Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3527D6A004D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 01:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjBWA6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 19:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjBWA6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:58:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463201A64C
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so117480857b3.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 16:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYvkJikrVfRkjAsoLRzcOofnxYsgz4Gx93yNax8xwTM=;
        b=oAkFvcRUZRbBfBexlIuZrzZ0B6uz1rZvppIPcAKlY9l1KOmS+1j7ulyHCbXpH3mLcP
         jPeFzDY9mfQqdVPoBJFa7k6TSAOgyIyRS9leF7lqARFwpV0WD/YDYlcmsi31uImkql8W
         J70rlkHO65u2TIMGugSLnEg9XeVZ/fgmH0ZPGREMBi8KeUMK7mxGIXZlcC35sY+VQ2v4
         hVyUSIgiZIXG9FaaRQqyw7iJp189c5+UQhowho7jHnih5SKndusUUoiuRTt/EGlDZpVP
         2JDn7E3fRsJ3JqYgiNpMlXinsEnrVqZC8wz+xid+dMDDnRhEz4y1LpNZEfmK5jU6aSCL
         Pxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYvkJikrVfRkjAsoLRzcOofnxYsgz4Gx93yNax8xwTM=;
        b=4Hdsa+A085G9Zcz57Mou1QaNUCZ+KmRVurjxwQQeGV1EAE13GZYcSXDBe7578DGdUy
         w7sMniBk0a8ngPVZ/OIJtOrJc1J9FNMLk/4n06dr6C32XF3wnSbv2Lkc11z9yh86kQqc
         nEhxhMPpCdPyal1GeiKEDD4pk8AZguR+8aGeHAknhKepm6GnLd7vLrbGjPwAXXRDNiAk
         8fmjxryyNzXzravoo10wiyzW0XN5voxUlk/L9776bvYcSZul7psDg6XPkZME0YFjxSqM
         A3twsuSgJqhC51GLu/XziiJgtfsCgriDlWuuGVZ16TBSYV8xzR/hqONqIKQZgUefuwQW
         4jpQ==
X-Gm-Message-State: AO0yUKXqbPE40Eo9brSiBCY5+g60Uaso21Z/ddronmm1KxyY5YefkaTS
        UR/u0srlxtra8X97ebseo21BIz7rS/h1hTw4rjHu
X-Google-Smtp-Source: AK7set91uajqgfLhiGUOQ4hgaeazw52oRkA5ceqRj17MRktBZi/1A1MsqoBszMqKO22Dtropn8Jg0Yj9+V5QIx70VPva
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:3e99:dd9e:9db9:449c])
 (user=axelrasmussen job=sendgmr) by 2002:a81:af5d:0:b0:52e:d380:ab14 with
 SMTP id x29-20020a81af5d000000b0052ed380ab14mr1497821ywj.3.1677113887212;
 Wed, 22 Feb 2023 16:58:07 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:57:52 -0800
In-Reply-To: <20230223005754.2700663-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230223005754.2700663-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230223005754.2700663-4-axelrasmussen@google.com>
Subject: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
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

Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
argument. In future commits we plan to plumb the flags through to more
places, so we'd be proliferating the very long argument list even
further.

Let's take the time to simplify the argument list. Combine the two
arguments into one - and generalize, so when we add more flags in the
future, it doesn't imply more function arguments.

Since the modes (copy, zeropage, continue) are mutually exclusive, store
them as an integer value (0, 1, 2) in the low bits. Place combine-able
flag bits in the high bits.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              |  5 ++-
 include/linux/hugetlb.h       | 11 ++---
 include/linux/shmem_fs.h      |  4 +-
 include/linux/userfaultfd_k.h | 30 +++++++-------
 mm/hugetlb.c                  | 14 ++++---
 mm/shmem.c                    |  6 +--
 mm/userfaultfd.c              | 76 ++++++++++++++++-------------------
 7 files changed, 70 insertions(+), 76 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a95f6aaef76b..2db15a5e3224 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1725,6 +1725,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	struct uffdio_copy uffdio_copy;
 	struct uffdio_copy __user *user_uffdio_copy;
 	struct userfaultfd_wake_range range;
