Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F69730FBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbjFOGud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbjFOGuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:50:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5D2711;
        Wed, 14 Jun 2023 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zfajrMr4h+aQcu6DQkl8W2vLYsKMj7t92xZera6/X2I=; b=LRS18YHYh8GlqvBY7c7jQFk7mG
        eJ6ZA8cMn1lrsG+8U0Zv4Z5+og+AlHUDPYW27Ppq+idf7+W93dXMKsk0UB/mbywLEUOSrH+8WvQTY
        fif+eXsJcu+6/SoCsdjVvFpsfPyGeoctnX631ly5my0PiqF3pHiw0LCczQuVwagz9z0zZ5bg+rNlF
        Rvgy/FEBAt6awTivZEJbdhCrPy4E70nFHVRCe/3xEu9oaY16A/iUD/VExrxQzv2nAxhrDQazby4s+
        J8CyuUv9vxJPe9qskLabA3UracuMZlQNZEW54sSb94kEUnCsqsoMoQhzdBFFwAoI5hgnyZ+lDGnG/
        ZMGzI2gw==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gn2-00DuBk-1e;
        Thu, 15 Jun 2023 06:49:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] md-bitmap: don't use ->index for pages backing the bitmap file
Date:   Thu, 15 Jun 2023 08:48:38 +0200
Message-Id: <20230615064840.629492-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The md driver allocates pages for storing the bitmap file data, which
are not page cache pages, and then stores the page granularity file
offset in page->index, which is a field that isn't really valid except
for page cache pages.

Use a separate index for the superblock, and use the scheme used at
read size to recalculate the index for the bitmap pages instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 65 ++++++++++++++++++++++++------------------
 drivers/md/md-bitmap.h |  1 +
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 39ff75cc7a16ac..ed402f4dad182d 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -157,11 +157,8 @@ static int read_sb_page(struct mddev *mddev, loff_t offset,
 		    test_bit(Bitmap_sync, &rdev->flags))
 			continue;
 
-		if (sync_page_io(rdev, sector, iosize, page, REQ_OP_READ,
-				true)) {
-			page->index = index;
+		if (sync_page_io(rdev, sector, iosize, page, REQ_OP_READ, true))
 			return 0;
-		}
 	}
 	return -EIO;
 }
@@ -225,18 +222,19 @@ static unsigned int bitmap_io_size(unsigned int io_size, unsigned int opt_size,
 }
 
 static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
