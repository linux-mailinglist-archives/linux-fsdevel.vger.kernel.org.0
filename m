Return-Path: <linux-fsdevel+bounces-51929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9317EADD2D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E24189EC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411472EA17A;
	Tue, 17 Jun 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc+bm97I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E02EA14F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175059; cv=none; b=nsxD8HTdkN0ECIGzjX0jJ3WAR/Ukbndbiy/uMshiPFvpxZ3T00vB81N0EQSdRkZMHtNSqheSEu4yd5V32YCBS1YdzIvS+PHKT71Pxd51miwlyX3OvgJWTaQuMcg/Q6O+DmiX+MWgiZ2tcEDplT/AN8eOPMts7oH5gSowDoJHQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175059; c=relaxed/simple;
	bh=OJI5f+1+NYHuwxH37IlrE7TLESeijQhASgWBHOjp2gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQpy8fBFpf1pFobQgSoj/rU+iyy0Fl+GNtcrsF3zl/TrqHpHNy2ha3aZZKZ3BQgII/y7d5dGnEXvAQP1bx5MihUIsO9EVCEFwjBTJD8V5xR6M+Od7KMppFEOpM2K9/jZmzrKksjtXnhIWbof2ClO3B+D5hLmuevFDoodgTBV5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gc+bm97I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EH5nVYJRAiyh61U5bFJOLvxZlURX1rOpBEXY4zGSahY=;
	b=Gc+bm97IFsT+ZwcDQdk3Q70EOYTGQ3dg0FHYXyJPP5DUd7ftIiC8x3ow4S1FlsX02z3sfx
	fgp7WM7h/BFwzZCc974e5VxOOPKiCEAcf3z08GKkStmYZjRPwsRCMTPhKXos4WUeOcUDPd
	TIbgC1nsZB5cihp5F7Eh69p3EGsH3qM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-E6-EhND4PPSEXVun5YjYvA-1; Tue, 17 Jun 2025 11:44:15 -0400
X-MC-Unique: E6-EhND4PPSEXVun5YjYvA-1
X-Mimecast-MFC-AGG-ID: E6-EhND4PPSEXVun5YjYvA_1750175054
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so548267f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175054; x=1750779854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EH5nVYJRAiyh61U5bFJOLvxZlURX1rOpBEXY4zGSahY=;
        b=GCfUdMdllBqSdFbJIHHpG+4u3nY2mzb1YBWI6KxYFjSwnMXHHRpiaXnHepKO4r2/Xl
         RQXVXGnjsAM6iNE/ex4X97hlo2pwfjam3F55HXo4kXoiPndHEpbR65IqCQtf5f22scKv
         hec0pAiSdoutHm7ambHehn+smu03hrY7Nz56v/BLUauBMVmSkRVzTJUWHu76Ng+f29nP
         WyopEiZL2RCDB8ezljlqrF6jZ3yNh+tzEFnWwIKxsuwUXMn7PKf9cyA3HLaF+suvDF4S
         8fIhFfzAkcsn5lXkN46cAzOOO2opnUhvPf8Pdz3UjZN1ZHvcg8LMkQmKxvyO5XKnDKxA
         jUTw==
X-Gm-Message-State: AOJu0Yw7wc1/6wu/v+FAeh+xTXaPpuwa4QEMWS5Y084dboGzqGj/TxVs
	GyyTX9vzNuGQKna/mykQupOikZvBX7XlVzsmVFAwF/QUQyAaJeNk198jaP3aCElOINQ3aeDocBY
	BKsM4jI4V3/PdKJ3xspU+cSA9rQq1/3b5scJTs9duHHFDhuXuKvwLbTwQuCqiKskzS4o=
X-Gm-Gg: ASbGncuHNs939ThUQkLDhWPIqom/rADjRTZ6Wyujj4IZyBPu/sHifIAhLHdKfufl2/X
	cDOcbjBmJo7/Bh/IOVEX/fOK1X0n81krwdaSXx1G3n8lm2Y1Ey9PXb9PNAon4+idIvK6W//RN75
	DvYFQbHZ0CbVWyPREMIcArkYcuvctgPGjzCjxGUVo/N5Si0ZJjc9FtQbou77vSkCImFEib3w0Sx
	kdNkwzVSA9NPYAuJHZwp9iEI/LUj5OHwvu0Qc3/fMYP4FZbr+PlWI2w3oWA2vPoEYakgbNSQDR0
	HJCRT9I17BGz+j6npQukSn0GKv/eczU1butSgfojd/DN+Eq+mhsuDyYH8r5dK8ocJbQUxH64CnG
	wYWJQyw==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a56d7bad5emr13168058f8f.4.1750175053656;
        Tue, 17 Jun 2025 08:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJKGvzcDxbJ2BQdcd7rWQnrxwh5Qby5YdaZuNvO87Urq3koTuTn6k4xY4C82ZJ429DbH36HQ==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a56d7bad5emr13168003f8f.4.1750175053036;
        Tue, 17 Jun 2025 08:44:13 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b089d8sm14553679f8f.57.2025.06.17.08.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:12 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH RFC 11/14] mm: remove "horrible special case to handle copy-on-write behaviour"
