Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACD56AD208
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 23:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCFWvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 17:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCFWu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA237B4B
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:50:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so12135956ybc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=isy/s02EN5NUA0pfogj85sB0sy+rGawYsLeZ7+MTkaI=;
        b=jpsywkv6G90QAEwW6fuDqh8b6F+l1vX6RhCR5n0pUXiOeVRUuYUZwOtyRBJ7CI273j
         xExihe3c92g6mnaJfzg+MS5n2+kLOg61adwdimP7zoOX45vD7G+mwHvhG6xgOjroBUC8
         u5l56id0L4BFNyc3GucRMx0bnw+ZVxfifMJBg3n85dXEevW9EUiQB7ylfCN6nzIo3anQ
         rKNc9n4PY5UzMuQVGKMZOgLsHiYxjYftZUHSEBn+q5WnL5FrLexXCLcBf4r3aGMjO4H9
         obuP3o3lbHgcCZCB/reF8wAuUSQdd/l3FMEIzsGSoLkinvdkx3El1yLcDBczrO+pACmZ
         SNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isy/s02EN5NUA0pfogj85sB0sy+rGawYsLeZ7+MTkaI=;
        b=QqH82uynIVPw4b8jLluunDq2WrlOAwvRGuWJi7HeLET39GKqGv80jUjrSPDF3ls9g5
         vcAYLgheT2vZWRercCw9Qmy1xkhD7k/2XxZyiWE5VOt6OQvm4eC4ygZSmPrsyL0gTB6/
         EugpxNlApAoOfld50OdX99HNJW2FbGIHayrsBdA+4M7FgvGdtV457V+E20z3IK4guOQg
         kwxCCov9gfZfYqCfuaCrWaHc2dKvYlGpNQkjZQOuJQVDcGBTwlLqnn5Mk1cFGvZSwvfn
         GdK7uvmtyh8TYlXsxuz9IQg7er+NOWPuZuKi/JY/QFaHoRBKfPiybm4f+MtU0+S/99nn
         diNA==
X-Gm-Message-State: AO0yUKWTOXw+OfXghab8K44GKZRc3HRpG5DkhgKwYG0KDhVfvZzroEGU
        JUwr6l7xHUYPddcmrVcsTTE27b3dJDH2oRqIzj2o
X-Google-Smtp-Source: AK7set/GgWCM/cv2lKkxpGMTEFZKamGvnzd+2nCisP3xoIKTzEETmzZk5EJDI3PQ/gFZUFYm9ly/QUlPoNDm8/wDFJru
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with
 SMTP id p5-20020a056902014500b00ac2a7a723c3mr3975549ybh.12.1678143041515;
 Mon, 06 Mar 2023 14:50:41 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:23 -0800
In-Reply-To: <20230306225024.264858-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-5-axelrasmussen@google.com>
Subject: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len arguments
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

We have a lot of functions which take an address + length pair,
currently passed as separate arguments. However, in our userspace API we
already have struct uffdio_range, which is exactly this pair, and this
is what we get from userspace when ioctls are called.

Instead of splitting the struct up into two separate arguments, just
plumb the struct through to the functions which use it (once we get to
the mfill_atomic_pte level, we're dealing with single (huge)pages, so we
don't need both parts).

Relatedly, for waking, just re-use this existing structure instead of
defining a new "struct uffdio_wake_range".

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              | 107 +++++++++++++---------------------
 include/linux/userfaultfd_k.h |  17 +++---
 mm/userfaultfd.c              |  92 ++++++++++++++---------------
 3 files changed, 96 insertions(+), 120 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index b8e328123b71..984b63b0fc75 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -95,11 +95,6 @@ struct userfaultfd_wait_queue {
 	bool waken;
 };
 
-struct userfaultfd_wake_range {
-	unsigned long start;
-	unsigned long len;
-};
-
 /* internal indication that UFFD_API ioctl was successfully executed */
 #define UFFD_FEATURE_INITIALIZED		(1u << 31)
 
@@ -126,7 +121,7 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
-	struct userfaultfd_wake_range *range = key;
+	struct uffdio_range *range = key;
 	int ret;
 	struct userfaultfd_wait_queue *uwq;
 	unsigned long start, len;
@@ -881,7 +876,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
-	struct userfaultfd_wake_range range = { .len = 0, };
+	struct uffdio_range range = {0};
 	unsigned long new_flags;
 	VMA_ITERATOR(vmi, mm, 0);
 
@@ -1226,7 +1221,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 }
 
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
-			     struct userfaultfd_wake_range *range)
+			     struct uffdio_range *range)
 {
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/* wake all in the range and autoremove */
@@ -1239,7 +1234,7 @@ static void __wake_userfault(struct userfaultfd_ctx *ctx,
 }
 
 static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
-					   struct userfaultfd_wake_range *range)
+					   struct uffdio_range *range)
 {
 	unsigned seq;
 	bool need_wakeup;
@@ -1270,21 +1265,21 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 }
 
 static __always_inline int validate_range(struct mm_struct *mm,
-					  __u64 start, __u64 len)
+					  const struct uffdio_range *range)
 {
 	__u64 task_size = mm->task_size;
 
-	if (start & ~PAGE_MASK)
+	if (range->start & ~PAGE_MASK)
 		return -EINVAL;
-	if (len & ~PAGE_MASK)
+	if (range->len & ~PAGE_MASK)
 		return -EINVAL;
-	if (!len)
+	if (!range->len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
+	if (range->start < mmap_min_addr)
 		return -EINVAL;
-	if (start >= task_size)
+	if (range->start >= task_size)
 		return -EINVAL;
-	if (len > task_size - start)
+	if (range->len > task_size - range->start)
 		return -EINVAL;
 	return 0;
 }
@@ -1331,8 +1326,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vm_flags |= VM_UFFD_MINOR;
 	}
 
