Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB1351FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhDATY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhDATYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:24:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADCC0319DE
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 11:37:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i6so6673466ybk.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X+WKfjTQZel8GESVz31Ne1H6IO8a/apyVTco0b+7YWM=;
        b=cZQ9w1UOGP6AG0TsS/XX4IVypHtAQjeGSDbmHhJ50xJn0f+LT6rRb8GQrAXYaEgiGo
         0LWohhxNOm65gYWG8Bph33IvBFB0HlH7JnZsk8H+QdmIweiCMedjLXpXgBS147YWd85m
         WbvdBhAplPr5+Pl9v8nWHFGTL01x4mgqd+cIKnOzkIaNsvypbcViNCW5JGWi7yFdjZGD
         AudVG3vurT64vXvFQXozJhArQg38qmmDhe3W+rqc11Kw6epkOXNBwoBHPBOzcKiuqf0H
         BuCsAgaz7L3FDoOjzK2ugmIDrsHcQ006ISizyfNaAkoKB/1f4JTFKD3FivIaQ3hRLdk2
         bLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X+WKfjTQZel8GESVz31Ne1H6IO8a/apyVTco0b+7YWM=;
        b=UwPbvsCT1m3efW3CAMlsxcMds07+7PhhLbl7Hs7LBPynojuPbDFxCiair7+7TIvJYX
         JPrdSOcrP+g7ADqp+mkmrdYJ2OjgKj2fR7CLldR4woecUciPToPNQKq2DGqVusbdyKJm
         UoXHtfxeU9/E74uM6jyaKlEBhXSqoWqg1M2vVf7BZy88RnOpN9tJCj3P/ZAAodND/QpP
         XkGBaiPli7YP3py8d9JfITUMxFzfeyNz2ixHBfZWmLAtr/PVwTvvGSDvWQ3IyzLl8ZmO
         pMzqY4xh0xdoVMA1cSPrnBFf+UrVnLPq/QD1CjRCgfV9Oam6Sw01xvQjjXI2yPa8mYDp
         9B5A==
X-Gm-Message-State: AOAM530WBebJSM9PZ/uUZhMsyH4nFlVVJlA4w2fthVeQFab7hqe8i1Ru
        d2OwQye51xdo2yIz33NOnIjPJPWdPolcL6+QpSRQ
X-Google-Smtp-Source: ABdhPJweEeATtgnO29SenGwXZI3wsXXVnNqH0nUaIpqi1Q1Z6R4LS2lJaGapfHy0YbCDBmII0OADbXPJpr9Gdw3yB+dY
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:4c6:17b6:e763:5f4a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:d202:: with SMTP id
 j2mr13154119ybg.80.1617302233989; Thu, 01 Apr 2021 11:37:13 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:37:01 -0700
Message-Id: <20210401183701.1774159-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, the continue implementation in shmem_mcopy_atomic_pte was
incorrect for two main reasons:

- It didn't correctly skip some sections of code which make sense for
  newly allocated pages, but absolutely don't make sense for
  pre-existing page cache pages.

- Because shmem_mcopy_continue_pte is called only if VM_SHARED is
  detected in mm/userfaultd.c, we were incorrectly not supporting the
  case where a tmpfs file had been mmap()-ed with MAP_PRIVATE.

So, this patch does the following:

In mm/userfaultfd.c, break the logic to install PTEs out of
mcopy_atomic_pte, into a separate helper function.

In mfill_atomic_pte, for the MCOPY_ATOMIC_CONTINUE case, simply look
up the existing page in the page cache, and then use the PTE
installation helper to setup the mapping. This addresses the two issues
noted above.

The previous code's bugs manifested clearly in the error handling path.
So, to detect this kind of issue in the future, modify the selftest to
exercise the error handling path as well.

Note that this patch is based on linux-next/akpm; the "fixes" line
refers to a SHA1 in that branch.

Changes since v3:
- Significantly refactored the patch. Continue handling now happens in
  mm/userfaultfd.c, via a PTE installation helper. Most of the
  mm/shmem.c changes from the patch being fixed [1] are reverted.

Changes since v2:
- Drop the ClearPageDirty() entirely, instead of trying to remember the
  old value.
- Modify both pgoff / max_off checks to use pgoff. It's equivalent to
  offset, but offset wasn't initialized until the first check (which
  we're skipping).
- Keep the second pgoff / max_off check in the continue case.

