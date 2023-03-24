Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87096C8438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjCXSCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10E1DB92;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=osH4kXio0ufnQh832mZEtEe4/fizBnGDfh/TWAoDpJ8=; b=pfnQ5aCraA9y00X1PZYxMAz9tk
        qjJkrSMIsLY4Z74WHqLDxy9voIg04ntRCJD6wcP3kXRgG+DgYdhqZYLVWDfwg5OQI7cQmYSgHzdpe
        t4qokvpNYAg2wzEEw5Y5d+2Yra/hHaY40cz8gkXG7LJDal2CL6Y5Es5PzRqFd+0hE4rHHcBDAA81m
        ldv407h/EQ3mm4M5yEfPnQ4YM3xIPix6y3rDnVFsoR9gjfhT5zORmGTuZ9FuKGOiwsRdCNuIgaIsK
        bH6jFdihnka6FGJhHN01uJmX8iqimjdYyKgZu6eDDj3bFEuiuLdwveiAjqVKkEdY4V22ilQslS4r+
        MXhUASEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057a8-M0; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 16/29] ext4: Convert ext4_write_begin() to use a folio
Date:   Fri, 24 Mar 2023 18:01:16 +0000
Message-Id: <20230324180129.1220691-17-willy@infradead.org>
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

Remove a lot of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 53 +++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6287cd1aa97e..769f6d5e0ec3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1139,7 +1139,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	int ret, needed_blocks;
 	handle_t *handle;
 	int retries = 0;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index;
 	unsigned from, to;
 
@@ -1166,68 +1166,69 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 	/*
-	 * grab_cache_page_write_begin() can take a long time if the
-	 * system is thrashing due to memory pressure, or if the page
+	 * __filemap_get_folio() can take a long time if the
+	 * system is thrashing due to memory pressure, or if the folio
 	 * is being written back.  So grab it first before we start
 	 * the transaction handle.  This also allows us to allocate
-	 * the page (if needed) without using GFP_NOFS.
+	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+					mapping_gfp_mask(mapping));
+	if (!folio)
 		return -ENOMEM;
 	/*
 	 * The same as page allocation, we prealloc buffer heads before
 	 * starting the handle.
 	 */
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, inode->i_sb->s_blocksize, 0);
+	if (!folio_buffers(folio))
+		create_empty_buffers(&folio->page, inode->i_sb->s_blocksize, 0);
 
-	unlock_page(page);
+	folio_unlock(folio);
 
 retry_journal:
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
 	if (IS_ERR(handle)) {
-		put_page(page);
+		folio_put(folio);
 		return PTR_ERR(handle);
 	}
 
-	lock_page(page);
-	if (page->mapping != mapping) {
-		/* The page got truncated from under us */
-		unlock_page(page);
-		put_page(page);
+	folio_lock(folio);
+	if (folio->mapping != mapping) {
+		/* The folio got truncated from under us */
+		folio_unlock(folio);
+		folio_put(folio);
 		ext4_journal_stop(handle);
 		goto retry_grab;
 	}
-	/* In case writeback began while the page was unlocked */
-	wait_for_stable_page(page);
+	/* In case writeback began while the folio was unlocked */
+	folio_wait_stable(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
-		ret = ext4_block_write_begin(page, pos, len,
+		ret = ext4_block_write_begin(&folio->page, pos, len,
 					     ext4_get_block_unwritten);
 	else
-		ret = ext4_block_write_begin(page, pos, len,
+		ret = ext4_block_write_begin(&folio->page, pos, len,
 					     ext4_get_block);
 #else
 	if (ext4_should_dioread_nolock(inode))
-		ret = __block_write_begin(page, pos, len,
+		ret = __block_write_begin(&folio->page, pos, len,
 					  ext4_get_block_unwritten);
 	else
-		ret = __block_write_begin(page, pos, len, ext4_get_block);
+		ret = __block_write_begin(&folio->page, pos, len, ext4_get_block);
 #endif
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
-					     page_buffers(page), from, to, NULL,
-					     do_journal_get_write_access);
+					     folio_buffers(folio), from, to,
+					     NULL, do_journal_get_write_access);
 	}
 
 	if (ret) {
 		bool extended = (pos + len > inode->i_size) &&
 				!ext4_verity_in_progress(inode);
 
-		unlock_page(page);
+		folio_unlock(folio);
 		/*
 		 * __block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
@@ -1255,10 +1256,10 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
-		put_page(page);
+		folio_put(folio);
 		return ret;
 	}
-	*pagep = page;
+	*pagep = &folio->page;
 	return ret;
 }
 
-- 
2.39.2

