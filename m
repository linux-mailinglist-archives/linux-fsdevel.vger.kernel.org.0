Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61693254491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgH0Lwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgH0Lu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B27C0619C2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c78so4564676ybf.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cVuWDkLHwa5/2KrhblG6pdzJasoQug9C22emcf5s8N8=;
        b=g0HxF1iqNkTG/iZ1NuqSDpSdtIFu/5LVjPFCvlEvPLfFc8Nt0Y9LUm/EDoP7OChPOn
         C5ScdaXQLX26RsmBnPBcgDGY1m9qNmtIkNvlA5DrglwYMX82L3zyjd8Fdzh29+iUvB27
         BtGIl7ot7ZYiNlDygiqTmUalK/KQEBFOQLJ9cSG87Qeqm2Ixo/7XNv8xW300Din64vmz
         ZTtYOU5XGTP45neB/5x11Ia7kADtKZzy5kFigDbuwSL/n+cFWzuwtPPCh7/zHSMUoUg+
         cEHxVAl3z9dhn5D6PTGY465up4NSdYwPDPX7B75uGRxdpC8rE6ySBOlHfjDmokL6hDcs
         azWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cVuWDkLHwa5/2KrhblG6pdzJasoQug9C22emcf5s8N8=;
        b=eC9KSMXKWX0PTohxp1T5PCPHxO/xqpygOYI+zf5uezjp5IvVy8RtJ67voeAfz7SkJb
         /XhyyBioBqT8jeO7u0tw69OBcT7AvQE2g1oVHiXcJKF/a9ZVEf0m5BY84e0HPBhM0TpO
         pwjJRpFuKtbKIrSa1TIZpY35WERim+jy5Gu22Y8d1UuHaE3RJIsFyJSPIP7MfSE0Q5lG
         n12ZOPDszQpznYCDKYQSV5vu1JzOTaJ+hpWfCUMQq/YurAPVUZIL7G5A5k7KsB/qriG2
         pUUDipenjJ9v+sfAu/9h2XxaH8XDVp8xnKF0tYXBe9D0/IPUT/icA77KHq71/URsmhB7
         HREA==
X-Gm-Message-State: AOAM531MLCJD368Qt6p+IgJR0eAtCK7cSA7Hf32x5ILKcGn7abwfTvFJ
        7LB0lxe5WVRtReA3dmsJ43IZqZJBHQ==
X-Google-Smtp-Source: ABdhPJyMvXDO/j8HxgHB0/l9iea2k6+d1+5jncQNCmzp/jZuuFGmOCLYN1CMoCdszB/WupNt0Y317Ks0yQ==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:5807:: with SMTP id m7mr8209201ybb.456.1598529006101;
 Thu, 27 Aug 2020 04:50:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:32 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-8-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid() hack
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The preceding patches have ensured that core dumping properly takes the
mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
its users.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/infiniband/core/uverbs_main.c |  3 ---
 drivers/vfio/pci/vfio_pci.c           | 38 +++++++++++++--------------
 fs/proc/task_mmu.c                    | 18 -------------
 fs/userfaultfd.c                      | 28 +++++++-------------
 include/linux/sched/mm.h              | 25 ------------------
 mm/khugepaged.c                       |  2 +-
 mm/madvise.c                          | 17 ------------
 mm/mmap.c                             |  5 +---
 8 files changed, 29 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 37794d88b1f3..a4ba0b87d6de 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -845,8 +845,6 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 		 * will only be one mm, so no big deal.
 		 */
 		mmap_read_lock(mm);
-		if (!mmget_still_valid(mm))
-			goto skip_mm;
 		mutex_lock(&ufile->umap_lock);
 		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
 					  list) {
@@ -865,7 +863,6 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 			}
 		}
 		mutex_unlock(&ufile->umap_lock);
-	skip_mm:
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 620465c2a1da..27f11cc7ba6c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1480,31 +1480,29 @@ static int vfio_pci_zap_and_vma_lock(struct vfio_pci_device *vdev, bool try)
 		} else {
 			mmap_read_lock(mm);
 		}
