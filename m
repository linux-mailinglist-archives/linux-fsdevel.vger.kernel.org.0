Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4F2F8507
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbhAOTFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387921AbhAOTFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:05:51 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305EC061794
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l8so7916362pjf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kKZn5EyK0lQoLlnKRIFyY3LHCOTCOwIOG+DqX75cVYE=;
        b=QJL0aQTRF6WjNZuTt0mjMBY74hIjWKebdDFkV+WmR96bfMmQhdzy6Ievi+D1ScQamO
         psY9xVq3kEOtbQj3AOrbf6zPjwcBO8HNywraylE7HrrAM921aa/9eFdExHyKGJFf75Rs
         ejeXP4E5dtnAlbmaIv7bQYxY1PmCSMMk4YBs/IF4rOIUEKz2WwhgjJmUmnLfmSPbMyT/
         cwhoQtFdtg4xazhM3/Tt9SaRgiW7xMDZLKik3nDLO0BzMbbAc5dNwcVvLFYoVkFd2+hj
         hobws0TW0rJqrv2qHUQ0FM9cxeDmad+V93uCdaBWGNqFZxPZpuSsgaQKaH1xOnsUu8Yx
         XmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kKZn5EyK0lQoLlnKRIFyY3LHCOTCOwIOG+DqX75cVYE=;
        b=h1SlvzWPOKGrmMIpmr7MzPiJp7Q87q3K0DDW1dl8tkdQQsm6boFXC0peKm0ELvuFj8
         SJ31pseGrSXJQpQWPH1cCzfqjBxc2URtiZfpVfEhSp92T/Jsj4lIOInlZ4ZgDx16GIQH
         U0iVoLGO4iEuG9pM3+t2Z0XBrLgBaXdJ7nZUmqE5iAhMiumaQF3XGLlGW/WQoqgC+/vE
         PK1bnyEd3aGLODIi96DWGeDJEHDt9rlOo2SZQdyN6yXPu/+OGblpT0i7cPsVEtTzf4yn
         5kgs6uYkqOJkBCgc3sguWlVZ3z2IxwhNhfGAzttlftrTH9e6lDmaIpQBb1XMgkbdVyot
         e6Hg==
X-Gm-Message-State: AOAM530f1n8lDwIMTFwrhOhZ9zcdPN8fpjtHuJ77t638AWa8RvYvVaQb
        KKiqP3QR5Q1r5tJKSn90at/smKNsqoiexT1Kk1lp
X-Google-Smtp-Source: ABdhPJyKVB/78lGsSqY8XilYt+Uja9F1K5zt3dfdTXKjEFRdpvqLA6pH6/W3MRpFKW0veksNz33GVXypGZHMSr1OmAdn
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:bb95:b029:dc:e7b:fd6e with
 SMTP id m21-20020a170902bb95b02900dc0e7bfd6emr14121161pls.12.1610737511070;
 Fri, 15 Jan 2021 11:05:11 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:04:44 -0800
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Message-Id: <20210115190451.3135416-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/9] hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
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
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Huge pmd sharing could bring problem to userfaultfd.  The thing is that
userfaultfd is running its logic based on the special bits on page table
entries, however the huge pmd sharing could potentially share page table
entries for different address ranges.  That could cause issues on either:

  - When sharing huge pmd page tables for an uffd write protected range, the
    newly mapped huge pmd range will also be write protected unexpectedly, or,

  - When we try to write protect a range of huge pmd shared range, we'll first
    do huge_pmd_unshare() in hugetlb_change_protection(), however that also
    means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
    region, which could lead to data loss.

Since at it, a few other things are done altogether:

  - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
    that's definitely something that arch code would like to use too

  - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
    trying to share huge pmd.  Switch to the want_pmd_share() helper.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 arch/arm64/mm/hugetlbpage.c   |  3 +--
 include/linux/hugetlb.h       | 12 ++++++++++++
 include/linux/userfaultfd_k.h |  9 +++++++++
 mm/hugetlb.c                  |  5 ++---
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5b32ec888698..1a8ce0facfe8 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		ptep = pte_alloc_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
-		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
-		    pud_none(READ_ONCE(*pudp)))
+		if (want_pmd_share(vma) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e0abb609976..4959e94e78b1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
+#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -947,4 +948,15 @@ static inline __init void hugetlb_cma_check(void)
 }
 #endif
 
+static inline bool want_pmd_share(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+	return true;
+#else
+	return false;
+#endif
+}
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..c63ccdae3eab 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -52,6 +52,15 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
 }
 
+/*
+ * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
+ * protect information is per pgtable entry.
+ */
+static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_WP;
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16a8d5ac68c0..1ad91d94cbe2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5371,7 +5371,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
 	return 1;
 }
-#define want_pmd_share()	(1)
+
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5388,7 +5388,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
 }
-#define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
@@ -5410,7 +5409,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			pte = (pte_t *)pud;
 		} else {
 			BUG_ON(sz != PMD_SIZE);
-			if (want_pmd_share() && pud_none(*pud))
+			if (want_pmd_share(vma) && pud_none(*pud))
 				pte = huge_pmd_share(mm, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

