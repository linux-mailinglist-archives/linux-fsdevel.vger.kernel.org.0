Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CB8747114
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGDMXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGDMXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396010DF;
        Tue,  4 Jul 2023 05:22:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D918B2286E;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77ujRf26Owowh0byfQ67xcMH5ve9C3R8kBJkiqUtyCg=;
        b=2VKahU1XOySHzEplDs1QltVNOFsTQ4dq8fvJlTW5NcA98HGvzmZtatnXM4OOLuzLkzGZcB
        uzw2YKZJoIVTmEJpZaCzkUoiAYvRhL8q67B7h52ZNqpk28gtTkFcsSTpiAMcamlusGN/Iq
        6Vv5l4hSCYlcfiNq++hkUnHBepLv+Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77ujRf26Owowh0byfQ67xcMH5ve9C3R8kBJkiqUtyCg=;
        b=q70p6SToqQrkW/lPtF4AOqrRzb+3ID6V/jBY2/qek+BzpILyPV7MhTw+FIlgjKrCnf1Azh
        s4eMuB2R65L75hDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C66DD13A26;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id txTTLwEPpGQkMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C449EA076B; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 09/32] zram: Convert to use blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:36 +0200
Message-Id: <20230704122224.16257-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=jack@suse.cz; h=from:subject; bh=d8xJMtYHgO5YwmVmWWlBkXahD1vV+6JInluTJ/YHmZY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7SYEWST8T4Q6p2EnRb+G285ejlkmGlLpc0nLak dRhgDHiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO0gAKCRCcnaoHP2RA2WtvB/ 485waibbQ1HI3VVHKcClB7d3e4aLU+VVjHUx3r/ZjrvHQmh1dgBvtBA2she0Tz5U3xntpGEpm3XAGj dfYLY5p7NA/F7vtQpBt/HGJ91sGtJN6upxh2pqd+zUrGRU9M9fUR2rzo+7oASL4cTfa9pHNLrTAbfp TmOIJxDLZ09cJYuSIM843A91+v5QmVcF1AbLckgQU0UVrEg75WX3NMDaF7TRI2l9FGtJGsfry8bX3V JADS6p+yB4HrAX7Liats6teTTRhzpjy36rn/P/w9kR18gFAbkDpkUp0tPXoKX7Q6Q0qpGu81FJ2YgF YcNC6qkumiwj63rFNl6uldgtL3pGhT
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert zram to use blkdev_get_handle_by_dev() and pass the handle
around.

CC: Minchan Kim <minchan@kernel.org>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/zram/zram_drv.c | 31 ++++++++++++++-----------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b16..987e4885956e 100644
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
+	blkdev_handle_put(zram->bdev_handle);
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
+	bdev_handle = blkdev_get_handle_by_dev(inode->i_rdev,
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
+		blkdev_handle_put(bdev_handle);
 
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

