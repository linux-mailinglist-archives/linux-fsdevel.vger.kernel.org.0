Return-Path: <linux-fsdevel+bounces-9928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F148463A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247B81F25C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAC4654D;
	Thu,  1 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0KMcAuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638A45BED
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827572; cv=none; b=R4rc1pEjU3w0SRjtZYJLELxKRNehUwwF7owPEMXv1oH8EVxtx4YZwMn8XNHqbIhXv8XySSZoShzLIlFBYzKf2VAZzAHcoeCNFPMNIqmGZWfOY8NuBmBgZkg/NweLdwV/+5oCg+zaJKJ+NaKW3EGR+6dC28MvDZZru5kZX7kQOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827572; c=relaxed/simple;
	bh=rcIr+B8qxMx5VK8mCQlDbMP5/vYU2Si+NvCCLWlbMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeYcZujegdAanaIqQblMv3ELepRfUJtWT7m1xlF6i12sk8L2/RYhFZKGF1tLtCpjWeIl5i7gtFZ7V83bheidnUgmvsp0d8sqnsbMnCz9YmO+Wc+E0rTScodAWFPWzkeUrAiHWPU6PWsoBMCbfZ8wWn8LvJv0KW3cNsvn97U5ICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I0KMcAuw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6SLAbvmsJojxx3vTYw3U/xZYbOr7sG7SZmWvTEYqw5I=; b=I0KMcAuw7Cb0GRzNwfTPSgu1EI
	yPKz7YDuHNv5W/N+WH1i6yh0DfvZ20yShoUfclzKT4j5GZ8fIavHxAxSTpwe4A7ycYoHTF4vqmAZn
	pRnO5VvL6AvXoX3LRQq8fMPbXA6tiWtFMpzI3ZW5Wno666ZLcgjXup8qcw6v7c8J/Wfg7zNrqyRY2
	G7FukhoT3tcOyb6PuBijn9HSY+06CSknJoh2p3iyy/0qklenhsl1jOLNnlj0WZ2yNlGVCLZGePPMI
	3beQBhzG61i2VY7YtS+ZQvQc2dn5Upp2wJRuJD5b/0nlIhg3Svhs76A844UD6ck36ohetlZJVNcLe
	S4Sl5dIA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H17z-0hMY;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/13] jfs: Convert metapage_writepage to metapage_write_folio
Date: Thu,  1 Feb 2024 22:45:51 +0000
Message-ID: <20240201224605.4055895-3-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement writepages rather than writepage by using write_cache_pages()
to call metapage_write_folio().  Use bio_add_folio_nofail() as we know
we just allocated the bio.  Replace the call to SetPageError (which
is never checked) with a call to mapping_set_error (which ... might be
checked somewhere?)

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 75 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 8266c43ec728..beecc9ad656e 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -4,6 +4,7 @@
  *   Portions Copyright (C) Christoph Hellwig, 2001-2002
  */
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -321,23 +322,25 @@ static void last_write_complete(struct page *page)
 
 static void metapage_write_end_io(struct bio *bio)
 {
-	struct page *page = bio->bi_private;
+	struct folio *folio = bio->bi_private;
 
-	BUG_ON(!PagePrivate(page));
+	BUG_ON(!folio->private);
 
 	if (bio->bi_status) {
+		int err = blk_status_to_errno(bio->bi_status);
 		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
-		SetPageError(page);
+		mapping_set_error(folio->mapping, err);
 	}
-	dec_io(page, last_write_complete);
+	dec_io(&folio->page, last_write_complete);
 	bio_put(bio);
 }
 
-static int metapage_writepage(struct page *page, struct writeback_control *wbc)
+static int metapage_write_folio(struct folio *folio,
+		struct writeback_control *wbc, void *unused)
 {
 	struct bio *bio = NULL;
 	int block_offset;	/* block offset of mp within page */
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	int blocks_per_mp = JFS_SBI(inode->i_sb)->nbperpage;
 	int len;
 	int xlen;
@@ -353,14 +356,13 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	int offset;
 	int bad_blocks = 0;
 
-	page_start = (sector_t)page->index <<
-		     (PAGE_SHIFT - inode->i_blkbits);
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
+	page_start = folio_pos(folio) >> inode->i_blkbits;
+	BUG_ON(!folio_test_locked(folio));
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(page, offset);
+		mp = page_to_mp(&folio->page, offset);
 
 		if (!mp || !test_bit(META_dirty, &mp->flag))
 			continue;
@@ -389,22 +391,20 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 				continue;
 			}
 			/* Not contiguous */
