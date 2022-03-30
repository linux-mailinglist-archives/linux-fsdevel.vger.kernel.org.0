Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34084EC70F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbiC3OvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiC3OvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE515A1E
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oUK7oXFaNg0Jm/ZXRY8kIw11fNg913zOOY977g4EdL8=; b=DuCBWya6bqvmfJsIPXX5I2IJjO
        OJyb0Wy/Mn2M8WP+BFM0JoQvFX0EdI6MhLcIwKIcZs/DcTaEsbNxvJp1wodvgZCwh2eqXPoGWo6Mw
        4NMXeBAj5ZuBTKXcxOPVOYd27ZQ3R9lfNpjy50fbQ2mNqGRo96Jmw9ME7EDotIYIEHql3dBWFntQb
        +LbkCn/UYQC65svR/EsnSRs5Lxz/yOIbSSeqnOiXdy+f836V4zedYnM+vMHdaQbtXfI0BhYo+H3o5
        mB/uOgOX5efdOUgMYQPIsO+RRhRI2A1KIOVsiIPqFo9q6FXrdzphzbBJbv3nicMFyI/TwV4wRr7/T
        IsB4iOAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdb-001KCs-Np; Wed, 30 Mar 2022 14:49:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/12] readahead: Remove read_cache_pages()
Date:   Wed, 30 Mar 2022 15:49:19 +0100
Message-Id: <20220330144930.315951-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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

With no remaining users, remove this function and the related
infrastructure.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 --
 mm/readahead.c          | 76 -----------------------------------------
 2 files changed, 78 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8d0b327b066..993994cd943a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -752,8 +752,6 @@ struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, void *data);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
-extern int read_cache_pages(struct address_space *mapping,
-		struct list_head *pages, filler_t *filler, void *data);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, struct file *file)
diff --git a/mm/readahead.c b/mm/readahead.c
index d3a47546d17d..9097af639beb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,82 +142,6 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
-/*
- * see if a page needs releasing upon read_cache_pages() failure
- * - the caller of read_cache_pages() may have set PG_private or PG_fscache
- *   before calling, such as the NFS fs marking pages that are cached locally
- *   on disk, thus we need to give the fs a chance to clean up in the event of
- *   an error
- */
-static void read_cache_pages_invalidate_page(struct address_space *mapping,
-					     struct page *page)
-{
-	if (page_has_private(page)) {
-		if (!trylock_page(page))
-			BUG();
-		page->mapping = mapping;
-		folio_invalidate(page_folio(page), 0, PAGE_SIZE);
-		page->mapping = NULL;
-		unlock_page(page);
-	}
-	put_page(page);
-}
-
-/*
- * release a list of pages, invalidating them first if need be
- */
-static void read_cache_pages_invalidate_pages(struct address_space *mapping,
-					      struct list_head *pages)
-{
-	struct page *victim;
-
-	while (!list_empty(pages)) {
-		victim = lru_to_page(pages);
-		list_del(&victim->lru);
-		read_cache_pages_invalidate_page(mapping, victim);
-	}
-}
-
-/**
- * read_cache_pages - populate an address space with some pages & start reads against them
- * @mapping: the address_space
- * @pages: The address of a list_head which contains the target pages.  These
- *   pages have their ->index populated and are otherwise uninitialised.
- * @filler: callback routine for filling a single page.
- * @data: private data for the callback routine.
- *
- * Hides the details of the LRU cache etc from the filesystems.
- *
- * Returns: %0 on success, error return by @filler otherwise
- */
-int read_cache_pages(struct address_space *mapping, struct list_head *pages,
-			int (*filler)(void *, struct page *), void *data)
-{
-	struct page *page;
-	int ret = 0;
-
-	while (!list_empty(pages)) {
-		page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (add_to_page_cache_lru(page, mapping, page->index,
-				readahead_gfp_mask(mapping))) {
-			read_cache_pages_invalidate_page(mapping, page);
-			continue;
-		}
-		put_page(page);
-
-		ret = filler(data, page);
-		if (unlikely(ret)) {
-			read_cache_pages_invalidate_pages(mapping, pages);
-			break;
-		}
-		task_io_account_read(PAGE_SIZE);
-	}
-	return ret;
-}
-
-EXPORT_SYMBOL(read_cache_pages);
-
 static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		bool skip_page)
 {
-- 
2.34.1

