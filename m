Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511172FD54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbjFNLrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbjFNLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE0A2;
        Wed, 14 Jun 2023 04:46:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ACB8C22519;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1yTeoSVLVyjZiMQAOJz+F9uUM4XPnKqxDI9EXnILlU=;
        b=WXZo/hrnY9KoS/cRpRil5negGKX0kEDL5MkDRBN8jhPpaeY6blrfAsNR22+KjBddDUCgbg
        mccP3bHnwBZSZ58fKwX7SUqG4kbb5MTMsOiD4ojMoyCMoNAZPHKS3DePvrgoEW31PDLNyx
        0t+00SrhBD/U6atjJL330n8j+dU5F/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1yTeoSVLVyjZiMQAOJz+F9uUM4XPnKqxDI9EXnILlU=;
        b=S9MMdSSeOkT+Jen8/vr/M/ALKN0CKtIzVXFfvlSD4rjStJrcyMBtcqprjSJnc82REEECoW
        HwvLYf3SH3i9vmDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 985F72C149;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 90C2251C4E13; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/7] brd: make logical sector size configurable
Date:   Wed, 14 Jun 2023 13:46:35 +0200
Message-Id: <20230614114637.89759-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
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

Add a module option 'rd_logical_blksize' to allow the user to change
the logical sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2ebb5532a204..a9f3c6591e75 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -45,9 +45,11 @@ struct brd_device {
 	u64			brd_nr_folios;
 	unsigned int		brd_sector_shift;
 	unsigned int		brd_sector_size;
+	unsigned int		brd_logical_sector_shift;
+	unsigned int		brd_logical_sector_size;
 };
 
-#define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - SECTOR_SHIFT)
+#define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - (b)->brd_logical_sector_shift)
 
 static pgoff_t brd_sector_index(struct brd_device *brd, sector_t sector)
 {
@@ -61,7 +63,7 @@ static int brd_sector_offset(struct brd_device *brd, sector_t sector)
 {
 	unsigned int rd_sector_mask = (1 << BRD_SECTOR_SHIFT(brd)) - 1;
 
-	return ((unsigned int)sector & rd_sector_mask) << SECTOR_SHIFT;
+	return ((unsigned int)sector & rd_sector_mask) << brd->brd_logical_sector_shift;
 }
 
 /*
@@ -152,7 +154,7 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 	if (ret)
 		return ret;
 	if (copy < n) {
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		ret = brd_insert_folio(brd, sector, gfp);
 	}
 	return ret;
@@ -180,7 +182,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 
 	if (copy < n) {
 		src += copy;
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		copy = n - copy;
 		folio = brd_lookup_folio(brd, sector);
 		BUG_ON(!folio);
@@ -214,7 +216,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 
 	if (copy < n) {
 		dst += copy;
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		copy = n - copy;
 		folio = brd_lookup_folio(brd, sector);
 		if (folio) {
@@ -273,8 +275,8 @@ static void brd_submit_bio(struct bio *bio)
 		int err;
 
 		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+		WARN_ON_ONCE((iter.offset & (brd->brd_logical_sector_size - 1)) ||
+				(len & (brd->brd_logical_sector_size - 1)));
 
 		err = brd_do_folio(brd, iter.folio, len, iter.offset,
 				   bio->bi_opf, sector);
@@ -286,7 +288,7 @@ static void brd_submit_bio(struct bio *bio)
 			bio_io_error(bio);
 			return;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += len >> brd->brd_logical_sector_shift;
 	}
 
 	bio_endio(bio);
@@ -316,6 +318,10 @@ static unsigned int rd_blksize = PAGE_SIZE;
 module_param(rd_blksize, uint, 0444);
 MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
 
+static unsigned int rd_logical_blksize = SECTOR_SIZE;
+module_param(rd_logical_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_logical_blksize, "Logical blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -373,6 +379,21 @@ static int brd_alloc(int i)
 	}
 	brd->brd_sector_size = rd_blksize;
 
+	brd->brd_logical_sector_shift = ilog2(rd_logical_blksize);
+	if ((1ULL << brd->brd_sector_shift) != rd_blksize) {
+		pr_err("rd_logical_blksize %d is not supported\n",
+		       rd_logical_blksize);
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	if (rd_logical_blksize > rd_blksize) {
+		pr_err("rd_logical_blksize %d larger than rd_blksize %d\n",
+		       rd_logical_blksize, rd_blksize);
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	brd->brd_logical_sector_size = rd_logical_blksize;
+
 	xa_init(&brd->brd_folios);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
@@ -393,6 +414,7 @@ static int brd_alloc(int i)
 	set_capacity(disk, rd_size * 2);
 
 	blk_queue_physical_block_size(disk->queue, rd_blksize);
+	blk_queue_logical_block_size(disk->queue, rd_logical_blksize);
 	blk_queue_max_hw_sectors(disk->queue, 1ULL << (MAX_ORDER + PAGE_SECTORS_SHIFT));
 
 	/* Tell the block layer that this is not a rotational device */
-- 
2.35.3

