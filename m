Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81CF3FF7B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347979AbhIBXTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 19:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347952AbhIBXTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:19:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03875C061757
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 16:18:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n202-20020a25d6d3000000b005991fd2f912so4582349ybg.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OvNLgv4ZFi3p08xkd4KAXOwUcX+v7iu51W2styin3+0=;
        b=iZfXoq/S2j8SaNFctE1mQ1+3j16Fyjl9VIPUkdrN1xw103T7sCd6mhIzmvplRy16Cw
         6hQAs2c7NM+xAJDTXUYfiKxpNf51whkpj9zx5usN+xxeq0cdG762Pdd3xdfXKjRI7YBn
         sNHMFxQiyZSGkFtH600cXYZBBG0SldmWeyAZNfGGMe+5ZlPrkcd6LMhIwzHGt5mMwFJe
         3AYnzYC51Coy3rhFG10AQxfTZS1FwWyyU2kRnr9s5wBD7asxQMwMMQiW8RPlZlupTwRz
         qOFktYt5hT546DQXf2PC/DJDGDU3iXflOxxsFHVF6d9FRbPKdZ9RR4wTqE+K7kUZtI6f
         eQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OvNLgv4ZFi3p08xkd4KAXOwUcX+v7iu51W2styin3+0=;
        b=BP8U4w2o8uFD1BFM3tOeU42NmMIUjKe7Rc3uX5IZWbjNdjIdssYUsXGE1vo5Gnc2jm
         7D7gI6NTuAUnL3nIIh+y9tyTw9YBEWw6KVyBorASPL0weN4SqgQsMPnff2FIxme1Yb4r
         2Iw2QhN+Bde2pIrgYlc6NByHJ2B7Jb/sSdIiL5qy9jxEZzdVbkBChW8WBjoNaUPNyJPX
         npl69kklXcJUpsmsGKkd/WQlMsETIrD5K1/yhR1CF0pLGFVmu+SsO5vZmrUXhc3lH1mf
         1VrJfVG4ZE+HWAGpGPyr1PBOHbD64JlJaX4O5UvfE2StG9npj++9KzuFIym8KBczm5lb
         ckFA==
X-Gm-Message-State: AOAM532sf2jNMaAcYBjsCUUYGIEwj6N5oRjhCj/FnmTBY6NW03BeZn4D
        olJOXOisQbM4KwyWMRjOGzacoWAn844=
X-Google-Smtp-Source: ABdhPJyjzqE2m61/0QXjGk0rbRpKY02YytNzYnUpUzP2PpUiJ7Ujf0hVCfyXou8+Z4gJ0NwCeap59XVGQFY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:556f:98c8:f567:be6])
 (user=surenb job=sendgmr) by 2002:a25:c305:: with SMTP id t5mr1097556ybf.410.1630624698040;
 Thu, 02 Sep 2021 16:18:18 -0700 (PDT)
Date:   Thu,  2 Sep 2021 16:18:11 -0700
Message-Id: <20210902231813.3597709-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v9 1/3] mm: rearrange madvise code to allow for reuse
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
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
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
previous version including cover letter with test results is at:
https://lore.kernel.org/linux-mm/20210827191858.2037087-1-surenb@google.com/

changes in v9
- Removed unnecessary initialization of 'error' to 0 in madvise_vma_behavior,
per Cyrill Gorcunov
- Replaced goto's with returns in madvise_vma_behavior, per Cyrill Gorcunov
- Recovered the comment explaining why we map ENOMEM to EAGAIN in
madvise_vma_behavior, per Cyrill Gorcunov

 mm/madvise.c | 317 +++++++++++++++++++++++++++------------------------
 1 file changed, 170 insertions(+), 147 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 56324a3dbc4e..54bf9f73f95d 100644
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
@@ -149,21 +93,21 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	if (start != vma->vm_start) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count)) {
 			error = -ENOMEM;
-			goto out;
+			return error;
 		}
 		error = __split_vma(mm, vma, start, 1);
 		if (error)
-			goto out_convert_errno;
+			return error;
 	}
 
 	if (end != vma->vm_end) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count)) {
 			error = -ENOMEM;
-			goto out;
+			return error;
 		}
 		error = __split_vma(mm, vma, end, 0);
 		if (error)
-			goto out_convert_errno;
+			return error;
 	}
 
 success:
@@ -172,15 +116,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
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
@@ -930,6 +866,94 @@ static long madvise_remove(struct vm_area_struct *vma,
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
@@ -978,30 +1002,6 @@ static int madvise_inject_error(int behavior,
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
@@ -1054,6 +1054,73 @@ process_madvise_behavior_valid(int behavior)
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
@@ -1126,9 +1193,7 @@ process_madvise_behavior_valid(int behavior)
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
-	unsigned long end, tmp;
-	struct vm_area_struct *vma, *prev;
-	int unmapped_error = 0;
+	unsigned long end;
 	int error = -EINVAL;
 	int write;
 	size_t len;
@@ -1168,51 +1233,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
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
2.33.0.153.gba50c8fa24-goog