Date: Tue, 17 Jun 2025 17:43:42 +0200
Message-ID: <20250617154345.2494405-12-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
References: <20250617154345.2494405-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make the kernel a bit less horrible, by removing the
linearity requirement in CoW PFNMAP mappings with
!CONFIG_ARCH_HAS_PTE_SPECIAL. In particular, stop messing with
vma->vm_pgoff in weird ways.

Simply lookup in applicable (i.e., CoW PFNMAP) mappings whether we
have an anon folio.

Nobody should ever try mapping anon folios using PFNs, that just screams
for other possible issues. To be sure, let's sanity-check when inserting
PFNs. Are they really required? Probably not, but it's a good safety net
at least for now.

The runtime overhead should be limited: there is nothing to do for !CoW
mappings (common case), and archs that care about performance
(i.e., GUP-fast) should be supporting CONFIG_ARCH_HAS_PTE_SPECIAL
either way.

Likely the sanity checks added in mm/huge_memory.c are not required for
now, because that code is probably only wired up with
CONFIG_ARCH_HAS_PTE_SPECIAL, but this way is certainly cleaner and
more consistent -- and doesn't really cost us anything in the cases we
really care about.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  16 ++++++
 mm/huge_memory.c   |  16 +++++-
 mm/memory.c        | 118 +++++++++++++++++++++++++--------------------
 3 files changed, 96 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98a606908307b..3f52871becd3f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2339,6 +2339,22 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
+static inline struct page *vm_pfnmap_normal_page_pfn(struct vm_area_struct *vma,
+		unsigned long pfn)
+{
+	/*
+	 * We don't identify normal pages using PFNs. So if we reach
+	 * this point, it's just for sanity checks that don't apply with
+	 * pte_special() etc.
+	 */
+	return NULL;
+}
+#else
+struct page *vm_pfnmap_normal_page_pfn(struct vm_area_struct *vma,
+		unsigned long pfn);
+#endif
+
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8f03cd4e40397..67220c30e7818 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1479,7 +1479,13 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+
+	/*
+	 * Refuse this pfn if we could mistake it as a refcounted folio
+	 * in a CoW mapping later in vm_normal_page_pmd().
+	 */
+	if ((vma->vm_flags & VM_PFNMAP) && vm_pfnmap_normal_page_pfn(vma, pfn))
+		return VM_FAULT_SIGBUS;
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -1587,7 +1593,13 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+
+	/*
+	 * Refuse this pfn if we could mistake it as a refcounted folio
+	 * in a CoW mapping later in vm_normal_page_pud().
+	 */
+	if ((vma->vm_flags & VM_PFNMAP) && vm_pfnmap_normal_page_pfn(vma, pfn))
+		return VM_FAULT_SIGBUS;
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
diff --git a/mm/memory.c b/mm/memory.c
index 3d3fa01cd217e..ace9c59e97181 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -536,9 +536,35 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
+#ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
+struct page *vm_pfnmap_normal_page_pfn(struct vm_area_struct *vma,
+		unsigned long pfn)
+{
+	struct folio *folio;
+	struct page *page;
+
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PFNMAP));
+
+	/*
+	 * If we have a CoW mapping and spot an anon folio, then it can
+	 * only be due to CoW: the page is "normal".
+	 */
+	if (likely(!is_cow_mapping(vma->vm_flags)))
+		return NULL;
+	if (likely(!pfn_valid(pfn)))
+		return NULL;
+
+	page = pfn_to_page(pfn);
+	folio = page_folio(page);
+	if (folio_test_slab(folio) || !folio_test_anon(folio))
+		return NULL;
+	return page;
+}
+#endif /* !CONFIG_ARCH_HAS_PTE_SPECIAL */
+
 /* Called only if the page table entry is not marked special. */
 static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn)
+		unsigned long pfn)
 {
 	/*
 	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
@@ -553,13 +579,8 @@ static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
 			if (!pfn_valid(pfn))
 				return NULL;
 		} else {
-			unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
-
 			/* Only CoW'ed anon folios are "normal". */
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
-				return NULL;
+			return vm_pfnmap_normal_page_pfn(vma, pfn);
 		}
 	}
 
@@ -589,30 +610,19 @@ static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
  * (such as GUP) can still identify these mappings and work with the
  * underlying "struct page".
  *
