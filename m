Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565C741725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjF1R0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjF1RZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C31FF5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so519327b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973141; x=1690565141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs/kXC7xcHrq9c07EUAAvOT83+rro6HC4rZ5AGfMFCA=;
        b=3gplJzXJhBY6iff0MITaQg7qq1fbPjAqgCxVk48TLjKNSRk2ZVcYwl9B6ys4XThx6f
         4IdWWG0uKl6jF+dmFqO4p08c7kHuPcS9TL5P/uGpBMbVMyrYimn/Of87aoPfQAiqOVfS
         QMswoUkYhkicP3xt1gz73zQ8oeo8QqEbKdXFe4gLWWjmwICm2jDUAYYFk1yzdYFSabjA
         4PyPp8TADBs4TtABQ6fFSIDwNgJWO/Lg16mBxHi80pof6pmgch5a6OE6+/Deo/nQKs6J
         VkyihG41HS4jHC6qBw0I8NjkgWHola51sBbUKa06EMV+qVzS56YMvtCbbg1yWN2hssRp
         kErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973141; x=1690565141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs/kXC7xcHrq9c07EUAAvOT83+rro6HC4rZ5AGfMFCA=;
        b=gxcuU8G7SEcDR/aKGde6lYM4yiDnWHCKrbf/21rOHSL7ABV0y2OkhDtTQUoV4YReYQ
         kQ5vqAiK+0xZHFMEJwamXyJmXI7k49R4yrnvNW02ZYTV8RlvMKKztRy7rCnbeRD9QACj
         mSOhd87xArAVZUYuned0ZJ8yW+mqAaBwCMlB299PhhisPwgCVvc5kYr6kSugunqKi9Ux
         b5NG9tg8kSTjHiLoP50ieVoMV5VMgF52V2YNI4WAA7/O5Px5hVedgZwH/GwtLbCkiKAy
         lh/l18FFxK05CeCHdmhfc5UU4ca5He4ssY6rrK/NHevQZ/wbhAsvdC2Rrgt11F2nrzBK
         icsQ==
X-Gm-Message-State: AC+VfDzb9jr4FAjtXlkb62B1kvQFDv0qq48n6YoWz8XQVXOBYur4RjIk
        xy27p/OZhDeaq3UXwfgy74BmZ/juFSE=
X-Google-Smtp-Source: ACHHUZ4DmmL1KbXoJUcLTcsqVboHZrBXg1e+ydt0kho9DvtJokDrg9K4gqv8lq1COe4UurCVTdxS896v+mk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a81:e247:0:b0:56d:502:9eb0 with SMTP id
 z7-20020a81e247000000b0056d05029eb0mr13999020ywl.6.1687973141513; Wed, 28 Jun
 2023 10:25:41 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:27 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-5-surenb@google.com>
Subject: [PATCH v5 4/6] mm: change folio_lock_or_retry to use vm_fault directly
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

Change folio_lock_or_retry to accept vm_fault struct and return the
vm_fault_t directly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pagemap.h |  9 ++++-----
 mm/filemap.c            | 22 ++++++++++++----------
 mm/memory.c             | 14 ++++++--------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..59d070c55c97 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -896,8 +896,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-				unsigned int flags);
+vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1001,11 +1000,11 @@ static inline int folio_lock_killable(struct folio *folio)
  * Return value and mmap_lock implications depend on flags; see
  * __folio_lock_or_retry().
  */
-static inline bool folio_lock_or_retry(struct folio *folio,
-		struct mm_struct *mm, unsigned int flags)
+static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
+					     struct vm_fault *vmf)
 {
 	might_sleep();
-	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
+	return folio_trylock(folio) ? 0 : __folio_lock_or_retry(folio, vmf);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 00f01d8ead47..52bcf12dcdbf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1701,32 +1701,34 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
 /*
  * Return values:
- * true - folio is locked; mmap_lock is still held.
- * false - folio is not locked.
+ * 0 - folio is locked.
+ * VM_FAULT_RETRY - folio is not locked.
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
  *
- * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
+ * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
  * with the folio locked and the mmap_lock unperturbed.
  */
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-			 unsigned int flags)
+vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 {
+	struct mm_struct *mm = vmf->vma->vm_mm;
+	unsigned int flags = vmf->flags;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return 0.
+		 * even though return VM_FAULT_RETRY.
 		 */
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return false;
+			return VM_FAULT_RETRY;
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
 			folio_wait_locked(folio);
-		return false;
+		return VM_FAULT_RETRY;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
 		bool ret;
@@ -1734,13 +1736,13 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 		ret = __folio_lock_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
-			return false;
+			return VM_FAULT_RETRY;
 		}
 	} else {
 		__folio_lock(folio);
 	}
 
-	return true;
+	return 0;
 }
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index f14d45957b83..345080052003 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3568,6 +3568,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
+	vm_fault_t ret;
 
 	/*
 	 * We need a reference to lock the folio because we don't hold
@@ -3580,9 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	if (!folio_try_get(folio))
 		return 0;
 
-	if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
+	ret = folio_lock_or_retry(folio, vmf);
+	if (ret) {
 		folio_put(folio);
-		return VM_FAULT_RETRY;
+		return ret;
 	}
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
 				vma->vm_mm, vmf->address & PAGE_MASK,
@@ -3704,7 +3706,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
-	int locked;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3826,12 +3827,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
-
-	if (!locked) {
-		ret |= VM_FAULT_RETRY;
+	ret |= folio_lock_or_retry(folio, vmf);
+	if (ret & VM_FAULT_RETRY)
 		goto out_release;
-	}
 
 	if (swapcache) {
 		/*
-- 
2.41.0.162.gfafddb0af9-goog

