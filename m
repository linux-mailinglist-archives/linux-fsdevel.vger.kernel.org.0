Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E415329710
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 10:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbhCAWbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbhCAW2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:28:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB4C06178B
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 14:27:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so7919973ybc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iKxOjaMBbFw6gkPZUshE1R3JAZ5TXYFS7WN7qwSZfEA=;
        b=Sa4nFYbPHCUpqXGkb03hxPxAiH6oqTR5tcs2gRJ34f7WgkHDHXD67jbnIJEfDoPMmK
         qwv07BGusuzhAidfsqJeH0jIEpJbz8Nc9wUvTenaV1CBPsABlv1gNSZxqbeZ47LItnkD
         0pPubDj+C5+KdfNtH0tIh2dn9MaBIPJWoPubm2ATPYJOe12NDYI30C3c5oz2I38u/Miy
         6SOht2mAzEZAWaGnxuhzYz0DJFZ4mnIIqlSq73fwMaoIdRMsvs5YIhmAbz+NOiiGwUW1
         WUfqS+v7DlbTvjgbMkhS7p5hsivS1qywqpzD7S136J6kpSbn3tsuY8OSKvCC0r9Y28Wy
         pHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iKxOjaMBbFw6gkPZUshE1R3JAZ5TXYFS7WN7qwSZfEA=;
        b=jiWPFZAV4RCysqT0LX9EUW7vFaaqdESvLOLHp/kpi2C4PE52N20+5wA8+K+kjaS1E0
         lcRQz7lK4Z76pNAEnWgg7NFB9fSSJvsNqOg2lVtFAGW5qgldzRRG4lz8EmiSMh2Yb8J0
         Y3YzQBqAp4xNZHD1CR9kacweIKeDXKlokC5adVDz24GQKQLogwSbC2qYTjtSVqT4b3fL
         xu57Lqwi8j4lsoSiD0mLhScYbzuuENzHO1vWr9+NPws2RUALHNx32HCRkyGKYXXuK1m+
         +DFJHr9zIa1zgLpLTylZ8jRRf0w0/erNPSR3vFXRAea+z/A1m/C+IBMylQz5CkOD25eN
         qBtw==
X-Gm-Message-State: AOAM531AznQLFPDf/hZ0owPu/Kre++V0hel7rkYPjQNuuvdr4OJz7qa3
        QcnYVE0s8Q+qOCKLNQrOJqarnXlf8gF+TSbbDhI+
X-Google-Smtp-Source: ABdhPJzLPv2Tqo5WEtXJ6ld1QQhkRx92kuf94HfB/kXNEsWvJhVAjKBTl0aE4Bx2QqAvfR8GrqcUINtSYAIluVjpKey5
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b223:: with SMTP id
 i35mr25569424ybj.372.1614637657616; Mon, 01 Mar 2021 14:27:37 -0800 (PST)
Date:   Mon,  1 Mar 2021 14:27:23 -0800
In-Reply-To: <20210301222728.176417-1-axelrasmussen@google.com>
Message-Id: <20210301222728.176417-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210301222728.176417-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v9 1/6] userfaultfd: add minor fault registration mode
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

This feature allows userspace to intercept "minor" faults. By "minor"
faults, I mean the following situation:

Let there exist two mappings (i.e., VMAs) to the same page(s). One of
the mappings is registered with userfaultfd (in minor mode), and the
other is not. Via the non-UFFD mapping, the underlying pages have
already been allocated & filled with some contents. The UFFD mapping
has not yet been faulted in; when it is touched for the first time,
this results in what I'm calling a "minor" fault. As a concrete
example, when working with hugetlbfs, we have huge_pte_none(), but
find_lock_page() finds an existing page.

This commit adds the new registration mode, and sets the relevant flag
on the VMAs being registered. In the hugetlb fault path, if we find
that we have huge_pte_none(), but find_lock_page() does indeed find an
existing page, then we have a "minor" fault, and if the VMA has the
userfaultfd registration flag, we call into userfaultfd to handle it.

This is implemented as a new registration mode, instead of an API
feature. This is because the alternative implementation has significant
drawbacks [1].

However, doing it this was requires we allocate a VM_* flag for the new
registration mode. On 32-bit systems, there are no unused bits, so this
feature is only supported on architectures with
CONFIG_ARCH_USES_HIGH_VMA_FLAGS. When attempting to register a VMA in
MINOR mode on 32-bit architectures, we return -EINVAL.

[1] https://lore.kernel.org/patchwork/patch/1380226/

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/x86/Kconfig                 |  1 +
 fs/proc/task_mmu.c               |  3 ++
 fs/userfaultfd.c                 | 78 ++++++++++++++++++-------------
 include/linux/mm.h               |  7 +++
 include/linux/userfaultfd_k.h    | 15 +++++-
 include/trace/events/mmflags.h   |  7 +++
 include/uapi/linux/userfaultfd.h | 15 +++++-
 init/Kconfig                     |  5 ++
 mm/hugetlb.c                     | 79 +++++++++++++++++++++-----------
 10 files changed, 149 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..ce6044273ef1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -208,6 +208,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..7f71b71ed372 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -164,6 +164,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
