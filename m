Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188396B261D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCIOBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjCIOAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004A1A4A7;
        Thu,  9 Mar 2023 05:58:05 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDE0B660304B;
        Thu,  9 Mar 2023 13:57:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370284;
        bh=NDAIT6+czxr5rnRPneoVHxM9Klwj48woEbH+SojSfjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfNDr/K/k6+FH0OO0Jdee4gxWN3BCMwd/tgl1Lub4I2TmhvWGVDOMMPoo7oT+OYfS
         eVgF7Zn6XhILopRbd9b/x5h8gtgWsMcRRCCIlc8w1jTY6iMtEpc4JHA87JQO06wrbo
         4fzu2A2Lbzs0P1ysLlkQdD+a5kdsgNU5CeUPznAL5obGJd1Q+PDa2fXITyEwm5zHci
         ywIkdSFPtQm3N+W99tLIJFEV7dGKikeaFjHdwcq81OwIUSSKU8hMTCR2ojkdrV9meC
         tRNIJoEWkRNTPqi1u7+JmyxVmHSaz5IoKmQgI1b2RFcGFiAJZOzFWEg8wDlXKk5u5U
         QGJKb+iiEHPCA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
Date:   Thu,  9 Mar 2023 18:57:15 +0500
Message-Id: <20230309135718.1490461-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
the info about page table entries. The following operations are supported
in this ioctl:
- Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
  file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
  (PAGE_IS_SWAPPED).
- Find pages which have been written-to and write protect the pages
  (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)

This IOCTL can be extended to get information about more PTE bits. This
IOCTL doesn't support hugetlbs at the moment. No information about
hugetlb can be obtained. This patch has evolved from a basic patch from
Gabriel Krisman Bertazi.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v11:
- Find written pages in a better way
- Fix a corner case (thanks Paul)
- Improve the code/comments
- remove ENGAGE_WP + ! GET operation
- shorten the commit message in favour of moving documentation to
  pagemap.rst

Changes in v10:
- move changes in tools/include/uapi/linux/fs.h to separate patch
- update commit message

Change in v8:
- Correct is_pte_uffd_wp()
- Improve readability and error checks
- Remove some un-needed code

Changes in v7:
- Rebase on top of latest next
- Fix some corner cases
- Base soft-dirty on the uffd wp async
- Update the terminologies
- Optimize the memory usage inside the ioctl

Changes in v6:
- Rename variables and update comments
- Make IOCTL independent of soft_dirty config
- Change masks and bitmap type to _u64
- Improve code quality

Changes in v5:
- Remove tlb flushing even for clear operation

Changes in v4:
- Update the interface and implementation

Changes in v3:
- Tighten the user-kernel interface by using explicit types and add more
  error checking

Changes in v2:
- Convert the interface from syscall to ioctl
- Remove pidfd support as it doesn't make sense in ioctl
---
 fs/proc/task_mmu.c      | 366 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  53 ++++++
 2 files changed, 419 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..f8f796cf3439 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/minmax.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -1132,6 +1133,18 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 }
 #endif
 
+static inline bool is_pte_uffd_wp(pte_t pte)
+{
+	return ((pte_present(pte) && pte_uffd_wp(pte)) ||
+		(pte_swp_uffd_wp_any(pte)));
+}
+
+static inline bool is_pmd_uffd_wp(pmd_t pmd)
+{
+	return ((pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
+		(is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd)));
+}
+
 #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
