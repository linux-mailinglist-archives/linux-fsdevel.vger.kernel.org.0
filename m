Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812B874327D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjF3CFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjF3CEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB622707
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so19794197b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090689; x=1690682689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPLq4zv3roaklCz3lgPe63Se1fgo5eMfP7akPG/a/ow=;
        b=6PpY0zxIk7j9Nuz5B+KxXIPHpGGMEYKk3CUWBJ5VjSX284Yj8oPSXI2iT2Fydz3ie6
         /QZ1Jby0umP//VyvIHxtQHR0BtS/pqKJXXEpDYRxgJpDwAZ+onleEU/W1qDCWKybMN6g
         tlFzWNOgeUS5JUijf+PhyR2rdGYuM+DLYL0bD6UwtFtPG5KdVaAFtt9KqSwnUHLsvr5L
         spl/lvcjwPrcYkUgTR8WOV2P2i7CZXMnh4/X/NqLaSO4UTmN7xBwAMBb/XsIOmkRYzkf
         5YmpauIoTGHRojFq+ezgT4pRCfiqWjPkdC0avAJTXDEpDjYb4dKPQbFkpIztJtKZDcQn
         6k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090689; x=1690682689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPLq4zv3roaklCz3lgPe63Se1fgo5eMfP7akPG/a/ow=;
        b=IMG7y9Z7FJUrcOkeT478B5hKOyNJ67nQXICelLPev9GP7gcM7OxZ2j8vK8VaB77JuX
         PJ0pkagpkKuDIGWQOEmsQlaOCrcwFsmRMeQ/gfB3ryHigivlFTdKyRxNV4gjX6SAb7/I
         dCHlFVqZ9H1FCYV2tWFI59oJUrj/71ziVYUCIV2uRdGNEGVCo+tL092In5EhfWaNQbPC
         BsW1VtaXTwQx3o7tLO4zAj2I8mLWVkQJAieZM+dE/yKNv9Q8fyLFUvoYw/m4kNYJCqjS
         2IJsebThpkxI4q8ZAHwGikjBvRsrsOaIhNrhP9qv6T+ZYwZaMK9mlCG9h/EBecEKghCv
         BPjw==
X-Gm-Message-State: ABy/qLame5/sT0ZR6QlWKm7KRpYUjLY+VrIrVxVmLS6WXmuTVaHfFKI+
        jkhiN8nNKXeF9DripjbblfzY2FOBrdM=
X-Google-Smtp-Source: APBJJlHrGzz2xdHx6UvUBVeHJ0BvkwaA6W8kb2bX6RsS6g6D2VZ4jkFr3U1teRxP9jVrOn+Hph+5c2ioFqg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a05:690c:2f82:b0:56d:5db:2f07 with SMTP id
 ew2-20020a05690c2f8200b0056d05db2f07mr70815ywb.5.1688090689367; Thu, 29 Jun
 2023 19:04:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:33 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-5-surenb@google.com>
Subject: [PATCH v6 4/6] mm: change folio_lock_or_retry to use vm_fault directly
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
index 716953ee1ebd..0026a0a8277c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -900,8 +900,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-				unsigned int flags);
+vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1005,11 +1004,11 @@ static inline int folio_lock_killable(struct folio *folio)
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
index 9e44a49bbd74..d245bb4f7153 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1669,32 +1669,34 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
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
@@ -1702,13 +1704,13 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
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
index 5f26c56ce979..4ae3f046f593 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3582,6 +3582,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
+	vm_fault_t ret;
 
 	/*
 	 * We need a reference to lock the folio because we don't hold
@@ -3594,9 +3595,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
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
@@ -3721,7 +3723,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
-	int locked;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3844,12 +3845,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
2.41.0.255.g8b1d071c50-goog

