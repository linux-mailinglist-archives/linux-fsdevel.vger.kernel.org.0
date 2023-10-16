Return-Path: <linux-fsdevel+bounces-488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE817CB432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704A01C20C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F763B793;
	Mon, 16 Oct 2023 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbjQZhUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118A381DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:34 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AF112;
	Mon, 16 Oct 2023 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Xp+QE9Qcwim0j3A98602n64hzJhTuI1lZnbxuA3ltu8=; b=UbjQZhUzGx3SVWyIAzGnFiSQ5j
	NNLH61o+0k+7P/Om5MbcDWJ7VfV/fC7iHeeot68tO/juqfA46/E6VGeUepq6nH9LlA0EMOpxrY6Ch
	q1Xd5j/slPHNAOYiNODikfDPCaQDdHol0IZHrwpKa4AiypNV+xRuP1GAx5yz7o7bnpkwxcphwnukl
	0qYed34mK5kcdS6sMBjfuxNDhqEm77DJjFvjP2zYqptF0mrbLDvr+hsRfYHjr9pte275Av+RWbsXL
	UPqS9cJNHE8qgMeVQli9oPkbHEGpe98CLyayKHoyOOQEdnguvQVTIzJCV4cwXGS05XGNrt597TvyM
	xbw0c1Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvr-0085ca-AF; Mon, 16 Oct 2023 20:11:19 +0000
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
Subject: [PATCH v2 22/27] reiserfs: Convert writepage to use a folio
Date: Mon, 16 Oct 2023 21:11:09 +0100
Message-Id: <20231016201114.1928083-23-willy@infradead.org>
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

Convert the incoming page to a folio and then use it throughout the
writeback path.  This definitely isn't enough to support large folios, but
I don't expect reiserfs to gain support for those before it is removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 80 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c8572346556f..d7df556220a4 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2503,10 +2503,10 @@ static int map_block_for_writepage(struct inode *inode,
  * start/recovery path as __block_write_full_folio, along with special
  * code to handle reiserfs tails.
  */
