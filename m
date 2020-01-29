Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8114C7BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 09:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA2I6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 03:58:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56117 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgA2I6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:58:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so2287901pjz.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pLjeeSFVIA65fVNzYeh03dIJsej38JGIb4IT7g3DAY=;
        b=oNqYPLRAqNupF61/dxKjeKt/3FMONNbtOjjkfcyOi4g6eA2UTQEZs7agCCGGmYdc1M
         qeyXylP8hzenzBo+Z1hTcEbXc4J9TDFJDI5fyZxMyV/FmMZHbhxQU43faxx2I8Z81ZQy
         lIngAZhj08NsFXI3EmxxOMMp405NamgtVA0u993FUxqjaLy6tYJzK1AgccNkHTqSUN4N
         Q6JTwXUtsU+18uZcyH3GgfM5o/goI7GaOUQ4XWqO4+brxCW8aE1OlOv4oCxjCbiY1lGV
         5hjKZV93xd2WUZHP/8WTCAS3/8NxCcmxYds9N/aJ4n/U3FF3C2K/XzAYdkgnbT4cva6n
         46Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pLjeeSFVIA65fVNzYeh03dIJsej38JGIb4IT7g3DAY=;
        b=ioJw41n7sMf/Sb3KLplr7VRe4zcGVmCAm+RtRc+7Li9tqr1m0+fQQmSpuiKeqRSGsr
         KXF+olk1ORe8O8XrmJQ3trnP2MppNox2GTKLyurh9vmbkS2j+jdneGUPz+satYL2WDXR
         FtYAO1nJ8jMKMYomEA/Kaheje+Z7hjhWIYRiwp3WKF18Ki1419HI86ilayTUICgx5vA1
         u441+GTC/ltNu0zlP5RSgnBqFCCm75817Px9eir4sSGFDFhcDvIG4IeroI9kySjc11Bd
         H6TOP66AtWpIgIDMtepfRZ0Gsvc2ZXX9qmeob2pyr2yMXKkiyA6lQ/BK51p1ZCuTQSf6
         CV3Q==
X-Gm-Message-State: APjAAAWQiqf6Kt5C4tWKljD0k3cyqj0DLKVSUVptBpmpuZKtQZJpaqCy
        69BVKt+WSRTJshn2/LQ+wqxQT9yhENU=
X-Google-Smtp-Source: APXvYqx77wlHtLV7un/BDna10JbY4hLtjiB8HOZLggWTx/a4PrphO8N5k6bOAQEjiRoTssqhGJomgw==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr10166214pja.132.1580288327539;
        Wed, 29 Jan 2020 00:58:47 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:47 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH v4 0/4] fs: add flag to linkat() for replacing destination
Date:   Wed, 29 Jan 2020 00:58:30 -0800
Message-Id: <cover.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[Sorry if you got this twice, I botched the Cc's on the previous
 submission.]

Hello,

This series adds an AT_LINK_REPLACE flag to linkat() which allows
atomically replacing the destination if it exists. This is a respin of
an old series [1] that I was convinced to resend due to some recent
interest [2][3].

Patch 1 adds a flags argument to i_ops->link() in preparation. Patch 2
adds the VFS support. Patch 3 fixes an inode leak in btrfs_link(),
included in this series because it conflicts with patch 4. Patch 4 adds
support for AT_LINK_REPLACE to Btrfs.

I've also included a man-page patch (with an example program), an xfs_io
patch, and an fstest.

Some outstanding issues:

- The Btrfs implementation does a d_drop() on the replaced dentry. We
  probably want a d_replace() helper for filesystems to use.
- Should AT_LINK_REPLACE be limited to O_TMPFILE? In my opinion, the
  answer is no. After all, `ln -f` is not that exotic.
- Should AT_LINK_REPLACE guarantee data integrity? Again, I think the
  answer is no. That's more suited to something like Amir's AT_ATOMIC
  proposal [4].

Changes since v3:

- Rebased on v5.5.
- Added patches 1 and 3.
- Incorporated Al's feedback on various error cases in patch 2.
- Renamed the flag to AT_LINK_REPLACE.

Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/
2: https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
3: https://lore.kernel.org/linux-fsdevel/364531.1579265357@warthog.procyon.org.uk/
4: https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/

Omar Sandoval (4):
  fs: add flags argument to i_op->link()
  fs: add AT_LINK_REPLACE flag for linkat() which replaces the target
  Btrfs: fix inode reference count leak in btrfs_link() error path
  Btrfs: add support for linkat() AT_REPLACE

 fs/9p/vfs_inode.c          |   5 +-
 fs/9p/vfs_inode_dotl.c     |   5 +-
 fs/affs/affs.h             |   2 +-
 fs/affs/namei.c            |   6 +-
 fs/afs/dir.c               |   7 +-
 fs/bad_inode.c             |   2 +-
 fs/bfs/dir.c               |   7 +-
 fs/btrfs/inode.c           |  70 ++++++++++++++--
 fs/ceph/dir.c              |   5 +-
 fs/cifs/cifsfs.h           |   2 +-
 fs/cifs/link.c             |   5 +-
 fs/coda/dir.c              |   5 +-
 fs/ecryptfs/inode.c        |   7 +-
 fs/ext2/namei.c            |   5 +-
 fs/ext4/namei.c            |   7 +-
 fs/f2fs/namei.c            |   5 +-
 fs/fuse/dir.c              |   5 +-
 fs/gfs2/inode.c            |   5 +-
 fs/hfsplus/dir.c           |   5 +-
 fs/hostfs/hostfs_kern.c    |   5 +-
 fs/jffs2/dir.c             |   8 +-
 fs/jfs/namei.c             |   7 +-
 fs/libfs.c                 |   6 +-
 fs/minix/namei.c           |   5 +-
 fs/namei.c                 | 166 +++++++++++++++++++++++++++++--------
 fs/nfs/dir.c               |   6 +-
 fs/nfs/internal.h          |   2 +-
 fs/nfsd/vfs.c              |   2 +-
 fs/nilfs2/namei.c          |   5 +-
 fs/ocfs2/namei.c           |   6 +-
 fs/overlayfs/dir.c         |   5 +-
 fs/overlayfs/overlayfs.h   |   2 +-
 fs/reiserfs/namei.c        |   5 +-
 fs/sysv/namei.c            |   7 +-
 fs/ubifs/dir.c             |   5 +-
 fs/udf/namei.c             |   5 +-
 fs/ufs/namei.c             |   5 +-
 fs/xfs/xfs_iops.c          |   6 +-
 include/linux/fs.h         |   6 +-
 include/uapi/linux/fcntl.h |   1 +
 mm/shmem.c                 |   6 +-
 41 files changed, 341 insertions(+), 90 deletions(-)

-- 
2.25.0

