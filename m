Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA0366201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhDTWJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhDTWJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:09:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08696C061344
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s34-20020a252d620000b02904e34d3a48abso13364804ybe.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vAl+5kPY6gQdy5J8CiiEmjqDhCXyHe3j8a5QynQlo+0=;
        b=cFRBCIerJ2KGHw+EXxrttvNQXCxEu42FdSHezdkvgUcN9+46CKRU32wVwHGgvfoITW
         eyfdf/4pDqZQq16I1On2hTodS+yLs8KRdNGlfoQ+WURHdQVWeqpIZsjYLLHIoKeTybr7
         czag3QNkHywVcXocuRyimSJD9VtRH2RtsaVBrUSy9whrglHM+1qsrGtjhM8EDpwc6xcD
         dMhbTj79g8AyFukZ4kK4X1dxGQECMPUT8fMmrm+cG65OepcBgYvPK+FZaASc3SPzg3+9
         9vDcr8SP2Zx1U+xequJF/dQ1XNhNJRfMycOeImdCwxni6DyZ23isuiRXd3nuHmdVl4bx
         essA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vAl+5kPY6gQdy5J8CiiEmjqDhCXyHe3j8a5QynQlo+0=;
        b=g2ew7uCqv282I5ioaBl4vVrVJpNHNKzGUWIb0BLYLkgwMIyEjxIAbjf2RjMr6V504G
         Dh7WStUDGaUvj6QMmx3zAI+cCrmv1qvfBzg/tlUF6kmBA2wujQCuBtbsFS2/1QDt3OxV
         RCBvjKdQxInJiIkpBb+C/vlKygVZYVKzGEqnHuxxRmdfvdhzhad0xuvMWEmXS344/GL+
         qtkRo8DLR8Xi/HIl+WyI3EXqAJa4Je8vMIeJr7SF1YhMjbvQo1w1WJjneS3Ey652ygIR
         CgPltiwLs5VIuAXhvX1mGh4yFOQR3G9nMBEZoFQeKWC+FkxoLA8n6DOED2Wq01FfaDuB
         GMjw==
X-Gm-Message-State: AOAM530Xlbfe8e8Y9BTGItyJw1g4Sd8KwtK33hDKDsCTntLt4fdmktm7
        nMmTdc7v9m3mnKuVECGYNrC9yNnJEbj0RWiMOf0l
X-Google-Smtp-Source: ABdhPJwelR+IY4W49IEvd/z2ZtKkzYKfsEUnbcZ0FS9g6/7FwQ3WaiJYlyanZA/JGCaBD/pfvJWgvN1YLUtkk0+aEfYd
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:dca:: with SMTP id
 193mr28730769ybn.434.1618956505213; Tue, 20 Apr 2021 15:08:25 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:08:03 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-10-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 09/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte to
 use install_pte()
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

In a previous commit, we added the mcopy_atomic_install_pte() helper.
This helper does the job of setting up PTEs for an existing page, to map
it into a given VMA. It deals with both the anon and shmem cases, as
well as the shared and private cases.

In other words, shmem_mcopy_atomic_pte() duplicates a case it already
handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
directly, to reduce code duplication.

This requires that we refactor shmem_mcopy_atomic_pte() a bit:

Instead of doing accounting (shmem_recalc_inode() et al) part-way
through the PTE setup, do it beforehand. This frees up
mcopy_atomic_install_pte() from having to care about this accounting,
but it does mean we need to clean it up if we get a failure afterwards
(shmem_uncharge()).

We can *almost* use shmem_charge() to do this, reducing code
duplication. But, it does `inode->i_mapping->nrpages++`, which would
double-count since shmem_add_to_page_cache() also does this.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h |  5 ++++
 mm/shmem.c                    | 53 ++++++++---------------------------
 mm/userfaultfd.c              | 17 ++++-------
 3 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 794d1538b8ba..39c094cc6641 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
 	MCOPY_ATOMIC_CONTINUE,
 };
 
+extern int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+				    struct vm_area_struct *dst_vma,
+				    unsigned long dst_addr, struct page *page,
+				    bool newly_allocated, bool wp_copy);
+
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
 			    bool *mmap_changing, __u64 mode);
diff --git a/mm/shmem.c b/mm/shmem.c
index 30c0bb501dc9..9bfa80fcd414 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2378,10 +2378,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
-	spinlock_t *ptl;
 	void *page_kaddr;
 	struct page *page;
-	pte_t _dst_pte, *dst_pte;
 	int ret;
 	pgoff_t max_off;
 
@@ -2391,8 +2389,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
-		if (!page)
-			goto out_unacct_blocks;
+		if (!page) {
+			shmem_inode_unacct_blocks(inode, 1);
+			goto out;
+		}
 
 		if (!zeropage) {	/* COPY */
 			page_kaddr = kmap_atomic(page);
@@ -2432,59 +2432,28 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (ret)
 		goto out_release;
 
-	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
-	if (dst_vma->vm_flags & VM_WRITE)
-		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
-	else {
-		/*
-		 * We don't set the pte dirty if the vma has no
-		 * VM_WRITE permission, so mark the page dirty or it
-		 * could be freed from under us. We could do it
-		 * unconditionally before unlock_page(), but doing it
-		 * only if VM_WRITE is not set is faster.
-		 */
-		set_page_dirty(page);
-	}
-
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-
-	ret = -EFAULT;
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(pgoff >= max_off))
-		goto out_release_unlock;
-
-	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
-		goto out_release_unlock;
-
-	lru_cache_add(page);
-
 	spin_lock_irq(&info->lock);
 	info->alloced++;
 	inode->i_blocks += BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	inc_mm_counter(dst_mm, mm_counter_file(page));
-	page_add_file_rmap(page, false);
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+				       page, true, false);
+	if (ret)
+		goto out_release_uncharge;
 
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-	pte_unmap_unlock(dst_pte, ptl);
+	SetPageDirty(page);
 	unlock_page(page);
 	ret = 0;
 out:
 	return ret;
-out_release_unlock:
-	pte_unmap_unlock(dst_pte, ptl);
-	ClearPageDirty(page);
+out_release_uncharge:
 	delete_from_page_cache(page);
+	shmem_uncharge(inode, 1);
 out_release:
 	unlock_page(page);
 	put_page(page);
-out_unacct_blocks:
-	shmem_inode_unacct_blocks(inode, 1);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 51d8c0127161..3a9ddbb2dbbd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -51,18 +51,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 /*
  * Install PTEs, to map dst_addr (within dst_vma) to page.
  *
- * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
- * whether or not dst_vma is VM_SHARED. It also handles the more general
- * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
- * backed, or not).
- *
- * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
- * shmem_mcopy_atomic_pte instead.
+ * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
+ * and anon, and for both shared and private VMAs.
  */
-static int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
-				    struct vm_area_struct *dst_vma,
-				    unsigned long dst_addr, struct page *page,
-				    bool newly_allocated, bool wp_copy)
+int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+			     struct vm_area_struct *dst_vma,
+			     unsigned long dst_addr, struct page *page,
+			     bool newly_allocated, bool wp_copy)
 {
 	int ret;
 	pte_t _dst_pte, *dst_pte;
-- 
2.31.1.368.gbe11c130af-goog

