Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5231F36A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBSAuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 19:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBSAt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:49:59 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6FC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:41 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d19so1471523qvm.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7idwpZf2NXqXQAKc+dHkceFTCeacQ9+x+zBeeDMWhSk=;
        b=Qa9WRCDM2qqQH7s1DqDy44bSxvnrQLwm/QLl6lO8n7TSwjhSk7gDG3U/lxrbpppBk7
         CNz/FAtgOA6eKnU/pZv1Jqhg9Qk2J+t3jrKddcl/o65T7TPFmlT+/D3ub44LO1wEGWQW
         QxbvgKn68M73n/JaAfJmcK/XgDwAeP8wW10qDQOc61r7Xe2yV1Dz8GXQdReAapfOITq8
         wGXDkWd2eYOd5UvkNsLaBj1P23u1cmH+34+6MMMRiD/lWF4R0OFglhYkrH+4m/3MkaTB
         MmBpwr1BNkAsXie4U33EqgDb/2zEHe9RBOBzvm+KXux0AwSFX440Y0sSoqbTbh+Wu8Vr
         GiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7idwpZf2NXqXQAKc+dHkceFTCeacQ9+x+zBeeDMWhSk=;
        b=P+G/rSKElfxPgj6OVI6uWnGFETzniG3yPYxu6aOYjCXNES1akY0tOwZ0Z5AyTEfoS+
         Qy9rEm6YSfjnedKT8Scr1Yhnzd+TL5y5X5iHdtDEdsTSd3Ko/CTZw2sCI6R3bXuFgMub
         D9jpP7XYvzLndR2Wav2f5WmC087nUSo5zMiYtqVVFB+45HCrny5iSV5XAxm0GJ4mkWWv
         8nyDkEH4Bl4Tnzi4cK6wVMVSuQD3WG3THLgxMIZpd4xzJgiISHpKSIx0wOT2m2gPCnCA
         L6g+fUzPdpto9S84XfzXyxAeYO10OpwmLQg12GclnlikVjPZhdNYOZJfpYXiQWBPuYas
         /gmQ==
X-Gm-Message-State: AOAM5336yFLNKnrYJTR3ACQjiBJBfj3Dat8Ylx9fYmspAT2vRBRY7Kzq
        R2NZagcr01DlIDN1IhCONCK0y4gaBKVORmQu7I2m
X-Google-Smtp-Source: ABdhPJzj8rxh9B4Lp7Lc0trUDZ6nGcTqHauXl7kqBC35mXG9HzWIWFnyiPrGfUAj7ZqfD6tvDvIQkg7pSJkL8fCRDil2
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:b929:: with SMTP id
 u41mr7174819qvf.30.1613695719449; Thu, 18 Feb 2021 16:48:39 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:22 -0800
In-Reply-To: <20210219004824.2899045-1-axelrasmussen@google.com>
Message-Id: <20210219004824.2899045-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
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

This ioctl is how userspace ought to resolve "minor" userfaults. The
idea is, userspace is notified that a minor fault has occurred. It might
change the contents of the page using its second non-UFFD mapping, or
not. Then, it calls UFFDIO_CONTINUE to tell the kernel "I have ensured
the page contents are correct, carry on setting up the mapping".

Note that it doesn't make much sense to use UFFDIO_{COPY,ZEROPAGE} for
MINOR registered VMAs. ZEROPAGE maps the VMA to the zero page; but in
the minor fault case, we already have some pre-existing underlying page.
Likewise, UFFDIO_COPY isn't useful if we have a second non-UFFD mapping.
We'd just use memcpy() or similar instead.

It turns out hugetlb_mcopy_atomic_pte() already does very close to what
we want, if an existing page is provided via `struct page **pagep`. We
already special-case the behavior a bit for the UFFDIO_ZEROPAGE case, so
just extend that design: add an enum for the three modes of operation,
and make the small adjustments needed for the MCOPY_ATOMIC_CONTINUE
case. (Basically, look up the existing page, and avoid adding the
existing page to the page cache or calling set_page_huge_active() on
it.)

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 67 ++++++++++++++++++++++++++++++++
 include/linux/hugetlb.h          |  3 ++
 include/linux/userfaultfd_k.h    | 18 +++++++++
 include/uapi/linux/userfaultfd.h | 21 +++++++++-
 mm/hugetlb.c                     | 41 ++++++++++++-------
 mm/userfaultfd.c                 | 37 +++++++++++-------
 6 files changed, 157 insertions(+), 30 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 041449e47870..3b42c09eb043 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1488,6 +1488,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
 			ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
 
