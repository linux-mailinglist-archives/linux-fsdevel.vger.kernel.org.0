Return-Path: <linux-fsdevel+bounces-10837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0684EA66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186801C244CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7E524A1;
	Thu,  8 Feb 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKVyr8Ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72451C23
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427341; cv=none; b=SGDMdm3at24WkoAryWG3dJXoJqJxyCSlDZm+AKOa+0wf5pSB+sWiLoXZv8hoea3jPs+fuX2PMPLks4Iw7PNZFlceA2q+MA1n3V2ytcNq8WjQ6u4yvXZX7Nxyi26UWpLl/uRw1fzP/QqDC9J4EdKXiFjXuD57Y8bBRn81zuYBVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427341; c=relaxed/simple;
	bh=In1FF0ynBqRiNE2uJuhiKoePMO53Q9NUdpdbPZmXlAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YFeBlPxha/EtlVQsgKHXt4kDDczCExafPnSxPSXfUHFw2yOKExS6kCRkYZyA4hzZlYaM1s+TF9UiKiEzLpZejbNaRN32hGQhnlsA6CTh0v+uXCD1EMpNP2iCfOIKgznhX7vHmLVAlapuCFYwa5aO5Ma5S+pJE0DfKpecddbLQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKVyr8Ft; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so5697057b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707427337; x=1708032137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSLmVkRgWUoN7XoRPV1r5JJdZzlBEVE8ndv4C2H5Jh8=;
        b=zKVyr8FtZGXLrOXI0ynq/yhdTRXfAK4ki8isgp2pG8+RCN+4ROhbBcLlKKqJdaAoNv
         tE5Z0i8X+c/WGWXmm+FFOQs9fj697dxIjEYsbNyaTxMtieg2Ps6ehJClN53OP78COL0J
         6suLyktisetTte2flCATpNHEWK65S3olTXzMj5TzUctpqeAX214pmGRFPLAE1n1LhKAu
         RQV4eNFVc0h+eKWOfq2InwftTflOu4OsX+Paw0wPJO+wwfflFw8GHWnPjOmbPBCjcRtA
         N9hRZtLGhZca2ZUBd7f1ijXCQR7cbsM+eU5IfbyeEOcB8a4Cn8JNKpwvH3BXUt5o4moX
         +bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427337; x=1708032137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSLmVkRgWUoN7XoRPV1r5JJdZzlBEVE8ndv4C2H5Jh8=;
        b=JrXu6KyNvtMyVvgOBGWTtCODC+E6zq3ikt9luZmhI3or3u6OpFRGSDXqYZoxlLOvG2
         m86Lh+0Rqj+4d5IUtHKtlfpIj4BOJCOjcFwIZbn+ke9Lq8BJCZ1wyKl551wNvX3E94nc
         tB/C4nGTlDXvjYWo8u93zek8BfnshhX6F1uwbLcEfPzQHG1a/RqvLk9+QhiMY8ayGmIc
         /EZ5DekzDbPkzL+FdvauZidD1PbX7wq+dPI02qsEPlzqy00sSPrJePrEOoRbNcXWevBg
         E6vBWbhf80iPi0Xsb+L8qzmEi5rnafUmAwyPEAT08fatkdGCixd0lLI9KdHhnrg6epyR
         2u0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjF6xsJOL/Whhg/43lMkjNmi08nBouBUYutuU3PZQ8Q4uz3aSGpQpksskqMliVyS1OUVf1qW0uII124N7UPGPF1pI62awAawR1ouCfaQ==
X-Gm-Message-State: AOJu0YwcTZgrJujlIYPVD/z0g+3dDJVED/Poj0745yUzqnek8z1OaA+T
	RRfOv7v/GmadJaT5nzrUO7/mbDbpBfBikEBT97XfvDzspVXVgks+ZRHa1x133enSjv+WLlxU1e/
	DLEpvrLtXFS6onDelfbRz8A==
