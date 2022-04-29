Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A75151FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379657AbiD2RaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E31A2061
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8k/MTnVfPcV8IkbozblERVgKuYJ+p1U9hCwSncciu/c=; b=NH6K0IRazCqwWXH0HiD32WFSUm
        1AjOT8mXdkV3BIxweXLa+yH7l47n8g+arpH7IKKY7PlEtyd5jbqZ0i7qQwX/OZQ2WFmIGNUVYaHXc
        ifYLxfsAyVjXykuzUVkuY3TPiOHWrw9bT7Q4o4eEL/j46Ha+8MDBlFM2O1EHF5PCH5vBtPn+tU+Sd
        zvaN8EEXDAvf5FtWkT3LlPpR7bmGyIVCi64VRd50I7NTV1d4oncHWhUOZ15i6+olBtS9bp13pKSVC
        OfXb9WB6qcieqx7dg2HWXrdXLUOGlzpqAzhsv9yTYT934h2lKGVDb+IwB9HE+CwpUgB9ce2sYrJJo
        ppOXJksg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00CdaH-M7; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 37/69] fs: Convert block_read_full_page() to block_read_full_folio()
Date:   Fri, 29 Apr 2022 18:25:24 +0100
Message-Id: <20220429172556.3011843-38-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is NOT converted to handle large folios, so include
an assert that the filesystem isn't passing one in.  Otherwise, use
the folio functions instead of the page functions, where they exist.
Convert all filesystems which use block_read_full_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                |  6 ++---
 fs/adfs/inode.c             |  6 ++---
 fs/affs/file.c              |  6 ++---
 fs/befs/linuxvfs.c          | 10 +++----
 fs/bfs/file.c               |  6 ++---
 fs/buffer.c                 | 53 ++++++++++++++++++++-----------------
 fs/efs/inode.c              |  8 +++---
 fs/ext4/readpage.c          |  4 +--
 fs/freevxfs/vxfs_subr.c     | 17 ++++++------
 fs/hfs/inode.c              |  8 +++---
 fs/hfsplus/inode.c          |  8 +++---
 fs/iomap/buffered-io.c      |  2 +-
 fs/minix/inode.c            |  6 ++---
 fs/mpage.c                  | 10 +++----
 fs/ntfs/compress.c          |  4 +--
 fs/ocfs2/aops.c             |  6 ++---
 fs/ocfs2/refcounttree.c     |  6 +++--
 fs/omfs/file.c              |  6 ++---
 fs/qnx4/inode.c             |  7 ++---
 fs/reiserfs/file.c          |  2 +-
 fs/reiserfs/inode.c         | 12 ++++-----
 fs/sysv/itree.c             |  6 ++---
 fs/ufs/inode.c              |  8 +++---
 include/linux/buffer_head.h |  2 +-
 24 files changed, 108 insertions(+), 101 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 712affe56e29..06feb41d798b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -387,9 +387,9 @@ static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, blkdev_get_block, wbc);
 }
 
-static int blkdev_readpage(struct file * file, struct page * page)
+static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, blkdev_get_block);
+	return block_read_full_folio(folio, blkdev_get_block);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
@@ -425,7 +425,7 @@ static int blkdev_writepages(struct address_space *mapping,
 const struct address_space_operations def_blk_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= blkdev_readpage,
+	.read_folio	= blkdev_read_folio,
 	.readahead	= blkdev_readahead,
 	.writepage	= blkdev_writepage,
 	.write_begin	= blkdev_write_begin,
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index f7959b1a2d52..ee22278b0cfc 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -38,9 +38,9 @@ static int adfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, adfs_get_block, wbc);
 }
 
-static int adfs_readpage(struct file *file, struct page *page)
+static int adfs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, adfs_get_block);
+	return block_read_full_folio(folio, adfs_get_block);
 }
 
 static void adfs_write_failed(struct address_space *mapping, loff_t to)
