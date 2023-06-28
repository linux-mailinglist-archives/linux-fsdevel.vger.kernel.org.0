Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2088740B79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjF1I3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjF1I06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:26:58 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D335BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:19:22 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-39acaa239b2so6136818b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940361; x=1690532361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/PrTNNebDD3ET79IWIr+QJG2wgn5QmJDayPL9+A73A=;
        b=bgv9U3NlOjrMU0EpD0oVUBvijT37kr5cF/5qNNIoX2Hj8Rz3n+BlfUoimLE7Q1CpE8
         hM4B3f8rtZLhAarOwUauyoMcl4nbcy/mzi2FbjOJJyOEgsLyFlg/x6YI2n/HZZ5gOamy
         pbOkwOSORlejJXagaeInBJQ4Lscb6EPCeR3LN3LiLpof1pWsuTwGBvPiqWM3qp5LmTkH
         DJUf3H88Swc/geyUOM67dp8zndvRx6/1OXFCayTlB2jfw897N4YvBQDZ2Q3NvP8RkHfK
         dmVIe8kW9K5dIl2aWJwtqHeLHZQWcRPqhWMMk3IHgLgnup4lhxVhgQymFpePVGX6nHDP
         iB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940361; x=1690532361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/PrTNNebDD3ET79IWIr+QJG2wgn5QmJDayPL9+A73A=;
        b=jMe17iG0bqrt+/KFE3EoqmnwfehcIdYgxq7ZI6LVThehPOptCMfx9Ecl9noOeI3qZc
         NMb8kbxqjOuYiSZEtdxgUfKKXpWMfukYp3gLzevWsqfSe9nfT63dOlUshkn9kYj4guq2
         59iMoIup9ZMV6z35Ti2nNkd+l5Uh/cvIC58IVYfhkRo08iQ/qubAQKkzIwZs3NH9NPHS
         fLEOttlh4EReZ0FCpV9KEUH29wcrEseilPem2WTo51x/+FGPxHDy8lzcjl5mjqhojZXA
         boYO67svnfGoUhohTMvW+hvq+zcXuA4Ot7gAu+d+t8y5F2HaAGMTQCpPHXveUBtdgRIy
         qtHA==
X-Gm-Message-State: AC+VfDzynSu2Xu+OWzVPQ0uemqUYxRW36dQeZAh7UobmFmL22guop0VT
        e38qTXqY1U61rmGvFTkqUbzvdjL50lI=
X-Google-Smtp-Source: ACHHUZ7aI7icl9yP+XTVAxjb/B56LWhJlYyY/bkxia+e7VEwFYxsmG4eFO4RUCr5qbQXOHl5LdpkQKpzOJA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a25:198a:0:b0:c00:a33:7 with SMTP id
 132-20020a25198a000000b00c000a330007mr9718444ybz.8.1687936698504; Wed, 28 Jun
 2023 00:18:18 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:18:00 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-7-surenb@google.com>
Subject: [PATCH v4 6/6] mm: handle userfaults under VMA lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable handle_userfault to operate under VMA lock by releasing VMA lock
instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
should never be used when handling faults under per-VMA lock protection
because that would break the assumption that lock is dropped on retry.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/userfaultfd.c   | 39 ++++++++++++++++++---------------------
 include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
 mm/filemap.c       |  8 --------
 mm/memory.c        |  9 ---------
 4 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4e800bb7d2ab..d019e7df6f15 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -277,17 +277,16 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
  * hugepmd ranges.
  */
 static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
-					 struct vm_area_struct *vma,
-					 unsigned long address,
-					 unsigned long flags,
-					 unsigned long reason)
+					      struct vm_fault *vmf,
+					      unsigned long reason)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	mmap_assert_locked(ctx->mm);
+	assert_fault_locked(ctx->mm, vmf);
 
-	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
+	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
 	if (!ptep)
 		goto out;
 
@@ -308,10 +307,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 }
 #else
 static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
-					 struct vm_area_struct *vma,
-					 unsigned long address,
-					 unsigned long flags,
-					 unsigned long reason)
+					      struct vm_fault *vmf,
+					      unsigned long reason)
 {
 	return false;	/* should never get here */
 }
@@ -325,11 +322,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
  * threads.
  */
 static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
-					 unsigned long address,
-					 unsigned long flags,
+					 struct vm_fault *vmf,
 					 unsigned long reason)
 {
 	struct mm_struct *mm = ctx->mm;
+	unsigned long address = vmf->address;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -337,7 +334,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	mmap_assert_locked(mm);
+	assert_fault_locked(mm, vmf);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -445,7 +442,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_lock so we can only check that
 	 * the mmap_lock is held, if PF_DUMPCORE was not set.
 	 */
-	mmap_assert_locked(mm);
+	assert_fault_locked(mm, vmf);
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -522,8 +519,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * and wait.
 	 */
 	ret = VM_FAULT_RETRY;
-	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
+		/* Per-VMA lock is expected to be dropped on VM_FAULT_RETRY */
+		BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
 		goto out;
+	}
 
 	/* take the reference before dropping the mmap_lock */
 	userfaultfd_ctx_get(ctx);
@@ -561,15 +561,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	if (!is_vm_hugetlb_page(vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
-						  reason);
+		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
 	else
-		must_wait = userfaultfd_huge_must_wait(ctx, vma,
-						       vmf->address,
-						       vmf->flags, reason);
+		must_wait = userfaultfd_huge_must_wait(ctx, vmf, reason);
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
-	mmap_read_unlock(mm);
+	release_fault_lock(vmf);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fec149585985..70bb2f923e33 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -705,6 +705,17 @@ static inline bool vma_try_start_write(struct vm_area_struct *vma)
 	return true;
 }
 
+static inline void vma_assert_locked(struct vm_area_struct *vma)
+{
+	int mm_lock_seq;
+
+	if (__is_vma_write_locked(vma, &mm_lock_seq))
+		return;
+
+	lockdep_assert_held(&vma->vm_lock->lock);
+	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_lock->lock), vma);
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
@@ -723,6 +734,23 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
+static inline
+void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_assert_locked(vmf->vma);
+	else
+		mmap_assert_locked(mm);
+}
+
+static inline void release_fault_lock(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vmf->vma);
+	else
+		mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -736,6 +764,17 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
+static inline
+void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
+{
+	mmap_assert_locked(mm);
+}
+
+static inline void release_fault_lock(struct vm_fault *vmf)
+{
+	mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 7ee078e1a0d2..d4d8f474e0c5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1699,14 +1699,6 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 	return ret;
 }
 
-static void release_fault_lock(struct vm_fault *vmf)
-{
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
-		vma_end_read(vmf->vma);
-	else
-		mmap_read_unlock(vmf->vma->vm_mm);
-}
-
 /*
  * Return values:
  * 0 - folio is locked.
diff --git a/mm/memory.c b/mm/memory.c
index 76c7907e7286..c6c759922f39 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5294,15 +5294,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_start_read(vma))
 		goto inval;
 
-	/*
-	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
-	 * it for now and fall back to page fault handling under mmap_lock.
-	 */
-	if (userfaultfd_armed(vma)) {
-		vma_end_read(vma);
-		goto inval;
-	}
-
 	/* Check since vm_start/vm_end might change before we lock the VMA */
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
 		vma_end_read(vma);
-- 
2.41.0.162.gfafddb0af9-goog

