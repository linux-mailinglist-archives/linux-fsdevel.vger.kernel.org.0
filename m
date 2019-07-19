Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC66E8F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfGSQnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 12:43:18 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:30202 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGSQnS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:43:18 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7E66EA1033;
        Fri, 19 Jul 2019 18:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id yblAqspWwNbi; Fri, 19 Jul 2019 18:43:06 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v10 0/9] namei: openat2(2) path resolution restrictions
Date:   Sat, 20 Jul 2019 02:42:16 +1000
Message-Id: <20190719164225.27083-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch is being developed here (with snapshots of each series
version being stashed in separate branches with names of the form
"resolveat/vX-summary"):
    <https://github.com/cyphar/linux/tree/resolveat/master>

Patch changelog:
 v10:
    * Ensure that unlazy_walk() will fail if we are in a scoped walk and
      the caller has zeroed nd->root (this happens in a few places, I'm
      not sure why because unlazy_walk() does legitimize_path()
      already). In this case we need to go through path_init() again to
      reset it (otherwise we will have a breakout because set_root()
      will breakout).
      * Also add a WARN_ON (and return -ENOTRECOVERABLE) if
        LOOKUP_IN_ROOT is set and we are in set_root() -- which should
        never happen and will cause a breakout.
    * Make changes suggested by Al Viro:
      * Remove nd->{opath_mask,acc_mode} by moving all of the magic-link
        permission logic be done after trailing_symlink() (with
        trailing_magiclink()) only within path_openat().
      * Introduce LOOKUP_MAGICLINK_JUMPED to be able to detect
        magic-link jumps done with nd_jump_link() (so we don't end up
        blocking other LOOKUP_JUMPED cases).
      * Simplify all of the path_init() changes to make the code far
        less confusing. dirfd_path_init() turns out to be un-necessary.
    * Make openat2(2) also -EINVAL on unknown how->flags.
      [Dmitry V. Levin]
    * Clean up bad definitions of O_EMPTYPATH on architectures where O_*
      flags are subtly different to <asm-generic/fcntl.h>.
    * Switch away from passing a struct to build_open_flags() and
      instead just copy the one field we need to temporarily modify
      (how->flags). Also fix a bug in OPENHOW_MODE. [Rasmus Villemoes]
    * Fix syscall linkages and switch to 437. [Arnd Bergmann]
    * Clean up text in commit messages and the cover-letter.
      [Rolf Eike Beer]
    * Fix openat2 selftest makefile. [Michael Ellerman]

The need for some sort of control over VFS's path resolution (to avoid
malicious paths resulting in inadvertent breakouts) has been a very
long-standing desire of many userspace applications. This patchset is a
revival of Al Viro's old AT_NO_JUMPS[1,2] patchset (which was a variant
of David Drysdale's O_BENEATH patchset[3] which was a spin-off of the
Capsicum project[4]) with a few additions and changes made based on the
previous discussion within [5] as well as others I felt were useful.

In line with the conclusions of the original discussion of AT_NO_JUMPS,
the flag has been split up into separate flags. However, instead of
being an openat(2) flag it is provided through a new syscall openat2(2)
which provides an alternative way to get an O_PATH file descriptor (the
reasoning for doing this is included in the patch description). The
following new LOOKUP_* flags are added:

  * LOOKUP_NO_XDEV blocks all mountpoint crossings (upwards, downwards,
    or through absolute links). Absolute pathnames alone in openat(2) do
    not trigger this.

  * LOOKUP_NO_MAGICLINKS blocks resolution through /proc/$pid/fd-style
    links. This is done by blocking the usage of nd_jump_link() during
    resolution in a filesystem. The term "magic-links" is used to match
    with the only reference to these links in Documentation/, but I'm
    happy to change the name.

    It should be noted that this is different to the scope of
    ~LOOKUP_FOLLOW in that it applies to all path components. However,
    you can do openat2(NO_FOLLOW|NO_MAGICLINKS) on a magic-link and it
    will *not* fail (assuming that no parent component was a
    magic-link), and you will have an fd for the magic-link.

  * LOOKUP_BENEATH disallows escapes to outside the starting dirfd's
    tree, using techniques such as ".." or absolute links. Absolute
    paths in openat(2) are also disallowed. Conceptually this flag is to
    ensure you "stay below" a certain point in the filesystem tree --
    but this requires some additional to protect against various races
    that would allow escape using "..".

    Currently LOOKUP_BENEATH implies LOOKUP_NO_MAGICLINKS, because it
    can trivially beam you around the filesystem (breaking the
    protection). In future, there might be similar safety checks done as
    in LOOKUP_IN_ROOT, but that requires more discussion.

