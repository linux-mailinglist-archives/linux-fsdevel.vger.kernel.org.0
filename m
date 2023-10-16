Return-Path: <linux-fsdevel+bounces-492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2A7CB435
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FB928197F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C43715E;
	Mon, 16 Oct 2023 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUWZLyWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC9381D9
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:34 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E9EA;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xXV69htwNi4n13/FbPuIQJ5RkmdCr8bBDaZMq8ye+/Y=; b=mUWZLyWDPpNDoGTdy9vlgD/TGh
	266T0/JpKuyIrnCxuzT4nYGCRiEyFazkiXyicg3LlG7CsuJ5x1Aszjh+nAs22Wky7thLrROxlaXEp
	BYFxnWw5qoraXzY7nDAeAjs97DAK6BKRa4cHCmAW4ggMglPmojA4ADJG0wdfIVVJYZ6V2V3+sSAaX
	4LmegFzu7U9e/l1Ba0K7Bn0YOodMqlZKWLzt5ZDr8NmNtYps+biQ96wZXNyaFV/9nwPe21RM25nvD
	CqbmsPHtiUuOPNBKP6SRdA26pwJ6pwJSOsz2Z4nqTvgDu1v+LB7BzSF1fcG0sskJE3tsizu0IcDzr
	x+k60JEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvq-0085c4-OL; Mon, 16 Oct 2023 20:11:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	reiserfs-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 18/27] ntfs: Convert ntfs_writepage to use a folio
Date: Mon, 16 Oct 2023 21:11:05 +0100
Message-Id: <20231016201114.1928083-19-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

use folio APIs throughout.  Saves many hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/aops.c | 211 +++++++++++++++++++++++--------------------------
 1 file changed, 100 insertions(+), 111 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index d66a9f5ffde9..c4426992a2ee 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -501,28 +501,29 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 #ifdef NTFS_RW
 
 /**
- * ntfs_write_block - write a @page to the backing store
- * @page:	page cache page to write out
+ * ntfs_write_block - write a @folio to the backing store
+ * @folio:	page cache folio to write out
  * @wbc:	writeback control structure
  *
- * This function is for writing pages belonging to non-resident, non-mst
+ * This function is for writing folios belonging to non-resident, non-mst
  * protected attributes to their backing store.
  *
- * For a page with buffers, map and write the dirty buffers asynchronously
- * under page writeback. For a page without buffers, create buffers for the
- * page, then proceed as above.
+ * For a folio with buffers, map and write the dirty buffers asynchronously
+ * under folio writeback. For a folio without buffers, create buffers for the
+ * folio, then proceed as above.
  *
- * If a page doesn't have buffers the page dirty state is definitive. If a page
- * does have buffers, the page dirty state is just a hint, and the buffer dirty
- * state is definitive. (A hint which has rules: dirty buffers against a clean
- * page is illegal. Other combinations are legal and need to be handled. In
- * particular a dirty page containing clean buffers for example.)
+ * If a folio doesn't have buffers the folio dirty state is definitive. If
+ * a folio does have buffers, the folio dirty state is just a hint,
+ * and the buffer dirty state is definitive. (A hint which has rules:
+ * dirty buffers against a clean folio is illegal. Other combinations are
+ * legal and need to be handled. In particular a dirty folio containing
+ * clean buffers for example.)
  *
  * Return 0 on success and -errno on error.
  *
  * Based on ntfs_read_block() and __block_write_full_folio().
  */
-static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
+static int ntfs_write_block(struct folio *folio, struct writeback_control *wbc)
 {
 	VCN vcn;
 	LCN lcn;
@@ -540,41 +541,29 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 	bool need_end_writeback;
 	unsigned char blocksize_bits;
 
-	vi = page->mapping->host;
+	vi = folio->mapping->host;
 	ni = NTFS_I(vi);
 	vol = ni->vol;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
-			"0x%lx.", ni->mft_no, ni->type, page->index);
+			"0x%lx.", ni->mft_no, ni->type, folio->index);
 
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(NInoMstProtected(ni));
 	blocksize = vol->sb->s_blocksize;
 	blocksize_bits = vol->sb->s_blocksize_bits;
