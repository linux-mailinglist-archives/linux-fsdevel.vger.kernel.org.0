Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21E67D63B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAZUYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjAZUYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADB4B88D;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=07jZVgnshAtXEL+2qn3RaXP+/v3Z8FnGfbVeAWNPvp8=; b=YdP3KGeVrX3PlhQjWiiFiGBmUL
        89ShociKKWDjzI5TA2+ueXa8ryD/IkJ3LvE2KcQLot31lApvCVmrEL6DozrUKRe0tWyLAlheVecjU
        DAPfxMaeCajYG2i94dxk2dxUKavXdQ5kwLYQ2qOzDw2Gc8WQh10JkRCyT4t7NRBrQ/ERElM3fLQiP
        I83SVaiHmYhrtO5UQGffutc7T1eBLe8sV1Dj51WwxUc8/M2koOvH6tGb+WjHRZAzpTFXSPvxpt9Pg
        V+sK38tiFSI1kIQryh3hWlsxzKwGEwNzPDM6DAwRIvdlkUvRx15s04bl71P07y6qbqsNkJcTOnUXG
        NwyPTakA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073lV-An; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a folio
Date:   Thu, 26 Jan 2023 20:24:09 +0000
Message-Id: <20230126202415.1682629-26-willy@infradead.org>
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

All the callers now have a folio, so pass that in and operate on folios.
Removes four calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dbfc0670de75..507c7f88d737 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1055,12 +1055,12 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
-static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
+static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 				  get_block_t *get_block)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned block_start, block_end;
 	sector_t block;
 	int err = 0;
@@ -1070,22 +1070,24 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	int nr_wait = 0;
 	int i;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(from > PAGE_SIZE);
 	BUG_ON(to > PAGE_SIZE);
 	BUG_ON(from > to);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
-	head = page_buffers(page);
+	head = folio_buffers(folio);
+	if (!head) {
+		create_empty_buffers(&folio->page, blocksize, 0);
+		head = folio_buffers(folio);
+	}
 	bbits = ilog2(blocksize);
-	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
+	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 
 	for (bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (PageUptodate(page)) {
+			if (folio_test_uptodate(folio)) {
 				set_buffer_uptodate(bh);
 			}
 			continue;
@@ -1098,19 +1100,20 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 			if (err)
 				break;
 			if (buffer_new(bh)) {
-				if (PageUptodate(page)) {
+				if (folio_test_uptodate(folio)) {
 					clear_buffer_new(bh);
 					set_buffer_uptodate(bh);
 					mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
-					zero_user_segments(page, to, block_end,
-							   block_start, from);
+					folio_zero_segments(folio, to,
+							    block_end,
+							    block_start, from);
 				continue;
 			}
 		}
-		if (PageUptodate(page)) {
+		if (folio_test_uptodate(folio)) {
 			set_buffer_uptodate(bh);
 			continue;
 		}
@@ -1130,13 +1133,13 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		page_zero_new_buffers(page, from, to);
+		page_zero_new_buffers(&folio->page, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
-			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
-								bh_offset(wait[i]));
+			err2 = fscrypt_decrypt_pagecache_blocks(&folio->page,
+						blocksize, bh_offset(wait[i]));
 			if (err2) {
 				clear_buffer_uptodate(wait[i]);
 				err = err2;
@@ -1223,11 +1226,10 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
-		ret = ext4_block_write_begin(&folio->page, pos, len,
+		ret = ext4_block_write_begin(folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
-		ret = ext4_block_write_begin(&folio->page, pos, len,
-					     ext4_get_block);
+		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
 #else
 	if (ext4_should_dioread_nolock(inode))
 		ret = __block_write_begin(&folio->page, pos, len,
@@ -3082,8 +3084,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	folio_wait_stable(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(&folio->page, pos, len,
-				     ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #else
 	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
-- 
2.35.1

