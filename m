Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEB6F353D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjEARum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjEARuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:50:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFC10CC
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:50:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a77926afbso5456333276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682963432; x=1685555432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw7vchvPa5zb0i4uc6VlbyjDM+/1CtZDGIGJ1EuR9xw=;
        b=5HsHeOLjpvUCguo8Lk5686FqyMyO/K1KiWJihXWf5ybeHIs84XPoHkts2mjy/kUs1l
         OVyccOydInIzF83t7slw6eryjNnVfxRNEDu94e6rnWhRVLxxc+mL+BA49regOAf5kslZ
         LLCq5lh1PW8I8Z10gv2qYm/fP8iSSz6PfSup+xBmEYK32jLAyJ72rp0lAb9Ja6S+ZNFp
         vpHyDid2/Jb8uaq1IaiD5weLPcePb/KM0hw6ZU+KPOncjNStmsgmO9gjEswNlynFjsvG
         Mb2tpXrasG6CZ2vTifbGdq0/Y2mX7Cc6JG0UUlhWyX6kwnaEJR4lOKi95Lq/0G+NMlK8
         jz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963432; x=1685555432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw7vchvPa5zb0i4uc6VlbyjDM+/1CtZDGIGJ1EuR9xw=;
        b=fPlaVjcQAVYtR3stwK2gCemgoglSB9UVCRIL/TLHWavSyZ5MiCPUw8+bgwkORdJkx0
         UqQo04bogOlySy8Q5qPOYSZ1jtNEfFzUkqzJtvG84axi3ak6/l1dqz8FLxbB2uSEhmKZ
         96hGpIKdRlY/zpxoZbuPKzGOzkDHruesx+61nW16D8bEuR2c2I35V4sDL7ym7/jhH0kJ
         +SU5tEcI4VBkuKyaaTWDp0gpQ0jayanxx7RAYYhz38TlHC2oypTYZ71jPzFcS/Cy+PWU
         tHcs63oWdvBV3Vu+BQIkSTUhSqpjub4/OfyInb3oh4xVB9R/LC49DDNvGx9vTTqCn/NP
         Asww==
X-Gm-Message-State: AC+VfDxK6Ei2FO0vMGSb32wk70svfkx7H3PJQ7tHacgaV4Qh2HsneuFv
        YYGCEuPeMfO14pr5YddduFl1IVX71/M=
X-Google-Smtp-Source: ACHHUZ52U0jmkTB2neK+iG10+QPSsqzCMma8yYtYnx1BEqBYvpEc0F6TFjBKuNu+xchIpilXB3tZ+Ex1C4w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:4884:0:b0:b9a:6a68:7c25 with SMTP id
 v126-20020a254884000000b00b9a6a687c25mr8582160yba.5.1682963432608; Mon, 01
 May 2023 10:50:32 -0700 (PDT)
Date:   Mon,  1 May 2023 10:50:24 -0700
In-Reply-To: <20230501175025.36233-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501175025.36233-2-surenb@google.com>
Subject: [PATCH 2/3] mm: drop VMA lock before waiting for migration
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        surenb@google.com, linux-mm@kvack.org,
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

migration_entry_wait does not need VMA lock, therefore it can be dropped
before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
lock was dropped while in handle_mm_fault().
Note that once VMA lock is dropped, the VMA reference can't be used as
there are no guarantees it was not freed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c    |  3 ++-
 arch/powerpc/mm/fault.c  |  3 ++-
 arch/s390/mm/fault.c     |  3 ++-
 arch/x86/mm/fault.c      |  3 ++-
 include/linux/mm_types.h |  6 +++++-
 mm/memory.c              | 12 ++++++++++--
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..8fa281f49d61 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -602,7 +602,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	}
 	fault = handle_mm_fault(vma, addr & PAGE_MASK,
 				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & VM_FAULT_VMA_UNLOCKED))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 531177a4ee08..b27730f07141 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -494,7 +494,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & VM_FAULT_VMA_UNLOCKED))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b65144c392b0..cc923dbb0821 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -418,7 +418,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & VM_FAULT_VMA_UNLOCKED))
+		vma_end_read(vma);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..ef62ab2fd211 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1347,7 +1347,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & VM_FAULT_VMA_UNLOCKED))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..b3b57c6da0e1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1030,6 +1030,7 @@ typedef __bitwise unsigned int vm_fault_t;
  *				fsync() to complete (for synchronous page faults
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
+ * @VM_FAULT_VMA_UNLOCKED:	VMA lock was released
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
  *
  */
@@ -1047,6 +1048,7 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_VMA_UNLOCKED   = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
@@ -1070,7 +1072,9 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\
+	{ VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/mm/memory.c b/mm/memory.c
index 41f45819a923..8222acf74fd3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3714,8 +3714,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-			migration_entry_wait(vma->vm_mm, vmf->pmd,
-					     vmf->address);
+			/* Save mm in case VMA lock is dropped */
+			struct mm_struct *mm = vma->vm_mm;
+
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				/* No need to hold VMA lock for migration */
+				vma_end_read(vma);
+				/* CAUTION! VMA can't be used after this */
+				ret |= VM_FAULT_VMA_UNLOCKED;
+			}
+			migration_entry_wait(mm, vmf->pmd, vmf->address);
 		} else if (is_device_exclusive_entry(entry)) {
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-- 
2.40.1.495.gc816e09b53d-goog

