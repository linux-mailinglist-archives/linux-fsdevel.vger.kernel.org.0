Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA056AD205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 23:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCFWu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 17:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCFWun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8A1259D
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:50:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-538116920c3so116504007b3.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 14:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTIdfrboSfZ8SF4fvQaWy4Q65QuhJjnwYVdRkDmBM+Q=;
        b=BS0+UG287tLhT9cl5hSvanOwwHVMM6WGwWxHG+i2DokDML6C6Ry9tf322cde9acDr9
         PiiKTOSWJOWeRj8YS2ITiV3UD9ZlRv9kkJZ9bcBY6x+Tv8628Ys6z9HDSZZoBEpD2GJ5
         D3InU3fmKVbfDm6OOnXsDaK4A4YmfwRpACYhtSMwkUmDlCjQfqkzYApRL24M8077QoTd
         xzRVdOd40u0ocC4MrWsWYDoJCVgLKXb/qyvJImS/G7TmrT8BrI1geDuaJlfifhTA8QDm
         zPchgGjQh3N7fZ8g2q6qQA6N5oLjdm0ftFe/y3Zy3OPf+E/ug/dc9mUBdxwRZQZwsgHo
         Zl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTIdfrboSfZ8SF4fvQaWy4Q65QuhJjnwYVdRkDmBM+Q=;
        b=1RWVyRun64+JUUVAlDGELEi2GXTEBjO1b9Uu/Nuf82U4TWL25ntAPE7psZiMfPZEhP
         9xEyxD5Z7kX/9J9PFNU7DzVgX6biHf/1HNWLghHoMqrxxhDE9ny71Igvy8E44Q49T0WL
         EmBsefSF+tLEAM6EtPsGrf9lyRYsySCEJxvkmmqeXW9nSxS9SFTyD9mMIhAvbS/AJArg
         YkIwaL8BCnJHuqbqXYg1Ehc+F2ziZm3IfZE/fUy/rRlC/VDbfEMWD48eon7t5W8n8898
         RonfG7A5FtQTwcqOBw5+X4c9N1ANbYMCCw/yPcWhopuPoULr2wTHRZHdBDIh2Nr8G+t9
         voAw==
X-Gm-Message-State: AO0yUKX6sNgCR8Jrv9iA8w0fVrjXz3ThX13Ux+18Dh4yU8lQaNAtPpfV
        VtBlP75x8ju00kVCPfqx1Puyhd8YSyTPvXeJE+I7
X-Google-Smtp-Source: AK7set+jsQdvYP75Q1I46VO+daeco0eoghdnqWp6vwPNxQuj5DwYniFMgWoXkYSTRJKTAwtLfbZzrm9JUnQ7qnr7FJVL
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:5d0:0:b0:a48:6236:1be4 with SMTP
 id w16-20020a5b05d0000000b00a4862361be4mr7411346ybp.2.1678143039350; Mon, 06
 Mar 2023 14:50:39 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:22 -0800
In-Reply-To: <20230306225024.264858-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-4-axelrasmussen@google.com>
Subject: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
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

This is quite similar to an earlier patch proposed by Nadav Amit
("userfaultfd: introduce uffd_flags" - for some reason Lore no longer
has a copy of the patch). The main difference is that patch only handled
flags, whereas this patch *also* combines the "mode" argument into the
same type to shorten the argument list.

Acked-by: James Houghton <jthoughton@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              |  5 ++-
 include/linux/hugetlb.h       | 10 ++---
 include/linux/shmem_fs.h      |  5 ++-
 include/linux/userfaultfd_k.h | 34 ++++++++--------
 mm/hugetlb.c                  | 13 +++---
 mm/shmem.c                    |  7 ++--
 mm/userfaultfd.c              | 76 ++++++++++++++++-------------------
 7 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 84d5d402214a..b8e328123b71 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1714,6 +1714,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	struct uffdio_copy uffdio_copy;
 	struct uffdio_copy __user *user_uffdio_copy;
 	struct userfaultfd_wake_range range;
