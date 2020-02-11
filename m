Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0415879D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBKBEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:04:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgBKBD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Lc+G4SM/NEvw6vPCbTjjSWwe9lLNYIaWmhi8L3efmGY=; b=L4gwhJsvAFtaZtSZUEMrcbz/ML
        Li1qYUOlP+Ep7R6MQfLdddJzhAHGbKd0VhUn/qwmMZkC226s7fk9PzVLSodHiBr0ckylw63mxn2Dd
        tTs8rkKL88P1Te2NINojiZmRQPfaxCGk4cWcLuBOxJocpoqSad3boNJAMHRbEFcADx4SsIvnuN4jO
        8l/8VqgL1+2kLLaJM5CY496E3jBXl8KKe0OYK6+XNLJ/kQ35H6tnXnOl7ifrJhaJNVG+2IGbGidgM
        2Nc84P5x35s1bKRevyBYVWXXB/abDB5RM3M+U03A6RefWNKsyQm2rI+0Vl07IQcq5AwhuCq2Q9MWw
        bDdSR86g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001o2-GB; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 06/13] fs: Convert mpage_readpages to mpage_readahead
Date:   Mon, 10 Feb 2020 17:03:41 -0800
Message-Id: <20200211010348.6872-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Implement the new readahead aop and convert all callers (block_dev,
exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/staging/exfat/exfat_super.c |  7 +++---
 fs/block_dev.c                      |  7 +++---
 fs/ext2/inode.c                     | 10 +++-----
 fs/fat/inode.c                      |  7 +++---
 fs/gfs2/aops.c                      | 23 ++++++-----------
 fs/hpfs/file.c                      |  7 +++---
 fs/iomap/buffered-io.c              |  2 +-
 fs/isofs/inode.c                    |  7 +++---
 fs/jfs/inode.c                      |  7 +++---
 fs/mpage.c                          | 38 +++++++++--------------------
 fs/nilfs2/inode.c                   | 15 +++---------
 fs/ocfs2/aops.c                     | 34 ++++++++++----------------
 fs/omfs/file.c                      |  7 +++---
 fs/qnx6/inode.c                     |  7 +++---
 fs/reiserfs/inode.c                 |  8 +++---
 fs/udf/inode.c                      |  7 +++---
 include/linux/mpage.h               |  4 +--
 mm/migrate.c                        |  2 +-
 18 files changed, 74 insertions(+), 125 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b81d2a87b82e..96aad9b16d31 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -3002,10 +3002,9 @@ static int exfat_readpage(struct file *file, struct page *page)
 	return  mpage_readpage(page, exfat_get_block);
 }
 
-static int exfat_readpages(struct file *file, struct address_space *mapping,
-			   struct list_head *pages, unsigned int nr_pages)
+static void exfat_readahead(struct readahead_control *rac)
 {
-	return  mpage_readpages(mapping, pages, nr_pages, exfat_get_block);
+	mpage_readahead(rac, exfat_get_block);
 }
 
 static int exfat_writepage(struct page *page, struct writeback_control *wbc)
@@ -3104,7 +3103,7 @@ static sector_t _exfat_bmap(struct address_space *mapping, sector_t block)
 
 static const struct address_space_operations exfat_aops = {
 	.readpage    = exfat_readpage,
-	.readpages   = exfat_readpages,
+	.readahead   = exfat_readahead,
 	.writepage   = exfat_writepage,
 	.writepages  = exfat_writepages,
 	.write_begin = exfat_write_begin,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..2fd9c7bd61f6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -614,10 +614,9 @@ static int blkdev_readpage(struct file * file, struct page * page)
 	return block_read_full_page(page, blkdev_get_block);
 }
 
-static int blkdev_readpages(struct file *file, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages)
+static void blkdev_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, blkdev_get_block);
+	mpage_readahead(rac, blkdev_get_block);
 }
 
 static int blkdev_write_begin(struct file *file, struct address_space *mapping,
@@ -2062,7 +2061,7 @@ static int blkdev_writepages(struct address_space *mapping,
 
 static const struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
-	.readpages	= blkdev_readpages,
+	.readahead	= blkdev_readahead,
 	.writepage	= blkdev_writepage,
 	.write_begin	= blkdev_write_begin,
 	.write_end	= blkdev_write_end,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 119667e65890..2a65387f9b12 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -877,11 +877,9 @@ static int ext2_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, ext2_get_block);
 }
 
