Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC88836BBC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDZWnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhDZWnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:43:03 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CCC061574;
        Mon, 26 Apr 2021 15:42:21 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb9vn-008WKe-OT; Mon, 26 Apr 2021 22:42:19 +0000
Date:   Mon, 26 Apr 2021 22:42:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [git pull] fileattr series from Miklos
Message-ID: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Splits the handling of  FS_IOC_[GS]ETFLAGS from ->ioctl() into
a separate method.  The interface is reasonably uniform across the
filesystems that support it and gives nice boilerplate removal.

	The branch is straight from Miklos' tree (it's #fileattr_v6 there),
sat merged into vfs.git #for-next for a while.  Not sure what's the normal
way to do pull requests in situations like that - do you prefer a reference
to my tree (as below) or to mszeredi/vfs.git?

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git miklos.fileattr

for you to fetch changes up to c4fe8aef2f07c8a41169bcb2c925f6a3a6818ca3:

  ovl: remove unneeded ioctls (2021-04-12 15:04:30 +0200)

----------------------------------------------------------------
Miklos Szeredi (23):
      vfs: add fileattr ops
      ecryptfs: stack fileattr ops
      ovl: stack fileattr ops
      btrfs: convert to fileattr
      ext2: convert to fileattr
      ext4: convert to fileattr
      f2fs: convert to fileattr
      gfs2: convert to fileattr
      orangefs: convert to fileattr
      xfs: convert to fileattr
      efivars: convert to fileattr
      hfsplus: convert to fileattr
      jfs: convert to fileattr
      nilfs2: convert to fileattr
      ocfs2: convert to fileattr
      reiserfs: convert to fileattr
      ubifs: convert to fileattr
      vfs: remove unused ioctl helpers
      fuse: move ioctl to separate source file
      fuse: unsigned open flags
      fuse: add internal open/release helpers
      fuse: convert to fileattr
      ovl: remove unneeded ioctls

 Documentation/filesystems/locking.rst |  11 +-
 Documentation/filesystems/vfs.rst     |  15 ++
 fs/btrfs/ctree.h                      |   3 +
 fs/btrfs/inode.c                      |   4 +
 fs/btrfs/ioctl.c                      | 226 +++-------------
 fs/ecryptfs/inode.c                   |  22 ++
 fs/efivarfs/file.c                    |  77 ------
 fs/efivarfs/inode.c                   |  44 +++
 fs/ext2/ext2.h                        |   7 +-
 fs/ext2/file.c                        |   2 +
 fs/ext2/ioctl.c                       |  88 +++---
 fs/ext2/namei.c                       |   2 +
 fs/ext4/ext4.h                        |  12 +-
 fs/ext4/file.c                        |   2 +
 fs/ext4/ioctl.c                       | 208 +++------------
 fs/ext4/namei.c                       |   2 +
 fs/f2fs/f2fs.h                        |   3 +
 fs/f2fs/file.c                        | 216 +++------------
 fs/f2fs/namei.c                       |   2 +
 fs/fuse/Makefile                      |   2 +-
 fs/fuse/dir.c                         |   6 +-
 fs/fuse/file.c                        | 435 +++---------------------------
 fs/fuse/fuse_i.h                      |  40 ++-
 fs/fuse/ioctl.c                       | 490 ++++++++++++++++++++++++++++++++++
 fs/gfs2/file.c                        |  63 ++---
 fs/gfs2/inode.c                       |   4 +
 fs/gfs2/inode.h                       |   3 +
 fs/hfsplus/dir.c                      |   2 +
 fs/hfsplus/hfsplus_fs.h               |  14 +-
 fs/hfsplus/inode.c                    |  54 ++++
 fs/hfsplus/ioctl.c                    |  84 ------
 fs/inode.c                            |  87 ------
 fs/ioctl.c                            | 325 ++++++++++++++++++++++
 fs/jfs/file.c                         |   6 +-
 fs/jfs/ioctl.c                        | 111 +++-----
 fs/jfs/jfs_dinode.h                   |   7 -
 fs/jfs/jfs_inode.h                    |   4 +-
 fs/jfs/namei.c                        |   6 +-
 fs/nilfs2/file.c                      |   2 +
 fs/nilfs2/ioctl.c                     |  61 ++---
 fs/nilfs2/namei.c                     |   2 +
 fs/nilfs2/nilfs.h                     |   3 +
 fs/ocfs2/file.c                       |   2 +
 fs/ocfs2/ioctl.c                      |  59 ++--
 fs/ocfs2/ioctl.h                      |   3 +
 fs/ocfs2/namei.c                      |   3 +
 fs/ocfs2/ocfs2_ioctl.h                |   8 -
 fs/orangefs/file.c                    |  79 ------
 fs/orangefs/inode.c                   |  50 ++++
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/file.c                   | 110 --------
 fs/overlayfs/inode.c                  |  77 ++++++
 fs/overlayfs/overlayfs.h              |   5 +-
 fs/overlayfs/readdir.c                |   4 -
 fs/reiserfs/file.c                    |   2 +
 fs/reiserfs/ioctl.c                   | 121 ++++-----
 fs/reiserfs/namei.c                   |   2 +
 fs/reiserfs/reiserfs.h                |   7 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +
 fs/ubifs/file.c                       |   2 +
 fs/ubifs/ioctl.c                      |  78 +++---
 fs/ubifs/ubifs.h                      |   3 +
 fs/xfs/libxfs/xfs_fs.h                |   4 -
 fs/xfs/xfs_ioctl.c                    | 258 +++++-------------
 fs/xfs/xfs_ioctl.h                    |  11 +
 fs/xfs/xfs_ioctl32.c                  |   2 -
 fs/xfs/xfs_ioctl32.h                  |   2 -
 fs/xfs/xfs_iops.c                     |   7 +
 include/linux/fileattr.h              |  59 ++++
 include/linux/fs.h                    |  16 +-
 71 files changed, 1727 insertions(+), 2010 deletions(-)
 create mode 100644 fs/fuse/ioctl.c
 create mode 100644 include/linux/fileattr.h
