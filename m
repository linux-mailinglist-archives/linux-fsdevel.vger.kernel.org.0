Return-Path: <linux-fsdevel+bounces-57319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD50B207FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1939A3A44B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048372D46A9;
	Mon, 11 Aug 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRVCylFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A582D3ECF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911612; cv=none; b=Sc0pkX7vuME3FPSUHy7HJiVvDxDxnmEnri9KxsAYk8iI0fRbM5hKnxNYGTxPKBVwUkxUsT6hUcrZCa7qXWqJJY+Bb0DAvkjXjhMg7yWqMYM9AdZsYpgE3Gy8eNVN72JoTwiWAhfzlIhXKnZBywwv1azC0li86IQy/wVakkaqCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911612; c=relaxed/simple;
	bh=a+hiBZtBByVYC1UASrKiik5/n19aV+sxWoIAsC0g5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgepD/Isc0z+ABsLYBCIA7LFA4+RcUu1Lopwiw4lxCQ7olWz8LyLsAUyoF8ceuV7YnxFr2ifr6AjiuJhYeS85/N/T9zG59MrQ3kUWoWEKgd1n9amAR/itGMtRWV2FBXv4iPPISUEiegIS2ZbW3qF32Nj5LlbI58OmO1LlJKWg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRVCylFc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNeO4mnK34t1j+RunD3+GtheXBl5F9uGzS1IAgGiaS8=;
	b=ZRVCylFcYARO7bM9HTjxXtF2baAIbsVFLIhCXlD3C5VPtVMsUiEhB/V/YrWUVw041ke2cM
	v4Y5lh6Y84y16vxEf9350V9OBWkvcDBgA4IUmph+01I+46h+gtvouvHDhuAw5gHkAQ0hZX
	2J1qfr8giWiv7p7APH3D4dAMACAR6o4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-UhLv4JuKOJWBANPdTp1TTg-1; Mon, 11 Aug 2025 07:26:48 -0400
X-MC-Unique: UhLv4JuKOJWBANPdTp1TTg-1
X-Mimecast-MFC-AGG-ID: UhLv4JuKOJWBANPdTp1TTg_1754911607
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459db47f138so16574955e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911607; x=1755516407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNeO4mnK34t1j+RunD3+GtheXBl5F9uGzS1IAgGiaS8=;
        b=oIlzVeLJ6HCH9AuP5JNsGDzNenWXKCz5EqBa/CIVH9D0yUju9finOdCvxmLZmgDGnI
         fL3wSElV7xjF3esWcOsad3r+TwYMtTn391EdqNs56OETXcaj6FvXNRZA/g0feinDD77a
         H3WhLGKcg9oWdTDSxC4fj3hBjgQJ+/pVztIIvrWahnpq9T8jH0QPiYX2747+1bG8EU2N
         4xIqseqPxhswoeEDtCRNtDd5iFfHa8eJX34r7EPXsyzjaEQHe7OaETuYkX65jFA0OOYv
         ly+gCkCTSytdpVkPmoUAb2CRVyQQGV8fzWpT0K1mcrxQVUKfAOAy1N/c/cvZ949k3DCd
         BLmg==
X-Forwarded-Encrypted: i=1; AJvYcCVXbI01bnAkzxtW2w0VzUrF9KBzGrfd7tc9QQFgY5L6EGBI9q9pqZwNccCes6O5Gpl7cmXURUzItO9yR+j4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AhC1x8aubAezMNLcq+U6C89/Yr09Pg82s1L/2yCVLRylYCx6
	62AJV2+FjnMv13BWAtELhwaGRbAFhraj3aWtsjdlvUIPITd/HcYQUDhswnoBhiaH28J/Iao7Qho
	ILzCdFgVUj76u3qb2NHs0bAAbrWxxzhvIRInPtjdXDt5HhUAAAo/gEQuyDPrMtwxm71wWf2mxZR
	0=
X-Gm-Gg: ASbGncs5mYm3MRBM5mdjVOtXKetMd2GVmqE+XXf5VATGNWo5yW9LRxQe4qkNgd+5lHO
	227s8OnDNfxe9wFL2O+xtWnv9teCkRNUWIbbZhIzfeykFTmMKpBK4gtraQ8Qhk7Nz0pByuzDyZc
	JzUnUp9XOmqei55okLVorIWFlZxsWYACA0oWduZUO0BEuVpsogBHycU7r9e7dNC/qZtSjEfrBYQ
	EqI3gSm2R3pvoMuLIrh0R9pMJGhfqdWwA23y4/duEOzO0o9NCBqX6UatdAtxeKEk0InsZEBpiFR
	QG7kGRX++Zary5LpDIKzjs40bPMaFF9aySgPK38EtQlCXCr7G1GtUe5QxODM9vZlY25wL9CNiZd
	HNyYMRAMsPGZj/873wweE17t1
