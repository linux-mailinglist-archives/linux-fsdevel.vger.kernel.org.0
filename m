Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B26FF973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 20:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbjEKSYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjEKSYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 14:24:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629151FEE
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9e2b65f2eeso16114385276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683829473; x=1686421473;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pi6QoZ5SCLGgP2sxC+MkaEgbY1VXhaAz9TEP3dwrDPs=;
        b=zpyNZKJdhGrBM4FCCCFdLJNUeHu7VB5x1zBza86yuRYT//8gc05k3M+A1XAjXeHYQU
         XsEPOjhIWX936abY0RAnUz756Co2yEtSnUBul6v6sCxjIPkPJgNCvPmNFhIN62HuVOE1
         irkrkZ4ocjIKKQeR0IfXiH2yEHFBjv0I6mZrVd3b7aEQFXXsYHEuLzZoJ1h6qn/7NkBG
         Kjw+bEIhpmgecGP8AQgNQNhH64/X0SBEYMkbt0iVzYsNyZ87+y4B+sEecTBCV4ftXZHx
         CwAYGbE8i4Tg39vPlkbL8N9Ogy15Z6Fr4rHTurnmFTOuV0J1qAkQm721UxKaMxjwzdwc
         hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829473; x=1686421473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi6QoZ5SCLGgP2sxC+MkaEgbY1VXhaAz9TEP3dwrDPs=;
        b=S1PJiTgXvUdBWVgtrfucQXShSX3Tw15dHN7LVlqoRgUfdgixw3phI1ybzXFG01eCsV
         /cTzyX1FH5acwdJ6hGcgaXyIsOJUMB2PMsakbd+Fm3D4l/Or2fsOSBv2nIbiJSjmfVIw
         DMkoaF33nVxd3c73zSAZenMYNrmMvoS+S3FbGPFVCoX/bb5OiZhbb4faNZ/DDahPscP1
         J3+nHZxORwjWyTdUaxl/mNJQ2/0aBvJqKlOF5yuScsOfi5vITY8oyyXhlVih3gikPvr4
         3npSW7cipVKw5wG/zqQn63azn82PGK2XhAH6WqyqshT9vOgTKrTijP8GD79vdB6WXNmQ
         /muA==
X-Gm-Message-State: AC+VfDypZOiZwVGJuvSlWz4ot8OO13O2KlZ5WQlKAfB4ntEOYlIvkhit
        xMJQQkeBYb+LJJ4oCEbMA4b2VGzRhWXTTeQRLjiC
X-Google-Smtp-Source: ACHHUZ7u4hIr1abfAjSfObToFMnjaZ5a7i67wz1z8K+AHbBfqmL+8z0DeI0fgjzjTRoAf5zNOgmTizL/c3RRg3dEL+oU
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:1119:8675:ddb3:1e7a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:114e:b0:b4a:3896:bc17 with
 SMTP id p14-20020a056902114e00b00b4a3896bc17mr9915594ybu.0.1683829473641;
 Thu, 11 May 2023 11:24:33 -0700 (PDT)
Date:   Thu, 11 May 2023 11:24:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511182426.1898675-1-axelrasmussen@google.com>
Subject: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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

The basic idea here is to "simulate" memory poisoning for VMs. A VM
running on some host might encounter a memory error, after which some
page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
once poisoned, pages can never become "un-poisoned". So, when we live
migrate the VM, we need to preserve the poisoned status of these pages.

When live migrating, we try to get the guest running on its new host as
quickly as possible. So, we start it running before all memory has been
copied, and before we're certain which pages should be poisoned or not.

So the basic way to use this new feature is:

