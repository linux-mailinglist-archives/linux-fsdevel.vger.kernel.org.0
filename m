Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B92B104D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKLV0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgKLV0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28AC0613D1;
        Thu, 12 Nov 2020 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qbzmVFagUCXYcU5rqtSiOvPsAwsTj6kZyDh1iXpm+g8=; b=crwQX+ofqsb4dwJIDejthD3rlI
        DfM1w6S4JFiJhDoILV7BLJ8eA/dmU2eThfVU39XCsCt23dHYcQlwEWw1EIKOnK6lp1fDK9mQaElvX
        A9/hA1zBksSTeN0qL4XJIdgBUSS/CMxV6eqidkNLja4FT+ciQzk38m622FhtcyOc8Uoo/YguzCf4w
        +z1pPgjU0XhG/Zq5hcbrE3oQa7CkaK5hPqRk1gMLI3XldOygpSoHx/6diRSxUhNxWMuRd/7mdTdjZ
        ZndubeNT/0NmVYgvpWR1LSOzUS5QiIoySacMtm8rz+Yaepr/jS4xKWHfCs0d17D9qV6wj1dlZLwlC
        jFrOHkXg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7H-0007Hx-A1; Thu, 12 Nov 2020 21:26:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 16/16] mm/filemap: Return only head pages from find_get_entries
Date:   Thu, 12 Nov 2020 21:26:41 +0000
Message-Id: <20201112212641.27837-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers now expect head (and base) pages, and can handle multiple
head pages in a single batch, so make find_get_entries() behave that way.
Also take the opportunity to make it use the pagevec infrastructure
instead of open-coding how pvecs behave.  This has the side-effect of
being able to append to a pagevec with existing contents, although we
don't make use of that functionality anywhere yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 36 ++++++++----------------------------
 mm/internal.h           |  2 ++
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 46d4b1704770..65ef8db8eaab 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -448,8 +448,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 479cbbadd93b..f8c294905e8d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1878,49 +1878,29 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
  * the mapping.  The entries are placed in @pvec.  find_get_entries()
  * takes a reference on any actual pages it returns.
  *
- * The search returns a group of mapping-contiguous page cache entries
- * with ascending indexes.  There may be holes in the indices due to
- * not-present pages.
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries or THPs.
  *
  * Any shadow entries of evicted pages, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
- * If it finds a Transparent Huge Page, head or tail, find_get_entries()
- * stops at that page: the caller is likely to have a better way to handle
- * the compound page as a whole, and then skip its extent, than repeatedly
- * calling find_get_entries() to return all its tails.
- *
- * Return: the number of pages and shadow entries which were found.
+ * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
-		/*
-		 * Terminate early on finding a THP, to allow the caller to
-		 * handle it all at once; but continue if this is hugetlbfs.
-		 */
-		if (!xa_is_value(page) && PageTransHuge(page) &&
-				!PageHuge(page)) {
-			page = find_subpage(page, xas.xa_index);
-			nr_entries = ret + 1;
-		}
-
-		indices[ret] = xas.xa_index;
-		pvec->pages[ret] = page;
-		if (++ret == nr_entries)
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, page))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return pagevec_count(pvec);
 }
 
 /**
@@ -1939,8 +1919,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * not returned.
  *
  * The entries have ascending indexes.  The indices may not be consecutive
- * due to not-present entries, THP pages, pages which could not be locked
- * or pages under writeback.
+ * due to not-present entries, THPs, pages which could not be locked or
+ * pages under writeback.
  *
  * Return: The number of entries which were found.
  */
diff --git a/mm/internal.h b/mm/internal.h
index cb7487efa856..1f137a5d66bb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -60,6 +60,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
 }
 
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
-- 
2.28.0

