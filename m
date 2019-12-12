Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5411C166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 01:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLLAbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 19:31:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:42244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbfLLAbA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:31:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48BA1B246;
        Thu, 12 Dec 2019 00:30:58 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/8] iomap: Move lockdep_assert_held() to iomap_dio_rw() calls
Date:   Wed, 11 Dec 2019 18:30:39 -0600
Message-Id: <20191212003043.31093-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212003043.31093-1-rgoldwyn@suse.de>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Filesystems such as btrfs can perform direct I/O without holding the
inode->i_rwsem in some of the cases like writing within i_size.
So, remove the check for lockdep_assert_held() in iomap_dio_rw()
and move it to where iomap_dio_rw() is called so the checks are
in place.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/gfs2/file.c       | 4 ++++
 fs/iomap/direct-io.c | 2 --
 fs/xfs/xfs_file.c    | 9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 9d58295ccf7a..d0517a78640b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -771,6 +771,8 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto out_uninit;
 
+	lockdep_assert_held(&file_inode(file)->i_rwsem);
+
 	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
 			   is_sync_kiocb(iocb));
 
@@ -807,6 +809,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
+	lockdep_assert_held(&inode->i_rwsem);
+
 	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
 			   is_sync_kiocb(iocb));
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1a3bf3bd86fb..41c1e7c20a1f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -415,8 +415,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
-	lockdep_assert_held(&inode->i_rwsem);
-
 	if (!count)
 		return 0;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c93250108952..dfaccd4d6e6c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -176,7 +176,8 @@ xfs_file_dio_aio_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
 	size_t			count = iov_iter_count(to);
 	ssize_t			ret;
 
@@ -188,6 +189,9 @@ xfs_file_dio_aio_read(
 	file_accessed(iocb->ki_filp);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
+
+	lockdep_assert_held(&inode->i_rwsem);
+
 	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
 			is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
@@ -547,6 +551,9 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
+
+	lockdep_assert_held(&inode->i_rwsem);
+
 	/*
 	 * If unaligned, this is the only IO in-flight. Wait on it before we
 	 * release the iolock to prevent subsequent overlapping IO.
-- 
2.16.4

