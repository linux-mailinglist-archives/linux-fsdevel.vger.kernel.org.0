Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867C728CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFIAwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbjFIAwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D830E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so2696855276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271937; x=1688863937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1WyFySTZ0XkKYIf3B7+wOl2DNVNhKC+z/byy1yFxnw=;
        b=4hO9nbpC9/B59lz7lu7ipLmvPx0TPiRR1YFcnoIIsLsACw+RsmBoY1hg9fpZtuMvoW
         AsVsIpTf8LfYB4lwQ5sT6jbE8vVaylpAww88SyjrA1LKqGMRXyWLDVtjUMHa3DShm/3L
         oCZtGpYklKgkoDTmolhi1ndUET6n652IDLkTIObECyb0yackpoS0TrORfZJOHg5/tfhJ
         JNKbEXfUKTJj0MNVLKCwTOpswbGOlStCgQHRqPjpQAo80ZcJR3KseQgmY2Wv1ZWl+SgC
         d+U9Bx2apmjK27kmJGDzWSJpSU7aLQV3FnJPhxOI/r8/brluCy0xQxyPUn6xCpotTzHq
         ehCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271937; x=1688863937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1WyFySTZ0XkKYIf3B7+wOl2DNVNhKC+z/byy1yFxnw=;
        b=NSIOMtTq3k1Gjjiuk4AL1RidaDOVp+uVuwFuEP6QJQZjWcGs0/o12cVb+NoOr0SAGq
         HOlTr/W5y1M/etdN+HEszIS0G2X12fp73VCyBWQWK90j4eKfPzt8Gvo8Y0YSI1XQ105g
         tGY8TG31fnwqrPRq4iNftFpOngnL46ioJVyEaXycgJBJRDTyQCpyoQvEuJtcYhq27tNI
         A45+Q7s2W8+uu4V2kyic8Xr+hADu8mVv3s4NZqjpXR9OYqAltAaxYQRmxexPhoSP3rxo
         VsYzHKnsOrojHCGJkDPE4EU1hEB8EPrzKACOVTIO2Qh0kZmr0c6uin8EfvJktROc4NX8
         rd6A==
X-Gm-Message-State: AC+VfDyN75gRdkvwZGpDwuhQfbN7Mdsu9wdx6joVMvvTlGs/N/X7bKoz
        zkzS09bxcSLmoED/VW1Gir0cs8v9QKY=
X-Google-Smtp-Source: ACHHUZ4bWROsb838DrUUPzvA00RwKpJHV0L0dTRYqvNM1IO6yvKJkT1erTMTIADmBKvxMqLYZ9xOLKXYFnE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a05:6902:211:b0:bb1:569c:f381 with SMTP id
 j17-20020a056902021100b00bb1569cf381mr138781ybs.1.1686271936956; Thu, 08 Jun
 2023 17:52:16 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:58 -0700
In-Reply-To: <20230609005158.2421285-1-surenb@google.com>
Mime-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-7-surenb@google.com>
Subject: [PATCH v2 6/6] mm: handle userfaults under VMA lock
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable handle_userfault to operate under VMA lock by releasing VMA lock
instead of mmap_lock and retrying with VM_FAULT_VMA_UNLOCKED set.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/userfaultfd.c | 42 ++++++++++++++++++++++--------------------
 mm/memory.c      |  9 ---------
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..23c3a4ce45d9 100644
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
+		vma_end_read(vma);
+		/* WARNING: VMA can't be used after this */
+		ret |= VM_FAULT_VMA_UNLOCKED;
+	} else
+		mmap_read_unlock(mm);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
diff --git a/mm/memory.c b/mm/memory.c
index acb09a3aad53..b2ea015dcb87 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5306,15 +5306,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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

