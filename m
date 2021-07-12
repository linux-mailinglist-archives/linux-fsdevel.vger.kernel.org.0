Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A203C4205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhGLDkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhGLDkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC1C0613DD;
        Sun, 11 Jul 2021 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m/Bg7LKZhCW6/qjbVSylrDx69jh8HyrsyM7lKpeyuoc=; b=Q3/W6DYBK+UQ8FmnedQL9fC7Yk
        Jz8juBG+EV5kBSkzw9APtbnt2n5Lez0abGrD0I7Lwkwq3ht8pfC+Y3b/XMeTNQNDgQbSXJd8kwucG
        GTRTthExhcgmlBOQaBuF/0lD28btPAr00pEbtVg4XROONLSGzMb1rjoMKum/82yLCrSCsTT3ytjih
        S663IKayXhIimJTVR0X6CyBrGLt+gkWMrrWna0UBabNyhy5NL85qNzDKi2vKAeg9Om6/LQRx7B7pQ
        E+oaMwal+VT7BliCYPMfGGrSkfcO/gbxKxgaOm8sDUkvR8cOPxUgGzRdXTwRDx+dX8dgPsA+Lf2eZ
        zpScvTTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mkE-00GoqJ-1U; Mon, 12 Jul 2021 03:36:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 055/137] mm: Add arch_make_folio_accessible()
Date:   Mon, 12 Jul 2021 04:05:39 +0100
Message-Id: <20210712030701.4000097-56-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index fa5974870660..12e78faa3519 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1731,6 +1731,27 @@ static inline size_t folio_size(struct folio *folio)
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

