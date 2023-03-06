Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AB6AD200
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 23:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCFWum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 17:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCFWuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA73B202
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:50:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cad819c7so116521227b3.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rzLjkwC2u5MGzDlepslQhV0v6WC0U/wtR0QDlZObA4=;
        b=hXXtqK+nObSBbk42X4186S/BuUW6h0+rcZvKUrSxrvjnBGNWu6kE+X3QL9KMppgwkZ
         cuh1YBOO+eCLPDlppXJPZndpWMbOuEEmYaEKfHUoqTWdLLK76APb/y9tNJbv41deQ7+Z
         fivExsyWtYEh8bIr/ChfAmzLVA0nmJXzMUZYz7vUufxZcmaTdDM8an5SSCygd9vV1Kxs
         Jg1p+AwJhArnUKcadA0/C/h+BoRNu2yPkZDlr/m6RXdQAhVTfRNLM8JyX1+L//GggnLU
         P0fGdPhXmTAA+ktZrWjMr1sfWlWM5Udn21ll3WyMUz3JYj3+Fk8T7gXGq7p5eYgA2Z5D
         9u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rzLjkwC2u5MGzDlepslQhV0v6WC0U/wtR0QDlZObA4=;
        b=NmPpQguguTl4aHJJ/oGS90St9Gato5FjrhcCMtx2WAEqvFYId3UUcc+/RXQJYQeh1x
         BS4Zfzg1lno6NOY1zQjriSiUVbfwxgkDEffF8iNw3um1I9lBXX01fHwRCQc11BmlxRrq
         7MKbyUHIxF654Ghn6tuRCSgTh+UL1hrxEmLGCt3U/Nsy8AAdsz1m+gDJr0qZHHNMUpnk
         FVhbB+WPVUJOStIwcXqmqdjNMNBGxBwMQpQ124E4FQnzavhSlPXDe2Dk8DXwtWKFX6n9
         DxJzPonmbD/e0IheWGvCa6z1nmOOcBtfywlcDCPKZQO9/Of6dm0VVabAPSkiV73H/ecG
         kz+g==
X-Gm-Message-State: AO0yUKX/qc9zAL8zEgtfbzJRbwvsChjYraPxWlek80tguiITYUIExM4j
        WXTbG0Nwo4mlXI+Hn4GUMUzeXyKP1RyvLhzl/3N6
X-Google-Smtp-Source: AK7set87bWVquSBcuZW8Ny+8Trz9/SMPleDpObSKtz0DFZyFj7iwR7+DMndg7acdQz2mXuY7FZwt1m8s/MP7pGIMbhYV
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8609:0:b0:a09:314f:9f09 with
 SMTP id y9-20020a258609000000b00a09314f9f09mr7650365ybk.6.1678143035096; Mon,
 06 Mar 2023 14:50:35 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:20 -0800
In-Reply-To: <20230306225024.264858-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-2-axelrasmussen@google.com>
Subject: [PATCH v3 1/5] mm: userfaultfd: rename functions for clarity + consistency
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The basic problem is, over time we've added new userfaultfd ioctls, and
we've refactored the code so functions which used to handle only one
case are now re-used to deal with several cases. While this happened, we
didn't bother to rename the functions.

Similarly, as we added new functions, we cargo-culted pieces of the
now-inconsistent naming scheme, so those functions too ended up with
names that don't make a lot of sense.

A key point here is, "copy" in most userfaultfd code refers specifically
to UFFDIO_COPY, where we allocate a new page and copy its contents from
userspace. There are many functions with "copy" in the name that don't
actually do this (at least in some cases).

So, rename things into a consistent scheme. The high level idea is that
the call stack for userfaultfd ioctls becomes:

userfaultfd_ioctl
  -> userfaultfd_(particular ioctl)
    -> mfill_atomic_(particular kind of fill operation)
      -> mfill_atomic    /* loops over pages in range */
        -> mfill_atomic_pte    /* deals with single pages */
          -> mfill_atomic_pte_(particular kind of fill operation)
            -> mfill_atomic_install_pte

