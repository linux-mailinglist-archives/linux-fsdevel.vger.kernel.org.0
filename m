Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8652A30D9FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBCMnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhBCMnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eaHavqdLzNN4HIXolByqIWIQT4TrE3vDVyTXfXQ1h/o=;
        b=TCMfTBfo/hGwUqGnaUxz1rbbL5x8yaZ2k4DE/XPXQO7z5rfvvDoTp+I6kkIjOZnv/GwPE/
        uHZ75BKdtsuYLlKX4J4ohZSDc1vlUVyQbe3FL9Caz5S6JWxiU1JKo9KxDaQPNP6NQh/wLs
        coIaGIvKHpVk6VQzh3TLVksKRVJapeo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-rFy-n5SnMTmAqDoAmM1lcA-1; Wed, 03 Feb 2021 07:41:34 -0500
X-MC-Unique: rFy-n5SnMTmAqDoAmM1lcA-1
Received: by mail-ej1-f69.google.com with SMTP id le12so11928090ejb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaHavqdLzNN4HIXolByqIWIQT4TrE3vDVyTXfXQ1h/o=;
        b=O6Pvzsx0RJPszEvwdZlY2hnjNWZruTxxoglL5VPzKFMIEKjA+ApTum6tZDzlkhOixp
         nlM5A0TkMJATPhCPKSuKKNyFBpAhXVT2tph0qf0K1jvQRrRwpsKcaWtu7JkqguAXalqi
         BWU2KTrDttwlHifJV4+F8Unwe5NWzMTy3vjBxxP0wNdGucZKtUdYvWMSPNH++7jGvzaU
         K0/m7WRBDsT4dpP1tyFEeec/o4sWYt8T+meus9+246aSAiRTfhMSBy6EkY4789bqgUBN
         osTSlQTrtAsuV+3OC9UyEWM3yw92NCMdG17eBfRzc3am6vJI1BIlGlrtEelh7DKwnQ/X
         OaMQ==
X-Gm-Message-State: AOAM531MRDU+hP6QLWgbqEBoN5ih8L50P1Y9Z2XIQShMPfeWO7vveEQO
        5YxuK0vsILItv/iUXoBH8GwUNGurPzCY1Coo0Os+0zalcQLdLRYXDiLILCmohDEsVcbSSZS5OBt
        ZvTqGcDNdQ8Z+xAKyk8bMfSJAssjdyXJbC0bzp1S1TV144Y89aoSJLB8J7Cm5iTGBfZnX4gQHhr
        fNww==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr733200ejr.481.1612356092442;
        Wed, 03 Feb 2021 04:41:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRXVedxTX98WUSw33tq7PLwSR8WbTWYfniFQx78sLmuewEdVI4H9cmtLKSUszoYJVf8TMoRw==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr733179ejr.481.1612356092264;
        Wed, 03 Feb 2021 04:41:32 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:31 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Date:   Wed,  3 Feb 2021 13:40:54 +0100
Message-Id: <20210203124112.1182614-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds the infrastructure and conversion of filesystems to the
new API.

Two filesystems are not converted: FUSE and CIFS, as they behave
differently from local filesystems (use the file pointer, don't perform
permission checks).  It's likely that these two can be supported with minor
changes to the API, but this requires more thought.

Quick xfstests on ext4, xfs and overlayfs didn't show any regressions.
Other filesystems were only compile tested.

Git tree is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#miscattr

---
Miklos Szeredi (18):
  vfs: add miscattr ops
  ecryptfs: stack miscattr ops
  ovl: stack miscattr
  btrfs: convert to miscattr
  ext2: convert to miscattr
  ext4: convert to miscattr
  f2fs: convert to miscattr
  gfs2: convert to miscattr
  orangefs: convert to miscattr
  xfs: convert to miscattr
  efivars: convert to miscattr
  hfsplus: convert to miscattr
  jfs: convert to miscattr
  nilfs2: convert to miscattr
  ocfs2: convert to miscattr
  reiserfs: convert to miscattr
  ubifs: convert to miscattr
  vfs: remove unused ioctl helpers

 Documentation/filesystems/locking.rst |   4 +
 Documentation/filesystems/vfs.rst     |  14 ++
 fs/btrfs/ctree.h                      |   2 +
 fs/btrfs/inode.c                      |   4 +
 fs/btrfs/ioctl.c                      | 248 ++++---------------
 fs/ecryptfs/inode.c                   |  21 ++
 fs/efivarfs/file.c                    |  77 ------
 fs/efivarfs/inode.c                   |  43 ++++
 fs/ext2/ext2.h                        |   6 +-
 fs/ext2/file.c                        |   2 +
 fs/ext2/ioctl.c                       |  85 +++----
 fs/ext2/namei.c                       |   2 +
 fs/ext4/ext4.h                        |  11 +-
 fs/ext4/file.c                        |   2 +
 fs/ext4/ioctl.c                       | 209 ++++------------
 fs/ext4/namei.c                       |   2 +
 fs/f2fs/f2fs.h                        |   2 +
 fs/f2fs/file.c                        | 212 +++--------------
 fs/f2fs/namei.c                       |   2 +
 fs/gfs2/file.c                        |  56 +----
 fs/gfs2/inode.c                       |   4 +
 fs/gfs2/inode.h                       |   2 +
 fs/hfsplus/dir.c                      |   2 +
 fs/hfsplus/hfsplus_fs.h               |  13 +-
 fs/hfsplus/inode.c                    |  53 +++++
 fs/hfsplus/ioctl.c                    |  84 -------
 fs/inode.c                            |  87 -------
 fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
 fs/jfs/file.c                         |   6 +-
 fs/jfs/ioctl.c                        | 104 +++-----
 fs/jfs/jfs_dinode.h                   |   7 -
 fs/jfs/jfs_inode.h                    |   3 +-
 fs/jfs/namei.c                        |   6 +-
 fs/nilfs2/file.c                      |   2 +
 fs/nilfs2/ioctl.c                     |  60 ++---
 fs/nilfs2/namei.c                     |   2 +
 fs/nilfs2/nilfs.h                     |   2 +
 fs/ocfs2/file.c                       |   2 +
 fs/ocfs2/ioctl.c                      |  58 ++---
 fs/ocfs2/ioctl.h                      |   2 +
 fs/ocfs2/namei.c                      |   3 +
 fs/ocfs2/ocfs2_ioctl.h                |   8 -
 fs/orangefs/file.c                    |  79 -------
 fs/orangefs/inode.c                   |  49 ++++
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/inode.c                  |  43 ++++
 fs/overlayfs/overlayfs.h              |   2 +
 fs/reiserfs/file.c                    |   2 +
 fs/reiserfs/ioctl.c                   | 120 +++++-----
 fs/reiserfs/namei.c                   |   2 +
 fs/reiserfs/reiserfs.h                |   6 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +
 fs/ubifs/file.c                       |   2 +
 fs/ubifs/ioctl.c                      |  73 +++---
 fs/ubifs/ubifs.h                      |   2 +
 fs/xfs/libxfs/xfs_fs.h                |   4 -
 fs/xfs/xfs_ioctl.c                    | 294 +++++++----------------
 fs/xfs/xfs_ioctl.h                    |  10 +
 fs/xfs/xfs_ioctl32.c                  |   2 -
 fs/xfs/xfs_ioctl32.h                  |   2 -
 fs/xfs/xfs_iops.c                     |   7 +
 include/linux/fs.h                    |  15 +-
 include/linux/miscattr.h              |  52 ++++
 64 files changed, 1097 insertions(+), 1518 deletions(-)
 create mode 100644 include/linux/miscattr.h

-- 
2.26.2

