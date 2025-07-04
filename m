Return-Path: <linux-fsdevel+bounces-53892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D1AF87B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A074A3261
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7F24DD00;
	Fri,  4 Jul 2025 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI80Qrkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22629246BD5
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609268; cv=none; b=uaGc8uxKE9cWnbPyFUu+rueno3TVtRhBYhEfkKvJjPwyHxEvjMBsWZevrcE2UXe8G5atcyCdCeGu3CR8wjFZJk/6przx+pTjYUTj15qOxrqJTwPhZm4OomAjuDlgZ4cgUIDEc0PHkWQvjlkJLooUDGuXz/y6bDKnwaGVwhlnBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609268; c=relaxed/simple;
	bh=ldcFF1mghDA07EpAp/w0hayCexC2/uagTVEfPtokacg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0UQSRT80SA2cpDfdtEFcK2Ee+KsgEuDlhafkPnlk9HSjVq2Fl9iyGZW5qPP2irRYNyNPnOjHZxPwK6pYBPlh7A81DePjcBy62kTQfFjmEHaG0cIQE2plMEeAQMi0u992DtesKywgaptAH0jdn/F6x+fgSDT4XyK3RjPIVI6YSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI80Qrkd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso1022378b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609265; x=1752214065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V87ghHwj2x/F08cA4iUlHoTxBegCjR03gbXdVLHzhkQ=;
        b=XI80Qrkd+t5+RRZzxlJXAb1SpowpB2XBtKtqRI4lmw8GsSeF1mO1cyv9lb3mie3cy5
         IDXGZ+0UQRDsDU70E3iBGVbfdjwDnrpJr/f4Ct0mymKZt61kAUHyaip/3/0Syzhg0I6J
         +IRhLgMMM2InQDEtt/Mv7Fk6Brnmq09OXRw3EoiUUQ4qP7aBIFi2fi/Ly0/22gMaQr1J
         PHLp6VbaPweAtkgg2xv8HDNEd6akxTUSVoW4P9rHGhuUPPj5UcgUBw+WkPWaif93dctg
         Iz97Srbt81M/1ewwdN3TjuQHcCNEJQrkGcRidRdtS50GADHto3XkEM+utR/dofcWWTtH
         Hxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609265; x=1752214065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V87ghHwj2x/F08cA4iUlHoTxBegCjR03gbXdVLHzhkQ=;
        b=v8X/8IBCPCxmdjRtFBa265ve0tjvkMKtHGorlAMFs0lYmF9WMHPbTL4UxZdDtqPiht
         XRuzzdg6mJ96vkca7nrSGJQmLBNxvBdehrBhtQWJBSliK5yAxIOmYE6krbkjY4dN5nZp
         RW/aCMVkPUPWbdBsNIRtMshilo0E1rbu3bDsUxOroXiCP9Wo15ZaghvomAoAYgUqQkq9
         LCHYoCpxTHC5XazwxQBzvg1qX7e9iuvMhos/L5c08vfYwkf7R6l8YWzuQZL4yDP+8d4v
         /1CUk4YKBJzk6eOLMlK/pUmFBqwwT/ZrWsMYreMX39/7+jt6UPyA8+ju5fAD9h39/p8H
         QqCg==
X-Forwarded-Encrypted: i=1; AJvYcCWYOfkwT5PnhBlRn2yl1QQb4g+HxBWPcO1HBOvV7mHmK0Lslo+cjxjfDvP7nUQ3VdXgzZ/Oh8jMRLB+aGd4@vger.kernel.org
X-Gm-Message-State: AOJu0YwOstKSzbiGLOzVcR57TO/JQcRaDIECGNbw0ZKavg9/xaEi8L5z
	DxaNQRXohSy9RfhfLNawbrGHtyL1yiLDGu8NohaFTfC/yE+LYrmhGBJhZDqi9O1koNmPMYmYf6E
	MMFOdMw==
X-Google-Smtp-Source: AGHT+IHa4YAEN8ymTNIzYo1RkEc+q9IqwmzCpnw8Sx/y3o7WA6jQRp5CcMpLhh5Oi7FcyNjv7oAKTzvc1WM=
X-Received: from pfbfc40.prod.google.com ([2002:a05:6a00:2e28:b0:746:fd4c:1fcf])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc9:b0:748:f406:b09
 with SMTP id d2e1a72fcca58-74ce6a6e9b6mr2178587b3a.23.1751609265125; Thu, 03
 Jul 2025 23:07:45 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:25 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-8-surenb@google.com>
