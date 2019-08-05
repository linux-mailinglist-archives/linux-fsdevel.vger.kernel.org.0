Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8A82391
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHERFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 13:05:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40667 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHERFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:05:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so36654584pla.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6enbaRgCy1S7rDBZDVFGQw1ilVeWELi091dal/0bsE=;
        b=Jd/oDqqYqEEx6bAkYfJ03zB6NioQX2VAZMqUJC5xLJHmgZUu1k3uKRc3upFfPicpph
         d1Ve6CbjaKxcRigKMThMiCfZjZRpAtt2NWtIMRO0biXI7wI9MUN2CeSK4Ogvk0sd6nu1
         H0PefrTdNZNPee+9n+GQBlegHmjSaE9fGdVEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6enbaRgCy1S7rDBZDVFGQw1ilVeWELi091dal/0bsE=;
        b=GlW0qPOUUwvYKbRR1PKV7w9aHHsBu7XRQWGnK5GlxJ5PFfimvAPWB/ZzXMWKkzWYPn
         RZokB+qlMxVtdg6vKdycM9XUj4SjuOWqWK6BjxLwWeLvKJw3JVKG9nklwJ5MmGtafAwk
         4VT4M0DnnncjQjZB1Bm1fLcnQ3vPTFn02NHiCLtoeL7WvwbwbYRhXgfJ+CsEsDqoP0+u
         6TNtJz7ojYd/+IfmPkvYmA/CvhwSJ3rERES72JUv08/QxgHTafqZhF2/pU1T+y7qV3VB
         jwVcvQx5OPxiPVnWF9oHUOaRsjAGGP1Aw+KCbj5+pAMx0p/4b0hNXSEEx8O7yy3Jl3Uh
         yk+A==
X-Gm-Message-State: APjAAAXfumHeNGJRC86b0F14gekT97kif/03YU8q5KIGu3oDDG37CgML
        T3Vft8gdCIw9UJfawYoVLAY=
X-Google-Smtp-Source: APXvYqwSCqsoisfaWyCSJh4gcO6tQVWxuNAzv4r7rc01gy8/qv4CayOnZvwQwv9S/jT0suuw4ucWEQ==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr145121799plp.61.1565024704990;
        Mon, 05 Aug 2019 10:05:04 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p23sm89832934pfn.10.2019.08.05.10.05.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:05:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 1/5] mm/page_idle: Add per-pid idle page tracking using virtual indexing
Date:   Mon,  5 Aug 2019 13:04:47 -0400
Message-Id: <20190805170451.26009-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page_idle tracking feature currently requires looking up the pagemap
for a process followed by interacting with /sys/kernel/mm/page_idle.
Looking up PFN from pagemap in Android devices is not supported by
unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.

This patch adds support to directly interact with page_idle tracking at
the PID level by introducing a /proc/<pid>/page_idle file.  It follows
the exact same semantics as the global /sys/kernel/mm/page_idle, but now
looking up PFN through pagemap is not needed since the interface uses
virtual frame numbers, and at the same time also does not require
SYS_ADMIN.

In Android, we are using this for the heap profiler (heapprofd) which
profiles and pin points code paths which allocates and leaves memory
idle for long periods of time. This method solves the security issue
with userspace learning the PFN, and while at it is also shown to yield
better results than the pagemap lookup, the theory being that the window
where the address space can change is reduced by eliminating the
intermediate pagemap look up stage. In virtual address indexing, the
process's mmap_sem is held for the duration of the access.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v3->v4: Minor fixups (Minchan)
        Add swap pte handling (Konstantin, Minchan)
v2->v3:
Fixed a bug where I was doing a kfree that is not needed due to not
needing to do GFP_ATOMIC allocations.

v1->v2:
Mark swap ptes as idle (Minchan)
Avoid need for GFP_ATOMIC (Andrew)
Get rid of idle_page_list lock by moving list to stack