-	ret = validate_range(mm, uffdio_register.range.start,
-			     uffdio_register.range.len);
+	ret = validate_range(mm, &uffdio_register.range);
 	if (ret)
 		goto out;
 
@@ -1538,11 +1532,11 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
-	ret = validate_range(mm, uffdio_unregister.start,
-			     uffdio_unregister.len);
+	ret = validate_range(mm, &uffdio_unregister);
 	if (ret)
 		goto out;
 
+	/* Get rid of start + end in favor of range *? */
 	start = uffdio_unregister.start;
 	end = start + uffdio_unregister.len;
 
@@ -1597,6 +1591,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	prev = vma_prev(&vmi);
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		struct uffdio_range range;
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1614,6 +1609,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
+		range.start = start;
+		range.len = vma_end - start;
 		if (userfaultfd_missing(vma)) {
 			/*
 			 * Wake any concurrent pending userfault while
@@ -1621,15 +1618,12 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			 * permanently and it avoids userland to call
 			 * UFFDIO_WAKE explicitly.
 			 */
-			struct userfaultfd_wake_range range;
-			range.start = start;
-			range.len = vma_end - start;
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
 		/* Reset ptes for the whole vma range if wr-protected */
 		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
+			uffd_wp_range(vma, &range, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
@@ -1680,27 +1674,23 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 {
 	int ret;
 	struct uffdio_range uffdio_wake;
-	struct userfaultfd_wake_range range;
 	const void __user *buf = (void __user *)arg;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
+	ret = validate_range(ctx->mm, &uffdio_wake);
 	if (ret)
 		goto out;
 
-	range.start = uffdio_wake.start;
-	range.len = uffdio_wake.len;
-
 	/*
 	 * len == 0 means wake all and we don't want to wake all here,
 	 * so check it again to be sure.
 	 */
-	VM_BUG_ON(!range.len);
+	VM_BUG_ON(!uffdio_wake.len);
 
-	wake_userfault(ctx, &range);
+	wake_userfault(ctx, &uffdio_wake);
 	ret = 0;
 
 out:
@@ -1713,7 +1703,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	__s64 ret;
 	struct uffdio_copy uffdio_copy;
 	struct uffdio_copy __user *user_uffdio_copy;
-	struct userfaultfd_wake_range range;
+	struct uffdio_range range;
 	int flags = 0;
 
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
@@ -1728,7 +1718,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
+	range.start = uffdio_copy.dst;
+	range.len = uffdio_copy.len;
+	ret = validate_range(ctx->mm, &range);
 	if (ret)
 		goto out;
 	/*
@@ -1744,9 +1736,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
 		flags |= MFILL_ATOMIC_WP;
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
-					uffdio_copy.len, &ctx->mmap_changing,
-					flags);
+		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.src, &range,
+					&ctx->mmap_changing, flags);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1758,10 +1749,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	BUG_ON(!ret);
 	/* len == 0 would wake all */
 	range.len = ret;
-	if (!(uffdio_copy.mode & UFFDIO_COPY_MODE_DONTWAKE)) {
-		range.start = uffdio_copy.dst;
+	if (!(uffdio_copy.mode & UFFDIO_COPY_MODE_DONTWAKE))
 		wake_userfault(ctx, &range);
-	}
 	ret = range.len == uffdio_copy.len ? 0 : -EAGAIN;
 out:
 	return ret;
@@ -1773,7 +1762,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	__s64 ret;
 	struct uffdio_zeropage uffdio_zeropage;
 	struct uffdio_zeropage __user *user_uffdio_zeropage;
-	struct userfaultfd_wake_range range;
+	struct uffdio_range range;
 
 	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
 
@@ -1787,8 +1776,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_zeropage)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
-			     uffdio_zeropage.range.len);
+	range = uffdio_zeropage.range;
+	ret = validate_range(ctx->mm, &range);
 	if (ret)
 		goto out;
 	ret = -EINVAL;
@@ -1796,8 +1785,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
-					   uffdio_zeropage.range.len,
+		ret = mfill_atomic_zeropage(ctx->mm, &uffdio_zeropage.range,
 					   &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
@@ -1811,7 +1799,6 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	BUG_ON(!ret);
 	range.len = ret;
 	if (!(uffdio_zeropage.mode & UFFDIO_ZEROPAGE_MODE_DONTWAKE)) {
-		range.start = uffdio_zeropage.range.start;
 		wake_userfault(ctx, &range);
 	}
 	ret = range.len == uffdio_zeropage.range.len ? 0 : -EAGAIN;
@@ -1825,7 +1812,6 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	int ret;
 	struct uffdio_writeprotect uffdio_wp;
 	struct uffdio_writeprotect __user *user_uffdio_wp;
-	struct userfaultfd_wake_range range;
 	bool mode_wp, mode_dontwake;
 
 	if (atomic_read(&ctx->mmap_changing))
@@ -1837,8 +1823,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 			   sizeof(struct uffdio_writeprotect)))
 		return -EFAULT;
 
