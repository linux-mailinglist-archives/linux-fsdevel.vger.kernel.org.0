Return-Path: <linux-fsdevel+bounces-1757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C07DE58B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80C32819B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347218E0C;
	Wed,  1 Nov 2023 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mJ7woFMj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i1N6gTVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0318033
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:43:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7584E4;
	Wed,  1 Nov 2023 10:43:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D075219EC;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOWlpyvyqUPB7G5rt7x1BI+QKqrBlv5E40CiHPTM+Kk=;
	b=mJ7woFMjXCtn39OPjthpw1UF9pYx1Zq56cDJO2SjF8xiH9xOmteSmSKgtANZVe3oIDzpx4
	w9uzI8yALv6HiqCosooSTWzhatJxVYwdmkDj1K7v0d5StxDS5kQoQaJ4V9xMzCSR3SYq2R
	Wb0uy111HWYt+HuZpjEckaWNBOl/QsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698860606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOWlpyvyqUPB7G5rt7x1BI+QKqrBlv5E40CiHPTM+Kk=;
	b=i1N6gTVgnGczSafQ+wX5fig7vT3ziax3S71S08nVTwUhwigtJEJd85iQRvQ90nDNqTZF2C
	2UNgaoBKIFhXgLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D30213A92;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7qHLEj6OQmUgYQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE4EDA0759; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>,
	<linux-xfs@vger.kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/7] block: Remove blkdev_get_by_*() functions
Date: Wed,  1 Nov 2023 18:43:07 +0100
Message-Id: <20231101174325.10596-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6836; i=jack@suse.cz; h=from:subject; bh=Cl6eHX1D7EnZV3pE1ncAUp3hwm40HBFOGX+U7sCElXc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQo4r89CA+wmIKuIlHwK7un/fPUGSEqIL0wavySgc VUGA+hqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKOKwAKCRCcnaoHP2RA2VnbB/ 9MGSRaVJUfXObNCBHtZLlpveGq32iGDwnfzHK+tjIp88gGD1khx86pGVoGWJ634DqbLVpTyA5iAiGp DC7YlHokAwof9gEF8uoT6t0QvsDtfmeYKpfcngsBuM8bQXNjlXpdAAgicqPWujieiVH/Nwmr/7PXOm 8tDsWGo/3GSsW/8FoJgsGSVp+MaFEt03qFy6FA53nzyOl/gsbwVzWHjJcQoMl0bYOCHWe3l26pBQ5g KSbS1yzMD7GmnLr9PnOE/m2rnA+piyz2a8v7eMcS+pG9XyhEXp4hMtN6Q3mSomTf5EA4XxVZAEHUOU YfZFcIF/qzrcC6yoZ2Gg160ry0ZZGf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
them.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 94 ++++++++++++++----------------------------
 include/linux/blkdev.h |  5 ---
 2 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4a502fb9b814..3f27939e02c6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -732,7 +732,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 }
 	
 /**
- * blkdev_get_by_dev - open a block device by device number
+ * bdev_open_by_dev - open a block device by device number
  * @dev: device number of block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -744,32 +744,40 @@ void blkdev_put_no_open(struct block_device *bdev)
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
- * number.  Everything else should use blkdev_get_by_path().
+ * number.  Everything else should use bdev_open_by_path().
  *
  * CONTEXT:
  * Might sleep.
  *
  * RETURNS:
- * Reference to the block_device on success, ERR_PTR(-errno) on failure.
+ * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
+ * failure.
  */
-struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops)
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				     const struct blk_holder_ops *hops)
 {
-	bool unblock_events = true;
+	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
+					     GFP_KERNEL);
 	struct block_device *bdev;
+	bool unblock_events = true;
 	struct gendisk *disk;
 	int ret;
 
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
 			MAJOR(dev), MINOR(dev),
 			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
 			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
 	if (ret)
-		return ERR_PTR(ret);
+		goto free_handle;
 
 	bdev = blkdev_get_no_open(dev);
-	if (!bdev)
-		return ERR_PTR(-ENXIO);
+	if (!bdev) {
+		ret = -ENXIO;
+		goto free_handle;
+	}
 	disk = bdev->bd_disk;
 
 	if (holder) {
@@ -818,7 +826,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	return bdev;
+	handle->bdev = bdev;
+	handle->holder = holder;
+	handle->mode = mode;
+	return handle;
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -828,34 +839,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
+free_handle:
+	kfree(handle);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(blkdev_get_by_dev);
-
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-				     const struct blk_holder_ops *hops)
-{
-	struct bdev_handle *handle = kmalloc(sizeof(*handle), GFP_KERNEL);
-	struct block_device *bdev;
-
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
-	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
-	if (IS_ERR(bdev)) {
-		kfree(handle);
-		return ERR_CAST(bdev);
-	}
-	handle->bdev = bdev;
-	handle->holder = holder;
-	if (holder)
-		mode |= BLK_OPEN_EXCL;
-	handle->mode = mode;
-	return handle;
-}
 EXPORT_SYMBOL(bdev_open_by_dev);
 
 /**
- * blkdev_get_by_path - open a block device by name
+ * bdev_open_by_path - open a block device by name
  * @path: path to the block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -869,29 +860,9 @@ EXPORT_SYMBOL(bdev_open_by_dev);
  * Might sleep.
  *
  * RETURNS:
- * Reference to the block_device on success, ERR_PTR(-errno) on failure.
+ * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
+ * failure.
  */
-struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops)
-{
-	struct block_device *bdev;
-	dev_t dev;
-	int error;
-
-	error = lookup_bdev(path, &dev);
-	if (error)
-		return ERR_PTR(error);
-
-	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
-	if (!IS_ERR(bdev) && (mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, holder);
-		return ERR_PTR(-EACCES);
-	}
-
-	return bdev;
-}
-EXPORT_SYMBOL(blkdev_get_by_path);
-
 struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops)
 {
@@ -914,8 +885,9 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_open_by_path);
 
-void blkdev_put(struct block_device *bdev, void *holder)
+void bdev_release(struct bdev_handle *handle)
 {
+	struct block_device *bdev = handle->bdev;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
@@ -929,8 +901,8 @@ void blkdev_put(struct block_device *bdev, void *holder)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (holder)
-		bd_end_claim(bdev, holder);
+	if (handle->holder)
+		bd_end_claim(bdev, handle->holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -947,12 +919,6 @@ void blkdev_put(struct block_device *bdev, void *holder)
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
-}
-EXPORT_SYMBOL(blkdev_put);
-
-void bdev_release(struct bdev_handle *handle)
-{
-	blkdev_put(handle->bdev, handle->holder);
 	kfree(handle);
 }
 EXPORT_SYMBOL(bdev_release);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index abf71cce785c..7afc10315dd5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1500,10 +1500,6 @@ struct bdev_handle {
 	blk_mode_t mode;
 };
 
-struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
@@ -1511,7 +1507,6 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_put(struct block_device *bdev, void *holder);
 void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.35.3


