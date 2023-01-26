Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6376B67D623
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAZUYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjAZUYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFE149952;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ega2nPk6JyEOJ/yX+Ll6lvh5JFeML9DVVsy1UgiysaI=; b=W11c6TgYvIrAvAX6geT5vrTlVF
        7+VDUABsqY6HvbcWaN/cLQZwKTk7RWMZNpqk15A5j6AqJyHZH+4uCCs4aYFj3cYq3fQpIDDzJ/uLv
        JoxjshFA1qNcB7H7h2F2pYnQMSQoqeuqAGs/W2Sid09onGRqEi+4jAWY5ivv7JA1ifoDLmoEeEod+
        +GhIEcw+ZYnWxAO4HjyNsbnyYcJH6y6LDERhZNApdG2LzGzSLbBirD82NeC/aeugkNu51YEi7Tt8S
        DxNFoUvrhkI5N1yznEroxW8nEy04XCHMBfEg3vE6dv0KAb8icFpY00flBjrPDJtI2hQA24NvUXOQR
        SGpnK4Fg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073je-B0; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/31] ext4: Convert ext4_convert_inline_data_to_extent() to use a folio
Date:   Thu, 26 Jan 2023 20:23:54 +0000
Message-Id: <20230126202415.1682629-11-willy@infradead.org>
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

Saves a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 38f6282cc012..2091077e37dc 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -535,8 +535,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	int ret, needed_blocks, no_expand;
 	handle_t *handle = NULL;
 	int retries = 0, sem_held = 0;
-	struct page *page = NULL;
-	unsigned int flags;
+	struct folio *folio = NULL;
 	unsigned from, to;
 	struct ext4_iloc iloc;
 
@@ -565,10 +564,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	/* We cannot recurse into the filesystem as the transaction is already
 	 * started */
-	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0);
-	memalloc_nofs_restore(flags);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+			mapping_gfp_mask(mapping));
+	if (!folio) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -583,8 +581,8 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	from = 0;
 	to = ext4_get_inline_size(inode);
-	if (!PageUptodate(page)) {
-		ret = ext4_read_inline_page(inode, page);
+	if (!folio_test_uptodate(folio)) {
+		ret = ext4_read_inline_page(inode, &folio->page);
 		if (ret < 0)
 			goto out;
 	}
@@ -594,21 +592,21 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = __block_write_begin(page, from, to,
+		ret = __block_write_begin(&folio->page, from, to,
 					  ext4_get_block_unwritten);
 	} else
-		ret = __block_write_begin(page, from, to, ext4_get_block);
+		ret = __block_write_begin(&folio->page, from, to, ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
-		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
-					     from, to, NULL,
-					     do_journal_get_write_access);
+		ret = ext4_walk_page_buffers(handle, inode,
+					     folio_buffers(folio), from, to,
+					     NULL, do_journal_get_write_access);
 	}
 
 	if (ret) {
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
 		ext4_orphan_add(handle, inode);
 		ext4_write_unlock_xattr(inode, &no_expand);
 		sem_held = 0;
@@ -628,12 +626,12 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 
-	if (page)
-		block_commit_write(page, from, to);
+	if (folio)
+		block_commit_write(&folio->page, from, to);
 out:
-	if (page) {
-		unlock_page(page);
-		put_page(page);
+	if (folio) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	if (sem_held)
 		ext4_write_unlock_xattr(inode, &no_expand);
-- 
2.35.1

