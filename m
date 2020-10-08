Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9014287053
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgJHH44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbgJHHzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C43C0613D6;
        Thu,  8 Oct 2020 00:55:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so3322261pff.6;
        Thu, 08 Oct 2020 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GLdCsDG8ctFS/IaazURKqVHKZeMbDoGOldSLDYhqodw=;
        b=Ymh6vTtxX6EemmN/d7QzIlZfSqRo6xlpNvCF2BCqgJvYYG6zd/e3mGU4qBGZQvGCpY
         D9PSW3uOm4t6AzV+XURBiWNwHdxSD9Rzpxs3XysQe40So8lMStI/7w/v7Xp+ZtB2jEaO
         YY51s2CRHcObYPHlExH3j0+wiUymftWgaAPlwQRnWh0HJI4cDolGyhXGQmg8RJMf+nS7
         SbvPpk7cZWlPHRilIPCZLDiqSIYEqjTmFa20VMcgr8rbv6PcpToXRNsU03t3U1W10reX
         9ebdbHfCtYOVM4rlIDrmNyHJJUNoeqtxlJArwf8K12zROQCZ/t8zNUBZhJIdaW6ucXoT
         COhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GLdCsDG8ctFS/IaazURKqVHKZeMbDoGOldSLDYhqodw=;
        b=ZjnGo3m3qR8sZGqy4l1XtotXWiiMpKNDaciowr1nL95ji+hQWRh6mpOF0TBP6XrhcK
         1cFKHvC2tHP2tBmvDpc+YX9c3NISp8rdSLjSY2NGuWMXs2Ln5sP5z451U5UCIteXvsSW
         FytQBMAD77pHprG6ymmQGCmYOtsYUEdamnFZlArIRL/MCvAPZmk4Gi76aiv8dzF7JqdI
         t2MwG3NFla3TPXSMem/K8p7ABfldU6j+mWV6v9zxHs3/B2OBq/IEBXxNBNAtsg+EeA0K
         63cpxMKMYQbsu7yqQ6exlCOJ/73eAmk4U0fUYCn51tX2EZE/W05NjPBcfHtlMEAZ5/b8
         OyCA==
X-Gm-Message-State: AOAM5312D/PnoYscKi1f6zviN5WZU7pYdwzC4ONhv8XhBoxGxW+tBWMC
        FhXaHbiaO+FbVZrIP8iNM2o=
X-Google-Smtp-Source: ABdhPJwcSszzr01fRpOkdPyRHaEHglnwh3D28o/3IibTaaYJl4wVZanAVU3UNnnVaH6gB1IjbtlWXQ==
X-Received: by 2002:a63:1665:: with SMTP id 37mr6436449pgw.383.1602143744116;
        Thu, 08 Oct 2020 00:55:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:43 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 27/35] mm: add pud_special() to support dmem huge pud
Date:   Thu,  8 Oct 2020 15:54:17 +0800
Message-Id: <a77b21e35deef53f66eea81198fc48dbde63d86b.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
 mm/gup.c                       | 46 ++++++++++++++++++++++++++++++++++
 mm/huge_memory.c               | 11 +++++---
 mm/memory.c                    |  4 +--
 mm/mprotect.c                  |  2 ++
 6 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 313fb4fd6645..c9a3b1f79cd5 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -266,7 +266,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_DMEM)) == _PAGE_PSE;
 }
 #endif
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b7381e5aafe5..ac8eb3e39575 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -254,7 +254,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/mm/gup.c b/mm/gup.c
index a8edbb6a2b2f..fdcaeb163bc4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -416,6 +416,42 @@ follow_special_pmd(struct vm_area_struct *vma, unsigned long address,
 	return ERR_PTR(-EEXIST);
 }
 
+static struct page *
+follow_special_pud(struct vm_area_struct *vma, unsigned long address,
+		   pud_t *pud, unsigned int flags)
+{
+	spinlock_t *ptl;
+
+	if (flags & FOLL_DUMP)
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
@@ -716,6 +752,12 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
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
@@ -2478,6 +2520,10 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
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
index a24601c93713..29e1ab959c90 100644
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
@@ -1883,7 +1885,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -1894,6 +1896,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
 	spinlock_t *ptl;
+	pud_t orig_pud;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
@@ -1904,9 +1907,9 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
index ca42a6e56e9b..3748fab7cc2a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -922,7 +922,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud) || pud_special(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, vma);
@@ -1215,7 +1215,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud) || pud_devmap(*pud) || pud_special(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 36f885cbbb30..cae78c0c5160 100644
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
-- 
2.28.0