X-Google-Smtp-Source: AGHT+IHpi2zp6f82761AcV8CyUSvOxGSqe6iXK7/Js/oY/YpNWS5eL45PoitVKDlSonNzu3IUBvopJOzuI0qCajr5g==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:e9ba:42a8:6aba:f5d5])
 (user=lokeshgidra job=sendgmr) by 2002:a81:a104:0:b0:5ee:d5ed:5f70 with SMTP
 id y4-20020a81a104000000b005eed5ed5f70mr93112ywg.9.1707427337633; Thu, 08 Feb
 2024 13:22:17 -0800 (PST)
Date: Thu,  8 Feb 2024 13:22:03 -0800
In-Reply-To: <20240208212204.2043140-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208212204.2043140-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208212204.2043140-3-lokeshgidra@google.com>
Subject: [PATCH v4 2/3] userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
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

Increments and loads to mmap_changing are always in mmap_lock
critical section. This ensures that if userspace requests event
notification for non-cooperative operations (e.g. mremap), userfaultfd
operations don't occur concurrently.

This can be achieved by using a separate read-write semaphore in
userfaultfd_ctx such that increments are done in write-mode and loads
in read-mode, thereby eliminating the dependency on mmap_lock for this
purpose.

This is a preparatory step before we replace mmap_lock usage with
per-vma locks in fill/move ioctls.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 fs/userfaultfd.c              | 40 ++++++++++++----------
 include/linux/userfaultfd_k.h | 31 ++++++++++--------
 mm/userfaultfd.c              | 62 ++++++++++++++++++++---------------
 3 files changed, 75 insertions(+), 58 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 58331b83d648..c00a021bcce4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		ctx->flags = octx->flags;
 		ctx->features = octx->features;
 		ctx->released = false;
+		init_rwsem(&ctx->map_changing_lock);
 		atomic_set(&ctx->mmap_changing, 0);
 		ctx->mm = vma->vm_mm;
 		mmgrab(ctx->mm);
 
 		userfaultfd_ctx_get(octx);
+		down_write(&octx->map_changing_lock);
 		atomic_inc(&octx->mmap_changing);
+		up_write(&octx->map_changing_lock);
 		fctx->orig = octx;
 		fctx->new = ctx;
 		list_add_tail(&fctx->list, fcs);
@@ -737,7 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
 		vm_ctx->ctx = ctx;
 		userfaultfd_ctx_get(ctx);
+		down_write(&ctx->map_changing_lock);
 		atomic_inc(&ctx->mmap_changing);
+		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
 		vma_start_write(vma);
@@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 		return true;
 
 	userfaultfd_ctx_get(ctx);
+	down_write(&ctx->map_changing_lock);
 	atomic_inc(&ctx->mmap_changing);
+	up_write(&ctx->map_changing_lock);
 	mmap_read_unlock(mm);
 
 	msg_init(&ewq.msg);
@@ -825,7 +832,9 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
 		return -ENOMEM;
 
 	userfaultfd_ctx_get(ctx);
+	down_write(&ctx->map_changing_lock);
 	atomic_inc(&ctx->mmap_changing);
+	up_write(&ctx->map_changing_lock);
 	unmap_ctx->ctx = ctx;
 	unmap_ctx->start = start;
 	unmap_ctx->end = end;
