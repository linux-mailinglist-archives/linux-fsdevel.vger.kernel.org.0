Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F254AFE38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiBIUWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D6E039C4E
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iXm/SEnRj/IstqLKJF/I7hjBxEi6Cnt+RUd9JyetrNA=; b=fAHiaPCR7BfjqFgNLWPD9sR0zq
        mmbvNWOUY/tRrrxqA3q8y0HxUAIiFLEZyU9UNH4HfpG0+RSJ7mSVj+m81odO7s6zxBd+FakBfdBEj
        f1qs+sD5LyvBFRadQulyHrrxS6mM3p/KpFsXYvTU/a1Eb8LU0uMo6+dQTruJTmmykaA9rVfczmiFS
        cpNqBilwa0QpSk/JpcpcigjwdmcaBLelHjwU6+oLFvfu21O4uDINv6/5YQgpT5JWbaN8NUyymBZvy
        lYgQhA//pHVqGjmPOl/Rb5r2X173CtNNDlBTXmyPr7feViKcpLMcfBviTe4jX1OwWN9GykzXiL4mg
        kIY55maA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTq-008cov-In; Wed, 09 Feb 2022 20:22:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/56] readahead: Remove read_cache_pages()
Date:   Wed,  9 Feb 2022 20:21:21 +0000
Message-Id: <20220209202215.2055748-3-willy@infradead.org>
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

With no remaining users, remove this function and the related
infrastructure.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 --
 mm/readahead.c          | 76 -----------------------------------------
 2 files changed, 78 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 270bf5136c34..34682f001344 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -632,8 +632,6 @@ struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, void *data);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
-extern int read_cache_pages(struct address_space *mapping,
-		struct list_head *pages, filler_t *filler, void *data);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
diff --git a/mm/readahead.c b/mm/readahead.c
index cf0dcf89eb69..7ba979bf8af3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -37,82 +37,6 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
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
-		do_invalidatepage(page, 0, PAGE_SIZE);
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

