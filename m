Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D365728C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjFIAwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjFIAwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B722136
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f44c25595so208621a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271932; x=1688863932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuo3Il/2NbgOWAM0rjqTihVZSZhUnoZMQ/ESG1PbGOc=;
        b=aoHc7JPCZ32CAYt9q46WDYGEOxxS+8Zg8n+MkQ8tBFVy2AxaNM8+3Gds918auhPTHa
         q1i93JJIOBjYqWdat77Bw43ovYfILELgsQ3A15M4ncn74YtVwsuP81alu9yqHz/6QEf4
         0ZCIwnE+WqrId9F8Np2B9UzySwNVPcW9qaPUxrGBEsK8nkCGUUE7v/JS22HdzPoOb4MB
         Chi4Dc24/vK44G+H3O7mb/dNtV3gVAS4dKZye3QS8d/JCKeQ8FR8f6Rt4chkxNrZVvil
         NBHO4/LslE98QkZt8lZcAJ+QXDZaDtGSI1vY2Loous6hPUzUbnAktXCDF6R5gPFfIwoD
         hcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271932; x=1688863932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuo3Il/2NbgOWAM0rjqTihVZSZhUnoZMQ/ESG1PbGOc=;
        b=L6Wv5K61D98aWnix/l3wSHHmeMBQiNUYlhgIbemyVIXi6RDJ0af51Yofysbv1vtwd+
         swqpCRikW/LsmorPhyyqvEtThjSHwsuwYg42hn3Avottn/ZEsIxI0541I4tFcwQZxaMx
         ojkFEdJ+yKZG2JtPK8TFj7dZ8sN4aCPh1MAZmKjw9ASuthvgJ/ce5Pey/HsflKw22mCa
         VtQI3/WwiwFDMYmyMrHv/zX6nvrVByG2J5tcvzNJ8Rr94WhBGO/M35S4zVKKrBd7NZcI
         wurr5gzDNPE7FWcTNXmv57VYPjq/GCbSllScqMwqcgLuvSwyJoSxLmlJJi6UfjPYRYXK
         3MXw==
X-Gm-Message-State: AC+VfDwhgT+Nee49BvsT8+DZVKm8dhIq0uLgGEpcYRKrkngxS9XQDs+l
        tNbC9c0P5nBqld36u6J/pfPae6dGa90=
X-Google-Smtp-Source: ACHHUZ6b1B6MYsfuF9F0w1PhABF3eJ3XJNF2fY5wRRyw5gd4GldbBtWiJ9mZhA7X4yciara2bOj4oc1yZEs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a63:d44:0:b0:503:77c9:45aa with SMTP id
 4-20020a630d44000000b0050377c945aamr225410pgn.9.1686271932107; Thu, 08 Jun
 2023 17:52:12 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:56 -0700
In-Reply-To: <20230609005158.2421285-1-surenb@google.com>
Mime-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-5-surenb@google.com>
Subject: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
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
index 6045a5117ac1..8f59badbffb5 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -601,7 +601,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
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
index 79765e3dd8f3..bd6b95c82f7a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1030,6 +1030,8 @@ typedef __bitwise unsigned int vm_fault_t;
  *				fsync() to complete (for synchronous page faults
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
+ * @VM_FAULT_VMA_UNLOCKED:	VMA lock was released, vmf->vma should no longer
+ *				be accessed
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
  *
  */
@@ -1047,6 +1049,7 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_VMA_UNLOCKED   = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
@@ -1071,7 +1074,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
 	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
-	{ VM_FAULT_COMPLETED,           "COMPLETED" }
+	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\
+	{ VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/mm/memory.c b/mm/memory.c
index 41f45819a923..c234f8085f1e 100644
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
+				/* WARNING: VMA can't be used after this */
+				ret |= VM_FAULT_VMA_UNLOCKED;
+			}
+			migration_entry_wait(mm, vmf->pmd, vmf->address);
 		} else if (is_device_exclusive_entry(entry)) {
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-- 
2.41.0.162.gfafddb0af9-goog

