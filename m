Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4E3747AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhEESB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhEESBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67331C0612AF;
        Wed,  5 May 2021 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aCJPdbFikHVw1iejx4/NJ1aZahzV7GtlgafMroiNaUM=; b=RHO9cr6oP/h0BR9MZibn2R924u
        q8bQNisZQBIAfcTDfoTYYmoGPKE0AmmJQ88PbpV4S1gLPuJO4lb8hRfJgPCBwAcMKzebKA3KgptDN
        frNsAuMcVhHx3YKmiXmQ9h76R8D3X6fGblRzrrKkxZe6+uDdkDl3dyQUGtodP3jX2AwARSXpGDSk3
        fgfYm6CvDeEXqrWfz5sQOooOTz1E/6YG9HzOcuTW1CqadHiEOF0Ovp+dyeTBBVMkJsKCmDDEu2MhY
        dr8nHzodQzMsGY2VPt2vRWtHLn+3cMyhvG7JGDnrXAvyOfF7T3WRIWxrjGNiVQmRB21Nylp6chiKT
        LjvqWXsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKpR-000cRK-Fm; Wed, 05 May 2021 16:58:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 77/96] mm/filemap: Add filemap_alloc_folio
Date:   Wed,  5 May 2021 16:06:09 +0100
Message-Id: <20210505150628.111735-78-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
---
 include/linux/pagemap.h | 11 ++++++++---
 mm/filemap.c            | 14 +++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d54772aa7a3a..64370f615aba 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -338,14 +338,19 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-extern struct page *__page_cache_alloc(gfp_t gfp);
+extern struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-static inline struct page *__page_cache_alloc(gfp_t gfp)
+static inline struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
 {
-	return alloc_pages(gfp, 0);
+	return alloc_folio(gfp, order);
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
index 5c130bfcdb1c..a9c16f05b863 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -987,24 +987,24 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
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
+			folio = __alloc_folio_node(n, gfp, order);
+		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
-		return page;
+		return folio;
 	}
-	return alloc_pages(gfp, 0);
+	return alloc_folio(gfp, order);
 }
-EXPORT_SYMBOL(__page_cache_alloc);
+EXPORT_SYMBOL(filemap_alloc_folio);
 #endif
 
 /*
-- 
2.30.2