Changes since v1:
- Refactor to skip ahead with goto, instead of adding several more
  "if (!is_continue)".
- Fix unconditional ClearPageDirty().
- Don't pte_mkwrite() when is_continue && !VM_SHARED.

[1] https://lore.kernel.org/patchwork/patch/1392464/

Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/shmem.c       |  56 ++++++---------
 mm/userfaultfd.c | 183 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 156 insertions(+), 83 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5cfd2fb6e52b..9d9a9f254f33 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2366,7 +2366,6 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			   unsigned long dst_addr, unsigned long src_addr,
 			   enum mcopy_atomic_mode mode, struct page **pagep)
 {
-	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct address_space *mapping = inode->i_mapping;
@@ -2377,18 +2376,17 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	struct page *page;
 	pte_t _dst_pte, *dst_pte;
 	int ret;
-	pgoff_t offset, max_off;
+	pgoff_t max_off;
+
+	/* Handled by mcontinue_atomic_pte instead. */
+	if (WARN_ON_ONCE(mode == MCOPY_ATOMIC_CONTINUE))
+		return -EINVAL;

 	ret = -ENOMEM;
 	if (!shmem_inode_acct_block(inode, 1))
 		goto out;

-	if (is_continue) {
-		ret = -EFAULT;
-		page = find_lock_page(mapping, pgoff);
-		if (!page)
-			goto out_unacct_blocks;
-	} else if (!*pagep) {
+	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
 		if (!page)
 			goto out_unacct_blocks;
@@ -2415,27 +2413,21 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		*pagep = NULL;
 	}

-	if (!is_continue) {
-		VM_BUG_ON(PageSwapBacked(page));
-		VM_BUG_ON(PageLocked(page));
-		__SetPageLocked(page);
-		__SetPageSwapBacked(page);
-		__SetPageUptodate(page);
-	}
+	VM_BUG_ON(PageSwapBacked(page));
+	VM_BUG_ON(PageLocked(page));
+	__SetPageLocked(page);
+	__SetPageSwapBacked(page);
+	__SetPageUptodate(page);

 	ret = -EFAULT;
-	offset = linear_page_index(dst_vma, dst_addr);
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release;

-	/* If page wasn't already in the page cache, add it. */
-	if (!is_continue) {
-		ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-					      gfp & GFP_RECLAIM_MASK, dst_mm);
-		if (ret)
-			goto out_release;
-	}
+	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
+				      gfp & GFP_RECLAIM_MASK, dst_mm);
+	if (ret)
+		goto out_release;

 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
@@ -2455,22 +2447,20 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,

 	ret = -EFAULT;
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	if (unlikely(pgoff >= max_off))
 		goto out_release_unlock;

 	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_release_unlock;

-	if (!is_continue) {
-		lru_cache_add(page);
+	lru_cache_add(page);

-		spin_lock_irq(&info->lock);
-		info->alloced++;
-		inode->i_blocks += BLOCKS_PER_PAGE;
-		shmem_recalc_inode(inode);
-		spin_unlock_irq(&info->lock);
-	}
+	spin_lock_irq(&info->lock);
+	info->alloced++;
+	inode->i_blocks += BLOCKS_PER_PAGE;
+	shmem_recalc_inode(inode);
+	spin_unlock_irq(&info->lock);

 	inc_mm_counter(dst_mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbb7c8d79a4d..286d0657fbe2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,21 +48,103 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	return dst_vma;
 }

