Return-Path: <linux-fsdevel+bounces-26033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC89952BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38BAB2196C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66FC1DE874;
	Thu, 15 Aug 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="yMRjZUSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BB1BE246;
	Thu, 15 Aug 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712971; cv=none; b=QieHRadS+vZb6eJoKiIe4emkgdaLB5wKiSyZih3dtTnLHAykiTfZob+bcK5Xe4vNH1byqHf3ZNgZJt60WBXzpkpgaotm8nzQDbGvyME6WOgNeaySATm8LMzfcwSKVj53nMEYm91oNhddVNH487l8cJSlwqz0UJQkJfW/PnWFWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712971; c=relaxed/simple;
	bh=Jadkut4ApW0mWOJoHNcP94ee6jMwQdv75HdW5y5euek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHJIUhcQWHK1qW8px/bOBtYlUmbpAvzh8Rix+q30wgvl4WXTAXVzgNOYFDtNhjuICAETYsFDphv1dKdPrRU5nlAor6W59E4nMg3FD/PJW0t12OJ8JPAxI+iQKMY72erXpFLy89ZngPAsfLsYxOvKloRORhblWvjlKeAsxtwaaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=yMRjZUSU; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WkzpC6TlNz9sq4;
	Thu, 15 Aug 2024 11:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7rWLiCMk4lxgxSKZFr+zzX4eLbJPbbhmvYIIxBW16M=;
	b=yMRjZUSUQXF3Rda1rlgQdRKTREHf0kEK87df0GQFEuTKR9jkjxv5/+nEzFABFSjMvua9OZ
	VvfQ2gD0Sehtvv+nB3rAHNcMroi9LuZxFx85wMNlyrC63JpuY492TrqNtX3X1GrKBoWJuj
	ghvHzH5UH9RXe7CBoNVs19Ra61LdDUkFa/I+p9wqKCpX7TZp9p5w3P2UQUQO5ts8bw9DHG
	yrHcsiTr8kgioUsas89xbTK0YEUrNCNCnVHUN5UqqrDrPxQtBS2uvtboqNoCSVMOnP3uc2
	/v89huMTzWt9fVm4uAAAKX8f/0xR3p5BSdkC0rt4TbwRxvBMUiQ8Iba3Et1xSg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v12 04/10] mm: split a folio in minimum folio order chunks
Date: Thu, 15 Aug 2024 11:08:43 +0200
Message-ID: <20240815090849.972355-5-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

split_folio() and split_folio_to_list() assume order 0, to support
minorder for non-anonymous folios, we must expand these to check the
folio mapping order and use that.

Set new_order to be at least minimum folio order if it is set in
split_huge_page_to_list() so that we can maintain minimum folio order
requirement in the page cache.

Update the debugfs write files used for testing to ensure the order
is respected as well. We simply enforce the min order when a file
mapping is used.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 14 +++++++---
 mm/huge_memory.c        | 59 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89a..7c50aeed05228 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -96,6 +96,8 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
 
+#define split_folio(f) split_folio_to_list(f, NULL)
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PUD_SHIFT PUD_SHIFT
@@ -317,9 +319,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
+int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	return split_huge_page_to_list_to_order(page, NULL, 0);
+	return split_folio(page_folio(page));
 }
 void deferred_split_folio(struct folio *folio);
 
@@ -484,6 +487,12 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
+
+static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
@@ -598,7 +607,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
-#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
-#define split_folio(f) split_folio_to_order(f, 0)
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a49..1a273625eb507 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3082,6 +3082,9 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  * released, or if some unexpected race happened (e.g., anon VMA disappeared,
  * truncation).
  *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
  * Returns -EINVAL when trying to split to an order that is incompatible
  * with the folio. Splitting to order 0 is compatible with all folios.
  */
@@ -3163,6 +3166,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
+		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
@@ -3173,6 +3177,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
+		min_order = mapping_min_folio_order(folio->mapping);
+		if (new_order < min_order) {
+			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
+				     min_order);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
@@ -3285,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	unsigned int min_order = 0;
+
+	if (folio_test_anon(folio))
+		goto out;
+
+	if (!folio->mapping) {
+		if (folio_test_pmd_mappable(folio))
+			count_vm_event(THP_SPLIT_PAGE_FAILED);
+		return -EBUSY;
+	}
+
+	min_order = mapping_min_folio_order(folio->mapping);
+out:
+	return split_huge_page_to_list_to_order(&folio->page, list,
+							min_order);
+}
+
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -3515,6 +3546,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 		struct folio *folio;
+		struct address_space *mapping;
+		unsigned int target_order = new_order;
 
 		if (!vma)
 			break;
@@ -3535,7 +3568,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!is_transparent_hugepage(folio))
 			goto next;
 
-		if (new_order >= folio_order(folio))
+		if (!folio_test_anon(folio)) {
+			mapping = folio->mapping;
+			target_order = max(new_order,
+					   mapping_min_folio_order(mapping));
+		}
+
+		if (target_order >= folio_order(folio))
 			goto next;
 
 		total++;
@@ -3551,9 +3590,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!folio_test_anon(folio) && folio->mapping != mapping)
+			goto unlock;
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
+unlock:
 		folio_unlock(folio);
 next:
 		folio_put(folio);
@@ -3578,6 +3621,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	pgoff_t index;
 	int nr_pages = 1;
 	unsigned long total = 0, split = 0;
+	unsigned int min_order;
 
 	file = getname_kernel(file_path);
 	if (IS_ERR(file))
@@ -3591,9 +3635,11 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		 file_path, off_start, off_end);
 
 	mapping = candidate->f_mapping;
+	min_order = mapping_min_folio_order(mapping);
 
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
+		unsigned int target_order = new_order;
 
 		nr_pages = 1;
 		if (IS_ERR(folio))
@@ -3602,18 +3648,23 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (!folio_test_large(folio))
 			goto next;
 
+		target_order = max(new_order, min_order);
 		total++;
 		nr_pages = folio_nr_pages(folio);
 
-		if (new_order >= folio_order(folio))
+		if (target_order >= folio_order(folio))
 			goto next;
 
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (folio->mapping != mapping)
+			goto unlock;
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
+unlock:
 		folio_unlock(folio);
 next:
 		folio_put(folio);
-- 
2.44.1


