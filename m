Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B856C845A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjCXSDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjCXSCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9801B55B;
        Fri, 24 Mar 2023 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5JUC4AIsGYn+08wO5xRBBMnY9d3XtLakNnUo0USQ7Hw=; b=q182Hfo8Vgr+VhfsX1YmlIe4Ej
        4fPC9mwfsUEk6QEwaeiz/8gJY1U3Q1prJ1FBEX8/u9DoAyc7MTco2s09chb641GhksVfes/tOdoKC
        SH6xca/tWsX9dTG+T5SCF7Yv8d4dkNF7WW6F9fF6biXgiXt/Txq1LbcXBUnabP994EUsYjRZUO0mq
        NbXnEmfdCfhmxlSqmgX0tx9/LUmyt5bF620yOXhFlIHO5uixnGEx6bTMy5AjEGWAnPl4QIf1lkbuy
        uiCShlV/Into8uVNew8qUPj9JgC3ImVGgNG3+9XG2yEb2pu9HhICJmy8mGaWY5HKT04qutFP42j6X
        RJtrc+gA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljN-0057aw-UB; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 24/29] ext4: Convert ext4_block_write_begin() to take a folio
Date:   Fri, 24 Mar 2023 18:01:24 +0000
Message-Id: <20230324180129.1220691-25-willy@infradead.org>
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

All the callers now have a folio, so pass that in and operate on folios.
Removes four calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 116acc5fe00c..cf2b89a819cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1030,12 +1030,12 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
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
@@ -1045,22 +1045,24 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
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
@@ -1073,19 +1075,20 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
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
@@ -1105,14 +1108,13 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		page_zero_new_buffers(page, from, to);
+		page_zero_new_buffers(&folio->page, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
-			err2 = fscrypt_decrypt_pagecache_blocks(page_folio(page),
-								blocksize,
-								bh_offset(wait[i]));
+			err2 = fscrypt_decrypt_pagecache_blocks(folio,
+						blocksize, bh_offset(wait[i]));
 			if (err2) {
 				clear_buffer_uptodate(wait[i]);
 				err = err2;
@@ -1206,11 +1208,10 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
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
@@ -2938,8 +2939,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	folio_wait_stable(folio);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(&folio->page, pos, len,
-				     ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #else
 	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
-- 
2.39.2