+		/* CONTINUE ioctl is only supported for MINOR ranges. */
+		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR))
+			ioctls_out &= ~((__u64)1 << _UFFDIO_CONTINUE);
+
 		/*
 		 * Now that we scanned all vmas we can already tell
 		 * userland which ioctls methods are guaranteed to
@@ -1841,6 +1845,66 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
+{
+	__s64 ret;
+	struct uffdio_continue uffdio_continue;
+	struct uffdio_continue __user *user_uffdio_continue;
+	struct userfaultfd_wake_range range;
+
+	user_uffdio_continue = (struct uffdio_continue __user *)arg;
+
+	ret = -EAGAIN;
+	if (READ_ONCE(ctx->mmap_changing))
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(&uffdio_continue, user_uffdio_continue,
+			   /* don't copy the output fields */
+			   sizeof(uffdio_continue) - (sizeof(__s64))))
+		goto out;
+
+	ret = validate_range(ctx->mm, &uffdio_continue.range.start,
+			     uffdio_continue.range.len);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	/* double check for wraparound just in case. */
+	if (uffdio_continue.range.start + uffdio_continue.range.len <=
+	    uffdio_continue.range.start) {
+		goto out;
+	}
+	if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
+		goto out;
+
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mcopy_continue(ctx->mm, uffdio_continue.range.start,
+				     uffdio_continue.range.len,
+				     &ctx->mmap_changing);
+		mmput(ctx->mm);
+	} else {
+		return -ESRCH;
+	}
+
+	if (unlikely(put_user(ret, &user_uffdio_continue->mapped)))
+		return -EFAULT;
+	if (ret < 0)
+		goto out;
+
+	/* len == 0 would wake all */
+	BUG_ON(!ret);
+	range.len = ret;
+	if (!(uffdio_continue.mode & UFFDIO_CONTINUE_MODE_DONTWAKE)) {
+		range.start = uffdio_continue.range.start;
+		wake_userfault(ctx, &range);
+	}
+	ret = range.len == uffdio_continue.range.len ? 0 : -EAGAIN;
+
+out:
+	return ret;
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -1928,6 +1992,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_WRITEPROTECT:
 		ret = userfaultfd_writeprotect(ctx, arg);
 		break;
+	case UFFDIO_CONTINUE:
+		ret = userfaultfd_continue(ctx, arg);
+		break;
 	}
 	return ret;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7e6d2f126df3..8f2a4fc11b1f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
+#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -139,6 +140,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
+				enum mcopy_atomic_mode mode,
 				struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
@@ -318,6 +320,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
+						enum mcopy_atomic_mode mode,
 						struct page **pagep)
 {
 	BUG();
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e060d5f77cc5..794d1538b8ba 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -37,6 +37,22 @@ extern int sysctl_unprivileged_userfaultfd;
 
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
+/*
+ * The mode of operation for __mcopy_atomic and its helpers.
+ *
+ * This is almost an implementation detail (mcopy_atomic below doesn't take this
+ * as a parameter), but it's exposed here because memory-kind-specific
+ * implementations (e.g. hugetlbfs) need to know the mode of operation.
+ */
+enum mcopy_atomic_mode {
+	/* A normal copy_from_user into the destination range. */
+	MCOPY_ATOMIC_NORMAL,
+	/* Don't copy; map the destination range to the zero page. */
+	MCOPY_ATOMIC_ZEROPAGE,
+	/* Just install pte(s) with the existing page(s) in the page cache. */
+	MCOPY_ATOMIC_CONTINUE,
+};
+
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 			    unsigned long src_start, unsigned long len,
 			    bool *mmap_changing, __u64 mode);
@@ -44,6 +60,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
 			      unsigned long dst_start,
 			      unsigned long len,
 			      bool *mmap_changing);
+extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
+			      unsigned long len, bool *mmap_changing);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, bool *mmap_changing);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index f24dd4fcbad9..bafbeb1a2624 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -40,10 +40,12 @@
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
-	 (__u64)1 << _UFFDIO_WRITEPROTECT)
+	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
+	 (__u64)1 << _UFFDIO_CONTINUE)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
-	 (__u64)1 << _UFFDIO_COPY)
+	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_CONTINUE)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -59,6 +61,7 @@
 #define _UFFDIO_COPY			(0x03)
 #define _UFFDIO_ZEROPAGE		(0x04)
 #define _UFFDIO_WRITEPROTECT		(0x06)
+#define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -77,6 +80,8 @@
 				      struct uffdio_zeropage)
 #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
 				      struct uffdio_writeprotect)
