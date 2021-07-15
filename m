Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767533CAE03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhGOUjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhGOUjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:39:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84779C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/RBw1G6aqidiNyQkusPUaUFes9i2dAFqf9U2SC2zdc4=; b=bjvGeaCrwN/oKtJE7CfNEf4W+f
        5TgQ2WP/iHuD3Q1R5J4bST8LhKON7nlqRiioxEB3MKz2qhZvScLlK6E/7VBjE5VYV6J7B8OUk/zsA
        t8PwjxWnzqNb3A0i5Ne+0cXFp6GLWXOj9MoSplnsjGsqlfB0b842oxiiyDec+JOg+2AnlOECWUCAw
        R5Np3cr3MihtOCLCgemIX/FxKnICAw09U57pexMj4Q6Ef0oNguPZ6H74I8P2L6KoHbGvp+qlMMy+g
        /CGDdSldy+ZD62zSUc/tj+nARLWfDhDwilvFS/UzGp+J0RNRXVMEl1gU9BiQyHJjDL++AQuqIMJEN
        csO4Zv/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m484Z-003qIA-UE; Thu, 15 Jul 2021 20:35:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 35/39] mm/filemap: Add filemap_alloc_folio
Date:   Thu, 15 Jul 2021 21:00:26 +0100
Message-Id: <20210715200030.899216-36-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement __page_cache_alloc as a wrapper around filemap_alloc_folio
to allow filesystems to be converted at our leisure.  Increases
kernel text size by 133 bytes, mostly in cachefiles_read_backing_file().
pagecache_get_page() shrinks by 32 bytes, though.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 11 ++++++++---
 mm/filemap.c            | 14 +++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bd4daebaf70e..848acb44ac80 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -262,14 +262,19 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-extern struct page *__page_cache_alloc(gfp_t gfp);
+struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-static inline struct page *__page_cache_alloc(gfp_t gfp)
+static inline struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
 {
-	return alloc_pages(gfp, 0);
+	return folio_alloc(gfp, order);
 }
 #endif
 
+static inline struct page *__page_cache_alloc(gfp_t gfp)
+{
+	return &filemap_alloc_folio(gfp, 0)->page;
+}
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return __page_cache_alloc(mapping_gfp_mask(x));
diff --git a/mm/filemap.c b/mm/filemap.c
index 6bec995e69bd..54989a32d6a8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -989,24 +989,24 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
 #ifdef CONFIG_NUMA
-struct page *__page_cache_alloc(gfp_t gfp)
+struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
 {
 	int n;
-	struct page *page;
+	struct folio *folio;
 
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			page = __alloc_pages_node(n, gfp, 0);
-		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
+			folio = __folio_alloc_node(gfp, order, n);
+		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
-		return page;
+		return folio;
 	}
-	return alloc_pages(gfp, 0);
+	return folio_alloc(gfp, order);
 }
-EXPORT_SYMBOL(__page_cache_alloc);
+EXPORT_SYMBOL(filemap_alloc_folio);
 #endif
 
 /*
-- 
2.30.2

