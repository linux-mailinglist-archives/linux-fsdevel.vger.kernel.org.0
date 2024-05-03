Return-Path: <linux-fsdevel+bounces-18590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E28BAA44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C82C283AC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D6152168;
	Fri,  3 May 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERDQV5qf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9B282EE;
	Fri,  3 May 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730044; cv=none; b=QIqKdcB6DTUo8KMkGFxD8eLTBTmDkiEIut0Op7axP1NFNbT6TaiKXWs7W0vlhHEJmkBSzJcEaRObCdSc/6/Mcu/z3IzQzsWRq5wehisAN7M9rJsfG+5ErwFUTkXBde/+i1Rzwn6sBGLz3bOwVZedLfybvO14mTWt1rXWLaBfXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730044; c=relaxed/simple;
	bh=gEbBORbEnhN5ctc0kra2/ejLF8Fn9FyjdP0qpmH85kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk0m6mHgMnMQ/N/u2lvcgXOnEbHNvoskeF7nn1Ky6RLyELSyKsz2AEiXzpy6i8ydiGp3Wll1KvC19SMS3HjaqjsFdcrSrUAqaZePWVNpSenT7TjaFF7E4R1DFeoiTbBzHuN1au2wW1LZF4HU8vQM/wSjOlKIBG0ZTVibv11mLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ERDQV5qf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4I9xqhTy2lFMzABeOddmnumdvFNlTh4tfqYx9OGQOzQ=; b=ERDQV5qfxEQHLjpvZHSwQlvFVW
	/w89WTHFzx2qowoqlcIaD3WLdLj2cnvL+gDbVmEifTdEIu4xIR09zhDBobRvkK1tZG2yG6Vydn1jb
	qpoe813VDwBJ31mJFbVwxU00mqf8jA+7S0khgN2NyNv7afb0Wx0v/UZcQMM/plI7HtLhTFFcfPlfh
	0KJfgzdPiPwyxU3xS6vz+mDI3MgBX7ELgK8ghzPEwHGitM5Ke1RUSlhjkkNUObMCkZV3nCQxbYQDS
	MJGXiVvH4D/DAkF9rl3xIso/903CJYKq/at2hIu2eHYQZ1VU7q/gUVX0TC8IurL29fpVZH+sC2rlE
	MxOwOfvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc3-0000000Fw3i-0pnP;
	Fri, 03 May 2024 09:53:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 05/11] mm: split a folio in minimum folio order chunks
Date: Fri,  3 May 2024 02:53:47 -0700
Message-ID: <20240503095353.3798063-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

split_folio() and split_folio_to_list() assume order 0, to support
minorder we must expand these to check the folio mapping order and use
that.

Set new_order to be at least minimum folio order if it is set in
split_huge_page_to_list() so that we can maintain minimum folio order
requirement in the page cache.

Update the debugfs write files used for testing to ensure the order
is respected as well. We simply enforce the min order when a file
mapping is used.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/huge_mm.h | 12 ++++++----
 mm/huge_memory.c        | 50 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..06748a8fa43b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -87,6 +87,8 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
 
+#define split_folio(f) split_folio_to_list(f, NULL)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
@@ -267,9 +269,10 @@ void folio_prep_large_rmappable(struct folio *folio);
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
 
@@ -432,6 +435,10 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
+static inline int split_folio_to_list(struct page *page, struct list_head *list)
+{
+	return 0;
+}
 static inline void deferred_split_folio(struct folio *folio) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
@@ -532,9 +539,6 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
-#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
-#define split_folio(f) split_folio_to_order(f, 0)
-
 /*
  * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
  * limitations in the implementation like arm64 MTE can override this to
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 89f58c7603b2..c0cc8f32fe42 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3035,6 +3035,9 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  * Returns 0 if the hugepage is split successfully.
  * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
  * us.
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set.
  */
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 				     unsigned int new_order)
@@ -3107,6 +3110,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
+		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
@@ -3117,6 +3121,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
 
@@ -3227,6 +3239,21 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	unsigned int min_order = 0;
+
+	if (!folio_test_anon(folio)) {
+		if (!folio->mapping) {
+			count_vm_event(THP_SPLIT_PAGE_FAILED);
+			return -EBUSY;
+		}
+		min_order = mapping_min_folio_order(folio->mapping);
+	}
+
+	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
+}
+
 void folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -3466,6 +3493,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 		struct folio *folio;
+		unsigned int target_order = new_order;
 
 		if (!vma)
 			break;
@@ -3502,7 +3530,18 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!folio_test_anon(folio)) {
+			unsigned int min_order;
+
+			if (!folio->mapping)
+				goto next;
+
+			min_order = mapping_min_folio_order(folio->mapping);
+			if (new_order < target_order)
+				target_order = min_order;
+		}
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
 		folio_unlock(folio);
@@ -3545,14 +3584,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
+		unsigned int min_order, target_order = new_order;
 
 		nr_pages = 1;
 		if (IS_ERR(folio))
 			continue;
 
-		if (!folio_test_large(folio))
+		if (!folio->mapping || !folio_test_large(folio))
 			goto next;
 
+		min_order = mapping_min_folio_order(mapping);
+		if (new_order < min_order)
+			target_order = min_order;
+
 		total++;
 		nr_pages = folio_nr_pages(folio);
 
@@ -3562,7 +3606,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
 		folio_unlock(folio);
-- 
2.43.0


