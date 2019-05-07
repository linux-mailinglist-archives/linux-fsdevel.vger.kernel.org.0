Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4116C98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEGUtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 16:49:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52134 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEGUtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:49:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO71d-0000Nx-Nu; Tue, 07 May 2019 20:49:21 +0000
Date:   Tue, 7 May 2019 21:49:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git next bits of mount ABI stuff (syscalls, this time)
Message-ID: <20190507204921.GL23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Syscalls themselves, finally.  That's not all there is to that
stuff, but switching individual filesystems to new methods is
fortunately independent from everything else, so e.g. NFS series can
go through NFS tree, etc.  As those conversions get done, we'll be
finally able to get rid of a bunch of duplication in fs/super.c introduced
in the beginning of the entire thing.  I expect that to be finished
in the next window...

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-syscalls

for you to fetch changes up to f1b5618e013af28b3c78daf424436a79674423c0:

  vfs: Add a sample program for the new mount API (2019-03-20 18:49:06 -0400)

----------------------------------------------------------------
Al Viro (1):
      vfs: syscall: Add open_tree(2) to reference or clone a mount

David Howells (9):
      vfs: syscall: Add move_mount(2) to move mounts around
      teach move_mount(2) to work with OPEN_TREE_CLONE
      Make anon_inodes unconditional
      vfs: syscall: Add fsopen() to prepare for superblock creation
      vfs: Implement logging through fs_context
      vfs: syscall: Add fsconfig() for configuring and managing a context
      vfs: syscall: Add fsmount() to create a mount for a superblock
      vfs: syscall: Add fspick() to select a superblock for reconfiguration
      vfs: Add a sample program for the new mount API

 arch/arm/kvm/Kconfig                   |   1 -
 arch/arm64/kvm/Kconfig                 |   1 -
 arch/mips/kvm/Kconfig                  |   1 -
 arch/powerpc/kvm/Kconfig               |   1 -
 arch/s390/kvm/Kconfig                  |   1 -
 arch/x86/Kconfig                       |   1 -
 arch/x86/entry/syscalls/syscall_32.tbl |   7 +-
 arch/x86/entry/syscalls/syscall_64.tbl |   6 +
 arch/x86/kvm/Kconfig                   |   1 -
 drivers/base/Kconfig                   |   1 -
 drivers/char/tpm/Kconfig               |   1 -
 drivers/dma-buf/Kconfig                |   1 -
 drivers/gpio/Kconfig                   |   1 -
 drivers/iio/Kconfig                    |   1 -
 drivers/infiniband/Kconfig             |   1 -
 drivers/vfio/Kconfig                   |   1 -
 fs/Makefile                            |   4 +-
 fs/file_table.c                        |   9 +-
 fs/fs_context.c                        | 160 ++++++++++-
 fs/fsopen.c                            | 477 +++++++++++++++++++++++++++++++++
 fs/internal.h                          |   4 +
 fs/namespace.c                         | 477 +++++++++++++++++++++++++++++----
 fs/notify/fanotify/Kconfig             |   1 -
 fs/notify/inotify/Kconfig              |   1 -
 include/linux/fs.h                     |   7 +-
 include/linux/fs_context.h             |  38 ++-
 include/linux/lsm_hooks.h              |   6 +
 include/linux/module.h                 |   6 +
 include/linux/security.h               |   7 +
 include/linux/syscalls.h               |   9 +
 include/uapi/linux/fcntl.h             |   2 +
 include/uapi/linux/mount.h             |  62 +++++
 init/Kconfig                           |  10 -
 samples/Kconfig                        |   9 +-
 samples/Makefile                       |   2 +-
 samples/{statx => vfs}/Makefile        |   5 +-
 samples/vfs/test-fsmount.c             | 133 +++++++++
 samples/{statx => vfs}/test-statx.c    |  11 +-
 security/security.c                    |   5 +
 39 files changed, 1354 insertions(+), 118 deletions(-)
 create mode 100644 fs/fsopen.c
 rename samples/{statx => vfs}/Makefile (55%)
 create mode 100644 samples/vfs/test-fsmount.c
 rename samples/{statx => vfs}/test-statx.c (96%)
