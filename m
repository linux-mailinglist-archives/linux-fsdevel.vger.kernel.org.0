Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFB1D4EEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgEONSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB8C05BD16;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p4lv0+UmHnq6RBjJImhnJUw/ZMfw21W2VRJ0b1bCXuY=; b=sdW8qN5So8cJXAzWdPawX/KqO4
        NC9n6+aVddyFi1llwITFS6OvPB/oFzyVetFDa0is5DugdChYKM/6RsjpXxK7HEecJfYXDtBYmtYHZ
        4ZVJQupg5T1Iap6Yb/K0Qh7RRH35GlaRK+/nQkTpUmy3gT5z+qFb7htPJqjhfZpp5ldgrVvCJqez4
        PDwhwMgqLQhkivacvTdoNazVglQD0u9kNWen4w7rqu7S6IYHZxwf163UnWxTcE7sajpQ+B69ehpCX
        AuEfSHzvj0YqVdCK5M98/W5zwTFGA5Fun7yhBRX6HJykToXUW3IjZm2cM11+UNM4OvuF5cZnU88C2
        AHMtl14A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCz-0005hF-Sl; Fri, 15 May 2020 13:17:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v4 21/36] mm: Add __page_cache_alloc_order
Date:   Fri, 15 May 2020 06:16:41 -0700
Message-Id: <20200515131656.12890-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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
index c75d7fb7ccbc..97f36ea16116 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -239,15 +239,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
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

