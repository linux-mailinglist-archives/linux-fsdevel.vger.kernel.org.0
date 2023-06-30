Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7474327C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjF3CFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF3CEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8D2D55
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c38a4d22b39so1184917276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090691; x=1690682691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu0VoANOHpdn98KZ5A8oxTD1IO6x9vVXdvuQ30VhewY=;
        b=k2hpUcvzZlE/wuJXtV9O7dL4UXXxuhDpxzQcAiputSPknItCWluXlZUxpoRBIZi4+h
         KPN0+q/TUs10CzJQOKd+bOTOon7y7djgB0shcBBLBkGelsKwDLz9YUoVX7yZo65DufTY
         P4JkhlOyxl+5Y4sHtisEscpkNUPQkRg0YJdrsF7TLvPZPYDazeDOXw56kQkG6lk7IMOb
         LIpjhA2ZqK8avd82tEbvK3qi2QqZXfHhXxV0tM1dYGuNxYmBSvT99J+b02I50CSXB1re
         Y5/Z9eDJjxBwbtZTVpuSEiPowUAnw0SnBR6/RuHq31FRA8xTlhoG8GfqRwahTeOntn1C
         rK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090691; x=1690682691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu0VoANOHpdn98KZ5A8oxTD1IO6x9vVXdvuQ30VhewY=;
        b=JWqLtRtzQ9apwXMaLYz7oonjGb9bDeT38Wb4EbfmQyD7AJc8tf+qHuwItpocKWH8KS
         LG8KkMDRHdb7eqkSTMJ1m5rEDe92zj6Q5IR5yTYYT0m8aCk8mf9/jt4/+2Dxv2464aPV
         cX/H5e2KTO+IXWMyFJsIYxjNu3rAQRrS3xJMJ2/879BI72HVctpdLnZu+pt7bRRCOpOr
         0pIvhTvxgPSBPQVP/30R+U5rdMadMslbvAWfFxBYo2oQxaAinCK+QKop8J5Y45Xy8+3+
         n3KtZvlgvINGtPg/CtMBgTKWsfsJ/yO5OKPaeEZRFP3dAgEExd4nTWe2+POTke4/CbxI
         KmEw==
X-Gm-Message-State: ABy/qLYyQmC9rWgx5rhrzHI8IxBT0k3J179Bmk2ce/5fD6JaXuhpFEPa
        WDzYQ4e0TfNHM1QLPo26m/w4oPRKGFw=
X-Google-Smtp-Source: APBJJlGKtiVgOdnPeKYm+NCCAggIfmI1+89sKApFSCd6E4GMafU0mEfZRNDPkjtpY2CHw7a1YIb4IaOz4KU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a25:7495:0:b0:bc5:f7fe:9e7d with SMTP id
 p143-20020a257495000000b00bc5f7fe9e7dmr11606ybc.11.1688090691484; Thu, 29 Jun
 2023 19:04:51 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:34 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-6-surenb@google.com>
Subject: [PATCH v6 5/6] mm: handle swap page faults under per-VMA lock
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
index d245bb4f7153..6f4a3d83a073 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1671,27 +1671,26 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
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

