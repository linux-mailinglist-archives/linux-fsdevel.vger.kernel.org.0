Return-Path: <linux-fsdevel+bounces-10406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44484AB6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07451C239F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998994A0C;
	Tue,  6 Feb 2024 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhIySEU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FC6FB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181801; cv=none; b=p2tz0aikkJpKBW/TxF0SKayF0+Qec37IETL8jefCa72ys/AyYI1M/xb+troUenotZquwjLb3JllqHnU+oHYXcGLefUEjZUO/XK00P/88ib9f3aIPxWdOGWPXSBpcuSd4c79JM812a7arOv1i9AcRL6pNoqjTGC3HInsUdLXMG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181801; c=relaxed/simple;
	bh=et1bk2HClvxxx+KlnYCYoJxbCpB22sDtDyEdKKTZUY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=My0W1q/xDVgH5sCDDxk3pk2VubnZ+TgDDVWO7HR1CnLdtz2mwXK7xd8gTB9pMEQPRgRb6LlLWQdKlVrgpqi1E2jn8lF351+Go9b73zQaNpaKVVcJWd73VcYvW3oYx6w+my6qEhzQOrusfDzCi2fN5i/BgAY60O3rs9aMmxwe9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhIySEU6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040a34c24bso6318027b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181798; x=1707786598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqm5rsZhzJMvjR9+dAhD+eAWB3F8dZk7DoU+bZxnlo=;
        b=NhIySEU6evwVfhRcDqh/yRLLNAQ444JW1YiT7baNb/pe4a21Q6ByNwLRV/8eevtFzH
         GRjodO6oCUkEaOqErqczmia7dipf7mIAXhZ6E91CLb5My67MH02/Ul5CBwFKXlE7uy0R
         Z1dydJqE7Qd0yniNv839F10PC3Jem3Jy5hAsPMR0F8DpTx1jpdb4EOLZkSF1TqCBBlJS
         g9a0EC56QyDWRqmNaHFdXfwvrTchjagyE0YVOOxErqK3TQZ/SQmCowTEVpZMJ0DL/kuP
         Dmgxyo/HGepJLMlfqBV2Hw14Dw+F25L9mTQAlHyOEAkL7+fbgX8SBxjiJymiHG1t2dIS
         kj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181798; x=1707786598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqm5rsZhzJMvjR9+dAhD+eAWB3F8dZk7DoU+bZxnlo=;
        b=LKyWESg5VBnQhOoTr1/MSN4X49zR/gxPIUsGDE4ROu26Blml7an4v+lhBVZDuAsIlr
         amAkvh3lBPto9lcv2sTnQ4ZXyg0ThqNel7oBixHGRlll3gv2Rg74bhTF3SQPWoZVy+JK
         O4hGXXtdtxuR5CdWPNYkvGy5jCwhCqhbXUbjIVApJvMVtDVDvMVTf5HZdxGWFGnTIE2d
         HdPzLOxkxAAaurYKXwyzkBz3tFSdx8tsU7rV6LQ48tnvUsDTdf1jdeaQkjtQeIOqxwaE
         eu1QmfB/k98qdmaRUsaSbsvJAgdory6/eQlR4GKPN4mMBClUCvpTwDCagn5FvEJkm2F6
         u6dA==
X-Gm-Message-State: AOJu0YxSI6kJCiOkItCF4p3jlMnpErWXpLTSR1MLryqSBAPAxg5EUs4l
	wo2XThKEqRDh4NEnC1EfvIIm3dEMWavCzm3WuEwbYjsu7e70BfrlxrXsAWI4mgs/V7caS9UKZiR
	8ByJNKr9TDZN9v5a0wjwVQQ==
X-Google-Smtp-Source: AGHT+IFYxfY6Ge56ali6DMQRIXX2ISa1rBsLQcS+PmAp5ZBB9lJ2RO73M/vP9jb/DuDtls5ONW17Z8++ijURLhrH/Q==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:713:bb2c:e0e8:becb])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:1b06:b0:dc2:3247:89d5 with
 SMTP id eh6-20020a0569021b0600b00dc2324789d5mr7221ybb.4.1707181798107; Mon,
 05 Feb 2024 17:09:58 -0800 (PST)
Date: Mon,  5 Feb 2024 17:09:19 -0800
In-Reply-To: <20240206010919.1109005-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206010919.1109005-4-lokeshgidra@google.com>
Subject: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd operations
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

All userfaultfd operations, except write-protect, opportunistically use
per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
critical section.

