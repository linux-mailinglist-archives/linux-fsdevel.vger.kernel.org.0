Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DA46CC5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhLHE0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA8C0617A2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cP2Ivi6zK+Qa/y07ReyASR7gp8ZaFUr3Vz/PfLjsdlA=; b=oaDJ4ZchXakogTE0J6WfBOAIid
        pMhFmwpKVVIjfyF9Sc3lGv7TJOLM3KfjA1wgiTaLX8NqFTJVv87mm7Lj3qa7jHpRqmIyRLkGMHsD+
        FyhXyy9/aBUM9GHEDjBsG1vKYklAYUjB6d80YvTX/VnmIfztlJfElaQxmmaADFYhge0+OBEBalgBw
        fNGuE92hsgAnb/9/RkOjCEcV9aUwVQ6hlxpK2/6J/6x/rv1UGQVVuchJizZz39UrsO9N26qPGlnY4
        7w2V5EcQYjl2ohAUET50Nzwvi4TkaBUiEQpDhuICGeA+qT+obZgNCDiMkbz5Ce5jCNFaY2UF+aNjq
        fgrABO4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084Xc-Rn; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/48] filemap: Convert tracing of page cache operations to folio
Date:   Wed,  8 Dec 2021 04:22:20 +0000
Message-Id: <20211208042256.1923824-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the folio instead of a page.  The page was already implicitly a
folio as it accessed page->mapping directly.  Add the order of the folio
to the tracepoint, as this is important information.  Also drop printing
the address of the struct page as the pfn provides better information
than the struct page address.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/trace/events/filemap.h | 32 +++++++++++++++++---------------
 mm/filemap.c                   |  9 +++++----
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index c47b63db124e..46c89c1e460c 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -15,43 +15,45 @@
 
 DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
 		__field(unsigned long, i_ino)
 		__field(unsigned long, index)
 		__field(dev_t, s_dev)
+		__field(unsigned char, order)
 	),
 
 	TP_fast_assign(
-		__entry->pfn = page_to_pfn(page);
-		__entry->i_ino = page->mapping->host->i_ino;
-		__entry->index = page->index;
-		if (page->mapping->host->i_sb)
-			__entry->s_dev = page->mapping->host->i_sb->s_dev;
+		__entry->pfn = folio_pfn(folio);
+		__entry->i_ino = folio->mapping->host->i_ino;
+		__entry->index = folio->index;
+		if (folio->mapping->host->i_sb)
+			__entry->s_dev = folio->mapping->host->i_sb->s_dev;
 		else
-			__entry->s_dev = page->mapping->host->i_rdev;
+			__entry->s_dev = folio->mapping->host->i_rdev;
+		__entry->order = folio_order(folio);
 	),
 
-	TP_printk("dev %d:%d ino %lx page=%p pfn=0x%lx ofs=%lu",
+	TP_printk("dev %d:%d ino %lx pfn=0x%lx ofs=%lu order=%u",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino,
-		pfn_to_page(__entry->pfn),
 		__entry->pfn,
-		__entry->index << PAGE_SHIFT)
+		__entry->index << PAGE_SHIFT,
+		__entry->order)
 );
 
 DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_delete_from_page_cache,
-	TP_PROTO(struct page *page),
-	TP_ARGS(page)
+	TP_PROTO(struct folio *folio),
+	TP_ARGS(folio)
 	);
 
 DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
-	TP_PROTO(struct page *page),
-	TP_ARGS(page)
+	TP_PROTO(struct folio *folio),
+	TP_ARGS(folio)
 	);
 
 TRACE_EVENT(filemap_set_wb_err,
diff --git a/mm/filemap.c b/mm/filemap.c
index 600b8c921a67..bcdc8bb4d2c8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -225,7 +225,7 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 	struct folio *folio = page_folio(page);
 	struct address_space *mapping = page->mapping;
 
-	trace_mm_filemap_delete_from_page_cache(page);
+	trace_mm_filemap_delete_from_page_cache(folio);
 
 	filemap_unaccount_folio(mapping, folio);
 	page_cache_delete(mapping, folio, shadow);
@@ -346,9 +346,10 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	for (i = 0; i < pagevec_count(pvec); i++) {
-		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
+		struct folio *folio = page_folio(pvec->pages[i]);
 
-		filemap_unaccount_folio(mapping, page_folio(pvec->pages[i]));
+		trace_mm_filemap_delete_from_page_cache(folio);
+		filemap_unaccount_folio(mapping, folio);
 	}
 	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irq(&mapping->i_pages);
@@ -959,7 +960,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		goto error;
 	}
 
-	trace_mm_filemap_add_to_page_cache(&folio->page);
+	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
 	folio->mapping = NULL;
-- 
2.33.0

