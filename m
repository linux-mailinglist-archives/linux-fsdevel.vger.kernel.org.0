Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E743E9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJ1VB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhJ1VBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:01:25 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33605C061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 13:58:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r13-20020a17090a1bcd00b001a1b1747cd2so4092428pjr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=1Gx3GrW6nfRdIvN3hTXoEKYwq030Bu3new2FccuYxgo=;
        b=rCt1D4mSu2vjxTTVSFG2Lu5AspB/iJjyyyyTL9vEnLgRFC3uDfKXS6CkgOun+CLV1J
         y/wG8Op0nvk9aj2joV0MIVZj3965kcvhOd3O/moGmjew9RsVsfUvCG4daSm/h7zNy5hD
         ZhmXIJZ0VnySJvB60SoJX694dKIa2FWXjoVF7mICun8WDA10u3DiqMNmLHcRS9Vacp7Y
         NOqdQt2Me4DaJ3TkaAdk+8tXn7hQsjlTisYCyZ2Shlqc4FeqjKG1QDshbLdFr3cWbCt+
         zOjoPcMx8umHzMIxY82zQDw5YUWdB/ueeLEiQEkqIReX7KLTTT3cexKg/Uq6HdnBI5n3
         UrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=1Gx3GrW6nfRdIvN3hTXoEKYwq030Bu3new2FccuYxgo=;
        b=Sv5ETARsD4jiuwMcuIhpGNfgp2R5Oz1QfB/1Av1QWDCjlvD17ncHhc7OzD2JyYMWgZ
         PrlmQfAq4B5aZoyv7QXR1BsEImXBL8fSbYZgKgM5xLBv0E3tmcFd8aNaI17L0utEyLVN
         z2XAytO/rKk01lJveOCJGFaNmbzv4zR/voT5uVVx9fG+MpWqrnh1H8ahE0HTKcNmi9T8
         pOUtLunT/qRbnQfRfhJySSS4mkoKLW8SKzPeR9VC/SE1ztBx/zgR1jIsAgyyWM7a991X
         /Vgf2LUh8+4muYU9pwh7/h29kjIU+E2eDweZfhYBYwzQ/oQh+KFRJwdcnbKJfwGHie1L
         njgA==
X-Gm-Message-State: AOAM5327v2abcgzIN/JDcvLPkQEkZuU+GPuBlJXSh0+gFcdOEEXP0lMM
        nRJOspsOBZpLOE3n1fsDEsf2bIbnZgAXI7r+Pw==
X-Google-Smtp-Source: ABdhPJwsx2QbAPnmHQN/diGDA6MEVEW27gTcAdEXpI5mnPZqo75LcKHbuSSNNHZa6+mSWL7N2ugnqt8U654P0OObvg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8b1e:c410:4c0f:5458])
 (user=almasrymina job=sendgmr) by 2002:a17:90a:2bca:: with SMTP id
 n10mr7112646pje.241.1635454737673; Thu, 28 Oct 2021 13:58:57 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:58:54 -0700
Message-Id: <20211028205854.830200-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v1] mm: Add /proc/$PID/pageflags
From:   Mina Almasry <almasrymina@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, Mina Almasry <almasrymina@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

This file lets a userspace process know the page flags of each of its virtual
pages.  It contains a 64-bit set of flags for each virtual page, containing
data identical to that emitted by /proc/kpageflags.  This allows the user-space
task can learn the kpageflags for the pages backing its address-space by
consulting one file, without needing to be root.

Example use case is a performance sensitive user-space process querying the
hugepage backing of its own memory without the root access required to access
/proc/kpageflags, and without accessing /proc/self/smaps_rollup which can be
slow and needs to hold mmap_lock.

Similar to /proc/kpageflags, the flags printed out by the kernel for
each page are provided by stable_page_flags(), which exports flag bits
that are user visible and stable over time.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: David Rientjes rientjes@google.com
Cc: Paul E. McKenney <paulmckrcu@fb.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Florian Schmidt <florian.schmidt@nutanix.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

---
 Documentation/admin-guide/mm/pagemap.rst |   9 +-
 Documentation/filesystems/proc.rst       |   5 +-
 fs/proc/base.c                           |   2 +
 fs/proc/internal.h                       |   1 +
 fs/proc/task_mmu.c                       | 158 ++++++++++++++++++-----
 5 files changed, 144 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fdc19fbc10839..79a127f671436 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -8,7 +8,7 @@ pagemap is a new (as of 2.6.25) set of interfaces in the kernel that allow
 userspace programs to examine the page tables and related information by
 reading files in ``/proc``.

-There are four components to pagemap:
+There are five components to pagemap:

  * ``/proc/pid/pagemap``.  This file lets a userspace process find out which
    physical frame each virtual page is mapped to.  It contains one 64-bit
