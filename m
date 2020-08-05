Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE423C45F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 06:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHEEVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 00:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgHEEVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:21:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB40C06174A;
        Tue,  4 Aug 2020 21:21:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Avw-009ao5-11; Wed, 05 Aug 2020 04:21:44 +0000
Date:   Wed, 5 Aug 2020 05:21:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [git pull] Christoph's init series
Message-ID: <20200805042144.GN1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Christoph's "getting rid of ksys_...() uses under KERNEL_DS" stuff.
One trivial conflict (drivers/md/md.c).

The following changes since commit f8456690ba8eb18ea4714e68554e242a04f65cff:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux into master (2020-07-15 19:00:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git hch.init_path

for you to fetch changes up to f073531070d24bbb82cb2658952d949f4851024b:

  init: add an init_dup helper (2020-08-04 21:02:38 -0400)

----------------------------------------------------------------
Christoph Hellwig (50):
      fs: add a vfs_fchown helper
      fs: add a vfs_fchmod helper
      init: remove the bstat helper
      md: move the early init autodetect code to drivers/md/
      md: replace the RAID_AUTORUN ioctl with a direct function call
      md: remove the autoscan partition re-read
      md: remove the kernel version of md_u.h
      md: simplify md_setup_drive
      md: rewrite md_setup_drive to avoid ioctls
      initrd: remove support for multiple floppies
      initrd: remove the BLKFLSBUF call in handle_initrd
      initrd: switch initrd loading to struct file based APIs
      initrd: mark init_linuxrc as __init
      initrd: mark initrd support as deprecated
      initramfs: remove the populate_initrd_image and clean_rootfs stubs
      initramfs: remove clean_rootfs
      initramfs: switch initramfs unpacking to struct file based APIs
      init: open code setting up stdin/stdout/stderr
      fs: remove ksys_getdents64
      fs: remove ksys_open
      fs: remove ksys_dup
      fs: remove ksys_fchmod
      fs: remove ksys_ioctl
      fs: refactor do_utimes
      fs: move timespec validation into utimes_common
      fs: expose utimes_common
      initramfs: use vfs_utimes in do_copy
      fs: refactor do_mount
      fs: refactor ksys_umount
      fs: push the getname from do_rmdir into the callers
      devtmpfs: refactor devtmpfsd()
      init: initialize ramdisk_execute_command at compile time
      init: mark console_on_rootfs as __init
      init: mark create_dev as __init
      init: add an init_mount helper
      init: add an init_umount helper
      init: add an init_unlink helper
      init: add an init_rmdir helper
      init: add an init_chdir helper
      init: add an init_chroot helper
      init: add an init_chown helper
      init: add an init_chmod helper
      init: add an init_eaccess helper
      init: add an init_link helper
      init: add an init_symlink helper
      init: add an init_mkdir helper
      init: add an init_mknod helper
      init: add an init_stat helper
      init: add an init_utimes helper
      init: add an init_dup helper

 arch/arm/kernel/atags_parse.c                     |   2 -
 arch/sh/kernel/setup.c                            |   2 -
 arch/sparc/kernel/setup_32.c                      |   2 -
 arch/sparc/kernel/setup_64.c                      |   2 -
 arch/x86/kernel/setup.c                           |   2 -
 drivers/base/devtmpfs.c                           |  59 +++--
 drivers/md/Makefile                               |   3 +
 init/do_mounts_md.c => drivers/md/md-autodetect.c | 247 ++++++++++----------
 drivers/md/md.c                                   |  38 +---
 drivers/md/md.h                                   |  12 +
 fs/Makefile                                       |   2 +-
 fs/file.c                                         |   7 +-
 fs/init.c                                         | 265 ++++++++++++++++++++++
 fs/internal.h                                     |  19 +-
 fs/ioctl.c                                        |   7 +-
 fs/namei.c                                        |  20 +-
 fs/namespace.c                                    | 107 +++++----
 fs/open.c                                         |  78 +++----
 fs/read_write.c                                   |   2 +-
 fs/readdir.c                                      |  11 +-
 fs/utimes.c                                       | 109 ++++-----
 include/linux/fs.h                                |   4 +
 include/linux/init_syscalls.h                     |  19 ++
 include/linux/initrd.h                            |   6 -
 include/linux/raid/detect.h                       |   8 +
 include/linux/raid/md_u.h                         |  13 --
 include/linux/syscalls.h                          |  83 -------
 init/Makefile                                     |   1 -
 init/do_mounts.c                                  |  82 ++-----
 init/do_mounts.h                                  |  28 +--
 init/do_mounts_initrd.c                           |  39 ++--
 init/do_mounts_rd.c                               | 101 ++++-----
 init/initramfs.c                                  | 148 +++++-------
 init/main.c                                       |  28 +--
 init/noinitramfs.c                                |   8 +-
 35 files changed, 796 insertions(+), 768 deletions(-)
 rename init/do_mounts_md.c => drivers/md/md-autodetect.c (59%)
 create mode 100644 fs/init.c
 create mode 100644 include/linux/init_syscalls.h
 delete mode 100644 include/linux/raid/md_u.h
