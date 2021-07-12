Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0139E3C4203
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhGLDkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhGLDkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:40:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B6C0613DD;
        Sun, 11 Jul 2021 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q3P0tZNKkQBQCHQAnhrC3AbA7cH4qgibd4ubfHlUHLI=; b=QUULptHz3Q+pW1Qkkr1fsNdmrV
        M0FUuLWpDI7QDgensG/OqbmtzsvxLLQE5QiLXEe5UNMhsPoBAGsiA79vfvzQbjzt+iiVgeGQyoZCj
        NSGH22YiKIf12ISj/46ydPfCHMxpLRM4GonCkKVcsgC6ubepRBsHtYRBzZyYD/cawNZcvJfIAdIVx
        OoP0cO6Ky7ufaEd5gHhiuP5a9O9DPaToTo85DODOe4OyDqRxCDSMDAnMne8zQwHVqntxXNGVBOCrG
        9Eo7ScU3vGkF2E1RqI5kAxfcIIXrEdRC8tHELqt5vmWH3ZG8rFtE20jPKlRdMyT86C9NZzkPJM0HR
        11NOp2PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mjh-00Goo0-0x; Mon, 12 Jul 2021 03:36:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 054/137] mm: Add kmap_local_folio()
Date:   Mon, 12 Jul 2021 04:05:38 +0100
Message-Id: <20210712030701.4000097-55-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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