In addition, two new flags are added that expand on the above ideas:

  * LOOKUP_NO_SYMLINKS does what it says on the tin. No symlink
    resolution is allowed at all, including magic-links. Just as with
    LOOKUP_NO_MAGICLINKS this can still be used with NOFOLLOW to open an
    fd for the symlink as long as no parent path had a symlink
    component.

  * LOOKUP_IN_ROOT is an extension of LOOKUP_BENEATH that, rather than
    blocking attempts to move past the root, forces all such movements
    to be scoped to the starting point. This provides chroot(2)-like
    protection but without the cost of a chroot(2) for each filesystem
    operation, as well as being safe against race attacks that chroot(2)
    is not.

    If a race is detected (as with LOOKUP_BENEATH) then an error is
    generated, and similar to LOOKUP_BENEATH it is not permitted to cross
    magic-links with LOOKUP_IN_ROOT.

    The primary need for this is from container runtimes, which
    currently need to do symlink scoping in userspace[6] when opening
    paths in a potentially malicious container. There is a long list of
    CVEs that could have bene mitigated by having RESOLVE_THIS_ROOT
    (such as CVE-2017-1002101, CVE-2017-1002102, CVE-2018-15664, and
    CVE-2019-5736, just to name a few).

And further, several semantics of file descriptor "re-opening" are now
changed to prevent attacks like CVE-2019-5736 by restricting how
magic-links can be resolved (based on their mode). This required some
other changes to the semantics of the modes of O_PATH file descriptor's
associated /proc/self/fd magic-links. openat2(2) has the ability to
further restrict re-opening of its own O_PATH fds, so that users can
make even better use of this feature.

Finally, O_EMPTYPATH was added so that users can do /proc/self/fd-style
re-opening without depending on procfs. The new restricted semantics for
magic-links are applied here too.

In order to make all of the above more usable, I'm working on
libpathrs[7] which is a C-friendly library for safe path resolution. It
features a userspace-emulated backend if the kernel doesn't support
openat2(2). Hopefully we can get userspace to switch to using it, and
thus get openat2(2) support for free once it's ready.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: David Drysdale <drysdale@google.com>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <containers@lists.linux-foundation.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-api@vger.kernel.org>

[1]: https://lwn.net/Articles/721443/
[2]: https://lore.kernel.org/patchwork/patch/784221/
[3]: https://lwn.net/Articles/619151/
[4]: https://lwn.net/Articles/603929/
[5]: https://lwn.net/Articles/723057/
[6]: https://github.com/cyphar/filepath-securejoin
[7]: https://github.com/openSUSE/libpathrs

Aleksa Sarai (9):
  namei: obey trailing magic-link DAC permissions
  procfs: switch magic-link modes to be more sane
  open: O_EMPTYPATH: procfs-less file descriptor re-opening
  namei: O_BENEATH-style path resolution flags
  namei: LOOKUP_IN_ROOT: chroot-like path resolution
  namei: aggressively check for nd->root escape on ".." resolution
  open: openat2(2) syscall
  kselftest: save-and-restore errno to allow for %m formatting
  selftests: add openat2(2) selftests

 Documentation/filesystems/path-lookup.rst     |  12 +-
 arch/alpha/include/uapi/asm/fcntl.h           |   1 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/include/uapi/asm/fcntl.h          |  39 +-
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/include/uapi/asm/fcntl.h           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/fcntl.c                                    |   2 +-
 fs/internal.h                                 |   1 +
 fs/namei.c                                    | 270 ++++++++++--
 fs/open.c                                     | 112 ++++-
 fs/proc/base.c                                |  20 +-
 fs/proc/fd.c                                  |  23 +-
 fs/proc/namespaces.c                          |   2 +-
 include/linux/fcntl.h                         |  17 +-
 include/linux/fs.h                            |   8 +-
 include/linux/namei.h                         |   9 +
 include/linux/syscalls.h                      |  17 +-
 include/uapi/asm-generic/fcntl.h              |   4 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/fcntl.h                    |  42 ++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/kselftest.h           |  15 +
 tools/testing/selftests/memfd/memfd_test.c    |   7 +-
 tools/testing/selftests/openat2/.gitignore    |   1 +
 tools/testing/selftests/openat2/Makefile      |   8 +
 tools/testing/selftests/openat2/helpers.c     | 162 +++++++
 tools/testing/selftests/openat2/helpers.h     | 114 +++++
 .../testing/selftests/openat2/linkmode_test.c | 326 ++++++++++++++
 .../selftests/openat2/rename_attack_test.c    | 124 ++++++
 .../testing/selftests/openat2/resolve_test.c  | 397 ++++++++++++++++++
 46 files changed, 1652 insertions(+), 107 deletions(-)
 create mode 100644 tools/testing/selftests/openat2/.gitignore
 create mode 100644 tools/testing/selftests/openat2/Makefile
 create mode 100644 tools/testing/selftests/openat2/helpers.c
 create mode 100644 tools/testing/selftests/openat2/helpers.h
 create mode 100644 tools/testing/selftests/openat2/linkmode_test.c
 create mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
 create mode 100644 tools/testing/selftests/openat2/resolve_test.c

-- 
2.22.0

