Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEB35A66C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhDIS6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhDIS6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:58:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93501C061762;
        Fri,  9 Apr 2021 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W5g+VwHltNTj8FpdbjCM8nUwZBIK09QAEf3IQR2EfkI=; b=FJcUD5OWaQ1F07avMpHBfY5M8P
        Dq9vUamNO9uOBi0OqHdFa5M2xUIlujch1gP4Sq18agRZ4fX6IET6hmXf5j6GgyKsQjUR8IKsxMd5t
        EaDtTeyd6YmXiw3NF9S+LxAwEPWD/AL+08HNy+h6+BxsoT+MnqnTqTeqIQ63KsR+f5ZlDdkdInC/2
        70NEC6n+CGkiLiUASJbTwLcvZ7IVLlY+YOM+tGQ+6TJ3hNXjPyNeuoIJJKPyn1fRCG/1r3OnTIZ9Y
        gT1c1jbBo8HsZVPKkJKQg8OtRsTEVFx+Z6NWteWLjNbmuWV60+Sfa2510Gievcvh2M9mWVeOlBt3d
        ljYiYDFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwJ1-000nZl-VF; Fri, 09 Apr 2021 18:56:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 08/28] mm: Add get_folio
Date:   Fri,  9 Apr 2021 19:50:45 +0100
Message-Id: <20210409185105.188284-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call get_folio() instead
of get_page() and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 747c6f47aef6..67d9104c1cc1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1219,18 +1219,26 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+
+/**
+ * get_folio - Increment the reference count on a folio.
+ * @folio: The folio.
+ *
+ * Context: May be called in any context, as long as you know that
+ * you have a refcount on the folio.  If you do not already have one,
+ * try_grab_page() may be the right interface for you to use.
+ */
+static inline void get_folio(struct folio *folio)
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
+	get_folio(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.30.2