-	ret = validate_range(ctx->mm, uffdio_wp.range.start,
-			     uffdio_wp.range.len);
+	ret = validate_range(ctx->mm, &uffdio_wp.range);
 	if (ret)
 		return ret;
 
@@ -1853,9 +1838,8 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 		return -EINVAL;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
-					  uffdio_wp.range.len, mode_wp,
-					  &ctx->mmap_changing);
+		ret = mwriteprotect_range(ctx->mm, &uffdio_wp.range,
+					  mode_wp, &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
 		return -ESRCH;
@@ -1864,11 +1848,8 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	if (ret)
 		return ret;
 
-	if (!mode_wp && !mode_dontwake) {
-		range.start = uffdio_wp.range.start;
-		range.len = uffdio_wp.range.len;
-		wake_userfault(ctx, &range);
-	}
+	if (!mode_wp && !mode_dontwake)
+		wake_userfault(ctx, &uffdio_wp.range);
 	return ret;
 }
 
@@ -1877,7 +1858,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	__s64 ret;
 	struct uffdio_continue uffdio_continue;
 	struct uffdio_continue __user *user_uffdio_continue;
-	struct userfaultfd_wake_range range;
+	struct uffdio_range range;
 
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
@@ -1891,23 +1872,20 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 			   sizeof(uffdio_continue) - (sizeof(__s64))))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_continue.range.start,
-			     uffdio_continue.range.len);
+	range = uffdio_continue.range;
+	ret = validate_range(ctx->mm, &range);
 	if (ret)
 		goto out;
 
 	ret = -EINVAL;
 	/* double check for wraparound just in case. */
-	if (uffdio_continue.range.start + uffdio_continue.range.len <=
-	    uffdio_continue.range.start) {
+	if (range.start + range.len <= range.start)
 		goto out;
-	}
 	if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
 		goto out;
 
 	if (mmget_not_zero(ctx->mm)) {
-		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
-					    uffdio_continue.range.len,
+		ret = mfill_atomic_continue(ctx->mm, &range,
 					    &ctx->mmap_changing);
 		mmput(ctx->mm);
 	} else {
@@ -1923,7 +1901,6 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	BUG_ON(!ret);
 	range.len = ret;
 	if (!(uffdio_continue.mode & UFFDIO_CONTINUE_MODE_DONTWAKE)) {
-		range.start = uffdio_continue.range.start;
 		wake_userfault(ctx, &range);
 	}
 	ret = range.len == uffdio_continue.range.len ? 0 : -EAGAIN;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a45c1b42e500..fcd95e3d3dcd 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -63,20 +63,21 @@ extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
 				    unsigned long dst_addr, struct page *page,
 				    bool newly_allocated, uffd_flags_t flags);
 
-extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
-				 unsigned long src_start, unsigned long len,
+extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long src_start,
+				 const struct uffdio_range *dst,
 				 atomic_t *mmap_changing, uffd_flags_t flags);
 extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
-				     unsigned long dst_start,
-				     unsigned long len,
+				     const struct uffdio_range *dst,
 				     atomic_t *mmap_changing);
-extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-				     unsigned long len, atomic_t *mmap_changing);
+extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
+				     const struct uffdio_range *dst,
+				    atomic_t *mmap_changing);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
-			       unsigned long start, unsigned long len,
+			       const struct uffdio_range *range,
 			       bool enable_wp, atomic_t *mmap_changing);
 extern long uffd_wp_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long len, bool enable_wp);
+			  const struct uffdio_range *range,
+			  bool enable_wp);
 
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c0d061acc069..870e7489e8d1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -21,8 +21,7 @@
 
 static __always_inline
 struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+				    const struct uffdio_range *dst)
 {
 	/*
 	 * Make sure that the dst range is both valid and fully within a
@@ -30,12 +29,12 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 */
 	struct vm_area_struct *dst_vma;
 
-	dst_vma = find_vma(dst_mm, dst_start);
+	dst_vma = find_vma(dst_mm, dst->start);
 	if (!dst_vma)
 		return NULL;
 
-	if (dst_start < dst_vma->vm_start ||
-	    dst_start + len > dst_vma->vm_end)
+	if (dst->start < dst_vma->vm_start ||
+	    dst->start + dst->len > dst_vma->vm_end)
 		return NULL;
 
 	/*
@@ -309,9 +308,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct vm_area_struct *dst_vma,
-					      unsigned long dst_start,
 					      unsigned long src_start,
-					      unsigned long len,
+					      const struct uffdio_range *dst,
 					      uffd_flags_t flags)
 {
 	int mode = flags & MFILL_ATOMIC_MODE_MASK;
@@ -339,7 +337,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	}
 
 	src_addr = src_start;
-	dst_addr = dst_start;
+	dst_addr = dst->start;
 	copied = 0;
 	page = NULL;
 	vma_hpagesize = vma_kernel_pagesize(dst_vma);
@@ -348,7 +346,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * Validate alignment based on huge page size
 	 */
 	err = -EINVAL;
-	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
+	if (dst->start & (vma_hpagesize - 1) || dst->len & (vma_hpagesize - 1))
 		goto out_unlock;
 
 retry:
@@ -358,7 +356,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (!dst_vma) {
 		err = -ENOENT;
-		dst_vma = find_dst_vma(dst_mm, dst_start, len);
+		dst_vma = find_dst_vma(dst_mm, dst);
 		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
 			goto out_unlock;
 
@@ -378,8 +376,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 	}
 
-	while (src_addr < src_start + len) {
-		BUG_ON(dst_addr >= dst_start + len);
+	while (src_addr < src_start + dst->len) {
+		BUG_ON(dst_addr >= dst->start + dst->len);
 
 		/*
 		 * Serialize via vma_lock and hugetlb_fault_mutex.
@@ -461,10 +459,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 #else /* !CONFIG_HUGETLB_PAGE */
 /* fail at build time if gcc attempts to use this */
 extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
-				    unsigned long dst_start,
 				    unsigned long src_start,
-				    unsigned long len,
-				    uffd_flags_t flags);
+				    struct uffdio_range dst,
+				    uffd_flags_t mode_flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
@@ -510,9 +507,8 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 }
 
 static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
-					    unsigned long dst_start,
 					    unsigned long src_start,
-					    unsigned long len,
+					    const struct uffdio_range *dst,
 					    atomic_t *mmap_changing,
 					    uffd_flags_t flags)
 {
@@ -526,15 +522,15 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	/*
 	 * Sanitize the command parameters:
 	 */
-	BUG_ON(dst_start & ~PAGE_MASK);
-	BUG_ON(len & ~PAGE_MASK);
+	BUG_ON(dst->start & ~PAGE_MASK);
+	BUG_ON(dst->len & ~PAGE_MASK);
 
 	/* Does the address range wrap, or is the span zero-sized? */
-	BUG_ON(src_start + len <= src_start);
-	BUG_ON(dst_start + len <= dst_start);
+	BUG_ON(src_start + dst->len <= src_start);
+	BUG_ON(dst->start + dst->len <= dst->start);
 
 	src_addr = src_start;
-	dst_addr = dst_start;
+	dst_addr = dst->start;
 	copied = 0;
 	page = NULL;
 retry:
@@ -554,7 +550,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * both valid and fully within a single existing vma.
 	 */
 	err = -ENOENT;
-	dst_vma = find_dst_vma(dst_mm, dst_start, len);
+	dst_vma = find_dst_vma(dst_mm, dst);
 	if (!dst_vma)
 		goto out_unlock;
 
@@ -578,8 +574,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(dst_vma, src_start, dst, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -597,10 +592,10 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	    unlikely(anon_vma_prepare(dst_vma)))
 		goto out_unlock;
 
-	while (src_addr < src_start + len) {
+	while (src_addr < src_start + dst->len) {
 		pmd_t dst_pmdval;
 
-		BUG_ON(dst_addr >= dst_start + len);
+		BUG_ON(dst_addr >= dst->start + dst->len);
 
 		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
 		if (unlikely(!dst_pmd)) {
@@ -678,30 +673,32 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	return copied ? copied : err;
 }
 
-ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
-			  unsigned long src_start, unsigned long len,
+ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long src_start,
+			  const struct uffdio_range *dst,
 			  atomic_t *mmap_changing, uffd_flags_t flags)
 {
-	return mfill_atomic(dst_mm, dst_start, src_start, len,
+	return mfill_atomic(dst_mm, src_start, dst,
 			    mmap_changing, flags | MFILL_ATOMIC_COPY);
 }
 
-ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
-			      unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
+			      const struct uffdio_range *dst,
+			      atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len,
+	return mfill_atomic(dst_mm, 0, dst,
 			    mmap_changing, MFILL_ATOMIC_ZEROPAGE);
 }
 
-ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
-			      unsigned long len, atomic_t *mmap_changing)
+ssize_t mfill_atomic_continue(struct mm_struct *dst_mm,
+			      const struct uffdio_range *dst,
+			      atomic_t *mmap_changing)
 {
-	return mfill_atomic(dst_mm, start, 0, len,
+	return mfill_atomic(dst_mm, 0, dst,
 			    mmap_changing, MFILL_ATOMIC_CONTINUE);
 }
 
 long uffd_wp_range(struct vm_area_struct *dst_vma,
-		   unsigned long start, unsigned long len, bool enable_wp)
+		   const struct uffdio_range *range, bool enable_wp)
 {
 	unsigned int mm_cp_flags;
 	struct mmu_gather tlb;
@@ -721,15 +718,16 @@ long uffd_wp_range(struct vm_area_struct *dst_vma,
 	if (!enable_wp && vma_wants_manual_pte_write_upgrade(dst_vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 	tlb_gather_mmu(&tlb, dst_vma->vm_mm);
-	ret = change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
+	ret = change_protection(&tlb, dst_vma, range->start,
+				range->start + range->len, mm_cp_flags);
 	tlb_finish_mmu(&tlb);
 
 	return ret;
 }
 
-int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
-			unsigned long len, bool enable_wp,
-			atomic_t *mmap_changing)
+int mwriteprotect_range(struct mm_struct *dst_mm,
+			const struct uffdio_range *dst,
+			bool enable_wp, atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
@@ -738,11 +736,11 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	/*
 	 * Sanitize the command parameters:
 	 */
-	BUG_ON(start & ~PAGE_MASK);
-	BUG_ON(len & ~PAGE_MASK);
+	BUG_ON(dst->start & ~PAGE_MASK);
+	BUG_ON(dst->len & ~PAGE_MASK);
 
 	/* Does the address range wrap, or is the span zero-sized? */
-	BUG_ON(start + len <= start);
+	BUG_ON(dst->start + dst->len <= dst->start);
 
 	mmap_read_lock(dst_mm);
 
@@ -756,7 +754,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 		goto out_unlock;
 
 	err = -ENOENT;
-	dst_vma = find_dst_vma(dst_mm, start, len);
+	dst_vma = find_dst_vma(dst_mm, dst);
 
 	if (!dst_vma)
 		goto out_unlock;
@@ -768,11 +766,11 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	if (is_vm_hugetlb_page(dst_vma)) {
 		err = -EINVAL;
 		page_mask = vma_kernel_pagesize(dst_vma) - 1;
-		if ((start & page_mask) || (len & page_mask))
+		if ((dst->start & page_mask) || (dst->len & page_mask))
 			goto out_unlock;
 	}
 
-	err = uffd_wp_range(dst_vma, start, len, enable_wp);
+	err = uffd_wp_range(dst_vma, dst, enable_wp);
 
 	/* Return 0 on success, <0 on failures */
 	if (err > 0)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

