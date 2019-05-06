Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6D151FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEFQzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:55:33 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:57688 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfEFQzc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:55:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id DE0B5A1167;
        Mon,  6 May 2019 18:55:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id IVJ6tn_By9w9; Mon,  6 May 2019 18:55:06 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 0/6] namei: resolveat(2) path resolution restriction API
Date:   Tue,  7 May 2019 02:54:33 +1000
Message-Id: <20190506165439.9155-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch changelog:
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
    * Switch "proclink" name to "magic link".
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
following new LOOKUP_ (and corresponding uapi) flags are added:

  * LOOKUP_XDEV blocks all mountpoint crossings (upwards, downwards, or
    through absolute links). Absolute pathnames alone in openat(2) do
    not trigger this.

  * LOOKUP_NO_MAGICLINKS blocks resolution through /proc/$pid/fd-style
    links. This is done by blocking the usage of nd_jump_link() during
    resolution in a filesystem. The term "magic links" is used to match
    with the only reference to these links in Documentation/, but I'm
    happy to change the name.

    It should be noted that this is different to the scope of
    ~LOOKUP_FOLLOW in that it applies to all path components. However,
    you can do resolveat(NOFOLLOW|NO_MAGICLINKS) on a "magic link" and
    it will *not* fail (assuming that no parent component was a "magic
    link"), and you will have an fd for the "magic link".

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

In addition, two new flags were added that expand on the above ideas:

  * LOOKUP_NO_SYMLINKS does what it says on the tin. No symlink
    resolution is allowed at all, including "magic links". Just as with
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
    "magic links" with LOOKUP_IN_ROOT.

    The primary need for this is from container runtimes, which
    currently need to do symlink scoping in userspace[6] when opening
    paths in a potentially malicious container. There is a long list of
    CVEs that could have bene mitigated by having O_THISROOT (such as
    CVE-2017-1002101, CVE-2017-1002102, CVE-2018-15664, and
    CVE-2019-5736, just to name a few).

In addition, a mirror set of AT_* flags have been added (though
currently these are only supported for execveat(2) -- and not for any
other syscall). The need for these is explained in patch 5 (it's
motivated by CVE-2019-5736).

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

Aleksa Sarai (6):
  namei: split out nd->dfd handling to dirfd_path_init
  namei: O_BENEATH-style path resolution flags
  namei: LOOKUP_IN_ROOT: chroot-like path resolution
  namei: aggressively check for nd->root escape on ".." resolution
  binfmt_*: scope path resolution of interpreters
  namei: resolveat(2) syscall

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/binfmt_elf.c                             |   2 +-
 fs/binfmt_elf_fdpic.c                       |   2 +-
 fs/binfmt_em86.c                            |   4 +-
 fs/binfmt_misc.c                            |   2 +-
 fs/binfmt_script.c                          |   2 +-
 fs/exec.c                                   |  26 +-
 fs/namei.c                                  | 251 +++++++++++++++-----
 include/linux/binfmts.h                     |   1 +
 include/linux/fs.h                          |   9 +-
 include/linux/namei.h                       |   8 +
 include/uapi/linux/fcntl.h                  |  18 ++
 27 files changed, 270 insertions(+), 71 deletions(-)

-- 
2.21.0

