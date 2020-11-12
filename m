Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E362B1060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKLV2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgKLV0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA90C0613D1;
        Thu, 12 Nov 2020 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YC6+GAJwlZFwXSFvTpyJewfs7ChCRtgnJTzrVE7HqTA=; b=Mlht3xsXO+OXXrDiIY94EfipvN
        m1ho5DPy8Pth4aAL18j9U5LwZubRikCMc2tmzM2r1MU1lIf/48LL09WnAUOssXqBHny0i844nH9N8
        x1sHE1JY/zeZSPH//OakqfKIbe4hoE1UGj99ATFbCC4cHhZ7frE11jpeHnuTkDuLuQ7K7Gia4GWS2
        ep6i2E8USP5ffYDH4t1B1U5DztLW4e3tbGoGxD1QPx/3LcXWB/kcy5+Rs8BKu9aR9BWRoSZ5SnKvT
        jag/OPdjvATwWYEKIu4Q1Sb5vnliUEa8HkY6soD9xRXD2F+Q1BeG8+ljKc9AjfQTAwJCKqRVjoxcf
        EvKRTEPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7E-0007HL-NW; Thu, 12 Nov 2020 21:26:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 11/16] mm: Add an 'end' parameter to pagevec_lookup_entries
Date:   Thu, 12 Nov 2020 21:26:36 +0000
Message-Id: <20201112212641.27837-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplifies the callers and uses the existing functionality
in find_get_entries().  We can also drop the final argument of
truncate_exceptional_pvec_entries() and simplify the logic in that
function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagevec.h |  5 ++---
 mm/swap.c               |  8 ++++----
 mm/truncate.c           | 41 ++++++++++-------------------------------
 3 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..4b245592262c 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,9 +26,8 @@ struct pagevec {
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices);
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index 39be55635ebd..5c2c12e3581e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1078,6 +1078,7 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * @pvec:	Where the resulting entries are placed
  * @mapping:	The address_space to search
  * @start:	The starting entry index
+ * @end:	The highest index to return (inclusive).
  * @nr_entries:	The maximum number of pages
  * @indices:	The cache indices corresponding to the entries in @pvec
  *
@@ -1098,11 +1099,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * found.
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices)
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index eefd62898db1..dcaee659fe1a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -57,11 +57,10 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
  * exceptional entries similar to what pagevec_remove_exceptionals does.
  */
 static void truncate_exceptional_pvec_entries(struct address_space *mapping,
-				struct pagevec *pvec, pgoff_t *indices,
-				pgoff_t end)
+				struct pagevec *pvec, pgoff_t *indices)
 {
 	int i, j;
-	bool dax, lock;
+	bool dax;
 
 	/* Handled by shmem itself */
 	if (shmem_mapping(mapping))
@@ -75,8 +74,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		return;
 
 	dax = dax_mapping(mapping);
-	lock = !dax && indices[j] < end;
-	if (lock)
+	if (!dax)
 		xa_lock_irq(&mapping->i_pages);
 
 	for (i = j; i < pagevec_count(pvec); i++) {
@@ -88,9 +86,6 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 			continue;
 		}
 
-		if (index >= end)
-			continue;
-
 		if (unlikely(dax)) {
 			dax_delete_mapping_entry(mapping, index);
 			continue;
@@ -99,7 +94,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		__clear_shadow_entry(mapping, index, page);
 	}
 
-	if (lock)
+	if (!dax)
 		xa_unlock_irq(&mapping->i_pages);
 	pvec->nr = j;
 }
@@ -329,7 +324,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	while (index < end && find_lock_entries(mapping, index, end - 1,
 			&pvec, indices)) {
 		index = indices[pagevec_count(&pvec) - 1] + 1;
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			truncate_cleanup_page(mapping, pvec.pages[i]);
 		delete_from_page_cache_batch(mapping, &pvec);
@@ -381,8 +376,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE), indices)) {
+		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+				PAGEVEC_SIZE, indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -390,23 +385,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			index = start;
 			continue;
 		}
-		if (index == start && indices[0] >= end) {
-			/* All gone out of hole to be punched, we're done */
-			pagevec_remove_exceptionals(&pvec);
-			pagevec_release(&pvec);
-			break;
-		}
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index >= end) {
-				/* Restart punch to make sure all gone */
-				index = start - 1;
-				break;
-			}
 
 			if (xa_is_value(page))
 				continue;
@@ -417,7 +401,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			truncate_inode_page(mapping, page);
 			unlock_page(page);
 		}
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		pagevec_release(&pvec);
 		index++;
 	}
@@ -513,8 +497,6 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				invalidate_exceptional_entry(mapping, index,
@@ -650,16 +632,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end,
+			PAGEVEC_SIZE, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (!invalidate_exceptional_entry2(mapping,
-- 
2.28.0

