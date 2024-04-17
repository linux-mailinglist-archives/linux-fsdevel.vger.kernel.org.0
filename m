Return-Path: <linux-fsdevel+bounces-17187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E18A8A95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D8286010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C2174ED2;
	Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6pFrxXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229D172BD0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376624; cv=none; b=Sp5XSB3IVorNytLfbMbiOmohWOHya8G3O3t1rIqPmrhb3e/L5Dmk2zrM67QjWmOL76LcO02ATGZ0PehVbYl85sGcujosZ2NYvetwBpuk8h9/OiJGc7OjN43PdP5Pm0idSWbd7Ynnqa1rKpZif3hm1xzEjAWk2oJXQge9s9SOgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376624; c=relaxed/simple;
	bh=rcIr+B8qxMx5VK8mCQlDbMP5/vYU2Si+NvCCLWlbMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feC8Zx+hiwACC5fJr56kUaOIJ/2eIK/rcIv+Hb2SwFjXefFVI6RSnfT3wGf0sklqLmk59lykTff6ojjJvnMIC9DpGveO81TwciGK0B7qxtxZJCR+C/65u9iT6buBsv5IKM0mbXuHs4qy5bicmjcagCwsD0n3iEwYCGlRRs8P6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t6pFrxXH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6SLAbvmsJojxx3vTYw3U/xZYbOr7sG7SZmWvTEYqw5I=; b=t6pFrxXHMV7wl3AxaPYC9LuFCY
	fiBKUKiJVqfWPECcvRoHu0pOidcy3xO/VRqX97Zhe0u0moo6uICbj+poigGotyu/Q1/jvLrWMWpyz
	X8ZSTCKBaOLo6368qrMpEK0G/kuWjKe4n5WWJoazj8Mk2eJbjkAi+Q4tFIbH3aEwhBhFXDvk9cnDa
	aSsYXzXhbAy8e1F9SmHK80VZ+ACda/5Ye06bC3XIXuogBVYa+t4i6GFonqyG03CpGt3n1hj6xDrI0
	2/x0jOZgvqIuI+WxswJlbdgpGrDUgEFpaDdd8Zqt8riOsHXlpUVHHer5ooSEr34XNN+Nlb9mwY2Ut
	zaSUUeIA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003Qsl-07dQ;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/13] jfs: Convert metapage_writepage to metapage_write_folio
Date: Wed, 17 Apr 2024 18:56:46 +0100
Message-ID: <20240417175659.818299-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
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


