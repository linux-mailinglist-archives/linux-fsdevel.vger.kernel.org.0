Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85297A47F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjIRLGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjIRLF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4490E8F;
        Mon, 18 Sep 2023 04:05:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C55521AB3;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfy2vCFgtAVM1TI9ZnFzaxxlIo0HxTD01Jxhm4xNrxg=;
        b=Ca1hy6TigpEZnzpiywPNfr1br8jbqU03nMElLxp6CpVGUpfRNyxQxuMROZykAR1h0c7ob1
        qFFC6tOWF1+Q/YJ2pskJ3tbOSJxnZ8UPZ3y9PiOQ9Kwo2TLAi1RwDRcm/wP+uwUmvHs+Lb
        anmvOqcEA9HzoAMpLGr/YYSbVsyX5is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfy2vCFgtAVM1TI9ZnFzaxxlIo0HxTD01Jxhm4xNrxg=;
        b=btuNDoqqtEgZAlJCAKE86b75PiL6yTMsfdAQdDT9lcaxldv1yTZidGPTN2GAAkJRBWzU5j
        ctslc2fqD3YNBkCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 65B192C15A;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4BEEC51CD155; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/18] brd: convert to folios
Date:   Mon, 18 Sep 2023 13:05:04 +0200
Message-Id: <20230918110510.66470-13-hare@suse.de>
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

Convert the driver to work on folios instead of pages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 150 ++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 76 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 970bd6ff38c4..9aa7511abc33 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -28,11 +28,10 @@
 #include <linux/uaccess.h>
 
 /*
- * Each block ramdisk device has a xarray brd_pages of pages that stores
- * the pages containing the block device's contents. A brd page's ->index is
- * its offset in PAGE_SIZE units. This is similar to, but in no way connected
- * with, the kernel's pagecache or buffer cache (which sit above our block
- * device).
+ * Each block ramdisk device has a xarray of folios that stores the folios
+ * containing the block device's contents. A brd folio's ->index is its offset
+ * in PAGE_SIZE units. This is similar to, but in no way connected with,
+ * the kernel's pagecache or buffer cache (which sit above our block device).
  */
 struct brd_device {
 	int			brd_number;
@@ -40,81 +39,81 @@ struct brd_device {
 	struct list_head	brd_list;
 
 	/*
-	 * Backing store of pages. This is the contents of the block device.
+	 * Backing store of folios. This is the contents of the block device.
 	 */
-	struct xarray	        brd_pages;
-	u64			brd_nr_pages;
+	struct xarray	        brd_folios;
+	u64			brd_nr_folios;
 };
 
 /*
- * Look up and return a brd's page for a given sector.
+ * Look up and return a brd's folio for a given sector.
  */
-static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
+static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct folio *folio;
 
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = xa_load(&brd->brd_pages, idx);
+	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to folio index */
+	folio = xa_load(&brd->brd_folios, idx);
 
-	BUG_ON(page && page->index != idx);
+	BUG_ON(folio && folio->index != idx);
 
-	return page;
+	return folio;
 }
 
 /*
- * Insert a new page for a given sector, if one does not already exist.
+ * Insert a new folio for a given sector, if one does not already exist.
  */
-static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
+static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
-	struct page *page, *cur;
+	struct folio *folio, *cur;
 	int ret = 0;
 
-	page = brd_lookup_page(brd, sector);
-	if (page)
+	folio = brd_lookup_folio(brd, sector);
+	if (folio)
 		return 0;
 
-	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	if (!page)
+	folio = folio_alloc(gfp | __GFP_ZERO | __GFP_HIGHMEM, 0);
+	if (!folio)
 		return -ENOMEM;
 
-	xa_lock(&brd->brd_pages);
+	xa_lock(&brd->brd_folios);
 
 	idx = sector >> PAGE_SECTORS_SHIFT;
-	page->index = idx;
+	folio->index = idx;
 
-	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
+	cur = __xa_cmpxchg(&brd->brd_folios, idx, NULL, folio, gfp);
 
 	if (unlikely(cur)) {
-		__free_page(page);
+		folio_put(folio);
 		ret = xa_err(cur);
 		if (!ret && (cur->index != idx))
 			ret = -EIO;
 	} else {
-		brd->brd_nr_pages++;
+		brd->brd_nr_folios++;
 	}
 
-	xa_unlock(&brd->brd_pages);
+	xa_unlock(&brd->brd_folios);
 
 	return ret;
 }
 
 /*
- * Free all backing store pages and xarray. This must only be called when
+ * Free all backing store folios and xarray. This must only be called when
  * there are no other users of the device.
  */
