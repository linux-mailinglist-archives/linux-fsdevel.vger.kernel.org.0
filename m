Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A950741728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF1R0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjF1RZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C12102
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704e551e8bso462447b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973144; x=1690565144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oD5hhI9l4Jf87DrZhgC9LlLYP4fwxMSCMPLIWpUYiKs=;
        b=MhkAySfkftL2P4BiqUnPcVvmpQvk/auH3LM7Z+ueqGc1NfLH7/HLo0jTbZXA1VBccI
         MPcn3IPYjRbtN8+PS8/WHGstetjsvYpAjB7wiPzwBwA8WrUeLSwMo3QonXvzVRty79ZB
         fRpfwoTvHml/EijbQiE610yUvpg+YKk8ds2myvs7Iaz02mVp+//6pTH44iU75MwgifSq
         GqZmgUdybSD1Qfo62qK8Rt2zHT3/1u/rMj1Tj+s5rzDAYW+Y65erL0beG/ik/HH+W9b0
         FfPThQsgjlORcaRtantGIZZAxCbaworyNXS0Ixo143Gu7hHDPB0CcHfBEhoO6N2MxhF+
         xccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973144; x=1690565144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oD5hhI9l4Jf87DrZhgC9LlLYP4fwxMSCMPLIWpUYiKs=;
        b=QcSpd1RgcoQxGWd1Idl9EY/XPpikR1r7pjvBP9bqnTXmOWtxbxauQOJByKvLYK+sUf
         Gy4bZOxm6IR5FNENsDqj6FjOiZyhB0Sl/6mceeCkB8kUDD9r1YS+A3rQFgzT9Vhtj2mc
         flq5NOoVfW0QTlaWG85+hublrdRA6V8XElI3HwzBMF5DQ2QPyOCmOq9hNM2UWkoe+lNw
         5UDWBwaYYqxaR+YQihU7OddGmDYR1UuWYjH+3vMrtDndJdS351JF6vNja6h5Hnj/M9qH
         n18T/9N8dDnGNkdHuMk9Ac7fXUezfUd1fHKnPkGfDT0e/tM+7haozvBIjldA67kt/41K
         pKtw==
X-Gm-Message-State: AC+VfDxKAFWN33XNnHvbT/f/aXekCnZJb1LjxPnBmdUQkw48CshKFvEg
        a0avMCrNrNjq5QPjz4eGQhpWFvZNrdI=
X-Google-Smtp-Source: ACHHUZ4No9DOKnC41jadwjTwUmerxqhcl1cZj6cyLHnTgWAWhGX3rU1mn98pnnUeCN9J0h+uWTD8lD/fZdg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a81:af0c:0:b0:55d:6af3:1e2c with SMTP id
 n12-20020a81af0c000000b0055d6af31e2cmr13786933ywh.3.1687973143932; Wed, 28
 Jun 2023 10:25:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:28 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-6-surenb@google.com>
Subject: [PATCH v5 5/6] mm: handle swap page faults under per-VMA lock
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
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 13 +++++++++++++
 mm/filemap.c       | 17 ++++++++---------
 mm/memory.c        | 16 ++++++++++------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fec149585985..bbaec479bf98 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -723,6 +723,14 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
+static inline void release_fault_lock(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vmf->vma);
+	else
+		mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -736,6 +744,11 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
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
index 52bcf12dcdbf..d4d8f474e0c5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1703,27 +1703,26 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  * Return values:
  * 0 - folio is locked.
  * VM_FAULT_RETRY - folio is not locked.
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
@@ -1735,7 +1734,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
-			mmap_read_unlock(mm);
+			release_fault_lock(vmf);
 			return VM_FAULT_RETRY;
 		}
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 345080052003..4fb8ecfc6d13 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3712,12 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3727,6 +3721,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
2.41.0.162.gfafddb0af9-goog

