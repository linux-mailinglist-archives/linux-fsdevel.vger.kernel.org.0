Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9753B0431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFVMXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhFVMXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:23:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD4C061574;
        Tue, 22 Jun 2021 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X5ppZNyk8VY95fBxUhjQKajJf5q5N5EjgqtX70C3lzU=; b=Vu706WtRv5ZNdSZIs3v6TUeUm/
        g6UmZTODxpgQpktZTVWzFj1OvSyonaPHO4sTC8Akrbla7d7hiRUcpsC8zbXr8AlDFirt4+D+URlYz
        ric6Wo1g467XN30OQXfi9gzetyfChVoFU1uJFaZxy31+2v0wJ86N28mGnjCCbbmjDaeXkEgwRu2T9
        Dx/yz4aQy5ayFAjf3TGc2WAiKVlZevnKh97jGE+qE5uJ0+mhDwtrk9fXbp6M4efo1vYlOB5Xk7nh5
        sYh9JKACQilrnIyxkn6UuPJw6x9kzTO8MpzLOYiKsaMhtLfDnw1+rqmnOEM/Q28NB6QzDDKZMFlyb
        cHLBIqfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfO3-00EGUp-R9; Tue, 22 Jun 2021 12:20:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/46] mm: Add arch_make_folio_accessible()
Date:   Tue, 22 Jun 2021 13:15:10 +0100
Message-Id: <20210622121551.3398730-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index 11da8af06704..a503d928e684 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -508,12 +508,6 @@ static inline void arch_free_page(struct page *page, int order) { }
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
index 2c7b6ae1d3fc..5609095ffcac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1719,6 +1719,27 @@ static inline size_t folio_size(struct folio *folio)
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