+	int flags = 0;
 
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
@@ -1740,10 +1741,12 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
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
index 8b9325f77ac3..6270a4786584 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -162,9 +162,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy);
+			     uffd_flags_t flags,
+			     struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -397,9 +396,8 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   struct vm_area_struct *dst_vma,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
-					   enum mcopy_atomic_mode mode,
-					   struct page **pagep,
-					   bool wp_copy)
+					   uffd_flags_t flags,
+					   struct page **pagep)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index b82916c25e61..b7048bd88a8d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/userfaultfd_k.h>
 
 /* inode in-kernel data */
 
@@ -155,11 +156,11 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  bool zeropage, bool wp_copy,
+				  uffd_flags_t flags,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
+			       src_addr, flags, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ba79e296fcc7..a45c1b42e500 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -40,30 +40,32 @@ extern int sysctl_unprivileged_userfaultfd;
 
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
+/* A combined operation mode + behavior flags. */
+typedef unsigned int __bitwise uffd_flags_t;
+
+/* Mutually exclusive modes of operation. */
+enum mfill_atomic_mode {
+	MFILL_ATOMIC_COPY = (__force uffd_flags_t) 0,
+	MFILL_ATOMIC_ZEROPAGE = (__force uffd_flags_t) 1,
+	MFILL_ATOMIC_CONTINUE = (__force uffd_flags_t) 2,
+	NR_MFILL_ATOMIC_MODES,
 };
 
+#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
+#define MFILL_ATOMIC_BIT(nr) ((__force uffd_flags_t) BIT(MFILL_ATOMIC_MODE_BITS + (nr)))
+#define MFILL_ATOMIC_MODE_MASK (MFILL_ATOMIC_BIT(0) - 1)
+
+/* Flags controlling behavior. */
+#define MFILL_ATOMIC_WP MFILL_ATOMIC_BIT(0)
+
 extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_addr, struct page *page,
-				    bool newly_allocated, bool wp_copy);
+				    bool newly_allocated, uffd_flags_t flags);
 
 extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 				 unsigned long src_start, unsigned long len,
-				 atomic_t *mmap_changing, __u64 mode);
+				 atomic_t *mmap_changing, uffd_flags_t flags);
 extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 				     unsigned long dst_start,
 				     unsigned long len,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b4bda5f7f29f..1339f527b540 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6161,11 +6161,12 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
