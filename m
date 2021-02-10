Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78A31723D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhBJVWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 16:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBJVWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:22:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 78so3929952ybn.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VBmryFKM8o9VLDG+gh0Pw8CYXmNCgracyZ1/7zA46E4=;
        b=bRwCJFZFBfkEqU8HN0Eo9K1vV/dk9ziw4khtfjoDz63kLliOjh8E8wV8y5HHmKlM1Z
         AROzReTlVbm2aCLhZZ07Q1u3EEcmgZz5ae4c3wrPKKLF31YxKpCneL41qOkGi2BEwpak
         wPaB1aWVWGOKJIJDXU40R4sHX5hMajIppuX+kxWNT7068mpvGDv//faOYoKWlKRa3IBU
         DSQNBzH3bzvUsdencjbEbGhN5lC07NeniFXseJ3nZScfj3ZYp7PtSyjhhn+QR1EfLjG0
         lgWEl6cEHoeoTtDrKOk2P0/0l13bC+mwSDbDA0s0oulOJbdknjJl1LG/jHVDE/Rxpkbc
         7qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VBmryFKM8o9VLDG+gh0Pw8CYXmNCgracyZ1/7zA46E4=;
        b=O8ECa7lDkfIk+hX4045KtDG2FIjD3bLI00dYps4RCpdwHyjQHT6Ld8aiA8UNKdiFvw
         6HwLpmoJByXFlqO5mDwjM0UR0WjJQrXWuM79EZRdcTmnITYs1pNr1cxv3F5AFAknh+b/
         Sf7QYs2jftkhe7WXhXHvY42uYBnNx5mQNS9mHrBrCav2r4eYql9YvryYlGFRWfRPe3su
         kwhGlelY5p+V2O+TwHv1erP0BIZ4APDC207fL/yT3XXrwvHX8IJIcxlrnP04yAjS+1Xp
         Vr5ToV3z3zjFXCoaw0r156dHnZzs7Rmsr5kTvd4UJk+lFMOtFoZQYuin/APGjcT+kjPZ
         +jjA==
X-Gm-Message-State: AOAM533msBxv8z75trqDjMXmxj8RAu3YVej8YJJztVz+6XOlE5tzd7Os
        2gzC9opia2fJFoa4eLqgMzzExZEBR/XhxKeksdJ+
X-Google-Smtp-Source: ABdhPJxxvTs75rP4OAzQwehPBlaiY7y7rHy+Bg3qmBLM59Qx5pzHRa6aI+S28xB81z3rkxhpHH3N8hpW9EOOt5SsHoe1
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:94ee:de01:168:9f20])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b992:: with SMTP id
 r18mr7218605ybg.86.1612992128509; Wed, 10 Feb 2021 13:22:08 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:51 -0800
In-Reply-To: <20210210212200.1097784-1-axelrasmussen@google.com>
Message-Id: <20210210212200.1097784-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 01/10] hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

It is a preparation work to be able to behave differently in the per
architecture huge_pte_alloc() according to different VMA attributes.

Pass it deeper into huge_pmd_share() so that we can avoid the find_vma() call.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 arch/arm64/mm/hugetlbpage.c   |  4 ++--
 arch/ia64/mm/hugetlbpage.c    |  3 ++-
 arch/mips/mm/hugetlbpage.c    |  4 ++--
 arch/parisc/mm/hugetlbpage.c  |  2 +-
 arch/powerpc/mm/hugetlbpage.c |  3 ++-
 arch/s390/mm/hugetlbpage.c    |  2 +-
 arch/sh/mm/hugetlbpage.c      |  2 +-
 arch/sparc/mm/hugetlbpage.c   |  6 +-----
 include/linux/hugetlb.h       |  5 +++--
 mm/hugetlb.c                  | 15 ++++++++-------
 mm/userfaultfd.c              |  2 +-
 11 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 55ecf6de9ff7..6e3bcffe2837 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -252,7 +252,7 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, pte);
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
@@ -286,7 +286,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	} else if (sz == PMD_SIZE) {
 		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
 		    pud_none(READ_ONCE(*pudp)))
-			ptep = huge_pmd_share(mm, addr, pudp);
+			ptep = huge_pmd_share(mm, vma, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
 	} else if (sz == (CONT_PMD_SIZE)) {
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index b331f94d20ac..f993cb36c062 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -25,7 +25,8 @@ unsigned int hpage_shift = HPAGE_SHIFT_DEFAULT;
 EXPORT_SYMBOL(hpage_shift);
 
 pte_t *
-huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+	       unsigned long addr, unsigned long sz)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
diff --git a/arch/mips/mm/hugetlbpage.c b/arch/mips/mm/hugetlbpage.c
index b9f76f433617..7eaff5b07873 100644
--- a/arch/mips/mm/hugetlbpage.c
+++ b/arch/mips/mm/hugetlbpage.c
@@ -21,8 +21,8 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
-		      unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index 30e0a862a0b2..f67f64709f50 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -44,7 +44,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 }
 
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 4e7d9b91f1da..e5caf2455aa4 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -106,7 +106,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
  */
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
 {
 	pgd_t *pg;
 	p4d_t *p4;
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 3b5a4d25ca9b..da36d13ffc16 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -189,7 +189,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgdp;
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 220d7bc43d2b..999ab5916e69 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -21,7 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ad4b42f04988..a487ea2977a2 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -275,11 +275,7 @@ static unsigned long huge_tte_to_size(pte_t pte)
 	return size;
 }
 
-unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift(*(pte_t *)&pud); }
-unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&pmd); }
-unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
-
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ce6533584eb7..ca6e5ba56f73 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -152,7 +152,8 @@ void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, pud_t *pud);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -161,7 +162,7 @@ extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0b7079dd0d35..32d4d2e277ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3757,7 +3757,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-		dst_pte = huge_pte_alloc(dst, addr, sz);
+		dst_pte = huge_pte_alloc(dst, vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
@@ -4494,7 +4494,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	mapping = vma->vm_file->f_mapping;
 	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
 	if (!ptep) {
 		i_mmap_unlock_read(mapping);
 		return VM_FAULT_OOM;
@@ -5289,9 +5289,9 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
  * only required for subsequent processing.
  */
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, pud_t *pud)
 {
-	struct vm_area_struct *vma = find_vma(mm, addr);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = ((addr - vma->vm_start) >> PAGE_SHIFT) +
 			vma->vm_pgoff;
@@ -5369,7 +5369,8 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 #define want_pmd_share()	(1)
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
-pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
+		      unsigned long addr, pud_t *pud)
 {
 	return NULL;
 }
@@ -5388,7 +5389,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-pte_t *huge_pte_alloc(struct mm_struct *mm,
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
@@ -5407,7 +5408,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		} else {
 			BUG_ON(sz != PMD_SIZE);
 			if (want_pmd_share() && pud_none(*pud))
-				pte = huge_pmd_share(mm, addr, pud);
+				pte = huge_pmd_share(mm, vma, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7423808640ef..b2ce61c1b50d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -290,7 +290,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		err = -ENOMEM;
-		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
+		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-- 
2.30.0.478.g8a0d178c01-goog

