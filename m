Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48A875D828
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 02:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGVAYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 20:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGVAYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:24:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EA35AB;
        Fri, 21 Jul 2023 17:24:19 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4R76cK1zQ6z5P;
        Sat, 22 Jul 2023 02:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1689985457; bh=PX0vjpJ2qCE4FRdSiu+LwsYWbHH8sd6A92WilSNx8CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrdFeJEHVjPpXRJL8t+rJNEYv2vydOLX63bpBzJbGPhYDfIX5SY6HKq2jah2Cyf8G
         xZvYTCJ5LmVq7aWIOU3GJF0UYhzy/LaFKKbBIZWXJTVLEV1GPiwek/PRHScaXPhwfQ
         oPBZnJ654J1JNqQuhUYG30QvaJcDKQO9wkdI5fNb8jkc//40ciHxyurYVo1B22a7+4
         3YCe+PzV1rk1luX9zIUygDIUlrk5S3MTGLXaWkO9ZO1J9wf4eq7wP4eTLFg6Eqj7bn
         w8kGGe6x+SO2RAbe7/8d0LkHQsDnfj1X7Uzly1bzrNNuXRrToE0Ken+fWU5It1/6AA
         8gJnSZaEoM3ag==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 22 Jul 2023 02:24:16 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

Changes from v1 [1]:

API:
  1. Change no-GET operation condition from `arg.return_mask == 0` to
     `arg.vec == NULL`. This will allow issuing the ioctl with
     return_mask == 0 to gather matching ranges when the exact category
     is not interesting. (Anticipated for CRIU scanning a large sparse
     anonymous mapping).

Implementation:
  1. Fixed splitting THPs if processing a non-full range.
  2. Pushed ...is_interesting_page() call to ...output().

[1] https://lore.kernel.org/linux-mm/202307211507.xOl45LiR-lkp@intel.com/T/#mc8ad9ca249a8ec01980791539abcb8a221154e20

Best Regards
Micha³ Miros³aw

Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
---
 fs/proc/task_mmu.c      | 641 ++++++++++++++++++++++++++++++++++++++++
 include/linux/hugetlb.h |   1 +
 include/uapi/linux/fs.h |  56 ++++
 mm/hugetlb.c            |   2 +-
 4 files changed, 699 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c1e6531cb02a..568e76f64824 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -19,6 +19,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
