Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59531A720
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBLVzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBLVzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:00 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E55C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:19 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l13so545011qvt.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CKBB7i4WKZ8V4NFQL35jIBKBg/dy7ji0N2zuyueuiDE=;
        b=q/C1CnJMihmZljCjgasMtzMEMhefxZ5Leb2bQUmOpZraBDczG4IIHCbCq+xO/0qTi2
         qIizPQMOVNkylMylWN4qE63+45q4oGIZxHxbn/nZRrxUchmJ3OQro5H1B7qZ/Sv59h5v
         4QfsycT1QbveNer1hlT4SP/ZQ5L5vHayDsUpfB/KItgn0yYMwZ19mJTRMqRbKrI16eSr
         rRkIbL+ydVKIIdkxCUDTpN5KWbWROY0RiLDAF1gHyKeTdd+5BWP209Q/0coSz8xlSMXr
         Rx1Y3gQI9ThzeFRxrLMwmmOrbDHshVUaCxF+I/q5QFEVGuwmMIQOAbDxrgdi6SgwVgu1
         EFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CKBB7i4WKZ8V4NFQL35jIBKBg/dy7ji0N2zuyueuiDE=;
        b=ZvuZ+2K0NhLZ/nRHvwyyhwszXLwVKVAbABHSAvsoImGHDrlo+R6XLr8hsmDmA/JL02
         4d6MVOznz0CA34NQX5Wn7SIiJxy6Sew039z/c8riEZxAm/MIE25ZNwWG7lAdEs6olkiU
         z3mTRSFPo9A/Hj0/wH2+8Ird5isirFF5sDT3XitoPhQO2MmMcqiCQRMkqlI4qDMZjVfg
         vgUU4QyQPj4aA7BZhAMDEzkARrsncaNK0v7HMRz5quZBR/2BSREJgTLP+KuEcULKzoe6
         ETU0tPO5Dv5df+48tSxlXEeApNC3E7NKg7WrXXXHmp2Zrss47fSME/z2CC5r9BRLLScG
         IWQw==
X-Gm-Message-State: AOAM530bhS7KlNevDi0TTYORo5qmuUL3CLwGNA1ehoS8DXrjTFNwKo3x
        jvtq5JE/mvi0E6TReR1d2Kleppv5Hl5di/QLjZbd
X-Google-Smtp-Source: ABdhPJwcHsCAN2GnttmsvMnQuKlj2Z/KdxDSc80IoWKQ/QvZqaQGpiLklO3HftzBZmN17C7RUsTH9hUh74EMOFwN61NW
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4b30:: with SMTP id
 s16mr4540474qvw.62.1613166858565; Fri, 12 Feb 2021 13:54:18 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:53:57 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 1/7] userfaultfd: introduce a new reason enum instead of
 using VM_* flags
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The problem is, VM_* flags are a limited resource. As we add support for
new use cases to userfaultfd, there are new reasons why a userfault
might be triggered, but we can't keep adding new VM_* flags.

So, introduce a new enum, to which we can add arbitrarily many reasons
going forward. The intent is:

1. Page fault handlers will notice a userfaultfd registration
   (VM_UFFD_MISSING or VM_UFFD_WP).
2. They'll call handle_userfault() to resolve it, with the reason:
   page missing, write protect fault, or (in the future) minor fault,
   etc...

Importantly, the possible reasons for triggering a userfault will no
longer match 1:1 with VM_* flags; there can be > 1 reason to trigger a
fault for a single VM_* flag.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c              | 21 +++++++++------------
 include/linux/userfaultfd_k.h | 12 ++++++++++--
 mm/huge_memory.c              |  4 ++--
 mm/hugetlb.c                  |  2 +-
 mm/memory.c                   |  8 ++++----
 mm/shmem.c                    |  2 +-
 6 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1f4a34b1a1e7..8d663eae0266 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -190,7 +190,7 @@ static inline void msg_init(struct uffd_msg *msg)
 
 static inline struct uffd_msg userfault_msg(unsigned long address,
 					    unsigned int flags,
-					    unsigned long reason,
+					    enum uffd_trigger_reason reason,
 					    unsigned int features)
 {
 	struct uffd_msg msg;
@@ -206,7 +206,7 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
 		 * a write fault.
 		 */
 		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
-	if (reason & VM_UFFD_WP)
+	if (reason == UFFD_REASON_WP)
 		/*
 		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
 		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WP was
@@ -229,7 +229,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 enum uffd_trigger_reason reason)
 {
 	struct mm_struct *mm = ctx->mm;
 	pte_t *ptep, pte;
@@ -251,7 +251,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (huge_pte_none(pte))
 		ret = true;
-	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
+	if (!huge_pte_write(pte) && (reason == UFFD_REASON_WP))
 		ret = true;
 out:
 	return ret;
@@ -261,7 +261,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 enum uffd_trigger_reason reason)
 {
 	return false;	/* should never get here */
 }
