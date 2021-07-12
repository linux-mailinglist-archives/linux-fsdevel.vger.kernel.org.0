Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3367E3C632E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhGLTJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbhGLTJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:09:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239FC0613E8;
        Mon, 12 Jul 2021 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WzW5W2Dt/B951jvmY2Dex4Bu1f+cRzgfrBFRxpf9B0M=; b=hcmRoZ0xavoaWMUIfEYvkqAAcO
        qLBbd88eFlf1TNg7p38DI6TwEh2mHLeGWGm5bohzkyOsRoZoG2XP152A5uJfEVWcJt+0+hFFYhkvd
        WljEVIX3HYHfeNVlSKXiQUtqfbw30x6RsAK9pKcfz3UsbVW3q2OtPmIhro8OUEDrUhMqfK7SnyLY5
        8r3JEM5g8xnC0YUYB7pUlN0YPMM5eb2y7IhdMPhHQqDd8Sc5cuowRPZTR2jvVNFDavkEXt8cRVqt8
        skHDds1hGandAE28Aob4OpEFHXdsuLXnyEFh2uUgYrrdqo+Nq6n3IMJCSfvcJM+uf7iikSnTgqGOa
        3SyFYqdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31FZ-000LO0-Iz; Mon, 12 Jul 2021 19:06:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 08/32] mm: Add folio_get()
Date:   Mon, 12 Jul 2021 20:01:40 +0100
Message-Id: <20210712190204.80979-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_get() instead
of get_page() and save the overhead of calling compound_head().
No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/mm.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c981e3b28eb0..4a0d61a0c376 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1222,18 +1222,26 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+
+/**
+ * folio_get - Increment the reference count on a folio.
+ * @folio: The folio.
+ *
+ * Context: May be called in any context, as long as you know that
+ * you have a refcount on the folio.  If you do not already have one,
+ * folio_try_get() may be the right interface for you to use.
+ */
+static inline void folio_get(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	folio_ref_inc(folio);
+}
 
 static inline void get_page(struct page *page)
 {
-	page = compound_head(page);
-	/*
-	 * Getting a normal page or the head of a compound page
-	 * requires to already have an elevated page->_refcount.
-	 */
-	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
-	page_ref_inc(page);
+	folio_get(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.30.2

