Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF83CAD92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbhGOUJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhGOUIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:08:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498FC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MloRg5oPBrJeSIbL/MGGSTulhaa43Wy8eyI2GPXyy80=; b=JJo1JCZ4Zz7wzsbOcHNFi6xWZB
        yPdgFGnzKFLkBSb5PDQfHE19PNzRTYmPkOKl9y3kUqMVbMyzNOyISnM4opThg7YsggLyVPuObwI/N
        kpHD80MPXi3QP2p2cTNwLLrR75mvlZlEumG6UX6wukNMAtcDLRpm8OJ3tP0XbSgALEKhUL/4fuQXZ
        3G2bOTbI4va1BueUBD1TeNYpJlzfGFd7ovLqR9R2WOr5ejv3CD/Q9EUk6sc5D2FDUPZvo37uJOWT2
        iCpuL+V9Nk0xCgr64H/g80T4XVPcltLA6bzcb9HaxfwJLokdm04TYCEVqpG68YNewmcmTHyaYXMiP
        2OILE2zQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47aC-003mJN-KG; Thu, 15 Jul 2021 20:04:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 03/39] mm: Add flush_dcache_folio()
Date:   Thu, 15 Jul 2021 20:59:54 +0100
Message-Id: <20210715200030.899216-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
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
 arch/arm/include/asm/cacheflush.h   |  1 +
 arch/nds32/include/asm/cacheflush.h |  1 +
 include/asm-generic/cacheflush.h    |  6 ++++++
 mm/util.c                           | 13 +++++++++++++
 5 files changed, 27 insertions(+)

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
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 2e24e765e6d3..23bf823376e1 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -290,6 +290,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *folio);
 
 static inline void flush_kernel_vmap_range(void *addr, int size)
 {
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
index d0aa1d9c811e..149537120a91 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1057,3 +1057,16 @@ void page_offline_end(void)
 	up_write(&page_offline_rwsem);
 }
 EXPORT_SYMBOL(page_offline_end);
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