@@ -277,7 +277,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 enum uffd_trigger_reason reason)
 {
 	struct mm_struct *mm = ctx->mm;
 	pgd_t *pgd;
@@ -316,7 +316,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
-		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
+		if (!pmd_write(_pmd) && (reason == UFFD_REASON_WP))
 			ret = true;
 		goto out;
 	}
@@ -332,7 +332,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (pte_none(*pte))
 		ret = true;
-	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
+	if (!pte_write(*pte) && (reason == UFFD_REASON_WP))
 		ret = true;
 	pte_unmap(pte);
 
@@ -366,7 +366,7 @@ static inline long userfaultfd_get_blocking_state(unsigned int flags)
  * fatal_signal_pending()s, and the mmap_lock must be released before
  * returning it.
  */
-vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
+vm_fault_t handle_userfault(struct vm_fault *vmf, enum uffd_trigger_reason reason)
 {
 	struct mm_struct *mm = vmf->vma->vm_mm;
 	struct userfaultfd_ctx *ctx;
@@ -401,9 +401,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	BUG_ON(ctx->mm != mm);
 
-	VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
-	VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
-
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
 	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c63ccdae3eab..cc1554e7162f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -9,6 +9,14 @@
 #ifndef _LINUX_USERFAULTFD_K_H
 #define _LINUX_USERFAULTFD_K_H
 
+/* Denotes the reason why handle_userfault() is being triggered. */
+enum uffd_trigger_reason {
+	/* A page was missing. */
+	UFFD_REASON_MISSING,
+	/* A write protect fault occurred. */
+	UFFD_REASON_WP,
+};
+
 #ifdef CONFIG_USERFAULTFD
 
 #include <linux/userfaultfd.h> /* linux/include/uapi/linux/userfaultfd.h */
@@ -32,7 +40,7 @@
 
 extern int sysctl_unprivileged_userfaultfd;
 
-extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
+extern vm_fault_t handle_userfault(struct vm_fault *vmf, enum uffd_trigger_reason reason);
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
@@ -111,7 +119,7 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 
 /* mm helpers */
 static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
-				unsigned long reason)
+				enum uffd_trigger_reason reason)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 395c75111d33..1d740b43bcc5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -629,7 +629,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			spin_unlock(vmf->ptl);
 			put_page(page);
 			pte_free(vma->vm_mm, pgtable);
-			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
+			ret2 = handle_userfault(vmf, UFFD_REASON_MISSING);
 			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
 			return ret2;
 		}
@@ -748,7 +748,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			} else if (userfaultfd_missing(vma)) {
 				spin_unlock(vmf->ptl);
 				pte_free(vma->vm_mm, pgtable);
-				ret = handle_userfault(vmf, VM_UFFD_MISSING);
+				ret = handle_userfault(vmf, UFFD_REASON_MISSING);
 				VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			} else {
 				set_huge_zero_page(pgtable, vma->vm_mm, vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0d45a01a85f8..2a90e0b4bf47 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4305,7 +4305,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
-			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
+			ret = handle_userfault(&vmf, UFFD_REASON_MISSING);
 			i_mmap_lock_read(mapping);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/mm/memory.c b/mm/memory.c
index bc4a41ec81aa..995a95826f4d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3100,7 +3100,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return handle_userfault(vmf, VM_UFFD_WP);
+		return handle_userfault(vmf, UFFD_REASON_WP);
 	}
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
@@ -3535,7 +3535,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		/* Deliver the page fault to userland, check inside PT lock */
 		if (userfaultfd_missing(vma)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
+			return handle_userfault(vmf, UFFD_REASON_MISSING);
 		}
 		goto setpte;
 	}
@@ -3577,7 +3577,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		put_page(page);
-		return handle_userfault(vmf, VM_UFFD_MISSING);
+		return handle_userfault(vmf, UFFD_REASON_MISSING);
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -4195,7 +4195,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma)) {
 		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
-			return handle_userfault(vmf, VM_UFFD_WP);
+			return handle_userfault(vmf, UFFD_REASON_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
 	if (vmf->vma->vm_ops->huge_fault) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 06c771d23127..e1e2513b4298 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1849,7 +1849,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	 */
 
 	if (vma && userfaultfd_missing(vma)) {
-		*fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
+		*fault_type = handle_userfault(vmf, UFFD_REASON_MISSING);
 		return 0;
 	}
 
-- 
2.30.0.478.g8a0d178c01-goog

