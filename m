Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341E1EACDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgFASkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgFASkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:40:40 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD9C008630;
        Mon,  1 Jun 2020 11:40:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfpMS-001XRC-OT; Mon, 01 Jun 2020 18:40:36 +0000
Date:   Mon, 1 Jun 2020 19:40:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [git pull] vfs patches from Miklos
Message-ID: <20200601184036.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted patches from Miklos; an interesting part here is /proc/mounts
stuff...

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git from-miklos

for you to fetch changes up to c8ffd8bcdd28296a198f237cc595148a8d4adfbe:

  vfs: add faccessat2 syscall (2020-05-14 16:44:25 +0200)

----------------------------------------------------------------
Miklos Szeredi (13):
      vfs: allow unprivileged whiteout creation
      aio: fix async fsync creds
      proc/mounts: add cursor
      vfs: split out access_override_creds()
      utimensat: AT_EMPTY_PATH support
      uapi: deprecate STATX_ALL
      statx: don't clear STATX_ATIME on SB_RDONLY
      statx: add mount ID
      statx: add mount_root
      vfs: don't parse forbidden flags
      vfs: don't parse "posixacl" option
      vfs: don't parse "silent" option
      vfs: add faccessat2 syscall

 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/aio.c                                    |  8 +++
 fs/char_dev.c                               |  3 +
 fs/fs_context.c                             | 30 ----------
 fs/internal.h                               |  1 -
 fs/mount.h                                  | 12 +++-
 fs/namei.c                                  | 21 +------
 fs/namespace.c                              | 91 ++++++++++++++++++++++++-----
 fs/open.c                                   | 58 +++++++++++++-----
 fs/proc_namespace.c                         |  4 +-
 fs/stat.c                                   | 11 +++-
 fs/utimes.c                                 |  6 +-
 include/linux/device_cgroup.h               |  3 +
 include/linux/fs.h                          |  6 +-
 include/linux/mount.h                       |  4 +-
 include/linux/stat.h                        |  1 +
 include/linux/syscalls.h                    |  6 +-
 include/uapi/asm-generic/unistd.h           |  4 +-
 include/uapi/linux/fcntl.h                  | 10 ++++
 include/uapi/linux/stat.h                   | 18 +++++-
 samples/vfs/test-statx.c                    |  2 +-
 tools/include/uapi/linux/stat.h             | 11 +++-
 39 files changed, 234 insertions(+), 96 deletions(-)
