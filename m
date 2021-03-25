Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63032349A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhCYTiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhCYTiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R0YdgWghM/7oFfDojn7dnaGdxOcNGzucqNhWxq5GgOE=;
        b=cwZXcnm+7PgpBpI2hnCNxaqdJZPErOb49Rzm2K5iy4nq3YGDLIYsGdkKddogqJkm7f5+4N
        LFy85qzWJIEV7EI7EujivfK+evWfL1+EK1PKRJX1BZGTwsb0sR2zhX6doqVocvznOTGeW2
        /fqcVCMNiftJSzmGZ/tS5zTwMaT88kw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-Jpsrz4BTN2adWYWFFqW6Hg-1; Thu, 25 Mar 2021 15:37:58 -0400
X-MC-Unique: Jpsrz4BTN2adWYWFFqW6Hg-1
Received: by mail-ej1-f69.google.com with SMTP id au15so3087149ejc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0YdgWghM/7oFfDojn7dnaGdxOcNGzucqNhWxq5GgOE=;
        b=Fq1DAjXTc9G2hcieJKRvmk7fXCnYjfY6SxK8cB+VV7oAqjJfmTVTT8kSMZneTaeuQq
         HKzWWQ13P5i0zq+NEbBPSmnbZiXkBs/tKNAWneqn5Mkvqs0aXf42fLHyTWSTcDvqDC6a
         e5cwRVJoYyYiUwaceT6uw/5A0sBcpCEdC9jdjNvWyz8r1g3qx4IusOydBQu2hqu00CFn
         Iu7CeC47LrpH0FJ0Sfk250KBExlFERHqHQ2d26dqx/tDGIdUbS7LbPNglFhnkg69WjTk
         rphDGw8KGRIU2pz6+lgC0/2+CZnT04isXpmfhNu/5aOqX3vj2hcaedYrSCnz+cfgQJlk
         sIAA==
X-Gm-Message-State: AOAM532ICx2zF9ejyxZxuYAH9bGXKB0hHvQkXc4v4Gg/Pe1jUzYVkLRL
        FAGaXh/ODkTwr94UO6f6HaQAEw24ixoJ2a22Wfa1BEnzdAVVJM82DD6TplV2Fk8UYSM/jn+Geaj
        QEyuoFr0j1HjDkjIh8ANJiNLGfVLOsi5A0IjbWR7gg7aoQaiszo7+tYjTo3SeazdGMKgJ2hLIWO
        0Cjw==
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr10825793edt.12.1616701077475;
        Thu, 25 Mar 2021 12:37:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfiBqIJxW4tk2YqrIabrdJZE2h+2ySrI+NqxkrkdTqleJ0RErUoBPoi3Kw+v5HW+44elJXVw==
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr10825766edt.12.1616701077285;
        Thu, 25 Mar 2021 12:37:57 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:37:56 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/18] new kAPI for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Date:   Thu, 25 Mar 2021 20:37:37 +0100
Message-Id: <20210325193755.294925-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the feedback, I think all comments are addressed.  Seems
"fileattr" has won a small majority of bikesheders' preference, so
switching over to that.

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

Git tree is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#fileattr_v3


Miklos Szeredi (18):
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

 Documentation/filesystems/locking.rst |   5 +
 Documentation/filesystems/vfs.rst     |  15 ++
 fs/btrfs/ctree.h                      |   3 +
 fs/btrfs/inode.c                      |   4 +
 fs/btrfs/ioctl.c                      | 226 +++---------------
 fs/ecryptfs/inode.c                   |  22 ++
 fs/efivarfs/file.c                    |  77 ------
 fs/efivarfs/inode.c                   |  44 ++++
 fs/ext2/ext2.h                        |   7 +-
 fs/ext2/file.c                        |   2 +
 fs/ext2/ioctl.c                       |  88 +++----
 fs/ext2/namei.c                       |   2 +
 fs/ext4/ext4.h                        |  12 +-
 fs/ext4/file.c                        |   2 +
 fs/ext4/ioctl.c                       | 208 ++++------------
 fs/ext4/namei.c                       |   2 +
 fs/f2fs/f2fs.h                        |   3 +
 fs/f2fs/file.c                        | 216 +++--------------
 fs/f2fs/namei.c                       |   2 +
 fs/gfs2/file.c                        |  57 ++---
 fs/gfs2/inode.c                       |   4 +
 fs/gfs2/inode.h                       |   3 +
 fs/hfsplus/dir.c                      |   2 +
 fs/hfsplus/hfsplus_fs.h               |  14 +-
 fs/hfsplus/inode.c                    |  54 +++++
 fs/hfsplus/ioctl.c                    |  84 -------
 fs/inode.c                            |  87 -------
 fs/ioctl.c                            | 331 ++++++++++++++++++++++++++
 fs/jfs/file.c                         |   6 +-
 fs/jfs/ioctl.c                        | 105 +++-----
 fs/jfs/jfs_dinode.h                   |   7 -
 fs/jfs/jfs_inode.h                    |   4 +-
 fs/jfs/namei.c                        |   6 +-
 fs/nilfs2/file.c                      |   2 +
 fs/nilfs2/ioctl.c                     |  61 ++---
 fs/nilfs2/namei.c                     |   2 +
 fs/nilfs2/nilfs.h                     |   3 +
 fs/ocfs2/file.c                       |   2 +
 fs/ocfs2/ioctl.c                      |  59 ++---
 fs/ocfs2/ioctl.h                      |   3 +
 fs/ocfs2/namei.c                      |   3 +
 fs/ocfs2/ocfs2_ioctl.h                |   8 -
 fs/orangefs/file.c                    |  79 ------
 fs/orangefs/inode.c                   |  50 ++++
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/inode.c                  |  77 ++++++
 fs/overlayfs/overlayfs.h              |   3 +
 fs/reiserfs/file.c                    |   2 +
 fs/reiserfs/ioctl.c                   | 121 +++++-----
 fs/reiserfs/namei.c                   |   2 +
 fs/reiserfs/reiserfs.h                |   7 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +
 fs/ubifs/file.c                       |   2 +
 fs/ubifs/ioctl.c                      |  74 +++---
 fs/ubifs/ubifs.h                      |   3 +
 fs/xfs/libxfs/xfs_fs.h                |   4 -
 fs/xfs/xfs_ioctl.c                    | 252 +++++---------------
 fs/xfs/xfs_ioctl.h                    |  11 +
 fs/xfs/xfs_ioctl32.c                  |   2 -
 fs/xfs/xfs_ioctl32.h                  |   2 -
 fs/xfs/xfs_iops.c                     |   7 +
 include/linux/fileattr.h              |  59 +++++
 include/linux/fs.h                    |  16 +-
 64 files changed, 1136 insertions(+), 1490 deletions(-)
 create mode 100644 include/linux/fileattr.h

-- 
2.30.2