-			   struct page *page)
+			   unsigned long pg_index, struct page *page)
 {
 	struct block_device *bdev;
 	struct mddev *mddev = bitmap->mddev;
 	struct bitmap_storage *store = &bitmap->storage;
 	loff_t sboff, offset = mddev->bitmap_info.offset;
-	sector_t ps, doff;
+	sector_t ps = pg_index * PAGE_SIZE / SECTOR_SIZE;
 	unsigned int size = PAGE_SIZE;
 	unsigned int opt_size = PAGE_SIZE;
+	sector_t doff;
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
-	if (page->index == store->file_pages - 1) {
+	if (pg_index == store->file_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 
 		if (last_page_size == 0)
@@ -245,7 +243,6 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 		opt_size = optimal_io_size(bdev, last_page_size, size);
 	}
 
-	ps = page->index * PAGE_SIZE / SECTOR_SIZE;
 	sboff = rdev->sb_start + offset;
 	doff = rdev->data_offset;
 
@@ -279,7 +276,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	return 0;
 }
 
-static void write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
+static void write_sb_page(struct bitmap *bitmap, unsigned long pg_index,
+			  struct page *page, bool wait)
 {
 	struct mddev *mddev = bitmap->mddev;
 
@@ -287,7 +285,7 @@ static void write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
 		struct md_rdev *rdev = NULL;
 
 		while ((rdev = next_active_rdev(rdev, mddev)) != NULL) {
-			if (__write_sb_page(rdev, bitmap, page) < 0) {
+			if (__write_sb_page(rdev, bitmap, pg_index, page) < 0) {
 				set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
 				return;
 			}
@@ -397,7 +395,6 @@ static int read_file_page(struct file *file, unsigned long index,
 		blk_cur++;
 		bh = bh->b_this_page;
 	}
-	page->index = index;
 
 	wait_event(bitmap->write_wait,
 		   atomic_read(&bitmap->pending_writes)==0);
@@ -419,12 +416,21 @@ static int read_file_page(struct file *file, unsigned long index,
 /*
  * write out a page to a file
  */
-static void write_page(struct bitmap *bitmap, struct page *page, int wait)
+static void filemap_write_page(struct bitmap *bitmap, unsigned long pg_index,
+			       bool wait)
 {
-	if (bitmap->storage.file)
+	struct bitmap_storage *store = &bitmap->storage;
+	struct page *page = store->filemap[pg_index];
+
+	if (mddev_is_clustered(bitmap->mddev)) {
+		pg_index += bitmap->cluster_slot *
+			DIV_ROUND_UP(store->bytes, PAGE_SIZE);
+	}
+
+	if (store->file)
 		write_file_page(bitmap, page, wait);
 	else
-		write_sb_page(bitmap, page, wait);
+		write_sb_page(bitmap, pg_index, page, wait);
 }
 
 /*
@@ -481,7 +487,12 @@ void md_bitmap_update_sb(struct bitmap *bitmap)
 	sb->sectors_reserved = cpu_to_le32(bitmap->mddev->
 					   bitmap_info.space);
 	kunmap_atomic(sb);
-	write_page(bitmap, bitmap->storage.sb_page, 1);
+
+	if (bitmap->storage.file)
+		write_file_page(bitmap, bitmap->storage.sb_page, 1);
+	else
+		write_sb_page(bitmap, bitmap->storage.sb_index,
+			      bitmap->storage.sb_page, 1);
 }
 EXPORT_SYMBOL(md_bitmap_update_sb);
 
@@ -533,7 +544,7 @@ static int md_bitmap_new_disk_sb(struct bitmap *bitmap)
 	bitmap->storage.sb_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (bitmap->storage.sb_page == NULL)
 		return -ENOMEM;
-	bitmap->storage.sb_page->index = 0;
+	bitmap->storage.sb_index = 0;
 
 	sb = kmap_atomic(bitmap->storage.sb_page);
 
@@ -810,7 +821,7 @@ static int md_bitmap_storage_alloc(struct bitmap_storage *store,
 	if (store->sb_page) {
 		store->filemap[0] = store->sb_page;
 		pnum = 1;
-		store->sb_page->index = offset;
+		store->sb_index = offset;
 	}
 
 	for ( ; pnum < num_pages; pnum++) {
@@ -819,7 +830,6 @@ static int md_bitmap_storage_alloc(struct bitmap_storage *store,
 			store->file_pages = pnum;
 			return -ENOMEM;
 		}
-		store->filemap[pnum]->index = pnum + offset;
 	}
 	store->file_pages = pnum;
 
@@ -924,6 +934,7 @@ static void md_bitmap_file_set_bit(struct bitmap *bitmap, sector_t block)
 	void *kaddr;
 	unsigned long chunk = block >> bitmap->counts.chunkshift;
 	struct bitmap_storage *store = &bitmap->storage;
+	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
 	if (mddev_is_clustered(bitmap->mddev))
@@ -941,9 +952,9 @@ static void md_bitmap_file_set_bit(struct bitmap *bitmap, sector_t block)
 	else
 		set_bit_le(bit, kaddr);
 	kunmap_atomic(kaddr);
-	pr_debug("set file bit %lu page %lu\n", bit, page->index);
+	pr_debug("set file bit %lu page %lu\n", bit, index);
 	/* record page number so it gets flushed to disk when unplug occurs */
-	set_page_attr(bitmap, page->index - node_offset, BITMAP_PAGE_DIRTY);
+	set_page_attr(bitmap, index - node_offset, BITMAP_PAGE_DIRTY);
 }
 
 static void md_bitmap_file_clear_bit(struct bitmap *bitmap, sector_t block)
@@ -953,6 +964,7 @@ static void md_bitmap_file_clear_bit(struct bitmap *bitmap, sector_t block)
 	void *paddr;
 	unsigned long chunk = block >> bitmap->counts.chunkshift;
 	struct bitmap_storage *store = &bitmap->storage;
+	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
 	if (mddev_is_clustered(bitmap->mddev))
@@ -968,8 +980,8 @@ static void md_bitmap_file_clear_bit(struct bitmap *bitmap, sector_t block)
 	else
 		clear_bit_le(bit, paddr);
 	kunmap_atomic(paddr);
-	if (!test_page_attr(bitmap, page->index - node_offset, BITMAP_PAGE_NEEDWRITE)) {
-		set_page_attr(bitmap, page->index - node_offset, BITMAP_PAGE_PENDING);
+	if (!test_page_attr(bitmap, index - node_offset, BITMAP_PAGE_NEEDWRITE)) {
+		set_page_attr(bitmap, index - node_offset, BITMAP_PAGE_PENDING);
 		bitmap->allclean = 0;
 	}
 }
@@ -1021,7 +1033,7 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 							  "md bitmap_unplug");
 			}
 			clear_page_attr(bitmap, i, BITMAP_PAGE_PENDING);
-			write_page(bitmap, bitmap->storage.filemap[i], 0);
+			filemap_write_page(bitmap, i, false);
 			writing = 1;
 		}
 	}
@@ -1152,7 +1164,7 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 			memset(paddr + offset, 0xff, PAGE_SIZE - offset);
 			kunmap_atomic(paddr);
 
-			write_page(bitmap, page, 1);
+			filemap_write_page(bitmap, i, true);
 			if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags)) {
 				ret = -EIO;
 				goto err;
@@ -1373,9 +1385,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 			break;
 		if (bitmap->storage.filemap &&
 		    test_and_clear_page_attr(bitmap, j,
-					     BITMAP_PAGE_NEEDWRITE)) {
-			write_page(bitmap, bitmap->storage.filemap[j], 0);
-		}
+					     BITMAP_PAGE_NEEDWRITE))
+			filemap_write_page(bitmap, j, false);
 	}
 
  done:
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 8a3788c9bfef85..bb9eb418780a62 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -201,6 +201,7 @@ struct bitmap {
 		struct file *file;		/* backing disk file */
 		struct page *sb_page;		/* cached copy of the bitmap
 						 * file superblock */
+		unsigned long sb_index;
 		struct page **filemap;		/* list of cache pages for
 						 * the file */
 		unsigned long *filemap_attr;	/* attributes associated
-- 
2.39.2