-static int
-ext2_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void ext2_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, ext2_get_block);
+	mpage_readahead(rac, ext2_get_block);
 }
 
 static int
@@ -966,7 +964,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 
 const struct address_space_operations ext2_aops = {
 	.readpage		= ext2_readpage,
-	.readpages		= ext2_readpages,
+	.readahead		= ext2_readahead,
 	.writepage		= ext2_writepage,
 	.write_begin		= ext2_write_begin,
 	.write_end		= ext2_write_end,
@@ -980,7 +978,7 @@ const struct address_space_operations ext2_aops = {
 
 const struct address_space_operations ext2_nobh_aops = {
 	.readpage		= ext2_readpage,
-	.readpages		= ext2_readpages,
+	.readahead		= ext2_readahead,
 	.writepage		= ext2_nobh_writepage,
 	.write_begin		= ext2_nobh_write_begin,
 	.write_end		= nobh_write_end,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 594b05ae16c9..3496f5fc3e6d 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -210,10 +210,9 @@ static int fat_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, fat_get_block);
 }
 
-static int fat_readpages(struct file *file, struct address_space *mapping,
-			 struct list_head *pages, unsigned nr_pages)
+static void fat_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, fat_get_block);
+	mpage_readahead(rac, fat_get_block);
 }
 
 static void fat_write_failed(struct address_space *mapping, loff_t to)
@@ -344,7 +343,7 @@ int fat_block_truncate_page(struct inode *inode, loff_t from)
 
 static const struct address_space_operations fat_aops = {
 	.readpage	= fat_readpage,
-	.readpages	= fat_readpages,
+	.readahead	= fat_readahead,
 	.writepage	= fat_writepage,
 	.writepages	= fat_writepages,
 	.write_begin	= fat_write_begin,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ba83b49ce18c..5e63c13c12c1 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -577,7 +577,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 }
 
 /**
- * gfs2_readpages - Read a bunch of pages at once
+ * gfs2_readahead - Read a bunch of pages at once
  * @file: The file to read from
  * @mapping: Address space info
  * @pages: List of pages to read
@@ -590,31 +590,24 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
  *    obviously not something we'd want to do on too regular a basis.
  *    Any I/O we ignore at this time will be done via readpage later.
  * 2. We don't handle stuffed files here we let readpage do the honours.
- * 3. mpage_readpages() does most of the heavy lifting in the common case.
+ * 3. mpage_readahead() does most of the heavy lifting in the common case.
  * 4. gfs2_block_map() is relied upon to set BH_Boundary in the right places.
  */
 
-static int gfs2_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *pages, unsigned nr_pages)
+static void gfs2_readahead(struct readahead_control *rac)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder gh;
-	int ret;
 
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	ret = gfs2_glock_nq(&gh);
-	if (unlikely(ret))
+	if (gfs2_glock_nq(&gh))
 		goto out_uninit;
 	if (!gfs2_is_stuffed(ip))
-		ret = mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
+		mpage_readahead(rac, gfs2_block_map);
 	gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
-	if (unlikely(gfs2_withdrawn(sdp)))
-		ret = -EIO;
-	return ret;
 }
 
 /**
@@ -828,7 +821,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
-	.readpages = gfs2_readpages,
+	.readahead = gfs2_readahead,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
 	.releasepage = gfs2_releasepage,
@@ -842,7 +835,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
 	.readpage = gfs2_readpage,
-	.readpages = gfs2_readpages,
+	.readahead = gfs2_readahead,
 	.set_page_dirty = jdata_set_page_dirty,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index b36abf9cb345..2de0d3492d15 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -125,10 +125,9 @@ static int hpfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, hpfs_get_block, wbc);
 }
 
-static int hpfs_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *pages, unsigned nr_pages)
+static void hpfs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, hpfs_get_block);
+	mpage_readahead(rac, hpfs_get_block);
 }
 
 static int hpfs_writepages(struct address_space *mapping,
@@ -198,7 +197,7 @@ static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 const struct address_space_operations hpfs_aops = {
 	.readpage = hpfs_readpage,
 	.writepage = hpfs_writepage,
-	.readpages = hpfs_readpages,
+	.readahead = hpfs_readahead,
 	.writepages = hpfs_writepages,
 	.write_begin = hpfs_write_begin,
 	.write_end = hpfs_write_end,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7c84c4c027c4..cb3511eb152a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -359,7 +359,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	}
 
 	/*
-	 * Just like mpage_readpages and block_read_full_page we always
+	 * Just like mpage_readahead and block_read_full_page we always
 	 * return 0 and just mark the page as PageError on errors.  This
 	 * should be cleaned up all through the stack eventually.
 	 */
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 62c0462dc89f..95b1f377ad09 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1185,10 +1185,9 @@ static int isofs_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, isofs_get_block);
 }
 
