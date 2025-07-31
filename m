Return-Path: <linux-fsdevel+bounces-56394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C30B17106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A72C4E6F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8162C15AE;
	Thu, 31 Jul 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkgq4ILv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A032C08C5;
	Thu, 31 Jul 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964519; cv=none; b=B1PdVUa1QO7IbZL9PnGk8RaviYrQF10pm8W8u2/7xn+0GWlgod42KJ/CE9EGSbbx/qWmVyRbiI5qOTKkInNhWYY1J4WgWyhZlV1gFfpw8caVOJ5eM5j40o52rpt3TVEDhbCi6rlwPc4k4ZYJjDC1TzclvMrF+mF57nFqZ0mfGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964519; c=relaxed/simple;
	bh=UciuG8bWW1nCMXt04oc8GQmG9stwv+Gzdpx7dTgbBDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayWuzXGJ9aGCjYceov+bT2yuJquhuR3Sl5su1/Id8ZxvVBCYUMI9YM97BdRISBpCbhUcghBap5iI1qv1eHhPWgppjffZD9CAQcfcaivdjvy8B6ZUd7Z0KbD+mv4gRC47/HmF1wC1M8CF5wZzOoKx64fMCKAlEyaLm6rZu7S8p0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkgq4ILv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4abc0a296f5so9164671cf.0;
        Thu, 31 Jul 2025 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964517; x=1754569317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVGPh02pmLJrHp5VeDMRa3cXERDmLuGimyItCvJL/y4=;
        b=Pkgq4ILvafBo0IlvRQhf5Uzn4RydEDmttJiPb/nmj9njfVhJtoX70wGWPJlwIXsnAe
         1490CXUET/+XcpkXd+RTORtOYTptollkBUe0/yVzVX4ONHDGfobOAg+X3bHni2/3wted
         M/EhuWSAqE8Y9bLJuahb0JqRj8uybCCGXxxktNNkmB5DcqTkH2men1Bqvse8dN1k7AEk
         Jf6icjIgKDkR4Q7GiVEgtTyTAWjlgjssPTnV1GOKDNsa//pQwcN9ixLkF/BU5MsGe7uZ
         gTJYP+Yij0UBjowQ+V/ferSkUbM8imD2h8m6aFDEKXgVa4XlcRqXfjcjF7tTNnsmiIdY
         kejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964517; x=1754569317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVGPh02pmLJrHp5VeDMRa3cXERDmLuGimyItCvJL/y4=;
        b=Nx6iTRWceqazPkflTc0rqGA3sEaMOJoKY33Vfj2fraF8GAsl6ic7W61rKsshBNhZqm
         GyZxkpCwo5zqdBnNidvsW1M6SMwP+YYa53cba/sJaxPCvFQ0gbpJqdIIReVHRWYuQc42
         h4bt3G6u1YhGO2c8zmtjsstAxN7wjp4hYNV8ae4M7+VAwkRHtG91dVGuvdwNLZjhkyYo
         AFOARNFg6bnq2fRFIjxIGKVQfh412RDmHyOZpx8Z584Te1rCNdPkb9JHuJtBcRXUac4s
         I/HQZ/tsmpyYD+bokCFGsxxpz45uAXbhGgIQ6y+6B44NxaAkcjWw2zCratdm7QgPZPrS
         OxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPK4oP/ubU/gl22ZbFw+DcGAkl45zGqgoONFyKsjMWAas5+HY5tarG2ru77b92zAUIWZnNQale8Uutj7E0@vger.kernel.org, AJvYcCVsT6r9o78vm4QAKCFW2xq9+Zk5sWY0iUxwdr0/9XZx4a/gQ8zc7TlfPqe3vA+pURdFhZq8XSZE5y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYpdKuVn3/d7fneNkJ/zpD1o0iNCNZHDLubuDcaUwUi5y62uT
	ggsADz1qenirPIKLR4wHbQCsE7HrIFiLTyiZ8S0F+ooZrruZVg+Uixhr
X-Gm-Gg: ASbGncsW2vpAcqwvTGmxgqZL6t0KZXrhss0u94f7dwJ4SRdUddpsKX27qbAYmNVj/uh
	JsI59q4dPB8a62fqFfv9Y4FjEfpPF4xW9g0PU1SKGqHQ1F/9FJAEdSqMRnGahc0bkt+v0UTFdmF
	xcvM0Xhqh5uPC8+fuK0txiRBYDp6tMZqmT1otESUQjD2lkdMYCgKzHNmDp8tiJzZFtdPDQ++SOs
	puC9Q8O2K0MlR/fuG0Au+4xh+09Bl5EiqliXV9dKn0O1DSR36ftmUYd02cmTGXiyIqqdRgQNBEo
	0UmzUwLOQKbsl8Ny/NGoGPj2Y93aKLEXVZrgy9iRV09uu0EswAXGRFc7T9zzPNxB6sqSdph9FZa
	FDwm4Qyor3jEpM9N1
