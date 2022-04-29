Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B35151F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379692AbiD2RaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379556AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985FFA27F2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EmS/g/wfHHe+anzEX7PHJ19CY4ZCLaPDaACn1QgK1iU=; b=hy/zC0CK9Q2Gt/qnmTeg1wNkuu
        mEoqlfT3FNEUAUpv0J0L9iKMWzd9bOmZNjXm38lFxc2IeFDK6UffiuReoTbMsPk68+dfa42TsYiSG
        83vILfX3z4GilEFeySuhWuwdvX4a6Dha/v8qX4/CxuehSksmigOrIvfrWeHN3djHNtQ0KLwkFVi/a
        3RO9sY4OXZF6sMMicSJ0HBOx5zOlOe1HMhYsC5wyG4+1GGYgi3qOzml+Eho29bwnjihJwb4VLsfBV
        18loEYSvwtxHt7e027L/xPagha8Y16Pwh2zJ68RAGxf2UWBfY7pVX6prlME3B2gvTM62NTRzDRUO0
        ze1OxNxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdao-DO; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 43/69] btrfs: Convert btrfs to read_folio
Date:   Fri, 29 Apr 2022 18:25:30 +0100
Message-Id: <20220429172556.3011843-44-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/ctree.h            | 2 +-
 fs/btrfs/file.c             | 7 ++++---
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/inode.c            | 7 ++++---
 fs/btrfs/ioctl.c            | 2 +-
 fs/btrfs/relocation.c       | 8 ++++----
 fs/btrfs/send.c             | 2 +-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 077c95e9baa5..8d4b5edd4059 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3269,7 +3269,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
-int btrfs_readpage(struct file *file, struct page *page);
+int btrfs_read_folio(struct file *file, struct folio *folio);
 void btrfs_evict_inode(struct inode *inode);
 int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 380054c94e4b..57fba5abb059 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1307,11 +1307,12 @@ static int prepare_uptodate_page(struct inode *inode,
 				 struct page *page, u64 pos,
 				 bool force_uptodate)
 {
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 
 	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
 	    !PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
+		ret = btrfs_read_folio(NULL, folio);
 		if (ret)
 			return ret;
 		lock_page(page);
@@ -1321,7 +1322,7 @@ static int prepare_uptodate_page(struct inode *inode,
 		}
 
 		/*
-		 * Since btrfs_readpage() will unlock the page before it
+		 * Since btrfs_read_folio() will unlock the folio before it
 		 * returns, there is a window where btrfs_releasepage() can be
 		 * called to release the page.  Here we check both inode
 		 * mapping and PagePrivate() to make sure the page was not
@@ -2401,7 +2402,7 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = filp->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
 	file_accessed(filp);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 01a408db5683..829a414a7ecb 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -465,7 +465,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 
 		io_ctl->pages[i] = page;
 		if (uptodate && !PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_read_folio(NULL, page_folio(page));
 			lock_page(page);
 			if (page->mapping != inode->i_mapping) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1c8a43ecfb9f..34d452d350d6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4725,7 +4725,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		goto out_unlock;
 
 	if (!PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
+		ret = btrfs_read_folio(NULL, page_folio(page));
 		lock_page(page);
 		if (page->mapping != mapping) {
 			unlock_page(page);
@@ -8124,8 +8124,9 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
-int btrfs_readpage(struct file *file, struct page *page)
+int btrfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
@@ -11368,7 +11369,7 @@ static const struct file_operations btrfs_dir_file_operations = {
  * For now we're avoiding this by dropping bmap.
  */
 static const struct address_space_operations btrfs_aops = {
-	.readpage	= btrfs_readpage,
+	.read_folio	= btrfs_read_folio,
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be6c24577dbe..8d0c4d23b743 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1359,7 +1359,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
 	 * make it uptodate.
 	 */
 	if (!PageUptodate(page)) {
-		btrfs_readpage(NULL, page);
+		btrfs_read_folio(NULL, page_folio(page));
 		lock_page(page);
 		if (page->mapping != mapping || !PagePrivate(page)) {
 			unlock_page(page);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9ae06895ffc9..fb16c484bbae 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1101,7 +1101,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 			continue;
 
 		/*
-		 * if we are modifying block in fs tree, wait for readpage
+		 * if we are modifying block in fs tree, wait for read_folio
 		 * to complete and drop the extent cache
 		 */
 		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
@@ -1563,7 +1563,7 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 			end = (u64)-1;
 		}
 
-		/* the lock_extent waits for readpage to complete */
+		/* the lock_extent waits for read_folio to complete */
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 1);
 		unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
@@ -2818,7 +2818,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		 * Subpage can't handle page with DIRTY but without UPTODATE
 		 * bit as it can lead to the following deadlock:
 		 *
-		 * btrfs_readpage()
+		 * btrfs_read_folio()
 		 * | Page already *locked*
 		 * |- btrfs_lock_and_flush_ordered_range()
 		 *    |- btrfs_start_ordered_extent()
@@ -2972,7 +2972,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 				last_index + 1 - page_index);
 
 	if (!PageUptodate(page)) {
-		btrfs_readpage(NULL, page);
+		btrfs_read_folio(NULL, page_folio(page));
 		lock_page(page);
 		if (!PageUptodate(page)) {
 			ret = -EIO;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b327dbe0cbf5..8985d115559d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4991,7 +4991,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_read_folio(NULL, page_folio(page));
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
-- 
2.34.1

