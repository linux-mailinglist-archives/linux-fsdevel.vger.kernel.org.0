Return-Path: <linux-fsdevel+bounces-10838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3648884EA74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D76B2A082
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81141524B5;
	Thu,  8 Feb 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMQ5kJHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72351C4C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427343; cv=none; b=SHJps1FfXcwp5ZfnL0Ry00T07vZe1eiP6nhKO5AlliaVRhe1tgJuhYMDZJmSd03v0QCHONuuGCO00H6f5iEHvmNe5UKuSaJ8NXGQZQD39FAIvw4TxZcsioPhw1YG3sRC17pCFsiH5n+lWJ1CT6mEpsU2GPC1W1Cj6sqwExG1+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427343; c=relaxed/simple;
	bh=wKU9ZTRfRhtwoVS8qEPNFAReB6efUPZkYLv+WBQAEfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Su1dVBip1sq0qYVhPVy5IR44zaWVNgyWA6j2vcXtkx6XtIuE1lJUhr3n9SuaV0IMLgFR5yAWUUgS2qwTwQ3US+Z5QL6LOyoLRW3IE/4aZuQGhDmu5rLohmpETFvYRN4nFz1D9TpKpja9pot5hrUMp81HHl6xSkFJ8ihdWCdceTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMQ5kJHR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047f0741e2so5686977b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707427340; x=1708032140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t75SKxYdfQlCW6bpie1fAW4ju+PGfumrxcdqts4g8gw=;
        b=iMQ5kJHR1gghC1/9dWsaIVZYTPB9dIKL7J6Qg0vU1cmCp6q4dNClNbqn/g03TZ7IYH
         NelYENBKt0YhoLQu7OsHNSrfqcKCKtCHV9hvb+v27ZrJMBvcO6r9TYWQY+omheh+Pzhx
         205ybj9Qhc/fHHhAlgMl/hICv/2fV3Poyo+AifMJKIWl2n+uge8QfmRLHpEfYMo2xEVY
         TSBbkPnXnwKxMTrppB5aiubo3jfiw6aKrrUKcyPL4Em1DdUQsznEQoNb1ePDKlZReeqd
         V5zKquiSsyAcYyg1pJ5cOSZnpxnvOqXfOWG+LaPfdOXA6goslKE6HRnNUB1vo/TMZFU6
         fAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427340; x=1708032140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t75SKxYdfQlCW6bpie1fAW4ju+PGfumrxcdqts4g8gw=;
        b=luMPqajBNALU0e+7l756A3E/evoVEF3m0KZQNR4vv+agUpNH8wRwRPc1Zcwyj6WDK4
         BuWYiodX8v86LhKwzNSOw2emeahG7AU6D1G5G1tAgIpN1dFYxSX3+k/m/7Lv4LuD8hC9
         +J/PfndcI3pLtzVEkaruZ01QV6q+09HpJxwFx7chJYEmyfYRHfPOcoTL7ZRuMcbGbG9w
         p2k4HBIZfIVNlhh4WjSva7TB+xJDDskm3guShBp29twwAeFIZlv7kDW/GBOa53soUdM6
         2xO5zUoDz6k1YmBdg7YD1NNYNXPf3Ur67VHPZEpKMUo+RlHPR9WJahTMypv8ZQZpQIVx
         JOsg==
X-Gm-Message-State: AOJu0YzbLnFO4hKs95Z9tzYqnbl9YWFZBvcYJlRT2KUlTlTJEQxnuoME
	bcvgSPX0NYPlFsnDYqFOH9Ka0rdwd2Xk6bH3tbuWtN8/9ZMWB/k4bfJOkyqW96XTy60byGVjnpo
	yb7ZpLGgtG06HHvLJDwgB+w==
X-Google-Smtp-Source: AGHT+IFAIVJj1WYfDvCAzIltMCiiv0Q1ue38dCbij931BC4Jbgs1PrxtKM7Z6HsgiVUMnFVeZrVZNb8xsxAHJCEJNQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:e9ba:42a8:6aba:f5d5])
 (user=lokeshgidra job=sendgmr) by 2002:a81:49c9:0:b0:5e8:bea4:4d3b with SMTP
 id w192-20020a8149c9000000b005e8bea44d3bmr93963ywa.6.1707427339968; Thu, 08
 Feb 2024 13:22:19 -0800 (PST)
Date: Thu,  8 Feb 2024 13:22:04 -0800
In-Reply-To: <20240208212204.2043140-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208212204.2043140-4-lokeshgidra@google.com>
Subject: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd operations
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
 include/linux/userfaultfd_k.h |   5 +-
 mm/userfaultfd.c              | 356 ++++++++++++++++++++++++++--------
 3 files changed, 275 insertions(+), 99 deletions(-)

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
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74aad0831e40..1e25768b2136 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -19,20 +19,12 @@
 #include <asm/tlb.h>
 #include "internal.h"
 
