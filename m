Return-Path: <linux-fsdevel+bounces-55517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4851B0B16D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD71563BF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED228A716;
	Sat, 19 Jul 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEmcpjVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C428A1EA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949753; cv=none; b=GMCUG78AvNQ64WPrbqdEkpuQFXOGCOZlHL/6N08WZll0UxqsLrosKJZG/Qbh1RIuRIQP/okh55J9cRWLovoj6RHH8wBeyQRnR+Ln2nDvExIq/2rBoPntrFFPrhD4KSqXPpMXvBHmT7boTqwyDN8bS6SAwFiimdxb1BARjjpruf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949753; c=relaxed/simple;
	bh=0R92dkqkLkVyRhsk1A+S8miCbOzA10PVNtoE2FxT788=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGejzQ8iIAScStZJhIXw6sv1TC7YgqzmX8/LC4XApJrAfhdE7gH95Itf8dGSEWf7mXaCWtN4Hq58pFing3gd/s+QY6QWPX5Ty1vIthq7Z+9NSPNWU/CZBnO3nHw6nfULYbAxomVOU1ZEA93WeYwvAtbDa01ebzB75Iw/Z7evhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEmcpjVW; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso3899894fac.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949750; x=1753554550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDMAWi2K+NbQLnl9UyB/CGGV2UlqflJbxYQJHmN9ABQ=;
        b=TEmcpjVW08Bm5YHCFLSjioRHJd8I2hCyrLyrzU0nNc3gOViTh28hyFLoNgChkigPIp
         S/i3zjyMiItfq16GDXycpCM96arJZ0DbGCk131fe8Pou8MeARF/QcM2vRIJx3a2BjQsK
         4SnAc0LWFZ6zpj8S3yqhe0K1bLCgyI+liRb1GxLVLnlci5hRdRTkEjZ8UeW0gQckPlz3
         e5Bg+keqVeSq3J3Azfpgq5KI8f2KZ3NFvajm7bxOoCzlLvI0QWI1EuUfRyoHXPJMGU55
         GJ+4gvLv2aFmaYNSeY2d6ZCYIjtP1gCho0rqyAvALvNdF1kX+ebgdp4txEAPcvzJHnLY
         dfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949750; x=1753554550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDMAWi2K+NbQLnl9UyB/CGGV2UlqflJbxYQJHmN9ABQ=;
        b=Qwg8c4z4pG9YL0Fa4LeX3jD7aF5P6zetpopCZ3T+7ltrHVk7dvcihIwQvlM+SVADN9
         GaTGUcJO7u/au9SWmfyD2k+iR8mTmObWOJ+h2tpRUwEy1cuPph2uEcwzoykAGPeCQ5wt
         jw9dt2+CilWiN2Nx2HulvTAK8RygW8IGiL0J1IzJ2i2A/J3gS5SNSS1mCKDXgE96o2t6
         +AXikhSEuIrh31BI+SGXmnDNPT98PBJtwBfHRd7SzlnK7VlkW2iw79SSFZx8qjgIVWLi
         8w4IX6YKAAbFcvEuBQRDnmAzSTJgc6Rx4mn+CJM//uqEbyHlwak4sB6HkrSMT2aWrOOw
         0tyg==
X-Forwarded-Encrypted: i=1; AJvYcCU8lWedDWzNRv2KD3pzOkrG6IeSIeZuOCRWdTdCx10aOZN9BefMFjds5schZ0v572EFY1rL+YdEVUNlF38j@vger.kernel.org
X-Gm-Message-State: AOJu0YypQ7PJEgq5N330oS5lOooo/vB2uOuxqdq6ssF8bDn6miHuKNSE
	CHYUh78pkYHLw4eIsxU9+H4E/rFVJs/nsIyvGf8mjNXhLrnpSvte6eQdX0GvONWsNzsGhOXl5E5
	hw/4k+A==