- On the new host, the guest's memory is registered with userfaultfd, in
  either MISSING or MINOR mode (doesn't really matter for this purpose).
- On any first access, we get a userfaultfd event. At this point we can
  communicate with the old host to find out if the page was poisoned.
- If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
  so any future accesses will SIGBUS. Because the pte is now "present",
  future accesses won't generate more userfaultfd events, they'll just
  SIGBUS directly.

UFFDIO_SIGBUS does not handle unmapping previously-present PTEs. This
isn't needed, because during live migration we want to intercept
all accesses with userfaultfd (not just writes, so WP mode isn't useful
for this). So whether minor or missing mode is being used (or both), the
PTE won't be present in any case, so handling that case isn't needed.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 63 ++++++++++++++++++++++++++++++++
 include/linux/swapops.h          |  3 +-
 include/linux/userfaultfd_k.h    |  4 ++
 include/uapi/linux/userfaultfd.h | 25 +++++++++++--
 mm/memory.c                      |  4 ++
 mm/userfaultfd.c                 | 62 ++++++++++++++++++++++++++++++-
 6 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..edc2928dae2b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1966,6 +1966,66 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	return ret;
 }
 
+static inline int userfaultfd_sigbus(struct userfaultfd_ctx *ctx, unsigned long arg)
+{
+	__s64 ret;
+	struct uffdio_sigbus uffdio_sigbus;
+	struct uffdio_sigbus __user *user_uffdio_sigbus;
+	struct userfaultfd_wake_range range;
+
+	user_uffdio_sigbus = (struct uffdio_sigbus __user *)arg;
+
+	ret = -EAGAIN;
+	if (atomic_read(&ctx->mmap_changing))
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(&uffdio_sigbus, user_uffdio_sigbus,
+			   /* don't copy the output fields */
+			   sizeof(uffdio_sigbus) - (sizeof(__s64))))
+		goto out;
+
+	ret = validate_range(ctx->mm, uffdio_sigbus.range.start,
+			     uffdio_sigbus.range.len);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	/* double check for wraparound just in case. */
+	if (uffdio_sigbus.range.start + uffdio_sigbus.range.len <=
+	    uffdio_sigbus.range.start) {
+		goto out;
+	}
+	if (uffdio_sigbus.mode & ~UFFDIO_SIGBUS_MODE_DONTWAKE)
+		goto out;
+
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mfill_atomic_sigbus(ctx->mm, uffdio_sigbus.range.start,
+					  uffdio_sigbus.range.len,
+					  &ctx->mmap_changing, 0);
+		mmput(ctx->mm);
+	} else {
+		return -ESRCH;
+	}
+
+	if (unlikely(put_user(ret, &user_uffdio_sigbus->updated)))
+		return -EFAULT;
+	if (ret < 0)
+		goto out;
+
+	/* len == 0 would wake all */
+	BUG_ON(!ret);
+	range.len = ret;
+	if (!(uffdio_sigbus.mode & UFFDIO_SIGBUS_MODE_DONTWAKE)) {
+		range.start = uffdio_sigbus.range.start;
+		wake_userfault(ctx, &range);
+	}
+	ret = range.len == uffdio_sigbus.range.len ? 0 : -EAGAIN;
+
+out:
+	return ret;
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -2067,6 +2127,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_CONTINUE:
 		ret = userfaultfd_continue(ctx, arg);
 		break;
+	case UFFDIO_SIGBUS:
+		ret = userfaultfd_sigbus(ctx, arg);
+		break;
 	}
 	return ret;
 }
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3a451b7afcb3..fa778a0ae730 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -405,7 +405,8 @@ typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP			BIT(0)
 #define  PTE_MARKER_SWAPIN_ERROR		BIT(1)
-#define  PTE_MARKER_MASK			(BIT(2) - 1)
+#define  PTE_MARKER_UFFD_SIGBUS			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index d78b01524349..6de1084939c5 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -46,6 +46,7 @@ enum mfill_atomic_mode {
 	MFILL_ATOMIC_COPY,
 	MFILL_ATOMIC_ZEROPAGE,
 	MFILL_ATOMIC_CONTINUE,
+	MFILL_ATOMIC_SIGBUS,
 	NR_MFILL_ATOMIC_MODES,
 };
 
@@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
 				     unsigned long len, atomic_t *mmap_changing,
 				     uffd_flags_t flags);
