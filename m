Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D473F349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0EXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjF0EXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0361718
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso4652025276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839813; x=1690431813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF0nP76m0uCKG0VaTNWwLBGINdJ/4Fr3BCgpH937Cjs=;
        b=0LWS1fUj8fHv91oTajKg0vJcBVpdqwwSqjUtzC56pWGWU3fl8K9dA6f0idnSLMfjRp
         fokb+1l28uCZoInOB6UO18g1SRkEK1ukcbhhi0rTdehONv4x9IMeidIzzGOWyKexc0OG
         jtPnV6XHIsb+Kk87Cid51Sqhcr8uIw/ufmfTLfVhd2MQ4RpVy1HWiF8B3Sb3sDy9uguB
         pjICzCL8grLgH0l9QV0PKaK54nmIU8F7wcbUEL44gNrVf8lCe7QlzZUd/Ktb4nhV/XHr
         Yfq48KIvtTGqDvC3g4QyYJOr3Z8pcOMXFmK7g5sWgh7pvY3BZaDvj7vYqGrfnd6T5ld/
         zR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839813; x=1690431813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WF0nP76m0uCKG0VaTNWwLBGINdJ/4Fr3BCgpH937Cjs=;
        b=GaKdhQD6lkmN0AfM3n1Nk0CNvsoW+xlDXtyC4LjP03v/2aoAkHFRePJlNILuT0C5/8
         blp/zpLyAe3m84P85x3QRmxPgOJb0GwcrvauUhUcBAK41ryRT026eK+2VMiMZqwM6wzH
         f42y9GEnTBbYYqOHV9fv9cr55t4CMP1h9FU85WagLduyBqLKDNJ8X5ZyoyZZ8qXXUztu
         3oZd+M3KypKjSVmTD3QiVDy0CV3YHAIzEOtZ5Xn/eDyhYp6f2w8XGplh/GMxVd6255tI
         PixnSDudJ161IReEHJTs2PpmeYTofIPQq2JOeoCcIkS9AUsLGE3jZ3RGuVIkrhmfH73N
         TRbQ==
X-Gm-Message-State: AC+VfDz/E/89t8E0biTAznrNJ+N45Cldn7UqxQ9sF9bCeEv/e0KDcJUD
        EvbZjkeSVt64HiIQoM1uazKSQhlChe8=
X-Google-Smtp-Source: ACHHUZ56AMLtfxTBdGwHX0CowYNHyrKCFB2CGbJH8wbYjNIC5f8CBX5MSU7xISg3RwE4lnvBrqwh6dvbi6E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:ac1:0:b0:c1d:4fce:466 with SMTP id
 184-20020a250ac1000000b00c1d4fce0466mr2214106ybk.4.1687839813544; Mon, 26 Jun
 2023 21:23:33 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:17 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-5-surenb@google.com>
Subject: [PATCH v3 4/8] mm: replace folio_lock_or_retry with folio_lock_fault
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
vm_fault_t directly. This will be used later to return additional
information about the state of the mmap_lock upon return from this
function.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pagemap.h | 13 ++++++-------
 mm/filemap.c            | 29 +++++++++++++++--------------
 mm/memory.c             | 14 ++++++--------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..0bc206c6f62c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -896,8 +896,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-				unsigned int flags);
+vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -995,17 +994,17 @@ static inline int folio_lock_killable(struct folio *folio)
 }
 
 /*
- * folio_lock_or_retry - Lock the folio, unless this would block and the
+ * folio_lock_fault - Lock the folio, unless this would block and the
  * caller indicated that it can handle a retry.
  *
  * Return value and mmap_lock implications depend on flags; see
- * __folio_lock_or_retry().
+ * __folio_lock_fault().
  */
-static inline bool folio_lock_or_retry(struct folio *folio,
-		struct mm_struct *mm, unsigned int flags)
+static inline vm_fault_t folio_lock_fault(struct folio *folio,
+					  struct vm_fault *vmf)
 {
 	might_sleep();
-	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
+	return folio_trylock(folio) ? 0 : __folio_lock_fault(folio, vmf);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 00f01d8ead47..87b335a93530 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1701,46 +1701,47 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
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
+vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 {
-	if (fault_flag_allow_retry_first(flags)) {
+	struct mm_struct *mm = vmf->vma->vm_mm;
+
+	if (fault_flag_allow_retry_first(vmf->flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return 0.
+		 * even though return VM_FAULT_RETRY.
 		 */
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return false;
+		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+			return VM_FAULT_RETRY;
 
 		mmap_read_unlock(mm);
-		if (flags & FAULT_FLAG_KILLABLE)
+		if (vmf->flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
 			folio_wait_locked(folio);
-		return false;
+		return VM_FAULT_RETRY;
 	}
-	if (flags & FAULT_FLAG_KILLABLE) {
+	if (vmf->flags & FAULT_FLAG_KILLABLE) {
 		bool ret;
 
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
index 9011ad63c41b..3c2acafcd7b6 100644
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
+	ret = folio_lock_fault(folio, vmf);
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
 
@@ -3825,12 +3826,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
-
-	if (!locked) {
-		ret |= VM_FAULT_RETRY;
+	ret |= folio_lock_fault(folio, vmf);
+	if (ret & VM_FAULT_RETRY)
 		goto out_release;
-	}
 
 	if (swapcache) {
 		/*
-- 
2.41.0.178.g377b9f9a00-goog

