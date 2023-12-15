Return-Path: <linux-fsdevel+bounces-6217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44738150C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF49286D3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F292A68B75;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G1pdApiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B15787C;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OF9/KtMCSO7iRo1gm6o2VJ23Gj1ecgTlZXtN74iujvU=; b=G1pdApiHUfoUdJNkTK1vUttiWN
	5GdIz83V2P34Nj9ohyg7GY9FdpXzYS7NN0p+ygxkvfbj2cu9EGts4bRrr0I0ZHuzu+vXwcmWksCYm
	sdDXdWgM4HL74p5gH4qf+0IvyNeQ7Y7GnrRyujggMgcfSMFptQGaFRQbD/RD3HYJrg7cYok3S5dj+
	0huWg+6wL24mkkQDGuJ50xF7XsaAh3LfZAyKoGYMAXqp3Zbt3DuEyF5VlSTc8KcBvFAHKkR6MwM3S
	kFhvnrSLddUaRtnYfXtap/lCWnMfjhhG+Py+Tl0XrcIeaZESdm+nPKmp5T+iUW44AZ5FqJVZ6TK5n
	Bvx8gV1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOW-0038jk-FL; Fri, 15 Dec 2023 20:02:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 13/14] fs: Convert block_write_full_page to block_write_full_folio
Date: Fri, 15 Dec 2023 20:02:44 +0000
Message-Id: <20231215200245.748418-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the function to be compatible with writepage_t so that it
can be passed to write_cache_pages() by blkdev.  This removes a call
to compound_head().  We can also remove the function export as both
callers are built-in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                | 21 ++++++++++++++++++---
 fs/buffer.c                 | 16 +++++++---------
 fs/ext4/page-io.c           |  2 +-
 fs/gfs2/aops.c              |  4 ++--
 fs/mpage.c                  |  2 +-
 fs/ntfs/aops.c              |  4 ++--
 fs/ocfs2/alloc.c            |  2 +-
 fs/ocfs2/file.c             |  2 +-
 include/linux/buffer_head.h |  4 ++--
 9 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0bdad1e8d514..0cf8cf72cdfa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -410,9 +410,24 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
+/*
+ * We cannot call mpage_writepages() as it does not take the buffer lock.
+ * We must use block_write_full_folio() directly which holds the buffer
+ * lock.  The buffer lock provides the synchronisation with writeback
+ * that filesystems rely on when they use the blockdev's mapping.
+ */
+static int blkdev_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page, blkdev_get_block, wbc);
+	struct blk_plug plug;
+	int err;
+
+	blk_start_plug(&plug);
+	err = write_cache_pages(mapping, wbc, block_write_full_folio,
+			blkdev_get_block);
+	blk_finish_plug(&plug);
+
+	return err;
 }
 
 static int blkdev_read_folio(struct file *file, struct folio *folio)
@@ -449,7 +464,7 @@ const struct address_space_operations def_blk_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= blkdev_read_folio,
 	.readahead	= blkdev_readahead,
-	.writepage	= blkdev_writepage,
+	.writepages	= blkdev_writepages,
 	.write_begin	= blkdev_write_begin,
 	.write_end	= blkdev_write_end,
 	.migrate_folio	= buffer_migrate_folio_norefs,
diff --git a/fs/buffer.c b/fs/buffer.c
index 9f41d2b38902..2e69f0ddca37 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -372,7 +372,7 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 }
 
 /*
- * Completion handler for block_write_full_page() - pages which are unlocked
+ * Completion handler for block_write_full_folio() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
  */
 void end_buffer_async_write(struct buffer_head *bh, int uptodate)
@@ -1771,18 +1771,18 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
  */
 
 /*
- * While block_write_full_page is writing back the dirty buffers under
+ * While block_write_full_folio is writing back the dirty buffers under
  * the page lock, whoever dirtied the buffers may decide to clean them
  * again at any time.  We handle that by only looking at the buffer
  * state inside lock_buffer().
  *
- * If block_write_full_page() is called for regular writeback
+ * If block_write_full_folio() is called for regular writeback
  * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a page which has a
  * locked buffer.   This only can happen if someone has written the buffer
  * directly, with submit_bh().  At the address_space level PageWriteback
  * prevents this contention from occurring.
  *
- * If block_write_full_page() is called with wbc->sync_mode ==
+ * If block_write_full_folio() is called with wbc->sync_mode ==
  * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
  * causes the writes to be flagged as synchronous writes.
  */
