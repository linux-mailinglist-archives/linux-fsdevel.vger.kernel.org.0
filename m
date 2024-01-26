Return-Path: <linux-fsdevel+bounces-9092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1583E15B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557C4B24580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A321356;
	Fri, 26 Jan 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXfr0lCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0B20DD9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293617; cv=none; b=tfnDoT4vY/u+yYlBxrjcHqNEkDnd7hCB69ZQLmaaTvvzIYPL9fz6tO46rc5jb5Fh0n+7SDIIXV9LczBsg84NZ6jdUd+tCRqyaulyXaDHfuUyB2STmiUNR2i7ooPgW0oABTC7BrUONEtfLEOs0r4OZra2vhpfhaqwFg7GVEIGNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293617; c=relaxed/simple;
	bh=o3RxoKEoGAMsrFl/gj9m84T613VSvhnEZzjCZFnZK5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p0LekUa7621oROPb2KxARiv+BcKCiHIyG+4ucoDH+I/3u5/DWe49YO4z8JDUQXkhqvxF5ZAE1P1gVLyVY17PFEq7AT1EAlVxx8LFLAGreqnHukrMm2ARfBwNXul4lXEoEMk4/LSFImGLMsJQnA1jQCTC7I92cBSxFGQUQCKWW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXfr0lCV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff7cf2fd21so6533527b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706293614; x=1706898414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLXJpcEgAvHLQ8+bquI5HaOs2SY4k/xeWqEkBYhbiw0=;
        b=QXfr0lCVIA/VWR19QIkaqlJkq8DXwIi5BAHiN3i9TzKydxcpI9JpYzh3zE/OYgvhST
         ekPXAzomBtsYWAQisdLWTb9ZL/DScyTu5farAiMxpNa/Q1R+0YGZTzEvPkpZFEaH0CnV
         YGtRwOaeKDjcf2kPtuN++PGFa5Fg8hWPV4e3HCV8D99OKuwpobExWMrtb/YOhEXXT2jO
         PCb+e/+jesiHRofWIFNF87/1azNVyhBZyJMIIauvvOoir5TfVRx1E2ruSz4dt5n8cBQg
         d9WBI7b4FNDzrPqgs4kLbY0SeAcvaQDNSldkunF3XGbAAgIIyy0af2GxDPV6BQY8WfmT
         WRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293614; x=1706898414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLXJpcEgAvHLQ8+bquI5HaOs2SY4k/xeWqEkBYhbiw0=;
        b=JAtmld5hprCzOD+kTtIND7Xj86/mevZeoGF/BvLY0TtHaBthqaDVHBwOQFMzoHGncA
         JOrPDXtO3kykNn7h7vQ0YLyJG8Qm4kBJE5N4ObG/8Jfg6GxxrHTy72N6O7zN4z2zklOS
         jbWbGjdeZjoU2IoPuwZoAsqzu1eR1t7cpZ1DyErkbTaxe84GCaOU+XbrUtkb7bl1Yagv
         5Mp8anuTF9O4WZpjrgJPrxuSMu8DN1a6I1eAjMw80KS3ELBy1MzmJzyt0zMMeTfNAlt0
         gmIzhXXOtuM+QNZODkdqs0Adg8ckHaFfR8Po4GlFXK1u6nun2LjAZrwj0N3+hxCX1aXM
         aECA==
X-Gm-Message-State: AOJu0Yzp8iPeBDB0jH8MltjyznkZS7yDZAviXGhCBKk4dVeHHyCuWmtF
	sAEXYqymI+IQ6Kah4F6K7Ri3XrETYsLKiHB33vrsbRgM+fY/E7OPzOrxzI5Bjc+Q7b5xVC6aKr1
	X+7hVQaLUIjcaJoHJQ+UpLw==
X-Google-Smtp-Source: AGHT+IGt2/BA8dj3t3+f3CDFRNY8WvXgtUOL2IcXoo5TOnIKymbSZPVcMF8fo+tUfgFLJ3Qz79dJcQPFBkAu0Cw8KQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:cc8a:c6c9:a475:ebf])
 (user=lokeshgidra job=sendgmr) by 2002:a81:4cd3:0:b0:5fc:7f94:da64 with SMTP
 id z202-20020a814cd3000000b005fc7f94da64mr95373ywa.5.1706293614376; Fri, 26
 Jan 2024 10:26:54 -0800 (PST)