X-Google-Smtp-Source: AGHT+IEipe0LJbGyYnss4/OL7SnvMyb93XlarOafpChub5K6cjmzI5jbHM8Jlvma++lFZLdQmq8W3nTugY8=
X-Received: from oabms18.prod.google.com ([2002:a05:6870:6b92:b0:303:204:336f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:7c18:b0:2c2:3e24:9b54
 with SMTP id 586e51a60fabf-2ffb225ee4amr10130864fac.11.1752949749803; Sat, 19
 Jul 2025 11:29:09 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:54 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-7-surenb@google.com>
Subject: [PATCH v8 6/6] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
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
A completely lockless approach (walking vma tree under RCU) would be
quite complex with the main issue being get_vma_name() using callbacks
which might not work correctly with a stable vma copy, requiring
original (unstable) vma - see special_mapping_name() for example.

When per-vma lock acquisition fails, we take the mmap_lock for reading,
lock the vma, release the mmap_lock and continue. This fallback to mmap
read lock guarantees the reader to make forward progress even during
lock contention. This will interfere with the writer but for a very
short time while we are acquiring the per-vma lock and only when there
was contention on the vma reader is interested in.

We shouldn't see a repeated fallback to mmap read locks in practice, as
this require a very unlikely series of lock contentions (for instance
due to repeated vma split operations). However even if this did somehow
happen, we would still progress.

One case requiring special handling is when a vma changes between the
time it was found and the time it got locked. A problematic case would
be if a vma got shrunk so that its vm_start moved higher in the address
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/internal.h        |   5 ++
 fs/proc/task_mmu.c        | 141 +++++++++++++++++++++++++++++++++++---
 include/linux/mmap_lock.h |  11 +++
 mm/madvise.c              |   3 +-
 mm/mmap_lock.c            |  93 +++++++++++++++++++++++++
 5 files changed, 244 insertions(+), 9 deletions(-)

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
index 90237df1ed33..3d6d8a9f13fc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -130,13 +130,132 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
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
+	 * mmap_lock but maps can be read with locking just the vma and
+	 * walking the vma tree under rcu read protection.
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
+static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
+					 loff_t pos)
 {
-	struct vm_area_struct *vma = vma_next(&priv->iter);
+	if (priv->mmap_locked)
+		return false;
+
+	rcu_read_unlock();
+	mmap_read_lock(priv->mm);
+	/* Reinitialize the iterator after taking mmap_lock */
+	vma_iter_set(&priv->iter, pos);
+	priv->mmap_locked = true;
 
+	return true;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline bool lock_vma_range(struct seq_file *m,
+				  struct proc_maps_private *priv)
+{
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
+
+static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
+					 loff_t pos)
+{
+	return false;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
+{
+	struct proc_maps_private *priv = m->private;
+	struct vm_area_struct *vma;
+
+retry:
+	vma = get_next_vma(priv, *ppos);
+	/* EINTR of EAGAIN is possible */
+	if (IS_ERR(vma)) {
+		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
+			goto retry;
+
+		return vma;
+	}
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
 		*ppos = SENTINEL_VMA_GATE;
 		vma = get_gate_vma(priv->mm);
@@ -166,19 +285,25 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
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
 	if (last_addr == SENTINEL_VMA_GATE)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
@@ -187,7 +312,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 		*ppos = SENTINEL_VMA_END;
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -199,7 +324,7 @@ static void m_stop(struct seq_file *m, void *v)
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
index da6e0e7c00b5..5c32c3b95e51 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -109,7 +109,8 @@ void anon_vma_name_free(struct kref *kref)
 
 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
-	mmap_assert_locked(vma->vm_mm);
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);
 
 	return vma->anon_name;
 }
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 5f725cc67334..729fb7d0dd59 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -178,6 +178,99 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);
 	return NULL;
 }
+
+static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
+							    struct vma_iterator *vmi,
+							    unsigned long from_addr)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	ret = mmap_read_lock_killable(mm);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Lookup the vma at the last position again under mmap_read_lock */
+	vma_iter_set(vmi, from_addr);
+	vma = vma_next(vmi);
+	if (vma) {
+		/* Very unlikely vma->vm_refcnt overflow case */
+		if (unlikely(!vma_start_read_locked(vma)))
+			vma = ERR_PTR(-EAGAIN);
+	}
+
+	mmap_read_unlock(mm);
+
+	return vma;
+}
+
+struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
+				     struct vma_iterator *vmi,
+				     unsigned long from_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned int mm_wr_seq;
+	bool mmap_unlocked;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
+retry:
+	/* Start mmap_lock speculation in case we need to verify the vma later */
+	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
+	vma = vma_next(vmi);
+	if (!vma)
+		return NULL;
+
+	vma = vma_start_read(mm, vma);
+	if (IS_ERR_OR_NULL(vma)) {
+		/*
+		 * Retry immediately if the vma gets detached from under us.
+		 * Infinite loop should not happen because the vma we find will
+		 * have to be constantly knocked out from under us.
+		 */
+		if (PTR_ERR(vma) == -EAGAIN) {
+			/* reset to search from the last address */
+			vma_iter_set(vmi, from_addr);
+			goto retry;
+		}
+
+		goto fallback;
+	}
+
+	/*
+	 * Verify the vma we locked belongs to the same address space and it's
+	 * not behind of the last search position.
+	 */
+	if (unlikely(vma->vm_mm != mm || from_addr >= vma->vm_end))
+		goto fallback_unlock;
+
+	/*
+	 * vma can be ahead of the last search position but we need to verify
+	 * it was not shrunk after we found it and another vma has not been
+	 * installed ahead of it. Otherwise we might observe a gap that should
+	 * not be there.
+	 */
+	if (from_addr < vma->vm_start) {
+		/* Verify only if the address space might have changed since vma lookup. */
+		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
+			vma_iter_set(vmi, from_addr);
+			if (vma != vma_next(vmi))
+				goto fallback_unlock;
+		}
+	}
+
+	return vma;
+
+fallback_unlock:
+	vma_end_read(vma);
+fallback:
+	rcu_read_unlock();
+	vma = lock_next_vma_under_mmap_lock(mm, vmi, from_addr);
+	rcu_read_lock();
+	/* Reinitialize the iterator after re-entering rcu read section */
+	vma_iter_set(vmi, IS_ERR_OR_NULL(vma) ? from_addr : vma->vm_end);
+
+	return vma;
+}
 #endif /* CONFIG_PER_VMA_LOCK */
 
 #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
-- 
2.50.0.727.gbf7dc18ff4-goog


