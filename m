Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C033F3574E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355619AbhDGTXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355621AbhDGTXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:23:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F84C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 12:23:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so29494145ejc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JopOz03EEkTqIxcI1fz3+f5sIDcGohgXhrqvwOa7zzc=;
        b=fYgEat3S5TRjhsX5Sy5lurynyLrcfD1do1btfeGSlk6AA0LO+vKYEeGCZiY0Qan/u5
         Wt3cpybQYXh16FTDgHW7Z1CY/8xL4glHerxUVL9Wq9Y2Je+qpRiVLLdTFYRNdkiFqLOK
         L8nQBP5pL5yLawNZFoptGEaueJ4/gTbNXz7YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JopOz03EEkTqIxcI1fz3+f5sIDcGohgXhrqvwOa7zzc=;
        b=cOo84TfzMqiSQaBWS9T3qN7EgjcvzDWzghKieYkPiUT7Jb+TYsYZcg+ppZYryndDUt
         r7goNt+5eFR/94mSqZdmAcuXaCEA03XRIzfApslLDBburYrCIbOGRUCueNGmLQV0/U8/
         Z7SlPnyQsvxyT/4u3gNMv5yjywV93eh+LuN/sVeRHJp7sqGa5Ur+NgqHAZPyQ5Y5BJuN
         zToelXxOdBnfGw/9IdXCavbY3sqeNh1V8FNiEuMbEzyg9jBqHf1oGx3DZ5nwJka2Etm0
         u6S8aM948IjZQa5xyClKCe/9LTIhp8Gefqsob2KRBaCiQhd/4/3++5Ia8D0xje82r04J
         9kFA==
X-Gm-Message-State: AOAM5313a8qOhUDYl7c9SFpYlrDImdwiLsAPNQhp4mLv8fHtliqZ2FaP
        XWToVurt44TOxi4y0FibHKSo/rVFgfYT3aOP
X-Google-Smtp-Source: ABdhPJy4/lwlB88/hwiGMlYHEeQrMmjB5Z20uF1ATkPSuvZqEg5oBfNN5tljocnGD3JClC9IxLrtcA==
X-Received: by 2002:a17:906:3487:: with SMTP id g7mr5490963ejb.222.1617823383009;
        Wed, 07 Apr 2021 12:23:03 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id q25sm16243267edt.51.2021.04.07.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:23:02 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:22:52 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fileattr API
Message-ID: <YG4GjNEqC6Pmhmod@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git fileattr_v4

Convert all (with the exception of CIFS) filesystems from handling
FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR themselves to new i_ops and
common code moved into the VFS for these ioctls.  This removes boilerplate
from filesystems, and allows these operations to be properly stacked in
overlayfs.

Thanks,
Miklos

---
Changes since v3:

 - converted fuse
 - removed overlayfs ioctl code
 - moved d_is_special() check to callbacks where necessary
 - user copy cosmetics

Changes since v2:

 - renaming, most notably miscattr -> fileattr
 - use memset instead of structure initialization
 - drop gratuitous use of file_dentry()
 - kerneldoc, comments, spelling improvements
 - xfs: enable getting/setting FS_PROJINHERIT_FL and other tweaks
 - btrfs: patch logistics

Changes since v1:

 - rebased on 5.12-rc1 (mnt_userns churn)
 - fixed LSM hook on overlayfs

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

---
 Documentation/filesystems/locking.rst |   5 +
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
 71 files changed, 1724 insertions(+), 2007 deletions(-)
 create mode 100644 fs/fuse/ioctl.c
 create mode 100644 include/linux/fileattr.h