+#include <linux/minmax.h>
+#include <linux/overflow.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -1749,11 +1751,650 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#define PM_SCAN_CATEGORIES	(PAGE_IS_WPASYNC | PAGE_IS_WRITTEN | \
+				 PAGE_IS_FILE |	PAGE_IS_PRESENT | \
+				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO)
+#define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
+
+struct pagemap_scan_private {
+	struct pm_scan_arg arg;
+	unsigned long cur_vma_category;
+	struct page_region *vec_buf, cur_buf;
+	unsigned long vec_buf_len, vec_buf_index, found_pages, end_addr;
+	struct page_region __user* vec_out;
+};
+
+static unsigned long pagemap_page_category(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+{
+	unsigned long categories = 0;
+
+	if (pte_present(pte)) {
+		struct page *page = vm_normal_page(vma, addr, pte);
+
+		categories |= PAGE_IS_PRESENT;
+		if (!pte_uffd_wp(pte))
+			categories |= PAGE_IS_WRITTEN;
+		if (page && !PageAnon(page))
+			categories |= PAGE_IS_FILE;
+		if (is_zero_pfn(pte_pfn(pte)))
+			categories |= PAGE_IS_PFNZERO;
+	} else if (is_swap_pte(pte)) {
+		swp_entry_t swp = pte_to_swp_entry(pte);
+
+		categories |= PAGE_IS_SWAPPED;
+		if (!pte_swp_uffd_wp_any(pte))
+			categories |= PAGE_IS_WRITTEN;
+		if (is_pfn_swap_entry(swp) && !PageAnon(pfn_swap_entry_to_page(swp)))
+			categories |= PAGE_IS_FILE;
+	}
+
+	return categories;
+}
+
+static void make_uffd_wp_pte(struct vm_area_struct *vma,
+			     unsigned long addr, pte_t *pte)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (pte_present(ptent)) {
+		pte_t old_pte;
+
+		old_pte = ptep_modify_prot_start(vma, addr, pte);
+		ptent = pte_mkuffd_wp(ptent);
+		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+	} else if (is_swap_pte(ptent)) {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
+	} else {
+		set_pte_at(vma->vm_mm, addr, pte,
+			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	}
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static unsigned long pagemap_thp_category(pmd_t pmd)
+{
+	unsigned long categories = 0;
+
+	if (pmd_present(pmd)) {
+		categories |= PAGE_IS_PRESENT;
+		if (!pmd_uffd_wp(pmd))
+			categories |= PAGE_IS_WRITTEN;
+		if (is_zero_pfn(pmd_pfn(pmd)))
+			categories |= PAGE_IS_PFNZERO;
+	} else if (is_swap_pmd(pmd)) {
+		categories |= PAGE_IS_SWAPPED;
+		if (!pmd_swp_uffd_wp(pmd))
+			categories |= PAGE_IS_WRITTEN;
+	}
+
+	return categories;
+}
+
+static void make_uffd_wp_pmd(struct vm_area_struct *vma,
+			     unsigned long addr, pmd_t *pmdp)
+{
+	pmd_t old, pmd = *pmdp;
+
+	if (pmd_present(pmd)) {
+		old = pmdp_invalidate_ad(vma, addr, pmdp);
+		pmd = pmd_mkuffd_wp(old);
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+		pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	}
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#ifdef CONFIG_HUGETLB_PAGE
+static unsigned long pagemap_hugetlb_category(pte_t pte)
+{
+	unsigned long categories = 0;
+
+	if (pte_present(pte)) {
+		categories |= PAGE_IS_PRESENT;
+		if (!huge_pte_uffd_wp(pte))
+			categories |= PAGE_IS_WRITTEN;
+		if (!PageAnon(pte_page(pte)))
+			categories |= PAGE_IS_FILE;
+		if (is_zero_pfn(pte_pfn(pte)))
+			categories |= PAGE_IS_PFNZERO;
+	} else if (is_swap_pte(pte)) {
+		categories |= PAGE_IS_SWAPPED;
+		if (!pte_swp_uffd_wp_any(pte))
+			categories |= PAGE_IS_WRITTEN;
+	}
+
+	return categories;
+}
+
+static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep,
+				  pte_t ptent)
+{
+	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
+		return;
+
+	if (is_hugetlb_entry_migration(ptent))
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				pte_swp_mkuffd_wp(ptent));
+	else if (!huge_pte_none(ptent))
+		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
+					     huge_pte_mkuffd_wp(ptent));
+	else
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				make_pte_marker(PTE_MARKER_UFFD_WP));
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
+static bool pagemap_scan_is_interesting_page(unsigned long categories,
+					     const struct pagemap_scan_private *p)
+{
+	categories ^= p->arg.category_inverted;
+	if ((categories & p->arg.category_mask) != p->arg.category_mask)
+		return false;
+	if (p->arg.category_anyof_mask && !(categories & p->arg.category_anyof_mask))
+		return false;
+
+	return true;
+}
+
+static bool pagemap_scan_is_interesting_vma(unsigned long categories,
+					    const struct pagemap_scan_private *p)
+{
+	unsigned long required = p->arg.category_mask & PAGE_IS_WPASYNC;
+
+	categories ^= p->arg.category_inverted;
+	if ((categories & required) != required)
+		return false;
+	return true;
+}
+
+static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
+				  struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long vma_category = 0;
+
+	if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
+		vma_category |= PAGE_IS_WPASYNC;
+	else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
+		return -EPERM;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	if (!pagemap_scan_is_interesting_vma(vma_category, p))
+		return 1;
+
+	p->cur_vma_category = vma_category;
+	return 0;
+}
+
+static bool pagemap_scan_push_range(unsigned long categories,
+				    struct pagemap_scan_private *p,
+				    unsigned long addr, unsigned long end)
+{
+	struct page_region *cur_buf = &p->cur_buf;
+
+	/*
+	 * When there is no output buffer provided at all, the sentinel values
+	 * won't match here. There is no other way for `cur_buf->end` to be
+	 * non-zero other than it being non-empty.
+	 */
+	if (addr == cur_buf->end && categories == cur_buf->categories) {
+		cur_buf->end = end;
+		return true;
+	}
+
+	if (cur_buf->end) {
+		if (p->vec_buf_index >= p->vec_buf_len)
+			return false;
+
+		memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
+		       sizeof(*p->vec_buf));
+		++p->vec_buf_index;
+	}
+
+	cur_buf->start = addr;
+	cur_buf->end = end;
+	cur_buf->categories = categories;
+	return true;
+}
+
+static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
+				       unsigned long addr, unsigned long end)
+{
+	struct page_region *cur_buf = &p->cur_buf;
+
+	if (cur_buf->start != addr)
+		cur_buf->end = addr;
+	else
+		cur_buf->start = cur_buf->end = 0;
+
+	p->end_addr = 0;
+	p->found_pages -= (end - addr) / PAGE_SIZE;
+}
+
+static int pagemap_scan_output(unsigned long categories,
+			       struct pagemap_scan_private *p,
+			       unsigned long addr, unsigned long *end)
+{
+	unsigned long n_pages, total_pages;
+	int ret = 0;
+
+	if (!pagemap_scan_is_interesting_page(categories, p)) {
+		*end = addr;
+		return 0;
+	}
+
+	if (!p->vec_buf)
+		return 0;
+
+	categories &= p->arg.return_mask;
+
+	n_pages = (*end - addr) / PAGE_SIZE;
+	if (check_add_overflow(p->found_pages, n_pages, &total_pages) || total_pages > p->arg.max_pages) {
+		size_t n_too_much = total_pages - p->arg.max_pages;
+		*end -= n_too_much * PAGE_SIZE;
+		n_pages -= n_too_much;
+		ret = -ENOSPC;
+	}
+
+	if (!pagemap_scan_push_range(categories, p, addr, *end)) {
+		*end = addr;
+		n_pages = 0;
+		ret = -ENOSPC;
+	}
+
+	p->found_pages += n_pages;
+	if (ret)
+		p->end_addr = *end;
+	return ret;
+}
+
+static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long categories;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (!ptl)
+		return -ENOENT;
+
+	categories = p->cur_vma_category | pagemap_thp_category(*pmd);
+
+	ret = pagemap_scan_output(categories, p, start, &end);
+	if (start == end)
+		goto out_unlock;
+
+	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+		goto out_unlock;
+	if (~categories & PAGE_IS_WRITTEN)
+		goto out_unlock;
+
+	/*
+	 * Break huge page into small pages if the WP operation
+	 * need to be performed is on a portion of the huge page.
+	 */
+	if (end != addr + HPAGE_SIZE) {
+		spin_unlock(ptl);
+		split_huge_pmd(vma, pmd, start);
+		pagemap_scan_backout_range(p, start, end);
+		return -ENOENT;
+	}
+
+	make_uffd_wp_pmd(vma, start, pmd);
+	flush_tlb_range(vma, start, end);
+out_unlock:
+	spin_unlock(ptl);
+	return ret;
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+	return -ENOENT;
+#endif
+}
+
+static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
+				  unsigned long end, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *pte, *start_pte;
+	unsigned long addr;
+	bool flush = false;
+	spinlock_t *ptl;
+	int ret;
+
+	arch_enter_lazy_mmu_mode();
+
+	ret = pagemap_scan_thp_entry(pmd, start, end, walk);
+	if (ret != -ENOENT) {
+		arch_leave_lazy_mmu_mode();
+		return ret;
+	}
+
+	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+	if (!pte) {
+		arch_leave_lazy_mmu_mode();
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
+		unsigned long categories = p->cur_vma_category |
+			pagemap_page_category(vma, addr, ptep_get(pte));
+		unsigned long next = addr + PAGE_SIZE;
+
+		ret = pagemap_scan_output(categories, p, addr, &next);
+		if (next == addr)
+			break;
+
+		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+			continue;
+		if (~categories & PAGE_IS_WRITTEN)
+			continue;
+
+		make_uffd_wp_pte(vma, addr, pte);
+		if (!flush) {
+			start = addr;
+			flush = true;
+		}
+	}
+
+	if (flush)
+		flush_tlb_range(vma, start, addr);
+
+	pte_unmap_unlock(start_pte, ptl);
+	arch_leave_lazy_mmu_mode();
+
+	cond_resched();
+	return ret;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
+				      unsigned long start, unsigned long end,
+				      struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long categories;
+	spinlock_t *ptl;
+	int ret = 0;
+	pte_t pte;
+
+	if (~p->arg.flags & PM_SCAN_WP_MATCHING) {
+		/* Go the short route when not write-protecting pages. */
+
+		pte = huge_ptep_get(ptep);
+		categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+
+		return pagemap_scan_output(categories, p, start, &end);
+	}
+
+	if (end != start + HPAGE_SIZE) {
+		/* Partial HugeTLB page WP isn't possible. */
+		p->end_addr = start;
+		return -EINVAL;
+	}
+
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
+
+	pte = huge_ptep_get(ptep);
+	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+
+	ret = pagemap_scan_output(categories, p, start, &end);
+	if (start == end)
+		goto out_unlock;
+
+	if (categories & PAGE_IS_WRITTEN) {
+		make_uffd_wp_huge_pte(vma, start, ptep, pte);
+		flush_hugetlb_tlb_range(vma, start, end);
+	}
+
+out_unlock:
+	spin_unlock(ptl);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+
+	return ret;
+}
+#else
+#define pagemap_scan_hugetlb_entry NULL
+#endif
+
+static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
+				 int depth, struct mm_walk *walk)
+{
+	struct pagemap_scan_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	int ret;
+
+	if (!vma)
+		return 0;
+
+	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
+	if (addr == end)
+		return ret;
+
+	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+		return ret;
+
+	int err = uffd_wp_range(vma, addr, end - addr, true);
+	if (err < 0)
+		ret = err;
+
+	return ret;
+}
+
+static const struct mm_walk_ops pagemap_scan_ops = {
+	.test_walk = pagemap_scan_test_walk,
+	.pmd_entry = pagemap_scan_pmd_entry,
+	.pte_hole = pagemap_scan_pte_hole,
+	.hugetlb_entry = pagemap_scan_hugetlb_entry,
+};
+
+static int pagemap_scan_get_args(struct pm_scan_arg *arg,
+				 unsigned long uarg)
+{
+	unsigned long start, end, vec;
+
+	if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
+		return -EFAULT;
+
+	if (arg->size != sizeof(struct pm_scan_arg))
+		return -EINVAL;
+
+	/* Validate requested features */
+	if (arg->flags & ~PM_SCAN_FLAGS)
+		return -EINVAL;
+	if ((arg->category_inverted | arg->category_mask |
+	     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
+		return -EINVAL;
+
+	start = untagged_addr((unsigned long)arg->start);
+	end = untagged_addr((unsigned long)arg->end);
+	vec = untagged_addr((unsigned long)arg->vec);
+
+	/* Validate memory pointers */
+	if (!IS_ALIGNED(start, PAGE_SIZE))
+		return -EINVAL;
+	if (!access_ok((void __user *)start, end - start))
+		return -EFAULT;
+	if (!vec && arg->vec_len)
+		return -EFAULT;
+	if (vec && !access_ok((void __user *)vec,
+			      arg->vec_len * sizeof(struct page_region)))
+		return -EFAULT;
+
+	/* Fixup default values */
+	if (!arg->max_pages)
+		arg->max_pages = ULONG_MAX;
+
+	return 0;
+}
+
+static int pagemap_scan_writeback_args(struct pm_scan_arg *arg,
+				       unsigned long uargl)
+{
+	struct pm_scan_arg __user *uarg	= (void __user *)uargl;
+
+	if (copy_to_user(&uarg->start, &arg->start, sizeof(arg->start)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
+{
+	if (!p->arg.vec_len) {
+		/*
+		 * An arbitrary non-page-aligned sentinel value for
+		 * pagemap_scan_push_range().
+		 */
+		p->cur_buf.start = p->cur_buf.end = ULLONG_MAX;
+		if (p->arg.vec)
+			p->vec_buf = ZERO_SIZE_PTR;
+		return 0;
+	}
+
+	/*
+	 * Allocate a smaller buffer to get output from inside the page
+	 * walk functions and walk the range in PAGEMAP_WALK_SIZE chunks.
+	 * The last range is always stored in p.cur_buf to allow coalescing
+	 * consecutive ranges that have the same categories returned across
+	 * walk_page_range() calls.
+	 */
+	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
+			       p->arg.vec_len - 1);
+	p->vec_buf = kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
+				   GFP_KERNEL);
+	if (!p->vec_buf)
+		return -ENOMEM;
+
+	p->vec_out = (void __user *)p->arg.vec;
+
+	return 0;
+}
+
+static int pagemap_scan_flush_buffer(struct pagemap_scan_private *p)
+{
+	const struct page_region *buf = p->vec_buf;
+	int n = (int)p->vec_buf_index;
+
+	if (!n)
+		return 0;
+
+	if (copy_to_user(p->vec_out, buf, n * sizeof(*buf)))
+		return -EFAULT;
+
+	p->arg.vec_len -= n;
+	p->vec_out += n;
+
+	p->vec_buf_index = 0;
+	p->vec_buf_len = min_t(size_t, p->vec_buf_len, p->arg.vec_len - 1);
+
+	return n;
+}
+
+static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
+{
+	unsigned long walk_start, walk_end;
+	struct mmu_notifier_range range;
+	struct pagemap_scan_private p;
+	size_t n_ranges_out = 0;
+	int ret;
+
+	memset(&p, 0, sizeof(p));
+	ret = pagemap_scan_get_args(&p.arg, uarg);
+	if (ret)
+		return ret;
+
+	ret = pagemap_scan_init_bounce_buffer(&p);
+	if (ret)
+		return ret;
+
+	/* Protection change for the range is going to happen. */
+	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
+		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
+					mm, p.arg.start, p.arg.end);
+		mmu_notifier_invalidate_range_start(&range);
+	}
+
+	walk_start = walk_end = p.arg.start;
+	for (; walk_end != p.arg.end; walk_start = walk_end) {
+		int n_out;
+		walk_end = min_t(unsigned long,
+				 (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK,
+				 p.arg.end);
+
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			break;
+		ret = walk_page_range(mm, walk_start, walk_end,
+				      &pagemap_scan_ops, &p);
+		mmap_read_unlock(mm);
+
+		n_out = pagemap_scan_flush_buffer(&p);
+		if (n_out < 0)
+			ret = n_out;
+		else
+			n_ranges_out += n_out;
+
+		if (ret)
+			break;
+	}
+
+	if (p.cur_buf.start != p.cur_buf.end) {
+		if (copy_to_user(p.vec_out, &p.cur_buf, sizeof(p.cur_buf)))
+			ret = -EFAULT;
+		else
+			++n_ranges_out;
+	}
+
+	/* ENOSPC signifies early stop (buffer full) from the walk. */
+	if (!ret || ret == -ENOSPC)
+		ret = n_ranges_out;
+
+	p.arg.start = p.end_addr ? p.end_addr : walk_start;
+	if (pagemap_scan_writeback_args(&p.arg, uarg))
+		ret = -EFAULT;
+
+	if (p.arg.flags & PM_SCAN_WP_MATCHING)
+		mmu_notifier_invalidate_range_end(&range);
+
+	kfree(p.vec_buf);
+	return ret;
+}
+
+static long do_pagemap_cmd(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct mm_struct *mm = file->private_data;
+
+	switch (cmd) {
+	case PAGEMAP_SCAN:
+		return do_pagemap_scan(mm, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
 	.read		= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
+	.unlocked_ioctl = do_pagemap_cmd,
+	.compat_ioctl	= do_pagemap_cmd,
 };
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9f4bac3df59e..4f5fed605538 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..db39442befcb 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,60 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in flags of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WPASYNC		(1 << 0)
+#define PAGE_IS_WRITTEN		(1 << 1)
+#define PAGE_IS_FILE		(1 << 2)
+#define PAGE_IS_PRESENT		(1 << 3)
+#define PAGE_IS_SWAPPED		(1 << 4)
+#define PAGE_IS_PFNZERO		(1 << 5)
+
+/*
+ * struct page_region - Page region with flags
+ * @start:	Start of the region
+ * @end:	End of the region (exclusive)
+ * @categories:	PAGE_IS_* category bitmask for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 end;
+	__u64 categories;
+};
+
+/* Flags for PAGEMAP_SCAN ioctl */
+#define PM_SCAN_WP_MATCHING	(1 << 0)	/* Write protect the pages matched. */
+#define PM_SCAN_CHECK_WPASYNC	(1 << 1)	/* Abort the scan when a non-WP-enabled page is found. */
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ *			(Ending address of the walk is also returned in it)
+ * @end:		Ending address of the region
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional limit for number of returned pages (0 = disabled)
+ * @category_inverted:	PAGE_IS_* categories which values match if 0 instead of 1
+ * @category_mask:	Skip pages for which any category doesn't match
+ * @category_anyof_mask: Skip pages for which no category matches
+ * @return_mask:	PAGE_IS_* categories that are to be reported in `page_region`s returned
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 end;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 category_inverted;
+	__u64 category_mask;
+	__u64 category_anyof_mask;
+	__u64 return_mask;
+};
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 751968eff92d..4bf8cc4aba2e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5008,7 +5008,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 		return false;
 }
 
-static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
+bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-- 
2.39.2
