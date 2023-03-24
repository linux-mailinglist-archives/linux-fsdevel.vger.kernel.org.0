Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA36C846D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjCXSEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjCXSC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF51E1D5;
        Fri, 24 Mar 2023 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BoZAErVqY/VyjEXVA45kzuiM4bUohGdcxiRHOtaw6Ro=; b=FqdvOGW2Pg3GOn0YbAFtWWfpnL
        nIzvIFSCX67tLi8JseVGF0z1Qxg6aWh3/EeD9lElBAb32sax3dt4G5Bg66QIQGd+PClvq0eNDKLWj
        f0Eq2sVPKI6zW2cLoV2KCLElWrETmiQilqCFP2NKx5U8TA5p7NJAi0nXxBILybsL0TrKT5ZkDM07+
        Kt7VZRqAS8XqfGilVzdrOQsLK06X/d7suv/Vso6VPuk50dkuf7lTQBJLNGIOyZhFcfMBy6D/tvyw/
        YFHqRz7zaj0MCZbSzT5zzZDtle1CDcUAs3lpxrKLssYX1cGIOP6wmzNlM/zbvaqyLiYftdcrBpx2x
        JHEHGSvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057Yt-1x; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 03/29] ext4: Convert ext4_bio_write_page() to use a folio
Date:   Fri, 24 Mar 2023 18:01:03 +0000
Message-Id: <20230324180129.1220691-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove several calls to compound_head() and the last caller of
set_page_writeback_keepwrite(), so remove the wrapper too.

Also export bio_add_folio() as this is the first caller from a module.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 block/bio.c                |  1 +
 fs/ext4/page-io.c          | 58 ++++++++++++++++++--------------------
 include/linux/page-flags.h |  5 ----
 3 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fc98c1c723ca..798cc4cf3bd2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1159,6 +1159,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		return false;
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
+EXPORT_SYMBOL(bio_add_folio);
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 8703fd732abb..7850d2cb2e08 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -409,12 +409,10 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 
 static void io_submit_add_bh(struct ext4_io_submit *io,
 			     struct inode *inode,
-			     struct page *pagecache_page,
-			     struct page *bounce_page,
+			     struct folio *folio,
+			     struct folio *io_folio,
 			     struct buffer_head *bh)
 {
-	int ret;
-
 	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
 			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
 submit_and_retry:
@@ -422,11 +420,9 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	}
 	if (io->io_bio == NULL)
 		io_submit_init_bio(io, bh);
-	ret = bio_add_page(io->io_bio, bounce_page ?: pagecache_page,
-			   bh->b_size, bh_offset(bh));
-	if (ret != bh->b_size)
+	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
-	wbc_account_cgroup_owner(io->io_wbc, pagecache_page, bh->b_size);
+	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
 	io->io_next_block++;
 }
 
@@ -434,8 +430,9 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
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
@@ -443,30 +440,30 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
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
@@ -481,14 +478,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
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
@@ -500,11 +497,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
-	/* Nothing to submit? Just unlock the page... */
+	/* Nothing to submit? Just unlock the folio... */
 	if (!nr_to_submit)
 		return 0;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 
 	/*
 	 * If any blocks are being written to an encrypted file, encrypt them
@@ -516,6 +513,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
+		struct page *bounce_page;
 
 		/*
 		 * Since bounce page allocation uses a mempool, we can only use
@@ -542,7 +540,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			}
 
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			do {
 				if (buffer_async_write(bh)) {
 					clear_buffer_async_write(bh);
@@ -553,18 +551,16 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 			return ret;
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
-		io_submit_add_bh(io, inode, page, bounce_page, bh);
+		io_submit_add_bh(io, inode, folio, io_folio, bh);
 	} while ((bh = bh->b_this_page) != head);
 
 	return 0;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 88600a94fa91..1c68d67b832f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -753,11 +753,6 @@ bool set_page_writeback(struct page *page);
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
2.39.2

