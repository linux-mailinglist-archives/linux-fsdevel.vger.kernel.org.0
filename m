Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B885728CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjFIAwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjFIAwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDF6269A
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso1717538276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271928; x=1688863928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkmNN9bDB8D6ky9B1T3x3QkjIj3UMnGVw+OccLVTcQI=;
        b=gXDUez/eWeoXfvtzBxoMFqX6yzChXfTjDT+EJvNOmhXnnvN012eKsotIpflrgQF8Lp
         2fyTd8do5aQagZSZ9UACoo1VzNRvUvy51OShxvvsm8sbDywK/VrQvSv+sRssJTGwZVIC
         O3ehpAZc1poO5bYiy+cj10MKTJW6cZFiOgpPC3NY9qfT+DR6GY8WwwiHc1OHk8IdiUQQ
         0ZsriYgMP54GSTwssMvXRD/MDAyF/nV4E+VqHs3oPq/UGb1xuVtyNqZYuiLhpsjiEGIs
         wnGJGf8nQGo+PvFSaShaFDV7MeHfsOJeL0uf+hxmZhAZVLSptRntOtdojyaNM4xUuxW5
         WCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271928; x=1688863928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkmNN9bDB8D6ky9B1T3x3QkjIj3UMnGVw+OccLVTcQI=;
        b=QRhqs+pTPSyaBuqhidMYvzLEgtq2ZmCVrIgAvK4XxXW3f+l+gyt8T4Yo0d71E1Dq/x
         J/HqihqEln4KLPf6T/0WfQtjpgcKepb4c922jy5+dsGWAe4L0N3kn+xIesop6vFEhV0S
         mAeD4vT0C+SDeQQVgRUaxm8zhYnldR/vhabkxrnAcg9TAelyTkeQ4k2m1zM654ez39L+
         j8jZN/Lz9ngaCy8LRRuog2X/fvMfGb/AizSouLkBrXk8QhzBvP1RkbCHeRwbOy0MHvzn
         6ysDhvjg7G7HUYly3WNSe1MOuCtI/l2BdB+AgUY2KLVTiukF/j96dzZ9a//igfGXgtVl
         hBLw==
X-Gm-Message-State: AC+VfDyWRBL/C5LjdZfcDFZM/3ejl88U+xnN4F1pZwaQPLkxaMrwlq8J
        kbUk4xY5wQTRDgo+4eccI1s8bf52TZM=
X-Google-Smtp-Source: ACHHUZ5ErqzNYue3IsR81EKLpgdV2ofXzmHeKkote+bFDE5P/CfrHNwNpRNHxN6f/RnaMXvb7Ljn6yc+ads=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a05:6902:691:b0:ba8:1f20:ff4f with SMTP id
 i17-20020a056902069100b00ba81f20ff4fmr691767ybt.12.1686271927895; Thu, 08 Jun
 2023 17:52:07 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:54 -0700
In-Reply-To: <20230609005158.2421285-1-surenb@google.com>
Mime-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-3-surenb@google.com>
Subject: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if page is uncontended
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

When page fault is handled under VMA lock protection, all swap page
faults are retried with mmap_lock because folio_lock_or_retry
implementation has to drop and reacquire mmap_lock if folio could
not be immediately locked.
Instead of retrying all swapped page faults, retry only when folio
locking fails.
Note that the only time do_swap_page calls synchronous swap_readpage
is when SWP_SYNCHRONOUS_IO is set, which is only set for
QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
pmem). Therefore we don't sleep in this path, and there's no need to
drop the mmap or per-vma lock.
Drivers implementing ops->migrate_to_ram might still rely on mmap_lock,
therefore fall back to mmap_lock in this case.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/filemap.c |  6 ++++++
 mm/memory.c  | 14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..7cb0a3776a07 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1706,6 +1706,8 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
+ *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
+ *     with VMA lock only, the VMA lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
  * with the folio locked and the mmap_lock unperturbed.
@@ -1713,6 +1715,10 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	/* Can't do this if not holding mmap_lock */
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return false;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..41f45819a923 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -3725,6 +3720,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
-- 
2.41.0.162.gfafddb0af9-goog