@@ -1760,11 +1773,364 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#define PM_SCAN_BITS_ALL	(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PM_SCAN_NON_WT_BITS	(PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
+				 PAGE_IS_SWAPPED)
+#define PM_SCAN_OPS		(PM_SCAN_OP_GET | PM_SCAN_OP_WP)
+#define PM_SCAN_OP_IS_WP(a)	(a->flags & PM_SCAN_OP_WP)
+#define PM_SCAN_BITMAP(wt, file, present, swap)	\
+	(wt | file << 1 | present << 2 | swap << 3)
+
+struct pagemap_scan_private {
+	struct page_region *vec;
+	struct page_region cur;
+	unsigned long vec_len, vec_index;
+	unsigned int max_pages, found_pages, flags;
+	unsigned long required_mask, anyof_mask, excluded_mask, return_mask;
+};
+
+static inline bool pagemap_scan_is_wt_required(struct pagemap_scan_private *p)
+{
+	return	((p->required_mask & PAGE_IS_WRITTEN) ||
+		 (p->anyof_mask & PAGE_IS_WRITTEN) ||
+		 (p->excluded_mask & PAGE_IS_WRITTEN));
+}
+
+static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
+				  struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (pagemap_scan_is_wt_required(p) && (!userfaultfd_wp(vma) ||
+	    !userfaultfd_wp_async(vma)))
+		return -EPERM;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	return 0;
+}
+
+static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
+			       struct pagemap_scan_private *p,
+			       unsigned long addr, unsigned int n_pages)
+{
+	unsigned long bitmap = PM_SCAN_BITMAP(wt, file, pres, swap);
+	struct page_region *cur = &p->cur;
+	bool cpy = true;
+
+	if (p->max_pages && (p->found_pages == p->max_pages))
+		return -ENOSPC;
+
+	if (!n_pages)
+		return -EINVAL;
+
+	if (p->required_mask)
+		cpy = ((p->required_mask & bitmap) == p->required_mask);
+	if (cpy && p->anyof_mask)
+		cpy = (p->anyof_mask & bitmap);
+	if (cpy && p->excluded_mask)
+		cpy = !(p->excluded_mask & bitmap);
+
+	bitmap = bitmap & p->return_mask;
+
+	if (cpy && bitmap) {
+		if ((cur->len) && (cur->bitmap == bitmap) &&
+		    (cur->start + cur->len * PAGE_SIZE == addr)) {
+
+			cur->len += n_pages;
+			p->found_pages += n_pages;
+		} else if ((!p->vec_index) ||
+			   ((p->vec_index + 1) < p->vec_len)) {
+
+			if (cur->len) {
+				memcpy(&p->vec[p->vec_index], cur,
+				       sizeof(struct page_region));
+				p->vec_index++;
+			}
+
+			cur->start = addr;
+			cur->len = n_pages;
+			cur->bitmap = bitmap;
+			p->found_pages += n_pages;
+		} else {
+			return -ENOSPC;
+		}
+	}
+
+	return 0;
+}
+
+static int pagemap_scan_deposit(struct pagemap_scan_private *p,
+				struct page_region __user *vec,
+				unsigned long *vec_index)
+{
+	struct page_region *cur = &p->cur;
+
+	if (cur->len) {
+		if (copy_to_user(&vec[*vec_index], cur,
+				 sizeof(struct page_region)))
+			return -EFAULT;
+
+		p->vec_index++;
+		(*vec_index)++;
+	}
+
+	return 0;
+}
+
+static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	bool is_writ, is_file, is_pres, is_swap;
+	unsigned long addr = end;
+	spinlock_t *ptl;
+	int ret = 0;
+	pte_t *pte;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		unsigned long n_pages;
+
+		is_writ = !is_pmd_uffd_wp(*pmd);
+		/*
+		 * Break huge page into small pages if operation needs to be
+		 * performed is on a portion of the huge page.
+		 */
+		if (is_writ && PM_SCAN_OP_IS_WP(p) &&
+		    (end - start < HPAGE_SIZE)) {
+			spin_unlock(ptl);
+
+			split_huge_pmd(vma, pmd, start);
+			goto process_smaller_pages;
+		}
+
+		n_pages = (end - start)/PAGE_SIZE;
+		if (p->max_pages &&
+		    p->found_pages + n_pages >= p->max_pages)
+			n_pages = p->max_pages - p->found_pages;
+
+		ret = pagemap_scan_output(is_writ, vma->vm_file,
+					  pmd_present(*pmd), is_swap_pmd(*pmd),
+					  p, start, n_pages);
+		spin_unlock(ptl);
+
+		if (!ret && is_writ && PM_SCAN_OP_IS_WP(p) &&
+		    uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true) < 0)
+			ret = -EINVAL;
+
+		return ret;
+	}
+process_smaller_pages:
+	if (pmd_trans_unstable(pmd))
+		return 0;
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+	for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
+		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+
+		is_writ = !is_pte_uffd_wp(*pte);
+		is_file = vma->vm_file;
+		is_pres = pte_present(*pte);
+		is_swap = is_swap_pte(*pte);
+
+		pte_unmap_unlock(pte, ptl);
+
+		ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
+					  p, addr, 1);
+		if (ret)
+			break;
+
+		if (PM_SCAN_OP_IS_WP(p) && is_writ &&
+		    uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
+			ret = -EINVAL;
+	}
+
+	cond_resched();
+	return ret;
+}
+
+static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
+				 int depth, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long n_pages;
+	int ret = 0;
+
+	if (vma) {
+		n_pages = (end - addr)/PAGE_SIZE;
+		if (p->max_pages &&
+		    p->found_pages + n_pages >= p->max_pages)
+			n_pages = p->max_pages - p->found_pages;
+
+		ret = pagemap_scan_output(false, vma->vm_file, false, false, p,
+					  addr, n_pages);
+	}
+
+	return ret;
+}
+
+/* No hugetlb support is present. */
+static const struct mm_walk_ops pagemap_scan_ops = {
+	.test_walk = pagemap_scan_test_walk,
+	.pmd_entry = pagemap_scan_pmd_entry,
+	.pte_hole = pagemap_scan_pte_hole,
+};
+
+static bool pagemap_scan_args_valid(struct pm_scan_arg *arg,
+				    struct page_region __user *vec,
+				    unsigned long start)
+{
+	/* Detect illegal size, flags and masks */
+	if (arg->size != sizeof(struct pm_scan_arg))
+		return false;
+	if (arg->flags & ~PM_SCAN_OPS)
+		return false;
+	if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
+	     arg->return_mask) & ~PM_SCAN_BITS_ALL)
+		return false;
+	if (!arg->required_mask && !arg->anyof_mask &&
+	    !arg->excluded_mask)
+		return false;
+	if (!arg->return_mask)
+		return false;
+
+	/* Validate memory ranges */
+	if (!(arg->flags & PM_SCAN_OP_GET))
+		return false;
+	if (!arg->vec)
+		return false;
+	if (arg->vec_len == 0)
+		return false;
+	if (!access_ok((void __user *)vec,
+		       arg->vec_len * sizeof(struct page_region)))
+		return false;
+
+	if (!IS_ALIGNED(start, PAGE_SIZE))
+		return false;
+	if (!access_ok((void __user *)start, arg->len))
+		return false;
+
+	if (PM_SCAN_OP_IS_WP(arg)) {
+		if (arg->required_mask & PM_SCAN_NON_WT_BITS)
+			return false;
+		if (arg->anyof_mask & PM_SCAN_NON_WT_BITS)
+			return false;
+		if (arg->excluded_mask & PM_SCAN_NON_WT_BITS)
+			return false;
+	}
+
+	return true;
+}
+
+static long do_pagemap_cmd(struct mm_struct *mm, struct pm_scan_arg *arg)
+{
+	unsigned long start, end, walk_start, walk_end;
+	unsigned long empty_slots, vec_index = 0;
+	struct page_region __user *vec;
+	struct pagemap_scan_private p;
+	int ret = 0;
+
+	start = (unsigned long)untagged_addr(arg->start);
+	vec = (struct page_region *)(unsigned long)untagged_addr(arg->vec);
+
+	if (!pagemap_scan_args_valid(arg, vec, start))
+		return -EINVAL;
+
+	end = start + arg->len;
+	p.max_pages = arg->max_pages;
+	p.found_pages = 0;
+	p.flags = arg->flags;
+	p.required_mask = arg->required_mask;
+	p.anyof_mask = arg->anyof_mask;
+	p.excluded_mask = arg->excluded_mask;
+	p.return_mask = arg->return_mask;
+	p.cur.len = 0;
+	p.vec = NULL;
+	p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
+
+	/*
+	 * Allocate smaller buffer to get output from inside the page walk
+	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
+	 * we want to return output to user in compact form where no two
+	 * consecutive regions should be continuous and have the same flags.
+	 * So store the latest element in p.cur between different walks and
+	 * store the p.cur at the end of the walk to the user buffer.
+	 */
+	p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
+			      GFP_KERNEL);
+	if (!p.vec)
+		return -ENOMEM;
+
+	walk_start = walk_end = start;
+	while (walk_end < end) {
+		p.vec_index = 0;
+
+		empty_slots = arg->vec_len - vec_index;
+		p.vec_len = min(p.vec_len, empty_slots);
+
+		walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
+		if (walk_end > end)
+			walk_end = end;
+
+		mmap_read_lock(mm);
+		ret = walk_page_range(mm, walk_start, walk_end,
+				      &pagemap_scan_ops, &p);
+		mmap_read_unlock(mm);
+
+		if (!(!ret || ret == -ENOSPC))
+			goto free_data;
+
+		walk_start = walk_end;
+		if (p.vec_index) {
+			if (copy_to_user(&vec[vec_index], p.vec,
+					 p.vec_index *
+					 sizeof(struct page_region))) {
+				ret = -EFAULT;
+				goto free_data;
+			}
+			vec_index += p.vec_index;
+		}
+	}
+	ret = pagemap_scan_deposit(&p, vec, &vec_index);
+	if (!ret)
+		ret = vec_index;
+free_data:
+	kfree(p.vec);
+
+	return ret;
+}
+
+static long pagemap_scan_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)arg;
+	struct mm_struct *mm = file->private_data;
+	struct pm_scan_arg argument;
+
+	if (cmd == PAGEMAP_SCAN) {
+		if (copy_from_user(&argument, uarg,
+				   sizeof(struct pm_scan_arg)))
+			return -EFAULT;
+		return do_pagemap_cmd(mm, &argument);
+	}
+
+	return -EINVAL;
+}
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
+	.unlocked_ioctl = pagemap_scan_ioctl,
+	.compat_ioctl	= pagemap_scan_ioctl,
 };
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..47879c38ce2f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in the bitmap of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WRITTEN		(1 << 0)
+#define PAGE_IS_FILE		(1 << 1)
+#define PAGE_IS_PRESENT		(1 << 2)
+#define PAGE_IS_SWAPPED		(1 << 3)
+
+/*
+ * struct page_region - Page region with bitmap flags
+ * @start:	Start of the region
+ * @len:	Length of the region in pages
+ * bitmap:	Bits sets for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 len;
+	__u64 bitmap;
+};
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ * @len:		Length of the region (All the pages in this length are included)
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional max return pages
+ * @required_mask:	Required mask - All of these bits have to be set in the PTE
+ * @anyof_mask:		Any mask - Any of these bits are set in the PTE
+ * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
+ * @return_mask:	Bits that are to be reported in page_region
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 len;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 required_mask;
+	__u64 anyof_mask;
+	__u64 excluded_mask;
+	__u64 return_mask;
+};
+
+/* Supported flags */
+#define PM_SCAN_OP_GET	(1 << 0)
+#define PM_SCAN_OP_WP	(1 << 1)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.39.2

