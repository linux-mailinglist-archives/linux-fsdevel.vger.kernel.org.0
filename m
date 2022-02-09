Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAA4AFE48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiBIUWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E2E040CAB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OHS9Fp1ZDEQBth59M3UFDw0+26l6vQBh5sn6AfBF+d0=; b=eU37hER8/YDN0zJCslqa/UgaiA
        5cH7trKerNzD83VgVTJzLodE/jNgXuZf9W/PSguoob2sLGF83STGnDFtAoEdNbqPeRMY+yMpb5H6L
        BRbCYC/6FgtFi+CaoN7OZoTCocOjU254PgtRE7j/ZI7TyvQzIZGTxhv011aQbogpHK2+NPgbrZ2CG
        28vlTeokxESbZphf6xSl/3pP98yCYbom2UmIzBdJwqZB46NYKhe2FQkEBo6E1cherhPopJSSZmUw9
        EaJwuinjtJ0I5Br/ZrM0dw9+iUEdCbpS0iMpnsb3ebFrir8o/3I+OpIVZ3U33wWDJra3C+v1fLvgq
        pU/BDlAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqx-Om; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 25/56] f2fs: Convert invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:44 +0000
Message-Id: <20220209202215.2055748-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

This is a minimal change which just accepts the new arguments and passes
the single struct page to the functions which do the work.  There is
very little progress here toards making f2fs support large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/compress.c   |  2 +-
 fs/f2fs/data.c       | 22 ++++++++++------------
 fs/f2fs/f2fs.h       |  3 +--
 fs/f2fs/node.c       |  2 +-
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 982f0170639f..097d792723cb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -455,7 +455,7 @@ const struct address_space_operations f2fs_meta_aops = {
 	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
 	.set_page_dirty	= f2fs_set_meta_page_dirty,
-	.invalidatepage = f2fs_invalidate_page,
+	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 #ifdef CONFIG_MIGRATION
 	.migratepage    = f2fs_migrate_page,
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0c3aeba5945..ade5fbaf34f6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1750,7 +1750,7 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
 
 const struct address_space_operations f2fs_compress_aops = {
 	.releasepage = f2fs_release_page,
-	.invalidatepage = f2fs_invalidate_page,
+	.invalidate_folio = f2fs_invalidate_folio,
 };
 
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66a..3e16c25d96cb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3492,17 +3492,16 @@ static int f2fs_write_end(struct file *file,
 	return copied;
 }
 
-void f2fs_invalidate_page(struct page *page, unsigned int offset,
-							unsigned int length)
+void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
-		(offset % PAGE_SIZE || length != PAGE_SIZE))
+				(offset || length != folio_size(folio)))
 		return;
 
-	if (PageDirty(page)) {
+	if (folio_test_dirty(folio)) {
 		if (inode->i_ino == F2FS_META_INO(sbi)) {
 			dec_page_count(sbi, F2FS_DIRTY_META);
 		} else if (inode->i_ino == F2FS_NODE_INO(sbi)) {
@@ -3513,17 +3512,16 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		}
 	}
 
-	clear_page_private_gcing(page);
+	clear_page_private_gcing(&folio->page);
 
 	if (test_opt(sbi, COMPRESS_CACHE) &&
 			inode->i_ino == F2FS_COMPRESS_INO(sbi))
-		clear_page_private_data(page);
+		clear_page_private_data(&folio->page);
 
-	if (page_private_atomic(page))
-		return f2fs_drop_inmem_page(inode, page);
+	if (page_private_atomic(&folio->page))
+		return f2fs_drop_inmem_page(inode, &folio->page);
 
-	detach_page_private(page);
-	set_page_private(page, 0);
+	folio_detach_private(folio);
 }
 
 int f2fs_release_page(struct page *page, gfp_t wait)
@@ -3939,7 +3937,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.write_begin	= f2fs_write_begin,
 	.write_end	= f2fs_write_end,
 	.set_page_dirty	= f2fs_set_data_page_dirty,
-	.invalidatepage	= f2fs_invalidate_page,
+	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 	.direct_IO	= noop_direct_IO,
 	.bmap		= f2fs_bmap,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68b44015514f..cf31af917f38 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3661,8 +3661,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
 void f2fs_write_failed(struct inode *inode, loff_t to);
-void f2fs_invalidate_page(struct page *page, unsigned int offset,
-			unsigned int length);
+void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 int f2fs_release_page(struct page *page, gfp_t wait);
 #ifdef CONFIG_MIGRATION
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 50b2874e758c..803c2b55ce86 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2158,7 +2158,7 @@ const struct address_space_operations f2fs_node_aops = {
 	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
 	.set_page_dirty	= f2fs_set_node_page_dirty,
-	.invalidatepage	= f2fs_invalidate_page,
+	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= f2fs_migrate_page,
-- 
2.34.1

