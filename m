Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCA6C8465
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjCXSDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCXSC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5642ABDEA;
        Fri, 24 Mar 2023 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cqYywlF2Q8R7QGX+jBw+CyvKUU8XyfAKGjEliwwm+0k=; b=O+Seyi/tLmdWgO7M8pqpiZ/QKQ
        QEQNVi1tSvPg/yRwLy3E11c6JSUPKauXGBHlksxQ4R7HOySGc8u2FLySj02+UKCanOLdZiw+5COi7
        b0rXSP+d4ec+gZHoRzHvFCPgiPXAgdgnCCqvIEzc0NYy+HS6F09L4xBfV4cB9iNwP3n1eOos94C2Q
        51qB9NkG1hcUJIKymEROE71kGcqyfNgfl5uxa12lJ/ACONOMLBw5Epf6BAYqlfgMnqd2aWTySiZtw
        ShZ8Z/6kDysO2BrpbF1s9KytGb3WUmr4d8JVPA0BstlO1jvbLRG6iWBNRezFc7AoHc/OLA2B1meSt
        JpMS3JLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljO-0057bv-Fq; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 27/29] ext4: Convert mext_page_mkuptodate() to take a folio
Date:   Fri, 24 Mar 2023 18:01:27 +0000
Message-Id: <20230324180129.1220691-28-willy@infradead.org>
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

Use a folio throughout.  Does not support large folios due to
an array sized for MAX_BUF_PER_PAGE, but it does remove a few
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index a84a794fed56..b5af2fc03b2f 100644
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
2.39.2

