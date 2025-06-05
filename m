Return-Path: <linux-fsdevel+bounces-50736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E45ACF029
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F943AE01C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B82376EC;
	Thu,  5 Jun 2025 13:17:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540A2367A4;
	Thu,  5 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129427; cv=none; b=P5u7bOtNAge5f/IzT4TFSi3HW3Ej5Th1QZn3rE1Q/ORUm8UQr+bzSK/2hgWCp51/s4LuG2l/x9fK1LKlr90aZVLp90u8FEnicvy1MjIDnWuD/1b6a6CfD8rKZfERofj707aUSnZIubbLwWAuNXY/5NC0ckgkRHQkFYDADpTa13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129427; c=relaxed/simple;
	bh=SeCGVBa8MCQVeTAkurdC25QXE4GiK+RbVlxLCVJnWiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUn+J8zmqOudZMU0kVoDxpA0NchuylS5S3b+GByZEw4OJn2s+M5Sya1j0tRKpdxXmyBkwpKQLyVH0rpAOvCMeJybQD2g9WhNkbS9uUPw5hCUY3vaX7SJiBdXlJmM/dVp7m+gMZIbOIEOT2I7cfa6cNGM2sFfTHfQcCr97s5JQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bClND0MDrzKHMmb;
	Thu,  5 Jun 2025 21:17:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 68D831A11C0;
	Thu,  5 Jun 2025 21:16:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S5;
	Thu, 05 Jun 2025 21:16:58 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] mm: shmem: avoid missing entries in shmem_undo_range() when entries was splited concurrently
Date: Fri,  6 Jun 2025 06:10:33 +0800
Message-Id: <20250605221037.7872-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250605221037.7872-1-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWrWFy5uF15Cw43Jr1rtFb_yoWxAw1xpF
	WUW3s3GrWrGr4xKrs3A3W8Xr4ag392gay8AFyfG3sxC3ZxJr12kr4qkr1YvFyDurWku3Wv
	qFs0y34j9F4UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsoGQ
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If large swap entry or large folio entry returned from find_get_entries()
is splited before it is truncated, only the first splited entry will be
truncated, leaving the remaining splited entries un-truncated.
To address this issue, we introduce a new helper function
shmem_find_get_entries() which is similar to find_get_entries() but it will
also return order of found entries. Then we can detect entry splitting
after initial search by comparing current entry order with order returned
from shmem_find_get_entries() and retry finding entries if the split is
detectted to fix the issue.
The large swap entry related race was introduced in 12885cbe88dd ("mm:
shmem: split large entry if the swapin folio is not large"). The large
folio related race seems a long-standing issue which may be related to
conversion to xarray, conversion to folio and other changes. As a result,
it's hard to track down the specific commit that directly introduced this
issue.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/filemap.c  |  2 +-
 mm/internal.h |  2 ++
 mm/shmem.c    | 81 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..672844b94d3a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2015,7 +2015,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(__filemap_get_folio);
 
-static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
+struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
 {
 	struct folio *folio;
diff --git a/mm/internal.h b/mm/internal.h
index 6b8ed2017743..9573b3a9e8c0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -446,6 +446,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
+struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
+		xa_mark_t mark);
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
diff --git a/mm/shmem.c b/mm/shmem.c
index f1062910a4de..2349673b239b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -949,18 +949,29 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
  * the number of pages being freed. 0 means entry not found in XArray (0 pages
  * being freed).
  */
-static long shmem_free_swap(struct address_space *mapping,
-			    pgoff_t index, void *radswap)
+static long shmem_free_swap(struct address_space *mapping, pgoff_t index,
+			    int order, void *radswap)
 {
-	int order = xa_get_order(&mapping->i_pages, index);
+	int old_order;
 	void *old;
 
-	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
-	if (old != radswap)
+	xa_lock_irq(&mapping->i_pages);
+	old_order = xa_get_order(&mapping->i_pages, index);
+	/* free swap anyway if input order is -1 */
+	if (order != -1 && old_order != order) {
+		xa_unlock_irq(&mapping->i_pages);
+		return 0;
+	}
+
+	old = __xa_cmpxchg(&mapping->i_pages, index, radswap, NULL, 0);
+	if (old != radswap) {
+		xa_unlock_irq(&mapping->i_pages);
 		return 0;
-	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
+	}
+	xa_unlock_irq(&mapping->i_pages);
 
-	return 1 << order;
+	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << old_order);
+	return 1 << old_order;
 }
 
 /*
@@ -1077,6 +1088,39 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
+/*
+ * Similar to find_get_entries(), but will return order of found entries
+ */
+static unsigned shmem_find_get_entries(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch,
+		pgoff_t *indices, int *orders)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
+		indices[fbatch->nr] = xas.xa_index;
+		if (!xa_is_value(folio))
+			orders[fbatch->nr] = folio_order(folio);
+		else
+			orders[fbatch->nr] = xas_get_order(&xas);
+		if (!folio_batch_add(fbatch, folio))
+			break;
+	}
+
+	if (folio_batch_count(fbatch)) {
+		unsigned long nr;
+		int idx = folio_batch_count(fbatch) - 1;
+
+		nr = 1 << orders[idx];
+		*start = round_down(indices[idx] + nr, nr);
+	}
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -1090,6 +1134,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
+	int orders[PAGEVEC_SIZE];
 	struct folio *folio;
 	bool same_folio;
 	long nr_swaps_freed = 0;
@@ -1113,7 +1158,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				if (unfalloc)
 					continue;
 				nr_swaps_freed += shmem_free_swap(mapping,
-							indices[i], folio);
+						indices[i], -1, folio);
 				continue;
 			}
 
@@ -1166,8 +1211,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
-				indices)) {
+		if (!shmem_find_get_entries(mapping, &index, end - 1, &fbatch,
+				indices, orders)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
@@ -1183,9 +1228,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
+				swaps_freed = shmem_free_swap(mapping,
+					indices[i], orders[i], folio);
+				/*
+				 * Swap was replaced by page or was
+				 * splited: retry
+				 */
 				if (!swaps_freed) {
-					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
@@ -1196,8 +1245,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio_lock(folio);
 
 			if (!unfalloc || !folio_test_uptodate(folio)) {
-				if (folio_mapping(folio) != mapping) {
-					/* Page was replaced by swap: retry */
+				/*
+				 * Page was replaced by swap or was
+				 * splited: retry
+				 */
+				if (folio_mapping(folio) != mapping ||
+				    folio_order(folio) != orders[i]) {
 					folio_unlock(folio);
 					index = indices[i];
 					break;
-- 
2.30.0


