Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9127F373F29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhEEQFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEEQFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:05:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A55C061574;
        Wed,  5 May 2021 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ruJMZgf1MOFrHiDvESe412bw0xTvpBkcG4kkfAZLeaU=; b=vqG2v2EXyQGrKoSpj5ZhAol8Og
        mXo8O37ehL+aQQeN9HbjeaNnNFx8Ww1h+jFXt8p6zHN4eLE9UYUucRJ6iFa/rn7/6KSnFeaAxvt8f
        9PS1AoNDWXHVQO4Gxikdl41K8gW/Dn6WI5En7iBwCA4Wvcy953NvijioqSGihnFVdNxUoX88LnsSS
        gXWSYwE1me65tCCzc1hEsdSlQmBhVW5eTvTLddQrgEoTfRgPJI1ILPKKjbeciQiUWfQU49nV+0Lcm
        o8Q8xR6ezD14DYIfZXGbHD0KtnUAsF/lToxSKUJ86yITs/KjBwnEG3r9BRgvKZPBxULcNoO8rjj7z
        nhzrr61w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJyP-000YhJ-Ef; Wed, 05 May 2021 16:02:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 45/96] mm: Add kmap_local_folio
Date:   Wed,  5 May 2021 16:05:37 +0100
Message-Id: <20210505150628.111735-46-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows us to map a portion of a folio.  Callers can only expect
to access up to the next page boundary.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem-internal.h | 11 +++++++++
 include/linux/highmem.h          | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 7902c7d8b55f..39cdcfdbc23a 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+{
+	struct page *page = nth_page(&folio->page, offset / PAGE_SIZE);
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
index b06eeeaee975..b01deb45d265 100644
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

