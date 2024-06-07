Return-Path: <linux-fsdevel+bounces-21194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A617F900372
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069D9B27439
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C4194C6A;
	Fri,  7 Jun 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw05mxLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58756194134
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763054; cv=none; b=kw3+lF7BRRoQnggarnOT2PESvmaR+Dx2m8j/rWD6p7JDtqJHviAAN0n6uU6BaZMdax7CdFCwwMDHynceGcaXUmjnLCjFYdtSba1hkMTHvlCDaYaoTbVJW8T7x5lP/b3jFGH64Utryc2RudqU+WWbGu7pZ4Jhb7Iu9eyyr8bHN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763054; c=relaxed/simple;
	bh=bXubjSMDCsk8IHqJafwWQl1Y2CVT+/ayW9XOJGvOu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdZvBpfU/SfGiN84KL7C6GABwPUktsX6kAoBvcexRORDrZ+3n2pBt6ijCvtlFTSF9IrxWc9FMyzxFv4YZLRVgZHW4bnTNs9QMc9BYyrX28LZVmWlxXd/Kt6WcNL08QJOEOY1A017m429bPnwKQKVXV3VjgMWOrS2Mm0ZpL1hSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pw05mxLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmTZWHwiI2sG/pKc2jb4R462HpyeqH/IZVxQCS1NoNI=;
	b=Pw05mxLwDEwxZO89wS5UZhGOp9CVVlCZPtJjP/5ESlVwm/iF8RBpm+B0b5MeEFfwwpnNqu
	Z3GkqE8Iz0oWNeOHABqDHFC61364Kat81uq8UUnNWZT4mzW4eFUUcy3AG8O8lJ+RO72fh4
	1GdifHw2KYE4Cw2qa+SL6yI9fxNiY8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-AAnXGuseOzmHuALWoCvR9w-1; Fri, 07 Jun 2024 08:24:09 -0400
X-MC-Unique: AAnXGuseOzmHuALWoCvR9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39BE185A5B5;
	Fri,  7 Jun 2024 12:24:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDC93492BCD;
	Fri,  7 Jun 2024 12:24:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 4/6] fs/proc/task_mmu: account non-present entries as "maybe shared, but no idea how often"
Date: Fri,  7 Jun 2024 14:23:55 +0200
Message-ID: <20240607122357.115423-5-david@redhat.com>
In-Reply-To: <20240607122357.115423-1-david@redhat.com>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

We currently rely on mapcount information for pages referenced by
non-present entries to calculate the USS (shared vs. private) and the
PSS.

However, relying on mapcounts for non-present entries doesn't make any
sense. We have to treat such entries as "maybe shared, but no idea how
often", implying that they will *not* get accounted towards the USS, and
will get fully accounted to the PSS (no idea how often shared).

There is one exception: device exclusive entries essentially behave like
present entries (e.g., mapcount incremented).

In smaps_pmd_entry(), use is_pfn_swap_entry() instead of
is_migration_entry(), which should not make a real difference but makes
the code look more similar to the PTE variant.

While at it, adjust the comments in smaps_account().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 53 +++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f427176ce2c34..67d9b406c7586 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -442,7 +442,7 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool compound, bool young, bool dirty, bool locked,
-		bool migration)
+		bool present)
 {
 	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
@@ -471,22 +471,27 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * Then accumulate quantities that may depend on sharing, or that may
 	 * differ page-by-page.
 	 *
-	 * refcount == 1 guarantees the page is mapped exactly once.
-	 * If any subpage of the compound page mapped with PTE it would elevate
-	 * the refcount.
+	 * refcount == 1 for present entries guarantees that the folio is mapped
+	 * exactly once. For large folios this implies that exactly one
+	 * PTE/PMD/... maps (a part of) this folio.
 	 *
-	 * The page_mapcount() is called to get a snapshot of the mapcount.
-	 * Without holding the page lock this snapshot can be slightly wrong as
-	 * we cannot always read the mapcount atomically.  It is not safe to
-	 * call page_mapcount() even with PTL held if the page is not mapped,
-	 * especially for migration entries.  Treat regular migration entries
-	 * as mapcount == 1.
+	 * Treat all non-present entries (where relying on the mapcount and
+	 * refcount doesn't make sense) as "maybe shared, but not sure how
+	 * often". We treat device private entries as being fake-present.
+	 *
+	 * Note that it would not be safe to read the mapcount especially for
+	 * pages referenced by migration entries, even with the PTL held.
 	 */
-	if ((folio_ref_count(folio) == 1) || migration) {
+	if (folio_ref_count(folio) == 1 || !present) {
 		smaps_page_accumulate(mss, folio, size, size << PSS_SHIFT,
-				dirty, locked, true);
+				      dirty, locked, present);
 		return;
 	}
+	/*
+	 * The page_mapcount() is called to get a snapshot of the mapcount.
+	 * Without holding the folio lock this snapshot can be slightly wrong as
+	 * we cannot always read the mapcount atomically.
+	 */
 	for (i = 0; i < nr; i++, page++) {
 		int mapcount = page_mapcount(page);
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
@@ -531,13 +536,14 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool migration = false, young = false, dirty = false;
+	bool present = false, young = false, dirty = false;
 	pte_t ptent = ptep_get(pte);
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
+		present = true;
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
@@ -555,8 +561,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 				mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
 			}
 		} else if (is_pfn_swap_entry(swpent)) {
-			if (is_migration_entry(swpent))
-				migration = true;
+			if (is_device_private_entry(swpent))
+				present = true;
 			page = pfn_swap_entry_to_page(swpent);
 		}
 	} else {
@@ -567,7 +573,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, young, dirty, locked, migration);
+	smaps_account(mss, page, false, young, dirty, locked, present);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -578,18 +584,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
+	bool present = false;
 	struct folio *folio;
-	bool migration = false;
 
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
+		present = true;
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
-		if (is_migration_entry(entry)) {
-			migration = true;
+		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
-		}
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
@@ -604,7 +609,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		mss->file_thp += HPAGE_PMD_SIZE;
 
 	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, migration);
+		      locked, present);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -732,17 +737,21 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t ptent = huge_ptep_get(pte);
 	struct folio *folio = NULL;
+	bool present = false;
 
 	if (pte_present(ptent)) {
 		folio = page_folio(pte_page(ptent));
+		present = true;
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
 			folio = pfn_swap_entry_folio(swpent);
 	}
+
 	if (folio) {
-		if (folio_likely_mapped_shared(folio) ||
+		/* We treat non-present entries as "maybe shared". */
+		if (!present || folio_likely_mapped_shared(folio) ||
 		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
-- 
2.45.2


