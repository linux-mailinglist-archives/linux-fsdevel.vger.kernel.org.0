Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94D829955F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789835AbgJZSbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:48 -0400
Received: from casper.infradead.org ([90.155.50.34]:47272 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789823AbgJZSbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6kfpPdwoe96sn45L+37Echg8oKD19gChL9y3LHoKcvA=; b=tGjtkoaf5dCaZzLZRLIEZn7aQI
        wSMyTxdrmYBhkva48bePpjCVRbiOoIKI0bpaOTUhzb3i9DFDIA0iQFtcxjK1Sj6lh2ihjonTl51NZ
        q/Ji+vQOtGVhotYhZUBClr60dsom8eNaFE+pdzUTe5jTLGVCzm0nK/5WXCeiWDtj7rzNTcq4pfHSI
        GhIAQbDTS6U3K4ol76JTs0CDzqFG455EJLJpGPaN5qjFx3yD3mcGxqCPozuQXaNce7a2/i7gPLc6b
        lPlft7y8ldHxAkvKmKUhZVfrq08E4MFeshQHA1l0WFjdstgLE0c6SJkl1ftqUsoa3CeZPF8HPH+EV
        I+pQzfkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HT-0002jn-0R; Mon, 26 Oct 2020 18:31:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] mm/truncate: Fix invalidate_complete_page2 for THPs
Date:   Mon, 26 Oct 2020 18:31:33 +0000
Message-Id: <20201026183136.10404-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

invalidate_complete_page2() currently open-codes page_cache_free_page(),
except for the part where it handles THP.  Rather than adding that,
call page_cache_free_page() from invalidate_complete_page2().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 3 +--
 mm/internal.h | 1 +
 mm/truncate.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 62bc6affeb70..00de12d42bc4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,8 +228,7 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 	page_cache_delete(mapping, page, shadow);
 }
 
-static void page_cache_free_page(struct address_space *mapping,
-				struct page *page)
+void page_cache_free_page(struct address_space *mapping, struct page *page)
 {
 	void (*freepage)(struct page *);
 
diff --git a/mm/internal.h b/mm/internal.h
index 5aca7d7bc57c..1391e3239547 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -623,4 +623,5 @@ struct migration_target_control {
 };
 
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
+void page_cache_free_page(struct address_space *mapping, struct page *page);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/truncate.c b/mm/truncate.c
index 30653b2717d3..bed24857d1d2 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -603,10 +603,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	__delete_from_page_cache(page, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
-	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(page);
-
-	put_page(page);	/* pagecache ref */
+	page_cache_free_page(mapping, page);
 	return 1;
 failed:
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
2.28.0

