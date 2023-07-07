Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B759874B8F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGGV4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjGGV4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:56:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE62106
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:55:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so1081517276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766951; x=1691358951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=13fFKLFK5UOuV/VKaxpsoKuDeTvwdO4Zasj0G6nnvw4=;
        b=MOZe/4J0t2eY56FwP6+UOnOCO967WEJl1TbQmpEjUkORQByt+zNCfplkM8DFDsfn2O
         r8uJClY/Y8Z5xV1YyuYdtmUraPk6/0cTJYHNmUSZbe/IN5Fu/cCN2a5n6nood0PBJ5ub
         r+oK/nXF6cKIsISrdC7GbKJnOlHWU/fYaofkbzYDjk4RMoXaSDwF7Xm8k0rAsTnBwL6M
         iIH+0ynit7jmNdoNEYTTc4GCckiC0R5j2gDKsv3fFbP7GHFkZpeE0NTYI7CtMCGaLWtX
         veWaDAElReFjefLsUGuuOtLuP8wj+UPVmDqBKLb1/cz2GLGjcNUxr2o85TMD4Ekuetv1
         Bkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766951; x=1691358951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13fFKLFK5UOuV/VKaxpsoKuDeTvwdO4Zasj0G6nnvw4=;
        b=OKiinp2LNuYuHfQmQr+uQJ6VEOD8jxA5q4ZDTK+cm2ML+VzVwLHxIzw91p7wBeDWic
         BZQoTOXypWjLo6uVptTPlZcr9wR8T4+dxJd9F0CFo/Psgp9TS7UMWM2djKCbmBVmFqRE
         qJsK2eOxX/K3L5jMbbVhRXbqVdbT3rQ6SjxvIbhQo6QK4QpqYQLveg6+AwXNgrkDnBGw
         zUEIAmIeyvoPoydEQEoeXQECzt0kP3WeXkQXCCvSGwrY0I/L1rjhLLi4abTlLGmGotqx
         CyHRL91XNkjPt0u0wyTXZlCnA3p1CU4cLweO3CqSmBvf244VpXJQemKgFUnMcdy80c8t
         g6cg==
X-Gm-Message-State: ABy/qLZV7ZIxIdQpyGU5ZGBx+IibNrnPy2kCR6kbOf1J8sFSo5MavmBO
        CN6lp0A164FuKyhH9bRoxN/dUeaekhvfOymu1RXs
X-Google-Smtp-Source: APBJJlE6DEJsijlYNuZPo3I86aUhHhB3DQHO8fcNF8FmogVn4S+pUbHfGvuKc4J+MOTJwTKMVeH0FM48t2P4Yv+ogdSs
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:c86:0:b0:c02:7c99:62e with SMTP
 id i6-20020a5b0c86000000b00c027c99062emr64646ybq.13.1688766950995; Fri, 07
 Jul 2023 14:55:50 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:36 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-5-axelrasmussen@google.com>
Subject: [PATCH v4 4/8] mm: userfaultfd: add new UFFDIO_POISON ioctl
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
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
- If so, we can respond with a UFFDIO_POISON - this places a swap marker
  so any future accesses will SIGBUS. Because the pte is now "present",
  future accesses won't generate more userfaultfd events, they'll just
  SIGBUS directly.

UFFDIO_POISON does not handle unmapping previously-present PTEs. This
isn't needed, because during live migration we want to intercept
all accesses with userfaultfd (not just writes, so WP mode isn't useful
for this). So whether minor or missing mode is being used (or both), the
PTE won't be present in any case, so handling that case isn't needed.

Similarly, UFFDIO_POISON won't replace existing PTE markers. This might
be okay to do, but it seems to be safer to just refuse to overwrite any
existing entry (like a UFFD_WP PTE marker).

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 58 ++++++++++++++++++++++++++++++++
 include/linux/userfaultfd_k.h    |  4 +++
 include/uapi/linux/userfaultfd.h | 16 +++++++++
 mm/userfaultfd.c                 | 48 +++++++++++++++++++++++++-
 4 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2e84684c46f0..53a7220c4679 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1956,6 +1956,61 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	return ret;
 }
 
