Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE39772FD53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbjFNLrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbjFNLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F641BE8;
        Wed, 14 Jun 2023 04:46:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A659B22518;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+JuxCxbU3J/C7rxukZwv/Y0BBZpaRFvUYKNZQeoUDE=;
        b=W+EX46t3sb9IhLvjQfI4UYRJ6rt6J/ApTLGHdPWsqhosb2HrQ2loC7vRndFa3ub4mwCeWS
        LkQNGBIHXKjhBffHce/R4/kFkwI+cZMlYU8S8nZc5BMAzexbteDg2U39NxX7+8EXrtGQng
        rzk+lxAdkmK6Kh2TWcZiLTbYvl1jHRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+JuxCxbU3J/C7rxukZwv/Y0BBZpaRFvUYKNZQeoUDE=;
        b=E7gNk0er8YuCbdbl9jEhq2z0ZJcJH7591rpNyV6PB05c0uOpa8JFBNlOpgkJEoHq0+VvRg
        4KcgHQwHZ2uny9DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 934872C146;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8950551C4E11; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/7] brd: make sector size configurable
Date:   Wed, 14 Jun 2023 13:46:34 +0200
Message-Id: <20230614114637.89759-5-hare@suse.de>
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

Add a module option 'rd_blksize' to allow the user to change
the sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 50 +++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 71d3d8af8b0d..2ebb5532a204 100644
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
@@ -164,7 +166,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 {
 	struct folio *folio;
 	void *dst;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
@@ -197,7 +199,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 {
 	struct folio *folio;
 	void *src;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
@@ -310,6 +312,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static unsigned int rd_blksize = PAGE_SIZE;
+module_param(rd_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -336,6 +342,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
+	unsigned int rd_max_sectors;
 	int err = -ENOMEM;
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
@@ -346,6 +353,25 @@ static int brd_alloc(int i)
 		return -ENOMEM;
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
+	brd->brd_sector_shift = ilog2(rd_blksize);
+	if ((1ULL << brd->brd_sector_shift) != rd_blksize) {
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
+	rd_max_sectors = (1ULL << MAX_ORDER) << BRD_SECTOR_SHIFT(brd);
+	if (rd_blksize > rd_max_sectors) {
+		pr_err("rd_blocksize too large\n");
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	brd->brd_sector_size = rd_blksize;
 
 	xa_init(&brd->brd_folios);
 
@@ -365,15 +391,9 @@ static int brd_alloc(int i)
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
+	blk_queue_max_hw_sectors(disk->queue, 1ULL << (MAX_ORDER + PAGE_SECTORS_SHIFT));
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-- 
2.35.3

