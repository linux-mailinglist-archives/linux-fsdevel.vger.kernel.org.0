Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2A359089
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhDHXoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhDHXoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:44:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE9C0613DA
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 10so3524451ybu.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SA+DqFU+tgMShZZq9qaZAZYTg8gGJxsmK6MPTeE2ry8=;
        b=uKP3BtZibz2XAPKw4vvNyzwrxvh/ZYYDs9RxYJl2+CpRzB2Z5KFuRqca9wKV9UKTYa
         UqAJwFGddPUBBBbAxB08uVP/Z+1Kx9WTvOs6zi4Q0Y48GFxPz46Pywb/cXM1zwRYuziU
         5AfjajljiCrur5A/ggK6zMwzsmHt4CpBD4/kxC0eTFVkxrMUzI3XP/NzU011N5oh5l8E
         mEZoflUq/RpYdw6cGlqAAj+0oS4q8rhNcPPEG59ModK2vJ5jEC3dzmv2DaYivMTEtYP2
         O0Qz0Jz8dkwc7Jo2IIXs0AyRKjNLh/dHuakZHeaFgxVcK8Oa6UNTqyOYWP2RqfXmVT6Q
         oAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SA+DqFU+tgMShZZq9qaZAZYTg8gGJxsmK6MPTeE2ry8=;
        b=GIkLSRCguazgPX2nwpdjIrxaGXEtaMau5A1jO8M0/qbHpaycsptkoRapaN03LNbNat
         pt0Hbh+ZLP4VPDYj3wx9cqLFM1XIDtsvNnCRCRQXc3eyuLwnxPvHl/KDaqwjsT7lnVkt
         xD33YDqcEiknWfppXcHvk9pClAMyiGpGdB0wPc103aaCr6ylpTTg3SaKICmUuxd4ZO1d
         O25KAmwBHWmCgzZAy5jxPpGSmXrYO6YrfB3VJQ3tFUgry1eRd9957PcL9KeGhQk6GG7F
         bEvE4POtbr/aGX+pZUSpPkY7WInwu4Xe/Nhcqc1jQzCG1yo6C0F+VKZqfC3UCj2iBSnA
         k2Ww==
X-Gm-Message-State: AOAM532kZNITMvTPCm/GOUPolYJwZs0FcXhpIVQftfq7EWsRNPYjOaNB
        xnvou3Nr4Ywqy+dYkuekQ4WRuumjUdf7VyOjVOut
X-Google-Smtp-Source: ABdhPJxuajF5zhvsVdOW0fkBia17zTyP9ZyuXT52doUy8oHVIE8g4t2RV/j5GXkZwQczAVAFQfTPCu3qCD1utqi0DImA
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:a265:: with SMTP id
 b92mr14490367ybi.486.1617925427524; Thu, 08 Apr 2021 16:43:47 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:27 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-10-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 9/9] userfaultfd/shmem: modify shmem_mcopy_atomic_pte to use install_ptes
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

In a previous commit, we added the mcopy_atomic_install_ptes() helper.
This helper does the job of setting up PTEs for an existing page, to map
it into a given VMA. It deals with both the anon and shmem cases, as
well as the shared and private cases.

In other words, shmem_mcopy_atomic_pte() duplicates a case it already
handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
directly, to reduce code duplication.

This requires that we refactor shmem_mcopy_atomic-pte() a bit:

Instead of doing accounting (shmem_recalc_inode() et al) part-way
through the PTE setup, do it beforehand. This frees up
mcopy_atomic_install_ptes() from having to care about this accounting,
but it does mean we need to clean it up if we get a failure afterwards
(shmem_uncharge()).

We can *almost* use shmem_charge() to do this, reducing code
duplication. But, it does `inode->i_mapping->nrpages++`, which would
double-count since shmem_add_to_page_cache() also does this.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h |  5 ++++
 mm/shmem.c                    | 52 +++++++----------------------------
 mm/userfaultfd.c              | 25 ++++++++---------
 3 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 794d1538b8ba..3e20bfa9ef80 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
 	MCOPY_ATOMIC_CONTINUE,
 };
 
+extern int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr, struct page *page,
+				     bool newly_allocated, bool wp_copy);
+
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
 			    bool *mmap_changing, __u64 mode);
diff --git a/mm/shmem.c b/mm/shmem.c
index 99c54b165c16..5d4b82e9bcb2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2380,10 +2380,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
-	spinlock_t *ptl;
 	void *page_kaddr;
 	struct page *page;
-	pte_t _dst_pte, *dst_pte;
 	int ret;
 	pgoff_t max_off;
 
@@ -2393,8 +2391,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
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
@@ -2434,59 +2434,27 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
+	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
+					page, true, false);
+	if (ret)
+		goto out_release_uncharge;
 
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-	pte_unmap_unlock(dst_pte, ptl);
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
index a539fe18b9a7..8fc597782219 100644
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
-static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
-				     struct vm_area_struct *dst_vma,
-				     unsigned long dst_addr, struct page *page,
-				     bool newly_allocated, bool wp_copy)
+int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+			      struct vm_area_struct *dst_vma,
+			      unsigned long dst_addr, struct page *page,
+			      bool newly_allocated, bool wp_copy)
 {
 	int ret;
 	pte_t _dst_pte, *dst_pte;
@@ -116,8 +111,12 @@ static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	else
 		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 
-	if (newly_allocated)
-		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+	if (newly_allocated) {
+		if (vma_is_shmem(dst_vma) && vm_shared)
+			lru_cache_add(page);
+		else
+			lru_cache_add_inactive_or_unevictable(page, dst_vma);
+	}
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.31.1.295.g9ea45b61b8-goog

