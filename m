Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DECB1BDF3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgD2Nl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgD2NhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA864C09B052;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VARbJRt66GXZ9qiKVVic699Ba+6i1AmoDjPwsJmH6Ms=; b=de4RFMRD8dMojIIeXBHcYPG/M5
        nWhABiDosUpLCR6KRc1wgN3T8SPfYoLJVSfmoWAAg1yTm8JRu0hIRMVkBl2IZ0/57ANffY4eNtzjJ
        0+Q6ZF75GUh0BNFNAZApP7LfPnMdiW5denJpYF1vBSQcUoqy2bSib5GP32tZnnvQcbyovRK8iv2mV
        6K8E3kJCQHATjoghavXFEKlKQ7/yLyay0pxghvyOFcf5oQ4acCEwBoclrNn3vv50W6EKviUaNA55N
        d0J47upy2ZwpPWv8P6+upSJve7iOzniw5/f++qOU3MXp38F62EHS6G7tvp3I1X/ooTuqZH4bq49WO
        WJ444nfA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005vx-LQ; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 16/25] mm: Make prep_transhuge_page return its argument
Date:   Wed, 29 Apr 2020 06:36:48 -0700
Message-Id: <20200429133657.22632-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
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
index 1f6245091917..6a8502278f41 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -193,7 +193,7 @@ extern unsigned long thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags);
 
-extern void prep_transhuge_page(struct page *page);
+extern struct page *prep_transhuge_page(struct page *page);
 extern void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
 
@@ -358,7 +358,10 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
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
index 6ecd1045113b..7a5e2b470bc7 100644
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
2.26.2

