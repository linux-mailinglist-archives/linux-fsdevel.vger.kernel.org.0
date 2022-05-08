Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852451F186
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiEHUhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630B11C1E
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OCxjvAdZxpvrpie/TK297LRQ65OSZAlqwmxei9EQf58=; b=nHksmjXHjeIfi6QQHd5fbNRW+P
        OAAwJJ5g6QZigHTBhLvgoeGq03k4XPYpwc1XisZmw91vs+fL2b/eRvXIyyizQxamKbskFNamzjjT3
        gNujUNDtry0gG/v3o00N7YjubN6vaHYUy6naoqiJveb1ZECTdx38C9wqG69RQs5QXWWJQAOvink+/
        PB7RCoHOkG3OSbYc4Ax3AMdmQAD6IVWBXoSCm5kKv/Ejxr8H3M/m5uIa3NjmXFPYqZW81D79TzLQA
        JcvL7uxw3JKwoJ912N5s52uqAVFWXh+b7jJX9X7djOgQf+Px2F/UcgSLjGtGNt38aPJHZsNYGnj5H
        eS0xzeZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1V-1H; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/26] f2fs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:31 +0100
Message-Id: <20220508203247.668791-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While converting f2fs_release_page() to f2fs_release_folio(), cache the
sb_info so we don't need to retrieve it twice, and remove the redundant
call to set_page_private().  The use of folios should be pushed further
into f2fs from here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/compress.c   |  2 +-
 fs/f2fs/data.c       | 32 +++++++++++++++++---------------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/node.c       |  2 +-
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 909085a78f9c..456c1e89386a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -468,7 +468,7 @@ const struct address_space_operations f2fs_meta_aops = {
 	.writepages	= f2fs_write_meta_pages,
 	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-	.releasepage	= f2fs_release_page,
+	.release_folio	= f2fs_release_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage    = f2fs_migrate_page,
 #endif
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 12a56f9e1572..24824cd96f36 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1746,7 +1746,7 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
 }
 
 const struct address_space_operations f2fs_compress_aops = {
-	.releasepage = f2fs_release_page,
+	.release_folio = f2fs_release_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 };
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f894267f0722..8f38c26bb16c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3528,28 +3528,30 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	folio_detach_private(folio);
 }
 
-int f2fs_release_page(struct page *page, gfp_t wait)
+bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 {
-	/* If this is dirty page, keep PagePrivate */
-	if (PageDirty(page))
-		return 0;
+	struct f2fs_sb_info *sbi;
+
+	/* If this is dirty folio, keep private data */
+	if (folio_test_dirty(folio))
+		return false;
 
 	/* This is atomic written page, keep Private */
-	if (page_private_atomic(page))
-		return 0;
+	if (page_private_atomic(&folio->page))
+		return false;
 
-	if (test_opt(F2FS_P_SB(page), COMPRESS_CACHE)) {
-		struct inode *inode = page->mapping->host;
+	sbi = F2FS_M_SB(folio->mapping);
+	if (test_opt(sbi, COMPRESS_CACHE)) {
+		struct inode *inode = folio->mapping->host;
 
-		if (inode->i_ino == F2FS_COMPRESS_INO(F2FS_I_SB(inode)))
-			clear_page_private_data(page);
+		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
+			clear_page_private_data(&folio->page);
 	}
 
-	clear_page_private_gcing(page);
+	clear_page_private_gcing(&folio->page);
 
-	detach_page_private(page);
-	set_page_private(page, 0);
-	return 1;
+	folio_detach_private(folio);
+	return true;
 }
 
 static bool f2fs_dirty_data_folio(struct address_space *mapping,
@@ -3944,7 +3946,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.write_end	= f2fs_write_end,
 	.dirty_folio	= f2fs_dirty_data_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-	.releasepage	= f2fs_release_page,
+	.release_folio	= f2fs_release_folio,
 	.direct_IO	= noop_direct_IO,
 	.bmap		= f2fs_bmap,
 	.swap_activate  = f2fs_swap_activate,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 18df53ef3d7e..73ebac078884 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3768,7 +3768,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				int compr_blocks, bool allow_balance);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
-int f2fs_release_page(struct page *page, gfp_t wait);
+bool f2fs_release_folio(struct folio *folio, gfp_t wait);
 #ifdef CONFIG_MIGRATION
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c45d341dcf6e..8ccff18560ff 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2165,7 +2165,7 @@ const struct address_space_operations f2fs_node_aops = {
 	.writepages	= f2fs_write_node_pages,
 	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-	.releasepage	= f2fs_release_page,
+	.release_folio	= f2fs_release_folio,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= f2fs_migrate_page,
 #endif
-- 
2.34.1