@@ -1709,9 +1718,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
 		flags |= MFILL_ATOMIC_WP;
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
-					uffdio_copy.len, &ctx->mmap_changing,
-					flags);
+		ret = mfill_atomic_copy(ctx, uffdio_copy.dst, uffdio_copy.src,
+					uffdio_copy.len, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1761,9 +1769,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
-					   uffdio_zeropage.range.len,
-					   &ctx->mmap_changing);
+		ret = mfill_atomic_zeropage(ctx, uffdio_zeropage.range.start,
+					   uffdio_zeropage.range.len);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1818,9 +1825,8 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 		return -EINVAL;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
-					  uffdio_wp.range.len, mode_wp,
-					  &ctx->mmap_changing);
+		ret = mwriteprotect_range(ctx, uffdio_wp.range.start,
+					  uffdio_wp.range.len, mode_wp);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1870,9 +1876,8 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		flags |= MFILL_ATOMIC_WP;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
-					    uffdio_continue.range.len,
-					    &ctx->mmap_changing, flags);
+		ret = mfill_atomic_continue(ctx, uffdio_continue.range.start,
+					    uffdio_continue.range.len, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1925,9 +1930,8 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_poison(ctx->mm, uffdio_poison.range.start,
-					  uffdio_poison.range.len,
-					  &ctx->mmap_changing, 0);
+		ret = mfill_atomic_poison(ctx, uffdio_poison.range.start,
+					  uffdio_poison.range.len, 0);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -2003,13 +2007,14 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 	if (mmget_not_zero(mm)) {
 		mmap_read_lock(mm);
 
-		/* Re-check after taking mmap_lock */
+		/* Re-check after taking map_changing_lock */
+		down_read(&ctx->map_changing_lock);
 		if (likely(!atomic_read(&ctx->mmap_changing)))
 			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
 					 uffdio_move.len, uffdio_move.mode);
 		else
 			ret = -EAGAIN;
-
+		up_read(&ctx->map_changing_lock);
 		mmap_read_unlock(mm);
 		mmput(mm);
 	} else {
@@ -2216,6 +2221,7 @@ static int new_userfaultfd(int flags)
 	ctx->flags = flags;
 	ctx->features = 0;
 	ctx->released = false;
+	init_rwsem(&ctx->map_changing_lock);
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 	/* prevent the mm struct to be freed */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 691d928ee864..3210c3552976 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -69,6 +69,13 @@ struct userfaultfd_ctx {
 	unsigned int features;
 	/* released */
 	bool released;
+	/*
+	 * Prevents userfaultfd operations (fill/move/wp) from happening while
+	 * some non-cooperative event(s) is taking place. Increments are done
+	 * in write-mode. Whereas, userfaultfd operations, which includes
+	 * reading mmap_changing, is done under read-mode.
+	 */
+	struct rw_semaphore map_changing_lock;
 	/* memory mappings are changing because of non-cooperative event */
 	atomic_t mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
@@ -113,22 +120,18 @@ extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, uffd_flags_t flags);
 
-extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				 unsigned long src_start, unsigned long len,
-				 atomic_t *mmap_changing, uffd_flags_t flags);
-extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
+				 uffd_flags_t flags);
+extern ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
 				     unsigned long dst_start,
-				     unsigned long len,
-				     atomic_t *mmap_changing);
-extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-				     unsigned long len, atomic_t *mmap_changing,
-				     uffd_flags_t flags);
-extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
-				   unsigned long len, atomic_t *mmap_changing,
-				   uffd_flags_t flags);
-extern int mwriteprotect_range(struct mm_struct *dst_mm,
-			       unsigned long start, unsigned long len,
-			       bool enable_wp, atomic_t *mmap_changing);
+				     unsigned long len);
+extern ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+				     unsigned long len, uffd_flags_t flags);
+extern ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
+				   unsigned long len, uffd_flags_t flags);
+extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
+			       unsigned long len, bool enable_wp);
 extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9cc93cc1330b..74aad0831e40 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -353,11 +353,11 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
  * called with mmap_lock held, it will release mmap_lock before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
+					      struct userfaultfd_ctx *ctx,
 					      struct vm_area_struct *dst_vma,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      atomic_t *mmap_changing,
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -379,6 +379,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * feature is not supported.
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
+		up_read(&ctx->map_changing_lock);
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -463,6 +464,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
+			up_read(&ctx->map_changing_lock);
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!folio);
 
@@ -473,12 +475,13 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			down_read(&ctx->map_changing_lock);
 			/*
 			 * If memory mappings are changing because of non-cooperative
 			 * operation (e.g. mremap) running in parallel, bail out and
 			 * request the user to retry later
 			 */
