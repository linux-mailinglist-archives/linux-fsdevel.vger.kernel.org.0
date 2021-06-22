Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703D03B042A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFVMXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFVMXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:23:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EA3C061574;
        Tue, 22 Jun 2021 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p82Ff5dDat6fw/NBmOQCBBhVAE9uyWfLJnpUxsS9pTo=; b=faHbgfKdkPTQpAaAW8pW8Z7lpg
        8cOV045c4TNJsrXhgj8+ZtOmH9SRGVv1t+NA8e+oapSGx2q4kkqxMJZGef133JUxW3trurBrLuwVc
        qS5UNznW8JpDtWjj9rYIQvY69oO7gcGNVl2ZYSbmRmWSx6cT1LgVvBP7s6CIa3mxMPhQfNV6hTIOd
        BgZGxdcySMz2NXBZhBb7uP4cv3tK6JWtIsgMleoTOX1kapf6xB2OEYBjWfilxbO1WwOQpqkXpvtv0
        FNPLOmtCh5ETLCIKswSwXGhC4Rw/qjm84c99m0Z3nRBzSgzvuzhHQVhM+9rlDck92qdtSm14QxjXc
        1ZPW442Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfND-00EGSB-B6; Tue, 22 Jun 2021 12:19:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/46] mm: Add flush_dcache_folio()
Date:   Tue, 22 Jun 2021 13:15:09 +0100
Message-Id: <20210622121551.3398730-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a default implementation which calls flush_dcache_page() on
each page in the folio.  If architectures can do better, they should
implement their own version of it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/cachetlb.rst |  6 ++++++
 arch/nds32/include/asm/cacheflush.h |  1 +
 include/asm-generic/cacheflush.h    |  6 ++++++
 mm/util.c                           | 13 +++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index fe4290e26729..29682f69a915 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -325,6 +325,12 @@ maps this page at its virtual address.
 			dirty.  Again, see sparc64 for examples of how
 			to deal with this.
 
+  ``void flush_dcache_folio(struct folio *folio)``
+	This function is called under the same circumstances as
+	flush_dcache_page().  It allows the architecture to
+	optimise for flushing the entire folio of pages instead
+	of flushing one page at a time.
+
   ``void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
   unsigned long user_vaddr, void *dst, void *src, int len)``
   ``void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 7d6824f7c0e8..f10d13af4ae5 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -38,6 +38,7 @@ void flush_anon_page(struct vm_area_struct *vma,
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 void flush_kernel_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
 void flush_kernel_vmap_range(void *addr, int size);
 void invalidate_kernel_vmap_range(void *addr, int size);
 #define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4a674db4e1fa..fedc0dfa4877 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -49,9 +49,15 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
 static inline void flush_dcache_page(struct page *page)
 {
 }
+
+static inline void flush_dcache_folio(struct folio *folio) { }
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 #endif
 
+#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+void flush_dcache_folio(struct folio *folio);
+#endif
 
 #ifndef flush_dcache_mmap_lock
 static inline void flush_dcache_mmap_lock(struct address_space *mapping)
diff --git a/mm/util.c b/mm/util.c
index 0ba3a56c2c90..cae22295c41f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1007,3 +1007,16 @@ void mem_dump_obj(void *object)
 }
 EXPORT_SYMBOL_GPL(mem_dump_obj);
 #endif
+
+#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+void flush_dcache_folio(struct folio *folio)
+{
+	unsigned int n = folio_nr_pages(folio);
+
+	do {
+		n--;
+		flush_dcache_page(folio_page(folio, n));
+	} while (n);
+}
+EXPORT_SYMBOL(flush_dcache_folio);
+#endif
-- 
2.30.2