Write-protect operation requires mmap_lock as it iterates over multiple
vmas.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c              |  13 +-
 include/linux/mm.h            |  16 +++
 include/linux/userfaultfd_k.h |   5 +-
 mm/memory.c                   |  48 +++++++
 mm/userfaultfd.c              | 242 +++++++++++++++++++++-------------
 5 files changed, 222 insertions(+), 102 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index c00a021bcce4..60dcfafdc11a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 		return -EINVAL;
 
 	if (mmget_not_zero(mm)) {
-		mmap_read_lock(mm);
-
-		/* Re-check after taking map_changing_lock */
-		down_read(&ctx->map_changing_lock);
-		if (likely(!atomic_read(&ctx->mmap_changing)))
-			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
-					 uffdio_move.len, uffdio_move.mode);
-		else
-			ret = -EAGAIN;
-		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(mm);
+		ret = move_pages(ctx, uffdio_move.dst, uffdio_move.src,
+				 uffdio_move.len, uffdio_move.mode);
 		mmput(mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d1f98ab0c72..e69dfe2edcce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -753,6 +753,11 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline void unlock_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	vma_end_read(vma);
+}
+
 static inline void assert_fault_locked(struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
@@ -774,6 +779,9 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
+static inline void vma_acquire_read_lock(struct vm_area_struct *vma) {
+	mmap_assert_locked(vma->vm_mm);
+}
 
 static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		unsigned long address)
@@ -786,6 +794,11 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline void unlock_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	mmap_read_unlock(mm);
+}
+
 static inline void assert_fault_locked(struct vm_fault *vmf)
 {
 	mmap_assert_locked(vmf->vma->vm_mm);
@@ -794,6 +807,9 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 #endif /* CONFIG_PER_VMA_LOCK */
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern struct vm_area_struct *lock_vma(struct mm_struct *mm,
+				       unsigned long address,
+				       bool prepare_anon);
 
 /*
  * WARNING: vma_init does not initialize vma->vm_lock.
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3210c3552976..05d59f74fc88 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vma,
 /* move_pages */
 void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
 void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
-ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
-		   unsigned long dst_start, unsigned long src_start,
-		   unsigned long len, __u64 flags);
+ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+		   unsigned long src_start, unsigned long len, __u64 flags);
 int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
 			struct vm_area_struct *dst_vma,
 			struct vm_area_struct *src_vma,
diff --git a/mm/memory.c b/mm/memory.c
index b05fd28dbce1..393ab3b0d6f3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5760,8 +5760,56 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);
 	return NULL;
 }
+
+static void vma_acquire_read_lock(struct vm_area_struct *vma)
+{
+	/*
+	 * We cannot use vma_start_read() as it may fail due to false locked
+	 * (see comment in vma_start_read()). We can avoid that by directly
+	 * locking vm_lock under mmap_lock, which guarantees that nobody could
+	 * have locked the vma for write (vma_start_write()).
+	 */
+	mmap_assert_locked(vma->vm_mm);
+	down_read(&vma->vm_lock->lock);
+}
 #endif /* CONFIG_PER_VMA_LOCK */
 
+/*
+ * lock_vma() - Lookup and lock VMA corresponding to @address.
+ * @prepare_anon: If true, then prepare the VMA (if anonymous) with anon_vma.
+ *
+ * Should be called without holding mmap_lock. VMA should be unlocked after use
+ * with unlock_vma().
+ *
+ * Return: A locked VMA containing @address, NULL of no VMA is found, or
+ * -ENOMEM if anon_vma couldn't be allocated.
+ */
+struct vm_area_struct *lock_vma(struct mm_struct *mm,
+				unsigned long address,
+				bool prepare_anon)
+{
+	struct vm_area_struct *vma;
+
+	vma = lock_vma_under_rcu(mm, address);
+
+	if (vma)
+		return vma;
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, address);
+	if (vma) {
+		if (prepare_anon && vma_is_anonymous(vma) &&
+		    anon_vma_prepare(vma))
+			vma = ERR_PTR(-ENOMEM);
+		else
+			vma_acquire_read_lock(vma);
+	}
+
+	if (IS_ENABLED(CONFIG_PER_VMA_LOCK) || !vma || PTR_ERR(vma) == -ENOMEM)
+		mmap_read_unlock(mm);
+	return vma;
+}
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74aad0831e40..64e22e467e4f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -19,20 +19,25 @@
 #include <asm/tlb.h>
 #include "internal.h"
 
