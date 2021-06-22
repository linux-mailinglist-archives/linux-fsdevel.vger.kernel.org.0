Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364003B0541
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhFVM4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFVM4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:56:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B92C061574;
        Tue, 22 Jun 2021 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uvzSdPlgZnEo1K7OF16ibQIUGrCf+vYKoFtlbhy1mNs=; b=rvSd5MpVHkErAESw/9kY5tvxS6
        yv5apwdXMhZht6rs/0E7OSHs366+A1ieE8s5NT90CJinW4VOI3rY45OayWlgxCJPJcCRccd/rXl0R
        pTcndYIgoFJSWlrI7xGOy8UbOxvrbgptF0qMPiC+2QdZUAwVzVUK8pajFuR2CXQ/EqLEVsRsJVaA6
        1fPexG5E0cJU2eZrzPRWjwmnT/HfVMBITpGuWz/2jtms2f51VwmF8tCA2k6ZwTJfvm5Brm7lATh9N
        Ad9389JVlytzy75A1v2ng5NflJOVYyLnixPYgCKhK+F9M4ampkznxVl88icW3LBeTWlSoCS2WNCaT
        44/Stleg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvftf-00EJ1M-Dv; Tue, 22 Jun 2021 12:53:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/46] mm/filemap: Add filemap_alloc_folio
Date:   Tue, 22 Jun 2021 13:15:47 +0100
Message-Id: <20210622121551.3398730-43-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index c1df4c569148..7637cc9333c9 100644
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
index 673094ce67da..4debb11ecc3e 100644
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
+			folio = __alloc_folio_node(gfp, order, n);
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