@@ -75,7 +75,7 @@ static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 static const struct address_space_operations adfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= adfs_readpage,
+	.read_folio	= adfs_read_folio,
 	.writepage	= adfs_writepage,
 	.write_begin	= adfs_write_begin,
 	.write_end	= generic_write_end,
diff --git a/fs/affs/file.c b/fs/affs/file.c
index b952f65c3f06..5da562cc7fb7 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -375,9 +375,9 @@ static int affs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, affs_get_block, wbc);
 }
 
-static int affs_readpage(struct file *file, struct page *page)
+static int affs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, affs_get_block);
+	return block_read_full_folio(folio, affs_get_block);
 }
 
 static void affs_write_failed(struct address_space *mapping, loff_t to)
@@ -455,7 +455,7 @@ static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations affs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = affs_readpage,
+	.read_folio = affs_read_folio,
 	.writepage = affs_writepage,
 	.write_begin = affs_write_begin,
 	.write_end = affs_write_end,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index b4b3567ac655..25350dd22cda 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -40,7 +40,7 @@ MODULE_LICENSE("GPL");
 
 static int befs_readdir(struct file *, struct dir_context *);
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-static int befs_readpage(struct file *file, struct page *page);
+static int befs_read_folio(struct file *file, struct folio *folio);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
 static struct dentry *befs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
@@ -87,7 +87,7 @@ static const struct inode_operations befs_dir_inode_operations = {
 };
 
 static const struct address_space_operations befs_aops = {
-	.readpage	= befs_readpage,
+	.read_folio	= befs_read_folio,
 	.bmap		= befs_bmap,
 };
 
@@ -102,16 +102,16 @@ static const struct export_operations befs_export_operations = {
 };
 
 /*
- * Called by generic_file_read() to read a page of data
+ * Called by generic_file_read() to read a folio of data
  *
  * In turn, simply calls a generic block read function and
  * passes it the address of befs_get_block, for mapping file
  * positions to disk blocks.
  */
 static int
-befs_readpage(struct file *file, struct page *page)
+befs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, befs_get_block);
+	return block_read_full_folio(folio, befs_get_block);
 }
 
 static sector_t
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index dc97c9b8f23b..57ae5ee6deec 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -155,9 +155,9 @@ static int bfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, bfs_get_block, wbc);
 }
 
-static int bfs_readpage(struct file *file, struct page *page)
+static int bfs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, bfs_get_block);
+	return block_read_full_folio(folio, bfs_get_block);
 }
 
 static void bfs_write_failed(struct address_space *mapping, loff_t to)
@@ -189,7 +189,7 @@ static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations bfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= bfs_readpage,
+	.read_folio	= bfs_read_folio,
 	.writepage	= bfs_writepage,
 	.write_begin	= bfs_write_begin,
 	.write_end	= generic_write_end,
diff --git a/fs/buffer.c b/fs/buffer.c
index 5826ef29fe70..786ef5b98c80 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -314,7 +314,7 @@ static void decrypt_bh(struct work_struct *work)
 }
 
 /*
- * I/O completion handler for block_read_full_page() - pages
+ * I/O completion handler for block_read_full_folio() - pages
  * which come unlocked at the end of I/O.
  */
 static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