-static __always_inline
-struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+/* Search for VMA and make sure it is valid. */
+static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *dst_mm,
+						    unsigned long dst_start,
+						    unsigned long len)
 {
-	/*
-	 * Make sure that the dst range is both valid and fully within a
-	 * single existing vma.
-	 */
 	struct vm_area_struct *dst_vma;
 
-	dst_vma = find_vma(dst_mm, dst_start);
-	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
-		return NULL;
+	/* Ensure anon_vma is assigned for anonymous vma */
+	dst_vma = lock_vma(dst_mm, dst_start, true);
+
+	if (!dst_vma)
+		return ERR_PTR(-ENOENT);
+
+	if (PTR_ERR(dst_vma) == -ENOMEM)
+		return dst_vma;
+
+	/* Make sure that the dst range is fully within dst_vma. */
+	if (dst_start + len > dst_vma->vm_end)
+		goto out_unlock;
 
 	/*
 	 * Check the vma is registered in uffd, this is required to
@@ -40,9 +45,12 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		return NULL;
+		goto out_unlock;
 
 	return dst_vma;
+out_unlock:
+	unlock_vma(dst_mm, dst_vma);
+	return ERR_PTR(-ENOENT);
 }
 
 /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
@@ -350,7 +358,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
- * called with mmap_lock held, it will release mmap_lock before returning.
+ * called with either vma-lock or mmap_lock held, it will release the lock
+ * before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct userfaultfd_ctx *ctx,
@@ -361,7 +370,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
@@ -380,7 +388,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(dst_mm);
+		unlock_vma(dst_mm, dst_vma);
 		return -EINVAL;
 	}
 
@@ -403,24 +411,28 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * retry, dst_vma will be set to NULL and we must lookup again.
 	 */
 	if (!dst_vma) {
+		dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
+		if (IS_ERR(dst_vma)) {
+			err = PTR_ERR(dst_vma);
+			goto out;
+		}
+
 		err = -ENOENT;
-		dst_vma = find_dst_vma(dst_mm, dst_start, len);
-		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
-			goto out_unlock;
+		if (!is_vm_hugetlb_page(dst_vma))
+			goto out_unlock_vma;
 
 		err = -EINVAL;
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
-			goto out_unlock;
+			goto out_unlock_vma;
 
-		vm_shared = dst_vma->vm_flags & VM_SHARED;
-	}
-
-	/*
-	 * If not shared, ensure the dst_vma has a anon_vma.
-	 */
-	err = -ENOMEM;
-	if (!vm_shared) {
-		if (unlikely(anon_vma_prepare(dst_vma)))
+		/*
+		 * If memory mappings are changing because of non-cooperative
+		 * operation (e.g. mremap) running in parallel, bail out and
+		 * request the user to retry later
+		 */
+		down_read(&ctx->map_changing_lock);
+		err = -EAGAIN;
+		if (atomic_read(&ctx->mmap_changing))
 			goto out_unlock;
 	}
 
@@ -465,7 +477,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unlock_vma(dst_mm, dst_vma);
 			BUG_ON(!folio);
 
 			err = copy_folio_from_user(folio,
@@ -474,17 +486,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				err = -EFAULT;
 				goto out;
 			}
-			mmap_read_lock(dst_mm);
-			down_read(&ctx->map_changing_lock);
-			/*
-			 * If memory mappings are changing because of non-cooperative
-			 * operation (e.g. mremap) running in parallel, bail out and
-			 * request the user to retry later
-			 */
-			if (atomic_read(&ctx->mmap_changing)) {
-				err = -EAGAIN;
-				break;
-			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -505,7 +506,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+out_unlock_vma:
+	unlock_vma(dst_mm, dst_vma);
 out:
 	if (folio)
 		folio_put(folio);
@@ -597,7 +599,15 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	copied = 0;
 	folio = NULL;
 retry:
-	mmap_read_lock(dst_mm);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
+	if (IS_ERR(dst_vma)) {
+		err = PTR_ERR(dst_vma);
+		goto out;
+	}
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -609,15 +619,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	err = -ENOENT;
-	dst_vma = find_dst_vma(dst_mm, dst_start, len);
-	if (!dst_vma)
-		goto out_unlock;
-
 	err = -EINVAL;
 	/*
 	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
@@ -647,16 +648,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
-	/*
-	 * Ensure the dst_vma has a anon_vma or this page
-	 * would get a NULL anon_vma when moved in the
-	 * dst_vma.
-	 */
-	err = -ENOMEM;
-	if (!(dst_vma->vm_flags & VM_SHARED) &&
-	    unlikely(anon_vma_prepare(dst_vma)))
-		goto out_unlock;
-
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 
@@ -699,7 +690,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unlock_vma(dst_mm, dst_vma);
+
 			BUG_ON(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
@@ -730,7 +722,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+	unlock_vma(dst_mm, dst_vma);
 out:
 	if (folio)
 		folio_put(folio);
@@ -1267,16 +1259,82 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
 	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
 		return -EINVAL;
 
-	/*
-	 * Ensure the dst_vma has a anon_vma or this page
-	 * would get a NULL anon_vma when moved in the
-	 * dst_vma.
-	 */
-	if (unlikely(anon_vma_prepare(dst_vma)))
-		return -ENOMEM;
+	return 0;
+}
+
+#ifdef CONFIG_PER_VMA_LOCK
+static int find_and_lock_move_vmas(struct mm_struct *mm,
+				   unsigned long dst_start,
+				   unsigned long src_start,
+				   struct vm_area_struct **dst_vmap,
+				   struct vm_area_struct **src_vmap)
+{
+	int err;
+
+	/* There is no need to prepare anon_vma for src_vma */
+	*src_vmap = lock_vma(mm, src_start, false);
+	if (!*src_vmap)
+		return -ENOENT;
+
+	/* Ensure anon_vma is assigned for anonymous vma */
+	*dst_vmap = lock_vma(mm, dst_start, true);
+	err = -ENOENT;
+	if (!*dst_vmap)
+		goto out_unlock;
+
+	err = -ENOMEM;
+	if (PTR_ERR(*dst_vmap) == -ENOMEM)
+		goto out_unlock;
 
 	return 0;
+out_unlock:
+	unlock_vma(mm, *src_vmap);
+	return err;
+}
+
+static void unlock_move_vmas(struct mm_struct *mm,
+			     struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma)
+{
+	unlock_vma(mm, dst_vma);
+	unlock_vma(mm, src_vma);
 }
+#else
+static int find_and_lock_move_vmas(struct mm_struct *mm,
+				   unsigned long dst_start,
+				   unsigned long src_start,
+				   struct vm_area_struct **dst_vmap,
+				   struct vm_area_struct **src_vmap)
+{
+	int err = -ENOENT;
+	mmap_read_lock(mm);
+
+	*src_vmap = vma_lookup(mm, src_start);
+	if (!*src_vmap)
+		goto out_unlock;
+
+	*dst_vmap = vma_lookup(mm, dst_start);
+	if (!*dst_vmap)
+		goto out_unlock;
+
+	/* Ensure anon_vma is assigned */
+	err = -ENOMEM;
+	if (vma_is_anonymous(*dst_vmap) && !anon_vma_prepare(*dst_vmap))
+		goto out_unlock;
+
+	return 0;
+out_unlock:
+	mmap_read_unlock(mm);
+	return err;
+}
+
+static void unlock_move_vmas(struct mm_struct *mm,
+			     struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma)
+{
+	mmap_read_unlock(mm);
+}
+#endif
 
 /**
  * move_pages - move arbitrary anonymous pages of an existing vma
@@ -1287,8 +1345,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * @len: length of the virtual memory range
  * @mode: flags from uffdio_move.mode
  *
- * Must be called with mmap_lock held for read.
- *
  * move_pages() remaps arbitrary anonymous pages atomically in zero
  * copy. It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
@@ -1355,10 +1411,10 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * could be obtained. This is the only additional complexity added to
  * the rmap code to provide this anonymous page remapping functionality.
  */
-ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
-		   unsigned long dst_start, unsigned long src_start,
-		   unsigned long len, __u64 mode)
+ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+		   unsigned long src_start, unsigned long len, __u64 mode)
 {
+	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *src_vma, *dst_vma;
 	unsigned long src_addr, dst_addr;
 	pmd_t *src_pmd, *dst_pmd;
@@ -1376,28 +1432,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	    WARN_ON_ONCE(dst_start + len <= dst_start))
 		goto out;
 
