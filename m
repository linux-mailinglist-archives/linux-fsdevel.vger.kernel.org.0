Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622362D0F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgLGLgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgLGLfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6BC061A52;
        Mon,  7 Dec 2020 03:35:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p21so6863193pjv.0;
        Mon, 07 Dec 2020 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1pOMiSZIT4zzWwCC3RI8cqklW1Nb035cekwxKtaaVc=;
        b=tdedZG4TA6YIeSkLXKLwKJSIDRJsgaWD49qSThY/5qRbEOGMhswjKF+y+3tE//Q9GX
         Z46nH7F5RztgV7IpQF+nvQh5fP0PRvVuDbCtmL+DqLUnzwsCtwEWrcKYUUE4IOslWky6
         zQLJvUhDs403MDnqw27lWTBP71HJqyW9dk+grHTF+6OPgJ452jBXTUZi8b4Iy1LCRY0a
         B7KsP2/DYqTQU9tErE4rG6jV75Gvt9+RD+EOGMwwsh3JBsAoxFJxie7XD44CJODdyBMH
         ZZjkx5xM1o3RMpaknmRKIUEsPRJuMTFE4JxUIeBNSdaI67DN+EkZESbAsjtXaH7s5v8J
         dDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1pOMiSZIT4zzWwCC3RI8cqklW1Nb035cekwxKtaaVc=;
        b=XarqcgMty2DANalvWUi+wBj7eVwtfSz4uJHvuumkVUU4IfchAJVylU5645ao0FKS4d
         kJ6pHp/m2B8XdveZZ1rrNKCfPY3FlC2Zdu7YsLf/Kb240+QquKbT6DF1OsMZVarGHDcO
         F9BsMUgEbnvWmJny7sGaAP/Eb13Z8UJ5K0+1SSgLSbXNt0CDnYpBjy1HZCcIWzdNNUxL
         +kJJ9g6qADk7O1WcmRow6ZxqoIDGIRznInnRU0hVE9TT0s8l0VP+pW+FpkGbZD+N71T+
         7qcC8+zi6bV4FYe7wkIh7gkdoTixotG+cfxUHbK7CHZUxmZm6jDHPwUZuXXF/cDJKcN5
         k9Lg==
X-Gm-Message-State: AOAM533v/0xfl/sY5vLcuhxAcY0VedWLy8tMbl7MG4xCmHnV6+7xz5e1
        R2UyGezRlZhUa/Z5SyEptJk=
X-Google-Smtp-Source: ABdhPJwOADOp4BHe+nOTWmOnCV7Krmz1UonOWASME9633gE5AHOao5YhBEMB9G6gr5genfai3+Mg9g==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr16288519pjo.176.1607340911988;
        Mon, 07 Dec 2020 03:35:11 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:11 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 27/37] mm: add pud_special() check to support dmem huge pud
Date:   Mon,  7 Dec 2020 19:31:20 +0800
Message-Id: <daeb7315990415d272803d5ddbf46418dac4a8f8.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add pud_special() and follow_special_pud() to support dmem
huge pud as we do for dmem huge pmd.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/include/asm/pgtable.h |  2 +-
 include/linux/huge_mm.h        |  2 +-
 mm/gup.c                       | 46 ++++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c               | 11 ++++++----
 mm/memory.c                    |  4 ++--
 mm/mprotect.c                  |  2 ++
 mm/pagewalk.c                  |  2 +-
 7 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9e36d42..2284387 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -265,7 +265,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_DMEM)) == _PAGE_PSE;
 }
 #endif
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2514b90..b69c940 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -251,7 +251,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/mm/gup.c b/mm/gup.c
index 0ea9071..8eb85ba 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -423,6 +423,42 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 	return ERR_PTR(-EEXIST);
 }
 
+static struct page *
+follow_special_pud(struct vm_area_struct *vma, unsigned long address,
+		   pud_t *pud, unsigned int flags)
+{
+	spinlock_t *ptl;
+
+	if ((flags & FOLL_DUMP) && is_huge_zero_pud(*pud))
+		/* Avoid special (like zero) pages in core dumps */
+		return ERR_PTR(-EFAULT);
+
+	/* No page to get reference */
+	if (flags & FOLL_GET)
+		return ERR_PTR(-EFAULT);
+
+	if (flags & FOLL_TOUCH) {
+		pud_t _pud;
+
+		ptl = pud_lock(vma->vm_mm, pud);
+		if (!pud_special(*pud)) {
+			spin_unlock(ptl);
+			return NULL;
+		}
+		_pud = pud_mkyoung(*pud);
+		if (flags & FOLL_WRITE)
+			_pud = pud_mkdirty(_pud);
+		if (pudp_set_access_flags(vma, address & HPAGE_PMD_MASK,
+					  pud, _pud,
+					  flags & FOLL_WRITE))
+			update_mmu_cache_pud(vma, address, pud);
+		spin_unlock(ptl);
+	}
+
+	/* Proper page table entry exists, but no corresponding struct page */
+	return ERR_PTR(-EEXIST);
+}
+
 /*
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
@@ -726,6 +762,12 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 			return page;
 		return no_page_table(vma, flags);
 	}
+	if (pud_special(*pud)) {
+		page = follow_special_pud(vma, address, pud, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
 	if (is_hugepd(__hugepd(pud_val(*pud)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pud_val(*pud)), flags,
@@ -2511,6 +2553,10 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
+	/* Bypass dmem pud. It will be handled in outside routine. */
+	if (pud_special(orig))
+		return 0;
+
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6e52d57..7c5385a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -883,6 +883,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
+	if (pfn_t_dmem(pfn))
+		entry = pud_mkdmem(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -919,7 +921,7 @@ vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 	 * can't support a 'special' bit.
 	 */
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+			!pfn_t_devmap(pfn) && !pfn_t_dmem(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1911,7 +1913,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -1922,6 +1924,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
 	spinlock_t *ptl;
+	pud_t orig_pud;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
@@ -1932,9 +1935,9 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pudp related
 	 * operations.
 	 */
-	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_special_huge(vma)) {
+	if (vma_is_special_huge(vma) || pud_special(orig_pud)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index abb9148..01f3b05 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1078,7 +1078,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud) || pud_special(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1375,7 +1375,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b1650b5..05fa453 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -292,6 +292,8 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		if (pud_special(*pud))
+			continue;
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e7c4575..afd8bca 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -129,7 +129,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	do {
  again:
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
+		if (pud_none(*pud) || (!walk->vma && !walk->no_vma) || pud_special(*pud)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
-- 
1.8.3.1