@@ -1060,8 +1060,8 @@ __getblk_slow(struct block_device *bdev, sector_t block,
  * Also.  When blockdev buffers are explicitly read with bread(), they
  * individually become uptodate.  But their backing page remains not
  * uptodate - even if all of its buffers are uptodate.  A subsequent
- * block_read_full_page() against that page will discover all the uptodate
- * buffers, will set the page uptodate and will perform no I/O.
+ * block_read_full_folio() against that folio will discover all the uptodate
+ * buffers, will set the folio uptodate and will perform no I/O.
  */
 
 /**
@@ -2088,7 +2088,7 @@ static int __block_commit_write(struct inode *inode, struct page *page,
 
 	/*
 	 * If this is a partial write which happened to make all buffers
-	 * uptodate then we can optimize away a bogus readpage() for
+	 * uptodate then we can optimize away a bogus read_folio() for
 	 * the next read(). Here we 'discover' whether the page went
 	 * uptodate as a result of this (potentially partial) write.
 	 */
@@ -2137,12 +2137,12 @@ int block_write_end(struct file *file, struct address_space *mapping,
 
 	if (unlikely(copied < len)) {
 		/*
-		 * The buffers that were written will now be uptodate, so we
-		 * don't have to worry about a readpage reading them and
-		 * overwriting a partial write. However if we have encountered
-		 * a short write and only partially written into a buffer, it
-		 * will not be marked uptodate, so a readpage might come in and
-		 * destroy our partial write.
+		 * The buffers that were written will now be uptodate, so
+		 * we don't have to worry about a read_folio reading them
+		 * and overwriting a partial write. However if we have
+		 * encountered a short write and only partially written
+		 * into a buffer, it will not be marked uptodate, so a
+		 * read_folio might come in and destroy our partial write.
 		 *
 		 * Do the simplest thing, and just treat any short write to a
 		 * non uptodate page as a zero-length write, and force the
@@ -2245,26 +2245,28 @@ bool block_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 EXPORT_SYMBOL(block_is_partially_uptodate);
 
 /*
- * Generic "read page" function for block devices that have the normal
+ * Generic "read_folio" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
- * Reads the page asynchronously --- the unlock_buffer() and
+ * Reads the folio asynchronously --- the unlock_buffer() and
  * set/clear_buffer_uptodate() functions propagate buffer state into the
- * page struct once IO has completed.
+ * folio once IO has completed.
  */
-int block_read_full_page(struct page *page, get_block_t *get_block)
+int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, bbits;
 	int nr, i;
 	int fully_mapped = 1;
 
-	head = create_page_buffers(page, inode, 0);
+	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+
+	head = create_page_buffers(&folio->page, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-	iblock = (sector_t)page->index << (PAGE_SHIFT - bbits);
+	iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
 	bh = head;
 	nr = 0;
@@ -2282,10 +2284,11 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 				WARN_ON(bh->b_size != blocksize);
 				err = get_block(inode, iblock, bh, 0);
 				if (err)
-					SetPageError(page);
+					folio_set_error(folio);
 			}
 			if (!buffer_mapped(bh)) {
-				zero_user(page, i * blocksize, blocksize);
+				folio_zero_range(folio, i * blocksize,
+						blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
 				continue;
@@ -2301,16 +2304,16 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (fully_mapped)
-		SetPageMappedToDisk(page);
+		folio_set_mappedtodisk(folio);
 
 	if (!nr) {
 		/*
-		 * All buffers are uptodate - we can set the page uptodate
+		 * All buffers are uptodate - we can set the folio uptodate
 		 * as well. But not if get_block() returned an error.
 		 */
-		if (!PageError(page))
-			SetPageUptodate(page);
-		unlock_page(page);
+		if (!folio_test_error(folio))
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 		return 0;
 	}
 
@@ -2335,7 +2338,7 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(block_read_full_page);
+EXPORT_SYMBOL(block_read_full_folio);
 
 /* utility function for filesystems that need to do work on expanding
  * truncates.  Uses filesystem pagecache writes to allow the filesystem to
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..3ba94bb005a6 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -14,16 +14,18 @@
 #include "efs.h"
 #include <linux/efs_fs_sb.h>
 
-static int efs_readpage(struct file *file, struct page *page)
+static int efs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,efs_get_block);
+	return block_read_full_folio(folio, efs_get_block);
 }
+
 static sector_t _efs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,efs_get_block);
 }
+
 static const struct address_space_operations efs_aops = {
-	.readpage = efs_readpage,
+	.read_folio = efs_read_folio,
 	.bmap = _efs_bmap
 };
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index af491e170c4a..e02a5f14e021 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -163,7 +163,7 @@ static bool bio_post_read_required(struct bio *bio)
  *
  * The mpage code never puts partial pages into a BIO (except for end-of-file).
  * If a page does not map to a contiguous run of blocks then it simply falls
- * back to block_read_full_page().
+ * back to block_read_full_folio().
  *
  * Why is this?  If a page's completion depends on a number of different BIOs
  * which can complete in any order (or at the same time) then determining the
@@ -394,7 +394,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			bio = NULL;
 		}
 		if (!PageUptodate(page))
-			block_read_full_page(page, ext4_get_block);
+			block_read_full_folio(page_folio(page), ext4_get_block);
 		else
 			unlock_page(page);
 	next_page:
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145..6143ebab940d 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -38,11 +38,11 @@
 #include "vxfs_extern.h"
 
 
-static int		vxfs_readpage(struct file *, struct page *);
+static int		vxfs_read_folio(struct file *, struct folio *);
 static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 const struct address_space_operations vxfs_aops = {
-	.readpage =		vxfs_readpage,
+	.read_folio =		vxfs_read_folio,
 	.bmap =			vxfs_bmap,
 };
 
@@ -141,24 +141,23 @@ vxfs_getblk(struct inode *ip, sector_t iblock,
 }
 
 /**
- * vxfs_readpage - read one page synchronously into the pagecache
+ * vxfs_read_folio - read one page synchronously into the pagecache
  * @file:	file context (unused)
- * @page:	page frame to fill in.
+ * @folio:	folio to fill in.
  *
  * Description:
- *   The vxfs_readpage routine reads @page synchronously into the
+ *   The vxfs_read_folio routine reads @folio synchronously into the
  *   pagecache.
  *
  * Returns:
  *   Zero on success, else a negative error code.
  *
  * Locking status:
- *   @page is locked and will be unlocked.
+ *   @folio is locked and will be unlocked.
  */
-static int
-vxfs_readpage(struct file *file, struct page *page)
+static int vxfs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, vxfs_getblk);
+	return block_read_full_folio(folio, vxfs_getblk);
 }
  
 /**
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9a26b9510da0..ba3ff9cd7cfc 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -34,9 +34,9 @@ static int hfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, hfs_get_block, wbc);
 }
 
-static int hfs_readpage(struct file *file, struct page *page)
+static int hfs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, hfs_get_block);
+	return block_read_full_folio(folio, hfs_get_block);
 }
 
 static void hfs_write_failed(struct address_space *mapping, loff_t to)
@@ -160,7 +160,7 @@ static int hfs_writepages(struct address_space *mapping,
 const struct address_space_operations hfs_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= hfs_readpage,
+	.read_folio	= hfs_read_folio,
 	.writepage	= hfs_writepage,
 	.write_begin	= hfs_write_begin,
 	.write_end	= generic_write_end,
@@ -171,7 +171,7 @@ const struct address_space_operations hfs_btree_aops = {
 const struct address_space_operations hfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= hfs_readpage,
+	.read_folio	= hfs_read_folio,
 	.writepage	= hfs_writepage,
 	.write_begin	= hfs_write_begin,
 	.write_end	= generic_write_end,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 905ae3660315..982b34eefec7 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -23,9 +23,9 @@
 #include "hfsplus_raw.h"
 #include "xattr.h"
 
-static int hfsplus_readpage(struct file *file, struct page *page)
+static int hfsplus_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, hfsplus_get_block);
+	return block_read_full_folio(folio, hfsplus_get_block);
 }
 
 static int hfsplus_writepage(struct page *page, struct writeback_control *wbc)
@@ -157,7 +157,7 @@ static int hfsplus_writepages(struct address_space *mapping,
 const struct address_space_operations hfsplus_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= hfsplus_readpage,
+	.read_folio	= hfsplus_read_folio,
 	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
@@ -168,7 +168,7 @@ const struct address_space_operations hfsplus_btree_aops = {
 const struct address_space_operations hfsplus_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= hfsplus_readpage,
+	.read_folio	= hfsplus_read_folio,
 	.writepage	= hfsplus_writepage,
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72f63d719c7c..75eb0c27a0e8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -349,7 +349,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	}
 
 	/*
-	 * Just like mpage_readahead and block_read_full_page, we always
+	 * Just like mpage_readahead and block_read_full_folio, we always
 	 * return 0 and just set the folio error flag on errors.  This
 	 * should be cleaned up throughout the stack eventually.
 	 */
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 3add78bccedc..da8bdd1712a7 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -402,9 +402,9 @@ static int minix_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, minix_get_block, wbc);
 }
 
-static int minix_readpage(struct file *file, struct page *page)
+static int minix_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,minix_get_block);
+	return block_read_full_folio(folio, minix_get_block);
 }
 
 int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len)
