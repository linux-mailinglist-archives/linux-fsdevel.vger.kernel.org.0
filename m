Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEBBD5DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633479AbfIYAxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:53:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411298AbfIYAwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y1NQt4anQEfBjooPzpptnZgqbwsCqUUifwKGuz058Us=; b=Ri0Wt1OFlgSu5WqI76Qo7Dl3PA
        z/6CoduVoj4eqcbssamNy4bItMsi2FmnNE73+TMXyxGFkSsgJbsM4w40M7Js3TSPsWObahgOTg9lQ
        b05c4+Nd8s5Us4TcGl88hCHlhigXp/0ZMhbxt5I2plWxdZBYf7fbVAvxx8qgvPH5CHRJoRqOw49jD
        liwU5sBhX1zd41WD0zvIZ4KKGnbzgRif6SlIwP3GfVozKLYsyA8OYyX5o7XgCMAJfN2daJOOOfMUA
        JSCi7ZXFc7Q3/yGTDESyNR5Fk7YdwFB6tegDEi88Ti7VR6Dgo9+3f3kD+JoaVVCvHltzYM4ij6mbH
        4EDfUNzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076f-Gq; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/15] mm: Make prep_transhuge_page tail-callable
Date:   Tue, 24 Sep 2019 17:52:06 -0700
Message-Id: <20190925005214.27240-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
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
---
 include/linux/huge_mm.h | 7 +++++--
 mm/huge_memory.c        | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 61c9ffd89b05..779e83800a77 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -153,7 +153,7 @@ extern unsigned long thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags);
 
-extern void prep_transhuge_page(struct page *page);
+extern struct page *prep_transhuge_page(struct page *page);
 extern void free_transhuge_page(struct page *page);
 
 bool can_split_huge_page(struct page *page, int *pextra_pins);
@@ -303,7 +303,10 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline void prep_transhuge_page(struct page *page) {}
+static inline struct page *prep_transhuge_page(struct page *page)
+{
+	return page;
+}
 
 #define transparent_hugepage_flags 0UL
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 73fc517c08d2..cbe7d0619439 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -516,15 +516,20 @@ static inline struct deferred_split *get_deferred_split_queue(struct page *page)
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
 
 static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
-- 
2.23.0