-static void brd_free_pages(struct brd_device *brd)
+static void brd_free_folios(struct brd_device *brd)
 {
-	struct page *page;
+	struct folio *folio;
 	pgoff_t idx;
 
-	xa_for_each(&brd->brd_pages, idx, page) {
-		__free_page(page);
+	xa_for_each(&brd->brd_folios, idx, folio) {
+		folio_put(folio);
 		cond_resched();
 	}
 
-	xa_destroy(&brd->brd_pages);
+	xa_destroy(&brd->brd_folios);
 }
 
 /*
@@ -128,12 +127,12 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 	int ret;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	ret = brd_insert_page(brd, sector, gfp);
+	ret = brd_insert_folio(brd, sector, gfp);
 	if (ret)
 		return ret;
 	if (copy < n) {
 		sector += copy >> SECTOR_SHIFT;
-		ret = brd_insert_page(brd, sector, gfp);
+		ret = brd_insert_folio(brd, sector, gfp);
 	}
 	return ret;
 }
@@ -144,29 +143,29 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
-	struct page *page;
+	struct folio *folio;
 	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	page = brd_lookup_page(brd, sector);
-	BUG_ON(!page);
+	folio = brd_lookup_folio(brd, sector);
+	BUG_ON(!folio);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	dst = kmap_local_folio(folio, offset);
+	memcpy(dst, src, copy);
+	kunmap_local(dst);
 
 	if (copy < n) {
 		src += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		BUG_ON(!page);
+		folio = brd_lookup_folio(brd, sector);
+		BUG_ON(!folio);
 
-		dst = kmap_atomic(page);
+		dst = kmap_local_folio(folio, 0);
 		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 	}
 }
 
@@ -176,17 +175,17 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
-	struct page *page;
+	struct folio *folio;
 	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
+	folio = brd_lookup_folio(brd, sector);
+	if (folio) {
+		src = kmap_local_folio(folio, offset);
+		memcpy(dst, src, copy);
+		kunmap_local(src);
 	} else
 		memset(dst, 0, copy);
 
@@ -194,20 +193,20 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		dst += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
+		folio = brd_lookup_folio(brd, sector);
+		if (folio) {
+			src = kmap_local_folio(folio, 0);
 			memcpy(dst, src, copy);
-			kunmap_atomic(src);
+			kunmap_local(src);
 		} else
 			memset(dst, 0, copy);
 	}
 }
 
 /*
- * Process a single bvec of a bio.
+ * Process a single folio of a bio.
  */
-static int brd_do_bvec(struct brd_device *brd, struct page *page,
+static int brd_do_folio(struct brd_device *brd, struct folio *folio,
 			unsigned int len, unsigned int off, blk_opf_t opf,
 			sector_t sector)
 {
@@ -217,7 +216,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	if (op_is_write(opf)) {
 		/*
 		 * Must use NOIO because we don't want to recurse back into the
-		 * block or filesystem layers from page reclaim.
+		 * block or filesystem layers from folio reclaim.
 		 */
 		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
 
@@ -226,15 +225,15 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 			goto out;
 	}
 
-	mem = kmap_atomic(page);
+	mem = kmap_local_folio(folio, off);
 	if (!op_is_write(opf)) {
-		copy_from_brd(mem + off, brd, sector, len);
-		flush_dcache_page(page);
+		copy_from_brd(mem, brd, sector, len);
+		flush_dcache_folio(folio);
 	} else {
-		flush_dcache_page(page);
-		copy_to_brd(brd, mem + off, sector, len);
+		flush_dcache_folio(folio);
+		copy_to_brd(brd, mem, sector, len);
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 
 out:
 	return err;
@@ -244,19 +243,18 @@ static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
 	sector_t sector = bio->bi_iter.bi_sector;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct folio_iter iter;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
+	bio_for_each_folio_all(iter, bio) {
+		unsigned int len = iter.length;
 		int err;
 
 		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
+		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
 				(len & (SECTOR_SIZE - 1)));
 
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
+		err = brd_do_folio(brd, iter.folio, len, iter.offset,
+				   bio->bi_opf, sector);
 		if (err) {
 			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
 				bio_wouldblock_error(bio);
@@ -328,12 +326,12 @@ static int brd_alloc(int i)
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
 
-	xa_init(&brd->brd_pages);
+	xa_init(&brd->brd_folios);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
 	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
 		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
-				&brd->brd_nr_pages);
+				&brd->brd_nr_folios);
 
 	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
@@ -388,7 +386,7 @@ static void brd_cleanup(void)
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
 		del_gendisk(brd->brd_disk);
 		put_disk(brd->brd_disk);
-		brd_free_pages(brd);
+		brd_free_folios(brd);
 		list_del(&brd->brd_list);
 		kfree(brd);
 	}
@@ -419,7 +417,7 @@ static int __init brd_init(void)
 
 	brd_check_and_reset_par();
 
-	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_folios", NULL);
 
 	for (i = 0; i < rd_nr; i++) {
 		err = brd_alloc(i);
-- 
2.35.3

