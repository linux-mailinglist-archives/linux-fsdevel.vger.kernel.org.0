Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B973C4251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhGLD4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhGLD4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A4C0613E9;
        Sun, 11 Jul 2021 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5QMYtx8QZW0KAbJgUMmy4ACPa1j3yj5hwVBCEiSFk2M=; b=O73cLzO4EsUkXApA1ABb0K8lTN
        DJBSU8q20uGbKMbzo7u7DyUN67yW8EWakiQHxS10nHYnxEDL6/vJ9QO6nXKbBbEZETRijRgBzop1y
        ozxY0TwBwyY0Q6+rUEGsSe2h5A3OvQRJJ8La30omGqhSU6lue/Mn9ZHFwQ5o4BDH5yYO9gz/LKwH1
        B39PXizgi8rNiedJb2jclQ8/WmNwEF0sxqqpiFyd6vdSbQrhLwt3DxEI7J0MQ6yohMYNuNwO/5GPb
        Mwui1ABHPfr+F/+HSBcFrmNNNDiHutzXGqDwQQgcSwyLKodfDWDtPwiGCvNaoM1gi81jvkbYlMR6y
        UASIEcJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mz9-00Gpw1-ID; Mon, 12 Jul 2021 03:52:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 084/137] mm/filemap: Add filemap_alloc_folio
Date:   Mon, 12 Jul 2021 04:06:08 +0100
Message-Id: <20210712030701.4000097-85-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index c0506722d209..5c9d8235fc4e 100644
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
index b0c9b4030144..6e721b283cb5 100644
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

