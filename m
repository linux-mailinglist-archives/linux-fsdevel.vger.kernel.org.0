Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B6373F34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhEEQHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEEQHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:07:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC4C061574;
        Wed,  5 May 2021 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=V5YX9ZMAcZXWVYDziUuUHkUQUGYF/zIoLuAsJD8P4xQ=; b=hPK2Kio968bjYkacnz3ZBDz/w1
        fjyvBe3xngJdARj48yvpC33cAfE1/E3pwEstBPwjcba0ig0Ra0MDvo8c8Bz4LH3mN7AstGk4Xy8H6
        fp+AhM/XSv/Ago9xxNYGEzNqRNWZAbM8LYGKpuEw4kmPMmM4AlciBuzGyHzegLNdNZnBHM2ZEkWyB
        RsryE/qQbqyvxWywSBXkM+OCzlPeltBtKLeAeDFM07cS8nDei/Ny0J/j8YFb/ix+aaMNT1J5V0I+g
        GKLXQ/jseOok0CTX9wsQJxJBMuevCVkHs0NdahzT3uKYdugrwY0Vp2hnp1neL6tS0HjEf+wIRCLRL
        WFYQXmrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK0t-000Yur-7F; Wed, 05 May 2021 16:04:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 47/96] mm: Add arch_make_folio_accessible
Date:   Wed,  5 May 2021 16:05:39 +0100
Message-Id: <20210505150628.111735-48-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 6bfc43309e4b..75279db82040 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1725,6 +1725,27 @@ static inline size_t folio_size(struct folio *folio)
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

