Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3A159FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBLESt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jC8GtqN7d2PIFCD2G3A5qYYZdOVd9+NyuF2giQfeE+o=; b=SnUC7w/yzeO9wGbmJ2fnvAHg89
        K5jXSIBNG58NYxIMnIxF21rJkwkCQYrEkore2fZNo1VJUUYPGzVtcNmb30mYaSZpvPQ1y9/HBi30Q
        ihriKwGl6uluD0O34tdvP28toUE4cDKNstqK9oF1csHhTMaTegIsCdmmbMEWx720j7RKCkLtDCBHl
        f/tImbi4SOkmns7CSo9mpGgVQ7cdb4s3Occ8ld3mmAe9XLVzNA6svmT5unVEozWJfcFLuqQowPSNN
        B+zKBDGLCj1zhTKXB6udltcwdAMlV3iQ2t8dhHlyZTvf3EpY/3GJYFEg+B3YuvLEwtecTbcOYSIkL
        /e4SD9XA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006op-CJ; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 21/25] mm: Add __page_cache_alloc_order
Date:   Tue, 11 Feb 2020 20:18:41 -0800
Message-Id: <20200212041845.25879-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This new function allows page cache pages to be allocated that are
larger than an order-0 page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/pagemap.h | 24 +++++++++++++++++++++---
 mm/filemap.c            | 12 ++++++++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 497197315b73..64a3cf79611f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -207,15 +207,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 	return __page_cache_add_speculative(page, count);
 }
 
+static inline gfp_t thp_gfpmask(gfp_t gfp)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/* We'd rather allocate smaller pages than stall a page fault */
+	gfp |= GFP_TRANSHUGE_LIGHT;
+	gfp &= ~__GFP_DIRECT_RECLAIM;
+#endif
+	return gfp;
+}
+
 #ifdef CONFIG_NUMA
-extern struct page *__page_cache_alloc(gfp_t gfp);
+extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order);
 #else
-static inline struct page *__page_cache_alloc(gfp_t gfp)
+static inline
+struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
 {
-	return alloc_pages(gfp, 0);
+	if (order == 0)
+		return alloc_pages(gfp, 0);
+	return prep_transhuge_page(alloc_pages(thp_gfpmask(gfp), order));
 }
 #endif
 
+static inline struct page *__page_cache_alloc(gfp_t gfp)
+{
+	return __page_cache_alloc_order(gfp, 0);
+}
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return __page_cache_alloc(mapping_gfp_mask(x));
diff --git a/mm/filemap.c b/mm/filemap.c
index 3204293f9b58..1061463a169e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -941,24 +941,28 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
 #ifdef CONFIG_NUMA
-struct page *__page_cache_alloc(gfp_t gfp)
+struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
 {
 	int n;
 	struct page *page;
 
+	if (order > 0)
+		gfp = thp_gfpmask(gfp);
+
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			page = __alloc_pages_node(n, gfp, 0);
+			page = __alloc_pages_node(n, gfp, order);
+			prep_transhuge_page(page);
 		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
 
 		return page;
 	}
-	return alloc_pages(gfp, 0);
+	return prep_transhuge_page(alloc_pages(gfp, order));
 }
-EXPORT_SYMBOL(__page_cache_alloc);
+EXPORT_SYMBOL(__page_cache_alloc_order);
 #endif
 
 /*
-- 
2.25.0

