Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9DE3C971C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhGOEYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOEYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:24:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22341C06175F;
        Wed, 14 Jul 2021 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q3P0tZNKkQBQCHQAnhrC3AbA7cH4qgibd4ubfHlUHLI=; b=H1WUkZDnuEVn52N3PeJ5KHdbnI
        ZQs7zReFPfjsUPm84hoc2OPUfZ19QDY6I49iYtb5+SJrH7e7Dc1mBrK97fDcZz+3/seAnmq57/DlW
        zfxG15tbdcsg/hUi133GL4aStb3wFjzrSv9rnpXtKJ4o4K5OEfKH2DqjoRl8NmOoiyTAsnaJ1W2+k
        Lv5p9RBANY6zM2ZfS7nhJB3ftKf78+RQoCqJAz+hc9zns6f5XdXHv3pXRDhhoCT+3ceOmGFH7hi4o
        FebvVsv9GutoCdncbnAdVUlungJiy9tLUtAfmtjbiZnesUoxauSHCN0KQad64tre21NSd6JgDNQ/U
        55uZGxxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sqz-002wvL-Nc; Thu, 15 Jul 2021 04:20:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 054/138] mm: Add kmap_local_folio()
Date:   Thu, 15 Jul 2021 04:35:40 +0100
Message-Id: <20210715033704.692967-55-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows us to map a portion of a folio.  Callers can only expect
to access up to the next page boundary.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/highmem-internal.h | 11 +++++++++
 include/linux/highmem.h          | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 7902c7d8b55f..d5d6f930ae1d 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+{
+	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
+}
+
 static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
@@ -160,6 +166,11 @@ static inline void *kmap_local_page(struct page *page)
 	return page_address(page);
 }
 
+static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+{
+	return page_address(&folio->page) + offset;
+}
+
 static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	return kmap_local_page(page);
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 8c6e8e996c87..85de3bd0b47d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -96,6 +96,44 @@ static inline void kmap_flush_unused(void);
  */
 static inline void *kmap_local_page(struct page *page);
 
+/**
+ * kmap_local_folio - Map a page in this folio for temporary usage
+ * @folio:	The folio to be mapped.
+ * @offset:	The byte offset within the folio.
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can be invoked from any context.
+ *
+ * Requires careful handling when nesting multiple mappings because the map
+ * management is stack based. The unmap has to be in the reverse order of
+ * the map operation:
+ *
+ * addr1 = kmap_local_folio(page1, offset1);
+ * addr2 = kmap_local_folio(page2, offset2);
+ * ...
+ * kunmap_local(addr2);
+ * kunmap_local(addr1);
+ *
+ * Unmapping addr1 before addr2 is invalid and causes malfunction.
+ *
+ * Contrary to kmap() mappings the mapping is only valid in the context of
+ * the caller and cannot be handed to other contexts.
+ *
+ * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+ * virtual address of the direct mapping. Only real highmem pages are
+ * temporarily mapped.
+ *
+ * While it is significantly faster than kmap() for the higmem case it
+ * comes with restrictions about the pointer validity. Only use when really
+ * necessary.
+ *
+ * On HIGHMEM enabled systems mapping a highmem page has the side effect of
+ * disabling migration in order to keep the virtual address stable across
+ * preemption. No caller of kmap_local_folio() can rely on this side effect.
+ */
+static inline void *kmap_local_folio(struct folio *folio, size_t offset);
+
 /**
  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
  * @page:	Pointer to the page to be mapped
-- 
2.30.2

