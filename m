Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25A73F355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjF0EYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjF0EYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:24:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C819BA
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfec07e5eb0so4371919276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839822; x=1690431822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SfBQGAifcALE2slHdUCY8qB9p3T7NgiAWq42Xuxc=;
        b=HRPWGd1foVC0TIQog8by8o2V8v8sJUL0qEpF8wD/s++kmHcbLnW9YsASla9n/li/yn
         jAVoOJuXYj+89+BkDU6C7DR87/c5I2Xe7AUt5OkB4Vx+il4OJL1UCe8wo1BahbtfS+tM
         +TIjU6wTLeLvtbx3yRAqe+pxoXluESKq2T+f/WXJ7whSwwQzfC1S58nYgZEbfoxC42G2
         cOxhlNeMNxCCBL8LKTRY8Gro4C7H4cVDDp7MvXisijQEL+ExlO4Z3Tomv0kO3XT8qUaT
         oJlcEThRU2WvKg9M91CG55+zV88WNMwVprV9PiZ+i5YWzMxoB7iBW977umhZZsFn9Nyn
         UwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839822; x=1690431822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SfBQGAifcALE2slHdUCY8qB9p3T7NgiAWq42Xuxc=;
        b=XiSeuFoalSHMMGoyCAym8Yh2bHL39mk6Gc8XY9QbCINhOkiqa/MoFLArCVd9CJS1Ef
         CLVIHjKISHPk5keplRjfMCapgMYl0D/ha3kJdrL71ugRb5c69KDXFD7krZXpeZsz14Z/
         BCjg8+IDgri0lAw1uiuaRtoK4wphrOzADjgyKR7iqnJF1slRPnp+urBbt0X+hr3oqrel
         L+GDr6fBiHIrFI1A29NZ40WO7OOVrwHw4Gew269ZCp9MFEg9utwFWZOF7A1Ee3EMZYY7
         OQLI6m915ekRGn65GjcRt1tcN3wdTC+B7V6xvV3/WSvKN7LkTckJrnXBemQJw2GdzPHY
         wc+g==
X-Gm-Message-State: AC+VfDxAeHzSAYlNKNRl7O+alE/EHypDcr1i3YQEB6y2TNXI6lHBHyHA
        QeLw2jEm3w7IuwtAmKNhKgoebd0+8CE=
X-Google-Smtp-Source: ACHHUZ7ZrkP2eGvIORpom8C2PklGU9Puo2bqG/qIQ+eaEnnHLQXFfj/ZvexRg0ciCojV4a3OpKeuYZMwT6k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr14013293ybg.11.1687839821918; Mon, 26
 Jun 2023 21:23:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:21 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-9-surenb@google.com>
Subject: [PATCH v3 8/8] mm: handle userfaults under VMA lock
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
instead of mmap_lock and retrying.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/userfaultfd.c | 42 ++++++++++++++++++++++--------------------
 mm/memory.c      |  9 ---------
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4e800bb7d2ab..b88632c404b6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -277,17 +277,17 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
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
+	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
+		mmap_assert_locked(ctx->mm);
 
-	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
+	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
 	if (!ptep)
 		goto out;
 
@@ -308,10 +308,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
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
@@ -325,11 +323,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
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
@@ -337,7 +335,8 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	mmap_assert_locked(mm);
+	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
+		mmap_assert_locked(mm);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -445,7 +444,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_lock so we can only check that
 	 * the mmap_lock is held, if PF_DUMPCORE was not set.
 	 */
-	mmap_assert_locked(mm);
+	if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
+		mmap_assert_locked(mm);
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -561,15 +561,17 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
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
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		/* WARNING: VMA can't be used after this */
+		vma_end_read(vma);
+	} else
+		mmap_read_unlock(mm);
+	vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
diff --git a/mm/memory.c b/mm/memory.c
index bdf46fdc58d6..923c1576bd14 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5316,15 +5316,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
2.41.0.178.g377b9f9a00-goog

