Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12F159FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBLESs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gXJv+foPDzm9zZZb2en6nqyTOSipe1jE6l4dnk9iVRY=; b=EvJY83cuo9CuZJSwbi/lXWN3fj
        3hmkqb1bPoc4dHHzywZCdrw9jpeYiTqqBtnxy23Te13nFXUD9zv6WmZrQqrNpCxOJDcnHFLEaAjvu
        cI/IU+S+kEnckvQ33zp+vvt5HrXRget0R5I4oS4OF/XVbp84syTfZTPyqwi23UR9+KYuASjxG3j4b
        Jq+mT5s/TcDEa6IPWtAko+4rA1fFFXCi6hu8ubmfD5KucwIokKRQrNw3OpJNIKP/SPZXU/lNrfjpu
        BIhDwvKiLNrJ5+cqAt4m6860BFcMc/AJCQJ89CaoeCaX7cbamgIiU5I3qifIGDaoRGjtM1WX3xVjF
        duIt4uvA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006oi-B9; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 20/25] mm: Make prep_transhuge_page return its argument
Date:   Tue, 11 Feb 2020 20:18:40 -0800
Message-Id: <20200212041845.25879-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By permitting NULL or order-0 pages as an argument, and returning the
argument, callers can write:

	return prep_transhuge_page(alloc_pages(...));

instead of assigning the result to a temporary variable and conditionally
passing that to prep_transhuge_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/huge_mm.h | 7 +++++--
 mm/huge_memory.c        | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3de788ee25bd..865b9c16c99c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -158,7 +158,7 @@ extern unsigned long thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags);
 
-extern void prep_transhuge_page(struct page *page);
+extern struct page *prep_transhuge_page(struct page *page);
 extern void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
 
@@ -307,7 +307,10 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline void prep_transhuge_page(struct page *page) {}
+static inline struct page *prep_transhuge_page(struct page *page)
+{
+	return page;
+}
 
 static inline bool is_transparent_hugepage(struct page *page)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..b52e007f0856 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -508,15 +508,20 @@ static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 }
 #endif
 
-void prep_transhuge_page(struct page *page)
+struct page *prep_transhuge_page(struct page *page)
 {
+	if (!page || compound_order(page) == 0)
+		return page;
 	/*
-	 * we use page->mapping and page->indexlru in second tail page
+	 * we use page->mapping and page->index in second tail page
 	 * as list_head: assuming THP order >= 2
 	 */
+	BUG_ON(compound_order(page) == 1);
 
 	INIT_LIST_HEAD(page_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
+
+	return page;
 }
 
 bool is_transparent_hugepage(struct page *page)
-- 
2.25.0

