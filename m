Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556474A73E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGFWvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGFWvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:51:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A531FD7
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:50:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-577323ba3d5so34198657b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683858; x=1691275858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJqf0m2qw+Xjs8Quv7ufLANzkWFzCscIfWrhHyj74r4=;
        b=D2k9xCsfeg61xPSIpw+bsBr3jPwLNm9nVEHyGhqfkG8lUTP35cd6IFL212tdgreqNz
         0YlkyIjNjF30q+hjO/oW6G1cNPIRff4f/oHqF7Wy+jVNAq1/WuXr6jz15FTr0ttknNyr
         0KjASHAlCDktsRxguFNoBBTItvv/YFICr/K4mQRPcS2hhFcyPon/giYdNfLAM48U0Jx0
         eXvwik0EB73EKMqASVZMZZsmmHmToMBPVsvzhfYgIrpjZiLkZdUoFdyj4hnakuxSym+M
         ulEcJTqFS3AoXIeAsnUQhvNIC+QtVFc1duLHDu/kIEV70/F62oZksyCAFiDKBKPrHFko
         dgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683858; x=1691275858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJqf0m2qw+Xjs8Quv7ufLANzkWFzCscIfWrhHyj74r4=;
        b=ipCQePS2MfXQ0BjMGmMqRGF5j25w6QBSeH+nI0nJCb8mGzv7Rfnlxpz9dgjlgRJ/cy
         WP9FhX7XaCEyNWKmi+27+XnL5QccEg9uom24iVmeyRh+higTYrm/oOV2YYFNEP0CslMU
         Jbf45v0IAramno8amgzQcXAYMhklxSkLzi124AZsMyfJzP66/N8lFiVaFbhd7dj7mHw2
         10G2U0P1ByKLO1su3eZupGRIFg7wru7FZUkoyxvjrYmWYIcm8QT78NDT6APoUyQUlJ4c
         YvV932g2Pdvo9uvcXKmmmGpdgjNMowfVPZWaXc3j9RzzdB/tKECCHNmVgrsAjiCUsEpB
         xU8w==
X-Gm-Message-State: ABy/qLZKkrhPyYuvVrJJDqe6uN6vDpifKsNrEsJ1K/xRM7D6D7k34wjA
        JKSLHUeNuLoVY4/yyD15lylDWBcBetDNZN6bt99M
X-Google-Smtp-Source: APBJJlE+eG+2pcJk+y2idAnX2/Q8CxWYDm8cs4gjQZ7N5JmAkaEanN8FC+O33rAco+pnBzwZaUMX3uj6yPdrSXWcsU/9
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:d17:0:b0:bd5:dc2d:9d7f with SMTP
 id 23-20020a250d17000000b00bd5dc2d9d7fmr78836ybn.4.1688683857962; Thu, 06 Jul
 2023 15:50:57 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:32 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-5-axelrasmussen@google.com>
Subject: [PATCH v3 4/8] mm: userfaultfd: add new UFFDIO_POISON ioctl
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
index 4244ca7ee903..899aa621d7c1 100644
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
+	_dst_pte = make_pte_marker(PTE_MARKER_ERROR);
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

