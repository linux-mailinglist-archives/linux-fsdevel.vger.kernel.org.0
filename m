Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268C373F15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEEP7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhEEP7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:59:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE6C061574;
        Wed,  5 May 2021 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XX7WlZLUVRG3S89p8YK7xOJIbSQs/CkgLGJSAS8+DyI=; b=bHMD4P6ej4G1RUIz1sSgK4fs0f
        9pW+eglMeqveEP4bWV6nICp3pc9Q8wsDNLIKa9BjaYkY02kZMVmUaWwgyYlgszNxr7aVxYH8PvCSs
        yZrEllcJwHVwvoj7yfQCO6ciG5q1jU6vgQ5vGu5Bw6wYlqYqrnWGPIs2VsJdiWpQsjfkSja8rQlFw
        35LiKkbWQbYa9/GV27p9LiMMIaC9U1XyaTuMsMTBqiWL+nTOlEXE6CieVpnTvqqss7s58WDCyBBXz
        ZDdYJ6nJJC3nlKA+8mPK2TeOJBE6V6hO060timN5s0C4L5KkGntYveL6DiodeexFufFFJ0eHOhjPX
        l5mRzhyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJtj-000XSV-Ht; Wed, 05 May 2021 15:57:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 40/96] mm: Add folio_mapped
Date:   Wed,  5 May 2021 16:05:32 +0100
Message-Id: <20210505150628.111735-41-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is the equivalent of page_mapped().  It is slightly
shorter as we do not need to handle the PageTail() case.  Reimplement
page_mapped() as a wrapper around folio_mapped().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  1 +
 mm/folio-compat.c  |  6 ++++++
 mm/util.c          | 30 +++++++++++++++++-------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bca3e2518e5e..6bfc43309e4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1779,6 +1779,7 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
+bool folio_mapped(struct folio *folio);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3c83f03b80d7..7044fcc8a8aa 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -35,3 +35,9 @@ void wait_for_stable_page(struct page *page)
 	return folio_wait_stable(page_folio(page));
 }
 EXPORT_SYMBOL_GPL(wait_for_stable_page);
+
+bool page_mapped(struct page *page)
+{
+	return folio_mapped(page_folio(page));
+}
+EXPORT_SYMBOL(page_mapped);
diff --git a/mm/util.c b/mm/util.c
index afd99591cb81..e60b0920f9a7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -652,28 +652,32 @@ void *page_rmapping(struct page *page)
 	return __page_rmapping(page);
 }
 
-/*
- * Return true if this page is mapped into pagetables.
- * For compound page it returns true if any subpage of compound page is mapped.
+/**
+ * folio_mapped - Is this folio mapped into userspace?
+ * @folio: The folio.
+ *
+ * Return: true if any page in this folio is mapped into pagetables.
  */
-bool page_mapped(struct page *page)
+bool folio_mapped(struct folio *folio)
 {
-	int i;
+	int i, nr;
 
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) >= 0;
-	page = compound_head(page);
-	if (atomic_read(compound_mapcount_ptr(page)) >= 0)
+	if (folio_single(folio))
+		return atomic_read(&folio->_mapcount) >= 0;
+	if (atomic_read(compound_mapcount_ptr(&folio->page)) >= 0)
 		return true;
-	if (PageHuge(page))
+	if (folio_hugetlb(folio))
 		return false;
-	for (i = 0; i < compound_nr(page); i++) {
-		if (atomic_read(&page[i]._mapcount) >= 0)
+
+	nr = folio_nr_pages(folio);
+	for (i = 0; i < nr; i++) {
+		struct page *page = nth_page(&folio->page, i);
+		if (atomic_read(&page->_mapcount) >= 0)
 			return true;
 	}
 	return false;
 }
-EXPORT_SYMBOL(page_mapped);
+EXPORT_SYMBOL(folio_mapped);
 
 struct anon_vma *page_anon_vma(struct page *page)
 {
-- 
2.30.2