-	if (!page_has_buffers(page)) {
-		BUG_ON(!PageUptodate(page));
-		create_empty_buffers(page, blocksize,
+	head = folio_buffers(folio);
+	if (!head) {
+		BUG_ON(!folio_test_uptodate(folio));
+		head = folio_create_empty_buffers(folio, blocksize,
 				(1 << BH_Uptodate) | (1 << BH_Dirty));
-		if (unlikely(!page_has_buffers(page))) {
-			ntfs_warning(vol->sb, "Error allocating page "
-					"buffers.  Redirtying page so we try "
-					"again later.");
-			/*
-			 * Put the page back on mapping->dirty_pages, but leave
-			 * its buffers' dirty state as-is.
-			 */
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-			return 0;
-		}
 	}
-	bh = head = page_buffers(page);
-	BUG_ON(!bh);
+	bh = head;
 
 	/* NOTE: Different naming scheme to ntfs_read_block()! */
 
-	/* The first block in the page. */
-	block = (s64)page->index << (PAGE_SHIFT - blocksize_bits);
+	/* The first block in the folio. */
+	block = (s64)folio->index << (PAGE_SHIFT - blocksize_bits);
 
 	read_lock_irqsave(&ni->size_lock, flags);
 	i_size = i_size_read(vi);
@@ -591,14 +580,14 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 	 * Be very careful.  We have no exclusion from block_dirty_folio
 	 * here, and the (potentially unmapped) buffers may become dirty at
 	 * any time.  If a buffer becomes dirty here after we've inspected it
-	 * then we just miss that fact, and the page stays dirty.
+	 * then we just miss that fact, and the folio stays dirty.
 	 *
 	 * Buffers outside i_size may be dirtied by block_dirty_folio;
 	 * handle that here by just cleaning them.
 	 */
 
 	/*
-	 * Loop through all the buffers in the page, mapping all the dirty
+	 * Loop through all the buffers in the folio, mapping all the dirty
 	 * buffers to disk addresses and handling any aliases from the
 	 * underlying block device's mapping.
 	 */
@@ -610,13 +599,13 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		if (unlikely(block >= dblock)) {
 			/*
 			 * Mapped buffers outside i_size will occur, because
-			 * this page can be outside i_size when there is a
+			 * this folio can be outside i_size when there is a
 			 * truncate in progress. The contents of such buffers
 			 * were zeroed by ntfs_writepage().
 			 *
 			 * FIXME: What about the small race window where
 			 * ntfs_writepage() has not done any clearing because
-			 * the page was within i_size but before we get here,
+			 * the folio was within i_size but before we get here,
 			 * vmtruncate() modifies i_size?
 			 */
 			clear_buffer_dirty(bh);
@@ -632,38 +621,38 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		if (unlikely((block >= iblock) &&
 				(initialized_size < i_size))) {
 			/*
-			 * If this page is fully outside initialized
-			 * size, zero out all pages between the current
-			 * initialized size and the current page. Just
+			 * If this folio is fully outside initialized
+			 * size, zero out all folios between the current
+			 * initialized size and the current folio. Just
 			 * use ntfs_read_folio() to do the zeroing
 			 * transparently.
 			 */
 			if (block > iblock) {
 				// TODO:
-				// For each page do:
-				// - read_cache_page()
-				// Again for each page do:
-				// - wait_on_page_locked()
-				// - Check (PageUptodate(page) &&
-				//			!PageError(page))
+				// For each folio do:
+				// - read_cache_folio()
+				// Again for each folio do:
+				// - wait_on_folio_locked()
+				// - Check (folio_test_uptodate(folio) &&
+				//		!folio_test_error(folio))
 				// Update initialized size in the attribute and
 				// in the inode.
-				// Again, for each page do:
+				// Again, for each folio do:
 				//	block_dirty_folio();
-				// put_page()
+				// folio_put()
 				// We don't need to wait on the writes.
 				// Update iblock.
 			}
 			/*
-			 * The current page straddles initialized size. Zero
+			 * The current folio straddles initialized size. Zero
 			 * all non-uptodate buffers and set them uptodate (and
 			 * dirty?). Note, there aren't any non-uptodate buffers
-			 * if the page is uptodate.
-			 * FIXME: For an uptodate page, the buffers may need to
+			 * if the folio is uptodate.
+			 * FIXME: For an uptodate folio, the buffers may need to
 			 * be written out because they were not initialized on
 			 * disk before.
 			 */
-			if (!PageUptodate(page)) {
+			if (!folio_test_uptodate(folio)) {
 				// TODO:
 				// Zero any non-uptodate buffers up to i_size.
 				// Set them uptodate and dirty.
@@ -721,14 +710,14 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 			unsigned long *bpos, *bend;
 
 			/* Check if the buffer is zero. */
-			kaddr = kmap_atomic(page);
-			bpos = (unsigned long *)(kaddr + bh_offset(bh));
-			bend = (unsigned long *)((u8*)bpos + blocksize);
+			kaddr = kmap_local_folio(folio, bh_offset(bh));
+			bpos = (unsigned long *)kaddr;
+			bend = (unsigned long *)(kaddr + blocksize);
 			do {
 				if (unlikely(*bpos))
 					break;
 			} while (likely(++bpos < bend));
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 			if (bpos == bend) {
 				/*
 				 * Buffer is zero and sparse, no need to write
@@ -768,7 +757,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		if (err == -ENOENT || lcn == LCN_ENOENT) {
 			bh->b_blocknr = -1;
 			clear_buffer_dirty(bh);
-			zero_user(page, bh_offset(bh), blocksize);
+			folio_zero_range(folio, bh_offset(bh), blocksize);
 			set_buffer_uptodate(bh);
 			err = 0;
 			continue;
@@ -795,7 +784,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 	bh = head;
 
 	/* Just an optimization, so ->read_folio() is not called later. */
-	if (unlikely(!PageUptodate(page))) {
+	if (unlikely(!folio_test_uptodate(folio))) {
 		int uptodate = 1;
 		do {
 			if (!buffer_uptodate(bh)) {
@@ -805,7 +794,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 			}
 		} while ((bh = bh->b_this_page) != head);
 		if (uptodate)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 
 	/* Setup all mapped, dirty buffers for async write i/o. */
@@ -820,7 +809,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		} else if (unlikely(err)) {
 			/*
 			 * For the error case. The buffer may have been set
-			 * dirty during attachment to a dirty page.
+			 * dirty during attachment to a dirty folio.
 			 */
 			if (err != -ENOMEM)
 				clear_buffer_dirty(bh);
@@ -833,20 +822,20 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 			err = 0;
 		else if (err == -ENOMEM) {
 			ntfs_warning(vol->sb, "Error allocating memory. "
-					"Redirtying page so we try again "
+					"Redirtying folio so we try again "
 					"later.");
 			/*
-			 * Put the page back on mapping->dirty_pages, but
+			 * Put the folio back on mapping->dirty_pages, but
 			 * leave its buffer's dirty state as-is.
 			 */
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			err = 0;
 		} else
-			SetPageError(page);
+			folio_set_error(folio);
 	}
 
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);	/* Keeps try_to_free_buffers() away. */
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);	/* Keeps try_to_free_buffers() away. */
 
 	/* Submit the prepared buffers for i/o. */
 	need_end_writeback = true;
@@ -858,11 +847,11 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		}
 		bh = next;
 	} while (bh != head);
-	unlock_page(page);
+	folio_unlock(folio);
 
-	/* If no i/o was started, need to end_page_writeback(). */
+	/* If no i/o was started, need to end writeback here. */
 	if (unlikely(need_end_writeback))
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 
 	ntfs_debug("Done.");
 	return err;
@@ -1331,8 +1320,9 @@ static int ntfs_write_mst_block(struct page *page,
  */
 static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	loff_t i_size;
-	struct inode *vi = page->mapping->host;
+	struct inode *vi = folio->mapping->host;
 	ntfs_inode *base_ni = NULL, *ni = NTFS_I(vi);
 	char *addr;
 	ntfs_attr_search_ctx *ctx = NULL;
@@ -1341,14 +1331,13 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	int err;
 
 retry_writepage:
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	i_size = i_size_read(vi);
-	/* Is the page fully outside i_size? (truncate in progress) */
-	if (unlikely(page->index >= (i_size + PAGE_SIZE - 1) >>
+	/* Is the folio fully outside i_size? (truncate in progress) */
+	if (unlikely(folio->index >= (i_size + PAGE_SIZE - 1) >>
 			PAGE_SHIFT)) {
-		struct folio *folio = page_folio(page);
 		/*
-		 * The page may have dirty, unmapped buffers.  Make them
+		 * The folio may have dirty, unmapped buffers.  Make them
 		 * freeable here, so the page does not leak.
 		 */
 		block_invalidate_folio(folio, 0, folio_size(folio));
@@ -1367,7 +1356,7 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	if (ni->type != AT_INDEX_ALLOCATION) {
 		/* If file is encrypted, deny access, just like NT4. */
 		if (NInoEncrypted(ni)) {
-			unlock_page(page);
+			folio_unlock(folio);
 			BUG_ON(ni->type != AT_DATA);
 			ntfs_debug("Denying write access to encrypted file.");
 			return -EACCES;
@@ -1378,14 +1367,14 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 			BUG_ON(ni->name_len);
 			// TODO: Implement and replace this with
 			// return ntfs_write_compressed_block(page);
-			unlock_page(page);
+			folio_unlock(folio);
 			ntfs_error(vi->i_sb, "Writing to compressed files is "
 					"not supported yet.  Sorry.");
 			return -EOPNOTSUPP;
 		}
 		// TODO: Implement and remove this check.
 		if (NInoNonResident(ni) && NInoSparse(ni)) {
-			unlock_page(page);
+			folio_unlock(folio);
 			ntfs_error(vi->i_sb, "Writing to sparse files is not "
 					"supported yet.  Sorry.");
 			return -EOPNOTSUPP;
@@ -1394,34 +1383,34 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	/* NInoNonResident() == NInoIndexAllocPresent() */
 	if (NInoNonResident(ni)) {
 		/* We have to zero every time due to mmap-at-end-of-file. */
-		if (page->index >= (i_size >> PAGE_SHIFT)) {
-			/* The page straddles i_size. */
-			unsigned int ofs = i_size & ~PAGE_MASK;
-			zero_user_segment(page, ofs, PAGE_SIZE);
+		if (folio->index >= (i_size >> PAGE_SHIFT)) {
+			/* The folio straddles i_size. */
+			unsigned int ofs = i_size & (folio_size(folio) - 1);
+			folio_zero_segment(folio, ofs, folio_size(folio));
 		}
 		/* Handle mst protected attributes. */
 		if (NInoMstProtected(ni))
 			return ntfs_write_mst_block(page, wbc);
 		/* Normal, non-resident data stream. */
-		return ntfs_write_block(page, wbc);
+		return ntfs_write_block(folio, wbc);
 	}
 	/*
 	 * Attribute is resident, implying it is not compressed, encrypted, or
 	 * mst protected.  This also means the attribute is smaller than an mft
-	 * record and hence smaller than a page, so can simply return error on
-	 * any pages with index above 0.  Note the attribute can actually be
+	 * record and hence smaller than a folio, so can simply return error on
+	 * any folios with index above 0.  Note the attribute can actually be
 	 * marked compressed but if it is resident the actual data is not
 	 * compressed so we are ok to ignore the compressed flag here.
 	 */
-	BUG_ON(page_has_buffers(page));
-	BUG_ON(!PageUptodate(page));
-	if (unlikely(page->index > 0)) {
-		ntfs_error(vi->i_sb, "BUG()! page->index (0x%lx) > 0.  "
-				"Aborting write.", page->index);
-		BUG_ON(PageWriteback(page));
-		set_page_writeback(page);
-		unlock_page(page);
-		end_page_writeback(page);
+	BUG_ON(folio_buffers(folio));
+	BUG_ON(!folio_test_uptodate(folio));
+	if (unlikely(folio->index > 0)) {
+		ntfs_error(vi->i_sb, "BUG()! folio->index (0x%lx) > 0.  "
+				"Aborting write.", folio->index);
+		BUG_ON(folio_test_writeback(folio));
+		folio_start_writeback(folio);
+		folio_unlock(folio);
+		folio_end_writeback(folio);
 		return -EIO;
 	}
 	if (!NInoAttr(ni))
@@ -1454,12 +1443,12 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	if (unlikely(err))
 		goto err_out;
 	/*
-	 * Keep the VM happy.  This must be done otherwise the radix-tree tag
-	 * PAGECACHE_TAG_DIRTY remains set even though the page is clean.
+	 * Keep the VM happy.  This must be done otherwise
+	 * PAGECACHE_TAG_DIRTY remains set even though the folio is clean.
 	 */
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
-	unlock_page(page);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
 	i_size = i_size_read(vi);
 	if (unlikely(attr_len > i_size)) {
@@ -1474,18 +1463,18 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 		/* Shrinking cannot fail. */
 		BUG_ON(err);
 	}
-	addr = kmap_atomic(page);
-	/* Copy the data from the page to the mft record. */
+	addr = kmap_local_folio(folio, 0);
+	/* Copy the data from the folio to the mft record. */
 	memcpy((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset),
 			addr, attr_len);
-	/* Zero out of bounds area in the page cache page. */
-	memset(addr + attr_len, 0, PAGE_SIZE - attr_len);
-	kunmap_atomic(addr);
-	flush_dcache_page(page);
+	/* Zero out of bounds area in the page cache folio. */
+	memset(addr + attr_len, 0, folio_size(folio) - attr_len);
+	kunmap_local(addr);
+	flush_dcache_folio(folio);
 	flush_dcache_mft_record_page(ctx->ntfs_ino);
-	/* We are done with the page. */
-	end_page_writeback(page);
+	/* We are done with the folio. */
+	folio_end_writeback(folio);
 	/* Finally, mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
@@ -1496,18 +1485,18 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 		ntfs_warning(vi->i_sb, "Error allocating memory. Redirtying "
 				"page so we try again later.");
 		/*
-		 * Put the page back on mapping->dirty_pages, but leave its
+		 * Put the folio back on mapping->dirty_pages, but leave its
 		 * buffers' dirty state as-is.
 		 */
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		err = 0;
 	} else {
 		ntfs_error(vi->i_sb, "Resident attribute write failed with "
 				"error %i.", err);
-		SetPageError(page);
+		folio_set_error(folio);
 		NVolSetErrors(ni->vol);
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
-- 
2.40.1


