Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4C1E734D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbgE2DDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391654AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4870C08C5CB;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fV6a9kwthzjvn5H6mEGqGNxUtAaq0B1mGHrdSJDwklg=; b=JpbI2/sxTNs//d6hRF9iKbeMCb
        LPdoIRuHkVCb+KWB3mg2gB7mXCFBbaa01lhVGF/CINPT1XOW2B7f8Nrf6FLgaX4dDG2xRWaNkq88B
        N0TevVW/JVqKL+zL0IHXUnm1e+iWZfgaVbYtm1igV4fotSZL7NdcK28Or6lEv1+18y98rOvbLhcHh
        GdatuViVlp7n+oJlu8lKJtL/8HQCv2UOB4Jz/zZltmSrJHm6faSqwSa7IERXaHyNO5pjY8Fwqyy9W
        Fzah3oQOXNaUmjx0oi/RnV31Ayz7NsPc1CJglMegHg+vtQDBl4n7H74ZtrUb9NVbKh4l/ngMOeyka
        MYRnTVaQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008S7-DT; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v5 22/39] mm: Add __page_cache_alloc_order
Date:   Thu, 28 May 2020 19:58:07 -0700
Message-Id: <20200529025824.32296-23-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
index 612f6f090d0f..0b4a4b62b585 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -240,15 +240,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
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
index 23a051a7ef0f..9abba062973a 100644
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
2.26.2