There are of course some special cases (shmem, hugetlb), but this is the
general structure which all function names now adhere to.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              | 18 +++----
 include/linux/hugetlb.h       | 30 +++++------
 include/linux/userfaultfd_k.h | 18 +++----
 mm/hugetlb.c                  | 20 +++----
 mm/userfaultfd.c              | 98 +++++++++++++++++------------------
 5 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..365bf00dd8dd 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1741,9 +1741,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
-				   uffdio_copy.len, &ctx->mmap_changing,
-				   uffdio_copy.mode);
+		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
+					uffdio_copy.len, &ctx->mmap_changing,
+					uffdio_copy.mode);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1793,9 +1793,9 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
-				     uffdio_zeropage.range.len,
-				     &ctx->mmap_changing);
+		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
+					   uffdio_zeropage.range.len,
+					   &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1903,9 +1903,9 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mcopy_continue(ctx->mm, uffdio_continue.range.start,
-				     uffdio_continue.range.len,
-				     &ctx->mmap_changing);
+		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
+					    uffdio_continue.range.len,
+					    &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..8f0467bf1cbd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -158,13 +158,13 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
-				struct vm_area_struct *dst_vma,
-				unsigned long dst_addr,
-				unsigned long src_addr,
-				enum mcopy_atomic_mode mode,
-				struct page **pagep,
-				bool wp_copy);
+int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+			     struct vm_area_struct *dst_vma,
+			     unsigned long dst_addr,
+			     unsigned long src_addr,
+			     enum mcopy_atomic_mode mode,
+			     struct page **pagep,
+			     bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -393,14 +393,14 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 #ifdef CONFIG_USERFAULTFD
-static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-						pte_t *dst_pte,
-						struct vm_area_struct *dst_vma,
-						unsigned long dst_addr,
-						unsigned long src_addr,
-						enum mcopy_atomic_mode mode,
-						struct page **pagep,
-						bool wp_copy)
+static inline int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
+					   pte_t *dst_pte,
+					   struct vm_area_struct *dst_vma,
+					   unsigned long dst_addr,
+					   unsigned long src_addr,
+					   enum mcopy_atomic_mode mode,
+					   struct page **pagep,
+					   bool wp_copy)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3767f18114ef..468080125612 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -61,15 +61,15 @@ extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, bool wp_copy);
 
-extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
-			    unsigned long src_start, unsigned long len,
-			    atomic_t *mmap_changing, __u64 mode);
-extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
-			      unsigned long dst_start,
-			      unsigned long len,
-			      atomic_t *mmap_changing);
-extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-			      unsigned long len, atomic_t *mmap_changing);
+extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+				 unsigned long src_start, unsigned long len,
+				 atomic_t *mmap_changing, __u64 mode);
+extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
+				     unsigned long dst_start,
+				     unsigned long len,
+				     atomic_t *mmap_changing);
+extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
+				     unsigned long len, atomic_t *mmap_changing);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..4c9276549394 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6154,17 +6154,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 #ifdef CONFIG_USERFAULTFD
 /*
- * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
- * modifications for huge pages.
+ * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
+ * with modifications for hugetlb pages.
  */
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pte_t *dst_pte,
-			    struct vm_area_struct *dst_vma,
-			    unsigned long dst_addr,
-			    unsigned long src_addr,
-			    enum mcopy_atomic_mode mode,
-			    struct page **pagep,
-			    bool wp_copy)
+int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
+			     pte_t *dst_pte,
+			     struct vm_area_struct *dst_vma,
+			     unsigned long dst_addr,
+			     unsigned long src_addr,
+			     enum mcopy_atomic_mode mode,
+			     struct page **pagep,
+			     bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..84db5b2fad3a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -127,13 +127,13 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	return ret;
 }
 
-static int mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pmd_t *dst_pmd,
-			    struct vm_area_struct *dst_vma,
-			    unsigned long dst_addr,
-			    unsigned long src_addr,
-			    struct page **pagep,
-			    bool wp_copy)
+static int mfill_atomic_pte_copy(struct mm_struct *dst_mm,
+				 pmd_t *dst_pmd,
+				 struct vm_area_struct *dst_vma,
+				 unsigned long dst_addr,
+				 unsigned long src_addr,
+				 struct page **pagep,
+				 bool wp_copy)
 {
 	void *page_kaddr;
 	int ret;
@@ -204,10 +204,10 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	goto out;
 }
 
