Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842B8298641
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422308AbgJZEqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:46:48 -0400
Received: from casper.infradead.org ([90.155.50.34]:60152 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420397AbgJZEqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9bKO5BckbV2VgZEPlLHdw6VBrK4Lqq5F1PqASZdfsOM=; b=Ey6vT/qVSvLtYtAoug5KdK8/6G
        8W/I0yNq/9wpoa/ehFJwTBHli/jCgivAtVJwE/IMsAwnpPXMOfTsy3SCpCSFreHy/QxbmTKH4sOOr
        GWZ3ZF6zacfETzOZIrnLy08dmDVrPB8DtSc7kAcxat4huRs1tEkOaYII8Rh/FWny/nV+0UWqdUTdt
        dyZUy9tTisfmD451aembuaGjkr6RI58W4TIhlCfDTAwfqjpMDyBjIToe9qdVUEMwkchh49TZmURQf
        4VSv+/NcRllyqi1PDGk97f2hoLelt0hsp4Xna6idX1cNXtC+Am4nWkBlVNavwGdjqWDXCox97PFCk
        lIISRdvg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttc-0006ac-Dx; Mon, 26 Oct 2020 04:14:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 10/12] mm: Remove pagevec_lookup_entries
Date:   Mon, 26 Oct 2020 04:14:06 +0000
Message-Id: <20201026041408.25230-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
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
index 0c5659c05e6e..8f5623336eb3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1070,44 +1070,12 @@ void __pagevec_lru_add(struct pagevec *pvec)
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
index c4a3c9d6a0c1..a96e44a5ce59 100644
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

