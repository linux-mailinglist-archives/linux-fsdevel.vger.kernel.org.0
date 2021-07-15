Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05B3C9721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhGOEZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOEZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:25:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FDC06175F;
        Wed, 14 Jul 2021 21:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7wUoKfBZfariJ0vsqhKDjrMepYyjGa6tL5Bdrvqggxg=; b=Gb703oXAZQ0yFbSal2W7lQiEbF
        vFbOMCu/dBI13V/4/enRicX/7MdlrJgcZm7F7doyr7R1dtoSQgQetZSqxmBpsQy2pejNVb20AMAoz
        y5KJFUDB8pjmOlc/YcMnGf4TBL1Pi0lwMw+igiV6B0LwjHBoeFJDt51lJdj2gCHrBi2GiJMsOyb31
        E1wJVpA7LWXc91eENoA4SAjt4ZEWtrpLuNDDyoB+fvsd8Cb2KgSZMDdz4fYlDMf2jFgEH3ILX6Xdh
        6YBW5eOL52ojpR7NWdWH9StiHskkF5VJXEIFxM/SMFpi7JHYLPfaAPStPcXFVQJdxzo8bFdl2QDta
        hxC3d8GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3srh-002wz6-0F; Thu, 15 Jul 2021 04:21:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 055/138] mm: Add arch_make_folio_accessible()
Date:   Thu, 15 Jul 2021 04:35:41 +0100
Message-Id: <20210715033704.692967-56-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a default implementation, call arch_make_page_accessible n times.
If an architecture can do better, it can override this.

Also move the default implementation of arch_make_page_accessible()
from gfp.h to mm.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/gfp.h |  6 ------
 include/linux/mm.h  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..dc5ff40608ce 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -520,12 +520,6 @@ static inline void arch_free_page(struct page *page, int order) { }
 #ifndef HAVE_ARCH_ALLOC_PAGE
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
-#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
-static inline int arch_make_page_accessible(struct page *page)
-{
-	return 0;
-}
-#endif
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 89daae93aa9b..deb0f5efaa65 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1732,6 +1732,27 @@ static inline size_t folio_size(struct folio *folio)
 	return PAGE_SIZE << folio_order(folio);
 }
 
+#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
+static inline int arch_make_page_accessible(struct page *page)
+{
+	return 0;
+}
+#endif
+
+#ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
+static inline int arch_make_folio_accessible(struct folio *folio)
+{
+	int ret, i;
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		ret = arch_make_page_accessible(folio_page(folio, i));
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+#endif
+
 /*
  * Some inline functions in vmstat.h depend on page_zone()
  */
-- 
2.30.2

