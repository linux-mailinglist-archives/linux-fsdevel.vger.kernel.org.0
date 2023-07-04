Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523374712E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGDMYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGDMXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278110F2;
        Tue,  4 Jul 2023 05:22:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC14720571;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRmJxUv1oN3QLGerake2clgnQ3hmieehbAXpU4V1Yjg=;
        b=HaQ3zmA39GcMNQtUzEOh7ILzDdR9KWTRMvwOLDuVL2B6vJCW7+MjAgemRld3/qleCr9Lm+
        tKkFCLN8zDvs7kbihWZCl6aw0lQK83AXS0T0o3e5leK+LlXH68yYRP9+qaGfDKydIST+a3
        GL8etW0XdTon4OXD7GFXRPFO0lgJJgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRmJxUv1oN3QLGerake2clgnQ3hmieehbAXpU4V1Yjg=;
        b=kPTmgXMJGLWGEs5jF3ogwveLPzQonX8nJ+cUowG53MFfem0kE4eJwOdu3GJkRb5zvwhgUt
        N6RMg7EkIOhCKECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA9701346D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sUKjKQIPpGRhMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 50077A0766; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 31/32] block: Remove blkdev_get_by_*() functions
Date:   Tue,  4 Jul 2023 14:21:58 +0200
Message-Id: <20230704122224.16257-31-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6807; i=jack@suse.cz; h=from:subject; bh=e6MOlXcpkAW76V4TaIkrxWSCn/BRxLHQLWmoKKLaYDY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7lB5qdggq4Zw0dXPvAval8AU3uAfuCx7CUZNjR Hfqp6N6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO5QAKCRCcnaoHP2RA2d/qB/ 9dURcsInsubMoY+D/8dsoYKzxuSKgySTPxOg6pBbTGHlrf8WztXpJDDrOjeKOWAqjXjGMN+ZJztOLi +kBLod7qAWpSpQV7TSLq0Ngnamsgr8s3Ms8KtvaoDeYMUCGyBBxS1zXCUdGBpJgouPcxSRmh79htOZ VD+oI+GQc3d5fv6hPscBcCVjIh/xqbapf3q8NztGGxl0kixxmiTJqiJlRATTzvRsTZDOZinsZV+XXd bYVoWJDksKbElsdyD4trZtqTL5PoTcp/SGXkCqLJfPd0hs+zdXY+P3yC/OZ7pOZoSX3+Smgc8bhj1U LNokPsTNBHHTEjnpYvmsPcd9NjTqZb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 89 ++++++++++++++----------------------------
 include/linux/blkdev.h |  5 ---
 2 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c75de5cac2bc..0423495fe5ac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -746,7 +746,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 }
 	
 /**
- * blkdev_get_by_dev - open a block device by device number
+ * blkdev_get_handle_by_dev - open a block device by device number
  * @dev: device number of block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -758,32 +758,40 @@ void blkdev_put_no_open(struct block_device *bdev)
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
- * number.  Everything else should use blkdev_get_by_path().
+ * number.  Everything else should use blkdev_get_handle_by_path().
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
+struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
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
@@ -832,7 +840,9 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
 	if (unblock_events)
 		disk_unblock_events(disk);
-	return bdev;
+	handle->bdev = bdev;
+	handle->holder = holder;
+	return handle;
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -842,30 +852,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
+free_handle:
+	kfree(handle);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(blkdev_get_by_dev);
-
-struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops)
-{
-	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
-					     GFP_KERNEL);
-	struct block_device *bdev;
-
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
-	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
-	handle->bdev = bdev;
-	handle->holder = holder;
-	return handle;
-}
 EXPORT_SYMBOL(blkdev_get_handle_by_dev);
 
 /**
- * blkdev_get_by_path - open a block device by name
+ * blkdev_get_handle_by_path - open a block device by name
  * @path: path to the block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -879,29 +873,9 @@ EXPORT_SYMBOL(blkdev_get_handle_by_dev);
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
 struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops)
 {
@@ -924,8 +898,9 @@ struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_handle_by_path);
 
-void blkdev_put(struct block_device *bdev, void *holder)
+void blkdev_handle_put(struct bdev_handle *handle)
 {
+	struct block_device *bdev = handle->bdev;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
@@ -939,8 +914,8 @@ void blkdev_put(struct block_device *bdev, void *holder)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (holder)
-		bd_end_claim(bdev, holder);
+	if (handle->holder)
+		bd_end_claim(bdev, handle->holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -957,12 +932,6 @@ void blkdev_put(struct block_device *bdev, void *holder)
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
-}
-EXPORT_SYMBOL(blkdev_put);
-
-void blkdev_handle_put(struct bdev_handle *handle)
-{
-	blkdev_put(handle->bdev, handle->holder);
 	kfree(handle);
 }
 EXPORT_SYMBOL(blkdev_handle_put);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a910e9997ddd..134dfd1162e2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1476,10 +1476,6 @@ struct bdev_handle {
 	void *holder;
 };
 
-struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
 struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
@@ -1487,7 +1483,6 @@ struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_put(struct block_device *bdev, void *holder);
 void blkdev_handle_put(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.35.3