@@ -443,7 +443,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 static const struct address_space_operations minix_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = minix_readpage,
+	.read_folio = minix_read_folio,
 	.writepage = minix_writepage,
 	.write_begin = minix_write_begin,
 	.write_end = generic_write_end,
diff --git a/fs/mpage.c b/fs/mpage.c
index 1fe56f8c495f..a04439b84ae2 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -36,7 +36,7 @@
  *
  * The mpage code never puts partial pages into a BIO (except for end-of-file).
  * If a page does not map to a contiguous run of blocks then it simply falls
- * back to block_read_full_page().
+ * back to block_read_full_folio().
  *
  * Why is this?  If a page's completion depends on a number of different BIOs
  * which can complete in any order (or at the same time) then determining the
@@ -68,7 +68,7 @@ static struct bio *mpage_bio_submit(struct bio *bio)
 /*
  * support function for mpage_readahead.  The fs supplied get_block might
  * return an up to date buffer.  This is used to map that buffer into
- * the page, which allows readpage to avoid triggering a duplicate call
+ * the page, which allows read_folio to avoid triggering a duplicate call
  * to get_block.
  *
  * The idea is to avoid adding buffers to pages that don't already have
@@ -296,7 +296,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (args->bio)
 		args->bio = mpage_bio_submit(args->bio);
 	if (!PageUptodate(page))
-		block_read_full_page(page, args->get_block);
+		block_read_full_folio(page_folio(page), args->get_block);
 	else
 		unlock_page(page);
 	goto out;
@@ -425,7 +425,7 @@ static void clean_buffers(struct page *page, unsigned first_unmapped)
 
 	/*
 	 * we cannot drop the bh if the page is not uptodate or a concurrent
-	 * readpage would fail to serialize with the bh and it would read from
+	 * read_folio would fail to serialize with the bh and it would read from
 	 * disk before we reach the platter.
 	 */
 	if (buffer_heads_over_limit && PageUptodate(page))
