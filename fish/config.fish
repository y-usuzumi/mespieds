set -U fish_greeting ""
set -U fish_user_paths ~/.local/bin ~/.cargo/bin ~/.dotnet/tools ~/go/bin ~/.emacs.d/bin ~/.yarn/bin
test -f /home/kj/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/kj/.ghcup/bin $PATH
# set -Ux RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
# set -Ux RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
set -Ux EDITOR nvim

# Configure pinentry to use the correct TTY. See:
# https://wiki.archlinux.org/index.php/GnuPG#gpg-agent
set -Ux GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

set -g fish_prompt_pwd_dir_length 0

set -g theme_nerd_fonts yes
set -g theme_color_scheme dracula

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source ~/.aliases

# nvm
function nvm
    bass source /usr/share/nvm/init-nvm.sh --no-use ';' nvm $argv
end

function _wine32prefix
    env WINEPREFIX=$HOME/.wine32 $argv
end

function wine32
    _wine32prefix wine $argv
end

function winetricks32
    _wine32prefix winetricks $argv
end

function regedit32
    _wine32prefix regedit $argv
end

function winecfg32
    _wine32prefix winecfg
end

if test "$DESKTOP_SESSION" = "/usr/share/xsessions/i3"
    set -x QT_QPA_PLATFORMTHEME "qt5ct"
    set -x TERMINAL "konsole"
end

# https://github.com/y-usuzumi/j
function j
    eval (eval ".j $argv")
end

# keepassxc syncer
function synckpxc
    pushd ~/CONFIDENTIAL/keepass2
    ./kpxcm
    popd
end

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
