Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61380496E0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 21:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiAVUzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiAVUzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:55:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B2C06173B;
        Sat, 22 Jan 2022 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iXm/SEnRj/IstqLKJF/I7hjBxEi6Cnt+RUd9JyetrNA=; b=iF5IToi1g3OV99Ypdg5G7BOFw+
        kTHOKbKOUPwgLqoxc4lzMRnYbCo7qdFkPVt9GjAa1iexy1sZxLM6T+OBNCMjDGs2zeewKeETxvgFj
        emZNAuuchxoEze/Z72ZtEmWNiqbhlqIbh05j5f2K7dmVjT57mrcF8hacuYIaUfN33rUSvjeiFxx6r
        ZnD2VuwY4YJfq3DTjkXR1q9BlwMLupVjlwVMkTuiBLlJmiHpDqCr7PWNIP+OvbIMjMUu2ixMjOL0f
        0Sui15XGxY02agKyZ7yK00NQbXmbx/kfq4uEAp32daYS1LzD/Q4qfPQdcAKAropyZAgI+BJA0GmHM
        awb0cwIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBNPW-00GblE-09; Sat, 22 Jan 2022 20:54:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] readahead: Remove read_cache_pages()
Date:   Sat, 22 Jan 2022 20:54:53 +0000
Message-Id: <20220122205453.3958181-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220122205453.3958181-1-willy@infradead.org>
References: <20220122205453.3958181-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