+	int flags = 0;
 
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
@@ -1751,10 +1752,12 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 		goto out;
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
+	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
+		flags |= MFILL_ATOMIC_WP;
 	if (mmget_not_zero(ctx->mm)) {
 		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
 					uffdio_copy.len, &ctx->mmap_changing,
-					uffdio_copy.mode);
+					flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d3fc104aab78..1e66a75b4da4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -12,7 +12,6 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -161,9 +160,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy);
+			     int mode_flags,
+			     struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -359,9 +357,8 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
-					   enum mcopy_atomic_mode mode,
-					   struct page **pagep,
-					   bool wp_copy)
+					   int mode_flags,
+					   struct page **pagep)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2a0b1dc0460f..6bbb243716f3 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -153,11 +153,11 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  bool zeropage, bool wp_copy,
+				  int mode_flags,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
+			       src_addr, mode_flags, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c6c23408d300..185024128e0f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -40,30 +40,28 @@ extern int sysctl_unprivileged_userfaultfd;
 
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
-/*
- * The mode of operation for __mcopy_atomic and its helpers.
- *
- * This is almost an implementation detail (mcopy_atomic below doesn't take this
- * as a parameter), but it's exposed here because memory-kind-specific
- * implementations (e.g. hugetlbfs) need to know the mode of operation.
- */
-enum mcopy_atomic_mode {
-	/* A normal copy_from_user into the destination range. */
-	MCOPY_ATOMIC_NORMAL,
-	/* Don't copy; map the destination range to the zero page. */
-	MCOPY_ATOMIC_ZEROPAGE,
-	/* Just install pte(s) with the existing page(s) in the page cache. */
-	MCOPY_ATOMIC_CONTINUE,
+/* Mutually exclusive modes of operation. */
+enum mfill_atomic_mode {
+	MFILL_ATOMIC_COPY,
+	MFILL_ATOMIC_ZEROPAGE,
+	MFILL_ATOMIC_CONTINUE,
+	NR_MFILL_ATOMIC_MODES,
 };
 
+#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
+#define MFILL_ATOMIC_MODE_MASK (BIT(MFILL_ATOMIC_MODE_BITS) - 1)
+
+/* Flags controlling behavior. */
+#define MFILL_ATOMIC_WP BIT(MFILL_ATOMIC_MODE_BITS + 0)
+
 extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr, struct page *page,
-				    bool newly_allocated, bool wp_copy);
+				    bool newly_allocated, int mode_flags);
 
 extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 				 unsigned long src_start, unsigned long len,
-				 atomic_t *mmap_changing, __u64 mode);
+				 atomic_t *mmap_changing, int flags);
 extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     unsigned long dst_start,
 				     unsigned long len,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0afd2ed8ad39..7fc4f529b4d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -34,6 +34,7 @@
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
 #include <linux/memory.h>
+#include <linux/userfaultfd_k.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -6166,11 +6167,12 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy)
+			     int mode_flags,
+			     struct page **pagep)
 {
-	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
+	int mode = mode_flags & MFILL_ATOMIC_MODE_MASK;
+	bool is_continue = (mode == MFILL_ATOMIC_CONTINUE);
+	bool wp_enabled = (mode_flags & MFILL_ATOMIC_WP);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
@@ -6305,7 +6307,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
 	 * with wp flag set, don't set pte write bit.
 	 */
-	if (wp_copy || (is_continue && !vm_shared))
+	if (wp_enabled || (is_continue && !vm_shared))
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
@@ -6320,7 +6322,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
-	if (wp_copy)
+	if (wp_enabled)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
 	set_huge_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
diff --git a/mm/shmem.c b/mm/shmem.c
index cc03c61190eb..98c9c1f08389 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2402,7 +2402,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage, bool wp_copy,
+			   int mode_flags,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2434,7 +2434,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		if (!folio)
 			goto out_unacct_blocks;
 
-		if (!zeropage) {	/* COPY */
+		if ((mode_flags & MFILL_ATOMIC_MODE_MASK) == MFILL_ATOMIC_COPY) {
 			page_kaddr = kmap_local_folio(folio, 0);
 			/*
 			 * The read mmap_lock is held here.  Despite the
@@ -2493,7 +2493,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       &folio->page, true, wp_copy);
+				       &folio->page, true, mode_flags);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4bf5c97c665a..7882e4c60f60 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -58,7 +58,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr, struct page *page,
-			     bool newly_allocated, bool wp_copy)
+			     bool newly_allocated, int mode_flags)
 {
 	int ret;
 	pte_t _dst_pte, *dst_pte;
@@ -79,7 +79,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * Always mark a PTE as write-protected when needed, regardless of
 	 * VM_WRITE, which the user might change.
 	 */
-	if (wp_copy) {
+	if (mode_flags & MFILL_ATOMIC_WP) {
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 		writable = false;
 	}
@@ -145,8 +145,8 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
-				 struct page **pagep,
-				 bool wp_copy)
+				 int mode_flags,
+				 struct page **pagep)
 {
 	void *page_kaddr;
 	int ret;
@@ -207,7 +207,7 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, true, wp_copy);
+				       page, true, mode_flags);
 	if (ret)
 		goto out_release;
 out:
@@ -255,7 +255,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
-				     bool wp_copy)
+				     int mode_flags)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
@@ -281,7 +281,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	}
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, false, wp_copy);
+				       page, false, mode_flags);
 	if (ret)
 		goto out_release;
 
