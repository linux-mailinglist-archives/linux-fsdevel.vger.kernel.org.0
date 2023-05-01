Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4086F353B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjEARun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjEARug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:50:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693011BFF
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:50:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115e69e1eso23582544b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682963435; x=1685555435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNrjh4NDZfCOCA+XspYc7I9kB51AWPXlbM0N3pX4I38=;
        b=Kbw2vWgfaNr9wwaOaALtstqdWrM8vexXN61YFf/VngXG0KW+KOPVkcePNZuJ8BunHG
         4fpSDYYnv+oGNFNonvZma1sxd7lY+pamluLU1rV2cF//+7bWNniJgJBWEyyKJ8Vh7+6F
         9iUtSaPHWAZ9eK6TXIhhIoxbL87AdOepwayQg5RNHhsGMUhaXjd/xW95LMnIJV5qHKsT
         ZO0KE701s1k305YVP18qbfaonF6MXOH89tuj3WV3vRzavu+9Gwau1Sh80hFUZAu7ob7d
         posHsah7zh+ARWr8FuaWg+eUdTnxNa8x9N/3HBaa0SrwutIbbkwlqTQY4bXjTqb8TVCJ
         gauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963435; x=1685555435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNrjh4NDZfCOCA+XspYc7I9kB51AWPXlbM0N3pX4I38=;
        b=cFfmUGqI/Z7NTtc3PSOZgPE077NieSKg9RfGtSX0WAhi4o08xIMw8ZIG1YcCNXf4g8
         W9IkN18WhW8iVnkOowp+HmwIlY+8dWL8UCbCV40lFPspgyjsZztkwT1bUbKSGc/ApTi4
         CpY2xekRBWORgWDi+17GQx1WCMYtn0aCQC7AYVGJbYiT4bHSKh1U/iMe4mnAuJywbwZ8
         cb+irqz55yrz2188nt22dlXaNqpVXUOS3R9KwIVAHJ59gjBEiLmy7zjJMJnP/yTnVPFX
         aTdjRFQ6Wytz3ZWG9XZHxnOzAeDxH2wW4PX7nBAZUjPLhEt5Ejt/ZUNAnBu4vtQmxlxJ
         ui8Q==
X-Gm-Message-State: AC+VfDx5Ao2CpMVPpgT/vJnaWKaGoCvHvpr0xn2VKC3WEllER58vSnv1
        2pXywJxmZKspJgwVMmwRLFUiCZNYYuA=
X-Google-Smtp-Source: ACHHUZ6EimADaT391MpwBUkL6hz/B/GfVS5bvY+TKbOxuncQS8LbI8CgIxJ7ch0/4tBeArriD6dOerX5ZI8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:72cc:b0:24d:e14a:6361 with SMTP id
 l12-20020a17090a72cc00b0024de14a6361mr1794469pjk.3.1682963434788; Mon, 01 May
 2023 10:50:34 -0700 (PDT)
Date:   Mon,  1 May 2023 10:50:25 -0700
In-Reply-To: <20230501175025.36233-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501175025.36233-3-surenb@google.com>
Subject: [PATCH 3/3] mm: implement folio wait under VMA lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        surenb@google.com, linux-mm@kvack.org,
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

Follow the same pattern as mmap_lock when waiting for folio by dropping
VMA lock before the wait and retrying once folio is available.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pagemap.h | 14 ++++++++++----
 mm/filemap.c            | 43 ++++++++++++++++++++++-------------------
 mm/memory.c             | 13 +++++++++----
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..6c9493314c21 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -896,8 +896,8 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-				unsigned int flags);
+bool __folio_lock_or_retry(struct folio *folio, struct vm_area_struct *vma,
+			   unsigned int flags, bool *lock_dropped);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1002,10 +1002,16 @@ static inline int folio_lock_killable(struct folio *folio)
  * __folio_lock_or_retry().
  */
 static inline bool folio_lock_or_retry(struct folio *folio,
-		struct mm_struct *mm, unsigned int flags)
+		struct vm_area_struct *vma, unsigned int flags,
+		bool *lock_dropped)
 {
 	might_sleep();
-	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
+	if (folio_trylock(folio)) {
+		*lock_dropped = false;
+		return true;
+	}
+
+	return __folio_lock_or_retry(folio, vma, flags, lock_dropped);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 84f39114d4de..9c0fa8578b2f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1701,37 +1701,35 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
 /*
  * Return values:
- * true - folio is locked; mmap_lock is still held.
+ * true - folio is locked.
  * false - folio is not locked.
- *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
- *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
- *     which case mmap_lock is still held.
- *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
- *     with VMA lock only, the VMA lock is still held.
+ *
+ * lock_dropped indicates whether mmap_lock/VMA lock got dropped.
+ *     mmap_lock/VMA lock is dropped when function fails to lock the folio,
+ *     unless flags had both FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT
+ *     set, in which case mmap_lock/VMA lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
- * with the folio locked and the mmap_lock unperturbed.
+ * with the folio locked and the mmap_lock/VMA lock unperturbed.
  */
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-			 unsigned int flags)
+bool __folio_lock_or_retry(struct folio *folio, struct vm_area_struct *vma,
+			 unsigned int flags, bool *lock_dropped)
 {
-	/* Can't do this if not holding mmap_lock */
-	if (flags & FAULT_FLAG_VMA_LOCK)
-		return false;
-
 	if (fault_flag_allow_retry_first(flags)) {
-		/*
-		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return 0.
-		 */
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+		if (flags & FAULT_FLAG_RETRY_NOWAIT) {
+			*lock_dropped = false;
 			return false;
+		}
 
-		mmap_read_unlock(mm);
+		if (flags & FAULT_FLAG_VMA_LOCK)
+			vma_end_read(vma);
+		else
+			mmap_read_unlock(vma->vm_mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
 			folio_wait_locked(folio);
+		*lock_dropped = true;
 		return false;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
@@ -1739,13 +1737,18 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
-			mmap_read_unlock(mm);
+			if (flags & FAULT_FLAG_VMA_LOCK)
+				vma_end_read(vma);
+			else
+				mmap_read_unlock(vma->vm_mm);
+			*lock_dropped = true;
 			return false;
 		}
 	} else {
 		__folio_lock(folio);
 	}
 
+	*lock_dropped = false;
 	return true;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 8222acf74fd3..e1cd39f00756 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3568,6 +3568,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
+	bool lock_dropped;
 
 	/*
 	 * We need a reference to lock the folio because we don't hold
@@ -3580,8 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	if (!folio_try_get(folio))
 		return 0;
 
-	if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
+	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
 		folio_put(folio);
+		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
+			return VM_FAULT_VMA_UNLOCKED | VM_FAULT_RETRY;
 		return VM_FAULT_RETRY;
 	}
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
@@ -3704,7 +3707,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
-	int locked;
+	bool locked;
+	bool lock_dropped;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3837,9 +3841,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
-
+	locked = folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped);
 	if (!locked) {
+		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
+			ret |= VM_FAULT_VMA_UNLOCKED;
 		ret |= VM_FAULT_RETRY;
 		goto out_release;
 	}
-- 
2.40.1.495.gc816e09b53d-goog

