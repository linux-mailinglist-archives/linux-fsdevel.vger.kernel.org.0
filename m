Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87014373F24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEEQEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhEEQEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:04:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4997C061574;
        Wed,  5 May 2021 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VIHdinPt47fCzUkoCdcECCNObaX1ZybO97UruiUb2Pc=; b=ZfEClWxN9ecaLACcdiFRsru8nq
        fOrk2UOQQ7KLnnlG+W/IOMwbWJd9iTiFtkIzyfF6cWG+/sH1/haKJUyHXmq9QDCzFxWZu/igMDMLZ
        w9E76tdJOUYlAKRQhtJFUG9Aw5hRtT6hR0skRFnqEMcZSblmCpvAQkICq8NpuJR3XRRDFB3q+6c3S
        5gECLL8VjaS4FgxOG3sz3rK8fqiXrFKTYajkRh7gj6/cZInJvb4t7TvYFOHe2tPMyI5xs9d9mxoQq
        GT8prJnD0BpghdaE0WQaw84nWYLGF1wRJAYoWwrXm91fNJ/f0uUaDRbXMN4xaZB1sqIzrDUq8FRiy
        vetLRZWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJxr-000Yg5-Mo; Wed, 05 May 2021 16:01:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 44/96] mm/rmap: Add folio_mkclean
Date:   Wed,  5 May 2021 16:05:36 +0100
Message-Id: <20210505150628.111735-45-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transform page_mkclean() into folio_mkclean() and add a page_mkclean()
wrapper around folio_mkclean().

folio_mkclean is 15 bytes smaller than page_mkclean, but the kernel
is enlarged by 33 bytes due to inlining page_folio() into each caller.
This will go away once the callers are converted to use folio_mkclean().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h | 10 ++++++----
 mm/rmap.c            | 12 ++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index def5c62c93b3..edb006bc4159 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -233,7 +233,7 @@ unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
  *
  * returns the number of cleaned PTEs.
  */
-int page_mkclean(struct page *);
+int folio_mkclean(struct folio *);
 
 /*
  * called in munlock()/munmap() path to check for other vmas holding
@@ -291,12 +291,14 @@ static inline int page_referenced(struct page *page, int is_locked,
 
 #define try_to_unmap(page, refs) false
 
-static inline int page_mkclean(struct page *page)
+static inline int folio_mkclean(struct folio *folio)
 {
 	return 0;
 }
-
-
 #endif	/* CONFIG_MMU */
 
+static inline int page_mkclean(struct page *page)
+{
+	return folio_mkclean(page_folio(page));
+}
 #endif	/* _LINUX_RMAP_H */
diff --git a/mm/rmap.c b/mm/rmap.c
index 693a610e181d..e29dbbc880d7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -983,7 +983,7 @@ static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
 	return true;
 }
 
-int page_mkclean(struct page *page)
+int folio_mkclean(struct folio *folio)
 {
 	int cleaned = 0;
 	struct address_space *mapping;
@@ -993,20 +993,20 @@ int page_mkclean(struct page *page)
 		.invalid_vma = invalid_mkclean_vma,
 	};
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_locked(folio));
 
-	if (!page_mapped(page))
+	if (!folio_mapped(folio))
 		return 0;
 
-	mapping = page_mapping(page);
+	mapping = folio_mapping(folio);
 	if (!mapping)
 		return 0;
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 
 	return cleaned;
 }
-EXPORT_SYMBOL_GPL(page_mkclean);
+EXPORT_SYMBOL_GPL(folio_mkclean);
 
 /**
  * page_move_anon_rmap - move a page to our anon_vma
-- 
2.30.2