X-Google-Smtp-Source: AGHT+IFPbmTUq+rQQKcQuYZXe1ohl0cR1iKPY/f2446SgL2VSTGAqlu9z68Mvf6HROUg/UKLgqkEtg==
X-Received: by 2002:a05:622a:198b:b0:4a7:2f49:7626 with SMTP id d75a77b69052e-4aedb958b94mr102830881cf.7.1753964516365;
        Thu, 31 Jul 2025 05:21:56 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed669c0sm7593891cf.33.2025.07.31.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:21:55 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 2/5] mm/huge_memory: convert "tva_flags" to "enum tva_type" for thp_vma_allowable_order*()
Date: Thu, 31 Jul 2025 13:18:13 +0100
Message-ID: <20250731122150.2039342-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731122150.2039342-1-usamaarif642@gmail.com>
References: <20250731122150.2039342-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Describing the context through a type is much clearer, and good enough
for our case.

We have:
* smaps handling for showing "THPeligible"
* Pagefault handling
* khugepaged handling
* Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case

Really, we want to ignore sysfs only when we are forcing a collapse
through MADV_COLLAPSE, otherwise we want to enforce.

With this change, we immediately know if we are in the forced collapse
case, which will be valuable next.

Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 fs/proc/task_mmu.c      |  4 ++--
 include/linux/huge_mm.h | 30 ++++++++++++++++++------------
 mm/huge_memory.c        |  8 ++++----
 mm/khugepaged.c         | 18 +++++++++---------
 mm/memory.c             | 14 ++++++--------
 5 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..d440df7b3d59 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %8u\n",
-		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
-			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
+		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
+					      THP_ORDERS_ALL));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71db243a002e..b0ff54eee81c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define THP_ORDERS_ALL	\
 	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
 
-#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
-#define TVA_IN_PF		(1 << 1)	/* Page fault handler */
-#define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
+enum tva_type {
+	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
+	TVA_PAGEFAULT,		/* Serving a page fault. */
+	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
+	TVA_FORCED_COLLAPSE,	/* Forced collapse (i.e., MADV_COLLAPSE). */
+};
 
-#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
-	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
+#define thp_vma_allowable_order(vma, vm_flags, type, order) \
+	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
 
 #define split_folio(f) split_folio_to_list(f, NULL)
 
@@ -264,14 +267,14 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 vm_flags_t vm_flags,
-					 unsigned long tva_flags,
+					 enum tva_type type,
 					 unsigned long orders);
 
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
  * @vma:  the vm area to check
  * @vm_flags: use these vm_flags instead of vma->vm_flags
- * @tva_flags: Which TVA flags to honour
+ * @type: TVA type
  * @orders: bitfield of all orders to consider
  *
  * Calculates the intersection of the requested hugepage orders and the allowed
@@ -285,11 +288,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 static inline
 unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       vm_flags_t vm_flags,
-				       unsigned long tva_flags,
+				       enum tva_type type,
 				       unsigned long orders)
 {
-	/* Optimization to check if required orders are enabled early. */
-	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
+	/*
+	 * Optimization to check if required orders are enabled early. Only
+	 * forced collapse ignores sysfs configs.
+	 */
+	if (type != TVA_FORCED_COLLAPSE && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
 
 		if (vm_flags & VM_HUGEPAGE)
@@ -303,7 +309,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 			return 0;
 	}
 
-	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
 }
 
 struct thpsize {
@@ -536,7 +542,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 
 static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 					vm_flags_t vm_flags,
-					unsigned long tva_flags,
+					enum tva_type type,
 					unsigned long orders)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..85252b468f80 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -99,12 +99,12 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 vm_flags_t vm_flags,
-					 unsigned long tva_flags,
+					 enum tva_type type,
 					 unsigned long orders)
 {
-	bool smaps = tva_flags & TVA_SMAPS;
-	bool in_pf = tva_flags & TVA_IN_PF;
-	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
+	const bool smaps = type == TVA_SMAPS;
+	const bool in_pf = type == TVA_PAGEFAULT;
+	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
 	unsigned long supported_orders;
 
 	/* Check the intersection of requested and supported orders. */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2c9008246785..7a54b6f2a346 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 				   struct collapse_control *cc)
 {
 	struct vm_area_struct *vma;
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
+				 TVA_FORCED_COLLAPSE;
 
 	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
@@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
 		return SCAN_ADDRESS_RANGE;
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_type, PMD_ORDER))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1532,9 +1532,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * in the page cache with a single hugepage. If a mm were to fault-in
 	 * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
 	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
-	 * analogously elide sysfs THP settings here.
+	 * analogously elide sysfs THP settings here and pretend we are
+	 * collapsing.
 	 */
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
 		return SCAN_VMA_CHECK;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2431,8 +2432,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
 skip:
 			progress++;
 			continue;
@@ -2766,7 +2766,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
 		return -EINVAL;
 
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
diff --git a/mm/memory.c b/mm/memory.c
index 92fd18a5d8d1..be761753f240 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4369,8 +4369,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
+					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
 					  vmf->address, orders);
@@ -4917,8 +4917,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	 * for this vma. Then filter out the orders that can't be allocated over
 	 * the faulting address and still be fully contained in the vma.
 	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
+					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 
 	if (!orders)
@@ -6108,8 +6108,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 retry_pud:
 	if (pud_none(*vmf.pud) &&
-	    thp_vma_allowable_order(vma, vm_flags,
-				TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER)) {
+	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PUD_ORDER)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -6143,8 +6142,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto retry_pud;
 
 	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, vm_flags,
-				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.47.3


