Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85093C424A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGLDx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGLDx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:53:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BECEC0613DD;
        Sun, 11 Jul 2021 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jo+Y05xHWXOoAJU0n/ZYZ1IsaPufgp8LtPQKSPxNC+I=; b=ZganTg8DeLHxmlQnCfI8MThZpt
        bQyoe9YcGESdDej+tcwLWZSNpokM8zckpgTvO8XMbs1pwVzOqRB8zBbV+njJU2JUOxerJZ4bniZdk
        kn54tId/jVO++JL3NxQTtruD76oCVwlahTkrenaahwXWRZwVN+7oLT6olf2JbnHdWPXb2kSsYbd3y
        QvAVGJPLsbKKt6MH39Yv/Bs4/O1KUxYmIzgegCJhledUC3NkDPZxnGcBLmQmBKLnNb7pV1j//WREd
        FAybUO4q4S5cZfpVbMFO5TyCwce8GYKkNYz52Hk6xsU4FrbmyZwjqdeUr7VuKiqh3kOs0aNerjGXl
        ycD53wnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mxI-00Gpoa-BX; Mon, 12 Jul 2021 03:50:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 080/137] mm: Add folio_evictable()
Date:   Mon, 12 Jul 2021 04:06:04 +0100
Message-Id: <20210712030701.4000097-81-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/internal.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 08e8a28994d1..4c966a8622cb 100644
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

