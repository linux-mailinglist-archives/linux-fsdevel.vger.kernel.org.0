Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8598A5151E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379617AbiD2R3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379535AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14162A145F
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oltpZnUdWxXe1PX5MIFD6kGux3W85Rmiqb/miN+Kgrc=; b=oYzDPOPTsm3kfRBFTeufi+HpF0
        W6KaCTYcF+642LBzwq1wZVaTjVkrhlf47iNfCj4HDXbr52IFaabO91bErQWL9Wn/COm1wwOQL7I1Y
        D+2jFmyqFDi0t3UB8HJ1CBUTTVFEA3Qytv3HYf2lLdqZ7D0wUVGv2NBVKntR3p1cAMajQNC2AFdte
        x+twqreIC0y0N/zEiRsxsWj0950xhJFuP2i8frIacp1l6DsunrXK7+iE6qs74ITf7Plu8R2vIAmx9
        wxl8JeytRbU6UAAGpVxskWMZAhyTR2mJnTf+KAt86Chf/Lgmw/E5bO7eCZX4j51D0582/riGeKxwM
        JWMFiJAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00CdZl-2i; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 32/69] buffer: Rewrite nobh_truncate_page() to use folios
Date:   Fri, 29 Apr 2022 18:25:19 +0100
Message-Id: <20220429172556.3011843-33-willy@infradead.org>
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

 - Calculate iblock directly instead of using a while loop
 - Move has_buffers to the end to remove a backwards jump
 - Use __filemap_get_folio() instead of grab_cache_page(), which
   removes a spurious FGP_ACCESSED flag.
 - Eliminate length and pos variables
 - Use folio APIs where they exist

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 64 ++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index fb4df259c92d..9737e0dbe3ec 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2791,44 +2791,28 @@ int nobh_truncate_page(struct address_space *mapping,
 			loff_t from, get_block_t *get_block)
 {
 	pgoff_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (PAGE_SIZE-1);
-	unsigned blocksize;
-	sector_t iblock;
-	unsigned length, pos;
 	struct inode *inode = mapping->host;
-	struct page *page;
+	unsigned blocksize = i_blocksize(inode);
+	struct folio *folio;
 	struct buffer_head map_bh;
+	size_t offset;
+	sector_t iblock;
 	int err;
 
-	blocksize = i_blocksize(inode);
-	length = offset & (blocksize - 1);
-
 	/* Block boundary? Nothing to do */
-	if (!length)
+	if (!(from & (blocksize - 1)))
 		return 0;
 
-	length = blocksize - length;
-	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
-
-	page = grab_cache_page(mapping, index);
+	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_CREAT,
+			mapping_gfp_mask(mapping));
 	err = -ENOMEM;
-	if (!page)
+	if (!folio)
 		goto out;
 
-	if (page_has_buffers(page)) {
-has_buffers:
-		unlock_page(page);
-		put_page(page);
-		return block_truncate_page(mapping, from, get_block);
-	}
-
-	/* Find the buffer that contains "offset" */
-	pos = blocksize;
-	while (offset >= pos) {
-		iblock++;
-		pos += blocksize;
-	}
+	if (folio_buffers(folio))
+		goto has_buffers;
 
+	iblock = from >> inode->i_blkbits;
 	map_bh.b_size = blocksize;
 	map_bh.b_state = 0;
 	err = get_block(inode, iblock, &map_bh, 0);
@@ -2839,29 +2823,35 @@ int nobh_truncate_page(struct address_space *mapping,
 		goto unlock;
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (!PageUptodate(page)) {
-		err = mapping->a_ops->readpage(NULL, page);
+	if (!folio_test_uptodate(folio)) {
+		err = mapping->a_ops->readpage(NULL, &folio->page);
 		if (err) {
-			put_page(page);
+			folio_put(folio);
 			goto out;
 		}
-		lock_page(page);
-		if (!PageUptodate(page)) {
+		folio_lock(folio);
+		if (!folio_test_uptodate(folio)) {
 			err = -EIO;
 			goto unlock;
 		}
-		if (page_has_buffers(page))
+		if (folio_buffers(folio))
 			goto has_buffers;
 	}
-	zero_user(page, offset, length);
-	set_page_dirty(page);
+	offset = offset_in_folio(folio, from);
+	folio_zero_segment(folio, offset, round_up(offset, blocksize));
+	folio_mark_dirty(folio);
 	err = 0;
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 out:
 	return err;
+
+has_buffers:
+	folio_unlock(folio);
+	folio_put(folio);
+	return block_truncate_page(mapping, from, get_block);
 }
 EXPORT_SYMBOL(nobh_truncate_page);
 
-- 
2.34.1

