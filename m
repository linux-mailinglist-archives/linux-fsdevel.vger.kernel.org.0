Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B87774792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHHTQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjHHTQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:16:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FEC3DDE9;
        Tue,  8 Aug 2023 09:38:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3B5C66071FD;
        Tue,  8 Aug 2023 11:43:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691491416;
        bh=PMbkzd4WJrINJbrVVZ0Sxur/llh382+VpFa9rx8eqXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVoR3O8G9hupZxU4g2LAhlmrUmSZs+N6TPW5nwwzdT9TOpeLpsKegTCQLvxVOjzB0
         /HPe/awBdDevf0q8Pu0fTTcUEp1Q7u7lobAjVzYsWVW05p+RrssK1ERpfIGaPwdGHx
         wsJJMvOGi/pD8yLNrii49LNfPpdABDbNZdDFHHgt/HrTm7eb8X117jvBWcakhtPNzH
         f8iILqJNZYKLDLPMu+kxqXP7B5Z7EgPKVtAWHjSNpUUvSrrUP6U1zR7OHz38sx2KM7
         5BcoYia33EZH81DAuxRssyTvRjphy6kl+GAeg4nZHkItK85S3G5ey0fr4xKMJxz03Y
         zH+PvqnJdbIGQ==
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v27 2/6] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
Date:   Tue,  8 Aug 2023 15:43:05 +0500
Message-Id: <20230808104309.357852-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808104309.357852-1-usama.anjum@collabora.com>
References: <20230808104309.357852-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
the info about page table entries. The following operations are supported
in this ioctl:
- Get the information if the pages have Async Write-Protection enabled
  (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), file
  mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
  (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
- Find pages which have been written to and/or write protect
  (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
  atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
  pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
  non-Async-Write-Protected pages are found. Get is automatically performed
  if output buffer is specified.

This IOCTL can be extended to get information about more PTE bits. The
entire address range passed by user [start, end) is scanned until either
the user provided buffer is full or max_pages have been found.

Reviewed-by: Andrei Vagin <avagin@gmail.com>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v27:
- Add PAGE_IS_HUGE
- Iterate until temporary buffer is full to do less iterations
- Don't check if PAGE_IS_FILE if no mask needs it as it is very
  expensive to check per pte
- bring is_interesting_page() outside pagemap_scan_output() to remove
  the horrible return value check
- Replace memcpy() with direct copy
- rename end_addr to walk_end_addr in pagemap_scan_private
- Abort walk if fatal_signal_pending()

Changes in v26:
Changes made by Usama:
- Fix the wrong breaking of loop if page isn't interesting, skip intsead
- Untag the address and save them into struct
- Round off the end address to next page
- Correct the partial hugetlb page handling and returning the error
- Rename PAGE_IS_WPASYNC to PAGE_IS_WPALLOWED
- Return walk ending address in walk_end instead of returning in start
  as there is potential of replacing the memory tag

Changes by Michał:
1. the API:
  a. return ranges as {begin, end} instead of {begin + len};
  b. rename match "flags" to 'page categories' everywhere - this makes
	it easier to differentiate the ioctl()s categorisation of pages
	from struct page flags;
  c. change {required + excluded} to {inverted + required}. This was
	rejected before, but I'd like to illustrate the difference.
	Old interface can be translated to the new by:
		categories_inverted = excluded_mask
		categories_mask = required_mask | excluded_mask
		categories_anyof_mask = anyof_mask
	The new way allows filtering by: A & (B | !C)
		categories_inverted = C
		categories_mask = A
		categories_anyof_mask = B | C
  e. allow no-op calls
2. the implementation:
  a. gather the page-categorising and write-protecting code in one place;
  b. optimization: add whole-vma skipping for WP usecase;
  c. extracted output limiting code to pagemap_scan_output();
  d. extracted range coalescing to pagemap_scan_push_range();
  e. extracted THP entry handling to pagemap_scan_thp_entry();
  f. added a shortcut for non-WP hugetlb scan; avoids conditional
	locking;
  g. extracted scan buffer handling code out of do_pagemap_scan();
  h. rework output code to always try to write pending ranges; if EFAULT
	is generated it always overwrites the original error code;
	(the case of SIGKILL is needlessly trying to write the output
	now, but this should be rare case and ignoring it makes the code
	not needing a goto)
3.Change no-GET operation condition from `arg.return_mask == 0` to
  `arg.vec == NULL`. This will allow issuing the ioctl with
  return_mask == 0 to gather matching ranges when the exact category
  is not interesting. (Anticipated for CRIU scanning a large sparse
  anonymous mapping).

Changes in v25:
- Do proper filtering on hole as well (hole got missed earlier)

Changes in v24:
- Place WP markers in case of hole as well

Changes in v23:
- Set vec_buf_index to 0 only when vec_buf_index is set
- Return -EFAULT instead of -EINVAL if vec is NULL
- Correctly return the walk ending address to the page granularity

Changes in v22:
- Interface change to return walk ending address to user:
  - Replace [start start + len) with [start, end)
  - Return the ending address of the address walk in start

Changes in v21:
- Abort walk instead of returning error if WP is to be performed on
  partial hugetlb
- Changed the data types of some variables in pagemap_scan_private to
  long

Changes in v20:
- Correct PAGE_IS_FILE and add PAGE_IS_PFNZERO

Changes in v19:
- Interface changes such as renaming, return mask and WP can be used
  with any flags specified in masks
- Internal code changes

Changes in v18:
- Rebased on top of next-20230613
  - ptep_get() updates
  - remove pmd_trans_unstable() and add ACTION_AGAIN
- Review updates (Micheal)

Changes in v17:
- Rebased on next-20230606
- Made make_uffd_wp_*_pte() better and minor changes

Changes in v16:
- Fixed a corner case where kernel writes beyond user buffer by one
  element
- Bring back exclusive PM_SCAN_OP_WP
- Cosmetic changes

Changes in v15:
- Build fix:
  - Use generic tlb flush function in pagemap_scan_pmd_entry() instead of
    using x86 specific flush function in do_pagemap_scan()
  - Remove #ifdef from pagemap_scan_hugetlb_entry()
  - Use mm instead of undefined vma->vm_mm

Changes in v14:
- Fix build error caused by #ifdef added at last minute in some configs

Changes in v13:
- Review updates
- mmap_read_lock_killable() instead of mmap_read_lock()
- Replace uffd_wp_range() with helpers which increases performance
  drastically for OP_WP operations by reducing the number of tlb
  flushing etc
- Add MMU_NOTIFY_PROTECTION_VMA notification for the memory range

Changes in v12:
- Add hugetlb support to cover all memory types
- Merge "userfaultfd: Define dummy uffd_wp_range()" with this patch
- Review updates to the code

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
---
 fs/proc/task_mmu.c      | 677 ++++++++++++++++++++++++++++++++++++++++
 include/linux/hugetlb.h |   1 +
 include/uapi/linux/fs.h |  59 ++++
 mm/hugetlb.c            |   2 +-
 4 files changed, 738 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c1e6531cb02ae..6131dc04cceb3 100644
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
@@ -1749,11 +1751,686 @@ static int pagemap_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
+				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
+				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
+				 PAGE_IS_HUGE)
+#define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
+
+#define MASKS_OF_INTEREST(a)	(a.category_inverted | a.category_mask | \
+				 a.category_anyof_mask | a.return_mask)
+
+struct pagemap_scan_private {
+	struct pm_scan_arg arg;
+	unsigned long masks_of_interest, cur_vma_category;
+	struct page_region *vec_buf, cur_buf;
+	unsigned long vec_buf_len, vec_buf_index, found_pages, walk_end_addr;
+	struct page_region __user *vec_out;
+};
+
+static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
+					   struct vm_area_struct *vma,
+					   unsigned long addr, pte_t pte)
+{
+	unsigned long categories = 0;
+
+	if (pte_present(pte)) {
+		struct page *page;
+
+		categories |= PAGE_IS_PRESENT;
+		if (!pte_uffd_wp(pte))
+			categories |= PAGE_IS_WRITTEN;
+
+		if (p->masks_of_interest & PAGE_IS_FILE) {
+			page = vm_normal_page(vma, addr, pte);
+			if (page && !PageAnon(page))
+				categories |= PAGE_IS_FILE;
+		}
+
+		if (is_zero_pfn(pte_pfn(pte)))
+			categories |= PAGE_IS_PFNZERO;
+	} else if (is_swap_pte(pte)) {
+		swp_entry_t swp;
+
+		categories |= PAGE_IS_SWAPPED;
+		if (!pte_swp_uffd_wp_any(pte))
+			categories |= PAGE_IS_WRITTEN;
+
+		if (p->masks_of_interest & PAGE_IS_FILE) {
+			swp = pte_to_swp_entry(pte);
+			if (is_pfn_swap_entry(swp) &&
+			    !PageAnon(pfn_swap_entry_to_page(swp)))
+				categories |= PAGE_IS_FILE;
+		}
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
+	unsigned long categories = PAGE_IS_HUGE;
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
+	unsigned long categories = PAGE_IS_HUGE;
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
+	unsigned long required = p->arg.category_mask & PAGE_IS_WPALLOWED;
+
+	categories ^= p->arg.category_inverted;
+	if ((categories & required) != required)
+		return false;
+
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
+		vma_category |= PAGE_IS_WPALLOWED;
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
+
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
+		p->vec_buf[p->vec_buf_index++] = *cur_buf;
+	}
+
+	cur_buf->start = addr;
+	cur_buf->end = end;
+	cur_buf->categories = categories;
+
+	return true;
+}
+
+static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
+				       unsigned long addr, unsigned long end,
+				       unsigned long walk_end_addr)
+{
+	struct page_region *cur_buf = &p->cur_buf;
+
+	if (cur_buf->start != addr)
+		cur_buf->end = addr;
+	else
+		cur_buf->start = cur_buf->end = 0;
+
+	p->walk_end_addr = walk_end_addr;
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
+	if (!p->vec_buf)
+		return 0;
+
+	categories &= p->arg.return_mask;
+
+	n_pages = (*end - addr) / PAGE_SIZE;
+	if (check_add_overflow(p->found_pages, n_pages, &total_pages) || //TODO
+	    total_pages > p->arg.max_pages) {
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
+		p->walk_end_addr = *end;
+
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
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		goto out_unlock;
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
+	if (end != start + HPAGE_SIZE) {
+		spin_unlock(ptl);
+		split_huge_pmd(vma, pmd, start);
+		pagemap_scan_backout_range(p, start, end, 0);
+		/* Indicate to caller for processing these as normal pages */
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
+	ret = 0;
+	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+	if (!pte) {
+		arch_leave_lazy_mmu_mode();
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
+		unsigned long categories = p->cur_vma_category |
+					   pagemap_page_category(p, vma, addr, ptep_get(pte));
+		unsigned long next = addr + PAGE_SIZE;
+
+		if (!pagemap_scan_is_interesting_page(categories, p))
+			continue;
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
+		if (!pagemap_scan_is_interesting_page(categories, p))
+			return 0;
+
+		return pagemap_scan_output(categories, p, start, &end);
+	}
+
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
+
+	pte = huge_ptep_get(ptep);
+	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+
+	if (!pagemap_scan_is_interesting_page(categories, p))
+		goto out_unlock;
+
+	ret = pagemap_scan_output(categories, p, start, &end);
+	if (start == end)
+		goto out_unlock;
+
+	if (~categories & PAGE_IS_WRITTEN)
+		goto out_unlock;
+
+	if (end != start + HPAGE_SIZE) {
+		/* Partial HugeTLB page WP isn't possible. */
+		pagemap_scan_backout_range(p, start, end, start);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	make_uffd_wp_huge_pte(vma, start, ptep, pte);
+	flush_hugetlb_tlb_range(vma, start, end);
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
+	int ret, err;
+
+	if (!vma || !pagemap_scan_is_interesting_page(p->cur_vma_category, p))
+		return 0;
+
+	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
+	if (addr == end)
+		return ret;
+
+	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+		return ret;
+
+	err = uffd_wp_range(vma, addr, end - addr, true);
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
+	arg->start = untagged_addr((unsigned long)arg->start);
+	arg->end = untagged_addr((unsigned long)arg->end);
+	arg->vec = untagged_addr((unsigned long)arg->vec);
+
+	/* Validate memory pointers */
+	if (!IS_ALIGNED(arg->start, PAGE_SIZE))
+		return -EINVAL;
+	if (!access_ok((void __user *)arg->start, arg->end - arg->start))
+		return -EFAULT;
+	if (!arg->vec && arg->vec_len)
+		return -EFAULT;
+	if (arg->vec && !access_ok((void __user *)arg->vec,
+			      arg->vec_len * sizeof(struct page_region)))
+		return -EFAULT;
+
+	/* Fixup default values */
+	arg->end = ALIGN(arg->end, PAGE_SIZE);
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
+	if (copy_to_user(&uarg->walk_end, &arg->walk_end, sizeof(arg->walk_end)))
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
+	p->vec_out = (struct page_region __user *)p->arg.vec;
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
+	struct mmu_notifier_range range;
+	struct pagemap_scan_private p;
+	unsigned long walk_start;
+	size_t n_ranges_out = 0;
+	int ret;
+
+	memset(&p, 0, sizeof(p));
+	ret = pagemap_scan_get_args(&p.arg, uarg);
+	if (ret)
+		return ret;
+
+	p.masks_of_interest = MASKS_OF_INTEREST(p.arg);
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
+	walk_start = p.arg.start;
+	for (; walk_start < p.arg.end; walk_start = p.arg.walk_end) {
+		int n_out;
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			break;
+		ret = walk_page_range(mm, walk_start, p.arg.end,
+				      &pagemap_scan_ops, &p);
+		mmap_read_unlock(mm);
+
+		n_out = pagemap_scan_flush_buffer(&p);
+		if (n_out < 0)
+			ret = n_out;
+		else
+			n_ranges_out += n_out;
+
+		if (ret != -ENOSPC || p.arg.vec_len - 1 == 0 ||
+		    p.found_pages == p.arg.max_pages) {
+			p.walk_end_addr = p.arg.end;
+			break;
+		}
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
+	p.arg.walk_end = p.walk_end_addr ? p.walk_end_addr : walk_start;
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
index 0a393bc02f25b..8f8ff07453f22 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c5..1c9d38af1015e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -305,4 +305,63 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in flags of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WPALLOWED	(1 << 0)
+#define PAGE_IS_WRITTEN		(1 << 1)
+#define PAGE_IS_FILE		(1 << 2)
+#define PAGE_IS_PRESENT		(1 << 3)
+#define PAGE_IS_SWAPPED		(1 << 4)
+#define PAGE_IS_PFNZERO		(1 << 5)
+#define PAGE_IS_HUGE		(1 << 6)
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
+ * @end:		Ending address of the region
+ * @walk_end		Address where the scan stopped (written by kernel).
+ *			walk_end == end informs that the scan completed on entire range.
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
+	__u64 walk_end;
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
index a073e6ed8900b..3b07db0a4f2d9 100644
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

