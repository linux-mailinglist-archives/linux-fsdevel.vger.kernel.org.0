Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AE41F68B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355085AbhJAU6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbhJAU6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:58:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024FC06177F
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 13:57:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x3-20020a05620a448300b0045e3e24de82so17884936qkp.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=npuLJ87TkB+y8CgzZzPNXPqlTxVMmmsBR51VxmZzJE8=;
        b=Srj2XxtT4obofi7fT2flMiMYV6stdXpvRkgk5h9VNYhV5KkRxmNzFdemmJmQHmlQTf
         OuKkzlYmIIKSzXOtsQ2NRzl4ssQCwaiZsNaY4OBdrHPG3xULx5Pg2/aD/dLs3NxJQffp
         myJXve4hAlKIYTwtWyiOl2ajr/BecPTHX3bUpmLpzT7vDnKgKOirtUGj9lTwzXvEVjCN
         hxDPOb2qxJvm2i7W6OuGDEKxa5RSqLoEC0kvX3/PTRt39UZ/4Ysrr9ZyODDEJJLqkKxz
         jabOi313TjmDWlP8G0CSI6y+OMNOsGon+MR9K4jYFbMmPrL7VqdYQEqhlwcjMtfBjAFu
         tsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=npuLJ87TkB+y8CgzZzPNXPqlTxVMmmsBR51VxmZzJE8=;
        b=iKehM9BA8SZXsugPI3t+jbMzzhfmSj/8TA9ys4n7gO/oWxY13SSJ02sW22hgPrQytU
         UUSrYMa0Bbw70oW3jqLHgzS2rvF/FPuimdR3IT6IlVusA/dMAbFpiMAmCKKhGniECqwO
         WtRH/X/KztlxAXG0faHB0k/TpGA6VorGkTZV7u2SKhR80Dvlr4p6+G3CpK59xuo7iOfq
         iAZwTHSaUKYl2K8u/W3Dn4ZhwtQreidKBuH+yudelyZa15k4utq3Ka03/xhqWqSRcVer
         PjoAmdooOl4BshEsgcOWYne+Y8JOuNk59Mnw9Jh7ytz0by9niS0grMPGY5ZOPfvUMID4
         e9yA==
X-Gm-Message-State: AOAM531H3GMT6t10s4OONgIZP5nTDEBISFRfLWTLwzFtZ5jdR8zd67mC
        8yycuiDTXIb/faQ6RuLqf9EdVNhHyGA=
X-Google-Smtp-Source: ABdhPJxvyQOQVXwoCewPYICl/A1Hj2tdEjJGtkqKvdvyzlRi9V2Cs/nVzZFZZPuKjcyoS6ov8diCua3eOIY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:fbba:6ac8:d071:dcc])
 (user=surenb job=sendgmr) by 2002:a05:6214:a89:: with SMTP id
 ev9mr3344641qvb.0.1633121821789; Fri, 01 Oct 2021 13:57:01 -0700 (PDT)
Date:   Fri,  1 Oct 2021 13:56:55 -0700
Message-Id: <20211001205657.815551-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Cross <ccross@google.com>

Refactor the madvise syscall to allow for parts of it to be reused by a
prctl syscall that affects vmas.

Move the code that walks vmas in a virtual address range into a function
that takes a function pointer as a parameter.  The only caller for now is
sys_madvise, which uses it to call madvise_vma_behavior on each vma, but
the next patch will add an additional caller.

Move handling all vma behaviors inside madvise_behavior, and rename it to
madvise_vma_behavior.

Move the code that updates the flags on a vma, including splitting or
merging the vma as necessary, into a new function called
madvise_update_vma.  The next patch will add support for updating a new
anon_name field as well.

Signed-off-by: Colin Cross <ccross@google.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Glauber <jan.glauber@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Rob Landley <rob@landley.net>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge.hallyn@ubuntu.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Shaohua Li <shli@fusionio.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
  [sumits: rebased over v5.9-rc3]
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
  [surenb: rebased over v5.14-rc7]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
previous version at:
https://lore.kernel.org/linux-mm/20210902231813.3597709-1-surenb@google.com/

