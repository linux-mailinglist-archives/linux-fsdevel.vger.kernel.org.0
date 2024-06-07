Return-Path: <linux-fsdevel+bounces-21243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D251900807
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A7A2876DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8219CCF6;
	Fri,  7 Jun 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZdAYb2mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4919B588;
	Fri,  7 Jun 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772375; cv=none; b=I3/JXWVfODVulv5IPFZE5CTOjtvC6QcCFvMR5+j1M+HD2OfR/blC9nRJgoXXJ7N8Zz/W1+kW2c1Swul+cdIlAJkxkKOtrXBU0/0HkT0u0elTJ2+4ZQKZfdMr3dXD/e0mIXDuDyaGgbAPQqF8/hpiVKdxYiz2t6C1bSKq5FaYAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772375; c=relaxed/simple;
	bh=cUwl+gKnOGZxD+G98FbkalmaaqTnrOMVBvb2xSPyGhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxJ4U0AchudDukuPDtGnUYPQx15iZApOukP1/EvZvfzaoPmXhdowz13YGB1l6bP4DMzJFViEw77L3YVrjDNxhGONc6LK++7H5sPgEHF0AVmFXLbCtS+q3oJ/PWm+om70q3VQlH9I76+2UpOWZPagpnx/AxJm00lFK1B5ghBAwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZdAYb2mh; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vwkr25d11z9sSR;
	Fri,  7 Jun 2024 16:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zln41o0VnudScHG2dePgG7Ab473xEOkNPoWQiBNMdss=;
	b=ZdAYb2mhM8DTD+9gaL5oSO2ufutF9jYKZ4LaFL+Ccv/WLe0FxfLHgOJ2jz8hJmq+zFaFfH
	1DVnmqnhsPB7nK4CJPGkYUR7AAH4trDdVYczePkfKc9SwfSuTYQRG9XfxAdqWCS4uKbdPc
	EKynLmDvK1hp0uwUe1uRCT48T8M5mXIOp70Iqha+WDTuuS1TuKD/kmNr20ot2lHMs99dsg
	YsfCd9qdPR+rjscTKB5m/S9/AvrAKtbO/ioMY54a+NgvHIp61f28fwKq4nfgw0CrqMugOj
	5XfVNAGPgRGXSEOPhIpFcNWG9shvhG2c1Tw94MlE9I9bl9XDCueBioKoU38Tmg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Date: Fri,  7 Jun 2024 14:58:56 +0000
Message-ID: <20240607145902.1137853-6-kernel@pankajraghav.com>
In-Reply-To: <20240607145902.1137853-1-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vwkr25d11z9sSR

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
---
 include/linux/huge_mm.h | 14 ++++++++---
 mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 020e2344eb86..15caa4e7b00e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -88,6 +88,8 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
 
+#define split_folio(f) split_folio_to_list(f, NULL)
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PUD_SHIFT PUD_SHIFT
@@ -307,9 +309,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
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
 
@@ -474,6 +477,12 @@ static inline int split_huge_page(struct page *page)
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
@@ -578,7 +587,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
-#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
-#define split_folio(f) split_folio_to_order(f, 0)
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e49f402d7c7..399a4f5125c7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3068,6 +3068,9 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  * released, or if some unexpected race happened (e.g., anon VMA disappeared,
  * truncation).
  *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
  * Returns -EINVAL when trying to split to an order that is incompatible
  * with the folio. Splitting to order 0 is compatible with all folios.
  */
@@ -3143,6 +3146,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
+		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
@@ -3153,6 +3157,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
 
@@ -3264,6 +3276,21 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -3493,6 +3520,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 		struct folio *folio;
+		struct address_space *mapping;
+		unsigned int target_order = new_order;
 
 		if (!vma)
 			break;
@@ -3513,7 +3542,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
@@ -3529,9 +3564,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
@@ -3556,6 +3595,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	pgoff_t index;
 	int nr_pages = 1;
 	unsigned long total = 0, split = 0;
+	unsigned int min_order;
 
 	file = getname_kernel(file_path);
 	if (IS_ERR(file))
@@ -3569,9 +3609,11 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		 file_path, off_start, off_end);
 
 	mapping = candidate->f_mapping;
+	min_order = mapping_min_folio_order(mapping);
 
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
+		unsigned int target_order = new_order;
 
 		nr_pages = 1;
 		if (IS_ERR(folio))
@@ -3580,18 +3622,23 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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


