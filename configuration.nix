# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Use the GRUB 2 boot loader.
    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
# Define on which hard drive you want to install Grub.
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.extraEntries = ''
        menuentry "Windows 7" {
            chainloader (hd0,1)+1
        }
    '';


# networking.hostName = "nixos"; # Define your hostname.
    networking = {
        hostId = "00000001";
        hostName = "eva01";
    };

# networking.wireless.enable = true;  # Enables wireless.

# Select internationalisation properties.
    i18n = {
        #consoleFont = "lat9w-16";
        consoleKeyMap = "dvorak";
        defaultLocale = "pt_BR.UTF-8";
    };

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
environment.systemPackages = with pkgs; [
  wget
  firefox
  sakura
  htop
];
#

# List services that you want to enable:

    programs.ssh.startAgent = true;

    nixpkgs.config.allowUnfree = true;
    hardware.opengl.driSupport32Bit = true;

    users.extraUsers.ew = {
        createHome = true;
        home = "/home/ew";
        description = "Emilio Wuerges";
        extraGroups = [ "wheel" "disk" "vboxusers" "cdrom" ];
        isNormalUser = true;
        useDefaultShell = true;
    };
    security.sudo.enable = true;

    services.xserver = {
        videoDrivers = [ "nvidia" ];
        enable = true;
        layout = "dvorak";
        windowManager.xmonad = {
            enable = true;
            extraPackages =
                haskellngPackages: [
                haskellngPackages.xmonad-contrib
                haskellngPackages.regex-posix
                haskellngPackages.taffybar
                ];
        };
        windowManager.default = "xmonad";
        desktopManager.xterm.enable = false;
        desktopManager.default = "none";
        displayManager = {
            slim = {
                enable = true;
                defaultUser = "ew";
            };
        };
    };

#services.printing.enable = true;
# Show the manual on virtual console 8 :
    services.nixosManual.showManual = true; 




}
