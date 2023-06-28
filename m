Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA47E740BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjF1Iiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjF1IfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:35:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767049DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:26:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-765986c0521so312340485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940812; x=1690532812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7MqQHJHdH35CYJ6Jb1zpJ4/eRYK1pcerh43dShkH+M=;
        b=LA2E19xf7pdXj42A1ExmJSbdMIaIbsn7NWmS9urFjUy/mNI98IsTbKUKdeui0/yaYA
         hA8WhjLz+tlG2LQrbUqRv+bCNiqRBz3Ow/Ir38THLz/uOLDlktWQjDRYkOGrClthKIH8
         88rADAgRwM4a7SvKH7Tc5/wsUsonQMNhX/qboDJQr3bvMfWE8nrJr/cN7CKEQZyQ/zl+
         PKg1CZTu0m3nXicuafs4hHYj1qjQDcWTs5N+b4z1WGmFzatznKMugkaipKlHv8d6x/Mb
         25StywCuDNj2wyw70TU82osLYLvglPWcSxaCp4h+fhOxWdoCf5jPI34AUXXQTcU+f1eF
         e3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940812; x=1690532812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7MqQHJHdH35CYJ6Jb1zpJ4/eRYK1pcerh43dShkH+M=;
        b=Ux1grZ/xCoNohR+4RKTXBA8glYyPNDWubQVCWR9vkPott8lQz+HqBJWNsk5Qls+0fF
         0C1lq6lsxjuEFLtzKiDGyNLgDfAC031np4ftx0uz/ipDJI/s5QRgp2veEzkN+R2ase5y
         z/CJFX+O6djzq5AEE04R7MoSdJoxANxYqoTt2tsYzn6RtsLvRM6qnXA6q7bXgLNo+9r3
         qwN2idwjDeO05rpTzsP2Wai2q8fTbHQEqtppE/Z7nChtH1XgOxT/YRteO1QHHJlodpQF
         Z36oZbiH/BfjdKyev8VaydJqFcQwNnNeWhLC5dhG6lPnkAcUhXf62wmIXA/g5IZSRKf8
         lFlA==
X-Gm-Message-State: AC+VfDz5dUhyWGuqyfJGiJLnBIEYluMieiQkBNoZiuePWtf3ADaSiYXD
        OU9Zq4cX9k2NNFt7roztOgO0LqdLrS4=
X-Google-Smtp-Source: ACHHUZ5p7K5vwu3GLTcOloeUXHu3uFg6BFvaVURIKfx6u7AbyQoKOvh6cJprBsCrY0QmdnAunXGn4WazRWI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a81:af22:0:b0:559:c032:eb5e with SMTP id
 n34-20020a81af22000000b00559c032eb5emr14112427ywh.1.1687936696048; Wed, 28
 Jun 2023 00:18:16 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:59 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-6-surenb@google.com>
Subject: [PATCH v4 5/6] mm: handle swap page faults under per-VMA lock
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
---
 mm/filemap.c | 25 ++++++++++++++++---------
 mm/memory.c  | 16 ++++++++++------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52bcf12dcdbf..7ee078e1a0d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1699,31 +1699,38 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 	return ret;
 }
 
+static void release_fault_lock(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vmf->vma);
+	else
+		mmap_read_unlock(vmf->vma->vm_mm);
+}
+
 /*
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
@@ -1735,7 +1742,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
-			mmap_read_unlock(mm);
+			release_fault_lock(vmf);
 			return VM_FAULT_RETRY;
 		}
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 345080052003..76c7907e7286 100644
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
+				ret |= VM_FAULT_RETRY;
+				goto out;
+			}
+
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-- 
2.41.0.162.gfafddb0af9-goog

