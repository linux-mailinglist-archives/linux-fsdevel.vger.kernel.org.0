Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7221D4ED9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEONRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F8C05BD1A;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J5D9xGGBSFhSBZQFLLkizdfmJQQ9VTJ9BzrD2DVYvp4=; b=KB8xI84bU5Vdya+GCcFphefntf
        wvsHkKCp9bbfGbppQcNHNf0QFh6cqNy4qevBWrUv4XigrxvTYt7pGT1ayXXp4iY3XnLHKuwQuTgVn
        QIzGJ1AceBBekhcvWCH1Ey8JApsbu6mRWmarzmhSBEmWCSYI0vBqmRGwRrNqEMHeODJo1ezIfjIgU
        AruDLjDFMPNoMYqmC7XcY4WSlT2NlmNV0h9XIQlL2yPwQjDbFk05SXROE3H+VMm8LdAwB4WDt1/hV
        6hzYPKZtpgqcgsn38IPEnXi0ikz1GiuytgTqR/ieyDBB+VSJ7/9N0Id2VTIRrHEMx45Wodh+KySa8
        O3CPAJ5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005li-Du; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 28/36] mm: Support storing shadow entries for large pages
Date:   Fri, 15 May 2020 06:16:48 -0700
Message-Id: <20200515131656.12890-29-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the page is being replaced with a NULL, we can do a single large store,
but for now we have to use a loop to store one shadow entry in each entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9c760dd7208e..0ec7f25a07b2 100644
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
+		entries = nr = hpage_nr_pages(page);
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