Internal review -> v1:
Fixes from Suren.
Corrections to change log, docs (Florian, Sandeep)

 arch/Kconfig                  |   3 +
 fs/proc/base.c                |   3 +
 fs/proc/internal.h            |   1 +
 fs/proc/task_mmu.c            |  43 ++++
 include/asm-generic/pgtable.h |   6 +
 include/linux/page_idle.h     |   4 +
 mm/page_idle.c                | 359 +++++++++++++++++++++++++++++-----
 mm/rmap.c                     |   2 +
 8 files changed, 376 insertions(+), 45 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..3aa121ce824e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -575,6 +575,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config HAVE_ARCH_SOFT_DIRTY
 	bool
 
+config HAVE_ARCH_PTE_SWP_PGIDLE
+	bool
+
 config HAVE_MOD_ARCH_SPECIFIC
 	bool
 	help
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..fd2f74bd4e35 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3039,6 +3039,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+#ifdef CONFIG_IDLE_PAGE_TRACKING
+	REG("page_idle", S_IRUSR|S_IWUSR, proc_page_idle_operations),
+#endif
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index cd0c8d5ce9a1..bc9371880c63 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -293,6 +293,7 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_page_idle_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 582c5e680176..a9003fe8d267 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1650,6 +1650,49 @@ const struct file_operations proc_pagemap_operations = {
 	.open		= pagemap_open,
 	.release	= pagemap_release,
 };
+
+#ifdef CONFIG_IDLE_PAGE_TRACKING
+static ssize_t proc_page_idle_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	return page_idle_proc_read(file, buf, count, ppos);
+}
+
+static ssize_t proc_page_idle_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return page_idle_proc_write(file, (char __user *)buf, count, ppos);
+}
+
+static int proc_page_idle_open(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm;
+
+	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
+	file->private_data = mm;
+	return 0;
+}
+
+static int proc_page_idle_release(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	if (mm)
+		mmdrop(mm);
+	return 0;
+}
+
+const struct file_operations proc_page_idle_operations = {
+	.llseek		= mem_lseek, /* borrow this */
+	.read		= proc_page_idle_read,
+	.write		= proc_page_idle_write,
+	.open		= proc_page_idle_open,
+	.release	= proc_page_idle_release,
+};
+#endif /* CONFIG_IDLE_PAGE_TRACKING */
+
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
 #ifdef CONFIG_NUMA
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..6d51d0a355a7 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -712,6 +712,12 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #define arch_start_context_switch(prev)	do {} while (0)
 #endif
 
+#ifndef CONFIG_HAVE_ARCH_PTE_SWP_PGIDLE
+static inline pte_t pte_swp_mkpage_idle(pte_t pte) { return pte; }
+static inline int pte_swp_page_idle(pte_t pte) { return 0; }
+static inline pte_t pte_swp_clear_mkpage_idle(pte_t pte) { return pte; }
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 1e894d34bdce..f1bc2640d85e 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -106,6 +106,10 @@ static inline void clear_page_idle(struct page *page)
 }
 #endif /* CONFIG_64BIT */
 
+ssize_t page_idle_proc_write(struct file *file,
+	char __user *buf, size_t count, loff_t *ppos, struct task_struct *tsk);
+ssize_t page_idle_proc_read(struct file *file,
+	char __user *buf, size_t count, loff_t *ppos, struct task_struct *tsk);
 #else /* !CONFIG_IDLE_PAGE_TRACKING */
 
 static inline bool page_is_young(struct page *page)
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..a5b00d63216c 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -5,17 +5,22 @@
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
 #include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/pagemap.h>
-#include <linux/rmap.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmzone.h>
 #include <linux/page_ext.h>
 #include <linux/page_idle.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/sched/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #define BITMAP_CHUNK_SIZE	sizeof(u64)
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
 /*
+ * Get a reference to a page for idle tracking purposes, with additional checks.
+ *
  * Idle page tracking only considers user memory pages, for other types of
  * pages the idle flag is always unset and an attempt to set it is silently
  * ignored.
@@ -25,18 +30,13 @@
  * page tracking. With such an indicator of user pages we can skip isolated
  * pages, but since there are not usually many of them, it will hardly affect
  * the overall result.
- *
- * This function tries to get a user memory page by pfn as described above.
  */
