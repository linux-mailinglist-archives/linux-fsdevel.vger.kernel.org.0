Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4E1F5CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFJUSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgFJUNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D9C08C5C2;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J/UeCwTdxdvssMS23HfBywrddunudah3jTHxFdDluWw=; b=LZhl8XoqWmoxoe4oiI7dUinI5V
        U776oT0ROF8uRC9JNB/LJXhTM+4p3TiyRvjzsIpCYCyO3a68xtitko/SBbg+ZVmx5GhngKvg9teOe
        WdyM9DdbiWNiNitspHxiYl9Nnk76ZbMXbemycCOEyXCj0YGes58HTegT39DkLVzMaCjRFXStIJ5kG
        CCvcIZMcZ+8zG/h8Ltb42ivV8fr2o3mwB1mfvj4o/3/wV0RG+WfDKZzyxnfPYIYRbsnTLZiVYQP3i
        bDBLGubh523Oi32hOAU2iXSukuT2B54nfqXae++cWaFptGmzzUymDbzAPIFUGkPFbaJp3uSHJUErK
        qj72UUNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003TO-EQ; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/51] mm: Store compound_nr as well as compound_order
Date:   Wed, 10 Jun 2020 13:13:00 -0700
Message-Id: <20200610201345.13273-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This removes a few instructions from functions which need to know how many
pages are in a compound page.  The storage used is either page->mapping
on 64-bit or page->index on 32-bit.  Both of these are fine to overlay
on tail pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 5 ++++-
 include/linux/mm_types.h | 1 +
 mm/page_alloc.c          | 5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..af0305ad090f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -911,12 +911,15 @@ static inline int compound_pincount(struct page *page)
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
 	page[1].compound_order = order;
+	page[1].compound_nr = 1U << order;
 }
 
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
-	return 1UL << compound_order(page);
+	if (!PageHead(page))
+		return 1;
+	return page[1].compound_nr;
 }
 
 /* Returns the number of bytes in this potentially compound page. */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc..561ed987ab44 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -134,6 +134,7 @@ struct page {
 			unsigned char compound_dtor;
 			unsigned char compound_order;
 			atomic_t compound_mapcount;
+			unsigned int compound_nr; /* 1 << compound_order */
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 727751219003..3fb61ef4c3a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -673,8 +673,6 @@ void prep_compound_page(struct page *page, unsigned int order)
 	int i;
 	int nr_pages = 1 << order;
 
-	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
-	set_compound_order(page, order);
 	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++) {
 		struct page *p = page + i;
@@ -682,6 +680,9 @@ void prep_compound_page(struct page *page, unsigned int order)
 		p->mapping = TAIL_MAPPING;
 		set_compound_head(p, page);
 	}
+
+	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+	set_compound_order(page, order);
 	atomic_set(compound_mapcount_ptr(page), -1);
 	if (hpage_pincount_available(page))
 		atomic_set(compound_pincount_ptr(page), 0);
-- 
2.26.2

