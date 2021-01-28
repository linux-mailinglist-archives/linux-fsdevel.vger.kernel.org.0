Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048F2308180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhA1Wwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhA1Wvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:51:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA1C0617AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t18so7742875ybb.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m47mS/DSj7Htyr0o8PLyyl7De7a7EM1cgKQ8lSle3DQ=;
        b=V5tdiTRMHldlbl60oNzXMo74EnIwllVGmDdsAa89YaHu7Ozg7ZMpzv3QK+V03lB51F
         La+12l4P8g8I3G1X2QhnU0n2TMo93buamuqII6ydJATJippimZybSJLe3f2BtBpoFv1c
         JohMpNZvp7h8TPsBZNKMBZLGpTRXdMqKdqh77lszPyQuSipzArai2dp9GaSDbSkQVn3h
         gta0JcozJyPilx/aKe+vWxQqI/+EoE5Deq8y38kQkqlEO8MTnuNpTyoNroIWEuOt7DLN
         ESSRU/Rq0s8pGY1uInYbqTZsulPb9Vhy4zPHWnZUQ7xai7t0aFBRBB2fYY4x2+F4hF/v
         4yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m47mS/DSj7Htyr0o8PLyyl7De7a7EM1cgKQ8lSle3DQ=;
        b=JE08mTPIBYs3Ls6jITF0bUeeJCWqjHz+YBE0D8/Dc/cwQmJCSCTdUAJBUVOe7YuCDa
         H/l2phRPYyCoZM4W7uJ6tqP+bNBs7PHOPZ32s9Un26kyYeyzl/bsB3PYDB3l9Tj0IsO1
         lENBO3QrINzhYRL66oqF6UHL8rBNwSjq4K3Lg6FxQ1QlGOP8mIrHK7/i/sCirrzE2Q2c
         OumPw9xV5q+X4h/PW3CiSNv8PvPqK/cfUcPsEX8s6ieKMs/bVdS6EyVdOnZ+6BglPYyU
         HLsyi9crF/ZSE+9OYpABuCa8v+1HwmMvecnrpdlcOmgldzIFYcyU44KX42ng0gCjnjo5
         MlqQ==
X-Gm-Message-State: AOAM531rjtLpUZ4UxeLBjeRjU+JhwwTsQkI3CKTUBaUhA+dPZuHn+BPZ
        CLBaKHgfbzXR2bLmpGMDSAyddAGInVb9F8Xlz12f
X-Google-Smtp-Source: ABdhPJxUpN1zjDUqpEanSW5LNLR55JXbmdeNcq9i42Pl6UqmaBRZqMXcW4ws5NK4XvRHfnw+AAQKrgWNIf4NOGWvIcRe
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:1645:: with SMTP id
 66mr2063884ybw.238.1611874119528; Thu, 28 Jan 2021 14:48:39 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:48:17 -0800
In-Reply-To: <20210128224819.2651899-1-axelrasmussen@google.com>
Message-Id: <20210128224819.2651899-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
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
 fs/userfaultfd.c                 | 67 +++++++++++++++++++++++++++++++
 include/linux/hugetlb.h          |  3 ++
 include/linux/userfaultfd_k.h    | 18 +++++++++
 include/uapi/linux/userfaultfd.h | 21 +++++++++-
 mm/hugetlb.c                     | 26 +++++++-----
 mm/userfaultfd.c                 | 69 +++++++++++++++++++++-----------
 6 files changed, 170 insertions(+), 34 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 968aca3e3ee9..80a3fca389b8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1530,6 +1530,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
 			ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
 
