Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5572D185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjFLVGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbjFLVEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0473198E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2Apa5O6YVLHPRKl9QPRk82tyPcbf0XN1bONDIYMH1qM=; b=SPBewS9f90gD3t2ehpHzyHC5jk
        MrXkZpDRr0aX4N8XgalvgYQ41/WILwB6oARPP+Gw0nUsGJx/0l6i58Xg2isoM7Z0mCj6dhsn1Qw5M
        6UJvq8rS8AjLT5aDiXls7WLcBYwP4rGwdGUD797Pu2e5x+bSnbG2spdBIuhzeaTgkvQCNWUfxjohV
        ZRmneuYjuh7bdNJWYNbDtIa6Rhz586GJ2F+JXXbyd7vhaYjzAarVEMr8Ex4h3JIpeh2fC51K4p+9s
        aO6F+tB6tEqaW2ywcMofb7pmvgKlXc17Dn2pqSRN0fGVkFDZnIIPPQtWhQXwkX0XAO7HRdm86vA9f
        X3ehGkHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofY-0033xW-AV; Mon, 12 Jun 2023 21:01:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 14/14] buffer: Convert block_truncate_page() to use a folio
Date:   Mon, 12 Jun 2023 22:01:41 +0100
Message-Id: <20230612210141.730128-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
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

Support large folios in block_truncate_page() and avoid three hidden
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c38fdcaa32ff..5a5b0c9d9769 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2598,17 +2598,16 @@ int block_truncate_page(struct address_space *mapping,
 			loff_t from, get_block_t *get_block)
 {
 	pgoff_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (PAGE_SIZE-1);
 	unsigned blocksize;
 	sector_t iblock;
-	unsigned length, pos;
+	size_t offset, length, pos;
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	int err = 0;
 
 	blocksize = i_blocksize(inode);
-	length = offset & (blocksize - 1);
+	length = from & (blocksize - 1);
 
 	/* Block boundary? Nothing to do */
 	if (!length)
@@ -2617,15 +2616,18 @@ int block_truncate_page(struct address_space *mapping,
 	length = blocksize - length;
 	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
 	
-	page = grab_cache_page(mapping, index);
-	if (!page)
+	folio = filemap_grab_folio(mapping, index);
+	if (!folio)
 		return -ENOMEM;
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
+	bh = folio_buffers(folio);
+	if (!bh) {
+		folio_create_empty_buffers(folio, blocksize, 0);
+		bh = folio_buffers(folio);
+	}
 
 	/* Find the buffer that contains "offset" */
-	bh = page_buffers(page);
+	offset = offset_in_folio(folio, from);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
@@ -2644,7 +2646,7 @@ int block_truncate_page(struct address_space *mapping,
 	}
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
@@ -2654,12 +2656,12 @@ int block_truncate_page(struct address_space *mapping,
 			goto unlock;
 	}
 
-	zero_user(page, offset, length);
+	folio_zero_range(folio, offset, length);
 	mark_buffer_dirty(bh);
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return err;
 }
-- 
2.39.2

