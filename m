Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1316AD201
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 23:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCFWun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 17:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCFWul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B7729A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:50:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so116753207b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWkp8Syt/tD24Ve1T0a4JE83slFHIHzMNtjm/Om6sdU=;
        b=RwYTVPGvBQHC7DUucN9vnX3PiGwPC1O0wU1evYWKKZfYz3uYpbFYom6VYlWtjJv/JM
         N1+sl3GwedWifR/rr2odEVekToXqyvtBlsN3af4GqghDVRqKpQUaAOpEw5MrSaMj6H4S
         CrPwwWmceBgD++ybpD9W6akDMtMEjKT1K2BV97tCXwLoqDpJx2f0muNCnnd29+R2Qn+1
         fQl3KFzPHz4I9MD+BM3qLtk1x0LKiuPp5WCQY39olKnjF24dO7MY0H/WRnk89mw/O7et
         KOqANybHK3icgBF/btd6MW70rl68aYtZLJD3z/4ObYMTt9ZG+gLKT7huZw6qx6IcjeoV
         MS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWkp8Syt/tD24Ve1T0a4JE83slFHIHzMNtjm/Om6sdU=;
        b=l8E46ayk90RV1SF2WuNAU/J4TYlkdkzPjv0vRtZeWTux4Uz0w2yktxjnEa+whFYZS7
         wXW6MZ3q1ZMoEUI7d5OhQ84Nf+andawGhRVN+INU8KLE8iQp3+ABOWMttcMQflFUjNHZ
         PLwg3o8msYOmspmxRRbZa7f4wehZxmqgX3suZzJzUR/ltZlBjPlr3l6BfRWRfxFaF6G4
         cplYz9QKFHbhC8hc9uCIuTw0chgCnxs8hNo6mT+8xmSyAigW8ryh7F1DWNebdildZkA2
         JfwkNvd6U9474CAN8i7n+svTgzNZACt3wY6y25YuFp7kowPDG3PYuM6Do9th1jdBR+S1
         1kzg==
X-Gm-Message-State: AO0yUKVTcg+Rk/PYzM6yaTZGKKZpHvNziQ37gHMVb577TGsojruN8Tx3
        dbxfr6hK/rF0gpC8ztiiHwHd1qh4dIWTHB9ygWAk
X-Google-Smtp-Source: AK7set8TPiGkxKjmjwBu1ogoTHma00i/P1CfwolBrXkh9LGNF5hzL8XkdfzdhHM7vgRN4Yh6w9R9bydmoqoE8GNICnDB
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a25:9888:0:b0:a88:ba7:59b with SMTP
 id l8-20020a259888000000b00a880ba7059bmr7448775ybo.9.1678143037277; Mon, 06
 Mar 2023 14:50:37 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:21 -0800
In-Reply-To: <20230306225024.264858-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-3-axelrasmussen@google.com>
Subject: [PATCH v3 2/5] mm: userfaultfd: don't pass around both mm and vma
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quite a few userfaultfd functions took both mm and vma pointers as
arguments. Since the mm is trivially accessible via vma->vm_mm, there's
no reason to pass both; it just needlessly extends the already long
argument list.

Get rid of the mm pointer, where possible, to shorten the argument list.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              |  2 +-
 include/linux/hugetlb.h       |  5 ++-
 include/linux/shmem_fs.h      |  4 +--
 include/linux/userfaultfd_k.h |  4 +--
 mm/hugetlb.c                  |  9 +++--
 mm/shmem.c                    |  7 ++--
 mm/userfaultfd.c              | 66 ++++++++++++++++-------------------
 7 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 365bf00dd8dd..84d5d402214a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1629,7 +1629,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 		/* Reset ptes for the whole vma range if wr-protected */
 		if (userfaultfd_wp(vma))
-			uffd_wp_range(mm, vma, start, vma_end - start, false);
+			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f0467bf1cbd..8b9325f77ac3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -158,7 +158,7 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -393,8 +393,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_USERFAULTFD
-static inline int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
-					   pte_t *dst_pte,
+static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..b82916c25e61 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -151,14 +151,14 @@ extern void shmem_uncharge(struct inode *inode, long pages);
 
 #ifdef CONFIG_USERFAULTFD
 #ifdef CONFIG_SHMEM
-extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  bool zeropage, bool wp_copy,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
-#define shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
+#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
 			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 468080125612..ba79e296fcc7 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -56,7 +56,7 @@ enum mcopy_atomic_mode {
 	MCOPY_ATOMIC_CONTINUE,
 };
 
-extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, bool wp_copy);
@@ -73,7 +73,7 @@ extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
-extern long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
+extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
 /* mm helpers */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c9276549394..b4bda5f7f29f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6157,8 +6157,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
  * with modifications for hugetlb pages.
  */
-int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
-			     pte_t *dst_pte,
+int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
@@ -6277,7 +6276,7 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
 		folio_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lock(h, dst_mm, dst_pte);
