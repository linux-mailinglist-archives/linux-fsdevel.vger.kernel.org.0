Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D63728CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjFIAwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjFIAwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1630DA
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659c7dad06so17188257b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271934; x=1688863934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDKE+Wkkd9TQZuY1u1+D5VbBuChdz1DMs8UdXXj0e2g=;
        b=oVug16yEjdlnNEpZ7pnd5qNolPTgsrM9t75qLEfhGOZfvwQQTTtBUSAfR3QIEEr+oC
         v/fzE6FqQXocpbRK9V3XWMbF2lwE13bpKfYmrqjm6uNGGYsi/lgDYeC/9YEof7hp5FqS
         5A0uKzNV8LOj4fKrnAEEjVJwZBkiAOghnhCcJkEwlpwZR4xAR7bH/08Zl/fuOCMap4kM
         hmRM8jBS/+AwHvOnOyZBcktaKtQpOMW1qGAdckEP5f61vXaEekTcAIlIX8pWgUawmGin
         2woY8gWii5fyujAxxvv+l/JMuwNA3M044wzqA3CPsKBvTCAFqHIUtCTz2+/Qo24VtWBB
         JIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271934; x=1688863934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDKE+Wkkd9TQZuY1u1+D5VbBuChdz1DMs8UdXXj0e2g=;
        b=UMKuvz7SbJOubab7q0g+JIHpMWCY1gztV76YrrIWihmPULYEQvcrC7ynxefyeABt1G
         CSI5taW0ed/VG3N9JvigaDzQDJd/6bsl+YfcP1wt0hpW47CVTyewNjBuQm88pnJisTMS
         NFuSJw19n8Kkkvo3o8fvFVi+LNWCYxWXO2dSlq8QibjYPUGbXDPgrF3n292a6488vX4/
         2mSk27nhiXqJ23hENe9GKgIYxy5hIoMufFTPc8esqWJZWl6jxQ5q54MN9O0lZUqrdYlZ
         JDLa81QyXGAvCSlm/zdS4KRjo/2I8jlbAZySFkTKwPv2azkOVvq3aB909rxTVpYcLAat
         47xw==
X-Gm-Message-State: AC+VfDyhxBZ/meFiHOvWp0ZjLuw4TuVrpcpMbJQOD43GmZJpwAeIn5IP
        EidS5MleKszAXEZj7xuSmfLXVgAPuvU=
X-Google-Smtp-Source: ACHHUZ6qGzpVQ3JwgFBzFsFEN7W5Nqjbd5tmkwDtF5dFLLF9fdY1OW4nuRJzWHLumkRKhGTOuLgN6g2TsCw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a25:3216:0:b0:bb3:ac6a:6d61 with SMTP id
 y22-20020a253216000000b00bb3ac6a6d61mr657350yby.3.1686271934456; Thu, 08 Jun
 2023 17:52:14 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:57 -0700
In-Reply-To: <20230609005158.2421285-1-surenb@google.com>
Mime-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-6-surenb@google.com>
Subject: [PATCH v2 5/6] mm: implement folio wait under VMA lock
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

Follow the same pattern as mmap_lock when waiting for folio by dropping
VMA lock before the wait and retrying once folio is available.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pagemap.h | 14 ++++++++++----
 mm/filemap.c            | 43 ++++++++++++++++++++++-------------------
 mm/memory.c             | 13 ++++++++-----
 3 files changed, 41 insertions(+), 29 deletions(-)

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
index 7cb0a3776a07..838955635fbc 100644
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
index c234f8085f1e..acb09a3aad53 100644
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
@@ -3704,7 +3707,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
-	int locked;
+	bool lock_dropped;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3837,9 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
-
-	if (!locked) {
+	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
+		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
+			ret |= VM_FAULT_VMA_UNLOCKED;
 		ret |= VM_FAULT_RETRY;
 		goto out_release;
 	}
-- 
2.41.0.162.gfafddb0af9-goog