+/*
+ * Install PTEs, to map dst_addr (within dst_vma) to page.
+ *
+ * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
+ * whether or not dst_vma is VM_SHARED. It also handles the more general
+ * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
+ * backed, or not).
+ *
+ * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
+ * shmem_mcopy_atomic_pte instead.
+ */
+static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr, struct page *page,
+				     enum mcopy_atomic_mode mode, bool wp_copy)
+{
+	int ret;
+	pte_t _dst_pte, *dst_pte;
+	bool is_continue = mode == MCOPY_ATOMIC_CONTINUE;
+	int writable;
+	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
+	bool is_file_backed = dst_vma->vm_file;
+	spinlock_t *ptl;
+	struct inode *inode;
+	pgoff_t offset, max_off;
+
+	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
+	writable = dst_vma->vm_flags & VM_WRITE;
+	/* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
+	if (is_continue && !vm_shared)
+		writable = 0;
+
+	if (writable) {
+		_dst_pte = pte_mkdirty(_dst_pte);
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	} else if (vm_shared) {
+		/*
+		 * Since we didn't pte_mkdirty(), mark the page dirty or it
+		 * could be freed from under us. We could do this
+		 * unconditionally, but doing it only if !writable is faster.
+		 */
+		set_page_dirty(page);
+	}
+
+	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	if (is_file_backed) {
+		/* The shmem MAP_PRIVATE case requires checking the i_size */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_unlock;
+	}
+
+	ret = -EEXIST;
+	if (!pte_none(*dst_pte))
+		goto out_unlock;
+
+	inc_mm_counter(dst_mm, mm_counter(page));
+	if (is_file_backed)
+		page_add_file_rmap(page, false);
+	else
+		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+
+	if (!is_continue)
+		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+
+	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	pte_unmap_unlock(dst_pte, ptl);
+	ret = 0;
+out:
+	return ret;
+out_unlock:
+	pte_unmap_unlock(dst_pte, ptl);
+	goto out;
+}
+
 static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    pmd_t *dst_pmd,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    struct page **pagep,
+			    enum mcopy_atomic_mode mode,
 			    bool wp_copy)
 {
-	pte_t _dst_pte, *dst_pte;
-	spinlock_t *ptl;
 	void *page_kaddr;
 	int ret;
 	struct page *page;
-	pgoff_t offset, max_off;
-	struct inode *inode;

 	if (!*pagep) {
 		ret = -ENOMEM;
@@ -99,43 +181,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
 		goto out_release;

-	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-	if (dst_vma->vm_flags & VM_WRITE) {
-		if (wp_copy)
-			_dst_pte = pte_mkuffd_wp(_dst_pte);
-		else
-			_dst_pte = pte_mkwrite(_dst_pte);
-	}
-
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-	if (dst_vma->vm_file) {
-		/* the shmem MAP_PRIVATE case requires checking the i_size */
-		inode = dst_vma->vm_file->f_inode;
-		offset = linear_page_index(dst_vma, dst_addr);
-		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-		ret = -EFAULT;
-		if (unlikely(offset >= max_off))
-			goto out_release_uncharge_unlock;
-	}
-	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
-		goto out_release_uncharge_unlock;
-
-	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
-	lru_cache_add_inactive_or_unevictable(page, dst_vma);
-
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-
-	pte_unmap_unlock(dst_pte, ptl);
-	ret = 0;
+	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
+					page, mode, wp_copy);
+	if (ret)
+		goto out_release;
 out:
 	return ret;
-out_release_uncharge_unlock:
-	pte_unmap_unlock(dst_pte, ptl);
 out_release:
 	put_page(page);
 	goto out;
@@ -176,6 +227,38 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	return ret;
 }

+static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
+				pmd_t *dst_pmd,
+				struct vm_area_struct *dst_vma,
+				unsigned long dst_addr,
+				bool wp_copy)
+{
+	struct inode *inode = file_inode(dst_vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
+	struct page *page;
+	int ret;
+
+	ret = -EFAULT;
+	page = find_lock_page(mapping, pgoff);
+	if (!page)
+		goto out;
+
+	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
+					page, MCOPY_ATOMIC_CONTINUE, wp_copy);
+	if (ret)
+		goto out_release;
+
+	unlock_page(page);
+	ret = 0;
+out:
+	return ret;
+out_release:
+	unlock_page(page);
+	put_page(page);
+	goto out;
+}
+
 static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 {
 	pgd_t *pgd;
@@ -418,7 +501,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
-	ssize_t err;
+	ssize_t err = 0;
+
+	if (mode == MCOPY_ATOMIC_CONTINUE) {
+		err = mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+					   wp_copy);
+		goto out;
+	}

 	/*
 	 * The normal page fault path for a shmem will invoke the
@@ -431,26 +520,20 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		switch (mode) {
-		case MCOPY_ATOMIC_NORMAL:
+		if (mode == MCOPY_ATOMIC_NORMAL)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page,
-					       wp_copy);
-			break;
-		case MCOPY_ATOMIC_ZEROPAGE:
+					       mode, wp_copy);
+		else if (mode == MCOPY_ATOMIC_ZEROPAGE)
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
-			break;
-		case MCOPY_ATOMIC_CONTINUE:
-			err = -EINVAL;
-			break;
-		}
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 					     src_addr, mode, page);
 	}

+out:
 	return err;
 }

--
2.31.0.208.g409f899ff0-goog

