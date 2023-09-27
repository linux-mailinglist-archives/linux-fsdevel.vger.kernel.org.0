Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0667B007E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjI0JfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjI0JfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915013A;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16E7C21978;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eshjhmlBZZ+GzNwp19gJ7ErY7Ih5GTuxpMRTs+m+0bs=;
        b=EWUVkms5/pm2Ml5jbpZ8PZyg98OaUFitQ5RxXq1ZzVlbbqyw5iGue5zipZL3x5PApU/j0e
        tymimozpkYIQuMmfdcJpSGaAuf6Gf9UuON4kL7vWrvc7BBDm5g/I6jma3HFNGt6D+RmQd0
        ZUoHLT4s9UMO9sL9Qq2azAktAfRGbNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eshjhmlBZZ+GzNwp19gJ7ErY7Ih5GTuxpMRTs+m+0bs=;
        b=ss5MNlOjNXLJ919ETlSHkJp1Yp2PPEp1qO36o7DGcIzrpPjnGfs13irxuEi6+C86YwJI4q
        U06WAnopbiSPRQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0798F1338F;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xuXGATX3E2U8EwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C1C83A0803; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 29/29] block: Remove blkdev_get_by_*() functions
Date:   Wed, 27 Sep 2023 11:34:35 +0200
Message-Id: <20230927093442.25915-29-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6889; i=jack@suse.cz; h=from:subject; bh=Ikp0JFfjK5lGV1c4NJSrLP6HE8Yq3ISmm+jwTrr9Eoo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cqYojfqY37VS0S+9Qe7bf2w8dSlubsDBORTzMw MxR5zRiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3KgAKCRCcnaoHP2RA2W2tB/ 4z1O2luo6CRlZwZnpcQ0ddFqPaZCe5klRUn2PXAkyymVb8HUEM+xi8yJoCYMwWARqiDTnM1llQDKHU CdOG+EIfrNHX04Y49v8aZ5jBACh5tybF04FSgUiZQ2UiQ8nVWJIHdAGiEQxBbCBsyZlvRTLGJiSTFi MFgwewQC3Vj/yweM/O+VqauZx5qUtsuhkByD9GAWeA/MfHYHhEvtVFWvqk9TvTAMo3M3X8q6pYJW80 llF5MbSIV/H8Lu/NQ08gZbEJMpb5gIHOkFdWdE6q6u81T1ukE6Pp1Yx0tns2uh8BDT457TT+8gikXg uKPANWF0+KQKASVwUmL+6WrDrx2JoL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
them.

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 94 ++++++++++++++----------------------------
 include/linux/blkdev.h |  5 ---
 2 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4628dcb1da8a..ea80958027a8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -729,7 +729,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 }
 	
 /**
- * blkdev_get_by_dev - open a block device by device number
+ * bdev_open_by_dev - open a block device by device number
  * @dev: device number of block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -741,32 +741,40 @@ void blkdev_put_no_open(struct block_device *bdev)
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
@@ -815,7 +823,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
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
@@ -825,34 +836,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
@@ -866,29 +857,9 @@ EXPORT_SYMBOL(bdev_open_by_dev);
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
@@ -911,8 +882,9 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_open_by_path);
 
-void blkdev_put(struct block_device *bdev, void *holder)
+void bdev_release(struct bdev_handle *handle)
 {
+	struct block_device *bdev = handle->bdev;
 	struct gendisk *disk = bdev->bd_disk;
 
 	/*
@@ -926,8 +898,8 @@ void blkdev_put(struct block_device *bdev, void *holder)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (holder)
-		bd_end_claim(bdev, holder);
+	if (handle->holder)
+		bd_end_claim(bdev, handle->holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -944,12 +916,6 @@ void blkdev_put(struct block_device *bdev, void *holder)
 
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
index 51fa7ffdee83..98406eea5d1b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1485,10 +1485,6 @@ struct bdev_handle {
 	blk_mode_t mode;
 };
 
-struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
-struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
@@ -1496,7 +1492,6 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_put(struct block_device *bdev, void *holder);
 void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.35.3

