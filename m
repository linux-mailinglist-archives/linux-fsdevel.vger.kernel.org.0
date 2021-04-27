Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EE36CEE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhD0Wxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbhD0Wxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD1C06138F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y5-20020a2586050000b02904ee36d3b170so2853726ybk.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V7Leaw/moabGhHjT6gwS5mm4c5iU1adbxYDsfDac/3I=;
        b=fPfYYvYLgMpYDhjLXk449JayHfBGEDpRTb65FCc2YHjhBRFcOkMsssPipzbIJKijAB
         AZZL3MjWmD/Jxcc4fOWj6UzR9bMCJwpv4yVvHJO5yRlWYTgDCUIIyzxjo8rMT+e8ME+s
         JeshZkci5IHRj0aNOO0ZfBpKM1NBqiAuBqEWKb5bKMDod1A60hwGq41vRl0+jntZQUyR
         IobGa7zGK4fWHCwE3ubkkFzO1N765aG6/eI5EmaoZ4wXTfJq9WIRxMDuxKUqdoYJJpaO
         hH/2rvt/rXAK2LTYR5MHuUSesOCd/lkziNgiDey0uBU2JBqfcuFsxmNcYkDYJqu9SH8A
         DDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V7Leaw/moabGhHjT6gwS5mm4c5iU1adbxYDsfDac/3I=;
        b=mclPiL44kQpQ6MZR1fEFAFhzUYSRrAl0Q9tULCEdgE8c0d1v/9ryuTlfrhN+BPW0mO
         u37wZI5eh8DzrPYxwIm78RIdMbOyfXPK9McXg8gSvrHXNqEWzY1kEDk4273Mpoi7Ieas
         87AbQvo6Zvw2UywJDX/GoZ67yEr9+e2osHUO4GTJ47i44LRBtsQaUM8zIoqZE4bU/D3T
         QACXyaVuOeOedKHFx5Fvy6vDRpvxlY+Yx6rF1AcjeDUrIaSrLWTuM6pJQBsRMPnPK1mI
         uCQbGVTrLCiZdp+Z6FjPcvi61q0qkzI14fZbl80Egy+lzQytethEu1O21l8jUCC4DeCR
         LPlQ==
X-Gm-Message-State: AOAM532tPoSqhGQJF7z8n3yOPibKDrhZdTmZh3rDqD0iMbjIZ0CkDNjt
        gk8QkrvmwyUDivGO5Ku7JbfgEsz7M3qvEkvVtntC
X-Google-Smtp-Source: ABdhPJzQacrsTxCdDxnMJdZVxKLTR2okvxDzpay7o8nMQZmQsa5eeVUzoPCKT3fpNyUam69MRXyfS4aQfMntiO7fxj+O
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:880f:: with SMTP id
 c15mr27743465ybl.373.1619563979406; Tue, 27 Apr 2021 15:52:59 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:40 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 06/10] userfaultfd/shmem: modify shmem_mcopy_atomic_pte to
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
through the PTE setup, do it afterward. This frees up
mcopy_atomic_install_pte() from having to care about this accounting,
and means we don't need to e.g. shmem_uncharge() in the error path.

A side effect is this switches shmem_mcopy_atomic_pte() to use
lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
This wrapper does some extra accounting in an exceptional case, if
appropriate, so it's actually the more correct thing to use.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h |  5 ++++
 mm/shmem.c                    | 48 +++++------------------------------
 mm/userfaultfd.c              | 17 +++++--------
 3 files changed, 18 insertions(+), 52 deletions(-)

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
index 30c0bb501dc9..37db52f45cb5 100644
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
 
@@ -2404,9 +2402,9 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* fallback to copy_from_user outside mmap_lock */
 			if (unlikely(ret)) {
 				*pagep = page;
-				shmem_inode_unacct_blocks(inode, 1);
+				ret = -ENOENT;
 				/* don't free the page */
-				return -ENOENT;
+				goto out_unacct_blocks;
 			}
 		} else {		/* ZEROPAGE */
 			clear_highpage(page);
@@ -2432,32 +2430,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
+	ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+				       page, true, false);
+	if (ret)
+		goto out_release;
 
 	spin_lock_irq(&info->lock);
 	info->alloced++;
@@ -2465,21 +2441,11 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
 
-	inc_mm_counter(dst_mm, mm_counter_file(page));
-	page_add_file_rmap(page, false);
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-
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
-	delete_from_page_cache(page);
 out_release:
 	unlock_page(page);
 	put_page(page);
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
2.31.1.498.g6c1eba8ee3d-goog

