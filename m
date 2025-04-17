Return-Path: <linux-fsdevel+bounces-46608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060EA9143A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8AE5A25DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104542063E2;
	Thu, 17 Apr 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL6iKCer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7D2040B6;
	Thu, 17 Apr 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872051; cv=none; b=bFYxgz0nR09J1Xr8HL5PnQvN18x+kfP5ci49EX7vYpeOvcNPeyjxhxO625S9OjIz0s0hBmfotWLDUMNuPfLepNvNya4CYFG/n8ofN97K+BaJ8XVH2fkhi7UcWHrczyrEBhnVrFp9cuTHk5SjBZ9Ji7Gfyhpk+ZIRSYLJTE/IMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872051; c=relaxed/simple;
	bh=IgmzinbyKF//ZH4UbMf8mksIaWgEpjVpKkTrpewXda4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/Ts//Ms73RPmUH6wkb9/GCUxqfoAQjQKuJNJVU5GxtoBUMGYQvQeyBjI9LGtCXSWFg5Fy95u98Sy8ZjUeiOybKf0uCqm8abH4NwyJbEtTogPOyyX9Z6jYLgEAKPPjqlTKb5E0xWbz62jAu4OSqcU2+S+4LF6XN8Vc6MM3blk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WL6iKCer; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WXKmRZKaxP42+vmcOaIfOuScIQ5hDSfNmZXHrVNWjyw=; b=WL6iKCerNS7EkVaCAx2tPZaiAZ
	332om/FuZOtTxIp3F8OV2axnvo4hLYZOBHaK4QeUCmerNnUh5eqjr4GcOhfq9l955wdCwGHKtGJXr
	gzctITR9kTWuVxxbGlArKryHodsH+DtRjj7Yk4ohjeGA+E1NsFfUcXmnSzho9UiAop9s6GJnMA09K
	JdrVZABWbgfKWFhU+L3dppSYST8zojsbWbKFgrI4An7UMnViKP3iWoWgtduSiadmVmkyfBcwu0B7s
	BTQbJKCSi8nNUomurVs8lZSi08c3FC10azUq5p4Ktd0ji+D5endnjVoxO6ziExun+KUINZS2Rkb5K
	mNlUGFBQ==;
Received: from 089144221046.atnat0030.highway.webapn.at ([89.144.221.46] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5IvW-0000000Bw3u-2pfQ;
	Thu, 17 Apr 2025 06:40:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: axboe@kernel.dk,
	djwong@kernel.org,
	ebiggers@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Date: Thu, 17 Apr 2025 08:40:42 +0200
Message-ID: <20250417064042.712140-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently bdex_statx is only called from the very high-level
vfs_statx_path function, and thus bypassing it for in-kernel calls
to vfs_getattr or vfs_getattr_nosec.

This breaks querying the block ѕize of the underlying device in the
loop driver and also is a pitfall for any other new kernel caller.

Move the call into the lowest level helper to ensure all callers get
the right results.

Fixes: 2d985f8c6b91 ("vfs: support STATX_DIOALIGN on block devices")
Fixes: f4774e92aab8 ("loop: take the file system minimum dio alignment into account")
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c           |  3 +--
 fs/stat.c              | 32 ++++++++++++++++++--------------
 include/linux/blkdev.h |  6 +++---
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..6a34179192c9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1272,8 +1272,7 @@ void sync_bdevs(bool wait)
 /*
  * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx(struct path *path, struct kstat *stat,
-		u32 request_mask)
+void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 {
 	struct inode *backing_inode;
 	struct block_device *bdev;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..3d9222807214 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -204,12 +204,25 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_DAX);
 
 	idmap = mnt_idmap(path->mnt);
-	if (inode->i_op->getattr)
-		return inode->i_op->getattr(idmap, path, stat,
-					    request_mask,
-					    query_flags);
+	if (inode->i_op->getattr) {
+		int ret;
+
+		ret = inode->i_op->getattr(idmap, path, stat, request_mask,
+				query_flags);
+		if (ret)
+			return ret;
+	} else {
+		generic_fillattr(idmap, request_mask, inode, stat);
+	}
+
+	/*
+	 * If this is a block device inode, override the filesystem attributes
+	 * with the block device specific parameters that need to be obtained
+	 * from the bdev backing inode.
+	 */
+	if (S_ISBLK(stat->mode))
+		bdev_statx(path, stat, request_mask);
 
-	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
@@ -295,15 +308,6 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	if (path_mounted(path))
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
-
-	/*
-	 * If this is a block device inode, override the filesystem
-	 * attributes with the block device specific parameters that need to be
-	 * obtained from the bdev backing inode.
-	 */
-	if (S_ISBLK(stat->mode))
-		bdev_statx(path, stat, request_mask);
-
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39c45bc0a97..678dc38442bf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1685,7 +1685,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx(struct path *, struct kstat *, u32);
+void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1703,8 +1703,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx(struct path *path, struct kstat *stat,
-				u32 request_mask)
+static inline void bdev_statx(const struct path *path, struct kstat *stat,
+		u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
-- 
2.47.2