@@ -82,6 +82,13 @@ number of times a page is mapped.
     25. IDLE
     26. PGTABLE

+ * ``/proc/pid/pageflags``.  This file lets a userspace process know the page
+   flags of each of its virtual pages.  It contains a 64-bit set of flags for
+   each virtual page, containing data identical to the one emitted by
+   /proc/kpageflags listed above.  The user-space task can learn the kpageflags
+   for the pages backing its address-space by consulting one file, without
+   needing to be root.
+
  * ``/proc/kpagecgroup``.  This file contains a 64-bit inode number of the
    memory cgroup each page is charged to, indexed by PFN. Only available when
    CONFIG_MEMCG is set.
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 042c418f40906..fab84e5966b3e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -155,6 +155,7 @@ usually fail with ESRCH.
  wchan		Present with CONFIG_KALLSYMS=y: it shows the kernel function
 		symbol the task is blocked in - or "0" if not blocked.
  pagemap	Page table
+ pageflags	Process's memory page flag information
  stack		Report full stack trace, enable via CONFIG_STACKTRACE
  smaps		An extension based on maps, showing the memory consumption of
 		each mapping and flags associated with it
@@ -619,7 +620,9 @@ Any other value written to /proc/PID/clear_refs will have no effect.

 The /proc/pid/pagemap gives the PFN, which can be used to find the pageflags
 using /proc/kpageflags and number of times a page is mapped using