@@ -510,7 +510,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 		/*
 		 * Page has buffers, but they are all unmapped. The page was
 		 * created by pagein or read over a hole which was handled by
-		 * block_read_full_page().  If this address_space is also
+		 * block_read_full_folio().  If this address_space is also
 		 * using mpage_readahead then this can rarely happen.
 		 */
 		goto confused;
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index d2f9d6a0ee32..a60f543e7557 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -780,12 +780,12 @@ int ntfs_read_compressed_block(struct page *page)
 		/* Uncompressed cb, copy it to the destination pages. */
 		/*
 		 * TODO: As a big optimization, we could detect this case
-		 * before we read all the pages and use block_read_full_page()
+		 * before we read all the pages and use block_read_full_folio()
 		 * on all full pages instead (we still have to treat partial
 		 * pages especially but at least we are getting rid of the
 		 * synchronous io for the majority of pages.
 		 * Or if we choose not to do the read-ahead/-behind stuff, we
-		 * could just return block_read_full_page(pages[xpage]) as long
+		 * could just return block_read_full_folio(pages[xpage]) as long
 		 * as PAGE_SIZE <= cb_size.
 		 */
 		if (cb_max_ofs)
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 7cffe9dcad17..7bf4b6fd93bf 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -309,7 +309,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	/*
 	 * i_size might have just been updated as we grabed the meta lock.  We
 	 * might now be discovering a truncate that hit on another node.
-	 * block_read_full_page->get_block freaks out if it is asked to read
+	 * block_read_full_folio->get_block freaks out if it is asked to read
 	 * beyond the end of a file, so we check here.  Callers
 	 * (generic_file_read, vm_ops->fault) are clever enough to check i_size
 	 * and notice that the page they just read isn't needed.
@@ -326,7 +326,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	if (oi->ip_dyn_features & OCFS2_INLINE_DATA_FL)
 		ret = ocfs2_readpage_inline(inode, page);
 	else
-		ret = block_read_full_page(page, ocfs2_get_block);
+		ret = block_read_full_folio(page_folio(page), ocfs2_get_block);
 	unlock = 0;
 
 out_alloc:
@@ -1897,7 +1897,7 @@ static int ocfs2_write_begin(struct file *file, struct address_space *mapping,
 	/*
 	 * Take alloc sem here to prevent concurrent lookups. That way
 	 * the mapping, zeroing and tree manipulation within
-	 * ocfs2_write() will be safe against ->readpage(). This
+	 * ocfs2_write() will be safe against ->read_folio(). This
 	 * should also serve to lock out allocation from a shared
 	 * writeable region.
 	 */
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 7f6355cbb587..e04358a46b68 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2961,12 +2961,14 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		}
 
 		if (!PageUptodate(page)) {
-			ret = block_read_full_page(page, ocfs2_get_block);
+			struct folio *folio = page_folio(page);
+
+			ret = block_read_full_folio(folio, ocfs2_get_block);
 			if (ret) {
 				mlog_errno(ret);
 				goto unlock;
 			}
-			lock_page(page);
+			folio_lock(folio);
 		}
 
 		if (page_has_buffers(page)) {
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 980b0a72c172..fa7fe2393ff6 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -284,9 +284,9 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	return ret;
 }
 
