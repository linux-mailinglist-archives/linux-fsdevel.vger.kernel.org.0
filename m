Return-Path: <linux-fsdevel+bounces-55252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED1B08C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077E0189CD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1180A2BD59C;
	Thu, 17 Jul 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiTtbrds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431A2BD5BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753155; cv=none; b=dSFpDV7b0W+GKx9/eR5YnqlNQKDat4vwc1kYMBuBABJMuZ67tr4RDicVDVeTVgmr+6IWgVJk+SGq7fz47Nx1994kr1k83J3tH5WHKz7TJl1D5F7XAUW+JunVMQIG5vvwJ9s0dd2s9yzO4GYe3Bv2klIK8kULsXiebq/ZtZDIle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753155; c=relaxed/simple;
	bh=1pwM060/WNa2ioGgS0u3OsH7hNEc8Mz5/vQMX1ys5tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWbjV76abzEFaok5dwqpOnXybNXVx4rkR2DgMvLN144+ABh+2eOdv23ultE4VWboKLzFdVD1DL1rets+H2A0WIUJZuhR5u1dzyQY10Wm7zQGTOYAHaVgvlig/epp8Mi1Ap2aaPwmSQglhrdOalZceaNCK01Ko0/stY4hwnLXdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiTtbrds; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbR0phC2X7fIX30bxtjDJxvlOXqw8t3nlah85Ck4RFM=;
	b=AiTtbrdsR8DfGDkUHahUZ5YDrj97Upj1Rk1Ck70qFKHUXXgJ9vCke8pHaN2ccgJz88TADq
	F/BBoaMWrJs2tTFvWuN+DvlF/1pPOwHoTEK30XwFBbrxJT9MJU6vBsa60I1KOG1zG5nuRx
	GaAqKLFrQloP/reh5Td4czyD+/jLJiU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-XJd-i75tO9KXZlzTLDP3bQ-1; Thu, 17 Jul 2025 07:52:31 -0400
X-MC-Unique: XJd-i75tO9KXZlzTLDP3bQ-1
X-Mimecast-MFC-AGG-ID: XJd-i75tO9KXZlzTLDP3bQ_1752753150
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so4557395e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753150; x=1753357950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbR0phC2X7fIX30bxtjDJxvlOXqw8t3nlah85Ck4RFM=;
        b=rbgQM1+PyMewwEIWGfPizKaelEeMpXq6ZkvZq0S9sTGcwJQc6wcbwB5u2pbPLtdFcv
         hN8pmFS7QDSSP2klgETeaBA+PZs0eDiQm5qxS3p79WwqhD5coWeCZNalLUc7oVJhclqT
         mfio+6kMwKj5LwOUMC2XGCuyzDKsqnWZbczHZUfVAaogp80XI1YsPhFsmuyf76KphiEy
         PMDpVQlsDe9iLhq8nU02qh6SqSq+NP5HrYVBb9lPYsfHIxGE/rdmJ8B4sK72nvXKHWPU
         jZjC2TnvXUuFxNE/1fntPfo4XuSx1vur75MxCXcPAmsEuxwdFGdvJk9bpYZ7hmfiroeg
         SukQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk6OLQNiqfhCFKXAqWQNDcGcDiFZUwmOjBjXYpFBwx0YorD5tsNiKwSARX1PUrSlMgzzNQfLkMQQ/0C0Qe@vger.kernel.org
X-Gm-Message-State: AOJu0YwveRMXe9Aw6usJGCdd8wDal25ltfWQWKh8quC9LhvL5lO2gDAN
	I6RuqYwRkPFbD2te5iN52E4/aEnGfNx1pnU4uwoglwnUcOUCC2vcMHxB8GfyHCty2OGdb/XafI2
	00gMLcwM4ZWPyVjcFJWjrUEzbqArLWm7VL/4AyejOxFxaEXmwF8zS9T5+uLr6yZ3NP1U=