-static __always_inline
-struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+static bool validate_dst_vma(struct vm_area_struct *dst_vma,
+			     unsigned long dst_end)
 {
-	/*
-	 * Make sure that the dst range is both valid and fully within a
-	 * single existing vma.
-	 */
-	struct vm_area_struct *dst_vma;
-
-	dst_vma = find_vma(dst_mm, dst_start);
-	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
-		return NULL;
+	/* Make sure that the dst range is fully within dst_vma. */
+	if (dst_end > dst_vma->vm_end)
+		return false;
 
 	/*
 	 * Check the vma is registered in uffd, this is required to
@@ -40,11 +32,125 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		return NULL;
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PER_VMA_LOCK
+/*
+ * lock_vma() - Lookup and lock vma corresponding to @address.
+ * @mm: mm to search vma in.
+ * @address: address that the vma should contain.
+ * @prepare_anon: If true, then prepare the vma (if private) with anon_vma.
+ *
+ * Should be called without holding mmap_lock. vma should be unlocked after use
+ * with unlock_vma().
+ *
+ * Return: A locked vma containing @address, NULL if no vma is found, or
+ * -ENOMEM if anon_vma couldn't be allocated.
+ */
+static struct vm_area_struct *lock_vma(struct mm_struct *mm,
+				       unsigned long address,
+				       bool prepare_anon)
+{
+	struct vm_area_struct *vma;
+
+	vma = lock_vma_under_rcu(mm, address);
+	if (vma) {
+		/*
+		 * lock_vma_under_rcu() only checks anon_vma for private
+		 * anonymous mappings. But we need to ensure it is assigned in
+		 * private file-backed vmas as well.
+		 */
+		if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
+		    !vma->anon_vma)
+			vma_end_read(vma);
+		else
+			return vma;
+	}
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, address);
+	if (vma) {
+		if (prepare_anon && !(vma->vm_flags & VM_SHARED) &&
+		    anon_vma_prepare(vma)) {
+			vma = ERR_PTR(-ENOMEM);
+		} else {
+			/*
+			 * We cannot use vma_start_read() as it may fail due to
+			 * false locked (see comment in vma_start_read()). We
+			 * can avoid that by directly locking vm_lock under
+			 * mmap_lock, which guarantees that nobody can lock the
+			 * vma for write (vma_start_write()) under us.
+			 */
+			down_read(&vma->vm_lock->lock);
+		}
+	}
+
+	mmap_read_unlock(mm);
+	return vma;
+}
+
+static void unlock_vma(struct vm_area_struct *vma)
+{
+	vma_end_read(vma);
+}
+
+static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct *dst_mm,
+						    unsigned long dst_start,
+						    unsigned long len)
+{
+	struct vm_area_struct *dst_vma;
+
+	/* Ensure anon_vma is assigned for private vmas */
+	dst_vma = lock_vma(dst_mm, dst_start, true);
+
+	if (!dst_vma)
+		return ERR_PTR(-ENOENT);
+
+	if (PTR_ERR(dst_vma) == -ENOMEM)
+		return dst_vma;
+
+	if (!validate_dst_vma(dst_vma, dst_start + len))
+		goto out_unlock;
 
 	return dst_vma;
+out_unlock:
+	unlock_vma(dst_vma);
+	return ERR_PTR(-ENOENT);
 }
 
+#else
+
+static struct vm_area_struct *lock_mm_and_find_dst_vma(struct mm_struct *dst_mm,
+						       unsigned long dst_start,
+						       unsigned long len)
+{
+	struct vm_area_struct *dst_vma;
+	int err = -ENOENT;
+
+	mmap_read_lock(dst_mm);
+	dst_vma = vma_lookup(dst_mm, dst_start);
+	if (!dst_vma)
+		goto out_unlock;
+
+	/* Ensure anon_vma is assigned for private vmas */
+	if (!(dst_vma->vm_flags & VM_SHARED) && anon_vma_prepare(dst_vma)) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	if (!validate_dst_vma(dst_vma, dst_start + len))
+		goto out_unlock;
+
+	return dst_vma;
+out_unlock:
+	mmap_read_unlock(dst_mm);
+	return ERR_PTR(err);
+}
+#endif
+
 /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
 static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr)
