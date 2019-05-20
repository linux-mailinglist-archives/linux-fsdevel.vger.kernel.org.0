Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90B12380D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfETNdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 09:33:50 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:55912 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfETNdt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 09:33:49 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 275274E913;
        Mon, 20 May 2019 15:33:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id HWdlg_oBspfg; Mon, 20 May 2019 15:33:41 +0200 (CEST)
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
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RFC v8 00/10] namei: resolveat(2) path resolution restrictions
Date:   Mon, 20 May 2019 23:32:55 +1000
Message-Id: <20190520133305.11925-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch changelog:
  v8:
    * Default to O_CLOEXEC to match other new fd-creation syscalls
      (users can always disable O_CLOEXEC afterwards). [Christian]
    * Implement magic-link restrictions based on their mode. This is
      done through a series of masks and is designed to avoid breaking
      users -- most users don't have chained O_PATH fd re-opens.
    * Add O_EMPTYPATH which allows for fd re-opening without needing
      procfs. This would help some users of fd re-opening, and with the
      changes to magic-link permissions we now have the right semantics
      for such a flag.
    * Add selftests for resolveat(2), O_EMPTYPATH, and the magic-link
	  mode semantics.
  v7:
    * Remove execveat(2) support for these flags since it might
      result in some pretty hairy security issues with setuid binaries.
      There are other avenues we can go down to solve the issues with
      CVE-2019-5736. [Jann]
    * Reserve an additional bit in resolveat(2) for the eXecute access
      mode if we end up implementing it.
  v6:
    * Drop O_* flags API to the new LOOKUP_ path scoping bits and
      instead introduce resolveat(2) as an alternative method of
      obtaining an O_PATH. The justification for this is included in
      patch 6 (though switching back to O_* flags is trivial).
  v5:
    * In response to CVE-2019-5736 (one of the vectors showed that
      open(2)+fexec(3) cannot be used to scope binfmt_script's implicit
      open_exec()), AT_* flags have been re-added and are now piped
      through to binfmt_script (and other binfmt_* that use open_exec)
      but are only supported for execveat(2) for now.
  v4:
    * Remove AT_* flag reservations, as they require more discussion.
    * Switch to path_is_under() over __d_path() for breakout checking.
    * Make O_XDEV no longer block openat("/tmp", "/", O_XDEV) -- dirfd
      is now ignored for absolute paths to match other flags.
    * Improve the dirfd_path_init() refactor and move it to a separate
      commit.
    * Remove reference to Linux-capsicum.
    * Switch "proclink" name to magic-link.
  v3: [resend]
  v2:
    * Made ".." resolution with AT_THIS_ROOT and AT_BENEATH safe(r) with
      some semi-aggressive __d_path checking (see patch 3).
    * Disallowed "proclinks" with AT_THIS_ROOT and AT_BENEATH, in the
      hopes they can be re-enabled once safe.
    * Removed the selftests as they will be reimplemented as xfstests.
    * Removed stat(2) support, since you can already get it through
      O_PATH and fstatat(2).

The need for some sort of control over VFS's path resolution (to avoid
malicious paths resulting in inadvertent breakouts) has been a very
long-standing desire of many userspace applications. This patchset is a
revival of Al Viro's old AT_NO_JUMPS[1,2] patchset (which was a variant
of David Drysdale's O_BENEATH patchset[3] which was a spin-off of the
Capsicum project[4]) with a few additions and changes made based on the
previous discussion within [5] as well as others I felt were useful.