+	select HAVE_ARCH_USERFAULTFD_MINOR	if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cec6fbef725..e1c9095ebe70 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -661,6 +661,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+		[ilog2(VM_UFFD_MINOR)]	= "ui",
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 	};
 	size_t i;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e5ce3b4e6c3d..ba35cafa8b0d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -197,24 +197,21 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
 	msg_init(&msg);
 	msg.event = UFFD_EVENT_PAGEFAULT;
 	msg.arg.pagefault.address = address;
+	/*
+	 * These flags indicate why the userfault occurred:
+	 * - UFFD_PAGEFAULT_FLAG_WP indicates a write protect fault.
+	 * - UFFD_PAGEFAULT_FLAG_MINOR indicates a minor fault.
+	 * - Neither of these flags being set indicates a MISSING fault.
+	 *
+	 * Separately, UFFD_PAGEFAULT_FLAG_WRITE indicates it was a write
+	 * fault. Otherwise, it was a read fault.
+	 */
 	if (flags & FAULT_FLAG_WRITE)
-		/*
-		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
-		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WRITE
-		 * was not set in a UFFD_EVENT_PAGEFAULT, it means it
-		 * was a read fault, otherwise if set it means it's
-		 * a write fault.
-		 */
 		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WRITE;
 	if (reason & VM_UFFD_WP)
-		/*
-		 * If UFFD_FEATURE_PAGEFAULT_FLAG_WP was set in the
-		 * uffdio_api.features and UFFD_PAGEFAULT_FLAG_WP was
-		 * not set in a UFFD_EVENT_PAGEFAULT, it means it was
-		 * a missing fault, otherwise if set it means it's a
-		 * write protect fault.
-		 */
 		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_WP;
+	if (reason & VM_UFFD_MINOR)
+		msg.arg.pagefault.flags |= UFFD_PAGEFAULT_FLAG_MINOR;
 	if (features & UFFD_FEATURE_THREAD_ID)
 		msg.arg.pagefault.feat.ptid = task_pid_vnr(current);
 	return msg;
@@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	BUG_ON(ctx->mm != mm);
 
-	VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
-	VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
+	/* Any unrecognized flag is a bug. */
+	VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
+	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
+	VM_BUG_ON(!reason || (reason & (reason - 1)));
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
@@ -612,7 +611,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+				vma->vm_flags &= ~__VM_UFFD_FLAGS;
 			}
 		mmap_write_unlock(mm);
 
@@ -644,7 +643,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 		return 0;
 	}
 
@@ -726,7 +725,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	} else {
 		/* Drop uffd context if remap feature not enabled */
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 	}
 }
 
@@ -867,12 +866,12 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
+		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
 		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
 			prev = vma;
 			continue;
 		}
-		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
+		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
@@ -1262,9 +1261,19 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 				     unsigned long vm_flags)
 {
 	/* FIXME: add WP support to hugetlbfs and shmem */
-	return vma_is_anonymous(vma) ||
-		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
-		 !(vm_flags & VM_UFFD_WP));
+	if (vm_flags & VM_UFFD_WP) {
+		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
+			return false;
+	}
+
+	if (vm_flags & VM_UFFD_MINOR) {
+		/* FIXME: Add minor fault interception for shmem. */
+		if (!is_vm_hugetlb_page(vma))
+			return false;
+	}
+
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
 }
 
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
@@ -1290,14 +1299,19 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	ret = -EINVAL;
 	if (!uffdio_register.mode)
 		goto out;
-	if (uffdio_register.mode & ~(UFFDIO_REGISTER_MODE_MISSING|
-				     UFFDIO_REGISTER_MODE_WP))
+	if (uffdio_register.mode & ~UFFD_API_REGISTER_MODES)
 		goto out;
 	vm_flags = 0;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
 		vm_flags |= VM_UFFD_MISSING;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP)
 		vm_flags |= VM_UFFD_WP;
+	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
+#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+		goto out;
+#endif
+		vm_flags |= VM_UFFD_MINOR;
+	}
 
 	ret = validate_range(mm, &uffdio_register.range.start,
 			     uffdio_register.range.len);
@@ -1341,7 +1355,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
+		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
@@ -1421,8 +1435,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
-		new_flags = (vma->vm_flags &
-			     ~(VM_UFFD_MISSING|VM_UFFD_WP)) | vm_flags;
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1544,7 +1557,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
+		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/*
 		 * Check not compatible vmas, not strictly required
@@ -1595,7 +1608,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
-		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
+		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1863,6 +1876,9 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto err_out;
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
+#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+#endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..5ed1316d6ed6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -362,6 +362,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_GROWSUP	VM_NONE
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+# define VM_UFFD_MINOR_BIT	37
+# define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
+#else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+# define VM_UFFD_MINOR		VM_NONE
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c63ccdae3eab..0390e5ac63b3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -17,6 +17,9 @@
 #include <linux/mm.h>
 #include <asm-generic/pgtable_uffd.h>
 
+/* The set of all possible UFFD-related VM flags. */
+#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
+
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
  * new flags, since they might collide with O_* ones. We want
