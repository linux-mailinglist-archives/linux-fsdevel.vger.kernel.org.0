Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867002DC660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgLPSZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgLPSZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE56C0619D7;
        Wed, 16 Dec 2020 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pdx6lYxeD1EW2wljUgpbb5DjEhz77Vz6Uwdtyq++/2E=; b=WLRTNy4RHQwlqEvtD8WvIZwTXE
        ai5BeoUNEB9KiNCBTDffKOTHcFrP9LGi47yySqEB8aXno4JthM75NCoOkbSUlaI5+pH4PaNakMui3
        UHuTD4hQZ0ym4V5HMQKBcrXdGuIQk+8JKMN4rQ35ItiWy6VFm3lvKZHAnDBcjjOvQwo98BFhJcg/E
        bTewMZTFdQr2T/klVLLvo8axWRXr74xuWvo7DRkBF5vNyQ5mBFeSI1vZtZypJwAEBqhQSM/9umP1Z
        SfqfWygyz9YyAcxdBVIoW4+mZoVTlZBSlr4AasY4+eqVt8AmOQgInt/uSnHEj5Asn9VIOwhpTpCsE
        W3chTQig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSi-000790-Te; Wed, 16 Dec 2020 18:23:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] mm: Add flush_dcache_folio
Date:   Wed, 16 Dec 2020 18:23:33 +0000
Message-Id: <20201216182335.27227-24-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
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
 include/asm-generic/cacheflush.h    | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index a1582cc79f0f..484cf31fcded 100644
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
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4a674db4e1fa..5537ea24333d 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -49,9 +49,22 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
 static inline void flush_dcache_page(struct page *page)
 {
 }
+
+static inline void flush_dcache_folio(struct folio *folio) { }
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 #endif
 
+#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	unsigned int n = folio_nr_pages(folio);
+
+	do {
+		flush_dcache_page(&folio->page[--n]);
+	} while (n);
+}
+#endif
 
 #ifndef flush_dcache_mmap_lock
 static inline void flush_dcache_mmap_lock(struct address_space *mapping)
-- 
2.29.2