@@ -1829,7 +1829,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			 * truncate in progress.
 			 */
 			/*
-			 * The buffer was zeroed by block_write_full_page()
+			 * The buffer was zeroed by block_write_full_folio()
 			 */
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
@@ -2696,10 +2696,9 @@ EXPORT_SYMBOL(block_truncate_page);
 /*
  * The generic ->writepage function for buffer-backed address_spaces
  */
-int block_write_full_page(struct page *page, get_block_t *get_block,
-			struct writeback_control *wbc)
+int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
+		void *get_block)
 {
-	struct folio *folio = page_folio(page);
 	struct inode * const inode = folio->mapping->host;
 	loff_t i_size = i_size_read(inode);
 
@@ -2726,7 +2725,6 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 	return __block_write_full_folio(inode, folio, get_block, wbc,
 			end_buffer_async_write);
 }
-EXPORT_SYMBOL(block_write_full_page);
 
 sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
 			    get_block_t *get_block)
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf038..312bc6813357 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -444,7 +444,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 	folio_clear_error(folio);
 
 	/*
-	 * Comments copied from block_write_full_page:
+	 * Comments copied from block_write_full_folio:
 	 *
 	 * The folio straddles i_size.  It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped.  "A file is mapped
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 5cffb079b87c..f986cd032b76 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -82,11 +82,11 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
 }
 
 /**
- * gfs2_write_jdata_folio - gfs2 jdata-specific version of block_write_full_page
+ * gfs2_write_jdata_folio - gfs2 jdata-specific version of block_write_full_folio
  * @folio: The folio to write
  * @wbc: The writeback control
  *
- * This is the same as calling block_write_full_page, but it also
+ * This is the same as calling block_write_full_folio, but it also
  * writes pages outside of i_size
  */
 static int gfs2_write_jdata_folio(struct folio *folio,
diff --git a/fs/mpage.c b/fs/mpage.c
index d4963f3d8051..738882e0766d 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -642,7 +642,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	ret = block_write_full_page(&folio->page, mpd->get_block, wbc);
+	ret = block_write_full_folio(folio, wbc, mpd->get_block);
 	mapping_set_error(mapping, ret);
 out:
 	mpd->bio = bio;
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1c747a3baa3e..2d01517a2d59 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1304,7 +1304,7 @@ static int ntfs_write_mst_block(struct page *page,
  * page cleaned.  The VM has already locked the page and marked it clean.
  *
  * For non-resident attributes, ntfs_writepage() writes the @page by calling
- * the ntfs version of the generic block_write_full_page() function,
+ * the ntfs version of the generic block_write_full_folio() function,
  * ntfs_write_block(), which in turn if necessary creates and writes the
  * buffers associated with the page asynchronously.
  *
@@ -1314,7 +1314,7 @@ static int ntfs_write_mst_block(struct page *page,
  * vfs inode dirty code path for the inode the mft record belongs to or via the
  * vm page dirty code path for the page the mft record is in.
  *
- * Based on ntfs_read_folio() and fs/buffer.c::block_write_full_page().
+ * Based on ntfs_read_folio() and fs/buffer.c::block_write_full_folio().
  *
  * Return 0 on success and -errno on error.
  */
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 91b32b2377ac..ea9127ba3208 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6934,7 +6934,7 @@ static int ocfs2_grab_eof_pages(struct inode *inode, loff_t start, loff_t end,
  * nonzero data on subsequent file extends.
  *
  * We need to call this before i_size is updated on the inode because
- * otherwise block_write_full_page() will skip writeout of pages past
+ * otherwise block_write_full_folio() will skip writeout of pages past
  * i_size.
  */
 int ocfs2_zero_range_for_truncate(struct inode *inode, handle_t *handle,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 94e2a1244442..8b6d15010703 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -818,7 +818,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 	/*
 	 * fs-writeback will release the dirty pages without page lock
 	 * whose offset are over inode size, the release happens at
-	 * block_write_full_page().
+	 * block_write_full_folio().
 	 */
 	i_size_write(inode, abs_to);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 94f6161eb45e..396b2adf24bf 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -252,8 +252,8 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
  * address_spaces.
  */
 void block_invalidate_folio(struct folio *folio, size_t offset, size_t length);
-int block_write_full_page(struct page *page, get_block_t *get_block,
-				struct writeback_control *wbc);
+int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
+		void *get_block);
 int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
-- 
2.42.0