@@ -71,6 +74,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
+static inline bool userfaultfd_minor(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_MINOR;
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
@@ -85,7 +93,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
 
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
+	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
@@ -132,6 +140,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_minor(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 67018d367b9f..629c7a0eaff2 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -137,6 +137,12 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
 #define IF_HAVE_VM_SOFTDIRTY(flag,name)
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+# define IF_HAVE_UFFD_MINOR(flag, name) {flag, name},
+#else
+# define IF_HAVE_UFFD_MINOR(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -148,6 +154,7 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
 	{VM_MAYSHARE,			"mayshare"	},		\
 	{VM_GROWSDOWN,			"growsdown"	},		\
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
+IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
 	{VM_DENYWRITE,			"denywrite"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 5f2d88212f7c..f24dd4fcbad9 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -19,15 +19,19 @@
  * means the userland is reading).
  */
 #define UFFD_API ((__u64)0xAA)
+#define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
+				 UFFDIO_REGISTER_MODE_WP |	\
+				 UFFDIO_REGISTER_MODE_MINOR)
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
-			   UFFD_FEATURE_EVENT_REMOVE |	\
+			   UFFD_FEATURE_EVENT_REMOVE |		\
 			   UFFD_FEATURE_EVENT_UNMAP |		\
 			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
-			   UFFD_FEATURE_THREAD_ID)
+			   UFFD_FEATURE_THREAD_ID |		\
+			   UFFD_FEATURE_MINOR_HUGETLBFS)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -127,6 +131,7 @@ struct uffd_msg {
 /* flags for UFFD_EVENT_PAGEFAULT */
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
 #define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
+#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
 
 struct uffdio_api {
 	/* userland asks for an API number and the features to enable */
@@ -171,6 +176,10 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
 	 * be returned, if feature is not requested 0 will be returned.
+	 *
+	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
+	 * can be intercepted (via REGISTER_MODE_MINOR) for
+	 * hugetlbfs-backed pages.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -181,6 +190,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
+#define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 	__u64 features;
 
 	__u64 ioctls;
@@ -195,6 +205,7 @@ struct uffdio_register {
 	struct uffdio_range range;
 #define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
 #define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
+#define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
 	__u64 mode;
 
 	/*
diff --git a/init/Kconfig b/init/Kconfig
index 22946fe5ded9..d13d942309ce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1628,6 +1628,11 @@ config HAVE_ARCH_USERFAULTFD_WP
 	help
 	  Arch has userfaultfd write protection support
 
+config HAVE_ARCH_USERFAULTFD_MINOR
+	bool
+	help
+	  Arch has userfaultfd minor fault support
+
 config MEMBARRIER
 	bool "Enable membarrier() system call" if EXPERT
 	default y
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cad303306abc..61fd15185f0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4230,6 +4230,44 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 	return 0;
 }
 
+static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
+						  struct address_space *mapping,
+						  pgoff_t idx,
+						  unsigned int flags,
+						  unsigned long haddr,
+						  unsigned long reason)
+{
+	vm_fault_t ret;
+	u32 hash;
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = haddr,
+		.flags = flags,
+
+		/*
+		 * Hard to debug if it ends up being
+		 * used by a callee that assumes
+		 * something about the other
+		 * uninitialized fields... same as in
+		 * memory.c
+		 */
+	};
+
+	/*
+	 * hugetlb_fault_mutex and i_mmap_rwsem must be
+	 * dropped before handling userfault.  Reacquire
+	 * after handling fault to make calling code simpler.
+	 */
+	hash = hugetlb_fault_mutex_hash(mapping, idx);
+	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	i_mmap_unlock_read(mapping);
+	ret = handle_userfault(&vmf, reason);
+	i_mmap_lock_read(mapping);
+	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
+	return ret;
+}
+
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
@@ -4268,35 +4306,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
-		/*
-		 * Check for page in userfault range
-		 */
+		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
-			u32 hash;
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = haddr,
-				.flags = flags,
-				/*
-				 * Hard to debug if it ends up being
-				 * used by a callee that assumes
-				 * something about the other
-				 * uninitialized fields... same as in
-				 * memory.c
-				 */
-			};
-
-			/*
-			 * hugetlb_fault_mutex and i_mmap_rwsem must be
-			 * dropped before handling userfault.  Reacquire
-			 * after handling fault to make calling code simpler.
-			 */
-			hash = hugetlb_fault_mutex_hash(mapping, idx);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
-			i_mmap_lock_read(mapping);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			ret = hugetlb_handle_userfault(vma, mapping, idx,
+						       flags, haddr,
+						       VM_UFFD_MISSING);
 			goto out;
 		}
 
@@ -4355,6 +4369,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				VM_FAULT_SET_HINDEX(hstate_index(h));
 			goto backout_unlocked;
 		}
+
+		/* Check for page in userfault range. */
+		if (userfaultfd_minor(vma)) {
+			unlock_page(page);
+			ret = hugetlb_handle_userfault(vma, mapping, idx,
+						       flags, haddr,
+						       VM_UFFD_MINOR);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.30.1.766.gb4fecdf3b7-goog

