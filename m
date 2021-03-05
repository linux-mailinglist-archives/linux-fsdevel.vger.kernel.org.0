Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEB32E099
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEEWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEEWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:22:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF76C061574;
        Thu,  4 Mar 2021 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VD0Fvg6cmd14tiXkK8z0qmCk4W9zwnqQgUrYNW/arts=; b=JpUjN9GY8ZgJniUfRJZmlBURQ2
        nIgf3UKyig4Swhl+XLzue7r1CE7cw/LigQZDDdEXQPrgenhmeC15rneYkVY4QPkvV18CaSDbox2bX
        7RxVqgp8CLAY+9zduAnD5qo1j1OBj30DLKOiZVSIgpDa9OsIS0WPmwZtMZVSAwsIsNuQU6tMqkhQu
        2mAec1BSqPl4qVSd3GTHhdWYoTzgI/xGdofk9SgsAVNRcAM4QBeQb4PoB+8R7/wZNbbAxFSaV4psK
        bCH2eSemJ3JmZelTPpYNbt0Tm06aBUWRSKEXQsYcDr/xkC8mgpbPfZdHn2ljUDfmi/AFb8pBvSDky
        v0fDfY2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1xU-00A3cR-Fh; Fri, 05 Mar 2021 04:21:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 09/25] mm: Add folio_index, folio_page and folio_contains
Date:   Fri,  5 Mar 2021 04:18:45 +0000
Message-Id: <20210305041901.2396498-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_index() is the equivalent of page_index() for folios.  folio_page()
finds the page in a folio for a page cache index.  folio_contains()
tells you whether a folio contains a particular page cache index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f07c03da83f6..5094b50f7680 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -447,6 +447,29 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
 	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
 }
 
+static inline pgoff_t folio_index(struct folio *folio)
+{
+        if (unlikely(FolioSwapCache(folio)))
+                return __page_file_index(&folio->page);
+        return folio->page.index;
+}
+
+static inline struct page *folio_page(struct folio *folio, pgoff_t index)
+{
+	index -= folio_index(folio);
+	VM_BUG_ON_FOLIO(index >= folio_nr_pages(folio), folio);
+	return &folio->page + index;
+}
+
+/* Does this folio contain this index? */
+static inline bool folio_contains(struct folio *folio, pgoff_t index)
+{
+	/* HugeTLBfs indexes the page cache in units of hpage_size */
+	if (PageHuge(&folio->page))
+		return folio->page.index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.30.0