X-Received: by 2002:a05:600c:4746:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-459f4ea0f2dmr115559635e9.4.1754911607436;
        Mon, 11 Aug 2025 04:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+SYBbVCDa86Al3Rw//iuzbWoSgvjLT8uLZDTY5p6isO9HqDz+nOTt8CKLJXWJJ2UJD3ft4A==
X-Received: by 2002:a05:600c:4746:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-459f4ea0f2dmr115559215e9.4.1754911607000;
        Mon, 11 Aug 2025 04:26:47 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e6214640sm259832575e9.1.2025.08.11.04.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:46 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: [PATCH v3 05/11] mm/huge_memory: mark PMD mappings of the huge zero folio special
Date: Mon, 11 Aug 2025 13:26:25 +0200
Message-ID: <20250811112631.759341-6-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The huge zero folio is refcounted (+mapcounted -- is that a word?)
differently than "normal" folios, similarly (but different) to the ordinary
shared zeropage.

For this reason, we special-case these pages in
vm_normal_page*/vm_normal_folio*, and only allow selected callers to
still use them (e.g., GUP can still take a reference on them).

vm_normal_page_pmd() already filters out the huge zero folio, to
indicate it a special (return NULL). However, so far we are not making
use of pmd_special() on architectures that support it
(CONFIG_ARCH_HAS_PTE_SPECIAL), like we would with the ordinary shared
zeropage.

Let's mark PMD mappings of the huge zero folio similarly as special, so we
can avoid the manual check for the huge zero folio with
CONFIG_ARCH_HAS_PTE_SPECIAL next, and only perform the check on
!CONFIG_ARCH_HAS_PTE_SPECIAL.

In copy_huge_pmd(), where we have a manual pmd_special() check to handle
PFNMAP, we have to manually rule out the huge zero folio. That code
needs a serious cleanup, but that's something for another day.

While at it, update the doc regarding the shared zero folios.

No functional change intended: vm_normal_page_pmd() still returns NULL
when it encounters the huge zero folio.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  8 ++++++--
 mm/memory.c      | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec89e0607424e..58bac83e7fa31 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1309,6 +1309,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 {
 	pmd_t entry;
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
+	entry = pmd_mkspecial(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -1418,7 +1419,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		if (!is_huge_zero_folio(fop.folio)) {
+		if (is_huge_zero_folio(fop.folio)) {
+			entry = pmd_mkspecial(entry);
+		} else {
 			folio_get(fop.folio);
 			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
@@ -1643,7 +1646,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 
 	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd))) {
+	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
+		     !is_huge_zero_pmd(pmd))) {
 		dst_ptl = pmd_lock(dst_mm, dst_pmd);
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b718471..626caedce35e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -555,7 +555,14 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * "Special" mappings do not wish to be associated with a "struct page" (either
  * it doesn't exist, or it exists but they don't want to touch it). In this
- * case, NULL is returned here. "Normal" mappings do have a struct page.
+ * case, NULL is returned here. "Normal" mappings do have a struct page and
+ * are ordinarily refcounted.
+ *
+ * Page mappings of the shared zero folios are always considered "special", as
+ * they are not ordinarily refcounted: neither the refcount nor the mapcount
+ * of these folios is adjusted when mapping them into user page tables.
+ * Selected page table walkers (such as GUP) can still identify mappings of the
+ * shared zero folios and work with the underlying "struct page".
  *
  * There are 2 broad cases. Firstly, an architecture may define a pte_special()
  * pte bit, in which case this function is trivial. Secondly, an architecture
@@ -585,9 +592,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
  * page" backing, however the difference is that _all_ pages with a struct
- * page (that is, those where pfn_valid is true) are refcounted and considered
- * normal pages by the VM. The only exception are zeropages, which are
- * *never* refcounted.
+ * page (that is, those where pfn_valid is true, except the shared zero
+ * folios) are refcounted and considered normal pages by the VM.
  *
  * The disadvantage is that pages are refcounted (which can be slower and
  * simply not an option for some PFNMAP users). The advantage is that we
@@ -667,7 +673,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/* Currently it's only used for huge pfnmaps */
 	if (unlikely(pmd_special(pmd)))
 		return NULL;
 
-- 
2.50.1


