Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8930098C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbhAVQwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbhAVQo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:44:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1264C061788;
        Fri, 22 Jan 2021 08:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YKFdeOXIHb2Hm3BSwwhiNNCeKmUpcIkSh04i0578nlc=; b=YA7IcDgDpefnHHTqXZlYOtyvfQ
        C0Nvsg5XmqxwKyZ7i4oTXUcCD/SLzK/nx1+kQD7khoISKk+BiVmiruDb815GkdqWEE+AS3ZEfXXWM
        VkmCyrBoM930i0frx1+iGLLEDj5Lk/u39rcnb0+aTZdq9VzcP63m01K56ORPNaBCycOWhffLcWcmZ
        yNphWTRkMeg09EKOIdqzpc29i/zNB+G0ToDlAhNDtDt93VH+IMqK6xzsAuI9HeDAzjLDi2VEik8Ks
        h5dqYmPKfHPCTevvAheuTfE/i4wVfUBZjWpBoUpuTIBwebSov6WORtBJhZwsAKHWi49rp6Qklyq/F
        +9wiTWCg==;
Received: from [2001:4bb8:188:1954:662b:86d3:ab5f:ac21] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zMg-000xki-88; Fri, 22 Jan 2021 16:32:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 09/11] iomap: pass a flags argument to iomap_dio_rw
Date:   Fri, 22 Jan 2021 17:20:41 +0100
Message-Id: <20210122162043.616755-10-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122162043.616755-1-hch@lst.de>
References: <20210122162043.616755-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a set of flags to iomap_dio_rw instead of the boolean
wait_for_completion argument.  The IOMAP_DIO_FORCE_WAIT flag
replaces the wait_for_completion, but only needs to be passed
when the iocb isn't synchronous to start with to simplify the
callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/file.c       |  7 +++----
 fs/ext4/file.c        |  5 ++---
 fs/gfs2/file.c        |  7 ++-----
 fs/iomap/direct-io.c  | 11 +++++------
 fs/xfs/xfs_file.c     |  7 +++----
 fs/zonefs/super.c     |  4 ++--
 include/linux/iomap.h | 10 ++++++++--
 7 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de667..ddfd2e2adedf58 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1949,8 +1949,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
-			     &btrfs_dio_ops, is_sync_kiocb(iocb));
+	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			     0);
 
 	btrfs_inode_unlock(inode, ilock_flags);
 
@@ -3622,8 +3622,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops, 0);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 349b27f0dda0cb..194f5d00fa3267 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,8 +74,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -550,7 +549,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ilock_shared)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io || extend);
+			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc93..89609c2997177a 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -797,9 +797,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
-
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
 	gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
@@ -833,8 +831,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 out:
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 604103ab76f9c5..947343730e2c93 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -420,13 +420,15 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+		unsigned int dio_flags)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
+	bool wait_for_completion =
+		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
 	unsigned int iomap_flags = IOMAP_DIRECT;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
@@ -434,9 +436,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!count)
 		return NULL;
 
-	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
-		return ERR_PTR(-EIO);
-
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
@@ -598,11 +597,11 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+		unsigned int dio_flags)
 {
 	struct iomap_dio *dio;
 
-	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
+	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags);
 	if (IS_ERR_OR_NULL(dio))
 		return PTR_ERR_OR_ZERO(dio);
 	return iomap_dio_complete(dio);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index db0d96ca4d92cb..c60ff7b5dd829e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -232,8 +232,7 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
-			is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -529,7 +528,7 @@ xfs_file_dio_write_aligned(
 	}
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, is_sync_kiocb(iocb));
+			   &xfs_dio_write_ops, 0);
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
@@ -587,7 +586,7 @@ xfs_file_dio_write_unaligned(
 
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, true);
+			   &xfs_dio_write_ops, IOMAP_DIO_FORCE_WAIT);
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074beb..0e7ab0bc00ae8e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -780,7 +780,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		ret = zonefs_file_dio_append(iocb, from);
 	else
 		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-				   &zonefs_write_dio_ops, sync);
+				   &zonefs_write_dio_ops, 0);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -917,7 +917,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		file_accessed(iocb->ki_filp);
 		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
-				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));
+				   &zonefs_read_dio_ops, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 		if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9cb4..be4e1e1e01e801 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,12 +256,18 @@ struct iomap_dio_ops {
 			struct bio *bio, loff_t file_offset);
 };
 
+/*
+ * Wait for the I/O to complete in iomap_dio_rw even if the kiocb is not
+ * synchronous.
+ */
+#define IOMAP_DIO_FORCE_WAIT	(1 << 0)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
+		unsigned int dio_flags);
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
+		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
-- 
2.29.2

