Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227D7A47F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbjIRLGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjIRLF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D358C3;
        Mon, 18 Sep 2023 04:05:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8D3271FE01;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVPahaNIXwTpL/pMoLNSBcQ3X6Y5CcM2ahaMzcXgzso=;
        b=OVz6NWhpbR0q0OZZ1jpe84PjWI4R5DxCDX97ryr4BxU55E++YPrOTU0eeWImxbZ2GIMGey
        FA4LXWd2Eowowu626PVwcvwRek+GTTlQCNA4E89LYV06t0sIHN1MqSTtlkJkeUY0oain5N
        d4r/B1A+KSW4+LOBUd2eeSDahbz1Hm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVPahaNIXwTpL/pMoLNSBcQ3X6Y5CcM2ahaMzcXgzso=;
        b=f8Uy+m+oyJYVe5iQbmdeBTEF4CixVkmkwM4vuEMvktls1jPhVvGn/eWStGZfy097JYLXyv
        wdRTDi6zLS5OUeAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7739F2C165;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6411251CD15B; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/18] brd: make sector size configurable
Date:   Mon, 18 Sep 2023 13:05:07 +0200
Message-Id: <20230918110510.66470-16-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a module option 'rd_blksize' to allow the user to change
the sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 50 +++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 90e1b6c4fbc8..0c5f3dbbb77c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -30,7 +30,7 @@
 /*
  * Each block ramdisk device has a xarray of folios that stores the folios
  * containing the block device's contents. A brd folio's ->index is its offset
- * in PAGE_SIZE units. This is similar to, but in no way connected with,
+ * in brd_sector_size units. This is similar to, but in no way connected with,
  * the kernel's pagecache or buffer cache (which sit above our block device).
  */
 struct brd_device {
@@ -43,9 +43,11 @@ struct brd_device {
 	 */
 	struct xarray	        brd_folios;
 	u64			brd_nr_folios;
+	unsigned int		brd_sector_shift;
+	unsigned int		brd_sector_size;
 };
 
-#define BRD_SECTOR_SHIFT(b) (PAGE_SHIFT - SECTOR_SHIFT)
+#define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - SECTOR_SHIFT)
 
 static pgoff_t brd_sector_index(struct brd_device *brd, sector_t sector)
 {
@@ -85,7 +87,7 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
 	struct folio *folio, *cur;
-	unsigned int rd_sector_order = get_order(PAGE_SIZE);
+	unsigned int rd_sector_order = get_order(brd->brd_sector_size);
 	int ret = 0;
 
 	folio = brd_lookup_folio(brd, sector);
@@ -140,7 +142,7 @@ static void brd_free_folios(struct brd_device *brd)
 static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 			     gfp_t gfp)
 {
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 	int ret;
@@ -163,7 +165,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
 	struct folio *folio;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
@@ -181,7 +183,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct folio *folio;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
@@ -279,6 +281,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static unsigned int rd_blksize = PAGE_SIZE;
+module_param(rd_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -305,6 +311,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
+	unsigned int rd_max_sectors;
 	int err = -ENOMEM;
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
@@ -315,6 +322,25 @@ static int brd_alloc(int i)
 		return -ENOMEM;
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
+	if (!is_power_of_2(rd_blksize)) {
+		pr_err("rd_blksize %d is not supported\n", rd_blksize);
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	if (rd_blksize < SECTOR_SIZE) {
+		pr_err("rd_blksize must be at least 512 bytes\n");
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	/* We can't allocate more than MAX_ORDER pages */
+	rd_max_sectors = (1ULL << MAX_ORDER) << PAGE_SECTORS_SHIFT;
+	if ((rd_blksize >> SECTOR_SHIFT) > rd_max_sectors) {
+		pr_err("rd_blocksize too large\n");
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	brd->brd_sector_shift = ilog2(rd_blksize);
+	brd->brd_sector_size = rd_blksize;
 
 	xa_init(&brd->brd_folios);
 
@@ -334,15 +360,9 @@ static int brd_alloc(int i)
 	disk->private_data	= brd;
 	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
 	set_capacity(disk, rd_size * 2);
-	
-	/*
-	 * This is so fdisk will align partitions on 4k, because of
-	 * direct_access API needing 4k alignment, returning a PFN
-	 * (This is only a problem on very small devices <= 4M,
-	 *  otherwise fdisk will align on 1M. Regardless this call
-	 *  is harmless)
-	 */
-	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
+
+	blk_queue_physical_block_size(disk->queue, rd_blksize);
+	blk_queue_max_hw_sectors(disk->queue, rd_max_sectors);
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-- 
2.35.3