-static int omfs_readpage(struct file *file, struct page *page)
+static int omfs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, omfs_get_block);
+	return block_read_full_folio(folio, omfs_get_block);
 }
 
 static void omfs_readahead(struct readahead_control *rac)
@@ -373,7 +373,7 @@ const struct inode_operations omfs_file_inops = {
 const struct address_space_operations omfs_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = omfs_readpage,
+	.read_folio = omfs_read_folio,
 	.readahead = omfs_readahead,
 	.writepage = omfs_writepage,
 	.writepages = omfs_writepages,
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index a635bb6615e9..391ea402920d 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -245,17 +245,18 @@ static void qnx4_kill_sb(struct super_block *sb)
 	}
 }
 
-static int qnx4_readpage(struct file *file, struct page *page)
+static int qnx4_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,qnx4_get_block);
+	return block_read_full_folio(folio, qnx4_get_block);
 }
 
 static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
+
 static const struct address_space_operations qnx4_aops = {
-	.readpage	= qnx4_readpage,
+	.read_folio	= qnx4_read_folio,
 	.bmap		= qnx4_bmap
 };
 
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 203a47232707..6e228bfbe7ef 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -227,7 +227,7 @@ int reiserfs_commit_page(struct inode *inode, struct page *page,
 	}
 	/*
 	 * If this is a partial write which happened to make all buffers
-	 * uptodate then we can optimize away a bogus readpage() for
+	 * uptodate then we can optimize away a bogus read_folio() for
 	 * the next read(). Here we 'discover' whether the page went
 	 * uptodate as a result of this (potentially partial) write.
 	 */
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 46ba4892030a..33a9555f77b9 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -167,10 +167,10 @@ inline void make_le_item_head(struct item_head *ih, const struct cpu_key *key,
  * cutting the code is fine, since it really isn't in use yet and is easy
  * to add back in.  But, Vladimir has a really good idea here.  Think
  * about what happens for reading a file.  For each page,
- * The VFS layer calls reiserfs_readpage, who searches the tree to find
+ * The VFS layer calls reiserfs_read_folio, who searches the tree to find
  * an indirect item.  This indirect item has X number of pointers, where
  * X is a big number if we've done the block allocation right.  But,
- * we only use one or two of these pointers during each call to readpage,
+ * we only use one or two of these pointers during each call to read_folio,
  * needlessly researching again later on.
  *
  * The size of the cache could be dynamic based on the size of the file.
@@ -966,7 +966,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 			 * it is important the set_buffer_uptodate is done
 			 * after the direct2indirect.  The buffer might
 			 * contain valid data newer than the data on disk
-			 * (read by readpage, changed, and then sent here by
+			 * (read by read_folio, changed, and then sent here by
 			 * writepage).  direct2indirect needs to know if unbh
 			 * was already up to date, so it can decide if the
 			 * data in unbh needs to be replaced with data from
@@ -2733,9 +2733,9 @@ static int reiserfs_write_full_page(struct page *page,
 	goto done;
 }
 
-static int reiserfs_readpage(struct file *f, struct page *page)
+static int reiserfs_read_folio(struct file *f, struct folio *folio)
 {
-	return block_read_full_page(page, reiserfs_get_block);
+	return block_read_full_folio(folio, reiserfs_get_block);
 }
 
 static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -3421,7 +3421,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 const struct address_space_operations reiserfs_address_space_operations = {
 	.writepage = reiserfs_writepage,
-	.readpage = reiserfs_readpage,
+	.read_folio = reiserfs_read_folio,
 	.readahead = reiserfs_readahead,
 	.releasepage = reiserfs_releasepage,
 	.invalidate_folio = reiserfs_invalidate_folio,
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 96ad24fe0ffb..d4ec9bb97de9 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -456,9 +456,9 @@ static int sysv_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,get_block,wbc);
 }
 
-static int sysv_readpage(struct file *file, struct page *page)
+static int sysv_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,get_block);
+	return block_read_full_folio(folio, get_block);
 }
 
 int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len)
