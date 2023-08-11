Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C830A778D0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjHKLGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjHKLFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2251994;
        Fri, 11 Aug 2023 04:05:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 894371F8AB;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSj8Idmwlk2KTpMfIy/2c/+NuKyGl9tAHG1uQWexaS0=;
        b=oZ7xpOQwaLqjESOM8cLKrlakfDk0e+PTlBOe2m1SGCSVMudowHg5RDiIFH88vw3/3izwcM
        cDPq1T2WxAgVqNVcHKE1zcKEquyVR6jSN6r2qFd+ddrSDU7D3A3Q7NtVJ+WfmZQh+4KJx0
        GcSYdt1e46vpT5wOOov8WEO9tBBc7Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSj8Idmwlk2KTpMfIy/2c/+NuKyGl9tAHG1uQWexaS0=;
        b=LdMEyAIe9QsaTak9s4wGxF4dtdKZdbik5ezIVis8QzgxiZgp9LLKex08HcXrQdezlKl5On
        5w9WVRPNK6vqcQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 772C713A95;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fk0UHeIV1mR+RQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 69F7BA0799; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 29/29] block: Remove blkdev_get_by_*() functions
Date:   Fri, 11 Aug 2023 13:05:00 +0200
Message-Id: <20230811110504.27514-29-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6794; i=jack@suse.cz; h=from:subject; bh=UsnntMIeaScmW7hx81NWZq2VByEWemzUKPAltQFMX2c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXceErAEFLAseDwPOeYTJ+kJipEdly6wTitnH0f gSlHNFOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV3AAKCRCcnaoHP2RA2ZxgB/ wI6vx4QVBHhISl3H1e6bJgqRFj55wW7/06pqBw6+U+y78jAMK5Qh1PagHtWGYN/q2qLlb0VyIbR13J sGwttxdnKAcbnBvyCta/RNKMEVN6olQpwQIXgWTMrI0S0w/1Y/FlOwzhVwwltppGX5Sor/IE4Ve75W DlTFUlHx9j65lkLB82x9wqYPR/q8mupWlFHtJTLchdUFmg9rz4sZAAdCVW933khl+oX4yBUuJ43/tx LuzI/2qzv/hA0YqAhYyIiBOrkDHoxJWzWx00s0sgfQukOu6qdvvFqYIhfDqNI12zv4dlNz77UNn/6K 6paXUyMKSI1/M5/jSiKPNvwgLBJDco
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
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
 block/bdev.c           | 94 ++++++++++++++----------------------------
 include/linux/blkdev.h |  5 ---
 2 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 32c0ef5abad4..0e631c9a75aa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -746,7 +746,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 }
 	
 /**
- * blkdev_get_by_dev - open a block device by device number
+ * bdev_open_by_dev - open a block device by device number
  * @dev: device number of block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -758,32 +758,40 @@ void blkdev_put_no_open(struct block_device *bdev)
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
@@ -832,7 +840,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
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
@@ -842,34 +853,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
@@ -883,29 +874,9 @@ EXPORT_SYMBOL(bdev_open_by_dev);
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
@@ -928,8 +899,9 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_open_by_path);
 
-void blkdev_put(struct block_device *bdev, void *holder)
+void bdev_release(struct bdev_handle *handle)
 {
+	struct block_device *bdev = handle->bdev;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
@@ -943,8 +915,8 @@ void blkdev_put(struct block_device *bdev, void *holder)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (holder)
-		bd_end_claim(bdev, holder);
+	if (handle->holder)
+		bd_end_claim(bdev, handle->holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -961,12 +933,6 @@ void blkdev_put(struct block_device *bdev, void *holder)
 
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
index 0e89ad5c645c..28f78bdecae7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1479,10 +1479,6 @@ struct bdev_handle {
 	blk_mode_t mode;
 };
 
-struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
@@ -1490,7 +1486,6 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_put(struct block_device *bdev, void *holder);
 void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.35.3