X-Gm-Gg: ASbGncsEva+uiJeKOsUmeglWvvSyDH4uHdyuIuYzEqqrdvU71OaaU1Yz/r9axPjr57I
	8v/MIHfkrYX/dnrX1rJooMBoAxl+GFzmNPSL/fz5tzcHJ7nDWGR3tWVAekjqaEo01Pl2Lngm62p
	I6TUoqhlkLThdLBE6FMgYFWx9egUJ+0G8YTXRy7V0OCUNs/0DWn1sySflae3E5EMa2iv+x2NspU
	GDfFWef9nbZxFRIc/PQsLXQzHpxKYsAOTAr+UPVCFE6r4AiGOza/rYkv/AkTzaNNlaGRKQP3Gog
	AVtB8GQh3I4KQ0tgoTap0/z9zO9b7RByCV6MnWufKpQs07/5UACOnAf3hDIF4y29DZwnCu/v6/x
	L7fCmNq2R/3ULGv+9AdbcZ24=
X-Received: by 2002:a05:600c:4706:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-4562edaa08cmr59715905e9.8.1752753150321;
        Thu, 17 Jul 2025 04:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGF6l6GEGtw18Sa0l+0UWiR0a/WM3dG6MbtHwia3ILIrxrhuz79ecySj7OKZMvEeK7lnwGw==
X-Received: by 2002:a05:600c:4706:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-4562edaa08cmr59715535e9.8.1752753149770;
        Thu, 17 Jul 2025 04:52:29 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45626c7b1a9sm45953235e9.0.2025.07.17.04.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:29 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to print_bad_page_map()
Date: Thu, 17 Jul 2025 13:52:09 +0200
Message-ID: <20250717115212.1825089-7-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717115212.1825089-1-david@redhat.com>
References: <20250717115212.1825089-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_bad_pte() looks like something that should actually be a WARN
or similar, but historically it apparently has proven to be useful to
detect corruption of page tables even on production systems -- report
the issue and keep the system running to make it easier to actually detect
what is going wrong (e.g., multiple such messages might shed a light).

As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
to take care of print_bad_pte() as well.

Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
implementation and renaming the function -- we'll rename it to what
we actually print: bad (page) mappings. Maybe it should be called
"print_bad_table_entry()"? We'll just call it "print_bad_page_map()"
because the assumption is that we are dealing with some (previously)
present page table entry that got corrupted in weird ways.

Whether it is a PTE or something else will usually become obvious from the
page table dump or from the dumped stack. If ever required in the future,
we could pass the entry level type similar to "enum rmap_level". For now,
let's keep it simple.

To make the function a bit more readable, factor out the ratelimit check
into is_bad_page_map_ratelimited() and place the dumping of page
table content into __dump_bad_page_map_pgtable(). We'll now dump
information from each level in a single line, and just stop the table
walk once we hit something that is not a present page table.

Use print_bad_page_map() in vm_normal_page_pmd() similar to how we do it
for vm_normal_page(), now that we have a function that can handle it.

The report will now look something like (dumping pgd to pmd values):

