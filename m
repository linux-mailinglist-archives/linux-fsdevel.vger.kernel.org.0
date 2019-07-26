Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8F76C5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfGZPIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 11:08:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41764 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfGZPIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:08:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so14578543pgg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiIh3ewyUN7r58YhEz3CTvh2WcWJZA4335Nt1iFVDU8=;
        b=Vfel5Oq3rZKt3sFji52iOETMAh79j74S3OqcJ2If83AVw3LRfkjRQMAy+ZlecPkEup
         gZmDFULuUJbXMQVxBhxJB3/LpJ9I6n8Iu2B/H2rlAylG+m80k5+cbuFdCkgNcjxRiGbs
         KzsYbvBQS+Lh/iMtQaGRZfQ0CLVzoy6RJQCh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiIh3ewyUN7r58YhEz3CTvh2WcWJZA4335Nt1iFVDU8=;
        b=A4hCsEOKF/aCZbWO3svgKxPI0Hff8v6iodG7dX7e13mqlTbB/Ab7japPwynNi5glkV
         cp2H3I4wz0TapxRKlIU4VNyvG2wu2OQzAQV1z9efRjV66/JLb3CBL5JH/8+hWnaNCu7G
         u/Vyqrkxnj1AaAbdfqtvV2YSBiBeKQOCcO5njieP5TnjGbPwdwgKIoPPcBJYw7yPtwh3
         mNYJoonZtel3mfWo2148H4h7Y6gNL3RD7PqI1vZpnKDuAVKGGzty9Or9TlVy/Kfe+fxi
         t0OlQx8Inj1KjN20UJ395kdFEwwkcYhHwt5GlaKkUNqTs1HdVPHHdx0wjH14yXdoEWUn
         gLwQ==
X-Gm-Message-State: APjAAAUAt+7yVm/f+/aJVHz2Ac4TEZwiXBdnqUa5MZSf1nOqchoGqBMb
        zBz7KqTRD5a/dJrR+092PXQ=
X-Google-Smtp-Source: APXvYqzJUKkEXG3yx+rE4TNzeTKnko/lEMbNDX9gkLfn4oR9oZkmKS0MeAsXLN2HS0F7aH4wIa2tTQ==
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr99333833pjt.131.1564153733367;
        Fri, 26 Jul 2019 08:08:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k36sm54802352pgl.42.2019.07.26.08.08.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:08:52 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, joaodias@google.com, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        tkjos@google.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: [PATCH v2 1/2] mm/page_idle: Add per-pid idle page tracking using virtual indexing
Date:   Fri, 26 Jul 2019 11:08:43 -0400
Message-Id: <20190726150845.95720-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
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
v1 -> v2:
Mark swap ptes as idle (Minchan)
Avoid need for GFP_ATOMIC (Andrew)
Get rid of idle_page_list lock by moving list to stack