Date: Fri, 26 Jan 2024 10:26:47 -0800
In-Reply-To: <20240126182647.2748949-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126182647.2748949-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126182647.2748949-3-lokeshgidra@google.com>
Subject: [PATCH 3/3] userfaultfd: use per-vma locks in userfaultfd operations
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) has shown significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently.

We can use per-vma locks instead to significantly reduce the contention
issue. All userfaultfd operations, except write-protect, opportunistically
use per-vma locks to lock vmas. Write-protect operation requires mmap_lock
as it iterates over multiple vmas.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c |  14 +----
 mm/userfaultfd.c | 160 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 117 insertions(+), 57 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5aaf248d3107..faa10ed3788f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2005,18 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
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
-			ret = -EINVAL;
-		up_read(&ctx->map_changing_lock);
-
-		mmap_read_unlock(mm);
+		ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
+				 uffdio_move.len, uffdio_move.mode);
 		mmput(mm);
 	} else {
 		return -ESRCH;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a66b4d62a361..9be643308f05 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -19,20 +19,39 @@
 #include <asm/tlb.h>
 #include "internal.h"
 
-static __always_inline
-struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+void unpin_vma(struct mm_struct *mm, struct vm_area_struct *vma, bool *mmap_locked)
+{
+	BUG_ON(!vma && !*mmap_locked);
+
+	if (*mmap_locked) {
+		mmap_read_unlock(mm);
+		*mmap_locked = false;
+	} else
+		vma_end_read(vma);
+}
+
+/*
+ * Search for VMA and make sure it is stable either by locking it or taking
+ * mmap_lock.
+ */
+struct vm_area_struct *find_and_pin_dst_vma(struct mm_struct *dst_mm,
+					    unsigned long dst_start,
+					    unsigned long len,
+					    bool *mmap_locked)
 {
+	struct vm_area_struct *dst_vma = lock_vma_under_rcu(dst_mm, dst_start);
+	if (!dst_vma) {
+		mmap_read_lock(dst_mm);
+		*mmap_locked = true;
+		dst_vma = find_vma(dst_mm, dst_start);
+	}
+
 	/*
 	 * Make sure that the dst range is both valid and fully within a
 	 * single existing vma.
 	 */
-	struct vm_area_struct *dst_vma;
-
-	dst_vma = find_vma(dst_mm, dst_start);
 	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
-		return NULL;
+		goto unpin;
 
 	/*
 	 * Check the vma is registered in uffd, this is required to
@@ -40,9 +59,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		return NULL;
+		goto unpin;
 
 	return dst_vma;
+
+unpin:
+	unpin_vma(dst_mm, dst_vma, mmap_locked);
+	return NULL;
 }
 
 /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
@@ -350,7 +373,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
- * called with mmap_lock held, it will release mmap_lock before returning.
+ * called with either vma-lock or mmap_lock held, it will release the lock
+ * before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct userfaultfd_ctx *ctx,
@@ -358,7 +382,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      uffd_flags_t flags)
+					      uffd_flags_t flags,
+					      bool *mmap_locked)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -380,7 +405,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(dst_mm);
+		unpin_vma(dst_mm, dst_vma, mmap_locked);
 		return -EINVAL;
 	}
 
@@ -404,12 +429,25 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (!dst_vma) {
 		err = -ENOENT;
-		dst_vma = find_dst_vma(dst_mm, dst_start, len);
-		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
-			goto out_unlock;
+		dst_vma = find_and_pin_dst_vma(dst_mm, dst_start,
+					       len, mmap_locked);
+		if (!dst_vma)
+			goto out;
+		if (!is_vm_hugetlb_page(dst_vma))
+			goto out_unlock_vma;
 
 		err = -EINVAL;
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
+			goto out_unlock_vma;
+
+		/*
+		 * If memory mappings are changing because of non-cooperative
+		 * operation (e.g. mremap) running in parallel, bail out and
+		 * request the user to retry later
+		 */
+		down_read(&ctx->map_changing_lock);
+		err = -EAGAIN;
+		if (atomic_read(&ctx->mmap_changing))
 			goto out_unlock;
 
 		vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unpin_vma(dst_mm, dst_vma, mmap_locked);
 			BUG_ON(!folio);
 
 			err = copy_folio_from_user(folio,
@@ -474,8 +512,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				err = -EFAULT;
 				goto out;
 			}
-			mmap_read_lock(dst_mm);
-			down_read(&ctx->map_changing_lock);
 
 			dst_vma = NULL;
 			goto retry;
@@ -496,7 +532,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+out_unlock_vma:
+	unpin_vma(dst_mm, dst_vma, mmap_locked);
 out:
 	if (folio)
 		folio_put(folio);
@@ -512,7 +549,8 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    uffd_flags_t flags);
+				    uffd_flags_t flags,
+				    bool *mmap_locked);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
@@ -572,6 +610,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct folio *folio;
+	bool mmap_locked = false;
 
 	/*
 	 * Sanitize the command parameters:
@@ -588,7 +627,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	copied = 0;
 	folio = NULL;
 retry:
-	mmap_read_lock(dst_mm);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	err = -ENOENT;
+	dst_vma = find_and_pin_dst_vma(dst_mm, dst_start, len, &mmap_locked);
+	if (!dst_vma)
+		goto out;
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -600,15 +646,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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
@@ -629,8 +666,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start, src_start
+					     len, flags, &mmap_locked);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -690,7 +727,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unpin_vma(dst_mm, dst_vma, &mmap_locked);
+
 			BUG_ON(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
@@ -721,7 +759,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+	unpin_vma(dst_mm, dst_vma, &mmap_locked);
 out:
 	if (folio)
 		folio_put(folio);
@@ -1243,8 +1281,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * @len: length of the virtual memory range
  * @mode: flags from uffdio_move.mode
  *
- * Must be called with mmap_lock held for read.
- *
  * move_pages() remaps arbitrary anonymous pages atomically in zero
  * copy. It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
@@ -1320,6 +1356,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	pmd_t *src_pmd, *dst_pmd;
 	long err = -EINVAL;
 	ssize_t moved = 0;
+	bool mmap_locked = false;
 
 	/* Sanitize the command parameters. */
 	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
