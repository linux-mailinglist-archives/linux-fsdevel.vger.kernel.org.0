Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8A53DDE5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbiFETjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbiFETjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424061181A;
        Sun,  5 Jun 2022 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eM6uKV+5ElE/ut/Cuc850ZV6AcTLZYIP033Wzko7MpA=; b=jw54R9vR5RZy9/he5CXHQlyFzw
        WYLQMbziLOy2S6/zd4nVgc2UPNgndelLoDnOz9B0h2hq2awUcQeux+YLGTLUOy6yY88ojJb4VqImT
        BdJhOFHQIHogBZx79rFympvKsdcS00RpUDNLrO41Q1KgQnJ3iFBBK9/ycC49M6c9x0ilXYsgzTFjq
        4M2AynY09RE7pLDC7wNMqh6uUkgDO0cK8SU9nOwxTGqhdbe51uxm7r4dsSqEZYp+pFoAmUhNlFnfR
        XUA+CO9svYVg4sD4a0sRDrWreBBx8ExZjOsvyFZpDcKYT7mvMK0NVRy7GTxV1W17OgLNV7TCmPpzI
        BHlN4vrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxw5R-009wsb-2q; Sun, 05 Jun 2022 19:38:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 07/10] nilfs2: Convert nilfs_copy_back_pages() to use filemap_get_folios()
Date:   Sun,  5 Jun 2022 20:38:51 +0100
Message-Id: <20220605193854.2371230-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/page.c | 60 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index a8e88cc38e16..3267e96c256c 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -294,57 +294,57 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 void nilfs_copy_back_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i, n;
-	pgoff_t index = 0;
+	pgoff_t start = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	n = pagevec_lookup(&pvec, smap, &index);
+	n = filemap_get_folios(smap, &start, ~0UL, &fbatch);
 	if (!n)
 		return;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
-		pgoff_t offset = page->index;
-
-		lock_page(page);
-		dpage = find_lock_page(dmap, offset);
-		if (dpage) {
-			/* overwrite existing page in the destination cache */
-			WARN_ON(PageDirty(dpage));
-			nilfs_copy_page(dpage, page, 0);
-			unlock_page(dpage);
-			put_page(dpage);
-			/* Do we not need to remove page from smap here? */
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
+		pgoff_t index = folio->index;
+
+		folio_lock(folio);
+		dfolio = filemap_lock_folio(dmap, index);
+		if (dfolio) {
+			/* overwrite existing folio in the destination cache */
+			WARN_ON(folio_test_dirty(dfolio));
+			nilfs_copy_page(&dfolio->page, &folio->page, 0);
+			folio_unlock(dfolio);
+			folio_put(dfolio);
+			/* Do we not need to remove folio from smap here? */
 		} else {
-			struct page *p;
+			struct folio *f;
 
-			/* move the page to the destination cache */
+			/* move the folio to the destination cache */
 			xa_lock_irq(&smap->i_pages);
-			p = __xa_erase(&smap->i_pages, offset);
-			WARN_ON(page != p);
+			f = __xa_erase(&smap->i_pages, index);
+			WARN_ON(folio != f);
 			smap->nrpages--;
 			xa_unlock_irq(&smap->i_pages);
 
 			xa_lock_irq(&dmap->i_pages);
-			p = __xa_store(&dmap->i_pages, offset, page, GFP_NOFS);
-			if (unlikely(p)) {
+			f = __xa_store(&dmap->i_pages, index, folio, GFP_NOFS);
+			if (unlikely(f)) {
 				/* Probably -ENOMEM */
-				page->mapping = NULL;
-				put_page(page);
+				folio->mapping = NULL;
+				folio_put(folio);
 			} else {
-				page->mapping = dmap;
+				folio->mapping = dmap;
 				dmap->nrpages++;
-				if (PageDirty(page))
-					__xa_set_mark(&dmap->i_pages, offset,
+				if (folio_test_dirty(folio))
+					__xa_set_mark(&dmap->i_pages, index,
 							PAGECACHE_TAG_DIRTY);
 			}
 			xa_unlock_irq(&dmap->i_pages);
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	goto repeat;
-- 
2.35.1