changes in v10
- Cleanup error handling code to return the error immediately instead of
assigning it to an intermediate variable first.

 mm/madvise.c | 338 +++++++++++++++++++++++++++------------------------
 1 file changed, 178 insertions(+), 160 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..d057109d7d17 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
 }
 
 /*
- * We can potentially split a vm area into separate
- * areas, each area with its own behavior.
+ * Update the vm_flags on regiion of a vma, splitting it or merging it as
+ * necessary.  Must be called with mmap_sem held for writing;
  */
-static long madvise_behavior(struct vm_area_struct *vma,
-		     struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end, int behavior)
+static int madvise_update_vma(struct vm_area_struct *vma,
+			      struct vm_area_struct **prev, unsigned long start,
+			      unsigned long end, unsigned long new_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	int error = 0;
+	int error;
 	pgoff_t pgoff;
-	unsigned long new_flags = vma->vm_flags;
-
-	switch (behavior) {
-	case MADV_NORMAL:
-		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
-		break;
-	case MADV_SEQUENTIAL:
-		new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
-		break;
-	case MADV_RANDOM:
-		new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
-		break;
-	case MADV_DONTFORK:
-		new_flags |= VM_DONTCOPY;
-		break;
-	case MADV_DOFORK:
-		if (vma->vm_flags & VM_IO) {
-			error = -EINVAL;
-			goto out;
-		}
-		new_flags &= ~VM_DONTCOPY;
-		break;
-	case MADV_WIPEONFORK:
-		/* MADV_WIPEONFORK is only supported on anonymous memory. */
-		if (vma->vm_file || vma->vm_flags & VM_SHARED) {
-			error = -EINVAL;
-			goto out;
-		}
-		new_flags |= VM_WIPEONFORK;
-		break;
-	case MADV_KEEPONFORK:
-		new_flags &= ~VM_WIPEONFORK;
-		break;
-	case MADV_DONTDUMP:
-		new_flags |= VM_DONTDUMP;
-		break;
-	case MADV_DODUMP:
-		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
-			error = -EINVAL;
-			goto out;
-		}
-		new_flags &= ~VM_DONTDUMP;
-		break;
-	case MADV_MERGEABLE:
-	case MADV_UNMERGEABLE:
-		error = ksm_madvise(vma, start, end, behavior, &new_flags);
-		if (error)
-			goto out_convert_errno;
-		break;
-	case MADV_HUGEPAGE:
-	case MADV_NOHUGEPAGE:
-		error = hugepage_madvise(vma, &new_flags, behavior);
-		if (error)
-			goto out_convert_errno;
-		break;
-	}
 
 	if (new_flags == vma->vm_flags) {
 		*prev = vma;
-		goto out;
+		return 0;
 	}
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
@@ -147,23 +91,19 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	*prev = vma;
 
 	if (start != vma->vm_start) {
-		if (unlikely(mm->map_count >= sysctl_max_map_count)) {
-			error = -ENOMEM;
-			goto out;
-		}
+		if (unlikely(mm->map_count >= sysctl_max_map_count))
+			return -ENOMEM;
 		error = __split_vma(mm, vma, start, 1);
 		if (error)
-			goto out_convert_errno;
+			return error;
 	}
 
 	if (end != vma->vm_end) {
-		if (unlikely(mm->map_count >= sysctl_max_map_count)) {
-			error = -ENOMEM;
-			goto out;
-		}
+		if (unlikely(mm->map_count >= sysctl_max_map_count))
+			return -ENOMEM;
 		error = __split_vma(mm, vma, end, 0);
 		if (error)
-			goto out_convert_errno;
+			return error;
 	}
 
 success:
@@ -172,15 +112,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	 */
 	vma->vm_flags = new_flags;
 
-out_convert_errno:
-	/*
-	 * madvise() returns EAGAIN if kernel resources, such as
-	 * slab, are temporarily unavailable.
-	 */
-	if (error == -ENOMEM)
-		error = -EAGAIN;
-out:
-	return error;
+	return 0;
 }
 
 #ifdef CONFIG_SWAP
