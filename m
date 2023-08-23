Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBF785610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjHWKuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjHWKtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D53CFE;
        Wed, 23 Aug 2023 03:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57A0721EE9;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s9tef63uXp7Cu9e1OLj6+YD/eKKzIvpOoyUWBFd9hk=;
        b=uqHAPU+zpWOqO73QMtZ5dHj8XiWzcxZV/vDYMcPNxwf6SoR/9JK5eUHBuU6HmhVE1kLohn
        S/WGl/JuLQL2T5lcOBGRxEi+63LPqs19u0WOdQiOF8mDQdX/ZbzIQzKqfv262O5P6DqX66
        335kHKkL4nH4sh8ehaknY0axk7215Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s9tef63uXp7Cu9e1OLj6+YD/eKKzIvpOoyUWBFd9hk=;
        b=707OUHV+nBcJ1RUPwoCnNlAg5vc8ef12Sp0BtjXBGK1gWcWPk01OyJZ5odqMiz11adgm7+
        CoEOmvkXy9eDIYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48804139D0;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KSuFERrk5WQ6IAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39846A0782; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/29] zram: Convert to use bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:19 +0200
Message-Id: <20230823104857.11437-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4019; i=jack@suse.cz; h=from:subject; bh=JLZRaOcUzs1CeWC4QBrmAW+ZuHqJPQx8hA0R9uvVbMo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP1DGDykqGvuqR48NK/HIl362WeY6d8AwIy/5V/ cGhznbaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj9QAKCRCcnaoHP2RA2Rz9CA CNTbD1+EkPvWBjqwvBdBXt8UGXOWwEeg+Jr9u5uewFmJvVD8FxjAQLMAGtTMWzCpS+sKw+3sv8Oc3C jlmu5Zne0Pe6q3SGw/RAv+oa9p71A3TLkI/QZAGWFT0toEzeZwrU/rD5qSXNUjuKfdmyYu3YYMCZSk Lo946J4Je+c6qC9HrupQsYOy9so/fnDU3me7Kqx+jvhM9r7rXJLn92tdDRD446A6xoTpreHm6/wMck cw+EeOUAdhfhJeFl4dXYCQF8noHhQq4h8DKt/kV7TvBO6t+ie9lBWoH43hB9+d3WWgHwjnX4++xd3G vu3GWEgqLsITm+4g/a5xHVqEh/atOs
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

Convert zram to use bdev_open_by_dev() and pass the handle around.

CC: Minchan Kim <minchan@kernel.org>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/zram/zram_drv.c | 31 ++++++++++++++-----------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b16..dfbb102d9c79 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -414,17 +414,14 @@ static ssize_t writeback_limit_show(struct device *dev,
 
 static void reset_bdev(struct zram *zram)
 {
-	struct block_device *bdev;
-
 	if (!zram->backing_dev)
 		return;
 
-	bdev = zram->bdev;
-	blkdev_put(bdev, zram);
+	bdev_release(zram->bdev_handle);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->bdev = NULL;
+	zram->bdev_handle = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
@@ -470,7 +467,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	struct address_space *mapping;
 	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
-	struct block_device *bdev = NULL;
+	struct bdev_handle *bdev_handle = NULL;
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
@@ -507,11 +504,11 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev = blkdev_get_by_dev(inode->i_rdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				 zram, NULL);
-	if (IS_ERR(bdev)) {
-		err = PTR_ERR(bdev);
-		bdev = NULL;
+	bdev_handle = bdev_open_by_dev(inode->i_rdev,
+				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
+	if (IS_ERR(bdev_handle)) {
+		err = PTR_ERR(bdev_handle);
+		bdev_handle = NULL;
 		goto out;
 	}
 
@@ -525,7 +522,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	reset_bdev(zram);
 
-	zram->bdev = bdev;
+	zram->bdev_handle = bdev_handle;
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
@@ -538,8 +535,8 @@ static ssize_t backing_dev_store(struct device *dev,
 out:
 	kvfree(bitmap);
 
-	if (bdev)
-		blkdev_put(bdev, zram);
+	if (bdev_handle)
+		bdev_release(bdev_handle);
 
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
@@ -581,7 +578,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
+	bio = bio_alloc(zram->bdev_handle->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_chain(bio, parent);
@@ -697,7 +694,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
+		bio_init(&bio, zram->bdev_handle->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 		__bio_add_page(&bio, page, PAGE_SIZE, 0);
@@ -779,7 +776,7 @@ static void zram_sync_read(struct work_struct *work)
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
+	bio_init(&bio, zw->zram->bdev_handle->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
 	zw->error = submit_bio_wait(&bio);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ca7a15bd4845..d090753f97be 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif
-- 
2.35.3