-			if (mmap_changing && atomic_read(mmap_changing)) {
+			if (atomic_read(&ctx->mmap_changing)) {
 				err = -EAGAIN;
 				break;
 			}
@@ -501,6 +504,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	}
 
 out_unlock:
+	up_read(&ctx->map_changing_lock);
 	mmap_read_unlock(dst_mm);
 out:
 	if (folio)
@@ -512,11 +516,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 }
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
-extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
+extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
+				    struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    atomic_t *mmap_changing,
 				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -564,13 +568,13 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	return err;
 }
 
-static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
+static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
 					    unsigned long len,
-					    atomic_t *mmap_changing,
 					    uffd_flags_t flags)
 {
+	struct mm_struct *dst_mm = ctx->mm;
 	struct vm_area_struct *dst_vma;
 	ssize_t err;
 	pmd_t *dst_pmd;
@@ -600,8 +604,9 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * operation (e.g. mremap) running in parallel, bail out and
 	 * request the user to retry later
 	 */
+	down_read(&ctx->map_changing_lock);
 	err = -EAGAIN;
-	if (mmap_changing && atomic_read(mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
 	/*
@@ -633,8 +638,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
-					     len, mmap_changing, flags);
+		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
+					     src_start, len, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -693,6 +698,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		if (unlikely(err == -ENOENT)) {
 			void *kaddr;
 
+			up_read(&ctx->map_changing_lock);
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!folio);
 
@@ -723,6 +729,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	}
 
 out_unlock:
+	up_read(&ctx->map_changing_lock);
 	mmap_read_unlock(dst_mm);
 out:
 	if (folio)
@@ -733,34 +740,33 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	return copied ? copied : err;
 }
 
-ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
+ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			  unsigned long src_start, unsigned long len,
-			  atomic_t *mmap_changing, uffd_flags_t flags)
+			  uffd_flags_t flags)
 {
-	return mfill_atomic(dst_mm, dst_start, src_start, len, mmap_changing,
+	return mfill_atomic(ctx, dst_start, src_start, len,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY));
 }
 
-ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
-			      unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
+			      unsigned long start,
+			      unsigned long len)
 {
-	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+	return mfill_atomic(ctx, start, 0, len,
 			    uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE));
 }
 
-ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
-			      unsigned long len, atomic_t *mmap_changing,
-			      uffd_flags_t flags)
+ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
+			      unsigned long len, uffd_flags_t flags)
 {
-	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+	return mfill_atomic(ctx, start, 0, len,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }
 
-ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
-			    unsigned long len, atomic_t *mmap_changing,
-			    uffd_flags_t flags)
+ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
+			    unsigned long len, uffd_flags_t flags)
 {
-	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+	return mfill_atomic(ctx, start, 0, len,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_POISON));
 }
 
@@ -793,10 +799,10 @@ long uffd_wp_range(struct vm_area_struct *dst_vma,
 	return ret;
 }
 
-int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
-			unsigned long len, bool enable_wp,
-			atomic_t *mmap_changing)
+int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
+			unsigned long len, bool enable_wp)
 {
+	struct mm_struct *dst_mm = ctx->mm;
 	unsigned long end = start + len;
 	unsigned long _start, _end;
 	struct vm_area_struct *dst_vma;
@@ -820,8 +826,9 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	 * operation (e.g. mremap) running in parallel, bail out and
 	 * request the user to retry later
 	 */
+	down_read(&ctx->map_changing_lock);
 	err = -EAGAIN;
-	if (mmap_changing && atomic_read(mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
 	err = -ENOENT;
@@ -850,6 +857,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 		err = 0;
 	}
 out_unlock:
+	up_read(&ctx->map_changing_lock);
 	mmap_read_unlock(dst_mm);
 	return err;
 }
-- 
2.43.0.687.g38aa6559b0-goog


