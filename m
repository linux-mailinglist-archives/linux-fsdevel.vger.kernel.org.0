Return-Path: <linux-fsdevel+bounces-55081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E338B06BF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E78189E29B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159C288514;
	Wed, 16 Jul 2025 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opXiIaSR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEC278E47
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635178; cv=none; b=Gmq69lZzuP6MYf+qZL0aGU59z+83xFEzamPibq81lHjagti7XV7j51XNySNXz+6kwpXWK0+nX43VsjTpwRwH1DECUVxmhtVzcErWdLRZnZ7HAFx7Df45Hp5YYObHDmhljZgBxWJiwPqCZdcAC9r81LYsnbRrULTuIkZ1NFWHMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635178; c=relaxed/simple;
	bh=oYvFfw2em77nggEm2xeU3D+z1Cfni8O5wEzbV1vruOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=siukmmPI9q18GZl9hgOhU0hAadW2hdft6qJU2dbNA8mxibJeCF0zHzBAr8cvoePEgty0rkjREwICZaOl7qCPelew/C+Lp/C1jLfrdkXhvUUetZBwF6XBDlYW5yBVGGaA0jKig75keHHpiNXPIn45HJXstOvowCFWyI1e0+eydU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opXiIaSR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234fedd3e51so59287295ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635176; x=1753239976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPwtRwrvPyoO56Fp2A3+1i9CxPrsJGWcxqOdpZT86SM=;
        b=opXiIaSRW9brSk09FHq99BHCJMwHw5D7ECD4RCSOnBv+sb6EICuGewCygsSdMPEdka
         G27top+pfaSJ70a79koodCqr6Tu+XZC26zBRmYLD7XXcXdudp6CcWi2R2PTexVv0LTZR
         iZuOdhiJq2HeJpvXYaWbzRuSNZCJuCnmeoeKtXeossrfOJDt18Y7hK4icVJbLheJj29o
         nSdUAXE8Gr3JKBpGk1aT6TxMAhAzg7rGTdUMtKPSEj1riArFj8xt8+9118e+0b/7II0b
         +yotOKNF4JBchb20hZAVbKXwH1SgCrtk0KiDAhF4fsbP1pCs2zcAJOMl9HJeULw2EKK4
         ALgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635176; x=1753239976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPwtRwrvPyoO56Fp2A3+1i9CxPrsJGWcxqOdpZT86SM=;
        b=GZrS1krfeROEvbfuv4DoPqbow2u/Qo0rgw76ck8wbLrYrPQ9ze29KjNRTlRlcsefgh
         pvPCENOep0rCMv5P/c9CspQcu4Nw+sMfFDUQd/a8G60bAmy7poBvzCJ6sGTbBnCy8KbD
         86u4EpKX+S5nATY/Xrra7SMAhAZIWaRRQl/09TkQDrf2msAH+wbregSCO/92ioUe+gwU
         4jlIqo1Cf30V1gtPVFT8DNWXPyPZCrqO3X/5MiS7n5nLxqdIP/l1Nrv6XLgN8gv238if
         usB6aPSFg+s/iY5rJ1S4/u9tRNsiBFslW9rm1TDV5LTZmiMswyUDcIKZ5Zv1SNbjVYT2
         +yrw==
X-Forwarded-Encrypted: i=1; AJvYcCU13P9UwUQfn340c4Q/ajTU4zAmxX/sprfFwhIsp/wsiE6Am6+iNf55BpyTxaPgkmFQ52beKJ7edAru92sC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5X+0wZz5EBTvsn+V5veOOe8g3M3n+2mG7Ose5SAD9X8UzcD4c
	0nX+D26vLgcQNN2OHk39uHjT0/ylFYBaRW5OG8h2zSxG6tEo2Q+Xb0wsFu3kDP/KHjzpFXfAnFe
	uVJ11rQ==
X-Google-Smtp-Source: AGHT+IHyXJbEHIgp2+qVGKBtnHRMJI8uJh40Q+DDdPYoHZcLs9Jo1htz2teqIVJkmR2xgXKKUNDYwihzWlM=
X-Received: from pjx14.prod.google.com ([2002:a17:90b:568e:b0:311:a4ee:7c3d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:224:10a2:cae7
 with SMTP id d9443c01a7336-23e25770df5mr17655605ad.40.1752635175619; Tue, 15
 Jul 2025 20:06:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:56 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-8-surenb@google.com>
Subject: [PATCH v7 7/7] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
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
---
 fs/proc/internal.h        |   5 ++
 fs/proc/task_mmu.c        | 145 +++++++++++++++++++++++++++++++++++---
 include/linux/mmap_lock.h |  11 +++
 mm/madvise.c              |   3 +-
 mm/mmap_lock.c            |  93 ++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 11 deletions(-)

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
index b8bc06d05a72..b15d0ef29896 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -127,15 +127,134 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
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
-		*ppos = -2;
+		*ppos = -2; /* -2 indicates gate vma */
 		vma = get_gate_vma(priv->mm);
 	}
 
@@ -163,28 +282,34 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
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
@@ -196,7 +321,7 @@ static void m_stop(struct seq_file *m, void *v)
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
index 1c30031ab035..9de9b7c797c6 100644
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