- * There are 2 broad cases. Firstly, an architecture may define a pte_special()
- * pte bit, in which case this function is trivial. Secondly, an architecture
- * may not have a spare pte bit, which requires a more complicated scheme,
- * described below.
+ * An architecture may support pte_special() to distinguish "special"
+ * from "normal" mappings more efficiently, and even without the VMA at hand.
+ * For example, in order to support GUP-fast, whereby we don't have the VMA
+ * available when walking the page tables, support for pte_special() is
+ * crucial.
+ *
+ * If an architecture does not support pte_special(), this function is less
+ * trivial and more expensive in some cases.
  *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
  * COWed pages of a VM_PFNMAP are always normal.
  *
- * The way we recognize COWed pages within VM_PFNMAP mappings is through the
- * rules set up by "remap_pfn_range()": the vma will have the VM_PFNMAP bit
- * set, and the vm_pgoff will point to the first PFN mapped: thus every special
- * mapping will always honor the rule
- *
- *	pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)
- *
- * And for normal mappings this is false.
- *
- * This restricts such mappings to be a linear translation from virtual address
- * to pfn. To get around this restriction, we allow arbitrary mappings so long
- * as the vma is not a COW mapping; in that case, we know that all ptes are
- * special (because none can have been COWed).
- *
- *
  * In order to support COW of arbitrary special mappings, we have VM_MIXEDMAP.
  *
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
@@ -621,10 +631,7 @@ static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
  * folios) are refcounted and considered normal pages by the VM.
  *
  * The disadvantage is that pages are refcounted (which can be slower and
- * simply not an option for some PFNMAP users). The advantage is that we
- * don't have to follow the strict linearity rule of PFNMAP mappings in
- * order to support COWable mappings.
- *
+ * simply not an option for some PFNMAP users).
  */
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
@@ -642,7 +649,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
 	}
-	return vm_normal_page_pfn(vma, addr, pfn);
+	return vm_normal_page_pfn(vma, pfn);
 }
 
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
@@ -666,7 +673,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				!is_huge_zero_pfn(pfn));
 		return NULL;
 	}
-	return vm_normal_page_pfn(vma, addr, pfn);
+	return vm_normal_page_pfn(vma, pfn);
 }
 
 struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
@@ -2422,6 +2429,13 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
+	/*
+	 * Refuse this pfn if we could mistake it as a refcounted folio
+	 * in a CoW mapping later in vm_normal_page().
+	 */
+	if ((vma->vm_flags & VM_PFNMAP) && vm_pfnmap_normal_page_pfn(vma, pfn))
+		return VM_FAULT_SIGBUS;
+
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
 		return VM_FAULT_OOM;
@@ -2511,7 +2525,6 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
 	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
@@ -2656,10 +2669,11 @@ vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+static int remap_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 	int err = 0;
@@ -2674,6 +2688,14 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			err = -EACCES;
 			break;
 		}
+		/*
+		 * Refuse this pfn if we could mistake it as a refcounted folio
+		 * in a CoW mapping later in vm_normal_page().
+		 */
+		if (vm_pfnmap_normal_page_pfn(vma, pfn)) {
+			err = -EINVAL;
+			break;
+		}
 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -2682,10 +2704,11 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	return err;
 }
 
-static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
+static inline int remap_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pmd_t *pmd;
 	unsigned long next;
 	int err;
@@ -2697,7 +2720,7 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
 		next = pmd_addr_end(addr, end);
-		err = remap_pte_range(mm, pmd, addr, next,
+		err = remap_pte_range(vma, pmd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
@@ -2705,10 +2728,11 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 	return 0;
 }
 
-static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
+static inline int remap_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pud_t *pud;
 	unsigned long next;
 	int err;
@@ -2719,7 +2743,7 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		err = remap_pmd_range(mm, pud, addr, next,
+		err = remap_pmd_range(vma, pud, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
@@ -2727,10 +2751,11 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	return 0;
 }
 
-static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
+static inline int remap_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	p4d_t *p4d;
 	unsigned long next;
 	int err;
@@ -2741,7 +2766,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		err = remap_pud_range(mm, p4d, addr, next,
+		err = remap_pud_range(vma, p4d, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
@@ -2773,18 +2798,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	 *      Disable vma merging and expanding with mremap().
 	 *   VM_DONTDUMP
 	 *      Omit vma from core dump, even when VM_IO turned off.
-	 *
-	 * There's a horrible special case to handle copy-on-write
-	 * behaviour that some programs depend on. We mark the "original"
-	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
-	 * See vm_normal_page() for details.
 	 */
-	if (is_cow_mapping(vma->vm_flags)) {
-		if (addr != vma->vm_start || end != vma->vm_end)
-			return -EINVAL;
-		vma->vm_pgoff = pfn;
-	}
-
 	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 
 	BUG_ON(addr >= end);
@@ -2793,7 +2807,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	flush_cache_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = remap_p4d_range(mm, pgd, addr, next,
+		err = remap_p4d_range(vma, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
 			return err;
-- 
2.49.0


