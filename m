Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3859C2B104C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKLV0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgKLV0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D0C0613D1;
        Thu, 12 Nov 2020 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nPDvTHk8PjzTj2XUJS83GH14pU+C7s3G9UCa3yq16Gg=; b=WMwLcRRLIzEY/GjJ+G32FgsHx5
        KiaxlnHD6t77xFQx7BG9Nkim1OczitEh18vJdbN5RQSEcy5cpy946x77uW8wHJzzcUrDXtGJnooDn
        /VK0mHBye057ztpFIfZupOhzLaSeIaLx3CmnDdU7ykPw6xYaPW4jgNe0S4+SVWdTc26UB4JRpbc0m
        09HHSiGae29bQ/CP5vrWPYtrof0GN2+umIWSmmhoYCMr9TxGsNCtGEpN57E3mgAc56usPr2rXhHAw
        HgE+hSvH0QHqfRxw9E4zkvthMYQYXpYcA5NXJ91BD7uLoaIed5wBaueEzQY9HheNRcQ1xmGP7s3R3
        oucS1wQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7G-0007Hj-8A; Thu, 12 Nov 2020 21:26:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 14/16] mm: Remove pagevec_lookup_entries
Date:   Thu, 12 Nov 2020 21:26:39 +0000
Message-Id: <20201112212641.27837-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pagevec_lookup_entries() is now just a wrapper around find_get_entries()
so remove it and convert all its callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagevec.h |  3 ---
 mm/swap.c               | 36 ++----------------------------------
 mm/truncate.c           |  4 ++--
 3 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index ce77724a2ab7..a45bea4b4d08 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -25,9 +25,6 @@ struct pagevec {
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
-unsigned pagevec_lookup_entries(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index 7cf585223566..14c3bac607a6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1073,44 +1073,12 @@ void __pagevec_lru_add(struct pagevec *pvec)
 	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
 }
 
-/**
- * pagevec_lookup_entries - gang pagecache lookup
- * @pvec:	Where the resulting entries are placed
- * @mapping:	The address_space to search
- * @start:	The starting entry index
- * @end:	The highest index to return (inclusive).
- * @nr_entries:	The maximum number of pages
- * @indices:	The cache indices corresponding to the entries in @pvec
- *
- * pagevec_lookup_entries() will search for and return a group of up
- * to @nr_pages pages and shadow entries in the mapping.  All
- * entries are placed in @pvec.  pagevec_lookup_entries() takes a
- * reference against actual pages in @pvec.
- *
- * The search returns a group of mapping-contiguous entries with
- * ascending indexes.  There may be holes in the indices due to
- * not-present entries.
- *
- * Only one subpage of a Transparent Huge Page is returned in one call:
- * allowing truncate_inode_pages_range() to evict the whole THP without
- * cycling through a pagevec of extra references.
- *
- * pagevec_lookup_entries() returns the number of entries which were
- * found.
- */
-unsigned pagevec_lookup_entries(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		pgoff_t *indices)
-{
-	return find_get_entries(mapping, start, end, pvec, indices);
-}
-
 /**
  * pagevec_remove_exceptionals - pagevec exceptionals pruning
  * @pvec:	The pagevec to prune
  *
- * pagevec_lookup_entries() fills both pages and exceptional radix
- * tree entries into the pagevec.  This function prunes all
+ * find_get_entries() fills both pages and XArray value entries (aka
+ * exceptional entries) into the pagevec.  This function prunes all
  * exceptionals from @pvec without leaving holes, so that it can be
  * passed on to page-only pagevec operations.
  */
diff --git a/mm/truncate.c b/mm/truncate.c
index 50d160700b7d..68b7630e1fc4 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -376,7 +376,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+		if (!find_get_entries(mapping, index, end - 1, &pvec,
 				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
@@ -632,7 +632,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
+	while (find_get_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.28.0

