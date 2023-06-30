Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F687443D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjF3VUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjF3VUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B64222
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2dcso22631497b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160015; x=1690752015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYZzVVGdFW3BZ7BX39EfN49IRv4dv2Sl4PMSdQqxDi4=;
        b=VRHbgEe+4tmyXojwe94SagE/3BdWRl9HljjtCM10oZH/2lirmShVuqPWYhXZZyEPVa
         PHSvriOmhmIWRrb97shs8wqeA/tP9lhy9ofKmbZu25SK7Md122TbXLrK9ljgsXGJnI7k
         2Mai/hmZVv0XaioP1GuSs9ziPWNt6fGSHdy1nJYlIY/ldiZVysVd4eUGJdPsUGTJU1jG
         HkPIOLGsrmKHdMyj/vDsrtFzgjcyUb0RruqV5uD7mMn2bM5ITwFRVeLw4+orENuWMhoI
         SxIeBb8YpgDHnftP3wphxALr9hOaqHUGaMOTSEgl5omQxW0Qu6paJ/+V+fHiSgMem/mA
         FuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160015; x=1690752015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYZzVVGdFW3BZ7BX39EfN49IRv4dv2Sl4PMSdQqxDi4=;
        b=jn5Trr9zNdvWXvKODt3edOSfxPJVGJTebV8iE+dRj6+bc2bWS0DatVaCtKoM2zpM+E
         5fqABBDE3CL76sUi9fxxkmWx/fMwrr3CvEPtIzIvb9TN+GKKYAApi+ZroveJHC3fjuOk
         CTtYk9HQSVPVk9W7EU7SYwUqQdvN7Hw771TJ+j0knxkA5v24RfIirkIb+jsq38WNQbRc
         7qk1qnJEax8HLJFm/Pnx75UvNDW+l7RWOP2zCF9hAozlhrOUMPefvFJR7eCoL550befL
         YFVyBwqn3/nnszdLfrRSmr9pPV1XUUwlBQrd7dyt8ekMDoKTCX4W+pW6vwe9wLnBN1Fh
         msqA==
X-Gm-Message-State: ABy/qLbEDLTXTRRq4wxj1RzEy2mXPCAGV1CwXrW1PzNCg7vKGAGmQ5jw
        3zPQfg26km6IzWr4Y8BvfILwWibK/TQ=
X-Google-Smtp-Source: APBJJlGXAJjNagMRUpJSstior0oEerrgAMTnrbJJ1mJiBLKiXUVNW+JBvG48qVTyNdlMCtXmqetsT5NLqOQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a81:414c:0:b0:56d:21a1:16a1 with SMTP id
 f12-20020a81414c000000b0056d21a116a1mr30032ywk.5.1688160015604; Fri, 30 Jun
 2023 14:20:15 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:57 -0700
In-Reply-To: <20230630211957.1341547-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-7-surenb@google.com>
Subject: [PATCH v7 6/6] mm: handle userfaults under VMA lock
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