-static struct page *page_idle_get_page(unsigned long pfn)
+static struct page *page_idle_get_page(struct page *page_in)
 {
 	struct page *page;
 	pg_data_t *pgdat;
 
-	if (!pfn_valid(pfn))
-		return NULL;
-
-	page = pfn_to_page(pfn);
+	page = page_in;
 	if (!page || !PageLRU(page) ||
 	    !get_page_unless_zero(page))
 		return NULL;
@@ -51,6 +51,18 @@ static struct page *page_idle_get_page(unsigned long pfn)
 	return page;
 }
 
+/*
+ * This function tries to get a user memory page by pfn as described above.
+ */
+static struct page *page_idle_get_page_pfn(unsigned long pfn)
+{
+
+	if (!pfn_valid(pfn))
+		return NULL;
+
+	return page_idle_get_page(pfn_to_page(pfn));
+}
+
 static bool page_idle_clear_pte_refs_one(struct page *page,
 					struct vm_area_struct *vma,
 					unsigned long addr, void *arg)
@@ -118,6 +130,47 @@ static void page_idle_clear_pte_refs(struct page *page)
 		unlock_page(page);
 }
 
+/* Helper to get the start and end frame given a pos and count */
+static int page_idle_get_frames(loff_t pos, size_t count, struct mm_struct *mm,
+				unsigned long *start, unsigned long *end)
+{
+	unsigned long max_frame;
+
+	/* If an mm is not given, assume we want physical frames */
+	max_frame = mm ? (mm->task_size >> PAGE_SHIFT) : max_pfn;
+
+	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
+		return -EINVAL;
+
+	*start = pos * BITS_PER_BYTE;
+	if (*start >= max_frame)
+		return -ENXIO;
+
+	*end = *start + count * BITS_PER_BYTE;
+	if (*end > max_frame)
+		*end = max_frame;
+	return 0;
+}
+
+static bool page_idle_pte_check(struct page *page)
+{
+	if (!page)
+		return false;
+
+	if (page_is_idle(page)) {
+		/*
+		 * The page might have been referenced via a
+		 * pte, in which case it is not idle. Clear
+		 * refs and recheck.
+		 */
+		page_idle_clear_pte_refs(page);
+		if (page_is_idle(page))
+			return true;
+	}
+
+	return false;
+}
+
 static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t pos, size_t count)
@@ -125,35 +178,21 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 	u64 *out = (u64 *)buf;
 	struct page *page;
 	unsigned long pfn, end_pfn;
-	int bit;
+	int bit, ret;
 
-	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
-		return -EINVAL;
-
-	pfn = pos * BITS_PER_BYTE;
-	if (pfn >= max_pfn)
-		return 0;
-
-	end_pfn = pfn + count * BITS_PER_BYTE;
-	if (end_pfn > max_pfn)
-		end_pfn = max_pfn;
+	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
+	if (ret == -ENXIO)
+		return 0;  /* Reads beyond max_pfn do nothing */
+	else if (ret)
+		return ret;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if (!bit)
 			*out = 0ULL;