Subject: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With maple_tree supporting vma tree traversal under RCU and per-vma
locks, /proc/pid/maps can be read while holding individual vma locks
instead of locking the entire address space.
Completely lockless approach (walking vma tree under RCU) would be quite
complex with the main issue being get_vma_name() using callbacks which
might not work correctly with a stable vma copy, requiring original
(unstable) vma - see special_mapping_name() for an example.
When per-vma lock acquisition fails, we take the mmap_lock for reading,
lock the vma, release the mmap_lock and continue. This fallback to mmap
read lock guarantees the reader to make forward progress even during
lock contention. This will interfere with the writer but for a very
short time while we are acquiring the per-vma lock and only when there
was contention on the vma reader is interested in. We shouldn't see a
repeated fallback to mmap read locks in practice, as this require a
very unlikely series of lock contentions (for instance due to repeated
vma split operations). However even if this did somehow happen, we would
still progress.
One case requiring special handling is when vma changes between the
time it was found and the time it got locked. A problematic case would
be if vma got shrunk so that it's start moved higher in the address
space and a new vma was installed at the beginning:

reader found:               |--------VMA A--------|
VMA is modified:            |-VMA B-|----VMA A----|
reader locks modified VMA A
reader reports VMA A:       |  gap  |----VMA A----|

This would result in reporting a gap in the address space that does not
exist. To prevent this we retry the lookup after locking the vma, however
we do that only when we identify a gap and detect that the address space
was changed after we found the vma.
This change is designed to reduce mmap_lock contention and prevent a
process reading /proc/pid/maps files (often a low priority task, such
as monitoring/data collection services) from blocking address space
updates. Note that this change has a userspace visible disadvantage:
it allows for sub-page data tearing as opposed to the previous mechanism
where data tearing could happen only between pages of generated output
data. Since current userspace considers data tearing between pages to be
acceptable, we assume is will be able to handle sub-page data tearing
as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h        |   5 ++
 fs/proc/task_mmu.c        | 118 ++++++++++++++++++++++++++++++++++----
 include/linux/mmap_lock.h |  11 ++++
 mm/madvise.c              |   3 +-
 mm/mmap_lock.c            |  88 ++++++++++++++++++++++++++++
 5 files changed, 214 insertions(+), 11 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 3d48ffe72583..7c235451c5ea 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -384,6 +384,11 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	loff_t last_pos;
+#ifdef CONFIG_PER_VMA_LOCK
+	bool mmap_locked;
+	struct vm_area_struct *locked_vma;
+#endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b8bc06d05a72..ff3fe488ce51 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -127,15 +127,107 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static void unlock_vma(struct proc_maps_private *priv)
+{
+	if (priv->locked_vma) {
+		vma_end_read(priv->locked_vma);
+		priv->locked_vma = NULL;
+	}
+}
+
+static const struct seq_operations proc_pid_maps_op;
+
+static inline bool lock_vma_range(struct seq_file *m,
+				  struct proc_maps_private *priv)
+{
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read with locking just the vma.
+	 */
+	if (m->op != &proc_pid_maps_op) {
+		if (mmap_read_lock_killable(priv->mm))
+			return false;
+
+		priv->mmap_locked = true;
+	} else {
+		rcu_read_lock();
+		priv->locked_vma = NULL;
+		priv->mmap_locked = false;
+	}
+
+	return true;
+}
+
+static inline void unlock_vma_range(struct proc_maps_private *priv)
+{
+	if (priv->mmap_locked) {
+		mmap_read_unlock(priv->mm);
+	} else {
+		unlock_vma(priv);
+		rcu_read_unlock();
+	}
+}
+
+static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
+					   loff_t last_pos)
+{
+	struct vm_area_struct *vma;
+
+	if (priv->mmap_locked)
+		return vma_next(&priv->iter);
+
+	unlock_vma(priv);
+	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
+	if (!IS_ERR_OR_NULL(vma))
+		priv->locked_vma = vma;
+
+	return vma;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline bool lock_vma_range(struct seq_file *m,
+				  struct proc_maps_private *priv)
 {
-	struct vm_area_struct *vma = vma_next(&priv->iter);
+	return mmap_read_lock_killable(priv->mm) == 0;
+}
+
+static inline void unlock_vma_range(struct proc_maps_private *priv)
+{
+	mmap_read_unlock(priv->mm);
+}
+
+static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
+					   loff_t last_pos)
+{
+	return vma_next(&priv->iter);
+}
 
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
+{
+	struct proc_maps_private *priv = m->private;
+	struct vm_area_struct *vma;
+
+	vma = get_next_vma(priv, *ppos);
+	/* EINTR is possible */
+	if (IS_ERR(vma))
+		return vma;
+
+	/* Store previous position to be able to restart if needed */
+	priv->last_pos = *ppos;
 	if (vma) {
-		*ppos = vma->vm_start;
+		/*
+		 * Track the end of the reported vma to ensure position changes
+		 * even if previous vma was merged with the next vma and we
+		 * found the extended vma with the same vm_start.
+		 */
+		*ppos = vma->vm_end;
 	} else {
-		*ppos = -2;
+		*ppos = -2; /* -2 indicates gate vma */
 		vma = get_gate_vma(priv->mm);
 	}
 
@@ -163,28 +255,34 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return NULL;
 	}
 
