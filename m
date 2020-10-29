Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605329F567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgJ2Te3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJ2TeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EEC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3hbUZbM6zGykKpCg4QK7R1IyrA2YegBa7tJLLyOCQP8=; b=p/v9M6wwP8wJfhOVYcSHALP0Io
        3ej4nUuX+G7NfN+JzKtFwVXYKBam//vH81nE63uNuDSeBOw5rj4OC224lElZqXsWNO64xOKWA8o6F
        IlDGD2L12OB1yA/v0dTtDxQfM2DdX61F3ztgR6qe0LVOSK1jDZJeXExzanTsNNPwmvlTMDkIDCHQF
        jO08whbEyiEI5CAPCZtDl5MC4VAbe7QPl2T6cSoV/wElmRuSXTWsy/ZFbqCvplBzncx9zl30DI8t1
        cXfYXtvBCBDiuDuCbux4HV+2XwCbTipydb+5yHYGR7r9qdQId48QcUKTafbUXV0us+YseE+osJHe0
        s3l/dKMg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgX-0007bu-IX; Thu, 29 Oct 2020 19:34:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 08/19] mm/filemap: Add __page_cache_alloc_order
Date:   Thu, 29 Oct 2020 19:33:54 +0000
Message-Id: <20201029193405.29125-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new function allows page cache pages to be allocated that are
larger than an order-0 page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/pagemap.h | 24 +++++++++++++++++++++---
 mm/filemap.c            | 16 ++++++++++------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 00288ed24698..bb6692001028 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -284,15 +284,33 @@ static inline void *detach_page_private(struct page *page)
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
+	return thp_prep(alloc_pages(thp_gfpmask(gfp), order));
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
index c0161f42f37d..64fe0018ee17 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -934,24 +934,28 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
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
 		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
-
-		return page;
+	} else {
+		page = alloc_pages(gfp, order);
 	}
-	return alloc_pages(gfp, 0);
+
+	return thp_prep(page);
 }
-EXPORT_SYMBOL(__page_cache_alloc);
+EXPORT_SYMBOL(__page_cache_alloc_order);
 #endif
 
 /*
-- 
2.28.0

