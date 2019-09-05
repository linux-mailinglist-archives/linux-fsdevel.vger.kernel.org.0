Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12523AAAD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbfIESXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:23:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389837AbfIESXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tXdc4iXzoXHU6OjGWpZjE6sWjkGFF7V5SHiPuHEFbCs=; b=Gpl9LKCwzm4apXNKWlvcBoujeM
        PczdnpXwPrCTloQ/JcvJKN8U2YuahJIfrkP4L9cUTYB3V1ZoPBSrWxAJyzoTsIj0+uDx5oS+h2CTC
        9WMsyr8KX2eDDyjkltgxe8psNHJRdUKtp45khXvYjgtXRbqbQtAXCH5jPgQ/sPHMHrJbuEUclg3da
        lBLNtjsLsfv2I8xEU3XAITOWeji5QqdmivrHTMv0HJVopIqdALlSG1fBQeTkNv/dwEzCdz/eZW5Xa
        AzDyQykKBt5d7ufUxG0MM1zraic1i+RhB8ub0KKJOYa8lnpwR+CGQRubsYGvcK4Wi+6QTjYl1yYcv
        BGa/FFzA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wQA-0001U6-Dv; Thu, 05 Sep 2019 18:23:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 1/3] mm: Add __page_cache_alloc_order
Date:   Thu,  5 Sep 2019 11:23:46 -0700
Message-Id: <20190905182348.5319-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905182348.5319-1-willy@infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
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
---
 include/linux/pagemap.h | 14 +++++++++++---
 mm/filemap.c            | 11 +++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 103205494ea0..d2147215d415 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -208,14 +208,22 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 }
 
 #ifdef CONFIG_NUMA
-extern struct page *__page_cache_alloc(gfp_t gfp);
+extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order);
 #else
-static inline struct page *__page_cache_alloc(gfp_t gfp)
+static inline
+struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
 {
-	return alloc_pages(gfp, 0);
+	if (order > 0)
+		gfp |= __GFP_COMP;
+	return alloc_pages(gfp, order);
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
index 05a5aa82cd32..041c77c4ca56 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -957,24 +957,27 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
 #ifdef CONFIG_NUMA
-struct page *__page_cache_alloc(gfp_t gfp)
+struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
 {
 	int n;
 	struct page *page;
 
+	if (order > 0)
+		gfp |= __GFP_COMP;
+
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			page = __alloc_pages_node(n, gfp, 0);
+			page = __alloc_pages_node(n, gfp, order);
 		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
 
 		return page;
 	}
-	return alloc_pages(gfp, 0);
+	return alloc_pages(gfp, order);
 }
-EXPORT_SYMBOL(__page_cache_alloc);
+EXPORT_SYMBOL(__page_cache_alloc_order);
 #endif
 
 /*
-- 
2.23.0.rc1