Internal review -> v1:
Fixes from Suren.
Corrections to change log, docs (Florian, Sandeep)

 fs/proc/base.c            |   3 +
 fs/proc/internal.h        |   1 +
 fs/proc/task_mmu.c        |  57 +++++++
 include/linux/page_idle.h |   4 +
 mm/page_idle.c            | 342 +++++++++++++++++++++++++++++++++-----
 5 files changed, 362 insertions(+), 45 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 77eb628ecc7f..a58dd74606e9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3021,6 +3021,9 @@ static const struct pid_entry tgid_base_stuff[] = {
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
index 4d2b860dbc3f..11ccc53da38e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1642,6 +1642,63 @@ const struct file_operations proc_pagemap_operations = {
 	.open		= pagemap_open,
 	.release	= pagemap_release,
 };
+
+#ifdef CONFIG_IDLE_PAGE_TRACKING
+static ssize_t proc_page_idle_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	int ret;
+	struct task_struct *tsk = get_proc_task(file_inode(file));
+
+	if (!tsk)
+		return -EINVAL;
+	ret = page_idle_proc_read(file, buf, count, ppos, tsk);
+	put_task_struct(tsk);
+	return ret;
+}
+
+static ssize_t proc_page_idle_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	int ret;
+	struct task_struct *tsk = get_proc_task(file_inode(file));
+
+	if (!tsk)
+		return -EINVAL;
+	ret = page_idle_proc_write(file, (char __user *)buf, count, ppos, tsk);
+	put_task_struct(tsk);
+	return ret;
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
index 295512465065..d8a14955c39d 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -5,12 +5,15 @@
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
@@ -25,18 +28,13 @@
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
@@ -51,6 +49,18 @@ static struct page *page_idle_get_page(unsigned long pfn)
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
@@ -118,6 +128,47 @@ static void page_idle_clear_pte_refs(struct page *page)
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
+static bool page_really_idle(struct page *page)
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
@@ -125,35 +176,21 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
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
+		if (page && page_really_idle(page)) {
+			*out |= 1ULL << bit;
 			put_page(page);
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
@@ -170,23 +207,16 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	const u64 *in = (u64 *)buf;
 	struct page *page;
 	unsigned long pfn, end_pfn;
-	int bit;
+	int bit, ret;
 
-	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
-		return -EINVAL;
-
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
@@ -224,6 +254,228 @@ struct page_ext_operations page_idle_ops = {
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
+	/* Pre-allocate and provide nodes to add_page_idle_list() */
+	struct page_node *page_nodes;
+	int cur_page_node;
+	struct list_head *idle_page_list;
+};
+
+/*
+ * Add a page to the idle page list. page can be NULL if pte is
+ * from a swapped page.
+ */
+static void add_page_idle_list(struct page *page,
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
+	}
+
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
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *pte;
+	spinlock_t *ptl;
+	struct page *page;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (pmd_present(*pmd)) {
+			page = follow_trans_huge_pmd(vma, addr, pmd,
+						     FOLL_DUMP|FOLL_WRITE);
+			if (!IS_ERR_OR_NULL(page))
+				add_page_idle_list(page, addr, walk);
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
+		/*
+		 * We add swapped pages to the idle_page_list so that we can
+		 * reported to userspace that they are idle.
+		 */
+		if (is_swap_pte(*pte)) {
+			add_page_idle_list(NULL, addr, walk);
+			continue;
+		}
+
+		if (!pte_present(*pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, *pte);
+		if (page)
+			add_page_idle_list(page, addr, walk);
+	}
+
+	pte_unmap_unlock(pte - 1, ptl);
+	return 0;
+}
+
+ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
+			       size_t count, loff_t *pos,
+			       struct task_struct *tsk, int write)
+{
+	int ret;
+	char *buffer;
+	u64 *out;
+	unsigned long start_addr, end_addr, start_frame, end_frame;
+	struct mm_struct *mm = file->private_data;
+	struct mm_walk walk = { .pmd_entry = pte_page_idle_proc_range, };
+	struct page_node *cur, *next;
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
+	list_for_each_entry_safe(cur, next, &idle_page_list, list) {
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
+			if (!page || page_really_idle(page)) {
+				off = ((cur->addr) >> PAGE_SHIFT) - start_frame;
+				bit = off % BITMAP_CHUNK_BITS;
+				index = off / BITMAP_CHUNK_BITS;
+				out[index] |= 1ULL << bit;
+			}
+		}
+remove_page:
+		if (page)
+			put_page(page);
+		list_del(&cur->list);
+		kfree(cur);
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
+			    size_t count, loff_t *pos, struct task_struct *tsk)
+{
+	return page_idle_proc_generic(file, ubuff, count, pos, tsk, 0);
+}
+
+ssize_t page_idle_proc_write(struct file *file, char __user *ubuff,
+			     size_t count, loff_t *pos, struct task_struct *tsk)
+{
+	return page_idle_proc_generic(file, ubuff, count, pos, tsk, 1);
+}
+
 static int __init page_idle_init(void)
 {
 	int err;
-- 
2.22.0.709.g102302147b-goog
