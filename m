Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9575267D649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjAZUYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjAZUY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B24996E;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5jhXruLPTjV4jnzqjiicBJgcR5CbK9TLgTzbBD00gmc=; b=SSOfATmVX8WNvGThd35CmIdYxk
        OzU3I/25ZUHoVg9S9Wlw3GVzh2rCS0zlKTrgXzs4eaPr2yVKSVMHx4QEgf7AjXEzUlgeVNfVDnPkA
        vWHJNVi5F19ypT/9KfrcJ0RhTDxUegCB85FMDAqi+tpVJZi7O+zuhCSKHnwkH2tRO1MO4sL2wkG/X
        JdL88xvD0Ly41ypc5SpizaHHxCMVHqAFE24lh40Zd98O/xRjUPXxHHExGg1JoOgLp5NnL0JyIJTNo
        WUMWvo4yD8GULSIQbtYSv3dYLNy+NbAaw+zlPK6rYvEzS4Ahommaup1sRAsX4IaN0OjrCkHJm6Bfk
        GD7eYcEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073m3-Tt; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 29/31] ext4: Convert mext_page_mkuptodate() to take a folio
Date:   Thu, 26 Jan 2023 20:24:13 +0000
Message-Id: <20230126202415.1682629-30-willy@infradead.org>
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

Use a folio throughout.  Does not support large folios due to
an array sized for MAX_BUF_PER_PAGE, but it does remove a few
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0cb361f0a4fe..e509c22a21ed 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -168,25 +168,27 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 
 /* Force page buffers uptodate w/o dropping page's lock */
 static int
-mext_page_mkuptodate(struct page *page, unsigned from, unsigned to)
+mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	sector_t block;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, block_start, block_end;
 	int i, err,  nr = 0, partial = 0;
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
+	BUG_ON(!folio_test_locked(folio));
+	BUG_ON(folio_test_writeback(folio));
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return 0;
 
 	blocksize = i_blocksize(inode);
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
+	head = folio_buffers(folio);
+	if (!head) {
+		create_empty_buffers(&folio->page, blocksize, 0);
+		head = folio_buffers(folio);
+	}
 
-	head = page_buffers(page);
-	block = (sector_t)page->index << (PAGE_SHIFT - inode->i_blkbits);
+	block = (sector_t)folio->index << (PAGE_SHIFT - inode->i_blkbits);
 	for (bh = head, block_start = 0; bh != head || !block_start;
 	     block++, block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
@@ -200,11 +202,11 @@ mext_page_mkuptodate(struct page *page, unsigned from, unsigned to)
 		if (!buffer_mapped(bh)) {
 			err = ext4_get_block(inode, block, bh, 0);
 			if (err) {
-				SetPageError(page);
+				folio_set_error(folio);
 				return err;
 			}
 			if (!buffer_mapped(bh)) {
-				zero_user(page, block_start, blocksize);
+				folio_zero_range(folio, block_start, blocksize);
 				set_buffer_uptodate(bh);
 				continue;
 			}
@@ -226,7 +228,7 @@ mext_page_mkuptodate(struct page *page, unsigned from, unsigned to)
 	}
 out:
 	if (!partial)
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	return 0;
 }
 
@@ -354,7 +356,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		goto unlock_folios;
 	}
 data_copy:
-	*err = mext_page_mkuptodate(&folio[0]->page, from, from + replaced_size);
+	*err = mext_page_mkuptodate(folio[0], from, from + replaced_size);
 	if (*err)
 		goto unlock_folios;
 
-- 
2.35.1

