Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4742115718
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 02:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEGAul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 20:50:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38134 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEGAul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 20:50:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNoJZ-0001mR-Tw; Tue, 07 May 2019 00:50:38 +0000
Date:   Tue, 7 May 2019 01:50:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 1: ->free_inode() series
Message-ID: <20190507005037.GF23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Introduction of separate method for RCU-delayed
part of ->destroy_inode() (if any).  Pretty much as posted,
except that destroy_inode() stashes ->free_inode into the
victim (anon-unioned with ->i_fops) before scheduling
i_callback() and the last two patches (sockfs conversion
and folding struct socket_wq into struct socket) are
excluded  - that pair should go through netdev once
davem reopens his tree.

	Sat in -next in that form for a while.

The following changes since commit f51dcd0f621caac5380ce90fbbeafc32ce4517ae:

  apparmorfs: fix use-after-free on symlink traversal (2019-04-10 14:04:34 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.icache

for you to fetch changes up to f276ae0dd6d0b5bfbcb51178a63f06dc035f4cc4:

  orangefs: make use of ->free_inode() (2019-05-01 22:43:27 -0400)

----------------------------------------------------------------
Al Viro (59):
      Merge branch 'fixes' into work.icache
      new inode method: ->free_inode()
      spufs: switch to ->free_inode()
      erofs: switch to ->free_inode()
      9p: switch to ->free_inode()
      adfs: switch to ->free_inode()
      affs: switch to ->free_inode()
      befs: switch to ->free_inode()
      bfs: switch to ->free_inode()
      bdev: switch to ->free_inode()
      cifs: switch to ->free_inode()
      debugfs: switch to ->free_inode()
      efs: switch to ->free_inode()
      ext2: switch to ->free_inode()
      f2fs: switch to ->free_inode()
      fat: switch to ->free_inode()
      freevxfs: switch to ->free_inode()
      gfs2: switch to ->free_inode()
      hfs: switch to ->free_inode()
      hfsplus: switch to ->free_inode()
      hostfs: switch to ->free_inode()
      hpfs: switch to ->free_inode()
      isofs: switch to ->free_inode()
      jffs2: switch to ->free_inode()
      minix: switch to ->free_inode()
      nfs{,4}: switch to ->free_inode()
      nilfs2: switch to ->free_inode()
      dlmfs: switch to ->free_inode()
      ocfs2: switch to ->free_inode()
      openpromfs: switch to ->free_inode()
      procfs: switch to ->free_inode()
      qnx4: switch to ->free_inode()
      qnx6: switch to ->free_inode()
      reiserfs: convert to ->free_inode()
      romfs: convert to ->free_inode()
      squashfs: switch to ->free_inode()
      ubifs: switch to ->free_inode()
      udf: switch to ->free_inode()
      sysv: switch to ->free_inode()
      coda: switch to ->free_inode()
      ufs: switch to ->free_inode()
      mqueue: switch to ->free_inode()
      bpf: switch to ->free_inode()
      rpcpipe: switch to ->free_inode()
      apparmor: switch to ->free_inode()
      securityfs: switch to ->free_inode()
      ntfs: switch to ->free_inode()
      dax: make use of ->free_inode()
      afs: switch to use of ->free_inode()
      btrfs: use ->free_inode()
      ceph: use ->free_inode()
      ecryptfs: make use of ->free_inode()
      ext4: make use of ->free_inode()
      fuse: switch to ->free_inode()
      jfs: switch to ->free_inode()
      overlayfs: make use of ->free_inode()
      hugetlb: make use of ->free_inode()
      shmem: make use of ->free_inode()
      orangefs: make use of ->free_inode()

 Documentation/filesystems/Locking         |  2 ++
 Documentation/filesystems/porting         | 25 ++++++++++++++
 arch/powerpc/platforms/cell/spufs/inode.c | 10 ++----
 drivers/dax/super.c                       |  7 ++--
 drivers/staging/erofs/super.c             | 10 ++----
 fs/9p/v9fs_vfs.h                          |  2 +-
 fs/9p/vfs_inode.c                         | 10 ++----
 fs/9p/vfs_super.c                         |  4 +--
 fs/adfs/super.c                           | 10 ++----
 fs/affs/super.c                           | 10 ++----
 fs/afs/super.c                            |  9 +++--
 fs/befs/linuxvfs.c                        | 12 ++-----
 fs/bfs/inode.c                            | 10 ++----
 fs/block_dev.c                            | 14 ++------
 fs/btrfs/ctree.h                          |  1 +
 fs/btrfs/inode.c                          |  7 ++--
 fs/btrfs/super.c                          |  1 +
 fs/ceph/inode.c                           |  5 +--
 fs/ceph/super.c                           |  1 +
 fs/ceph/super.h                           |  1 +
 fs/cifs/cifsfs.c                          | 12 ++-----
 fs/coda/inode.c                           | 10 ++----
 fs/debugfs/inode.c                        | 10 ++----
 fs/ecryptfs/super.c                       |  5 ++-
 fs/efs/super.c                            | 10 ++----
 fs/ext2/super.c                           | 10 ++----
 fs/ext4/super.c                           |  5 ++-
 fs/f2fs/super.c                           | 10 ++----
 fs/fat/inode.c                            | 10 ++----
 fs/freevxfs/vxfs_super.c                  | 11 ++----
 fs/fuse/inode.c                           | 24 ++++++-------
 fs/gfs2/super.c                           | 12 ++-----
 fs/hfs/super.c                            | 10 ++----
 fs/hfsplus/super.c                        | 13 ++-----
 fs/hostfs/hostfs_kern.c                   | 10 ++----
 fs/hpfs/super.c                           | 10 ++----
 fs/hugetlbfs/inode.c                      |  5 ++-
 fs/inode.c                                | 56 +++++++++++++++++++------------
 fs/isofs/inode.c                          | 10 ++----
 fs/jffs2/super.c                          | 10 ++----
 fs/jfs/inode.c                            | 13 +++++++
 fs/jfs/super.c                            | 24 ++-----------
 fs/minix/inode.c                          | 10 ++----
 fs/nfs/inode.c                            | 10 ++----
 fs/nfs/internal.h                         |  2 +-
 fs/nfs/nfs4super.c                        |  2 +-
 fs/nfs/super.c                            |  2 +-
 fs/nilfs2/nilfs.h                         |  2 --
 fs/nilfs2/super.c                         | 11 ++----
 fs/ntfs/inode.c                           | 17 +++-------
 fs/ntfs/inode.h                           |  2 +-
 fs/ntfs/super.c                           |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c                    | 10 ++----
 fs/ocfs2/super.c                          | 12 ++-----
 fs/openpromfs/inode.c                     | 10 ++----
 fs/orangefs/super.c                       |  9 ++---
 fs/overlayfs/super.c                      | 13 ++++---
 fs/proc/inode.c                           | 10 ++----
 fs/qnx4/inode.c                           | 12 ++-----
 fs/qnx6/inode.c                           | 12 ++-----
 fs/reiserfs/super.c                       | 10 ++----
 fs/romfs/super.c                          | 11 ++----
 fs/squashfs/super.c                       | 11 ++----
 fs/sysv/inode.c                           | 10 ++----
 fs/ubifs/super.c                          | 10 ++----
 fs/udf/super.c                            | 10 ++----
 fs/ufs/super.c                            | 10 ++----
 include/linux/fs.h                        |  6 +++-
 ipc/mqueue.c                              | 10 ++----
 kernel/bpf/inode.c                        | 10 ++----
 mm/shmem.c                                |  5 ++-
 net/sunrpc/rpc_pipe.c                     | 11 ++----
 security/apparmor/apparmorfs.c            | 10 ++----
 security/inode.c                          | 10 ++----
 74 files changed, 230 insertions(+), 493 deletions(-)