-static int mfill_zeropage_pte(struct mm_struct *dst_mm,
-			      pmd_t *dst_pmd,
-			      struct vm_area_struct *dst_vma,
-			      unsigned long dst_addr)
+static int mfill_atomic_pte_zeropage(struct mm_struct *dst_mm,
+				     pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr)
 {
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
@@ -240,11 +240,11 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 }
 
 /* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
-static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
-				pmd_t *dst_pmd,
-				struct vm_area_struct *dst_vma,
-				unsigned long dst_addr,
-				bool wp_copy)
+static int mfill_atomic_pte_continue(struct mm_struct *dst_mm,
+				     pmd_t *dst_pmd,
+				     struct vm_area_struct *dst_vma,
+				     unsigned long dst_addr,
+				     bool wp_copy)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
@@ -307,10 +307,10 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 
 #ifdef CONFIG_HUGETLB_PAGE
 /*
- * __mcopy_atomic processing for HUGETLB vmas.  Note that this routine is
+ * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
  * called with mmap_lock held, it will release mmap_lock before returning.
  */
-static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
+static __always_inline ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 					      struct vm_area_struct *dst_vma,
 					      unsigned long dst_start,
 					      unsigned long src_start,
@@ -411,7 +411,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mfill_atomic_pte(dst_mm, dst_pte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
@@ -463,7 +463,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 }
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
-extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
+extern ssize_t mfill_atomic_hugetlb(struct mm_struct *dst_mm,
 				      struct vm_area_struct *dst_vma,
 				      unsigned long dst_start,
 				      unsigned long src_start,
@@ -484,8 +484,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	ssize_t err;
 
 	if (mode == MCOPY_ATOMIC_CONTINUE) {
-		return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-					    wp_copy);
+		return mfill_atomic_pte_continue(dst_mm, dst_pmd, dst_vma,
+						 dst_addr, wp_copy);
 	}
 
 	/*
@@ -500,11 +500,11 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
-			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					       dst_addr, src_addr, page,
-					       wp_copy);
+			err = mfill_atomic_pte_copy(dst_mm, dst_pmd, dst_vma,
+						    dst_addr, src_addr, page,
+						    wp_copy);
 		else
-			err = mfill_zeropage_pte(dst_mm, dst_pmd,
+			err = mfill_atomic_pte_zeropage(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
@@ -516,13 +516,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	return err;
 }
 
-static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
-					      unsigned long dst_start,
-					      unsigned long src_start,
-					      unsigned long len,
-					      enum mcopy_atomic_mode mcopy_mode,
-					      atomic_t *mmap_changing,
-					      __u64 mode)
+static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
+					    unsigned long dst_start,
+					    unsigned long src_start,
+					    unsigned long len,
+					    enum mcopy_atomic_mode mcopy_mode,
+					    atomic_t *mmap_changing,
+					    __u64 mode)
 {
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
@@ -588,9 +588,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-					       src_start, len, mcopy_mode,
-					       wp_copy);
+		return  mfill_atomic_hugetlb(dst_mm, dst_vma, dst_start,
+					     src_start, len, mcopy_mode,
+					     wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -688,26 +688,26 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	return copied ? copied : err;
 }
 
-ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
-		     unsigned long src_start, unsigned long len,
-		     atomic_t *mmap_changing, __u64 mode)
+ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+			  unsigned long src_start, unsigned long len,
+			  atomic_t *mmap_changing, __u64 mode)
 {
-	return __mcopy_atomic(dst_mm, dst_start, src_start, len,
-			      MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
+	return mfill_atomic(dst_mm, dst_start, src_start, len,
+			    MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
 }
 
-ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
+			      unsigned long len, atomic_t *mmap_changing)
 {
-	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
-			      mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
+			    mmap_changing, 0);
 }
 
-ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
+			      unsigned long len, atomic_t *mmap_changing)
 {
-	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
-			      mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
+			    mmap_changing, 0);
 }
 
 long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