@@ -326,9 +326,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode,
-					      bool wp_copy)
+					      int mode_flags)
 {
+	int mode = mode_flags & MFILL_ATOMIC_MODE_MASK;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
@@ -347,7 +347,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
+	if (mode == MFILL_ATOMIC_ZEROPAGE) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -415,7 +415,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		if (mode != MCOPY_ATOMIC_CONTINUE &&
+		if (mode != MFILL_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
@@ -423,9 +423,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page,
-					       wp_copy);
+		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
+					       src_addr, mode_flags, &page);
 
 		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -479,23 +478,22 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    enum mcopy_atomic_mode mode,
-				    bool wp_copy);
+				    int mode_flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **page,
-						enum mcopy_atomic_mode mode,
-						bool wp_copy)
+						struct page **pagep,
+						int mode_flags)
 {
+	int mode = mode_flags & MFILL_ATOMIC_MODE_MASK;
 	ssize_t err;
 
-	if (mode == MCOPY_ATOMIC_CONTINUE) {
+	if (mode == MFILL_ATOMIC_CONTINUE) {
 		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
-						 dst_addr, wp_copy);
+						 dst_addr, mode_flags);
 	}
 
 	/*
@@ -509,18 +507,17 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (mode == MCOPY_ATOMIC_NORMAL)
+		if (mode == MFILL_ATOMIC_COPY)
 			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
-						    dst_addr, src_addr, page,
-						    wp_copy);
+						    dst_addr, src_addr,
+						    mode_flags, pagep);
 		else
 			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
-					     mode != MCOPY_ATOMIC_NORMAL,
-					     wp_copy, page);
+					     mode_flags, pagep);
 	}
 
 	return err;
@@ -530,9 +527,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 					    unsigned long dst_start,
 					    unsigned long src_start,
 					    unsigned long len,
-					    enum mcopy_atomic_mode mcopy_mode,
 					    atomic_t *mmap_changing,
-					    __u64 mode)
+					    int mode_flags)
 {
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
@@ -540,7 +536,6 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	bool wp_copy;
 
 	/*
 	 * Sanitize the command parameters:
@@ -590,8 +585,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * validate 'mode' now that we know the dst_vma: don't allow
 	 * a wrprotect copy if the userfaultfd didn't register as WP.
 	 */
-	wp_copy = mode & UFFDIO_COPY_MODE_WP;
-	if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if ((mode_flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
 		goto out_unlock;
 
 	/*
@@ -599,12 +593,12 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, mcopy_mode,
-					     wp_copy);
+					     src_start, len, mode_flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) &&
+	    (mode_flags & MFILL_ATOMIC_MODE_MASK) == MFILL_ATOMIC_CONTINUE)
 		goto out_unlock;
 
 	/*
@@ -652,7 +646,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, mcopy_mode, wp_copy);
+				       src_addr, &page, mode_flags);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
@@ -700,24 +694,24 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 
 ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 			  unsigned long src_start, unsigned long len,
-			  atomic_t *mmap_changing, __u64 mode)
+			  atomic_t *mmap_changing, int flags)
 {
 	return mfill_atomic(dst_mm, dst_start, src_start, len,
-			    MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
+			    mmap_changing, flags | MFILL_ATOMIC_COPY);
 }
 
 ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
 			      unsigned long len, atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
-			    mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len,
+			    mmap_changing, MFILL_ATOMIC_ZEROPAGE);
 }
 
 ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			      unsigned long len, atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
-			    mmap_changing, 0);
+	return mfill_atomic(dst_mm, start, 0, len,
+			    mmap_changing, MFILL_ATOMIC_CONTINUE);
 }
 
 void uffd_wp_range(struct vm_area_struct *dst_vma,
-- 
2.39.2.637.g21b0678d19-goog