In line with the conclusions of the original discussion of AT_NO_JUMPS,
the flag has been split up into separate flags. However, instead of
being an openat(2) flag it is provided through a new syscall
resolveat(2) which provides an alternative way to get an O_PATH file
descriptor (the reasoning for doing this is included in patch 6). The
following new LOOKUP_ flags are added:

  * LOOKUP_XDEV blocks all mountpoint crossings (upwards, downwards, or
    through absolute links). Absolute pathnames alone in openat(2) do
    not trigger this.

  * LOOKUP_NO_MAGICLINKS blocks resolution through /proc/$pid/fd-style
    links. This is done by blocking the usage of nd_jump_link() during
	resolution in a filesystem. The term "magic-links" is used to match
	with the only reference to these links in Documentation/, but I'm
	happy to change the name.

	It should be noted that this is different to the scope of
	~LOOKUP_FOLLOW in that it applies to all path components. However,
	you can do resolveat(NO_FOLLOW|NO_MAGICLINKS) on a magic-link and it
	will *not* fail (assuming that no parent component was a
	magic-link), and you will have an fd for the magic-link.

  * LOOKUP_BENEATH disallows escapes to outside the starting dirfd's
    tree, using techniques such as ".." or absolute links. Absolute
    paths in openat(2) are also disallowed. Conceptually this flag is to
    ensure you "stay below" a certain point in the filesystem tree --
    but this requires some additional to protect against various races
    that would allow escape using ".." (see patch 4 for more detail).

    Currently LOOKUP_BENEATH implies LOOKUP_NO_MAGICLINKS, because it
    can trivially beam you around the filesystem (breaking the
    protection). In future, there might be similar safety checks as in
    patch 4, but that requires more discussion.

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
    CVEs that could have bene mitigated by having O_THISROOT (such as
    CVE-2017-1002101, CVE-2017-1002102, CVE-2018-15664, and
    CVE-2019-5736, just to name a few).

And further, several semantics of file descriptor "re-opening" are now
changed to prevent attacks like CVE-2019-5736 by restricting how
magic-links can be resolved (based on their mode). This required some
other changes to the semantics of the modes of O_PATH file descriptor's
associated /proc/self/fd magic-links. resolveat(2) has the ability to
further restrict re-opening of its own O_PATH fds, so that users can
make even better use of this feature.

Finally, O_EMPTYPATH was added so that users can do /proc/self/fd-style
re-opening without depending on procfs. The new restricted semantics for
magic-links are applied here too.

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

Aleksa Sarai (10):
  namei: obey trailing magic-link DAC permissions
  procfs: switch magic-link modes to be more sane
  open: O_EMPTYPATH: procfs-less file descriptor re-opening
  namei: split out nd->dfd handling to dirfd_path_init
  namei: O_BENEATH-style path resolution flags
  namei: LOOKUP_IN_ROOT: chroot-like path resolution
  namei: aggressively check for nd->root escape on ".." resolution
  namei: resolveat(2) syscall
  kselftest: save-and-restore errno to allow for %m formatting
  selftests: add resolveat(2) selftests

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   3 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/fcntl.c                                    |   2 +-
 fs/internal.h                                 |   1 +
 fs/namei.c                                    | 397 ++++++++++++++---
 fs/open.c                                     |  10 +-
 fs/proc/base.c                                |  20 +-
 fs/proc/fd.c                                  |  16 +-
 fs/proc/namespaces.c                          |   2 +-
 include/linux/fcntl.h                         |  10 +-
 include/linux/fs.h                            |   4 +
 include/linux/namei.h                         |   8 +
 include/linux/types.h                         |   2 +-
 include/uapi/asm-generic/fcntl.h              |   5 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/fcntl.h                    |  10 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/kselftest.h           |  15 +
 tools/testing/selftests/resolveat/.gitignore  |   1 +
 tools/testing/selftests/resolveat/Makefile    |   6 +
 tools/testing/selftests/resolveat/helpers.h   | 195 +++++++++
 .../selftests/resolveat/linkmode_test.c       | 306 ++++++++++++++
 .../selftests/resolveat/resolveat_test.c      | 400 ++++++++++++++++++
 39 files changed, 1350 insertions(+), 87 deletions(-)
 create mode 100644 tools/testing/selftests/resolveat/.gitignore
 create mode 100644 tools/testing/selftests/resolveat/Makefile
 create mode 100644 tools/testing/selftests/resolveat/helpers.h
 create mode 100644 tools/testing/selftests/resolveat/linkmode_test.c
 create mode 100644 tools/testing/selftests/resolveat/resolveat_test.c

-- 
2.21.0

