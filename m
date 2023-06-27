Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9094173F351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjF0EYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjF0EXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AED1984
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf34588085bso5537415276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839818; x=1690431818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/K5IT4x+bKsumOYQJ+yi2cT1e5z+UZoZveNoih+cDc=;
        b=SPsLrhIf+/FviYu5sa3cDiqhSS9nUO2CjK/9TugBc73fpzLKK7PAw7c+quZSTddlaF
         vZFybm/r8dGNnIepLjzU4IjRPPNo5Dyn4qcIKvLx1Ra7pU8Cv/EXd8r7DspbiwGRfqHi
         MU+3kIKCrT0+6JdwkeK19scpvS+xkXgrwyrrwzTvdmNJYgNZXtE3QZuG/vo4kg5AeGI2
         bmnmp+IfBgDLtPSxL3LPcMXJgEk0vn02BtNF9KdqeRATk3kahh1G/AEseDofSFqqS0cB
         IngFLnBfekjj25euZhbjVOsR2M+c4gYV9YLPJZnMZCSFvyWp7HxKSX62DnyRwsvBkXkx
         8M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839818; x=1690431818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/K5IT4x+bKsumOYQJ+yi2cT1e5z+UZoZveNoih+cDc=;
        b=WjbuLiKNB9jphKqdqGT7MQLIlJ0aIGXWViRLo1ISaHPBonz2QiFCBulTotLwMk4fqm
         fAKQmc+lOpYznAWy/15qJgOBnT8ARU7biUCMH2+JKbyYTx/5VIdl4r2nzNlFdFfUHtpU
         EBbc2KSo7S0mmdkd1FWVcMnKk+eqEBd7AXbuAiEliLdVp0xUou97U1JDaezyAfEXZv2G
         rz5qrXEdsZkIO9dOhiPEmuNF+VLtC8DcMMZLzMStUjSqMqc/SZqUMmNKKnmn0BeKC96J
         EzA+3LL4yjGbcihaql2oTjCf2AvWrf9j+2QXvrDEq5zaJsFkSEzXDeUSs1VuTJl+N1/o
         r+kQ==
X-Gm-Message-State: AC+VfDzjuOEaLDanwXbwiSUzI7038az4/haTlUSljfcDuD1hEX6xd3dj
        30qCKFD9wXBcQaJ76XqnI5+cbiGloFI=
X-Google-Smtp-Source: ACHHUZ5LhiNy4/UmnJHGuxwqmDS8M96KwdM5oYuqNif7TJ8z9OhcGrThYwi/uY+L/KRajOJ6sRKDPRQ1ACQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:e7c2:0:b0:c1d:4fce:452 with SMTP id
 e185-20020a25e7c2000000b00c1d4fce0452mr3205627ybh.1.1687839817945; Mon, 26
 Jun 2023 21:23:37 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:19 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-7-surenb@google.com>
Subject: [PATCH v3 6/8] mm: handle swap page faults under per-VMA lock
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
faults are retried with mmap_lock because folio_lock_fault (formerly
known as folio_lock_or_retry) had to drop and reacquire mmap_lock
if folio could not be immediately locked.
Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
for folio in folio_lock_fault and retrying once folio is available.
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
 mm/filemap.c | 24 ++++++++++++++++--------
 mm/memory.c  | 21 ++++++++++++++-------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8ad06d69895b..683f11f244cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1703,12 +1703,14 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  * Return values:
  * 0 - folio is locked.
  * VM_FAULT_RETRY - folio is not locked.
- *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
- *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
- *     which case mmap_lock is still held.
+ *     FAULT_FLAG_LOCK_DROPPED bit in vmf flags will be set if mmap_lock or
+ *     per-VMA lock got dropped. mmap_lock/per-VMA lock is dropped when
+ *     function fails to lock the folio, unless flags had both
+ *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in which case
+ *     the lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
- * with the folio locked and the mmap_lock unperturbed.
+ * with the folio locked and the mmap_lock/per-VMA lock unperturbed.
  */
 vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 {
@@ -1716,13 +1718,16 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 
 	if (fault_flag_allow_retry_first(vmf->flags)) {
 		/*
-		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return VM_FAULT_RETRY.
+		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
+		 * released even though returning VM_FAULT_RETRY.
 		 */
 		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
 			return VM_FAULT_RETRY;
 
-		mmap_read_unlock(mm);
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+			vma_end_read(vmf->vma);
+		else
+			mmap_read_unlock(mm);
 		vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
 		if (vmf->flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
@@ -1735,7 +1740,10 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
-			mmap_read_unlock(mm);
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+				vma_end_read(vmf->vma);
+			else
+				mmap_read_unlock(mm);
 			vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
 			return VM_FAULT_RETRY;
 		}
diff --git a/mm/memory.c b/mm/memory.c
index 3c2acafcd7b6..5caaa4c66ea2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3712,11 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		ret = VM_FAULT_RETRY;
-		goto out;
-	}
-
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
@@ -3726,6 +3721,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				/*
+				 * migrate_to_ram is not yet ready to operate
+				 * under VMA lock.
+				 */
+				ret |= VM_FAULT_RETRY;
+				goto out;
+			}
+
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
@@ -5089,9 +5093,12 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		/*
 		 * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we might
 		 * be still holding per-VMA lock to keep the vma stable as long
-		 * as possible. Drop it before returning.
+		 * as possible. In this situation vmf.flags has
+		 * FAULT_FLAG_VMA_LOCK set and FAULT_FLAG_LOCK_DROPPED unset.
+		 * Drop the lock before returning when this happens.
 		 */
-		if (vmf.flags & FAULT_FLAG_VMA_LOCK)
+		if ((vmf.flags & (FAULT_FLAG_VMA_LOCK | FAULT_FLAG_LOCK_DROPPED)) ==
+		    FAULT_FLAG_VMA_LOCK)
 			vma_end_read(vma);
 	}
 	return ret;
-- 
2.41.0.178.g377b9f9a00-goog

