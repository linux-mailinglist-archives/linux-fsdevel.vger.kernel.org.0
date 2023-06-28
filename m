Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E571C740B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjF1IcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjF1I1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:27:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986453ABA
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:21:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704a25be9so10993077b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940471; x=1690532471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vpZ4UoIowr79k29KU4+AhJbPBUsrrQbVzV/sKUpKyik=;
        b=zbLKDH2SWtH0rL/EpkfYuqOJyaH9DqjHpFftBY76uQWFXD077RjYqlR5tXT0nd48/I
         AgyhNxR6D4Ba/dnniLtzOwXS0tzqLGkAGRHzbJbc7HkRE2Vm9FLD9xnlBxWqtOYCTAX+
         B7yopsNtj/eZKSlDz8Kzmg4Ymtb4+DS9MhZDvieZ+kdjbmedkh7JpnWXe3Ns3kTTRmhQ
         WlQE4GnILtMFyh6N2XkDcGEEUypSGk5FmcF2Loiq91ea012ejaV/0hQtjIvGHlRvjcuA
         1k50mqknu2M0/+OVCdnEv/xY0hYoF1m8vO2Ibz00pxfZtKTQJTwAhOwpEPAhPRs+1D+2
         lwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940471; x=1690532471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpZ4UoIowr79k29KU4+AhJbPBUsrrQbVzV/sKUpKyik=;
        b=TuDO9ena5Np96bOQUusMI0h6h6ytzq6bvJDmEhTef5W4Zz40moyZ+O8VSn7pZPLm0K
         M7Vpr0qxtEcmPGkoS5tDJ8mAS4/vTt6zv/63bxr+oaw5FzMbLNhqBJSLTnhgxTnyjaw9
         bcSKsRM8482eN2jA4n5Oxqk8MSNiQY/BAt9zaBSa5yKvBeEcRzitv4EIDQ09L6/pvG3o
         FZPGTnulQT1x47haWuydwuYlGFcHEOwDztRG8x8TtvifZ72mPHiRo+nUPvDREYQbNBPc
         Sxs3Ch2R8crqcx7eNlZpvtb8z0FbI7yZzBrewtqL80F9cgUYSMs5pw/Cg3nG7TStV6Fp
         HMyA==
X-Gm-Message-State: ABy/qLaL9/XiqqMyh/3EmQfPpLJhselaT90JdKlIJWUrGnYObIYwX3fA
        KoAaTcXeBpPrG909dLDxn2oOI8gxeg0=
X-Google-Smtp-Source: APBJJlFgJ2jRK81tWxhk4XDKf3t6TTIa6oT5N32m+JJJWdx/Y3G1ED6lRjtvxsVjVQo+TveZPkRF5dvhPUU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1105:b0:bc3:cdb7:4ec8 with SMTP id
 o5-20020a056902110500b00bc3cdb74ec8mr7690ybu.6.1687936691637; Wed, 28 Jun
 2023 00:18:11 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:57 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-4-surenb@google.com>
Subject: [PATCH v4 3/6] mm: drop per-VMA lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED
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

handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
mmap_lock has been released. However with per-VMA locks behavior is
different and the caller should still release it. To make the
rules consistent for the caller, drop the per-VMA lock when returning
VM_FAULT_RETRY or VM_FAULT_COMPLETED. Currently the only path returning
VM_FAULT_RETRY under per-VMA locks is do_swap_page and no path returns
VM_FAULT_COMPLETED for now.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c   | 3 ++-
 arch/powerpc/mm/fault.c | 3 ++-
 arch/s390/mm/fault.c    | 3 ++-
 arch/x86/mm/fault.c     | 3 ++-
 mm/memory.c             | 1 +
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c85b6d70b222..9c06c53a9ff3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -612,7 +612,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 531177a4ee08..4697c5dca31c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -494,7 +494,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b65144c392b0..cccefe41038b 100644
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
index e4399983c50c..d69c85c1c04e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1347,7 +1347,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..f14d45957b83 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3713,6 +3713,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		ret = VM_FAULT_RETRY;
+		vma_end_read(vma);
 		goto out;
 	}
 
-- 
2.41.0.162.gfafddb0af9-goog