+#define UFFDIO_CONTINUE		_IOR(UFFDIO, _UFFDIO_CONTINUE,	\
+				     struct uffdio_continue)
 
 /* read() structure */
 struct uffd_msg {
@@ -268,6 +273,18 @@ struct uffdio_writeprotect {
 	__u64 mode;
 };
 
+struct uffdio_continue {
+	struct uffdio_range range;
+#define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 mapped;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 301b6b64c04e..2553b0d525aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -39,7 +39,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
 #include <linux/node.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
 #include "internal.h"
 
@@ -4634,8 +4633,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
+			    enum mcopy_atomic_mode mode,
 			    struct page **pagep)
 {
+	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct address_space *mapping;
 	pgoff_t idx;
 	unsigned long size;
@@ -4645,8 +4646,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	spinlock_t *ptl;
 	int ret;
 	struct page *page;
+	int writable;
 
-	if (!*pagep) {
+	mapping = dst_vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
+
+	if (is_continue) {
+		ret = -EFAULT;
+		page = find_lock_page(mapping, idx);
+		*pagep = NULL;
+		if (!page)
+			goto out;
+	} else if (!*pagep) {
 		ret = -ENOMEM;
 		page = alloc_huge_page(dst_vma, dst_addr, 0);
 		if (IS_ERR(page))
@@ -4675,13 +4686,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	__SetPageUptodate(page);
 
-	mapping = dst_vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
-
-	/*
-	 * If shared, add to page cache
-	 */
-	if (vm_shared) {
+	/* Add shared, newly allocated pages to the page cache. */
+	if (vm_shared && !is_continue) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		ret = -EFAULT;
 		if (idx >= size)
@@ -4726,8 +4732,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-	_dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);
-	if (dst_vma->vm_flags & VM_WRITE)
+	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
+	if (is_continue && !vm_shared)
+		writable = 0;
+	else
+		writable = dst_vma->vm_flags & VM_WRITE;
+
+	_dst_pte = make_huge_pte(dst_vma, page, writable);
+	if (writable)
 		_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
@@ -4741,15 +4753,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	SetHPageMigratable(page);
-	if (vm_shared)
+	if (!is_continue)
+		SetHPageMigratable(page);
+	if (vm_shared || is_continue)
 		unlock_page(page);
 	ret = 0;
 out:
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
-	if (vm_shared)
+	if (vm_shared || is_continue)
 		unlock_page(page);
 out_release_nounlock:
 	put_page(page);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b2ce61c1b50d..ce6cb4760d2c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -207,7 +207,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      bool zeropage)
+					      enum mcopy_atomic_mode mode)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -227,7 +227,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (zeropage) {
+	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -273,8 +273,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
-		pte_t dst_pteval;
-
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
@@ -297,16 +295,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = -EEXIST;
-		dst_pteval = huge_ptep_get(dst_pte);
-		if (!huge_pte_none(dst_pteval)) {
+		if (mode != MCOPY_ATOMIC_CONTINUE &&
+		    !huge_pte_none(huge_ptep_get(dst_pte))) {
+			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-						dst_addr, src_addr, &page);
+					       dst_addr, src_addr, mode, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -408,7 +406,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      bool zeropage);
+				      enum mcopy_atomic_mode mode);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -458,7 +456,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      bool zeropage,
+					      enum mcopy_atomic_mode mcopy_mode,
 					      bool *mmap_changing,
 					      __u64 mode)
 {
@@ -469,6 +467,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	long copied;
 	struct page *page;
 	bool wp_copy;
+	bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
 
 	/*
 	 * Sanitize the command parameters:
@@ -527,10 +526,12 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+						src_start, len, mcopy_mode);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
+	if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+		goto out_unlock;
 
 	/*
 	 * Ensure the dst_vma has a anon_vma or this page
@@ -626,14 +627,22 @@ ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
 		     unsigned long src_start, unsigned long len,
 		     bool *mmap_changing, __u64 mode)
 {
-	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false,
-			      mmap_changing, mode);
+	return __mcopy_atomic(dst_mm, dst_start, src_start, len,
+			      MCOPY_ATOMIC_NORMAL, mmap_changing, mode);
 }
 
 ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
 		       unsigned long len, bool *mmap_changing)
 {
-	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
+	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_ZEROPAGE,
+			      mmap_changing, 0);
+}
+
+ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
+		       unsigned long len, bool *mmap_changing)
+{
+	return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
+			      mmap_changing, 0);
 }
 
 int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
-- 
2.30.0.617.g56c4b15f3c-goog

