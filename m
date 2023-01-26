Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BC67D655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjAZUZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjAZUYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD64B4B0;
        Thu, 26 Jan 2023 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7RNlhF8CRIANN0d8CRWQ0o803TuHroT7WJqd3rajUk4=; b=Mmy/sKUFAN+RkaB5RN6pK8ftND
        iy4+3icZ4q8wA6tUIVjXnocvgcA/lStN2pGmRbqUzzDEvPVL/Jn65lnV+Rj/F24FPd4LCbuVv6oTm
        3B3sEwtTc969wKLxagJCj5lDABynaL6rTFR8aoS0ekcr8i3NrKu5rRe/GleO7S7J530i2nbX5wCH+
        f96PIzONNaVqp6eeHaC4/wGXRNnQQt0l/HfVBZWhlAAcWiSBoCmpixh9dGEiVKob1NiJZL+2ppRD0
        C1Tv4QbOU7lxj11Hlj40jppEJmGD+jKbVBsIKZ8Tr9GuPXPZ4iv78UupeE1RI4usKU835X+IhwBJt
        0VPvkktg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jQ-N1; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
Date:   Thu, 26 Jan 2023 20:23:47 +0000
Message-Id: <20230126202415.1682629-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

Remove several calls to compound_head() and the last caller of
set_page_writeback_keepwrite(), so remove the wrapper too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/page-io.c          | 58 ++++++++++++++++++--------------------
 include/linux/page-flags.h |  5 ----
 2 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index beaec6d81074..982791050892 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -409,11 +409,9 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 
 static void io_submit_add_bh(struct ext4_io_submit *io,
 			     struct inode *inode,
-			     struct page *page,
+			     struct folio *folio,
 			     struct buffer_head *bh)
 {
-	int ret;
-
 	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
 			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
 submit_and_retry:
@@ -421,10 +419,9 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	}
 	if (io->io_bio == NULL)
 		io_submit_init_bio(io, bh);
-	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
-	if (ret != bh->b_size)
+	if (!bio_add_folio(io->io_bio, folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
-	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
+	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
 	io->io_next_block++;
 }
 
@@ -432,8 +429,9 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			struct page *page,
 			int len)
 {
-	struct page *bounce_page = NULL;
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct folio *io_folio = folio;
+	struct inode *inode = folio->mapping->host;
 	unsigned block_start;
 	struct buffer_head *bh, *head;
 	int ret = 0;
@@ -441,30 +439,30 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	struct writeback_control *wbc = io->io_wbc;
 	bool keep_towrite = false;
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
+	BUG_ON(!folio_test_locked(folio));
+	BUG_ON(folio_test_writeback(folio));
 
-	ClearPageError(page);
+	folio_clear_error(folio);
 
 	/*
 	 * Comments copied from block_write_full_page:
 	 *
-	 * The page straddles i_size.  It must be zeroed out on each and every
+	 * The folio straddles i_size.  It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped.  "A file is mapped
 	 * in multiples of the page size.  For a file that is not a multiple of
 	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
 	 */
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
+	if (len < folio_size(folio))
+		folio_zero_segment(folio, len, folio_size(folio));
 	/*
 	 * In the first loop we prepare and mark buffers to submit. We have to
-	 * mark all buffers in the page before submitting so that
-	 * end_page_writeback() cannot be called from ext4_end_bio() when IO
+	 * mark all buffers in the folio before submitting so that
+	 * folio_end_writeback() cannot be called from ext4_end_bio() when IO
 	 * on the first buffer finishes and we are still working on submitting
 	 * the second buffer.
 	 */
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		block_start = bh_offset(bh);
 		if (block_start >= len) {
@@ -479,14 +477,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 				clear_buffer_dirty(bh);
 			/*
 			 * Keeping dirty some buffer we cannot write? Make sure
-			 * to redirty the page and keep TOWRITE tag so that
-			 * racing WB_SYNC_ALL writeback does not skip the page.
+			 * to redirty the folio and keep TOWRITE tag so that
+			 * racing WB_SYNC_ALL writeback does not skip the folio.
 			 * This happens e.g. when doing writeout for
 			 * transaction commit.
 			 */
 			if (buffer_dirty(bh)) {
-				if (!PageDirty(page))
-					redirty_page_for_writepage(wbc, page);
+				if (!folio_test_dirty(folio))
+					folio_redirty_for_writepage(wbc, folio);
 				keep_towrite = true;
 			}
 			continue;
@@ -498,11 +496,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
-	/* Nothing to submit? Just unlock the page... */
+	/* Nothing to submit? Just unlock the folio... */
 	if (!nr_to_submit)
 		goto unlock;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 
 	/*
 	 * If any blocks are being written to an encrypted file, encrypt them
@@ -514,6 +512,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
+		struct page *bounce_page;
 
 		/*
 		 * Since bounce page allocation uses a mempool, we can only use
@@ -540,7 +539,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			}
 
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			do {
 				if (buffer_async_write(bh)) {
 					clear_buffer_async_write(bh);
@@ -550,21 +549,18 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			} while (bh != head);
 			goto unlock;
 		}
+		io_folio = page_folio(bounce_page);
 	}
 
-	if (keep_towrite)
-		set_page_writeback_keepwrite(page);
-	else
-		set_page_writeback(page);
+	__folio_start_writeback(folio, keep_towrite);
 
 	/* Now submit buffers to write */
 	do {
 		if (!buffer_async_write(bh))
 			continue;
-		io_submit_add_bh(io, inode,
-				 bounce_page ? bounce_page : page, bh);
+		io_submit_add_bh(io, inode, io_folio, bh);
 	} while ((bh = bh->b_this_page) != head);
 unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return ret;
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0425f22a9c82..bba2a32031a2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -766,11 +766,6 @@ bool set_page_writeback(struct page *page);
 #define folio_start_writeback_keepwrite(folio)	\
 	__folio_start_writeback(folio, true)
 
-static inline void set_page_writeback_keepwrite(struct page *page)
-{
-	folio_start_writeback_keepwrite(page_folio(page));
-}
-
 static inline bool test_set_page_writeback(struct page *page)
 {
 	return set_page_writeback(page);
-- 
2.35.1

