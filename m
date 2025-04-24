Return-Path: <linux-fsdevel+bounces-47212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11336A9A737
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062811889F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C132101AE;
	Thu, 24 Apr 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho5zzF1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96C20B811
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485200; cv=none; b=FjVU+xDcBEaDhijIG+dF2oBDre4STt3IAu7K+74cZP5AplsmtA2B8Y4XHqMUi94pDh9EhakyQj84XRGHoHUjPeu07NJWwtMSPoDMQaIPCwjZnYYEIV1b8grZRr2HNM4fk5w1XMgeJrbOal0oPlAZUs2IF4ZFeL2c1Xl4S73Ylbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485200; c=relaxed/simple;
	bh=zhbIXimDWflbr7YEBKPKnNqUa325o+j3p8EoSaFbaLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtLqYIoDH1vZM/Jg5EPpQxvd2+R3buygWXhtWVGKP3ssMQMfYz96gD3Lp2ZRUrstUnRtu34zxuNnOKEEp9dYs6m8XS+kxWz/twuDqzD8OkZp9dUIOErJ9k82O2z7NC7+etVrsRQ2UncFlrVK87+nNN+D+FFo7SS5fdenAPxtfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho5zzF1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A96C4CEE3;
	Thu, 24 Apr 2025 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745485200;
	bh=zhbIXimDWflbr7YEBKPKnNqUa325o+j3p8EoSaFbaLY=;
	h=From:To:Cc:Subject:Date:From;
	b=ho5zzF1hF1Hy9TNpuhQpmPXqn5y6rgicgrsqn3DeACpCDxpINLTyh8m7dZCUAAg1y
	 3F9sn197zdOSu3Q2N6Z7aBgVQDkUfM0dNrLVm2bou0wuspQXnRGdB4hjQWZF0OkdqK
	 wrUssCYKcxWu9mNGSXk1HEkHBNbES4kX6RS8mFhDrN6TvF+UwrYiQPMc2bHrUBnWVZ
	 bDQkLEJteFe6L1dtMpErA3t+GUdI6nGpvFO7x3pVg0IFBmlMesTLa6t8P7MJsTOb3X
	 CmGGf1Efwa5ps7K9oiqbqEf8PpkVXpE7mayCFxqEDWmI9BjteL1W+yYmFtpblNg0aJ
	 i7BiIVlgGWOqg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] Revert "fs: move the bdex_statx call to vfs_getattr_nosec"
Date: Thu, 24 Apr 2025 10:59:44 +0200
Message-ID: <20250424-patient-abgeebbt-a0a7001f040b@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; i=brauner@kernel.org; h=from:subject:message-id; bh=zhbIXimDWflbr7YEBKPKnNqUa325o+j3p8EoSaFbaLY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw/u1i5a3z36h19fTdCTVpm2Iklf7HzUraHJqclnxkb 7nnpDcPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyx5qRoTUqba6SW7FW9hfD evfnZxRPlXw5tO3ov+U3TXe/VdriUsPwV/T4cfYLPQE2/yzjKjMmBsgaCryoU3tz7PPfl1oW7zi zeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This reverts commit 777d0961ff95b26d5887fdae69900374364976f3.

Now that we have fixed the original issue in devtmpfs we can revert this
commit because the bdev_statx() call in vfs_getattr_nosec() causes
issues with the lifetime logic of dm devices.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           |  3 ++-
 fs/stat.c              | 32 ++++++++++++++------------------
 include/linux/blkdev.h |  6 +++---
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 6a34179192c9..4844d1e27b6f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1272,7 +1272,8 @@ void sync_bdevs(bool wait)
 /*
  * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
+void bdev_statx(struct path *path, struct kstat *stat,
+		u32 request_mask)
 {
 	struct inode *backing_inode;
 	struct block_device *bdev;
diff --git a/fs/stat.c b/fs/stat.c
index 3d9222807214..f13308bfdc98 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -204,25 +204,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_DAX);
 
 	idmap = mnt_idmap(path->mnt);
-	if (inode->i_op->getattr) {
-		int ret;
-
-		ret = inode->i_op->getattr(idmap, path, stat, request_mask,
-				query_flags);
-		if (ret)
-			return ret;
-	} else {
-		generic_fillattr(idmap, request_mask, inode, stat);
-	}
-
-	/*
-	 * If this is a block device inode, override the filesystem attributes
-	 * with the block device specific parameters that need to be obtained
-	 * from the bdev backing inode.
-	 */
-	if (S_ISBLK(stat->mode))
-		bdev_statx(path, stat, request_mask);
+	if (inode->i_op->getattr)
+		return inode->i_op->getattr(idmap, path, stat,
+					    request_mask,
+					    query_flags);
 
+	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
@@ -308,6 +295,15 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	if (path_mounted(path))
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+
+	/*
+	 * If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters that need to be
+	 * obtained from the bdev backing inode.
+	 */
+	if (S_ISBLK(stat->mode))
+		bdev_statx(path, stat, request_mask);
+
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 678dc38442bf..e39c45bc0a97 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1685,7 +1685,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask);
+void bdev_statx(struct path *, struct kstat *, u32);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1703,8 +1703,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx(const struct path *path, struct kstat *stat,
-		u32 request_mask)
+static inline void bdev_statx(struct path *path, struct kstat *stat,
+				u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
-- 
2.47.2