[   77.943408] BUG: Bad page map in process XXX  entry:80000001233f5867
[   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
[   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067

Not using pgdp_get(), because that does not work properly on some arm
configs where pgd_t is an array. Note that we are dumping all levels
even when levels are folded for simplicity.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 26 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 173eb6267e0ac..08d16ed7b4cc7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -473,22 +473,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 			add_mm_counter(mm, i, rss[i]);
 }
 
-/*
- * This function is called to print an error when a bad pte
- * is found. For example, we might have a PFN-mapped pte in
- * a region that doesn't allow it.
- *
- * The calling function must still handle the error.
- */
-static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
-			  pte_t pte, struct page *page)
+static bool is_bad_page_map_ratelimited(void)
 {
-	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
-	p4d_t *p4d = p4d_offset(pgd, addr);
-	pud_t *pud = pud_offset(p4d, addr);
-	pmd_t *pmd = pmd_offset(pud, addr);
-	struct address_space *mapping;
-	pgoff_t index;
 	static unsigned long resume;
 	static unsigned long nr_shown;
 	static unsigned long nr_unshown;
@@ -500,7 +486,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	if (nr_shown == 60) {
 		if (time_before(jiffies, resume)) {
 			nr_unshown++;
-			return;
+			return true;
 		}
 		if (nr_unshown) {
 			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
@@ -511,15 +497,87 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	}
 	if (nr_shown++ == 0)
 		resume = jiffies + 60 * HZ;
+	return false;
+}
+
+static void __dump_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long long pgdv, p4dv, pudv, pmdv;
+	p4d_t p4d, *p4dp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
+	pgd_t *pgdp;
+
+	/*
+	 * This looks like a fully lockless walk, however, the caller is
+	 * expected to hold the leaf page table lock in addition to other
+	 * rmap/mm/vma locks. So this is just a re-walk to dump page table
+	 * content while any concurrent modifications should be completely
+	 * prevented.
+	 */
+	pgdp = pgd_offset(mm, addr);
+	pgdv = pgd_val(*pgdp);
+
+	if (!pgd_present(*pgdp) || pgd_leaf(*pgdp)) {
+		pr_alert("pgd:%08llx\n", pgdv);
+		return;
+	}
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = p4dp_get(p4dp);
+	p4dv = p4d_val(p4d);
+
+	if (!p4d_present(p4d) || p4d_leaf(p4d)) {
+		pr_alert("pgd:%08llx p4d:%08llx\n", pgdv, p4dv);
+		return;
+	}
+
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	pudv = pud_val(pud);
+
+	if (!pud_present(pud) || pud_leaf(pud)) {
+		pr_alert("pgd:%08llx p4d:%08llx pud:%08llx\n", pgdv, p4dv, pudv);
+		return;
+	}
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get(pmdp);
+	pmdv = pmd_val(pmd);
+
+	/*
+	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
+	 * because the table should already be mapped by the caller and
+	 * doing another map would be bad. print_bad_page_map() should
+	 * already take care of printing the PTE.
+	 */
+	pr_alert("pgd:%08llx p4d:%08llx pud:%08llx pmd:%08llx\n", pgdv,
+		 p4dv, pudv, pmdv);
+}
+
+/*
+ * This function is called to print an error when a bad page table entry (e.g.,
+ * corrupted page table entry) is found. For example, we might have a
+ * PFN-mapped pte in a region that doesn't allow it.
+ *
+ * The calling function must still handle the error.
+ */
+static void print_bad_page_map(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long long entry, struct page *page)
+{
+	struct address_space *mapping;
+	pgoff_t index;
+
+	if (is_bad_page_map_ratelimited())
+		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
 
-	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
-		 current->comm,
-		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
+	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);
+	__dump_bad_page_map_pgtable(vma->vm_mm, addr);
 	if (page)
-		dump_page(page, "bad pte");
+		dump_page(page, "bad page map");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
@@ -597,7 +655,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		if (is_zero_pfn(pfn))
 			return NULL;
 
-		print_bad_pte(vma, addr, pte, NULL);
+		print_bad_page_map(vma, addr, pte_val(pte), NULL);
 		return NULL;
 	}
 
@@ -625,7 +683,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 
 check_pfn:
 	if (unlikely(pfn > highest_memmap_pfn)) {
-		print_bad_pte(vma, addr, pte, NULL);
+		print_bad_page_map(vma, addr, pte_val(pte), NULL);
 		return NULL;
 	}
 
@@ -654,8 +712,15 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	if (unlikely(pmd_special(pmd)))
+	if (unlikely(pmd_special(pmd))) {
+		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			return NULL;
+		if (is_huge_zero_pfn(pfn))
+			return NULL;
+
+		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
 		return NULL;
+	}
 
 	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
 		if (vma->vm_flags & VM_MIXEDMAP) {
@@ -674,8 +739,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (is_huge_zero_pfn(pfn))
 		return NULL;
-	if (unlikely(pfn > highest_memmap_pfn))
+	if (unlikely(pfn > highest_memmap_pfn)) {
+		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
 		return NULL;
+	}
 
 	/*
 	 * NOTE! We still have PageReserved() pages in the page tables.
@@ -1509,7 +1576,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		folio_remove_rmap_ptes(folio, page, nr, vma);
 
 		if (unlikely(folio_mapcount(folio) < 0))
-			print_bad_pte(vma, addr, ptent, page);
+			print_bad_page_map(vma, addr, pte_val(ptent), page);
 	}
 	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
 		*force_flush = true;
@@ -4507,7 +4574,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		} else if (is_pte_marker_entry(entry)) {
 			ret = handle_pte_marker(vmf);
 		} else {
-			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
+			print_bad_page_map(vma, vmf->address,
+					   pte_val(vmf->orig_pte), NULL);
 			ret = VM_FAULT_SIGBUS;
 		}
 		goto out;
-- 
2.50.1