-static int isofs_readpages(struct file *file, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages)
+static void isofs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, isofs_get_block);
+	mpage_readahead(rac, isofs_get_block);
 }
 
 static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
@@ -1198,7 +1197,7 @@ static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 
 static const struct address_space_operations isofs_aops = {
 	.readpage = isofs_readpage,
-	.readpages = isofs_readpages,
+	.readahead = isofs_readahead,
 	.bmap = _isofs_bmap
 };
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 9486afcdac76..6f65bfa9f18d 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -296,10 +296,9 @@ static int jfs_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, jfs_get_block);
 }
 
-static int jfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void jfs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, jfs_get_block);
+	mpage_readahead(rac, jfs_get_block);
 }
 
 static void jfs_write_failed(struct address_space *mapping, loff_t to)
@@ -358,7 +357,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations jfs_aops = {
 	.readpage	= jfs_readpage,
-	.readpages	= jfs_readpages,
+	.readahead	= jfs_readahead,
 	.writepage	= jfs_writepage,
 	.writepages	= jfs_writepages,
 	.write_begin	= jfs_write_begin,
diff --git a/fs/mpage.c b/fs/mpage.c
index ccba3c4c4479..166a95ec1341 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -91,7 +91,7 @@ mpage_alloc(struct block_device *bdev,
 }
 
 /*
- * support function for mpage_readpages.  The fs supplied get_block might
+ * support function for mpage_readahead.  The fs supplied get_block might
  * return an up to date buffer.  This is used to map that buffer into
  * the page, which allows readpage to avoid triggering a duplicate call
  * to get_block.
@@ -338,13 +338,10 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 }
 
 /**
- * mpage_readpages - populate an address space with some pages & start reads against them
+ * mpage_readahead - start reads against pages
  * @mapping: the address_space
- * @pages: The address of a list_head which contains the target pages.  These
- *   pages have their ->index populated and are otherwise uninitialised.
- *   The page at @pages->prev has the lowest file offset, and reads should be
- *   issued in @pages->prev to @pages->next order.
- * @nr_pages: The number of pages at *@pages
+ * @start: The number of the first page to read.
+ * @nr_pages: The number of consecutive pages to read.
  * @get_block: The filesystem's block mapper function.
  *
  * This function walks the pages and the blocks within each page, building and
@@ -381,36 +378,25 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
  *
  * This all causes the disk requests to be issued in the correct order.
  */
-int
-mpage_readpages(struct address_space *mapping, struct list_head *pages,
-				unsigned nr_pages, get_block_t get_block)
+void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 {
+	struct page *page;
 	struct mpage_readpage_args args = {
 		.get_block = get_block,
 		.is_readahead = true,
 	};
-	unsigned page_idx;
-
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = lru_to_page(pages);
 
+	readahead_for_each(rac, page) {
 		prefetchw(&page->flags);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping,
-					page->index,
-					readahead_gfp_mask(mapping))) {
-			args.page = page;
-			args.nr_pages = nr_pages - page_idx;
-			args.bio = do_mpage_readpage(&args);
-		}
+		args.page = page;
+		args.nr_pages = readahead_count(rac);
+		args.bio = do_mpage_readpage(&args);
 		put_page(page);
 	}
-	BUG_ON(!list_empty(pages));
 	if (args.bio)
 		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
-	return 0;
 }
