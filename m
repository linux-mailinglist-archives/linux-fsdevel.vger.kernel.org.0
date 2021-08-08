Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263413E37F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhHHCIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 22:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHCII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:08:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98925C061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 19:07:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so28793715pjs.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1+8qk94YsLybd6d880dx8+jAHRqhw7MZcVegNJG/As=;
        b=pf9HhRCzXwqsDn7byDY/u5c0MwGmAVtS9hJq0ik9NCMy+0S2monj1cEmbyz5BT4FAJ
         wprdXcKO8uBN69fa2aSYUnDM7FRoGYqbixoLorFJAk92XDt3Po5RB7oEff76+tkLg5y5
         PUoUGUaZnstPDuQWpn356mOJWtwhsYdfAzW5ed1O4Enu4AJXBAPS44vRV3LHzkgEfZoO
         XBmu6fr3Ny3uwqZCtTHupkGNfs9avJIqwUKSHHqUh91v+zq1xbAdaTZvh5qR1iInEYpg
         MhS8CgwGF6K8xQcujJIVLT9X+iFztvW9ufZTjahasm+2Z0T4lj8I8xwLLXdC4jXKLvuM
         eNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1+8qk94YsLybd6d880dx8+jAHRqhw7MZcVegNJG/As=;
        b=feqO0bXqBzYJoeM2yVHhywTT2ZkkeJEb8/qtYWFHnByP//xGYlr78ighIXRHrWlhhV
         H2RY0JU+XItvNc++iQFbCBMQavx4BlMrZqhBcwm3SOUNsHsCkokWYdoRdesVx+gYETXA
         7XhoqseXL79k/EHZoccfEyTgj9q7WKqm+2XAOdDLXdImKdIocGxZ++6V+iXLKqHhXvpy
         x0LIPs9O+p8Ko3tOtep1A8QrW0jZ9n+GJKQlu95cBCcGSpJyEF7vqEKthASgLQeYg8Rj
         MtTmix0JW8dkn37xM9JcFv9Bvn98qKHYRsOVzCM8BNa1/FJMhPiSA0/B4lN/OGlLZkWd
         et7A==
X-Gm-Message-State: AOAM531PxXEGInHmBWPBv37MWHyqHgeOzr4XAr8i3I273ztgPcf8l8S/
        OPRVzh7ZAj6NcQ9EmjRVuRZvMiOQR/CbWA==
X-Google-Smtp-Source: ABdhPJzW27UfC05q0W5jndajSA0al8nrdR98ALOIkJYTPk5PoG0hdD4KIRhan00ZSd5sftw4KzUtzw==
X-Received: by 2002:a63:57:: with SMTP id 84mr31742pga.241.1628388469915;
        Sat, 07 Aug 2021 19:07:49 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o18sm3987432pjp.1.2021.08.07.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 19:07:49 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Emelyanov <xemul@parallels.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/3] userfaultfd: change mmap_changing to atomic
Date:   Sat,  7 Aug 2021 19:07:22 -0700
Message-Id: <20210808020724.1022515-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210808020724.1022515-1-namit@vmware.com>
References: <20210808020724.1022515-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

mmap_changing is currently a boolean variable, which is set and cleared
without any lock that protects against concurrent modifications.

mmap_chanign is supposed to mark whether userfaultfd page-faults
handling should be retried since mappings are undergoing a change.
However, concurrent calls, for instance to madvise(MADV_DONTNEED), might
cause mmap_changing to be false, although the remove event was still not
read (hence acknowledged) by the user.

Change mmap_changing to atomic_t and increase/decrease appropriately.
Add a debug assertion to see whether mmap_changing is negative.

Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Fixes: df2cc96e77011 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 fs/userfaultfd.c              | 25 +++++++++++++------------
 include/linux/userfaultfd_k.h |  8 ++++----
 mm/userfaultfd.c              | 15 ++++++++-------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5c2d806e6ae5..29a3016f16c9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -74,7 +74,7 @@ struct userfaultfd_ctx {
 	/* released */
 	bool released;
 	/* memory mappings are changing because of non-cooperative event */
-	bool mmap_changing;
+	atomic_t mmap_changing;
 	/* mm with one ore more vmas attached to this userfaultfd_ctx */
 	struct mm_struct *mm;
 };
@@ -623,7 +623,8 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	 * already released.
 	 */
 out:
-	WRITE_ONCE(ctx->mmap_changing, false);
+	atomic_dec(&ctx->mmap_changing);
+	VM_BUG_ON(atomic_read(&ctx->mmap_changing) < 0);
 	userfaultfd_ctx_put(ctx);
 }
 
@@ -669,12 +670,12 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		ctx->state = UFFD_STATE_RUNNING;
 		ctx->features = octx->features;
 		ctx->released = false;
