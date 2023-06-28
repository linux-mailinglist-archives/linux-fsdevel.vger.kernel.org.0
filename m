Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AF74172A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjF1R0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF1RZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C452105
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-576d63dfc1dso491067b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973146; x=1690565146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlfhR7EToLpThGeQT880X4R1DISXmAyjsxAIr0E3t3A=;
        b=cv9vKOTj1uWilOQw2ueM+a7smhsXMKEOe4ULfV9/3oHnfMC+VyWkg0YagZLfag3QHt
         VTJVW68wDX5A6qNCjY1/v0NLpgB8pHfHimYDj35/V7zXaqiOra1xeA1GkBbA67NjquPW
         x1QSTu4uNaPPEroE9IurX9RKH4SkOXwFavLPUCF6hvBPJKloBSUU4o+6g7KIM6M/Kdrl
         Ee89eRG8kSHNaxe/bYk8hYg9yrrFR5dU/fxBHCJQ0CcEb54uf2JQBXMie2rfUmkqeUKw
         huYvjvg5vTodCn7//hTPnzWx41V+3ZeyKFUf8CEnL3AFwmjDEeS4lOCQ4Q4hhBG07yIU
         YDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973146; x=1690565146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlfhR7EToLpThGeQT880X4R1DISXmAyjsxAIr0E3t3A=;
        b=J3ITkPLaix86amivUIMnls+t3EGmq/5N2KRc4peZGBDCjiOR4hsFiVpZwgwtnIShlG
         gJ9lKFkoR3dfpfdKTgGG5UiBCb7pT7iRmgB/OdwVFwUv2E2nH4QO55NfBUPLR0VK0FQi
         fWiIV1A4i0cvZXk3lUhTWiiwuwBvWFNBML02rwdGlKzP+PHYDV2TNWAqOMx1YHWuBXFl
         6lEdYXodtOK/0GWiKJoNmoqOi/hRiRxPUCXxG3kvaPwRrLYRvNr0wEilpVgHpxoqSg81
         yoMIkuLmnN5oGh4GHkfhKhRQghliLQUqtm/XxpUcQ+ZNhx0Q+F9yKCVqAUpz9hWcmpB8
         pm6g==
X-Gm-Message-State: AC+VfDy+J8UhiVYKg6NItkMoAL2qJrGM/OEd2hzbe8a8eQ3528RXMthz
        uWyyk/W0EJo0u5tmHuDWQDPDjqvSX7Q=
X-Google-Smtp-Source: ACHHUZ6mVzUq9ryDcwh2Xte1sV3YO3u9EdCX8f+cPy2W6N1hipmOz/QDUBjgoPGi9sK1StwJ6zYhxS8iBnQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a25:5091:0:b0:c1a:dc07:1d74 with SMTP id
 e139-20020a255091000000b00c1adc071d74mr3744020ybb.0.1687973146287; Wed, 28
 Jun 2023 10:25:46 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:29 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-7-surenb@google.com>
Subject: [PATCH v5 6/6] mm: handle userfaults under VMA lock
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
 fs/userfaultfd.c   | 34 ++++++++++++++--------------------
 include/linux/mm.h | 26 ++++++++++++++++++++++++++
 mm/memory.c        | 20 +++++++++++---------
 3 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4e800bb7d2ab..9d61e3e7da7b 100644
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
@@ -337,7 +334,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	mmap_assert_locked(mm);
+	assert_fault_locked(vmf);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -445,7 +442,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_lock so we can only check that
 	 * the mmap_lock is held, if PF_DUMPCORE was not set.
 	 */
-	mmap_assert_locked(mm);
+	assert_fault_locked(vmf);
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -561,15 +558,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
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
index bbaec479bf98..cd5389338def 100644
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
@@ -731,6 +742,15 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline
+void assert_fault_locked(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_assert_locked(vmf->vma);
+	else
+		mmap_assert_locked(vmf->vma->vm_mm);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -749,6 +769,12 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
+static inline
+void assert_fault_locked(struct vm_fault *vmf)
+{
+	mmap_assert_locked(vmf->vma->vm_mm);
+}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 4fb8ecfc6d13..672f7383a622 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5202,6 +5202,17 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 				 !is_cow_mapping(vma->vm_flags)))
 			return VM_FAULT_SIGSEGV;
 	}
+#ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * Per-VMA locks can't be used with FAULT_FLAG_RETRY_NOWAIT because of
+	 * the assumption that lock is dropped on VM_FAULT_RETRY.
+	 */
+	if (WARN_ON_ONCE((*flags &
+			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)) ==
+			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)))
+		return VM_FAULT_SIGSEGV;
+#endif
+
 	return 0;
 }
 
@@ -5294,15 +5305,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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

