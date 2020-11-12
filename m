Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53A2B105E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKLV0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgKLV0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CAC0613D4;
        Thu, 12 Nov 2020 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MOhcev08Qr0q0WFBcUAlxQv3z5m+M7Jp4y+munP9EsA=; b=CHIbihY1P2M/Ip+chUtSUhnj3r
        elD6u7bsS9+RzgTnl0LJCsB2RDtvlKb/+FO69euC9vy1E3NlerVYFVjsiEGnTP1A4MWEdMHWHygHD
        Ndv51Z65hEpInchnaYCGWnWG4KLGe9ZLqfKTKBcyboFB7bk0ORTAmoDL4oDne4UWWwNduDwKrtcuk
        tp3f+pO5bImAQqt9oneNQYyOXWiubs66lAQ+73plyA/m5OTZUTNw+ElLdntFoQ/S1zRiV28vyBUjX
        ypR0pp2gkQttKWVfxGupREgDAXSNa2Bq9G3sYKzOJQ8ZekiODCTlFjvA5W3dsslgQmn8diNXHHsQs
        RuC5wYfw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7F-0007Ha-GX; Thu, 12 Nov 2020 21:26:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 13/16] mm: Pass pvec directly to find_get_entries
Date:   Thu, 12 Nov 2020 21:26:38 +0000
Message-Id: <20201112212641.27837-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers of find_get_entries() use a pvec, so pass it directly
instead of manipulating it in the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  3 +--
 mm/filemap.c            | 21 +++++++++------------
 mm/shmem.c              |  5 ++---
 mm/swap.c               |  4 +---
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c7c26a902743..46d4b1704770 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -449,8 +449,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 }
 
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices);
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index b3b89a62ab1a..479cbbadd93b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1871,14 +1871,12 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
  * @end:	The final page index (inclusive).
- * @nr_entries:	The maximum number of entries
- * @entries:	Where the resulting entries are placed
+ * @pvec:	Where the resulting entries are placed.
  * @indices:	The cache indices corresponding to the entries in @entries
  *
- * find_get_entries() will search for and return a group of up to
- * @nr_entries entries in the mapping.  The entries are placed at
- * @entries.  find_get_entries() takes a reference against any actual
- * pages it returns.
+ * find_get_entries() will search for and return a batch of entries in
+ * the mapping.  The entries are placed in @pvec.  find_get_entries()
+ * takes a reference on any actual pages it returns.
  *
  * The search returns a group of mapping-contiguous page cache entries
  * with ascending indexes.  There may be holes in the indices due to
@@ -1895,15 +1893,12 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
  * Return: the number of pages and shadow entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, unsigned int nr_entries, struct page **entries,
-		pgoff_t *indices)
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned int ret = 0;
-
-	if (!nr_entries)
-		return 0;
+	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
@@ -1918,11 +1913,13 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		}
 
 		indices[ret] = xas.xa_index;
-		entries[ret] = page;
+		pvec->pages[ret] = page;
 		if (++ret == nr_entries)
 			break;
 	}
 	rcu_read_unlock();
+
+	pvec->nr = ret;
 	return ret;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 7a62dc967d7d..e01457988dd6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -965,9 +965,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index, end - 1,
-				PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr) {
+		if (!find_get_entries(mapping, index, end - 1, &pvec,
+				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
diff --git a/mm/swap.c b/mm/swap.c
index 9a562f7fd200..7cf585223566 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1102,9 +1102,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
 		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
-				    pvec->pages, indices);
-	return pagevec_count(pvec);
+	return find_get_entries(mapping, start, end, pvec, indices);
 }
 
 /**
-- 
2.28.0

