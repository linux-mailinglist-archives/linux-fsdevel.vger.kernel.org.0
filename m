Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D87B0047
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjI0Jez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI0Jer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441013A;
        Wed, 27 Sep 2023 02:34:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 209222195D;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYrEpPlW04XPHY9SSKFn1gjS6jGaIlC5VTJcApbM8Qo=;
        b=U8J+ZjV6DpBgIpbQgI3eO1ar4SEFD/TB8v27msstPsdBXhPLcxYbGLhowAjHYTQ2RwLvWd
        VcgQGWr8QSAbgIrbpmxvpr5/9z5RXiW3lpu74KqW6B7BlFHWY3svarWFPzc9yzocwQXAbw
        JGrXwvxki3lDobR1AdIGIYUc/2W79U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYrEpPlW04XPHY9SSKFn1gjS6jGaIlC5VTJcApbM8Qo=;
        b=aMOgRVP/+DQLkxciu6unK2YASvl+uOZFID6u+T43QoB/Xwx5NRkeK3RfYzoD5k6AF25n5w
        jhsebuPcrPQA0GCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BDD513AC6;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q6XzAjT3E2UQEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1DEC1A07D8; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/29] zram: Convert to use bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:14 +0200
Message-Id: <20230927093442.25915-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069; i=jack@suse.cz; h=from:subject; bh=EdXIA2UybD5ESwRXdE8bPlWXf7+M0vz1Znp/57/M720=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cYRYs/0b4bY6/8Ruci1xNxAvv1kUzOGpumDtJH ZUs0wXmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3GAAKCRCcnaoHP2RA2VJAB/ 4pyDkPssoX/nVZOy4e4IwzVWtAxG3EuqQ/HUA7UwFVPJXHJAuiWUWoh+lA+dQqEkXxQMRA48G92CWw e1Xq9WJBlQ6yrqQ/PkMbc+R0BdrDuFj2CTHpKvJ/jpyiyM75veDDmCeYFb2i7E5gbGJcjivSxky2YC iYy+p/n2tV+kG+TduriAIjb0KKigpAWrLN35VRNiT1CLW+bH2KlOHnH9W2jVhVS2RFhBFNBixW9+mA 3BCrm8RN0AfP55lTnrxUR7gvQfoC7FoOUj3TlGAcrXDgJDYLihvvHP70r/VAn31ioaxiXrxeLVn74u xtkQgXqqOIhMYN1z/7oAi/E7zeaTBQ
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

Convert zram to use bdev_open_by_dev() and pass the handle around.

CC: Minchan Kim <minchan@kernel.org>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/zram/zram_drv.c | 31 ++++++++++++++-----------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..d77d3664ca08 100644
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

