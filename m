Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305337443D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjF3VUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjF3VUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6042707
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704af0e64so22653067b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160012; x=1690752012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLYKxrZ5h1fbhcFAmYXsTYfJQa/73KPAk4mDWkHP+2U=;
        b=ZT6ktHZWBfakPwTdWQL11GJylklZdUt0REmIhnELtq8vuBuVaxQgco9JCoPnC+OuuU
         vZw6PSnrGelo0lEcCeDnFYN+4tflSM08EdhmftkX19M9KyJrNLTeDVawm7norgcsHG5C
         dYVgLU28UQIhivrIil0nxAl475ziO73D9fN2kmu9LIUFW9ZFSiP3g0UxtSZe73VE2twZ
         nBPnZdmF3VizjltBsqXwY6xVQPcd/rehkQvW2VeGImIgps3clPONivcBrZwnBiRTeozA
         de88VNzV4x+EJnMxv8ucE3UsQ49l0jwnRRd+gl+RiItO69e1VdmSX+9wfmOXimiSZbMc
         iK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160012; x=1690752012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLYKxrZ5h1fbhcFAmYXsTYfJQa/73KPAk4mDWkHP+2U=;
        b=QDuU6RBIp0nWPaKPIqZmZmIRAJFyjti/on0WsLfBrHt3fGi2YxGyfLLyHo7AjEpqXK
         uSsuScJ2XafmMVI9FLRTZHa/7OIJdt3/unqA4WyXlcaOWh7nkagC1l5Buxy/CpA1ENxm
         kN9wJDchaSiQdnz49gA/xzbBVE+TGac6dAsZHl1i3MLztTQCAGOmWKnxbrKCoHIzTQNa
         zP6Y5ZV7eVhwNxRiilq1WO0C9s9gk9o9ueP1Sf/i7iIwD1RjrFo0VTNAa9l9sqzYbOo+
         3oRJUl8YHPIMoYqK/lrkXIOs64mJ9lFcezB+0hxosqIwR92kd/Z2pukHP0TJj8P3szgN
         4sgw==
X-Gm-Message-State: ABy/qLYx2cQDhHvCdcZUXDhTjCz/sXw/sKBigmqky1/tuNjAz3kWOgrn
        fS+U+bgOPu9qkcm0ZzwG9BmhCdDUrbA=
X-Google-Smtp-Source: APBJJlEfJxRiiLohpASuK48k4/aLdsiMH6cDocekn+hydllmXb7XugZwuZXe3kkmsJwh5wjvqPkBFJmtPmQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a81:cb0c:0:b0:56c:e6fa:6ce9 with SMTP id
 q12-20020a81cb0c000000b0056ce6fa6ce9mr29913ywi.8.1688160012625; Fri, 30 Jun
 2023 14:20:12 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:56 -0700
In-Reply-To: <20230630211957.1341547-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-6-surenb@google.com>
Subject: [PATCH v7 5/6] mm: handle swap page faults under per-VMA lock
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

When page fault is handled under per-VMA lock protection, all swap page
faults are retried with mmap_lock because folio_lock_or_retry has to drop
and reacquire mmap_lock if folio could not be immediately locked.
Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
for folio and retrying once folio is available.
With this obstacle removed, enable do_swap_page to operate under
per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
still rely on mmap_lock, therefore we have to fall back to mmap_lock in
that particular case.
Note that the only time do_swap_page calls synchronous swap_readpage
is when SWP_SYNCHRONOUS_IO is set, which is only set for
QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
pmem). Therefore we don't sleep in this path, and there's no need to
drop the mmap or per-VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 13 +++++++++++++
 mm/filemap.c       | 17 ++++++++---------
 mm/memory.c        | 16 ++++++++++------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 39aa409e84d5..54ab11214f4f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -720,6 +720,14 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 	vma->detached = detached;
 }
 
+static inline void release_fault_lock(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vmf->vma);
+	else
+		mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
@@ -735,6 +743,11 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
+static inline void release_fault_lock(struct vm_fault *vmf)
+{
+	mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 5da5ad6f7f4c..5ac1b7beea2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1671,27 +1671,26 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  * Return values:
  * 0 - folio is locked.
  * non-zero - folio is not locked.
- *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
- *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
- *     which case mmap_lock is still held.
+ *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
+ *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
+ *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
- * with the folio locked and the mmap_lock unperturbed.
+ * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
  */
 vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 {
-	struct mm_struct *mm = vmf->vma->vm_mm;
 	unsigned int flags = vmf->flags;
 
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
-		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return VM_FAULT_RETRY.
+		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
+		 * released even though returning VM_FAULT_RETRY.
 		 */
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			return VM_FAULT_RETRY;
 
-		mmap_read_unlock(mm);
+		release_fault_lock(vmf);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
@@ -1703,7 +1702,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
-			mmap_read_unlock(mm);
+			release_fault_lock(vmf);
 			return VM_FAULT_RETRY;
 		}
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 4ae3f046f593..bb0f68a73b0c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3729,12 +3729,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		ret = VM_FAULT_RETRY;
-		vma_end_read(vma);
-		goto out;
-	}
-
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
@@ -3744,6 +3738,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				/*
+				 * migrate_to_ram is not yet ready to operate
+				 * under VMA lock.
+				 */
+				vma_end_read(vma);
+				ret = VM_FAULT_RETRY;
+				goto out;
+			}
+
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-- 
2.41.0.255.g8b1d071c50-goog