@@ -1332,28 +1369,52 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	    WARN_ON_ONCE(dst_start + len <= dst_start))
 		goto out;
 
+	dst_vma = NULL;
+	src_vma = lock_vma_under_rcu(mm, src_start);
+	if (src_vma) {
+		dst_vma = lock_vma_under_rcu(mm, dst_start);
+		if (!dst_vma)
+			vma_end_read(src_vma);
+	}
+
+	/* If we failed to lock both VMAs, fall back to mmap_lock */
+	if (!dst_vma) {
+		mmap_read_lock(mm);
+		mmap_locked = true;
+		src_vma = find_vma(mm, src_start);
+		if (!src_vma)
+			goto out_unlock_mmap;
+		dst_vma = find_vma(mm, dst_start);
+		if (!dst_vma)
+			goto out_unlock_mmap;
+	}
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
+	if (src_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
 	if (src_start < src_vma->vm_start ||
 	    src_start + len > src_vma->vm_end)
-		goto out;
+		goto out_unlock;
 
-	dst_vma = find_vma(mm, dst_start);
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
-		goto out;
+	if (dst_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
 	if (dst_start < dst_vma->vm_start ||
 	    dst_start + len > dst_vma->vm_end)
-		goto out;
+		goto out_unlock;
 
 	err = validate_move_areas(ctx, src_vma, dst_vma);
 	if (err)
-		goto out;
+		goto out_unlock;
 
 	for (src_addr = src_start, dst_addr = dst_start;
 	     src_addr < src_start + len;) {
@@ -1475,6 +1536,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 		moved += step_size;
 	}
 
+out_unlock:
+	up_read(&ctx->map_changing_lock);
+out_unlock_mmap:
+	if (mmap_locked)
+		mmap_read_unlock(mm);
+	else {
+		vma_end_read(dst_vma);
+		vma_end_read(src_vma);
+	}
 out:
 	VM_WARN_ON(moved < 0);
 	VM_WARN_ON(err > 0);
-- 
2.43.0.429.g432eaa2c6b-goog