@@ -930,6 +862,94 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+/*
+ * Apply an madvise behavior to a region of a vma.  madvise_update_vma
+ * will handle splitting a vm area into separate areas, each area with its own
+ * behavior.
+ */
+static int madvise_vma_behavior(struct vm_area_struct *vma,
+				struct vm_area_struct **prev,
+				unsigned long start, unsigned long end,
+				unsigned long behavior)
+{
+	int error;
+	unsigned long new_flags = vma->vm_flags;
+
+	switch (behavior) {
+	case MADV_REMOVE:
+		return madvise_remove(vma, prev, start, end);
+	case MADV_WILLNEED:
+		return madvise_willneed(vma, prev, start, end);
+	case MADV_COLD:
+		return madvise_cold(vma, prev, start, end);
+	case MADV_PAGEOUT:
+		return madvise_pageout(vma, prev, start, end);
+	case MADV_FREE:
+	case MADV_DONTNEED:
+		return madvise_dontneed_free(vma, prev, start, end, behavior);
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
+		return madvise_populate(vma, prev, start, end, behavior);
+	case MADV_NORMAL:
+		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
+		break;
+	case MADV_SEQUENTIAL:
+		new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
+		break;
+	case MADV_RANDOM:
+		new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
+		break;
+	case MADV_DONTFORK:
+		new_flags |= VM_DONTCOPY;
+		break;
+	case MADV_DOFORK:
+		if (vma->vm_flags & VM_IO)
+			return -EINVAL;
+		new_flags &= ~VM_DONTCOPY;
+		break;
+	case MADV_WIPEONFORK:
+		/* MADV_WIPEONFORK is only supported on anonymous memory. */
+		if (vma->vm_file || vma->vm_flags & VM_SHARED)
+			return -EINVAL;
+		new_flags |= VM_WIPEONFORK;
+		break;
+	case MADV_KEEPONFORK:
+		new_flags &= ~VM_WIPEONFORK;
+		break;
+	case MADV_DONTDUMP:
+		new_flags |= VM_DONTDUMP;
+		break;
+	case MADV_DODUMP:
+		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
+			return -EINVAL;
+		new_flags &= ~VM_DONTDUMP;
+		break;
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+		error = ksm_madvise(vma, start, end, behavior, &new_flags);
+		if (error)
+			goto out;
+		break;
+	case MADV_HUGEPAGE:
+	case MADV_NOHUGEPAGE:
+		error = hugepage_madvise(vma, &new_flags, behavior);
+		if (error)
+			goto out;
+		break;
+	}
+
+	error = madvise_update_vma(vma, prev, start, end, new_flags);
+
+out:
+	/*
+	 * madvise() returns EAGAIN if kernel resources, such as
+	 * slab, are temporarily unavailable.
+	 */
+	if (error == -ENOMEM)
+		error = -EAGAIN;
+	return error;
+}
+
 #ifdef CONFIG_MEMORY_FAILURE
 /*
  * Error injection support for memory error handling.
@@ -978,30 +998,6 @@ static int madvise_inject_error(int behavior,
 }
 #endif
 
-static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		unsigned long start, unsigned long end, int behavior)
-{
-	switch (behavior) {
-	case MADV_REMOVE:
-		return madvise_remove(vma, prev, start, end);
-	case MADV_WILLNEED:
-		return madvise_willneed(vma, prev, start, end);
-	case MADV_COLD:
-		return madvise_cold(vma, prev, start, end);
-	case MADV_PAGEOUT:
-		return madvise_pageout(vma, prev, start, end);
-	case MADV_FREE:
-	case MADV_DONTNEED:
-		return madvise_dontneed_free(vma, prev, start, end, behavior);
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
-		return madvise_populate(vma, prev, start, end, behavior);
-	default:
-		return madvise_behavior(vma, prev, start, end, behavior);
-	}
-}
-
 static bool
 madvise_behavior_valid(int behavior)
 {
@@ -1055,6 +1051,73 @@ process_madvise_behavior_valid(int behavior)
 	}
 }
 
+/*
+ * Walk the vmas in range [start,end), and call the visit function on each one.
+ * The visit function will get start and end parameters that cover the overlap
+ * between the current vma and the original range.  Any unmapped regions in the
+ * original range will result in this function returning -ENOMEM while still
+ * calling the visit function on all of the existing vmas in the range.
+ * Must be called with the mmap_lock held for reading or writing.
+ */
+static
+int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
+		      unsigned long end, unsigned long arg,
+		      int (*visit)(struct vm_area_struct *vma,
+				   struct vm_area_struct **prev, unsigned long start,
+				   unsigned long end, unsigned long arg))
+{
+	struct vm_area_struct *vma;
+	struct vm_area_struct *prev;
+	unsigned long tmp;
+	int unmapped_error = 0;
+
+	/*
+	 * If the interval [start,end) covers some unmapped address
+	 * ranges, just ignore them, but return -ENOMEM at the end.
+	 * - different from the way of handling in mlock etc.
+	 */
+	vma = find_vma_prev(mm, start, &prev);
+	if (vma && start > vma->vm_start)
+		prev = vma;
+
+	for (;;) {
+		int error;
+
+		/* Still start < end. */
+		if (!vma)
+			return -ENOMEM;
+
+		/* Here start < (end|vma->vm_end). */
+		if (start < vma->vm_start) {
+			unmapped_error = -ENOMEM;
+			start = vma->vm_start;
+			if (start >= end)
+				break;
+		}
+
+		/* Here vma->vm_start <= start < (end|vma->vm_end) */
+		tmp = vma->vm_end;
+		if (end < tmp)
+			tmp = end;
+
+		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
+		error = visit(vma, &prev, start, tmp, arg);
+		if (error)
+			return error;
+		start = tmp;
+		if (prev && start < prev->vm_end)
+			start = prev->vm_end;
+		if (start >= end)
+			break;
+		if (prev)
+			vma = prev->vm_next;
+		else	/* madvise_remove dropped mmap_lock */
+			vma = find_vma(mm, start);
+	}
+
+	return unmapped_error;
+}
+
 /*
  * The madvise(2) system call.
  *
@@ -1127,10 +1190,8 @@ process_madvise_behavior_valid(int behavior)
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
-	unsigned long end, tmp;
-	struct vm_area_struct *vma, *prev;
-	int unmapped_error = 0;
-	int error = -EINVAL;
+	unsigned long end;
+	int error;
 	int write;
 	size_t len;
 	struct blk_plug plug;
@@ -1138,23 +1199,22 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	start = untagged_addr(start);
 
 	if (!madvise_behavior_valid(behavior))
-		return error;
+		return -EINVAL;
 
 	if (!PAGE_ALIGNED(start))
-		return error;
+		return -EINVAL;
 	len = PAGE_ALIGN(len_in);
 
 	/* Check to see whether len was rounded up from small -ve to zero */
 	if (len_in && !len)