-		page = page_idle_get_page(pfn);
-		if (page) {
-			if (page_is_idle(page)) {
-				/*
-				 * The page might have been referenced via a
-				 * pte, in which case it is not idle. Clear
-				 * refs and recheck.
-				 */
-				page_idle_clear_pte_refs(page);
-				if (page_is_idle(page))
-					*out |= 1ULL << bit;
-			}
+		page = page_idle_get_page_pfn(pfn);
+		if (page && page_idle_pte_check(page)) {
+			*out |= 1ULL << bit;
 			put_page(page);
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
@@ -170,23 +209,16 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	const u64 *in = (u64 *)buf;
 	struct page *page;
 	unsigned long pfn, end_pfn;
-	int bit;
-
-	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
-		return -EINVAL;
+	int bit, ret;
 
-	pfn = pos * BITS_PER_BYTE;
-	if (pfn >= max_pfn)
-		return -ENXIO;
-
-	end_pfn = pfn + count * BITS_PER_BYTE;
-	if (end_pfn > max_pfn)
-		end_pfn = max_pfn;
+	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
+	if (ret)
+		return ret;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
 		if ((*in >> bit) & 1) {
-			page = page_idle_get_page(pfn);
+			page = page_idle_get_page_pfn(pfn);
 			if (page) {
 				page_idle_clear_pte_refs(page);
 				set_page_idle(page);
@@ -224,6 +256,243 @@ struct page_ext_operations page_idle_ops = {
 };
 #endif
 
+/*  page_idle tracking for /proc/<pid>/page_idle */
+
+struct page_node {
+	struct page *page;
+	unsigned long addr;
+	struct list_head list;
+};
+
+struct page_idle_proc_priv {
+	unsigned long start_addr;
+	char *buffer;
+	int write;
+
+	/* Pre-allocate and provide nodes to pte_page_idle_proc_add() */
+	struct page_node *page_nodes;
+	int cur_page_node;
+	struct list_head *idle_page_list;
+};
+
+/*
+ * Set a page as idle or add it to a list to be set as idle later.
+ */
+static void pte_page_idle_proc_add(struct page *page,
+			       unsigned long addr, struct mm_walk *walk)
+{
+	struct page *page_get = NULL;
+	struct page_node *pn;
+	int bit;
+	unsigned long frames;
+	struct page_idle_proc_priv *priv = walk->private;
+	u64 *chunk = (u64 *)priv->buffer;
+
+	if (priv->write) {
+		VM_BUG_ON(!page);
+
+		/* Find whether this page was asked to be marked */
+		frames = (addr - priv->start_addr) >> PAGE_SHIFT;
+		bit = frames % BITMAP_CHUNK_BITS;
+		chunk = &chunk[frames / BITMAP_CHUNK_BITS];
+		if (((*chunk >> bit) & 1) == 0)
+			return;
+	}
+
+	if (page) {
+		page_get = page_idle_get_page(page);
+		if (!page_get)
+			return;
+	} else {
+		/* For swapped pages, set output bit as idle */
+		frames = (addr - priv->start_addr) >> PAGE_SHIFT;
+		bit = frames % BITMAP_CHUNK_BITS;
+		chunk = &chunk[frames / BITMAP_CHUNK_BITS];
+		*chunk |= (1 << bit);
+		return;
+	}
+
+	/*
+	 * For all other pages, add it to a list since we have to walk rmap,
+	 * which acquires ptlock, and we cannot walk rmap right now.
+	 */
+	pn = &(priv->page_nodes[priv->cur_page_node++]);
+	pn->page = page_get;
+	pn->addr = addr;
+	list_add(&pn->list, priv->idle_page_list);
+}
+
+static int pte_page_idle_proc_range(pmd_t *pmd, unsigned long addr,
+				    unsigned long end,
+				    struct mm_walk *walk)
+{
+	pte_t *pte;
+	spinlock_t *ptl;
+	struct page *page;
+	struct vm_area_struct *vma = walk->vma;
+	struct page_idle_proc_priv *priv = walk->private;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (pmd_present(*pmd)) {
+			page = follow_trans_huge_pmd(vma, addr, pmd,
+						     FOLL_DUMP|FOLL_WRITE);
+			if (!IS_ERR_OR_NULL(page))
+				pte_page_idle_proc_add(page, addr, walk);
+		}
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		/* For swap_pte handling, we use an idle bit in the swap pte. */
+		if (is_swap_pte(*pte)) {
+			if (priv->write) {
+				set_pte_at(walk->mm, addr, pte,
+					   pte_swp_mkpage_idle(*pte));
+			} else {
+				/* If swap pte has idle bit set, report it as idle */
+				if (pte_swp_page_idle(*pte))
+					pte_page_idle_proc_add(NULL, addr, walk);
+			}
+			continue;
+		}
+
+		if (!pte_present(*pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, *pte);
+		if (page)
+			pte_page_idle_proc_add(page, addr, walk);
+	}
+
+	pte_unmap_unlock(pte - 1, ptl);
+	return 0;
+}
+
+ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
+			       size_t count, loff_t *pos, int write)
+{
+	int ret;
+	char *buffer;
+	u64 *out;
+	unsigned long start_addr, end_addr, start_frame, end_frame;
+	struct mm_struct *mm = file->private_data;
+	struct mm_walk walk = { .pmd_entry = pte_page_idle_proc_range, };
+	struct page_node *cur;
+	struct page_idle_proc_priv priv;
+	bool walk_error = false;
+	LIST_HEAD(idle_page_list);
+
+	if (!mm || !mmget_not_zero(mm))
+		return -EINVAL;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_mmput;
+	}
+	out = (u64 *)buffer;
+
+	if (write && copy_from_user(buffer, ubuff, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = page_idle_get_frames(*pos, count, mm, &start_frame, &end_frame);
+	if (ret)
+		goto out;
+
+	start_addr = (start_frame << PAGE_SHIFT);
+	end_addr = (end_frame << PAGE_SHIFT);
+	priv.buffer = buffer;
+	priv.start_addr = start_addr;
+	priv.write = write;
+
+	priv.idle_page_list = &idle_page_list;
+	priv.cur_page_node = 0;
+	priv.page_nodes = kzalloc(sizeof(struct page_node) *
+				  (end_frame - start_frame), GFP_KERNEL);
+	if (!priv.page_nodes) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	walk.private = &priv;
+	walk.mm = mm;
+
+	down_read(&mm->mmap_sem);
+
+	/*
+	 * idle_page_list is needed because walk_page_vma() holds ptlock which
+	 * deadlocks with page_idle_clear_pte_refs(). So we have to collect all
+	 * pages first, and then call page_idle_clear_pte_refs().
+	 */
+	ret = walk_page_range(start_addr, end_addr, &walk);
+	if (ret)
+		walk_error = true;
+
+	list_for_each_entry(cur, &idle_page_list, list) {
+		int bit, index;
+		unsigned long off;
+		struct page *page = cur->page;
+
+		if (unlikely(walk_error))
+			goto remove_page;
+
+		if (write) {
+			if (page) {
+				page_idle_clear_pte_refs(page);
+				set_page_idle(page);
+			}
+		} else {
+			/* If page is NULL, it was swapped out */
+			if (!page || page_idle_pte_check(page)) {
+				off = ((cur->addr) >> PAGE_SHIFT) - start_frame;
+				bit = off % BITMAP_CHUNK_BITS;
+				index = off / BITMAP_CHUNK_BITS;
+				out[index] |= 1ULL << bit;
+			}
+		}
+remove_page:
+		if (page)
+			put_page(page);
+	}
+
+	if (!write && !walk_error)
+		ret = copy_to_user(ubuff, buffer, count);
+
+	up_read(&mm->mmap_sem);
+	kfree(priv.page_nodes);
+out:
+	kfree(buffer);
+out_mmput:
+	mmput(mm);
+	if (!ret)
+		ret = count;
+	return ret;
+
+}
+
+ssize_t page_idle_proc_read(struct file *file, char __user *ubuff,
+			    size_t count, loff_t *pos)
+{
+	return page_idle_proc_generic(file, ubuff, count, pos, 0);
+}
+
+ssize_t page_idle_proc_write(struct file *file, char __user *ubuff,
+			     size_t count, loff_t *pos, struct mm_struct *mm)
+{
+	return page_idle_proc_generic(file, ubuff, count, pos, 1);
+}
+
 static int __init page_idle_init(void)
 {
 	int err;
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..4bd618aab402 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1629,6 +1629,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (page_is_idle(page))
+				swp_pte = pte_swp_mkpage_idle(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 			/* Invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
-- 
2.22.0.770.g0f2c4a37fd-goog
