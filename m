Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D18743280
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjF3CF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF3CFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:05:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A013591
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5707177ff8aso12069657b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090693; x=1690682693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYZzVVGdFW3BZ7BX39EfN49IRv4dv2Sl4PMSdQqxDi4=;
        b=OfSNNJfPU4LwQ+4p9lDzr7d1rFDuCbznmXwZGpFoQOb9UUudIpyItFW/YnfzN2Uh76
         17QZyg1dnJZ0RJOiYlJksJqf+ObRNyfur60YXCCTmzLOEpNbJptma3iOBWfggxbFypeQ
         SuvH+35aKNV8vVQgv8xFp3l8bhmps0ul+sZaLrf42oWdSvTkXAXDfwilgWGr0jerAG4l
         sSY5toJRTgjNO5CA+/+11sgpLNowGp96hGOd7L/hLE+sdwuDraoAAgdGjVBoc+inBYNF
         /ADidYiQiiUKM6I0fDPL0+DkQgUrxvrePdheW3EmveHdBrFadg1h+kL02l0hzoDZg27p
         8OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090693; x=1690682693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYZzVVGdFW3BZ7BX39EfN49IRv4dv2Sl4PMSdQqxDi4=;
        b=PltF1S5thvkxBsQm2coxImXJ0iYIuF2RrgUCHfLEJbtJkuwz/kZxQgkvWWgjiDoUbm
         QzaUsuUZYQpqsM9Grf2izHJn5VN5zJqnn65FdfwpfIsiCWF1IPPrxrBWD6Eb0XbO3pmN
         5C5c8A+0N6VCDu20XxOYAg9DZcq7M9NEtdXHUAlJx9KvJbXKNMUdXbq5bOAu8gP+U8KE
         qMyp20XWSuuPwDcy1rByflOegEy96BtoB4DjVw3SReWruWOzKnabPVpbiwZytxosM+z/
         ait85PgrF0i1xJ+tuGxdH46WvfXt6/KiMjrTB+LmtOUJu0NngUSMG0LivAjM3mV/wVJt
         WLjQ==
X-Gm-Message-State: ABy/qLZC/V2+chXZ5w/4ggK04wT5r3qHjLBH3CoohoLMXnlBCh4ttgLG
        DqN6ISxz+hHvlkRyZLkQ11igozea59I=
X-Google-Smtp-Source: APBJJlHphA7u0fNQhe1Hsg8YKxbjFOsjCu3koFUTN0LEhcBBqL04HvYnu+QQsZhyytzMLSCp+6sbkkOtcng=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a25:4183:0:b0:c1e:f91c:2691 with SMTP id
 o125-20020a254183000000b00c1ef91c2691mr12237yba.10.1688090693727; Thu, 29 Jun
 2023 19:04:53 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:35 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-7-surenb@google.com>
Subject: [PATCH v6 6/6] mm: handle userfaults under VMA lock
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
Acked-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c   | 34 ++++++++++++++--------------------
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/memory.c        |  9 ---------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..21a546eaf9f7 100644
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
+	assert_fault_locked(vmf);
 
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
@@ -338,7 +335,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t ptent;
 	bool ret = true;
 
-	mmap_assert_locked(mm);
+	assert_fault_locked(vmf);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -440,7 +437,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_lock so we can only check that
 	 * the mmap_lock is held, if PF_DUMPCORE was not set.
 	 */
-	mmap_assert_locked(mm);
+	assert_fault_locked(vmf);
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -556,15 +553,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
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
index 54ab11214f4f..2794225b2d42 100644
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
@@ -728,6 +739,14 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline void assert_fault_locked(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_assert_locked(vmf->vma);
+	else
+		mmap_assert_locked(vmf->vma->vm_mm);
+}
+
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
@@ -748,6 +767,11 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline void assert_fault_locked(struct vm_fault *vmf)
+{
+	mmap_assert_locked(vmf->vma->vm_mm);
+}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index bb0f68a73b0c..d9f36f9392a9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5407,15 +5407,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
2.41.0.255.g8b1d071c50-goog