-	if (mmap_read_lock_killable(mm)) {
+	if (!lock_vma_range(m, priv)) {
 		mmput(mm);
 		put_task_struct(priv->task);
 		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
+	/*
+	 * Reset current position if last_addr was set before
+	 * and it's not a sentinel.
+	 */
+	if (last_addr > 0)
+		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
 	if (last_addr == -2)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	if (*ppos == -2) {
-		*ppos = -1;
+		*ppos = -1; /* -1 indicates no more vmas */
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -196,7 +294,7 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	unlock_vma_range(priv);
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 5da384bd0a26..1f4f44951abe 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -309,6 +309,17 @@ void vma_mark_detached(struct vm_area_struct *vma);
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
+/*
+ * Locks next vma pointed by the iterator. Confirms the locked vma has not
+ * been modified and will retry under mmap_lock protection if modification
+ * was detected. Should be called from read RCU section.
+ * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if the
+ * process was interrupted.
+ */
+struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
+				     struct vma_iterator *iter,
+				     unsigned long address);
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
diff --git a/mm/madvise.c b/mm/madvise.c
index a34c2c89a53b..e61e32b2cd91 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
 
 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
-	mmap_assert_locked(vma->vm_mm);
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);
 
 	return vma->anon_name;
 }
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 5f725cc67334..ed0e5e2171cd 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);
 	return NULL;
 }
+
+static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struct *mm,
+						       struct vma_iterator *iter,
+						       unsigned long address)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	ret = mmap_read_lock_killable(mm);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Lookup the vma at the last position again under mmap_read_lock */
+	vma_iter_init(iter, mm, address);
+	vma = vma_next(iter);
+	if (vma)
+		vma_start_read_locked(vma);
+
+	mmap_read_unlock(mm);
+
+	return vma;
+}
+
+struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
+				     struct vma_iterator *iter,
+				     unsigned long address)
+{
+	struct vm_area_struct *vma;
+	unsigned int mm_wr_seq;
+	bool mmap_unlocked;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
+retry:
+	/* Start mmap_lock speculation in case we need to verify the vma later */
+	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
+	vma = vma_next(iter);
+	if (!vma)
+		return NULL;
+
+	vma = vma_start_read(mm, vma);
+
+	if (IS_ERR_OR_NULL(vma)) {
+		/*
+		 * Retry immediately if the vma gets detached from under us.
+		 * Infinite loop should not happen because the vma we find will
+		 * have to be constantly knocked out from under us.
+		 */
+		if (PTR_ERR(vma) == -EAGAIN) {
+			vma_iter_init(iter, mm, address);
+			goto retry;
+		}
+
+		goto out;
+	}
+
+	/*
+	 * Verify the vma we locked belongs to the same address space and it's
+	 * not behind of the last search position.
+	 */
+	if (unlikely(vma->vm_mm != mm || address >= vma->vm_end))
+		goto out_unlock;
+
+	/*
+	 * vma can be ahead of the last search position but we need to verify
+	 * it was not shrunk after we found it and another vma has not been
+	 * installed ahead of it. Otherwise we might observe a gap that should
+	 * not be there.
+	 */
+	if (address < vma->vm_start) {
+		/* Verify only if the address space might have changed since vma lookup. */
+		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
+			vma_iter_init(iter, mm, address);
+			if (vma != vma_next(iter))
+				goto out_unlock;
+		}
+	}
+
+	return vma;
+
+out_unlock:
+	vma_end_read(vma);
+out:
+	rcu_read_unlock();
+	vma = lock_vma_under_mmap_lock(mm, iter, address);
+	rcu_read_lock();
+
+	return vma;
+}
 #endif /* CONFIG_PER_VMA_LOCK */
 
 #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
-- 
2.50.0.727.gbf7dc18ff4-goog


