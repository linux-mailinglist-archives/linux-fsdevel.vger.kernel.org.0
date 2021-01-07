Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339CD2ED728
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbhAGTFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbhAGTFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:05:48 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA47C0612F9
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 11:05:08 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l3so6205691qvr.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Qh9e4f349O4oNSnOmzR94pOxYsoiWswUDDXdZ5MBYyY=;
        b=owTCzFP9EaM/Y3QL2y/Us5oS4RsMXLbEAS1U+A2gFhI7UbMaGpbORry3Fm2V1BMA9O
         GHlQEjG1LH3lZojDT33Wz6jhBOJIdyQn4utbfDPjezAscqLEqdGFPp+JWtYr39xDC8zj
         sGDmJBWhdSxuDY5lKI6Tmwu/IseWq5P3d98LPVdkgRWQznLqTkQXYA+wuBxIT9nbu2Ib
         cd7YJXfnWBqZUWDqOV7aUV5OJzW2rGfHQaGoz37rTMowpUhi5NlRLKGNqRmVb1anDbYm
         lNtDHK6r70F5AisKjgdKbcLj2gmi6qVV/yo/D8Y2SyIbNez/PHYmIhDkJzYYCrQOQB18
         Z0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qh9e4f349O4oNSnOmzR94pOxYsoiWswUDDXdZ5MBYyY=;
        b=pLwPzyjf/c0sgPteK7B6ymTfsFP/Z3NS9glDzU8XoGSBSe8Le9XDdFdr6hgBeGa3Wp
         FVp35BZOUY9xJAxs1jnFaXfv38Jf38uvm2KQ4Cs10uQ1HJ1/2WbKl1omtIrxBSnqf2ti
         KJ+BqJkWx7WqrESsnCQzaA8bhWsuTSSfEUA23gvLSPH5YJXylfFBaGZELVa0bE1LzM3O
         mrMlqbaitq+n83nq6+Y8titTsgqVLOihzWGX8AnUexfTs678Qd2umItCSRwxTewJrE3l
         snNF5e6S/oJyPFmqqrkQtIj6aWHNwfYH88DhnMA1PngonIkLMdQKJgIJs7/zlCg4VtSC
         Cukg==
X-Gm-Message-State: AOAM5319/zpo+smwFsI7vOfUazVSOph/i+/kcZ+PEApkETE1m2OFTdf6
        BSFSZ0EjfjOYOz7fGYF97ADjbO9bWstZtZghjxJx
X-Google-Smtp-Source: ABdhPJwggCSsAQbUjhdmFTUypbIsQTjn37rTPT+O7wfBdaFO/fCx/HQpG1XAWXjiUpv/iLA1/jMpMF14K+i9H/sIqe/L
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:a366:: with SMTP id
 u93mr10037684qvu.53.1610046307155; Thu, 07 Jan 2021 11:05:07 -0800 (PST)
Date:   Thu,  7 Jan 2021 11:04:52 -0800
In-Reply-To: <20210107190453.3051110-1-axelrasmussen@google.com>
Message-Id: <20210107190453.3051110-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210107190453.3051110-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [RFC PATCH 1/2] userfaultfd: add minor fault registration mode
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
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This feature allows userspace to intercept "minor" faults. By "minor"
fault, I mean the following situation:

Let there exist two mappings (i.e., VMAs) to the same page(s) (shared
memory). One of the mappings is registered with userfaultfd (in minor
mode), and the other is not. Via the non-UFFD mapping, the underlying
pages have already been allocated & filled with some contents. The UFFD
mapping has not yet been faulted in; when it is touched for the first
time, this results in what I'm calling a "minor" fault. As a concrete
example, when working with hugetlbfs, we have huge_pte_none(), but
find_lock_page() finds an existing page.

This commit adds the new registration mode, and sets the relevant flag
on the VMAs being registered. In the hugetlb fault path, if we find
that we have huge_pte_none(), but find_lock_page() does indeed find an
existing page, then we have a "minor" fault, and if the VMA has the
userfaultfd registration flag, we call into userfaultfd to handle it.

Why add a new registration mode, as opposed to adding a feature to
MISSING registration, like UFFD_FEATURE_SIGBUS?

- The semantics are significantly different. UFFDIO_COPY or
  UFFDIO_ZEROPAGE do not make sense for these minor faults; userspace
  would instead just memset() or memcpy() or whatever via the non-UFFD
  mapping. Unlike MISSING registration, MINOR registration only makes
  sense for shared memory (hugetlbfs or shmem [to be supported in future
  commits]).

- Doing so would make handle_userfault()'s "reason" argument confusing.
  We'd pass in "MISSING" even if the pages weren't really missing.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/proc/task_mmu.c               |  1 +
 fs/userfaultfd.c                 | 80 +++++++++++++++++++-------------
 include/linux/mm.h               |  1 +
 include/linux/userfaultfd_k.h    | 12 ++++-
 include/trace/events/mmflags.h   |  1 +
 include/uapi/linux/userfaultfd.h | 15 +++++-
 mm/hugetlb.c                     | 31 +++++++++++++
 7 files changed, 107 insertions(+), 34 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ee5a235b3056..108faf719a83 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -651,6 +651,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MTE)]		= "mt",
 		[ilog2(VM_MTE_ALLOWED)]	= "",
 #endif