-		return error;
+		return -EINVAL;
 
 	end = start + len;
 	if (end < start)
-		return error;
+		return -EINVAL;
 
-	error = 0;
 	if (end == start)
-		return error;
+		return 0;
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
@@ -1169,51 +1229,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 		mmap_read_lock(mm);
 	}
 
-	/*
-	 * If the interval [start,end) covers some unmapped address
-	 * ranges, just ignore them, but return -ENOMEM at the end.
-	 * - different from the way of handling in mlock etc.
-	 */
-	vma = find_vma_prev(mm, start, &prev);
-	if (vma && start > vma->vm_start)
-		prev = vma;
-
 	blk_start_plug(&plug);
-	for (;;) {
-		/* Still start < end. */
-		error = -ENOMEM;
-		if (!vma)
-			goto out;
-
-		/* Here start < (end|vma->vm_end). */
-		if (start < vma->vm_start) {
-			unmapped_error = -ENOMEM;
-			start = vma->vm_start;
-			if (start >= end)
-				goto out;
-		}
-
-		/* Here vma->vm_start <= start < (end|vma->vm_end) */
-		tmp = vma->vm_end;
-		if (end < tmp)
-			tmp = end;
-
-		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
-		if (error)
-			goto out;
-		start = tmp;
-		if (prev && start < prev->vm_end)
-			start = prev->vm_end;
-		error = unmapped_error;
-		if (start >= end)
-			goto out;
-		if (prev)
-			vma = prev->vm_next;
-		else	/* madvise_remove dropped mmap_lock */
-			vma = find_vma(mm, start);
-	}
-out:
+	error = madvise_walk_vmas(mm, start, end, behavior,
+			madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	if (write)
 		mmap_write_unlock(mm);
-- 
2.33.0.800.g4c38ced690-goog

