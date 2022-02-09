Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAE4AFE62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiBIUXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C652EE03A553
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CnqadxJ+B85CZzCbB0p/O5+dZITDTh3qP9crbveHjbI=; b=sUXVcG+0ovD5vH4a6jioAb0ZPe
        8AP+hIL0zYrr3x86PnRuSDjBVYXk7B9FeDrfkJIo86OkrzwWLjIwzKvi5LfvcVNvDnBcXJHzOH8Kg
        /y0mtc3zcERr/T0JEvnVGtigHcjDvvDsVecRS/VehihlKUhOEsEafRnsvdFEVEQQXPeRqB/3ejJXz
        nN7CzGVSjYfOOKIdIlZBB1Be92NNJo2I33UnImnVTcUTkKkCzFNkzfX2NwPBxZ0uRhrD3MAxNLNOE
        ir1MhMThtSdZTfTQQBSjk3Bjkg1eue79oHCxfADIvTJFtuvTXTWtqAfSa5zy1HPUX613gFH4dYwPU
        iOAM0t6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008ctI-Oi; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 48/56] f2fs: Convert f2fs_set_data_page_dirty to f2fs_dirty_data_folio
Date:   Wed,  9 Feb 2022 20:22:07 +0000
Message-Id: <20220209202215.2055748-49-willy@infradead.org>
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

Removes several calls to __set_page_dirty_nobuffers().  Also turn the
PageSwapCache() case into a BUG() as there's no way for a swapcache page
to make it to a filesystem that doesn't use SWP_FS_OPS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 34 +++++++++++++++++-----------------
 fs/f2fs/f2fs.h       |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 49100ae0c17f..17655f6e8eb8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1015,7 +1015,7 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
-void f2fs_update_dirty_page(struct inode *inode, struct page *page)
+void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
@@ -1030,7 +1030,7 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
 	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->inode_lock[type]);
 
-	set_page_private_reference(page);
+	set_page_private_reference(&folio->page);
 }
 
 void f2fs_remove_dirty_inode(struct inode *inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3e16c25d96cb..6330be19a973 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3548,35 +3548,35 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	return 1;
 }
 
-static int f2fs_set_data_page_dirty(struct page *page)
+static bool f2fs_dirty_data_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = mapping->host;
 
-	trace_f2fs_set_page_dirty(page, DATA);
+	trace_f2fs_set_page_dirty(&folio->page, DATA);
 
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
-	if (PageSwapCache(page))
-		return __set_page_dirty_nobuffers(page);
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
+	BUG_ON(folio_test_swapcache(folio));
 
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
-		if (!page_private_atomic(page)) {
-			f2fs_register_inmem_page(inode, page);
-			return 1;
+		if (!page_private_atomic(&folio->page)) {
+			f2fs_register_inmem_page(inode, &folio->page);
+			return true;
 		}
 		/*
 		 * Previously, this page has been registered, we just
 		 * return here.
 		 */
-		return 0;
+		return false;
 	}
 
-	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
-		f2fs_update_dirty_page(inode, page);
-		return 1;
+	if (!folio_test_dirty(folio)) {
+		filemap_dirty_folio(mapping, folio);
+		f2fs_update_dirty_folio(inode, folio);
+		return true;
 	}
-	return 0;
+	return true;
 }
 
 
@@ -3936,7 +3936,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.writepages	= f2fs_write_data_pages,
 	.write_begin	= f2fs_write_begin,
 	.write_end	= f2fs_write_end,
-	.set_page_dirty	= f2fs_set_data_page_dirty,
+	.dirty_folio	= f2fs_dirty_data_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 	.direct_IO	= noop_direct_IO,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cf31af917f38..51ba0f8ffd86 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3597,7 +3597,7 @@ void f2fs_add_orphan_inode(struct inode *inode);
 void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
-void f2fs_update_dirty_page(struct inode *inode, struct page *page);
+void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
 void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
-- 
2.34.1