-		if (mmget_still_valid(mm)) {
-			if (try) {
-				if (!mutex_trylock(&vdev->vma_lock)) {
-					mmap_read_unlock(mm);
-					mmput(mm);
-					return 0;
-				}
-			} else {
-				mutex_lock(&vdev->vma_lock);
+		if (try) {
+			if (!mutex_trylock(&vdev->vma_lock)) {
+				mmap_read_unlock(mm);
+				mmput(mm);
+				return 0;
 			}
-			list_for_each_entry_safe(mmap_vma, tmp,
-						 &vdev->vma_list, vma_next) {
-				struct vm_area_struct *vma = mmap_vma->vma;
+		} else {
+			mutex_lock(&vdev->vma_lock);
+		}
+		list_for_each_entry_safe(mmap_vma, tmp,
+					 &vdev->vma_list, vma_next) {
+			struct vm_area_struct *vma = mmap_vma->vma;
 
-				if (vma->vm_mm != mm)
-					continue;
+			if (vma->vm_mm != mm)
+				continue;
 
-				list_del(&mmap_vma->vma_next);
-				kfree(mmap_vma);
+			list_del(&mmap_vma->vma_next);
+			kfree(mmap_vma);
 
-				zap_vma_ptes(vma, vma->vm_start,
-					     vma->vm_end - vma->vm_start);
-			}
-			mutex_unlock(&vdev->vma_lock);
+			zap_vma_ptes(vma, vma->vm_start,
+				     vma->vm_end - vma->vm_start);
 		}
+		mutex_unlock(&vdev->vma_lock);
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5066b0251ed8..c43490aec95d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1168,24 +1168,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 					count = -EINTR;
 					goto out_mm;
 				}
-				/*
-				 * Avoid to modify vma->vm_flags
-				 * without locked ops while the
-				 * coredump reads the vm_flags.
-				 */
-				if (!mmget_still_valid(mm)) {
-					/*
-					 * Silently return "count"
-					 * like if get_task_mm()
-					 * failed. FIXME: should this
-					 * function have returned
-					 * -ESRCH if get_task_mm()
-					 * failed like if
-					 * get_proc_task() fails?
-					 */
-					mmap_write_unlock(mm);
-					goto out_mm;
-				}
 				for (vma = mm->mmap; vma; vma = vma->vm_next) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0e4a3837da52..000b457ad087 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -601,8 +601,6 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		/* no task can run (and in turn coredump) yet */
-		VM_WARN_ON(!mmget_still_valid(mm));
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
@@ -842,7 +840,6 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
-	bool still_valid;
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -858,7 +855,6 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 * taking the mmap_lock for writing.
 	 */
 	mmap_write_lock(mm);
-	still_valid = mmget_still_valid(mm);
 	prev = NULL;
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		cond_resched();
@@ -869,17 +865,15 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~(VM_UFFD_MISSING | VM_UFFD_WP);
-		if (still_valid) {
-			prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
-					 new_flags, vma->anon_vma,
-					 vma->vm_file, vma->vm_pgoff,
-					 vma_policy(vma),
-					 NULL_VM_UFFD_CTX);
-			if (prev)
-				vma = prev;
-			else
-				prev = vma;
-		}
+		prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+				 new_flags, vma->anon_vma,
+				 vma->vm_file, vma->vm_pgoff,
+				 vma_policy(vma),
+				 NULL_VM_UFFD_CTX);
+		if (prev)
+			vma = prev;
+		else
+			prev = vma;
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
@@ -1309,8 +1303,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	mmap_write_lock(mm);
-	if (!mmget_still_valid(mm))
-		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
@@ -1511,8 +1503,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	mmap_write_lock(mm);
-	if (!mmget_still_valid(mm))
-		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..e9cd1e637d76 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,31 +49,6 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
-/*
- * This has to be called after a get_task_mm()/mmget_not_zero()
- * followed by taking the mmap_lock for writing before modifying the
- * vmas or anything the coredump pretends not to change from under it.
- *
- * It also has to be called when mmgrab() is used in the context of
- * the process, but then the mm_count refcount is transferred outside
- * the context of the process to run down_write() on that pinned mm.
- *
- * NOTE: find_extend_vma() called from GUP context is the only place
- * that can modify the "mm" (notably the vm_start/end) under mmap_lock
- * for reading and outside the context of the process, so it is also
- * the only case that holds the mmap_lock for reading that must call
- * this function. Generally if the mmap_lock is hold for reading
- * there's no need of this check after get_task_mm()/mmget_not_zero().
- *
- * This function can be obsoleted and the check can be removed, after
- * the coredump code will hold the mmap_lock for writing before
- * invoking the ->core_dump methods.
- */
-static inline bool mmget_still_valid(struct mm_struct *mm)
-{
-	return likely(!mm->core_state);
-}
-
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15a9af791014..101b636c72b5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
 
 static inline int khugepaged_test_exit(struct mm_struct *mm)
 {
-	return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
+	return atomic_read(&mm->mm_users) == 0;
 }
 
 static bool hugepage_vma_check(struct vm_area_struct *vma,
diff --git a/mm/madvise.c b/mm/madvise.c
index dd1d43cf026d..d5b33d9011f0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1091,23 +1091,6 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
 	if (write) {
 		if (mmap_write_lock_killable(current->mm))
 			return -EINTR;
-
-		/*
-		 * We may have stolen the mm from another process
-		 * that is undergoing core dumping.
-		 *
-		 * Right now that's io_ring, in the future it may
-		 * be remote process management and not "current"
-		 * at all.
-		 *
-		 * We need to fix core dumping to not do this,
-		 * but for now we have the mmget_still_valid()
-		 * model.
-		 */
-		if (!mmget_still_valid(current->mm)) {
-			mmap_write_unlock(current->mm);
-			return -EINTR;
-		}
 	} else {
 		mmap_read_lock(current->mm);
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..c47abe460439 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2552,7 +2552,7 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 	if (vma && (vma->vm_start <= addr))
 		return vma;
 	/* don't alter vm_end if the coredump is running */
-	if (!prev || !mmget_still_valid(mm) || expand_stack(prev, addr))
+	if (!prev || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
@@ -2578,9 +2578,6 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 		return vma;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return NULL;
-	/* don't alter vm_start if the coredump is running */
-	if (!mmget_still_valid(mm))
-		return NULL;
 	start = vma->vm_start;
 	if (expand_stack(vma, addr))
 		return NULL;
-- 
2.28.0.297.g1956fa8f8d-goog

