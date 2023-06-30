Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F369A74327A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF3CE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjF3CEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6DC19A9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c3d29d2fdffso978749276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090687; x=1690682687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7p+xkeFpHpY+8imX6dpZwoTYVp943eibQ5qK+rLf3c=;
        b=DUV7BVM9nFkRrG4OmL2z1rbzNQPYA08eD/W6CM9ZTP8ycZScg2wT7L7+zDm47i3EEp
         YYXhyTKoKtmqRcvzOyTyV44bllZXd+7i1AMkEKCnp9VhDpEzAvKcS+2YEZK4NAZsYcoe
         y/bdw210HSJrZUvj1zbrUaU+YWomeS88ogbqihRlgl+T+b4TNg18Gr+BlED4NnaQkkkw
         f1IhR/XhDFUZ7ovgt4RYv6+3pQDpmsTR7as7++jPBwf7pFCGJ+iXgGbx70KDjUWJPZkG
         Jf9I49Iy4KlltuDt6TFCOy2p6d0dzZ9NTdp0L/acX6A4axhyfobo5rKVJIXrfSI6c/Al
         EGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090687; x=1690682687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7p+xkeFpHpY+8imX6dpZwoTYVp943eibQ5qK+rLf3c=;
        b=TdmkwIo/Xlw0lIiyv6hEI9Z5pf/l/3O6dOkS0flKR+zfDfJVwYGia3d1Xf/I6MaEkp
         W12x6GBAqbAEULc/6oDSz3W2yE/wxSRkYGGlxrx0NDyTiQ/Hey4Mtiqx8aOy2VUywDYB
         W/LkJnq3dB1qmBSxmKlvqb2D5ch0jw1atrCunP2ZVi1vpVC7rxtfmeCQ5JlFJWpPeEwh
         rH2vjG5mtEbyn3mnP901OJub3r6MymSbO1wAG0LkrjcfH11+1EOuxnN7lWsRcH01C0Qm
         IFhth/PkVSbN90YI3ZbF4ZEEpyYI5RIX9M62h0PXlNOfqR5Woeuq2TwMEpg/39XtzjzS
         pqPQ==
X-Gm-Message-State: ABy/qLY4mlEYGOxlxZPhXdHkbh4rl6FgzHPSw6fzpOFJxeG9PAGget+D
        Rz3acoRnk9SarciB1HIc0CtOfnTO++4=
X-Google-Smtp-Source: APBJJlEey6/2V3MIX/R8fPAMY5b+xzPIZFVw7itp9GblxpDJfWRGEmOCyuEH2lOm02vp1cSgPAo6FSaIDcg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a5b:a01:0:b0:c1d:d3e6:d52e with SMTP id
 k1-20020a5b0a01000000b00c1dd3e6d52emr10821ybq.0.1688090686807; Thu, 29 Jun
 2023 19:04:46 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:32 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-4-surenb@google.com>
Subject: [PATCH v6 3/6] mm: drop per-VMA lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED
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

handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
mmap_lock has been released. However with per-VMA locks behavior is
different and the caller should still release it. To make the
rules consistent for the caller, drop the per-VMA lock when returning
VM_FAULT_RETRY or VM_FAULT_COMPLETED. Currently the only path returning
VM_FAULT_RETRY under per-VMA locks is do_swap_page and no path returns
VM_FAULT_COMPLETED for now.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c   |  3 ++-
 arch/powerpc/mm/fault.c |  3 ++-
 arch/s390/mm/fault.c    |  3 ++-
 arch/x86/mm/fault.c     |  3 ++-
 mm/memory.c             | 12 ++++++++++++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 935f0a8911f9..9d78ff78b0e3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -602,7 +602,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 5bfdf6ecfa96..82954d0e6906 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -489,7 +489,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dbe8394234e2..40a71063949b 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -418,7 +418,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e8711b2cafaf..56b4f9faf8c4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1341,7 +1341,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/mm/memory.c b/mm/memory.c
index 0ae594703021..5f26c56ce979 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3730,6 +3730,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		ret = VM_FAULT_RETRY;
+		vma_end_read(vma);
 		goto out;
 	}
 
@@ -5182,6 +5183,17 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 				 !is_cow_mapping(vma->vm_flags)))
 			return VM_FAULT_SIGSEGV;
 	}
+#ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * Per-VMA locks can't be used with FAULT_FLAG_RETRY_NOWAIT because of
+	 * the assumption that lock is dropped on VM_FAULT_RETRY.
+	 */
+	if (WARN_ON_ONCE((*flags &
+			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)) ==
+			(FAULT_FLAG_VMA_LOCK | FAULT_FLAG_RETRY_NOWAIT)))
+		return VM_FAULT_SIGSEGV;
+#endif
+
 	return 0;
 }
 
-- 
2.41.0.255.g8b1d071c50-goog