+extern ssize_t mfill_atomic_sigbus(struct mm_struct *dst_mm, unsigned long start,
+				   unsigned long len, atomic_t *mmap_changing,
+				   uffd_flags_t flags);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 66dd4cd277bd..616e33d3db97 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -39,7 +39,8 @@
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
-			   UFFD_FEATURE_WP_UNPOPULATED)
+			   UFFD_FEATURE_WP_UNPOPULATED |	\
+			   UFFD_FEATURE_SIGBUS_IOCTL)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -49,12 +50,14 @@
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
-	 (__u64)1 << _UFFDIO_CONTINUE)
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_SIGBUS)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_WRITEPROTECT)
+	 (__u64)1 << _UFFDIO_SIGBUS)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -71,6 +74,7 @@
 #define _UFFDIO_ZEROPAGE		(0x04)
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
+#define _UFFDIO_SIGBUS			(0x08)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -91,6 +95,8 @@
 				      struct uffdio_writeprotect)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
 				      struct uffdio_continue)
+#define UFFDIO_SIGBUS		_IOWR(UFFDIO, _UFFDIO_SIGBUS, \
+				      struct uffdio_sigbus)
 
 /* read() structure */
 struct uffd_msg {
@@ -225,6 +231,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_SIGBUS_IOCTL		(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
@@ -321,6 +328,18 @@ struct uffdio_continue {
 	__s64 mapped;
 };
 
+struct uffdio_sigbus {
+	struct uffdio_range range;
+#define UFFDIO_SIGBUS_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 updated;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..e4b4207c2590 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3675,6 +3675,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (WARN_ON_ONCE(!marker))
 		return VM_FAULT_SIGBUS;
 
+	/* SIGBUS explicitly requested for this PTE. */
+	if (marker & PTE_MARKER_UFFD_SIGBUS)
+		return VM_FAULT_SIGBUS;
+
 	/* Higher priority than uffd-wp when data corrupted */
 	if (marker & PTE_MARKER_SWAPIN_ERROR)
 		return VM_FAULT_SIGBUS;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e97a0b4889fc..933587eebd5d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -278,6 +278,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	goto out;
 }
 
+/* Handles UFFDIO_SIGBUS for all non-hugetlb VMAs. */
+static int mfill_atomic_pte_sigbus(pmd_t *dst_pmd,
+				   struct vm_area_struct *dst_vma,
+				   unsigned long dst_addr,
+				   uffd_flags_t flags)
+{
+	int ret;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	pte_t _dst_pte, *dst_pte;
+	spinlock_t *ptl;
+
+	_dst_pte = make_pte_marker(PTE_MARKER_UFFD_SIGBUS);
+	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	if (vma_is_shmem(dst_vma)) {
+		struct inode *inode;
+		pgoff_t offset, max_off;
+
+		/* serialize against truncate with the page table lock */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_unlock;
+	}
+
+	ret = -EEXIST;
+	/*
+	 * For now, we don't handle unmapping pages, so only support filling in
+	 * none PTEs, or replacing PTE markers.
+	 */
+	if (!pte_none_mostly(*dst_pte))
+		goto out_unlock;
+
+	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	ret = 0;
+out_unlock:
+	pte_unmap_unlock(dst_pte, ptl);
+	return ret;
+}
+
 static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 {
 	pgd_t *pgd;
@@ -328,8 +373,12 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
+	 *
+	 * PTE marker handling for hugetlb is a bit special, so for now
+	 * UFFDIO_SIGBUS is not supported.
 	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
+	    uffd_flags_mode_is(flags, MFILL_ATOMIC_SIGBUS)) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -473,6 +522,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
 		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
 						 dst_addr, flags);
+	} else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_SIGBUS)) {
+		return mfill_atomic_pte_sigbus(dst_pmd, dst_vma,
+					       dst_addr, flags);
 	}
 
 	/*
@@ -694,6 +746,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }
 
+ssize_t mfill_atomic_sigbus(struct mm_struct *dst_mm, unsigned long start,
+			    unsigned long len, atomic_t *mmap_changing,
+			    uffd_flags_t flags)
+{
+	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+			    uffd_flags_set_mode(flags, MFILL_ATOMIC_SIGBUS));
+}
+
 long uffd_wp_range(struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
-- 
2.40.1.606.ga4b1b128d6-goog

