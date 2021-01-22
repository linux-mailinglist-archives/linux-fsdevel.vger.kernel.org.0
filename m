Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4B300EF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbhAVVc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbhAVVaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:30:14 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC85C06178B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:34 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a17so5051398qko.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7ooyFXBx1fIP/mZWl+q42UsYzUb6W7T7o6Qp5Bwm9hw=;
        b=XsWnNNT3bc6NKjNDXbJftwz4CzNpoXWdn06wSFhE9hrt040cUk7xfYmqbrN5GIVZWi
         i86OXfhFvdsu6DVlgJxXEVtz+etIe2fK6hDTiOU2ZNuVWwA6OVjCJOjxR8tzuhJS3kMb
         xZwUld/tGUOekzt3iwU/YmDZXAE2VD1ZGIdEXGjiLDvRYKyG82TgkmUDJCd+0S5ZqW4I
         70Z21Wp0GtmlzoRgbtQ1fXtAA9OaXyTuH1/uVDuqRWkKJd6Ql1sD6VTsoQGCNiMog+Ep
         B8d7aXwnk2MzbdVwMN6cCOQf9v6PYZL7IZEHfyC48t2yNf6yIQ+9ABBB60mxOeVc55Bm
         f3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ooyFXBx1fIP/mZWl+q42UsYzUb6W7T7o6Qp5Bwm9hw=;
        b=HhHjdYXLa8rzzm2+sUK7kUGcAMfX50155/J0OxvSRX5npBP6XBDD/U2YrQzysPO6Tf
         PKWr3MH3mIWnB4qsyQDUL5O7zr3Cpxur3Vmvgv4ReMmJEjYx45G1RkTaaP3qVmZAHTDY
         A1tSHwL/Wtqa7J8Y8sqXHZvKcFa/MnS2gcI5VUY4ccc3xnM8n/kqRCa3mXw55rn3uGo7
         +oPxdR/cxAemIlwKgTtWgwnUObnujv+xmzXy3QUNKjg3mEZKLxRFmYlFpMdldM7Bx918
         LtlBWXzxlmngSZjdQeInze0qTObWEUwZIiYwDiHnG26EDCKHcv89hjSQMiWGpgSKSd9w
         P6og==
X-Gm-Message-State: AOAM532sYtfhQW3jt8cicbWpFxEIDegi0pAL75BaYe7fdxNl06BJVK3V
        y5DWRlfbVE/nBElXcl3iExzSoHC6otKQuDhZJdWJ
X-Google-Smtp-Source: ABdhPJxb/hwoxHIo8QflV3z+18lopvVFKCpUYIsbtpY3zEzFE4r6BQtxe0nvXRYR/UfBzES127pXZs6ua8xttRg5W3aC
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:9d9a:: with SMTP id
 s26mr6613401qvd.9.1611350973499; Fri, 22 Jan 2021 13:29:33 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:29:19 -0800
In-Reply-To: <20210122212926.3457593-1-axelrasmussen@google.com>
Message-Id: <20210122212926.3457593-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210122212926.3457593-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 2/9] hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
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
 include/linux/hugetlb.h       | 15 +++++++++++++++
 include/linux/userfaultfd_k.h |  9 +++++++++
 mm/hugetlb.c                  |  5 ++---
 4 files changed, 27 insertions(+), 5 deletions(-)

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
index 1e0abb609976..4508136c8376 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
+#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -947,4 +948,18 @@ static inline __init void hugetlb_cma_check(void)
 }
 #endif
 
+static inline bool want_pmd_share(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_USERFAULTFD
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
+
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
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
index 07b23c81b1db..d46f50a99ff1 100644
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
2.30.0.280.ga3ce27912f-goog