+	ptl = huge_pte_lock(h, dst_vma->vm_mm, dst_pte);
 
 	ret = -EIO;
 	if (folio_test_hwpoison(folio))
@@ -6319,9 +6318,9 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (wp_copy)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
-	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_huge_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
 
-	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
+	hugetlb_count_add(pages_per_huge_page(h), dst_vma->vm_mm);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..1d751b6cf1ac 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2415,8 +2415,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 }
 
 #ifdef CONFIG_USERFAULTFD
-int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
-			   pmd_t *dst_pmd,
+int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
@@ -2506,11 +2505,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_mm);
+				      gfp & GFP_RECLAIM_MASK, dst_vma->vm_mm);
 	if (ret)
 		goto out_release;
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       &folio->page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 84db5b2fad3a..bd3542d5408f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -55,7 +55,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
  * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
  * and anon, and for both shared and private VMAs.
  */
-int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr, struct page *page,
 			     bool newly_allocated, bool wp_copy)
@@ -79,7 +79,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (wp_copy)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
 
 	if (vma_is_shmem(dst_vma)) {
 		/* serialize against truncate with the page table lock */
@@ -115,9 +115,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	 * Must happen after rmap, as mm_counter() checks mapping (via
 	 * PageAnon()), which is set by __page_set_anon_rmap().
 	 */
-	inc_mm_counter(dst_mm, mm_counter(page));
+	inc_mm_counter(dst_vma->vm_mm, mm_counter(page));
 
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
@@ -127,8 +127,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	return ret;
 }
 
-static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
-				 pmd_t *dst_pmd,
+static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
@@ -190,10 +189,10 @@ static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page_folio(page), dst_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), dst_vma->vm_mm, GFP_KERNEL))
 		goto out_release;
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       page, true, wp_copy);
 	if (ret)
 		goto out_release;
@@ -204,8 +203,7 @@ static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
 	goto out;
 }
 
-static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
-				     pmd_t *dst_pmd,
+static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr)
 {
@@ -217,7 +215,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
 		inode = dst_vma->vm_file->f_inode;
@@ -230,7 +228,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
-	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
@@ -240,8 +238,7 @@ static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
 }
 
 /* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
-static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
-				     pmd_t *dst_pmd,
+static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
 				     bool wp_copy)
@@ -269,7 +266,7 @@ static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
 		goto out_release;
 	}
 
-	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
 				       page, false, wp_copy);
 	if (ret)
 		goto out_release;
@@ -310,7 +307,7 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
  * called with mmap_lock held, it will release mmap_lock before returning.
  */
-static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
+static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct vm_area_struct *dst_vma,
 					      unsigned long dst_start,
 					      unsigned long src_start,
@@ -318,6 +315,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 					      enum mcopy_atomic_mode mode,
 					      bool wp_copy)
 {
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
@@ -411,7 +409,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = hugetlb_mfill_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
@@ -463,17 +461,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 }
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
-extern ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
-				      struct vm_area_struct *dst_vma,
-				      unsigned long dst_start,
-				      unsigned long src_start,
-				      unsigned long len,
-				      enum mcopy_atomic_mode mode,
-				      bool wp_copy);
+extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
+				    unsigned long dst_start,
+				    unsigned long src_start,
+				    unsigned long len,
+				    enum mcopy_atomic_mode mode,
+				    bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
-						pmd_t *dst_pmd,
+static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
@@ -484,7 +480,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	ssize_t err;
 
 	if (mode == MCOPY_ATOMIC_CONTINUE) {
-		return mfill_atomic_pte_continue(dst_mm, dst_pmd, dst_vma,
+		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
 						 dst_addr, wp_copy);
 	}
 
@@ -500,14 +496,14 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
-			err = mfill_atomic_pte_copy(dst_mm, dst_pmd, dst_vma,
+			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
 						    dst_addr, src_addr, page,
 						    wp_copy);
 		else
-			err = mfill_atomic_pte_zeropage(dst_mm, dst_pmd,
+			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
+		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
 					     wp_copy, page);
@@ -588,7 +584,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_mm, dst_vma, dst_start,
+		return  mfill_atomic_hugetlb(dst_vma, dst_start,
 					     src_start, len, mcopy_mode,
 					     wp_copy);
 
@@ -641,7 +637,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_none(*dst_pmd));
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
-		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
@@ -710,7 +706,7 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			    mmap_changing, 0);
 }
 
-long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
+long uffd_wp_range(struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
 	unsigned int mm_cp_flags;
@@ -730,7 +726,7 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
 	 */
 	if (!enable_wp && vma_wants_manual_pte_write_upgrade(dst_vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
-	tlb_gather_mmu(&tlb, dst_mm);
+	tlb_gather_mmu(&tlb, dst_vma->vm_mm);
 	ret = change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
 	tlb_finish_mmu(&tlb);
 
@@ -782,7 +778,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			goto out_unlock;
 	}
 
-	err = uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
+	err = uffd_wp_range(dst_vma, start, len, enable_wp);
 
 	/* Return 0 on success, <0 on failures */
 	if (err > 0)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