-			     enum mcopy_atomic_mode mode,
-			     struct page **pagep,
-			     bool wp_copy)
+			     uffd_flags_t flags,
+			     struct page **pagep)
 {
-	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
+	int mode = flags & MFILL_ATOMIC_MODE_MASK;
+	bool is_continue = (mode == MFILL_ATOMIC_CONTINUE);
+	bool wp_enabled = (flags & MFILL_ATOMIC_WP);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
@@ -6300,7 +6301,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
 	 * with wp flag set, don't set pte write bit.
 	 */
-	if (wp_copy || (is_continue && !vm_shared))
+	if (wp_enabled || (is_continue && !vm_shared))
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
@@ -6315,7 +6316,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
-	if (wp_copy)
+	if (wp_enabled)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
 	set_huge_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
diff --git a/mm/shmem.c b/mm/shmem.c
index 1d751b6cf1ac..0258054a0270 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -76,7 +76,6 @@ static struct vfsmount *shm_mnt;
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <uapi/linux/memfd.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
 
@@ -2419,7 +2418,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage, bool wp_copy,
+			   uffd_flags_t flags,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2451,7 +2450,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		if (!folio)
 			goto out_unacct_blocks;
 
-		if (!zeropage) {	/* COPY */
+		if ((flags & MFILL_ATOMIC_MODE_MASK) == MFILL_ATOMIC_COPY) {
 			page_kaddr = kmap_local_folio(folio, 0);
 			/*
 			 * The read mmap_lock is held here.  Despite the
@@ -2510,7 +2509,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       &folio->page, true, wp_copy);
+				       &folio->page, true, flags);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bd3542d5408f..c0d061acc069 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -58,7 +58,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 int mfill_atomic_install_pte(pmd_t *dst_pmd,
 			     struct vm_area_struct *dst_vma,
 			     unsigned long dst_addr, struct page *page,
-			     bool newly_allocated, bool wp_copy)
+			     bool newly_allocated, uffd_flags_t flags)
 {
 	int ret;
 	pte_t _dst_pte, *dst_pte;
@@ -76,7 +76,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 		writable = false;
 	if (writable)
 		_dst_pte = pte_mkwrite(_dst_pte);
-	if (wp_copy)
+	if (flags & MFILL_ATOMIC_WP)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
@@ -131,8 +131,8 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
-				 struct page **pagep,
-				 bool wp_copy)
+				 uffd_flags_t flags,
+				 struct page **pagep)
 {
 	void *page_kaddr;
 	int ret;
@@ -193,7 +193,7 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, true, wp_copy);
+				       page, true, flags);
 	if (ret)
 		goto out_release;
 out:
@@ -241,7 +241,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
-				     bool wp_copy)
+				     uffd_flags_t flags)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
@@ -267,7 +267,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	}
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, false, wp_copy);
+				       page, false, flags);
 	if (ret)
 		goto out_release;
 
@@ -312,9 +312,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode,
-					      bool wp_copy)
+					      uffd_flags_t flags)
 {
+	int mode = flags & MFILL_ATOMIC_MODE_MASK;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
@@ -333,7 +333,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
+	if (mode == MFILL_ATOMIC_ZEROPAGE) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -401,7 +401,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		if (mode != MCOPY_ATOMIC_CONTINUE &&
+		if (mode != MFILL_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
@@ -409,9 +409,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page,
-					       wp_copy);
+		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
+					       src_addr, flags, &page);
 
 		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -465,23 +464,22 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    enum mcopy_atomic_mode mode,
-				    bool wp_copy);
+				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **page,
-						enum mcopy_atomic_mode mode,
-						bool wp_copy)
+						struct page **pagep,
+						uffd_flags_t flags)
 {
+	int mode = flags & MFILL_ATOMIC_MODE_MASK;
 	ssize_t err;
 
-	if (mode == MCOPY_ATOMIC_CONTINUE) {
+	if (mode == MFILL_ATOMIC_CONTINUE) {
 		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
-						 dst_addr, wp_copy);
+						 dst_addr, flags);
 	}
 
 	/*
@@ -495,18 +493,17 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (mode == MCOPY_ATOMIC_NORMAL)
+		if (mode == MFILL_ATOMIC_COPY)
 			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
-						    dst_addr, src_addr, page,
-						    wp_copy);
+						    dst_addr, src_addr,
+						    flags, pagep);
 		else
 			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
-					     mode != MCOPY_ATOMIC_NORMAL,
-					     wp_copy, page);
+					     flags, pagep);
 	}
 
 	return err;
@@ -516,9 +513,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 					    unsigned long dst_start,
 					    unsigned long src_start,
 					    unsigned long len,
-					    enum mcopy_atomic_mode mcopy_mode,
 					    atomic_t *mmap_changing,
-					    __u64 mode)
+					    uffd_flags_t flags)
 {
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
@@ -526,7 +522,6 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	bool wp_copy;
 
 	/*
 	 * Sanitize the command parameters:
@@ -576,8 +571,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * validate 'mode' now that we know the dst_vma: don't allow
 	 * a wrprotect copy if the userfaultfd didn't register as WP.
 	 */
-	wp_copy = mode & UFFDIO_COPY_MODE_WP;
-	if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
 		goto out_unlock;
 
 	/*
@@ -585,12 +579,12 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, mcopy_mode,
-					     wp_copy);
+					     src_start, len, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) &&
+	    (flags & MFILL_ATOMIC_MODE_MASK) == MFILL_ATOMIC_CONTINUE)
 		goto out_unlock;
 
 	/*
@@ -638,7 +632,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, mcopy_mode, wp_copy);
+				       src_addr, &page, flags);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
@@ -686,24 +680,24 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 
 ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
 			  unsigned long src_start, unsigned long len,
-			  atomic_t *mmap_changing, __u64 mode)
+			  atomic_t *mmap_changing, uffd_flags_t flags)
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
 
 long uffd_wp_range(struct vm_area_struct *dst_vma,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