-EXPORT_SYMBOL(mpage_readpages);
+EXPORT_SYMBOL(mpage_readahead);
 
 /*
  * This isn't called much at all
@@ -563,7 +549,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 		 * Page has buffers, but they are all unmapped. The page was
 		 * created by pagein or read over a hole which was handled by
 		 * block_read_full_page().  If this address_space is also
-		 * using mpage_readpages then this can rarely happen.
+		 * using mpage_readahead then this can rarely happen.
 		 */
 		goto confused;
 	}
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 671085512e0f..ceeb3b441844 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -145,18 +145,9 @@ static int nilfs_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, nilfs_get_block);
 }
 
-/**
- * nilfs_readpages() - implement readpages() method of nilfs_aops {}
- * address_space_operations.
- * @file - file struct of the file to be read
- * @mapping - address_space struct used for reading multiple pages
- * @pages - the pages to be read
- * @nr_pages - number of pages to be read
- */
-static int nilfs_readpages(struct file *file, struct address_space *mapping,
-			   struct list_head *pages, unsigned int nr_pages)
+static void nilfs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, nilfs_get_block);
+	mpage_readahead(rac, nilfs_get_block);
 }
 
 static int nilfs_writepages(struct address_space *mapping,
@@ -308,7 +299,7 @@ const struct address_space_operations nilfs_aops = {
 	.readpage		= nilfs_readpage,
 	.writepages		= nilfs_writepages,
 	.set_page_dirty		= nilfs_set_page_dirty,
-	.readpages		= nilfs_readpages,
+	.readahead		= nilfs_readahead,
 	.write_begin		= nilfs_write_begin,
 	.write_end		= nilfs_write_end,
 	/* .releasepage		= nilfs_releasepage, */
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 3a67a6518ddf..e8137efaafec 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -350,14 +350,11 @@ static int ocfs2_readpage(struct file *file, struct page *page)
  * grow out to a tree. If need be, detecting boundary extents could
  * trivially be added in a future version of ocfs2_get_block().
  */
-static int ocfs2_readpages(struct file *filp, struct address_space *mapping,
-			   struct list_head *pages, unsigned nr_pages)
+static void ocfs2_readahead(struct readahead_control *rac)
 {
-	int ret, err = -EIO;
-	struct inode *inode = mapping->host;
+	int ret;
+	struct inode *inode = rac->mapping->host;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	loff_t start;
-	struct page *last;
 
 	/*
 	 * Use the nonblocking flag for the dlm code to avoid page
@@ -365,36 +362,31 @@ static int ocfs2_readpages(struct file *filp, struct address_space *mapping,
 	 */
 	ret = ocfs2_inode_lock_full(inode, NULL, 0, OCFS2_LOCK_NONBLOCK);
 	if (ret)
-		return err;
+		return;
 
-	if (down_read_trylock(&oi->ip_alloc_sem) == 0) {
-		ocfs2_inode_unlock(inode, 0);
-		return err;
-	}
+	if (down_read_trylock(&oi->ip_alloc_sem) == 0)
+		goto out_unlock;
 
 	/*
 	 * Don't bother with inline-data. There isn't anything
 	 * to read-ahead in that case anyway...
 	 */
 	if (oi->ip_dyn_features & OCFS2_INLINE_DATA_FL)
-		goto out_unlock;
+		goto out_up;
 
 	/*
 	 * Check whether a remote node truncated this file - we just
 	 * drop out in that case as it's not worth handling here.
 	 */
-	last = lru_to_page(pages);
-	start = (loff_t)last->index << PAGE_SHIFT;
-	if (start >= i_size_read(inode))
-		goto out_unlock;
+	if (readahead_offset(rac) >= i_size_read(inode))
+		goto out_up;
 
-	err = mpage_readpages(mapping, pages, nr_pages, ocfs2_get_block);
+	mpage_readahead(rac, ocfs2_get_block);
 
-out_unlock:
+out_up:
 	up_read(&oi->ip_alloc_sem);
+out_unlock:
 	ocfs2_inode_unlock(inode, 0);
-
-	return err;
 }
 
 /* Note: Because we don't support holes, our allocation has
@@ -2474,7 +2466,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations ocfs2_aops = {
 	.readpage		= ocfs2_readpage,
-	.readpages		= ocfs2_readpages,
+	.readahead		= ocfs2_readahead,
 	.writepage		= ocfs2_writepage,
 	.write_begin		= ocfs2_write_begin,
 	.write_end		= ocfs2_write_end,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index d640b9388238..d7b5f09d298c 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -289,10 +289,9 @@ static int omfs_readpage(struct file *file, struct page *page)
 	return block_read_full_page(page, omfs_get_block);
 }
 
-static int omfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void omfs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, omfs_get_block);
+	mpage_readahead(rac, omfs_get_block);
 }
 
 static int omfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -373,7 +372,7 @@ const struct inode_operations omfs_file_inops = {
 
 const struct address_space_operations omfs_aops = {
 	.readpage = omfs_readpage,
-	.readpages = omfs_readpages,
+	.readahead = omfs_readahead,
 	.writepage = omfs_writepage,
 	.writepages = omfs_writepages,
 	.write_begin = omfs_write_begin,
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 345db56c98fd..755293c8c71a 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -99,10 +99,9 @@ static int qnx6_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, qnx6_get_block);
 }
 
-static int qnx6_readpages(struct file *file, struct address_space *mapping,
-		   struct list_head *pages, unsigned nr_pages)
+static void qnx6_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, qnx6_get_block);
+	mpage_readahead(rac, qnx6_get_block);
 }
 
 /*
@@ -499,7 +498,7 @@ static sector_t qnx6_bmap(struct address_space *mapping, sector_t block)
 }
 static const struct address_space_operations qnx6_aops = {
 	.readpage	= qnx6_readpage,
-	.readpages	= qnx6_readpages,
+	.readahead	= qnx6_readahead,
 	.bmap		= qnx6_bmap
 };
 
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 6419e6dacc39..0031070b3692 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1160,11 +1160,9 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	return retval;
 }
 
-static int
-reiserfs_readpages(struct file *file, struct address_space *mapping,
-		   struct list_head *pages, unsigned nr_pages)
+static void reiserfs_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, reiserfs_get_block);
+	mpage_readahead(rac, reiserfs_get_block);
 }
 
 /*
@@ -3434,7 +3432,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 const struct address_space_operations reiserfs_address_space_operations = {
 	.writepage = reiserfs_writepage,
 	.readpage = reiserfs_readpage,
-	.readpages = reiserfs_readpages,
+	.readahead = reiserfs_readahead,
 	.releasepage = reiserfs_releasepage,
 	.invalidatepage = reiserfs_invalidatepage,
 	.write_begin = reiserfs_write_begin,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e875bc5668ee..adaba8e8b326 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -195,10 +195,9 @@ static int udf_readpage(struct file *file, struct page *page)
 	return mpage_readpage(page, udf_get_block);
 }
 
-static int udf_readpages(struct file *file, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages)
+static void udf_readahead(struct readahead_control *rac)
 {
-	return mpage_readpages(mapping, pages, nr_pages, udf_get_block);
+	mpage_readahead(rac, udf_get_block);
 }
 
 static int udf_write_begin(struct file *file, struct address_space *mapping,
@@ -234,7 +233,7 @@ static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 
 const struct address_space_operations udf_aops = {
 	.readpage	= udf_readpage,
-	.readpages	= udf_readpages,
+	.readahead	= udf_readahead,
 	.writepage	= udf_writepage,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 001f1fcf9836..f4f5e90a6844 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -13,9 +13,9 @@
 #ifdef CONFIG_BLOCK
 
 struct writeback_control;
+struct readahead_control;
 
-int mpage_readpages(struct address_space *mapping, struct list_head *pages,
-				unsigned nr_pages, get_block_t get_block);
+void mpage_readahead(struct readahead_control *, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
diff --git a/mm/migrate.c b/mm/migrate.c
index b1092876e537..a32122095702 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1020,7 +1020,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		 * to the LRU. Later, when the IO completes the pages are
 		 * marked uptodate and unlocked. However, the queueing
 		 * could be merging multiple pages for one bio (e.g.
-		 * mpage_readpages). If an allocation happens for the
+		 * mpage_readahead). If an allocation happens for the
 		 * second or third page, the process can end up locking
 		 * the same page twice and deadlocking. Rather than
 		 * trying to be clever about what pages can be locked,
-- 
2.25.0