-			if (bio_add_page(bio, page, bio_bytes, bio_offset) <
-			    bio_bytes)
-				goto add_failed;
+			bio_add_folio_nofail(bio, folio, bio_bytes, bio_offset);
 			/*
 			 * Increment counter before submitting i/o to keep
 			 * count from hitting zero before we're through
 			 */
-			inc_io(page);
+			inc_io(&folio->page);
 			if (!bio->bi_iter.bi_size)
 				goto dump_bio;
 			submit_bio(bio);
 			nr_underway++;
 			bio = NULL;
 		} else
-			inc_io(page);
-		xlen = (PAGE_SIZE - offset) >> inode->i_blkbits;
+			inc_io(&folio->page);
+		xlen = (folio_size(folio) - offset) >> inode->i_blkbits;
 		pblock = metapage_get_blocks(inode, lblock, &xlen);
 		if (!pblock) {
 			printk(KERN_ERR "JFS: metapage_get_blocks failed\n");
@@ -420,7 +420,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		bio = bio_alloc(inode->i_sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOFS);
 		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
 		bio->bi_end_io = metapage_write_end_io;
-		bio->bi_private = page;
+		bio->bi_private = folio;
 
 		/* Don't call bio_add_page yet, we may add to this vec */
 		bio_offset = offset;
@@ -430,8 +430,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		next_block = lblock + len;
 	}
 	if (bio) {
-		if (bio_add_page(bio, page, bio_bytes, bio_offset) < bio_bytes)
-				goto add_failed;
+		bio_add_folio_nofail(bio, folio, bio_bytes, bio_offset);
 		if (!bio->bi_iter.bi_size)
 			goto dump_bio;
 
@@ -439,34 +438,42 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		nr_underway++;
 	}
 	if (redirty)
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 
-	unlock_page(page);
+	folio_unlock(folio);
 
 	if (bad_blocks)
 		goto err_out;
 
 	if (nr_underway == 0)
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 
 	return 0;
-add_failed:
-	/* We should never reach here, since we're only adding one vec */
-	printk(KERN_ERR "JFS: bio_add_page failed unexpectedly\n");
-	goto skip;
 dump_bio:
 	print_hex_dump(KERN_ERR, "JFS: dump of bio: ", DUMP_PREFIX_ADDRESS, 16,
 		       4, bio, sizeof(*bio), 0);
-skip:
 	bio_put(bio);
-	unlock_page(page);
-	dec_io(page, last_write_complete);
+	folio_unlock(folio);
+	dec_io(&folio->page, last_write_complete);
 err_out:
 	while (bad_blocks--)
-		dec_io(page, last_write_complete);
+		dec_io(&folio->page, last_write_complete);
 	return -EIO;
 }
 
+static int metapage_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct blk_plug plug;
+	int err;
+
+	blk_start_plug(&plug);
+	err = write_cache_pages(mapping, wbc, metapage_write_folio, NULL);
+	blk_finish_plug(&plug);
+
+	return err;
+}
+
 static int metapage_read_folio(struct file *fp, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
@@ -556,7 +563,7 @@ static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 
 const struct address_space_operations jfs_metapage_aops = {
 	.read_folio	= metapage_read_folio,
-	.writepage	= metapage_writepage,
+	.writepages	= metapage_writepages,
 	.release_folio	= metapage_release_folio,
 	.invalidate_folio = metapage_invalidate_folio,
 	.dirty_folio	= filemap_dirty_folio,
@@ -698,7 +705,7 @@ static int metapage_write_one(struct page *page)
 
 	if (folio_clear_dirty_for_io(folio)) {
 		folio_get(folio);
-		ret = metapage_writepage(page, &wbc);
+		ret = metapage_write_folio(folio, &wbc, NULL);
 		if (ret == 0)
 			folio_wait_writeback(folio);
 		folio_put(folio);
-- 
2.43.0


