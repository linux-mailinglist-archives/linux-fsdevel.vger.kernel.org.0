Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7973C42CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhGLEU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGLEUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:20:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4ADC0613E8;
        Sun, 11 Jul 2021 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=afpe9MgEq6p1fMK6Y/D/Lr2EVdIHLoiu+PRgXveJNJA=; b=g1axzEAW/gsANmxA4iPiXtm6z0
        RHVYRgd8wLpVwRzAGppfJdDqHtcZpE1U10e3KKQDbx0C8Qbgtqo80quUgN7D308rCpMPg2+2RB0NW
        PWG8AThdoP5l739Jj8R3X7SqXDNuxP2BuGStoSO/N+QJodwCBs6J+okMa9XhUv2dBWVSWQzZMFZ3V
        6FvY7kAQw+QTJci5G5WY+MVZ9nWErw0CfGmFMa1EBI5r/DYcV1v7JCo7A1uukDN8XUfj/e06OUzya
        7NfpZ+EBfP4NcoNO2ANqoVtGaxYNGj/na+TjybIpHmK1or729pI0dcd71MUF4mTVDsa1K2zDhdFdv
        bKiIvz4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nMR-00GrcV-Dz; Mon, 12 Jul 2021 04:16:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 130/137] mm/truncate: Fix invalidate_complete_page2 for THPs
Date:   Mon, 12 Jul 2021 04:06:54 +0100
Message-Id: <20210712030701.4000097-131-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

invalidate_complete_page2() currently open-codes filemap_free_folio(),
except for the part where it handles THP.  Rather than adding that,
call page_cache_free_page() from invalidate_complete_page2().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c  | 3 +--
 mm/internal.h | 1 +
 mm/truncate.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab3503493975..c8fc0d07fa92 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,8 +228,7 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void filemap_free_folio(struct address_space *mapping,
-				struct folio *folio)
+void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*freepage)(struct page *);
 
diff --git a/mm/internal.h b/mm/internal.h
index 65314d4380d0..d3958ef40d8b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -73,6 +73,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
+void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/truncate.c b/mm/truncate.c
index cc849e2b080b..b2c4d2bcf970 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -619,10 +619,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
-	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(&folio->page);
-
-	folio_ref_sub(folio, folio_nr_pages(folio));	/* pagecache ref */
+	filemap_free_folio(mapping, folio);
 	return 1;
 failed:
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
2.30.2

