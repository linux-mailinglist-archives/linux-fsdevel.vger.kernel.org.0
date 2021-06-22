Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EE3B0533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFVMxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFVMxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:53:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B6C061574;
        Tue, 22 Jun 2021 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+OaQAmOpbAmE8t7mu+LKDjA9tzdjfko1XYfFGUdSf/8=; b=eAva0WJiUk1v5UQOf0a6Sky9AG
        q2wiOxQ480IkG52D7IBtQuHnC3le87IrWA1aub6fRXe3O/IpuArHgwG03MPWfTl6mJD9nqFhDdSXU
        HCo21NT4TLvzg7n2TUdCM7yGACwtj8Nsi5WdUZer1UPCmRvRGqe/TnLXEZtZ8hOpYd2vdE4tVYjuC
        3uRysgeYDLqXF1gB3gJW6Rn/7RlEvVODp5P9DK6ZtHTggSDTEPFYIEjrzK+y12S5Aa87p1fvCvSjM
        JhZOSM7Tzs+rVw1UQd3z8i3z+GLF1xJMsiaIRsbK/hXnbQZyoxWt1Jbu9KcD+a9Ze7lSnURS2qL8G
        SrRFvIVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfqa-00EIm3-VW; Tue, 22 Jun 2021 12:49:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/46] mm: Add folio_evictable()
Date:   Tue, 22 Jun 2021 13:15:43 +0100
Message-Id: <20210622121551.3398730-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_evictable().  Unfortunately, it's
different from !folio_unevictable(), but I think it's used in places
where you have to be a VM expert and can reasonably be expected to know
the difference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d7013df5d1f0..3b0ab6b5457c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -72,17 +72,28 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
 /**
- * page_evictable - test whether a page is evictable
- * @page: the page to test
+ * folio_evictable - Test whether a folio is evictable.
+ * @folio: The folio to test.
  *
- * Test whether page is evictable--i.e., should be placed on active/inactive
- * lists vs unevictable list.
- *
- * Reasons page might not be evictable:
- * (1) page's mapping marked unevictable
- * (2) page is part of an mlocked VMA
+ * Test whether @folio is evictable -- i.e., should be placed on
+ * active/inactive lists vs unevictable list.
  *
+ * Reasons folio might not be evictable:
+ * 1. page's mapping marked unevictable
+ * 2. page is part of an mlocked VMA
  */
+static inline bool folio_evictable(struct folio *folio)
+{
+	bool ret;
+
+	/* Prevent address_space of inode and swap cache from being freed */
+	rcu_read_lock();
+	ret = !mapping_unevictable(folio_mapping(folio)) &&
+			!folio_mlocked(folio);
+	rcu_read_unlock();
+	return ret;
+}
+
 static inline bool page_evictable(struct page *page)
 {
 	bool ret;
-- 
2.30.2

