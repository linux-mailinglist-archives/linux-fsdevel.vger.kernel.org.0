Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB442C27CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfI3VDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:03:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16818 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732010AbfI3VDV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:21 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2F5DAA17EF;
        Mon, 30 Sep 2019 20:34:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id u0_dV-SPLAXA; Mon, 30 Sep 2019 20:34:31 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v13 0/9] namei: openat2(2) path resolution restrictions
Date:   Tue,  1 Oct 2019 04:33:07 +1000
Message-Id: <20190930183316.10190-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is being developed here:
  <https://github.com/cyphar/linux/tree/resolveat/master>

It depends on the copy_struct_from_user() helpers being developed here:
  <https://github.com/cyphar/linux/tree/copy_struct_from_user/master>
and posted here:
  <https://lore.kernel.org/lkml/20190930182810.6090-1-cyphar@cyphar.com/>

Patch changelog:
 v13:
  * Fix race with the magic-link mode semantics by recomputing the mode during
    ->get_link() and storing it with nd_jump_link(). A selftest was added for
    this attack scenario as well. [Jann Horn]
  * Fix gap in RESOLVE_NO_XDEV with magic-links -- now magic-link resolution is
    only permitted if the link doesn't jump vfsmounts.
  * Remove path_is_under() checks for ".." resolution (due to the possibility
    of O(m*n) lookup behaviour). Instead, return -EAGAIN if a racing rename or
    mount occurs. Userspace is then encouraged to retry or have another
    fallback (if after several tries, it still fails it's likely that there is
    an attack going on -- though failures will occur spuriously because
    &{rename,mount}_lock are both global). [Linus Torvalds]
  * Move copy_struct_from_user() to a separate series so it can be merged
    separately. [Christian Brauner]
  * Small test improvements (mainly making the TAP output more readable and
    adding a few new minor test cases). Now the openat2(2) self-tests have ~271
    overall test cases.
  * Expand on changes to path-lookup in the kernel docs.
  * Kernel-doc fixes. [Randy Dunlap]
 v12: <https://lore.kernel.org/lkml/20190904201933.10736-1-cyphar@cyphar.com/>
 v11: <https://lore.kernel.org/lkml/20190820033406.29796-1-cyphar@cyphar.com/>
      <https://lore.kernel.org/lkml/20190728010207.9781-1-cyphar@cyphar.com/>
 v10: <https://lore.kernel.org/lkml/20190719164225.27083-1-cyphar@cyphar.com/>
 v09: <https://lore.kernel.org/lkml/20190706145737.5299-1-cyphar@cyphar.com/>
 v08: <https://lore.kernel.org/lkml/20190520133305.11925-1-cyphar@cyphar.com/>
 v07: <https://lore.kernel.org/lkml/20190507164317.13562-1-cyphar@cyphar.com/>
 v06: <https://lore.kernel.org/lkml/20190506165439.9155-1-cyphar@cyphar.com/>
 v05: <https://lore.kernel.org/lkml/20190320143717.2523-1-cyphar@cyphar.com/>
 v04: <https://lore.kernel.org/lkml/20181112142654.341-1-cyphar@cyphar.com/>
 v03: <https://lore.kernel.org/lkml/20181009070230.12884-1-cyphar@cyphar.com/>
 v02: <https://lore.kernel.org/lkml/20181009065300.11053-1-cyphar@cyphar.com/>
 v01: <https://lore.kernel.org/lkml/20180929103453.12025-1-cyphar@cyphar.com/>

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
which provides several other improvements to the openat(2) interface (see the
patch description for more details). The following new LOOKUP_* flags are
added:

  * LOOKUP_NO_XDEV blocks all mountpoint crossings (upwards, downwards,
    or through absolute links). Absolute pathnames alone in openat(2) do not
    trigger this. Magic-link traversal which implies a vfsmount jump is also
    blocked (though magic-link jumps on the same vfsmount are permitted).

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
  namei: permit ".." resolution with LOOKUP_{IN_ROOT,BENEATH}
  open: openat2(2) syscall
  selftests: add openat2(2) selftests
  Documentation: update path-lookup to mention trailing magic-links

 Documentation/filesystems/path-lookup.rst     |  80 ++-
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
 fs/namei.c                                    | 286 +++++++--
 fs/open.c                                     | 100 ++-
 fs/proc/base.c                                |  69 +-
 fs/proc/fd.c                                  |  45 +-
 fs/proc/internal.h                            |   2 +-
 fs/proc/namespaces.c                          |   4 +-
 include/linux/fcntl.h                         |  21 +-
 include/linux/fs.h                            |   8 +-
 include/linux/namei.h                         |  15 +-
 include/linux/syscalls.h                      |  14 +-
 include/uapi/asm-generic/fcntl.h              |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/fcntl.h                    |  42 ++
 security/apparmor/apparmorfs.c                |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/memfd/memfd_test.c    |   7 +-
 tools/testing/selftests/openat2/.gitignore    |   1 +
 tools/testing/selftests/openat2/Makefile      |   8 +
 tools/testing/selftests/openat2/helpers.c     |  98 +++
 tools/testing/selftests/openat2/helpers.h     | 114 ++++
 .../testing/selftests/openat2/linkmode_test.c | 590 ++++++++++++++++++
 .../testing/selftests/openat2/openat2_test.c  | 152 +++++
 .../selftests/openat2/rename_attack_test.c    | 149 +++++
 .../testing/selftests/openat2/resolve_test.c  | 522 ++++++++++++++++
 48 files changed, 2258 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/openat2/.gitignore
 create mode 100644 tools/testing/selftests/openat2/Makefile
 create mode 100644 tools/testing/selftests/openat2/helpers.c
 create mode 100644 tools/testing/selftests/openat2/helpers.h
 create mode 100644 tools/testing/selftests/openat2/linkmode_test.c
 create mode 100644 tools/testing/selftests/openat2/openat2_test.c
 create mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
 create mode 100644 tools/testing/selftests/openat2/resolve_test.c

-- 
2.23.0

