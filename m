Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A137A815
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhEKNuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 09:50:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2703 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhEKNuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 09:50:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FffN911FSz1BLNY;
        Tue, 11 May 2021 21:46:33 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 21:49:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <hughd@google.com>, <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 3/5] mm/huge_memory.c: add missing read-only THP checking in transparent_hugepage_enabled()
Date:   Tue, 11 May 2021 21:48:55 +0800
Message-ID: <20210511134857.1581273-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210511134857.1581273-1-linmiaohe@huawei.com>
References: <20210511134857.1581273-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
(non-shmem) FS"), read-only THP file mapping is supported. But it
forgot to add checking for it in transparent_hugepage_enabled().
To fix it, we add checking for read-only THP file mapping and also
introduce helper transhuge_vma_enabled() to check whether thp is
enabled for specified vma to reduce duplicated code. We rename
transparent_hugepage_enabled to transparent_hugepage_active to make
the code easier to follow as suggested by David Hildenbrand.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/proc/task_mmu.c      |  2 +-
 include/linux/huge_mm.h | 27 ++++++++++++++++++++-------
 mm/huge_memory.c        | 11 ++++++++++-
 mm/khugepaged.c         |  4 +---
 mm/shmem.c              |  3 +--
 5 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc9784544b24..7389df326edd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -832,7 +832,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   transparent_hugepage_enabled(vma));
+		   transparent_hugepage_active(vma));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0a526f211fec..a35c13d1f487 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -115,9 +115,19 @@ extern struct kobj_attribute shmem_enabled_attr;
 
 extern unsigned long transparent_hugepage_flags;
 
+static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
+					  unsigned long vm_flags)
+{
+	/* Explicitly disabled through madvise. */
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
+	return true;
+}
+
 /*
  * to be used on vmas which are known to support THP.
- * Use transparent_hugepage_enabled otherwise
+ * Use transparent_hugepage_active otherwise
  */
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
@@ -128,15 +138,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
 		return false;
 
-	if (vma->vm_flags & VM_NOHUGEPAGE)
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
 		return false;
 
 	if (vma_is_temporary_stack(vma))
 		return false;
 
-	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
 
@@ -150,7 +157,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
-bool transparent_hugepage_enabled(struct vm_area_struct *vma);
+bool transparent_hugepage_active(struct vm_area_struct *vma);
 
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long haddr)
@@ -351,7 +358,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
+static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
 	return false;
 }
@@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
+					  unsigned long vm_flags)
+{
+	return false;
+}
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 static inline bool is_transparent_hugepage(struct page *page)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76ca1eb2a223..4f37867eed12 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -63,7 +63,14 @@ static struct shrinker deferred_split_shrinker;
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 
-bool transparent_hugepage_enabled(struct vm_area_struct *vma)
+static inline bool file_thp_enabled(struct vm_area_struct *vma)
+{
+	return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
+	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
+	       (vma->vm_flags & VM_EXEC);
+}
+
+bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
 	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
@@ -74,6 +81,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
+		return file_thp_enabled(vma);
 
 	return false;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..d97b20fad6e8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
 static bool hugepage_vma_check(struct vm_area_struct *vma,
 			       unsigned long vm_flags)
 {
-	/* Explicitly disabled through madvise. */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
 	/* Enabled via shmem mount options or sysfs settings. */
diff --git a/mm/shmem.c b/mm/shmem.c
index a08cedefbfaa..1dcbec313c70 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
-- 
2.23.0

