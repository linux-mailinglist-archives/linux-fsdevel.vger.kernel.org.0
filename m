Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC121F5CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgFJUPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6874C03E96B;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GYkASM4BgicRB6qQw/ipKWc7P4OsD4qqbRXZJoBJj2A=; b=fZ2qNCLZY8A3ORQkyJtDxInaEG
        Ecup0o0tQdAskbPlcKAGJkERx1rVwDVpliXE0v56sOxSjvNkNJfecQ3fVI58HSMbEXzGNKOdBif3G
        DXv8jO2AifgU8NIxn1NHR75q907XSarxq4GYn0ljEUeXXRRH2uVyC9ouBMtk3HWOWFhdJKjmh5XBl
        MlZyubcdGQ69V9DNZj48RpjKvCg3Oi69Hv2gSpQc+SUwkcQXvWTQu4CfFKgVQoMuBFxVCWufXTOsZ
        h/Hl+P38eVcPsrviQQgN1txwem/H/6DkT+MZrF0J7Za5Edimj9JmwlOCN09qAxpYv0TOgmM7kvrUO
        yp8bAmgw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Wa-LC; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 34/51] mm: Add __page_cache_alloc_order
Date:   Wed, 10 Jun 2020 13:13:28 -0700
Message-Id: <20200610201345.13273-35-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
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
index f47ba9f18f3e..8455a3e16900 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -280,15 +280,33 @@ static inline void *detach_page_private(struct page *page)
 	return data;
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
index 80ce3658b147..3a9579a1ffa7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -938,24 +938,28 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
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
2.26.2