@@ -350,7 +456,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
- * called with mmap_lock held, it will release mmap_lock before returning.
+ * called with either vma-lock or mmap_lock held, it will release the lock
+ * before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct userfaultfd_ctx *ctx,
@@ -361,7 +468,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
@@ -380,7 +486,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		up_read(&ctx->map_changing_lock);
+#ifdef CONFIG_PER_VMA_LOCK
+		unlock_vma(dst_vma);
+#else
 		mmap_read_unlock(dst_mm);
+#endif
 		return -EINVAL;
 	}
 
@@ -403,24 +513,32 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * retry, dst_vma will be set to NULL and we must lookup again.
 	 */
 	if (!dst_vma) {
+#ifdef CONFIG_PER_VMA_LOCK
+		dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
+#else
+		dst_vma = lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
+#endif
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
-
-		vm_shared = dst_vma->vm_flags & VM_SHARED;
-	}
+			goto out_unlock_vma;
 
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
 
@@ -465,7 +583,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
+#ifdef CONFIG_PER_VMA_LOCK
+			unlock_vma(dst_vma);
+#else
 			mmap_read_unlock(dst_mm);
+#endif
 			BUG_ON(!folio);
 
 			err = copy_folio_from_user(folio,
@@ -474,17 +596,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
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
@@ -505,7 +616,12 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
+out_unlock_vma:
+#ifdef CONFIG_PER_VMA_LOCK
+	unlock_vma(dst_vma);
+#else
 	mmap_read_unlock(dst_mm);
+#endif
 out:
 	if (folio)
 		folio_put(folio);
@@ -597,7 +713,19 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	copied = 0;
 	folio = NULL;
 retry:
-	mmap_read_lock(dst_mm);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+#ifdef CONFIG_PER_VMA_LOCK
+	dst_vma = find_and_lock_dst_vma(dst_mm, dst_start, len);
+#else
+	dst_vma = lock_mm_and_find_dst_vma(dst_mm, dst_start, len);
+#endif
+	if (IS_ERR(dst_vma)) {
+		err = PTR_ERR(dst_vma);
+		goto out;
+	}
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -609,15 +737,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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
@@ -647,16 +766,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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
 
@@ -699,7 +808,11 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
+#ifdef CONFIG_PER_VMA_LOCK
+			unlock_vma(dst_vma);
+#else
 			mmap_read_unlock(dst_mm);
+#endif
 			BUG_ON(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
@@ -730,7 +843,11 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
+#ifdef CONFIG_PER_VMA_LOCK
+	unlock_vma(dst_vma);
+#else
 	mmap_read_unlock(dst_mm);
+#endif
 out:
 	if (folio)
 		folio_put(folio);
@@ -1267,16 +1384,67 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
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
+static int find_and_lock_vmas(struct mm_struct *mm,
+			      unsigned long dst_start,
+			      unsigned long src_start,
+			      struct vm_area_struct **dst_vmap,
+			      struct vm_area_struct **src_vmap)
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
+	unlock_vma(*src_vmap);
+	return err;
 }
+#else
+static int lock_mm_and_find_vmas(struct mm_struct *mm,
+				 unsigned long dst_start,
+				 unsigned long src_start,
+				 struct vm_area_struct **dst_vmap,
+				 struct vm_area_struct **src_vmap)
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
+	if (vma_is_anonymous(*dst_vmap) && anon_vma_prepare(*dst_vmap))
+		goto out_unlock;
+
+	return 0;
+out_unlock:
+	mmap_read_unlock(mm);
+	return err;
+}
+#endif
 
 /**
  * move_pages - move arbitrary anonymous pages of an existing vma
@@ -1287,8 +1455,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * @len: length of the virtual memory range
  * @mode: flags from uffdio_move.mode
  *
- * Must be called with mmap_lock held for read.
- *
  * move_pages() remaps arbitrary anonymous pages atomically in zero
  * copy. It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
@@ -1355,10 +1521,10 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
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
@@ -1376,28 +1542,40 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	    WARN_ON_ONCE(dst_start + len <= dst_start))
 		goto out;
 
+#ifdef CONFIG_PER_VMA_LOCK
+	err = find_and_lock_vmas(mm, dst_start, src_start,
+				 &dst_vma, &src_vma);
+#else
+	err = lock_mm_and_find_vmas(mm, dst_start, src_start,
+				    &dst_vma, &src_vma);
+#endif
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
@@ -1514,6 +1692,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 		moved += step_size;
 	}
 
+out_unlock:
+	up_read(&ctx->map_changing_lock);
+#ifdef CONFIG_PER_VMA_LOCK
+	unlock_vma(dst_vma);
+	unlock_vma(src_vma);
+#else
+	mmap_read_unlock(mm);
+#endif
 out:
 	VM_WARN_ON(moved < 0);
 	VM_WARN_ON(err > 0);
-- 
2.43.0.687.g38aa6559b0-goog