+	err = find_and_lock_move_vmas(mm, dst_start, src_start,
+				      &dst_vma, &src_vma);
+	if (err)
+		goto out;
+
+	/* Re-check after taking map_changing_lock */
+	down_read(&ctx->map_changing_lock);
+	if (likely(atomic_read(&ctx->mmap_changing))) {
+		err = -EAGAIN;
+		goto out_unlock;
+	}
 	/*
 	 * Make sure the vma is not shared, that the src and dst remap
 	 * ranges are both valid and fully within a single existing
 	 * vma.
 	 */
-	src_vma = find_vma(mm, src_start);
-	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
-		goto out;
-	if (src_start < src_vma->vm_start ||
-	    src_start + len > src_vma->vm_end)
-		goto out;
+	if (src_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
+	if (src_start + len > src_vma->vm_end)
+		goto out_unlock;
 
-	dst_vma = find_vma(mm, dst_start);
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
-		goto out;
-	if (dst_start < dst_vma->vm_start ||
-	    dst_start + len > dst_vma->vm_end)
-		goto out;
+	if (dst_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
+	if (dst_start + len > dst_vma->vm_end)
+		goto out_unlock;
 
 	err = validate_move_areas(ctx, src_vma, dst_vma);
 	if (err)
-		goto out;
+		goto out_unlock;
 
 	for (src_addr = src_start, dst_addr = dst_start;
 	     src_addr < src_start + len;) {
@@ -1514,6 +1577,9 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 		moved += step_size;
 	}
 
+out_unlock:
+	up_read(&ctx->map_changing_lock);
+	unlock_move_vmas(mm, dst_vma, src_vma);
 out:
 	VM_WARN_ON(moved < 0);
 	VM_WARN_ON(err > 0);
-- 
2.43.0.594.gd9cf4e227d-goog


