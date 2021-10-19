Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51A4340E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJSV5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhJSV53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:57:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3FC06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 14:55:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a252256000000b005b67a878f56so20650558ybi.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VdCVGbU6S1sdkmkwa3vBJoKzpaTODhkE73FG+sH2hI8=;
        b=BaVikAwoZ6wB9ke/Ei27iyYLNeIY4+uRKTEzhSxp8CVbxf2Gsvi+oBXuVlkE5/ZHpp
         TceyHmxULcmiWb6mcyAzXDdZ8BlxX+hWXznMWsPZvw5mrFYHfDP3vuyrqnGJEK0aWfvm
         sRUPkrMBsglvYDuj5CriaHPZWsbjYXEJnQf/Y2ew8rN4hN45EwuKlADDx2RiMhAMibDJ
         8e34U3QuGgxOnP+lHGQE7FRWzEe81vrdPdyZymJpH2m7v21gtUI/cpCCfw72G5qRjPut
         3Sn0/3653wV2R2sk7kW1YniCkfIAsPuWU7sp9HkNN++z+A9no/HianLJAxB3jFOsUO2F
         DOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VdCVGbU6S1sdkmkwa3vBJoKzpaTODhkE73FG+sH2hI8=;
        b=KM3yFTtz7ub/8L0yWokAy1mWlTav18PNJCFlzSNmht8cL9RYkDHOdE2SnhH+1dy85/
         yO7OLLu6iNdIh8m3Oxm0w2kn06aNYECW2swNbo3nSzglVOeE3TgxHIdXr5Bw++ScTOR2
         6T9Otujw+ShP3fv/tIKCfRBvFNq8YZKdOZ7HU5vosvfQML4wfZSPdnNqZRe7CqpfrvzZ
         L5VcbTfb9QIa9DGI6VuyT2mo17USb2nQWVlZ0LLn62R/n1N6WcK7eT/wGHBUJ/pPc19F
         JIsvtQqCAPh5O9K+7W16Qwrx0J5fvxRjOwDLajotdVvEOtGcOYrp3eW+wSq983+enM/H
         E7/A==
X-Gm-Message-State: AOAM5315qk5zwbqbkaWbumqALSuyuh56rTwfwXsEiJQBVJAiBDqIV8VB
        108kgRnDrLsTjJIwKMLMuOLJdGf1+G8=
X-Google-Smtp-Source: ABdhPJwacT2nQFyLw6ACB691m/BUqMlkBA4uHghCtrIHQtr7+rR3h2O7/gTMd3rml6GLiEyES356T+wbNC0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:932c:247a:84c6:20f5])
 (user=surenb job=sendgmr) by 2002:a05:6902:110b:: with SMTP id
 o11mr42621747ybu.251.1634680515665; Tue, 19 Oct 2021 14:55:15 -0700 (PDT)
Date:   Tue, 19 Oct 2021 14:55:09 -0700
Message-Id: <20211019215511.3771969-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v11 1/3] mm: rearrange madvise code to allow for reuse
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
https://lore.kernel.org/all/20211001205657.815551-1-surenb@google.com/

changes in v11
- Fixed misspelling, per Rolf Eike Beer

 mm/madvise.c | 338 +++++++++++++++++++++++++++------------------------
 1 file changed, 178 insertions(+), 160 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..224f971b2da2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
 }
 
 /*
- * We can potentially split a vm area into separate
- * areas, each area with its own behavior.
+ * Update the vm_flags on region of a vma, splitting it or merging it as
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
2.33.0.1079.g6e70778dc9-goog

