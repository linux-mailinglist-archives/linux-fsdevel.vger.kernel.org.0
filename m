Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220501F5C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFJUPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgFJUNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EFFC00863D;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WQYUHtaa1PlP1XkIa4APm8ZxDaohf3g/uelkXzjDEzk=; b=hwWRASta1tlG6WCdBl2KkJNJzr
        nvbYBTfI6Mu/K4m6gQEQMPCt4LO80m/FyuVq9tIMkJ18nlag0tghEzd0QiTIVzu0lZs0rset5WvKJ
        N5pJwzizSEwx+sOoPLBmjq8PrfTpbD7VTsJyaqD0x12p/HXI0yJPHzDqZo/Evn/z1uxGFBUvcHDVa
        UTyq1eTa+oiGoOwpFCZNYT+kWRClHGiofccsEnWMUQkHGAuKD8oKJPG52/BwQ3KvVEBHb4LlvZM9L
        HP0YPkLSaqemnXdZLxKTisKN+6Sj48890bydbdM0IWKzEuXCLJvnL1guhhfpRkJjy2LIRWjiFXayR
        FPX2gcfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003Xd-0l; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 43/51] mm: Support storing shadow entries for THPs
Date:   Wed, 10 Jun 2020 13:13:37 -0700
Message-Id: <20200610201345.13273-44-willy@infradead.org>
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

If the page is being replaced with a NULL, we can do a single store that
erases the entire range of indices.  Otherwise we have to use a loop to
store one shadow entry in each index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 78f888d028c5..17db007f0277 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -120,22 +120,27 @@ static void page_cache_delete(struct address_space *mapping,
 				   struct page *page, void *shadow)
 {
 	XA_STATE(xas, &mapping->i_pages, page->index);
-	unsigned int nr = 1;
+	unsigned int i, nr = 1, entries = 1;
 
 	mapping_set_update(&xas, mapping);
 
 	/* hugetlb pages are represented by a single entry in the xarray */
 	if (!PageHuge(page)) {
-		xas_set_order(&xas, page->index, compound_order(page));
-		nr = compound_nr(page);
+		entries = nr = thp_nr_pages(page);
+		if (!shadow) {
+			xas_set_order(&xas, page->index, thp_order(page));
+			entries = 1;
+		}
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
 
-	xas_store(&xas, shadow);
-	xas_init_marks(&xas);
+	for (i = 0; i < entries; i++) {
+		xas_store(&xas, shadow);
+		xas_init_marks(&xas);
+		xas_next(&xas);
+	}
 
 	page->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
-- 
2.26.2

