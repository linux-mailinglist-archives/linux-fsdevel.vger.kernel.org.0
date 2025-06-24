Return-Path: <linux-fsdevel+bounces-52806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9945AE6FB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EE418890B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65C2EBDEA;
	Tue, 24 Jun 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lexT8NlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE52EBDEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793657; cv=none; b=innvBVV2ayU8W95ULpNvPUkcvNUM3FnICF5NcdEHsqbAWhbMBZJKKfHN8J7azejuIiuEwqX+q4LbT4T9WstpEE99qTiMiymg3q+RxSjuGscGlr41hKDZnlVJNiyjbvEYtH644zkH/FbbhB9whpLsKz2EgJ8N9Quc1znrD5OANNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793657; c=relaxed/simple;
	bh=U4CpqRhmkjkU+JSBE1xEgEtaLoyuPdpcrl5XFw5JfRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e45hT71dK63LsfKYEc7Srm67ORS3FnJvfZMJsIFZBXnevBHTQ8VI3VfzVnu8b7f2SUnJRtmAh8QyW2S8YqRIHwdRJbjWI69eoyvfBOEj5SLnuO3wFznrwV3RkaHvndNFHLpbuRZNZEN2Gnqb4yNZly9aODFx/QhODOPxB76dACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lexT8NlL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so50319545ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750793655; x=1751398455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8jCWZ/F+ajpqK4ZOmTtaT6tZvVFIoI2XxVqwquCgmw=;
        b=lexT8NlLX3KgGeZX3T/PApvCCB7P4EEKvnwrfpzvbxwXJRdFSiS6PecyRjA5BNYQCL
         p5ViVEInGKJeLomMCdQH67LSjJpyP7576YxVekJI2INkI33uHsHSVZw5ibTvXSvD+p2X
         D3ts+Z/Md4oErG5qlULHQ+N+eI3Q4Z4GFgDqVEbk/i9DNjBXosOrP4xz0NJs9Bt4Xr3C
         ycjc8ikB2aaszRtlsMkuYTzelMkmoAo2rsNXQRu2SNrtquDVyJBzyhkIajuKIp7O85qD
         2QUTrQcYS76YCb63DZLSYnnYyfUkLHRTG2oDRHV9LNjllq6gr/tBSi6XnVfXMZxTAsmr
         5Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793655; x=1751398455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8jCWZ/F+ajpqK4ZOmTtaT6tZvVFIoI2XxVqwquCgmw=;
        b=m0rE6wVjvdtdCTSL/GmADiSnZV7ctk2xO/Ct1zYRR8o5tAJcDYTcRgvAGe+tOwC1JJ
         LQ859WoMLPl6rfzBgMmW0ebLmhwt/5zN3vCNVsB0o2pD9aVZNRd4X5cIrME3vJxweonL
         j2rjTp01S0SQa09AAvUHVGWovAysldhKLfF1mt5GSvJlumCLjx6h0NGtPTkY/2b/jR/G
         vUXC/km4B8uHS1qrDyyTFfuWRIw0ebINj/EP+ZClDDlZE3Im85U+w6NmUDcdmcmHcbyU
         4VKnHxP1V6q0RsCWlO7BcstX4/MW8y01S1GGe7B4x3+BNvwSdVEr2/XYqC3VjJvUvhcp
         lRdg==
X-Forwarded-Encrypted: i=1; AJvYcCXmT45NI9VdGdgAyn1E9wcRtQ42xrVvQLBYRYL08qBJquOPYjzhX07gCIdZsh1+/3lLwMv+oCs2x3LZ3TsY@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcgV+0hiVg62j66lYVYCIg0p9idERaAVguCRNCwr1PTRxIdOr
	b3UyIXZwMC5/jhK+pY1s0A2Q6dAhNt2ynkrETflTP+1p2gZEAyUynZOLH7RYd9txcOBauPIx065
	KPQlVCQ==
X-Google-Smtp-Source: AGHT+IF1b8D4iLGP12pVy+17DkqSsks+kkF0hmalJQ6QlCgP6k7A5fSY0k99ddn2kQ7IT6XhG2dE5s8LCCA=
X-Received: from plbkw7.prod.google.com ([2002:a17:902:f907:b0:234:4c97:1e84])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f684:b0:235:60e:3704
 with SMTP id d9443c01a7336-23823fc3f99mr9626325ad.12.1750793655228; Tue, 24
 Jun 2025 12:34:15 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:33:58 -0700
In-Reply-To: <20250624193359.3865351-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624193359.3865351-7-surenb@google.com>
Subject: [PATCH v5 6/7] mm/maps: read proc/pid/maps under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
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
 fs/proc/task_mmu.c        | 123 ++++++++++++++++++++++++++++++++++----
 include/linux/mmap_lock.h |  11 ++++
 mm/mmap_lock.c            |  88 +++++++++++++++++++++++++++
 4 files changed, 217 insertions(+), 10 deletions(-)

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
index 751479eb128f..33171afb5364 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -127,21 +127,118 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static void unlock_vma(struct proc_maps_private *priv)
 {
-	struct vm_area_struct *vma = vma_next(&priv->iter);
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
-		*ppos = -2UL;
+		*ppos = -2UL; /* -2 indicates gate vma */
 		vma = get_gate_vma(priv->mm);
 	}
 
 	return vma;
 }
 
+static inline bool is_sentinel_pos(unsigned long pos)
+{
+	return pos == -1UL || pos == -2UL;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
@@ -163,28 +260,34 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
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
+	if (last_addr > 0 && !is_sentinel_pos(last_addr))
+		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
 	if (last_addr == -2UL)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	if (*ppos == -2UL) {
-		*ppos = -1UL;
+		*ppos = -1UL; /* -1 indicates no more vmas */
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -196,7 +299,7 @@ static void m_stop(struct seq_file *m, void *v)
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
2.50.0.714.g196bf9f422-goog