+static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long arg)
+{
+	__s64 ret;
+	struct uffdio_poison uffdio_poison;
+	struct uffdio_poison __user *user_uffdio_poison;
+	struct userfaultfd_wake_range range;
+
+	user_uffdio_poison = (struct uffdio_poison __user *)arg;
+
+	ret = -EAGAIN;
+	if (atomic_read(&ctx->mmap_changing))
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(&uffdio_poison, user_uffdio_poison,
+			   /* don't copy the output fields */
+			   sizeof(uffdio_poison) - (sizeof(__s64))))
+		goto out;
+
+	ret = validate_range(ctx->mm, uffdio_poison.range.start,
+			     uffdio_poison.range.len);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	if (uffdio_poison.mode & ~UFFDIO_POISON_MODE_DONTWAKE)
+		goto out;
+
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mfill_atomic_poison(ctx->mm, uffdio_poison.range.start,
+					  uffdio_poison.range.len,
+					  &ctx->mmap_changing, 0);
+		mmput(ctx->mm);
+	} else {
+		return -ESRCH;
+	}
+
+	if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
+		return -EFAULT;
+	if (ret < 0)
+		goto out;
+
+	/* len == 0 would wake all */
+	BUG_ON(!ret);
+	range.len = ret;
+	if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
+		range.start = uffdio_poison.range.start;
+		wake_userfault(ctx, &range);
+	}
+	ret = range.len == uffdio_poison.range.len ? 0 : -EAGAIN;
+
+out:
+	return ret;
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -2057,6 +2112,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_CONTINUE:
 		ret = userfaultfd_continue(ctx, arg);
 		break;
+	case UFFDIO_POISON:
+		ret = userfaultfd_poison(ctx, arg);
+		break;
 	}
 	return ret;
 }
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac7b0c96d351..ac8c6854097c 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -46,6 +46,7 @@ enum mfill_atomic_mode {
 	MFILL_ATOMIC_COPY,
 	MFILL_ATOMIC_ZEROPAGE,
 	MFILL_ATOMIC_CONTINUE,
+	MFILL_ATOMIC_POISON,
 	NR_MFILL_ATOMIC_MODES,
 };
 
@@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
 extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
 				     unsigned long len, atomic_t *mmap_changing,
 				     uffd_flags_t flags);
+extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
+				   unsigned long len, atomic_t *mmap_changing,
+				   uffd_flags_t flags);
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 66dd4cd277bd..b5f07eacc697 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -71,6 +71,7 @@
 #define _UFFDIO_ZEROPAGE		(0x04)
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
+#define _UFFDIO_POISON			(0x08)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -91,6 +92,8 @@
 				      struct uffdio_writeprotect)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
 				      struct uffdio_continue)
+#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
+				      struct uffdio_poison)
 
 /* read() structure */
 struct uffd_msg {
@@ -225,6 +228,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_POISON			(1<<14)
 	__u64 features;
 
 	__u64 ioctls;
@@ -321,6 +325,18 @@ struct uffdio_continue {
 	__s64 mapped;
 };
 
+struct uffdio_poison {
+	struct uffdio_range range;
+#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
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
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4244ca7ee903..68157359dc34 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -288,6 +288,40 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	goto out;
 }
 
+/* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
+static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
+				   struct vm_area_struct *dst_vma,
+				   unsigned long dst_addr,
+				   uffd_flags_t flags)
+{
+	int ret;
+	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	pte_t _dst_pte, *dst_pte;
+	spinlock_t *ptl;
+
+	_dst_pte = make_pte_marker(PTE_MARKER_POISONED);
+	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	if (mfill_file_over_size(dst_vma, dst_addr)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	ret = -EEXIST;
+	/* Refuse to overwrite any PTE, even a PTE marker (e.g. UFFD WP). */
+	if (!pte_none(*dst_pte))
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
@@ -339,7 +373,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
+	    uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
@@ -483,6 +518,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
 		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
 						 dst_addr, flags);
+	} else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
+		return mfill_atomic_pte_poison(dst_pmd, dst_vma,
+					       dst_addr, flags);
 	}
 
 	/*
@@ -704,6 +742,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }
 
+ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
+			    unsigned long len, atomic_t *mmap_changing,
+			    uffd_flags_t flags)
+{
+	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
+			    uffd_flags_set_mode(flags, MFILL_ATOMIC_POISON));
+}
+
 long uffd_wp_range(struct vm_area_struct *dst_vma,
 		   unsigned long start, unsigned long len, bool enable_wp)
 {
-- 
2.41.0.255.g8b1d071c50-goog

