Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB8E67D647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjAZUYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5749952;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yp1hifiEATrURCYketbD6BQMeHyHPE7j4pW3CSdtzfM=; b=Ywr/wpTTJM9J2sODBgsVk4tFI7
        JwOIzUxqqaG0kiJjtgre/K/HQEgxH3wnDdkkCobqs//J5ttfZF6w1XFbHGze1OqqSC2XBq/ZpCHo8
        mpIAG3k2IQyNLIW/CZwv/7TgJuoJDHKOg2uuLJJFJ3ND1jz2RBj4T4EOJNA3MmMEal8LeYsN5sl5k
        ILYxENWT+wx8CreqQKkuSUDwwVyatpOwyIVUgRsjGjUHE9xfEGYvsGn1HkPieW7lazOIXn0LJsaso
        k0Y6OPOQ6+bAmuGP6F9xlaPWuGQujSzgg7wAh5LoBwZQxcHpmrGdWHggWO8aof965M/14oyYZrNsi
        NFbfGfYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073kx-Ob; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/31] ext4: Convert __ext4_journalled_writepage() to take a folio
Date:   Thu, 26 Jan 2023 20:24:05 +0000
Message-Id: <20230126202415.1682629-22-willy@infradead.org>
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

Use the folio APIs throughout and remove a PAGE_SIZE assumption.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 727aa2e51a9d..9b2c21d0e1f3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -136,7 +136,7 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static int __ext4_journalled_writepage(struct page *page, unsigned int len);
+static int __ext4_journalled_writepage(struct folio *folio, unsigned int len);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 
@@ -1891,10 +1891,10 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int __ext4_journalled_writepage(struct page *page,
+static int __ext4_journalled_writepage(struct folio *folio,
 				       unsigned int len)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	handle_t *handle = NULL;
 	int ret = 0, err = 0;
@@ -1902,37 +1902,38 @@ static int __ext4_journalled_writepage(struct page *page,
 	struct buffer_head *inode_bh = NULL;
 	loff_t size;
 
-	ClearPageChecked(page);
+	folio_clear_checked(folio);
 
 	if (inline_data) {
-		BUG_ON(page->index != 0);
+		BUG_ON(folio->index != 0);
 		BUG_ON(len > ext4_get_max_inline_size(inode));
-		inode_bh = ext4_journalled_write_inline_data(inode, len, page);
+		inode_bh = ext4_journalled_write_inline_data(inode, len,
+							     &folio->page);
 		if (inode_bh == NULL)
 			goto out;
 	}
 	/*
-	 * We need to release the page lock before we start the
-	 * journal, so grab a reference so the page won't disappear
+	 * We need to release the folio lock before we start the
+	 * journal, so grab a reference so the folio won't disappear
 	 * out from under us.
 	 */
-	get_page(page);
-	unlock_page(page);
+	folio_get(folio);
+	folio_unlock(folio);
 
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
 				    ext4_writepage_trans_blocks(inode));
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		put_page(page);
+		folio_put(folio);
 		goto out_no_pagelock;
 	}
 	BUG_ON(!ext4_handle_valid(handle));
 
-	lock_page(page);
-	put_page(page);
+	folio_lock(folio);
+	folio_put(folio);
 	size = i_size_read(inode);
-	if (page->mapping != mapping || page_offset(page) > size) {
-		/* The page got truncated from under us */
+	if (folio->mapping != mapping || folio_pos(folio) > size) {
+		/* The folio got truncated from under us */
 		ext4_journal_stop(handle);
 		ret = 0;
 		goto out;
@@ -1941,12 +1942,11 @@ static int __ext4_journalled_writepage(struct page *page,
 	if (inline_data) {
 		ret = ext4_mark_inode_dirty(handle, inode);
 	} else {
-		struct buffer_head *page_bufs = page_buffers(page);
+		struct buffer_head *page_bufs = folio_buffers(folio);
 
-		if (page->index == size >> PAGE_SHIFT)
-			len = size & ~PAGE_MASK;
-		else
-			len = PAGE_SIZE;
+		len = folio_size(folio);
+		if (folio_pos(folio) + len > size)
+			len = size - folio_pos(folio);
 
 		ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
 					     NULL, do_journal_get_write_access);
@@ -1956,7 +1956,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	}
 	if (ret == 0)
 		ret = err;
-	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
+	err = ext4_jbd2_inode_add_write(handle, inode, folio_pos(folio), len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
@@ -1966,7 +1966,7 @@ static int __ext4_journalled_writepage(struct page *page,
 
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 out:
-	unlock_page(page);
+	folio_unlock(folio);
 out_no_pagelock:
 	brelse(inode_bh);
 	return ret;
@@ -2086,7 +2086,7 @@ static int ext4_writepage(struct page *page,
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the folio here.
 		 */
-		return __ext4_journalled_writepage(page, len);
+		return __ext4_journalled_writepage(folio, len);
 
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
-- 
2.35.1

