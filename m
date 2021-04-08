Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCD359075
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhDHXn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhDHXnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:51 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FBC061763
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:39 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id n15so2100071qvo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b1l2Yiaa4e1GScvqO3tIqjfF3IL448iCcHjGxtB3S5U=;
        b=TnAwE/T+b2WxJDB34xqNZqms0Uq5Jfv4/M2aUflRzWby1PbjsEIWIE4JjVy60EWtfB
         Nh2zGATLALwuepjx5KMSUQvvtDWeOkW+nophCrFShYHjTashfLngUwzObzi9ow+vpY4B
         ofxVY75OaJBumpmoo0b4G370K8+Nqclr3GeQFsz04Ds58tOe6bDTH26UZhxlwcwsmZcq
         hEE8JfMw2SFnhrU0R6gaSJR1I2QmY1loupyMEw1UgbkkaaY0XypYsGYRnK/TnvIw/poy
         YMF/fISzHNa3O1sE+OhwMneUxM/EIYBrXEgTARqPjmqIUVQ+R+UlwREhSmq41fbfteHe
         jZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b1l2Yiaa4e1GScvqO3tIqjfF3IL448iCcHjGxtB3S5U=;
        b=aTe2/55ADtwejTyqHlTeSMlvg7RGmZRM6FUej6aZEFiIEMkAF5gvDS0KIzfjNbcez6
         bUD+2cs72GPI4lWLJQBlOCUQXtGbJ26iO9Bv2mIpqX73wMcfibFvYoFvWwpoVBjiWLt1
         9hF1JN7sFPezfvXgeDi3Ai2/YFRdAP345/C9C12NHZoeQlvmWTceZAGtlSzy1tDRXqtG
         rpX/CmIBJef14Hquo2Tqj2BPJmvyzH/Yn7Rox266RT4ZWHHZ8Z4finYI7SrmVSVnGRT0
         A3e7hQ3GQ+9H623RNolHaZLv4FdeY1Lt3f1abvloTWL4CcKh4GE0PMz0a3PXhosMgNTG
         guYA==
X-Gm-Message-State: AOAM533ReBaMaf+g3p9tir6J7ZCvjoan9WMBSg3GvMod1OfThJwy/Ubo
        9KJTb/RGD5iuVF1jLIoFgKgxy4yHAqzPo0dUvTXX
X-Google-Smtp-Source: ABdhPJz0UAF8Im/K3ITirnNbKBmhZ4xFaQkyg32dZUvA2tJpSDdDYSz60qhtlPK3HEKOk5Ga4+gbetkNxuSOVSbijbZn
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:5572:: with SMTP id
 w18mr11739166qvy.0.1617925418617; Thu, 08 Apr 2021 16:43:38 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:22 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 4/9] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this change, userspace can resolve a minor fault within a
shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
match those for hugetlbfs - we look up the existing page in the page
cache, and install PTEs for it.

This commit introduces a new helper: mcopy_atomic_install_ptes.

Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
shmem.c? The existing userfault implementation only relies on shmem.c
for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
shmem in one place, regardless of shared/private (to reduce code
duplication).

Why add a new mcopy_atomic_install_ptes helper? A problem we have with
continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
*close* to what we want, but not exactly. We do want to setup the PTEs
in a CONTINUE operation, but we don't want to e.g. allocate a new page,
charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
we have the problem stated above: shmem_mcopy_atomic_pte() and
mcopy_atomic_pte() both handle one-half of the problem (shared /
private) continue cares about. So, introduce mcontinue_atomic_pte(), to
handle all of the shmem continue cases. Introduce the helper so it
doesn't duplicate code with mcopy_atomic_pte().

In a future commit, shmem_mcopy_atomic_pte() will also be modified to
use this new helper. However, since this is a bigger refactor, it seems
most clear to do it as a separate change.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/userfaultfd.c | 176 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 131 insertions(+), 45 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 60ae22207761..a539fe18b9a7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,6 +48,87 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
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
+				     bool newly_allocated, bool wp_copy)
+{
+	int ret;
+	pte_t _dst_pte, *dst_pte;
+	int writable;
+	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
+	spinlock_t *ptl;
+	struct inode *inode;
+	pgoff_t offset, max_off;
+
+	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
+	writable = dst_vma->vm_flags & VM_WRITE;
+	/* For private, non-anon we need CoW (don't write to page cache!) */
+	if (!vma_is_anonymous(dst_vma) && !vm_shared)
+		writable = 0;
+
+	if (writable || vma_is_anonymous(dst_vma))
+		_dst_pte = pte_mkdirty(_dst_pte);
+	if (writable) {
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
+	if (vma_is_shmem(dst_vma)) {
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
+	if (vma_is_shmem(dst_vma))
+		page_add_file_rmap(page, false);
+	else
+		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+
+	if (newly_allocated)
+		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+
+	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	ret = 0;
+out_unlock:
+	pte_unmap_unlock(dst_pte, ptl);
+	return ret;
+}
+
 static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    pmd_t *dst_pmd,
 			    struct vm_area_struct *dst_vma,
@@ -56,13 +137,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct page **pagep,
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
@@ -99,43 +176,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
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
+					page, true, wp_copy);
+	if (ret)
+		goto out_release;
 out:
 	return ret;
-out_release_uncharge_unlock:
-	pte_unmap_unlock(dst_pte, ptl);
 out_release:
 	put_page(page);
 	goto out;
@@ -176,6 +222,41 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	return ret;
 }
 
+/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
+static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
+				pmd_t *dst_pmd,
+				struct vm_area_struct *dst_vma,
+				unsigned long dst_addr,
+				bool wp_copy)
+{
+	struct inode *inode = file_inode(dst_vma->vm_file);
+	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
+	if (ret)
+		goto out;
+	if (!page) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
+					page, false, wp_copy);
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
@@ -415,11 +496,16 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						struct page **page,
-						bool zeropage,
+						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
 	ssize_t err;
 
+	if (mode == MCOPY_ATOMIC_CONTINUE) {
+		return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+					    wp_copy);
+	}
+
 	/*
 	 * The normal page fault path for a shmem will invoke the
 	 * fault, fill the hole in the file and COW it right away. The
@@ -431,7 +517,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (!zeropage)
+		if (mode == MCOPY_ATOMIC_NORMAL)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page,
 					       wp_copy);
@@ -441,7 +527,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					     dst_addr, src_addr, zeropage,
+					     dst_addr, src_addr,
+					     mode != MCOPY_ATOMIC_NORMAL,
 					     page);
 	}
 
@@ -463,7 +550,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	long copied;
 	struct page *page;
 	bool wp_copy;
-	bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
 
 	/*
 	 * Sanitize the command parameters:
@@ -526,7 +612,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
 		goto out_unlock;
 
 	/*
@@ -574,7 +660,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, zeropage, wp_copy);
+				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.31.1.295.g9ea45b61b8-goog