-static int reiserfs_write_full_page(struct page *page,
+static int reiserfs_write_full_folio(struct folio *folio,
 				    struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned long end_index = inode->i_size >> PAGE_SHIFT;
 	int error = 0;
 	unsigned long block;
@@ -2514,7 +2514,7 @@ static int reiserfs_write_full_page(struct page *page,
 	struct buffer_head *head, *bh;
 	int partial = 0;
 	int nr = 0;
-	int checked = PageChecked(page);
+	int checked = folio_test_checked(folio);
 	struct reiserfs_transaction_handle th;
 	struct super_block *s = inode->i_sb;
 	int bh_per_page = PAGE_SIZE / s->s_blocksize;
@@ -2522,47 +2522,46 @@ static int reiserfs_write_full_page(struct page *page,
 
 	/* no logging allowed when nonblocking or from PF_MEMALLOC */
 	if (checked && (current->flags & PF_MEMALLOC)) {
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
+		folio_redirty_for_writepage(wbc, folio);
+		folio_unlock(folio);
 		return 0;
 	}
 
 	/*
-	 * The page dirty bit is cleared before writepage is called, which
+	 * The folio dirty bit is cleared before writepage is called, which
 	 * means we have to tell create_empty_buffers to make dirty buffers
-	 * The page really should be up to date at this point, so tossing
+	 * The folio really should be up to date at this point, so tossing
 	 * in the BH_Uptodate is just a sanity check.
 	 */
-	if (!page_has_buffers(page)) {
-		create_empty_buffers(page, s->s_blocksize,
+	head = folio_buffers(folio);
+	if (!head)
+		head = folio_create_empty_buffers(folio, s->s_blocksize,
 				     (1 << BH_Dirty) | (1 << BH_Uptodate));
-	}
-	head = page_buffers(page);
 
 	/*
-	 * last page in the file, zero out any contents past the
+	 * last folio in the file, zero out any contents past the
 	 * last byte in the file
 	 */
-	if (page->index >= end_index) {
+	if (folio->index >= end_index) {
 		unsigned last_offset;
 
 		last_offset = inode->i_size & (PAGE_SIZE - 1);
-		/* no file contents in this page */
-		if (page->index >= end_index + 1 || !last_offset) {
-			unlock_page(page);
+		/* no file contents in this folio */
+		if (folio->index >= end_index + 1 || !last_offset) {
+			folio_unlock(folio);
 			return 0;
 		}
-		zero_user_segment(page, last_offset, PAGE_SIZE);
+		folio_zero_segment(folio, last_offset, folio_size(folio));
 	}
 	bh = head;
-	block = page->index << (PAGE_SHIFT - s->s_blocksize_bits);
+	block = folio->index << (PAGE_SHIFT - s->s_blocksize_bits);
 	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
 	/* first map all the buffers, logging any direct items we find */
 	do {
 		if (block > last_block) {
 			/*
 			 * This can happen when the block size is less than
-			 * the page size.  The corresponding bytes in the page
+			 * the folio size.  The corresponding bytes in the folio
 			 * were zero filled above
 			 */
 			clear_buffer_dirty(bh);
@@ -2589,7 +2588,7 @@ static int reiserfs_write_full_page(struct page *page,
 	 * blocks we're going to log
 	 */
 	if (checked) {
-		ClearPageChecked(page);
+		folio_clear_checked(folio);
 		reiserfs_write_lock(s);
 		error = journal_begin(&th, s, bh_per_page + 1);
 		if (error) {
@@ -2598,7 +2597,7 @@ static int reiserfs_write_full_page(struct page *page,
 		}
 		reiserfs_update_inode_transaction(inode);
 	}
-	/* now go through and lock any dirty buffers on the page */
+	/* now go through and lock any dirty buffers on the folio */
 	do {
 		get_bh(bh);
 		if (!buffer_mapped(bh))
@@ -2619,7 +2618,7 @@ static int reiserfs_write_full_page(struct page *page,
 			lock_buffer(bh);
 		} else {
 			if (!trylock_buffer(bh)) {
-				redirty_page_for_writepage(wbc, page);
+				folio_redirty_for_writepage(wbc, folio);
 				continue;
 			}
 		}
@@ -2636,13 +2635,13 @@ static int reiserfs_write_full_page(struct page *page,
 		if (error)
 			goto fail;
 	}
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
-	unlock_page(page);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 
 	/*
-	 * since any buffer might be the only dirty buffer on the page,
-	 * the first submit_bh can bring the page out of writeback.
+	 * since any buffer might be the only dirty buffer on the folio,
+	 * the first submit_bh can bring the folio out of writeback.
 	 * be careful with the buffers.
 	 */
 	do {
@@ -2659,10 +2658,10 @@ static int reiserfs_write_full_page(struct page *page,
 done:
 	if (nr == 0) {
 		/*
-		 * if this page only had a direct item, it is very possible for
+		 * if this folio only had a direct item, it is very possible for
 		 * no io to be required without there being an error.  Or,
 		 * someone else could have locked them and sent them down the
-		 * pipe without locking the page
+		 * pipe without locking the folio
 		 */
 		bh = head;
 		do {
@@ -2673,18 +2672,18 @@ static int reiserfs_write_full_page(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 		if (!partial)
-			SetPageUptodate(page);
-		end_page_writeback(page);
+			folio_mark_uptodate(folio);
+		folio_end_writeback(folio);
 	}
 	return error;
 
 fail:
 	/*
 	 * catches various errors, we need to make sure any valid dirty blocks
-	 * get to the media.  The page is currently locked and not marked for
+	 * get to the media.  The folio is currently locked and not marked for
 	 * writeback
 	 */
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 	bh = head;
 	do {
 		get_bh(bh);
@@ -2694,16 +2693,16 @@ static int reiserfs_write_full_page(struct page *page,
 		} else {
 			/*
 			 * clear any dirty bits that might have come from
-			 * getting attached to a dirty page
+			 * getting attached to a dirty folio
 			 */
 			clear_buffer_dirty(bh);
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	SetPageError(page);
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
-	unlock_page(page);
+	folio_set_error(folio);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
@@ -2724,9 +2723,10 @@ static int reiserfs_read_folio(struct file *f, struct folio *folio)
 
 static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	reiserfs_wait_on_write_block(inode->i_sb);
-	return reiserfs_write_full_page(page, wbc);
+	return reiserfs_write_full_folio(folio, wbc);
 }
 
 static void reiserfs_truncate_failed_write(struct inode *inode)
-- 
2.40.1