+		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #ifdef CONFIG_ARCH_HAS_PKEYS
 		/* These come out via ProtectionKey: */
 		[ilog2(VM_PKEY_BIT0)]	= "",
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..0a661422eb19 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -28,6 +28,8 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
+#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
+
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
@@ -196,24 +198,21 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
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
@@ -400,8 +399,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	BUG_ON(ctx->mm != mm);
 
-	VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
-	VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
+	/* Any unrecognized flag is a bug. */
+	VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
+	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
+	VM_BUG_ON(!reason || !!(reason & (reason - 1)));
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
@@ -611,7 +612,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+				vma->vm_flags &= ~__VM_UFFD_FLAGS;
 			}
 		mmap_write_unlock(mm);
 
@@ -643,7 +644,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 		return 0;
 	}
 
@@ -725,7 +726,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 	} else {
 		/* Drop uffd context if remap feature not enabled */
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+		vma->vm_flags &= ~__VM_UFFD_FLAGS;
 	}
 }
 
@@ -866,12 +867,12 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
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
@@ -1260,9 +1261,26 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
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
+		/*
+		 * The use case for minor registration (intercepting minor
+		 * faults) is to handle the case where a page is present, but
+		 * needs to be modified before it can be used. This requires
+		 * two mappings: one with UFFD registration, and one without.
+		 * So, it only makes sense to do this with shared memory.
+		 */
+		/* FIXME: Add minor fault interception for shmem. */
+		if (!(is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SHARED)))
+			return false;
+	}
+
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
 }
 
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
@@ -1288,14 +1306,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
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
+	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR)
+		vm_flags |= VM_UFFD_MINOR;
 
 	ret = validate_range(mm, &uffdio_register.range.start,
 			     uffdio_register.range.len);
@@ -1339,7 +1358,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
+		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/* check not compatible vmas */
 		ret = -EINVAL;
@@ -1419,8 +1438,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
-		new_flags = (vma->vm_flags &
-			     ~(VM_UFFD_MISSING|VM_UFFD_WP)) | vm_flags;
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1539,7 +1557,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
-		       !!(cur->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
+		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
 		/*
 		 * Check not compatible vmas, not strictly required
@@ -1590,7 +1608,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
-		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
+		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..1d7041bd3148 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -276,6 +276,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
 #define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
+#define VM_UFFD_MINOR	0x00002000	/* minor fault interception */
 
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000	/* Memory mapped I/O or similar */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..0c8c5fa5efc8 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -62,6 +62,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
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
@@ -76,7 +81,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
 
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
+	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
@@ -123,6 +128,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
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
index 67018d367b9f..2d583ffd4100 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -151,6 +151,7 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
 	{VM_PFNMAP,			"pfnmap"	},		\
 	{VM_DENYWRITE,			"denywrite"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
+	{VM_UFFD_MINOR,			"uffd_minor"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
 	{VM_SEQ_READ,			"seqread"	},		\
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 5f2d88212f7c..1cc2cd8a5279 100644
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
+			   UFFD_FEATURE_MINOR_FAULT_HUGETLBFS)
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
+	 * UFFD_FEATURE_MINOR_FAULT_HUGETLBFS indicates that minor faults
+	 * can be intercepted (via REGISTER_MODE_MINOR) for
+	 * hugetlbfs-backed pages.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -181,6 +190,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
+#define UFFD_FEATURE_MINOR_FAULT_HUGETLBFS	(1<<9)
 	__u64 features;
 
 	__u64 ioctls;
@@ -195,6 +205,7 @@ struct uffdio_register {
 	struct uffdio_range range;
 #define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
 #define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
+#define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
 	__u64 mode;
 
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a2602969873d..0ba8f2f5a4ae 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4377,6 +4377,37 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		}
 	}
 
+	/* Check for page in userfault range. */
+	if (!new_page && userfaultfd_minor(vma)) {
+		u32 hash;
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.flags = flags,
+			/*
+			 * Hard to debug if it ends up being used by a callee
+			 * that assumes something about the other uninitialized
+			 * fields... same as in memory.c
+			 */
+		};
+
+		unlock_page(page);
+
+		/*
+		 * hugetlb_fault_mutex and i_mmap_rwsem must be dropped before
+		 * handling userfault.  Reacquire after handling fault to make
+		 * calling code simpler.
+		 */
+
+		hash = hugetlb_fault_mutex_hash(mapping, idx);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		ret = handle_userfault(&vmf, VM_UFFD_MINOR);
+		i_mmap_lock_read(mapping);
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		goto out;
+	}
+
 	/*
 	 * If we are going to COW a private mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that
-- 
2.29.2.729.g45daf8777d-goog