-		ctx->mmap_changing = false;
+		atomic_set(&ctx->mmap_changing, 0);
 		ctx->mm = vma->vm_mm;
 		mmgrab(ctx->mm);
 
 		userfaultfd_ctx_get(octx);
-		WRITE_ONCE(octx->mmap_changing, true);
+		atomic_inc(&octx->mmap_changing);
 		fctx->orig = octx;
 		fctx->new = ctx;
 		list_add_tail(&fctx->list, fcs);
@@ -721,7 +722,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
 		vm_ctx->ctx = ctx;
 		userfaultfd_ctx_get(ctx);
-		WRITE_ONCE(ctx->mmap_changing, true);
+		atomic_inc(&ctx->mmap_changing);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
@@ -766,7 +767,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 		return true;
 
 	userfaultfd_ctx_get(ctx);
-	WRITE_ONCE(ctx->mmap_changing, true);
+	atomic_inc(&ctx->mmap_changing);
 	mmap_read_unlock(mm);
 
 	msg_init(&ewq.msg);
@@ -810,7 +811,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 			return -ENOMEM;
 
 		userfaultfd_ctx_get(ctx);
-		WRITE_ONCE(ctx->mmap_changing, true);
+		atomic_inc(&ctx->mmap_changing);
 		unmap_ctx->ctx = ctx;
 		unmap_ctx->start = start;
 		unmap_ctx->end = end;
@@ -1700,7 +1701,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
 	ret = -EAGAIN;
-	if (READ_ONCE(ctx->mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		goto out;
 
 	ret = -EFAULT;
@@ -1757,7 +1758,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
 
 	ret = -EAGAIN;
-	if (READ_ONCE(ctx->mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		goto out;
 
 	ret = -EFAULT;
@@ -1807,7 +1808,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	struct userfaultfd_wake_range range;
 	bool mode_wp, mode_dontwake;
 
-	if (READ_ONCE(ctx->mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		return -EAGAIN;
 
 	user_uffdio_wp = (struct uffdio_writeprotect __user *) arg;
@@ -1855,7 +1856,7 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
 	ret = -EAGAIN;
-	if (READ_ONCE(ctx->mmap_changing))
+	if (atomic_read(&ctx->mmap_changing))
 		goto out;
 
 	ret = -EFAULT;
@@ -2087,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	ctx->features = 0;
 	ctx->state = UFFD_STATE_WAIT_API;
 	ctx->released = false;
-	ctx->mmap_changing = false;
+	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 331d2ccf0bcc..33cea484d1ad 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -60,16 +60,16 @@ extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
-			    bool *mmap_changing, __u64 mode);
+			    atomic_t *mmap_changing, __u64 mode);
 extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
 			      unsigned long dst_start,
 			      unsigned long len,
-			      bool *mmap_changing);
+			      atomic_t *mmap_changing);
 extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
-			      unsigned long len, bool *mmap_changing);
+			      unsigned long len, atomic_t *mmap_changing);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
-			       bool enable_wp, bool *mmap_changing);
+			       bool enable_wp, atomic_t *mmap_changing);
 
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0e2132834bc7..7a9008415534 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -483,7 +483,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 					      unsigned long src_start,
 					      unsigned long len,
 					      enum mcopy_atomic_mode mcopy_mode,
-					      bool *mmap_changing,
+					      atomic_t *mmap_changing,
 					      __u64 mode)
 {
 	struct vm_area_struct *dst_vma;
@@ -517,7 +517,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 * request the user to retry later
 	 */
 	err = -EAGAIN;
-	if (mmap_changing && READ_ONCE(*mmap_changing))
+	if (mmap_changing && atomic_read(mmap_changing))
 		goto out_unlock;
 
 	/*
@@ -650,28 +650,29 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 		     unsigned long src_start, unsigned long len,
-		     bool *mmap_changing, __u64 mode)
+		     atomic_t *mmap_changing, __u64 mode)
 {
 	return __mcopy_atomic(dst_mm, dst_start, src_start, len,
 			      MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
 }
 
 ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, bool *mmap_changing)
+		       unsigned long len, atomic_t *mmap_changing)
 {
 	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
 			      mmap_changing, 0);
 }
 
 ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
-		       unsigned long len, bool *mmap_changing)
+		       unsigned long len, atomic_t *mmap_changing)
 {
 	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
 			      mmap_changing, 0);
 }
 
 int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
-			unsigned long len, bool enable_wp, bool *mmap_changing)
+			unsigned long len, bool enable_wp,
+			atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
 	pgprot_t newprot;
@@ -694,7 +695,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	 * request the user to retry later
 	 */
 	err = -EAGAIN;
-	if (mmap_changing && READ_ONCE(*mmap_changing))
+	if (mmap_changing && atomic_read(mmap_changing))
 		goto out_unlock;
 
 	err = -ENOENT;
-- 
2.25.1

