Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCB3CAE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhGOUme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbhGOUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:42:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D86C061762
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iQqpnTwxqRXjD5hes7UseJQTEUIrkCuby3ucZ182rzs=; b=uitKHfs4H4unpnN+CyQ+ciCnHD
        ugtp6nC6T3j5xuzinFXn0KNevuOZXhhV1diCij61FWBE5V3P1BvUzz0RsQ1ALQz/7zaVWfRUG0Qil
        ehEEoBTOSLRO33ey/rJqwY0DRsRkb48OIXf+GNaTbwDC8sfOXVWI3aMkARGnkdHc0sbdQT6PpnBUj
        v67qvTEHXIwV4RgVgJtA8jlp+w6RB89/A/UXkw0yb9Br+/U3ZXC+TOQc/BwXauoWlRqzqGbqwzrj1
        YH5EH6BKmgC0VXxHf6s9Hv7dRSEHc+3w6u1AVPAEnTg2Af0PeyudfP+Ia4BPqJL8jgdvsQvJ2/PNY
        s2EgM79A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m481R-003qBz-9S; Thu, 15 Jul 2021 20:32:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 31/39] mm: Add folio_evictable()
Date:   Thu, 15 Jul 2021 21:00:22 +0100
Message-Id: <20210715200030.899216-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_evictable().  Unfortunately, it's
different from !folio_test_unevictable(), but I think it's used in places
where you have to be a VM expert and can reasonably be expected to know
the difference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/internal.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 08e8a28994d1..0910efec5821 100644
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
+ * 1. folio's mapping marked unevictable
+ * 2. One of the pages in the folio is part of an mlocked VMA
  */
+static inline bool folio_evictable(struct folio *folio)
+{
+	bool ret;
+
+	/* Prevent address_space of inode and swap cache from being freed */
+	rcu_read_lock();
+	ret = !mapping_unevictable(folio_mapping(folio)) &&
+			!folio_test_mlocked(folio);
+	rcu_read_unlock();
+	return ret;
+}
+
 static inline bool page_evictable(struct page *page)
 {
 	bool ret;
-- 
2.30.2

