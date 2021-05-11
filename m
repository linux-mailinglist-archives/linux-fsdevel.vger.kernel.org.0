Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82D37B118
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEKVyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 17:54:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2DC061574;
        Tue, 11 May 2021 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=THKqHH1zdY71muk4hmu6GV47gBB0ocM5D86wSpfUHEg=; b=pZoG13gCT0H5ScJ9POLSqKFhTx
        x5LsON7Qqy6MoVTsujy3VHiZdZbrh1FM9lEClu/oSoT6XJ7pfUuvVXRJRzMVpH+7xFhTiV0TY3p8O
        DQ7VeTDs+/6Bpfu+4VWEEYqZjXgz/5Ee1YaZYMS7I5nLRk6zW9EJpqZ3dhJFqfGcdZecGuiUbNyG2
        lc8SHQGhu9od6TouZ3YUB+JqBT6CrwSB9wQsprQHEQNwATjkQDmqDDLnU22Z2zZIDRctvUKcdsQoo
        6Ci9StYmrgTSMQyM51iq7NUMykzqZ66fByHemKxvcuU6d1JeCEBo6hEsakphKgz/lrsFO94Dde+Rd
        vjZU6uFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaI2-007hqn-AY; Tue, 11 May 2021 21:51:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 07/33] mm: Add folio_get
Date:   Tue, 11 May 2021 22:47:09 +0100
Message-Id: <20210511214735.1836149-8-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_get() instead
of get_page() and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 610948f0cb43..feb4645ef4f2 100644
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

