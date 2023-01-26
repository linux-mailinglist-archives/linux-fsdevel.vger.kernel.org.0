Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3E67D65E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjAZUZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjAZUZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:25:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2058599A6;
        Thu, 26 Jan 2023 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cZMF8LX59CrJPnQgJl9xKeli/V3bk+yesVg+QEOrOmY=; b=VVzbR2x8SocNaTlkE8+Ouz/rMd
        O4X+hY+5R1MMqR98ouhRJEdYDHbPuVr3m2MC+gNiNoJ8QNA9haSprw8/HTyoMt/lYXDq7ALa39Vho
        8cQ6L1drr9IO4ml3idh5NgW3bj6pFje9XgPQQT7WPx6+p/7fw6kMyEvXRBgGS3fsxOE4lizrMOqXD
        Y8ySmxXtBJTQCSq0MNAiwOdPgHBxgKaWP9/VymSxEGUKrPuFbvD/j/SHks/4Pa9YheonhpYo3E8FY
        Z0tysQ0sC/UwgULyIjWkPaJlemCJAHFdrblTtje7Ekrv9wNb0m6KBySIK+v7M0qPu3c0gvvwXL2U3
        4Dl9o3Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073ja-5N; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/31] ext4: Convert ext4_bio_write_page() to ext4_bio_write_folio()
Date:   Thu, 26 Jan 2023 20:23:52 +0000
Message-Id: <20230126202415.1682629-9-willy@infradead.org>
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

Both callers now have a folio so pass it in directly and avoid the call
to page_folio() at the beginning.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/ext4.h    |  5 ++---
 fs/ext4/inode.c   | 18 +++++++++---------
 fs/ext4/page-io.c | 10 ++++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 43e26e6f6e42..7a132e8648f4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3756,9 +3756,8 @@ extern void ext4_io_submit_init(struct ext4_io_submit *io,
 				struct writeback_control *wbc);
 extern void ext4_end_io_rsv_work(struct work_struct *work);
 extern void ext4_io_submit(struct ext4_io_submit *io);
-extern int ext4_bio_write_page(struct ext4_io_submit *io,
-			       struct page *page,
-			       int len);
+int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *page,
+		size_t len);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8b91e325492f..fcd904123384 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2014,9 +2014,9 @@ static int ext4_writepage(struct page *page,
 	struct folio *folio = page_folio(page);
 	int ret = 0;
 	loff_t size;
-	unsigned int len;
+	size_t len;
 	struct buffer_head *page_bufs = NULL;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ext4_io_submit io_submit;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
@@ -2052,12 +2052,12 @@ static int ext4_writepage(struct page *page,
 	 * Also, if there is only one buffer per page (the fs block
 	 * size == the page size), if one buffer needs block
 	 * allocation or needs to modify the extent tree to clear the
-	 * unwritten flag, we know that the page can't be written at
+	 * unwritten flag, we know that the folio can't be written at
 	 * all, so we might as well refuse the write immediately.
 	 * Unfortunately if the block size != page size, we can't as
 	 * easily detect this case using ext4_walk_page_buffers(), but
 	 * for the extremely common case, this is an optimization that
-	 * skips a useless round trip through ext4_bio_write_page().
+	 * skips a useless round trip through ext4_bio_write_folio().
 	 */
 	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
 				   ext4_bh_delay_or_unwritten)) {
@@ -2079,7 +2079,7 @@ static int ext4_writepage(struct page *page,
 	if (folio_test_checked(folio) && ext4_should_journal_data(inode))
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
-		 * doesn't seem much point in redirtying the page here.
+		 * doesn't seem much point in redirtying the folio here.
 		 */
 		return __ext4_journalled_writepage(page, len);
 
@@ -2090,7 +2090,7 @@ static int ext4_writepage(struct page *page,
 		folio_unlock(folio);
 		return -ENOMEM;
 	}
-	ret = ext4_bio_write_page(&io_submit, page, len);
+	ret = ext4_bio_write_folio(&io_submit, folio, len);
 	ext4_io_submit(&io_submit);
 	/* Drop io_end reference we got from init */
 	ext4_put_io_end_defer(io_submit.io_end);
@@ -2113,8 +2113,8 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	 * write-protects our page in page tables and the page cannot get
 	 * written to again until we release folio lock. So only after
 	 * folio_clear_dirty_for_io() we are safe to sample i_size for
-	 * ext4_bio_write_page() to zero-out tail of the written page. We rely
-	 * on the barrier provided by TestClearPageDirty in
+	 * ext4_bio_write_folio() to zero-out tail of the written page. We rely
+	 * on the barrier provided by folio_test_clear_dirty() in
 	 * folio_clear_dirty_for_io() to make sure i_size is really sampled only
 	 * after page tables are updated.
 	 */
@@ -2123,7 +2123,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & ~PAGE_MASK;
-	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
+	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index fd6c0dca24b9..c6da8800a49f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -425,11 +425,9 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 	io->io_next_block++;
 }
 
-int ext4_bio_write_page(struct ext4_io_submit *io,
-			struct page *page,
-			int len)
+int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
+		size_t len)
 {
-	struct folio *folio = page_folio(page);
 	struct folio *io_folio = folio;
 	struct inode *inode = folio->mapping->host;
 	unsigned block_start;
@@ -522,8 +520,8 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (io->io_bio)
 			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page, enc_bytes,
-							       0, gfp_flags);
+		bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page,
+					enc_bytes, 0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
 			if (ret == -ENOMEM &&
-- 
2.35.1