-/proc/kpagecount. For detailed explanation, see
+/proc/kpagecount. /proc/pid/pageflags provides the page flags of a process's
+virtual pages, so a task can learn the kpageflags for its address space with no
+need to be root. For detailed explanation, see
 Documentation/admin-guide/mm/pagemap.rst.

 The /proc/pid/numa_maps is an extension based on maps, showing the memory
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 264509e584e3e..40febcaef6aa6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3219,6 +3219,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("pageflags",  S_IRUGO, proc_pageflags_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
@@ -3562,6 +3563,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("smaps",     S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("pageflags",  S_IRUGO, proc_pageflags_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",      S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a81..177be691a86a7 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -305,6 +305,7 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_pageflags_operations;

 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5c..4e24ff521b5f0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1291,6 +1291,10 @@ struct pagemapread {
 	int pos, len;		/* units: PM_ENTRY_BYTES, not bytes */
 	pagemap_entry_t *buffer;
 	bool show_pfn;
+	/* If to_flags is set, show the page flags for the virtual pages
+	 * instead of the mapping information.
+	 */
+	bool to_flags;
 };

 #define PAGEMAP_WALK_SIZE	(PMD_SIZE)
@@ -1331,7 +1335,8 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,

 	while (addr < end) {
 		struct vm_area_struct *vma = find_vma(walk->mm, addr);
-		pagemap_entry_t pme = make_pme(0, 0);
+		pagemap_entry_t pme =
+			make_pme(0, pm->to_flags ? stable_page_flags(NULL) : 0);
 		/* End of address space hole, which we mark as non-present. */
 		unsigned long hole_end;

@@ -1350,7 +1355,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			break;

 		/* Addresses in the VMA. */
-		if (vma->vm_flags & VM_SOFTDIRTY)
+		if ((vma->vm_flags & VM_SOFTDIRTY) && !pm->to_flags)
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
 			err = add_to_pagemap(addr, &pme, pm);
@@ -1368,6 +1373,12 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	u64 frame = 0, flags = 0;
 	struct page *page = NULL;

+	if (pm->to_flags) {
+		if (pte_present(pte))
+			page = vm_normal_page(vma, addr, pte);
+		return make_pme(0, stable_page_flags(page));
+	}
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1421,6 +1432,22 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;

+		if (pm->to_flags) {
+			pagemap_entry_t pme;
+			struct page *page =
+				pmd_present(pmd) ? pmd_page(pmd) : NULL;
+
+			for (; addr != end; addr += PAGE_SIZE) {
+				if (page)
+					page += (addr & ~PMD_MASK) >>
+						PAGE_SHIFT;
+				pme = make_pme(0, stable_page_flags(page));
+				add_to_pagemap(addr, &pme, pm);
+			}
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (pmd_present(pmd)) {
 			page = pmd_page(pmd);

@@ -1514,6 +1541,20 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		flags |= PM_SOFT_DIRTY;

 	pte = huge_ptep_get(ptep);
+
+	if (pm->to_flags) {
+		pagemap_entry_t pme;
+		struct page *page = pte_present(pte) ? pte_page(pte) : NULL;
+
+		for (; addr != end; addr += PAGE_SIZE) {
+			if (page)
+				page += (addr & ~hmask) >> PAGE_SHIFT;
+			pme = make_pme(0, stable_page_flags(page));
+			add_to_pagemap(addr, &pme, pm);
+		}
+		goto done;
+	}
+
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);

@@ -1539,6 +1580,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			frame++;
 	}

+done:
 	cond_resched();

 	return err;
@@ -1553,34 +1595,11 @@ static const struct mm_walk_ops pagemap_ops = {
 	.hugetlb_entry	= pagemap_hugetlb_range,
 };

-/*
- * /proc/pid/pagemap - an array mapping virtual pages to pfns
- *
- * For each page in the address space, this file contains one 64-bit entry
- * consisting of the following:
- *
- * Bits 0-54  page frame number (PFN) if present
- * Bits 0-4   swap type if swapped
- * Bits 5-54  swap offset if swapped
- * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
- * Bit  56    page exclusively mapped
- * Bits 57-60 zero
- * Bit  61    page is file-page or shared-anon
- * Bit  62    page swapped
- * Bit  63    page present
- *
- * If the page is not present but in swap, then the PFN contains an
- * encoding of the swap file number and the page's offset into the
- * swap. Unmapped pages return a null PFN. This allows determining
- * precisely which pages are mapped (or in swap) and comparing mapped
- * pages between processes.
- *
- * Efficient users of this interface will use /proc/pid/maps to
- * determine which areas of memory are actually mapped and llseek to
- * skip over unmapped regions.
+/* If to_flags is set, show the page flags for the virtual pages
+ * instead of the mapping information.
  */
-static ssize_t pagemap_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t pagemap_pageflags_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos, bool to_flags)
 {
 	struct mm_struct *mm = file->private_data;
 	struct pagemapread pm;
@@ -1602,6 +1621,8 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	if (!count)
 		goto out_mm;

+	pm.to_flags = to_flags;
+
 	/* do not disclose physical addresses: attack vector */
 	pm.show_pfn = file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN);

@@ -1668,6 +1689,78 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	return ret;
 }

+/*
+ * /proc/pid/pagemap - an array mapping virtual pages to pfns
+ *
+ * For each page in the address space, this file contains one 64-bit entry
+ * consisting of the following:
+ *
+ * Bits 0-54  page frame number (PFN) if present
+ * Bits 0-4   swap type if swapped
+ * Bits 5-54  swap offset if swapped
+ * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
+ * Bit  56    page exclusively mapped
+ * Bits 57-60 zero
+ * Bit  61    page is file-page or shared-anon
+ * Bit  62    page swapped
+ * Bit  63    page present
+ *
+ * If the page is not present but in swap, then the PFN contains an
+ * encoding of the swap file number and the page's offset into the
+ * swap. Unmapped pages return a null PFN. This allows determining
+ * precisely which pages are mapped (or in swap) and comparing mapped
+ * pages between processes.
+ *
+ * Efficient users of this interface will use /proc/pid/maps to
+ * determine which areas of memory are actually mapped and llseek to
+ * skip over unmapped regions.
+ */
+static ssize_t pagemap_read(struct file *file, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	return pagemap_pageflags_read(file, buf, count, ppos, false);
+}
+
+/*
+ * /proc/pid/pageflags - an array mapping virtual pages to pageflags
+ *
+ * For each page in the address space, this file contains one 64-bit entry
+ * consisting of the following:
+ *
+ * 0. LOCKED
+ * 1. ERROR
+ * 2. REFERENCED
+ * 3. UPTODATE
+ * 4. DIRTY
+ * 5. LRU
+ * 6. ACTIVE
+ * 7. SLAB
+ * 8. WRITEBACK
+ * 9. RECLAIM
+ * 10. BUDDY
+ * 11. MMAP
+ * 12. ANON
+ * 13. SWAPCACHE
+ * 14. SWAPBACKED
+ * 15. COMPOUND_HEAD
+ * 16. COMPOUND_TAIL
+ * 17. HUGE
+ * 18. UNEVICTABLE
+ * 19. HWPOISON
+ * 20. NOPAGE
+ * 21. KSM
+ * 22. THP
+ * 23. OFFLINE
+ * 24. ZERO_PAGE
+ * 25. IDLE
+ * 26. PGTABLE
+ */
+static ssize_t pageflags_read(struct file *file, char __user *buf, size_t count,
+			      loff_t *ppos)
+{
+	return pagemap_pageflags_read(file, buf, count, ppos, true);
+}
+
 static int pagemap_open(struct inode *inode, struct file *file)
 {
 	struct mm_struct *mm;
@@ -1694,6 +1787,13 @@ const struct file_operations proc_pagemap_operations = {
 	.open		= pagemap_open,
 	.release	= pagemap_release,
 };
+
+const struct file_operations proc_pageflags_operations = {
+	.llseek		= mem_lseek,
+	.read		= pageflags_read,
+	.open		= pagemap_open,
+	.release	= pagemap_release,
+};
 #endif /* CONFIG_PROC_PAGE_MONITOR */

 #ifdef CONFIG_NUMA
--
2.33.0.1079.g6e70778dc9-goog
