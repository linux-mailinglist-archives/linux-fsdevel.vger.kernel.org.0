Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3311E7334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbgE2DAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407301AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE23C008636;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J5D9xGGBSFhSBZQFLLkizdfmJQQ9VTJ9BzrD2DVYvp4=; b=tmPXNoJJJGdFoOD9J9FNwV0VEG
        vFXMqfk659WjQZQNq4OsTpO9+bbMIluzsW9as8ai4xUzMZiwvpBF+pxGXTOHb7qNZPQMxjrOpP4O7
        lE1dZJR5/WSStJBy/e405ENAcOHwzzHPub3qO71+/MuO4BkUXBU1AVJJFMMOjErjX177jCs6TYu7g
        ueTGMIPy7uhepQMpWjUEzL7Z9qNGmt/TPOhy6hYpe+28I0QXRAmNtJWrUrz1pcLBy+gk6ZU+bjnsi
        mqtGjz6r7evdRWP2Wn8wWzKXuMej4o1naXk7t1H7TkVB/2PHztDC0C/Vb+QfSnu4u5v2FGsGpRNI1
        a4qtLI6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008TD-Ou; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 31/39] mm: Support storing shadow entries for large pages
Date:   Thu, 28 May 2020 19:58:16 -0700
Message-Id: <20200529025824.32296-32-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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