+		/* CONTINUE ioctl is only supported for MINOR ranges. */
+		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR))
+			ioctls_out &= ~((__u64)1 << _UFFDIO_CONTINUE);
+
 		/*
 		 * Now that we scanned all vmas we can already tell
 		 * userland which ioctls methods are guaranteed to
@@ -1883,6 +1887,66 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
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
@@ -1967,6 +2031,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
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
index f94a35296618..79e1f0155afa 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -135,11 +135,14 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+#ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
+				enum mcopy_atomic_mode mode,
 				struct page **pagep);
+#endif
 int hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fb9abaeb4194..2fcb686211e8 100644
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
+	/* Just setup the dst_vma, without modifying the underlying page(s). */
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
index 6f9d8349f818..3d318ef3d180 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4647,6 +4647,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
 /*
  * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
  * modifications for huge pages.
@@ -4656,6 +4657,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
+			    enum mcopy_atomic_mode mode,
 			    struct page **pagep)
 {
 	struct address_space *mapping;
@@ -4668,7 +4670,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	int ret;
 	struct page *page;
 
-	if (!*pagep) {
+	mapping = dst_vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
+
+	if (!*pagep && mode != MCOPY_ATOMIC_CONTINUE) {
 		ret = -ENOMEM;
 		page = alloc_huge_page(dst_vma, dst_addr, 0);
 		if (IS_ERR(page))
@@ -4685,6 +4690,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* don't free the page */
 			goto out;
 		}
+	} else if (mode == MCOPY_ATOMIC_CONTINUE) {
+		ret = -EFAULT;
+		page = find_lock_page(mapping, idx);
+		*pagep = NULL;
+		if (!page)
+			goto out;
 	} else {
 		page = *pagep;
 		*pagep = NULL;
@@ -4697,13 +4708,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
+	if (vm_shared && mode != MCOPY_ATOMIC_CONTINUE) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		ret = -EFAULT;
 		if (idx >= size)
@@ -4763,7 +4769,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	set_page_huge_active(page);
+	if (mode != MCOPY_ATOMIC_CONTINUE)
+		set_page_huge_active(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -4777,6 +4784,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	put_page(page);
 	goto out;
 }
+#endif
 
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b2ce61c1b50d..a762b9cefaea 100644
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
@@ -297,16 +295,17 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 		}
 
-		err = -EEXIST;
-		dst_pteval = huge_ptep_get(dst_pte);
-		if (!huge_pte_none(dst_pteval)) {
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-			goto out_unlock;
+		if (mode != MCOPY_ATOMIC_CONTINUE) {
+			if (!huge_pte_none(huge_ptep_get(dst_pte))) {
+				err = -EEXIST;
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+				i_mmap_unlock_read(mapping);
+				goto out_unlock;
+			}
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-						dst_addr, src_addr, &page);
+					       dst_addr, src_addr, mode, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -408,7 +407,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      bool zeropage);
+				      enum mcopy_atomic_mode mode);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -417,7 +416,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						struct page **page,
-						bool zeropage,
+						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
 	ssize_t err;
@@ -433,22 +432,38 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (!zeropage)
+		switch (mode) {
+		case MCOPY_ATOMIC_NORMAL:
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page,
 					       wp_copy);
-		else
+			break;
+		case MCOPY_ATOMIC_ZEROPAGE:
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
+			break;
+		/* It only makes sense to CONTINUE for shared memory. */
+		case MCOPY_ATOMIC_CONTINUE:
+			err = -EINVAL;
+			break;
+		}
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
-		if (!zeropage)
+		switch (mode) {
+		case MCOPY_ATOMIC_NORMAL:
 			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
 						     dst_vma, dst_addr,
 						     src_addr, page);
-		else
+			break;
+		case MCOPY_ATOMIC_ZEROPAGE:
 			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
 						       dst_vma, dst_addr);
+			break;
+		case MCOPY_ATOMIC_CONTINUE:
+			/* FIXME: Add minor fault interception for shmem. */
+			err = -EINVAL;
+			break;
+		}
 	}
 
 	return err;
@@ -458,7 +473,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      bool zeropage,
+					      enum mcopy_atomic_mode mcopy_mode,
 					      bool *mmap_changing,
 					      __u64 mode)
 {
@@ -527,7 +542,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+						src_start, len, mcopy_mode);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -577,7 +592,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, zeropage, wp_copy);
+				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
@@ -626,14 +641,22 @@ ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
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
2.30.0.365.g02bc693789-goog