@@ -497,7 +497,7 @@ static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations sysv_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = sysv_readpage,
+	.read_folio = sysv_read_folio,
 	.writepage = sysv_writepage,
 	.write_begin = sysv_write_begin,
 	.write_end = generic_write_end,
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 6c973b71cab2..a873de7dec1c 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -390,7 +390,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 
 /**
  * ufs_getfrag_block() - `get_block_t' function, interface between UFS and
- * readpage, writepage and so on
+ * read_folio, writepage and so on
  */
 
 static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
@@ -472,9 +472,9 @@ static int ufs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,ufs_getfrag_block,wbc);
 }
 
-static int ufs_readpage(struct file *file, struct page *page)
+static int ufs_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,ufs_getfrag_block);
+	return block_read_full_folio(folio, ufs_getfrag_block);
 }
 
 int ufs_prepare_chunk(struct page *page, loff_t pos, unsigned len)
@@ -527,7 +527,7 @@ static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations ufs_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = ufs_readpage,
+	.read_folio = ufs_read_folio,
 	.writepage = ufs_writepage,
 	.write_begin = ufs_write_begin,
 	.write_end = ufs_write_end,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 805c4e12700a..31d82fd9abe8 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -223,7 +223,7 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
-int block_read_full_page(struct page*, get_block_t*);
+int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct page **pagep, get_block_t *get_block);
-- 
2.34.1

