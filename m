Return-Path: <linux-fsdevel+bounces-50690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288EACE70E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 01:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CD51893B42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2626FA56;
	Wed,  4 Jun 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwOZ9b50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7426E158
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078745; cv=none; b=uGHqHWjw0A9tpHMKaRPbmbj63VYqH/PLAUi4PyAupzKEpGMnqJl0zt3ZFi9eCjGoOzA3QSXfrG8sDNvPZJj95oRiMbzq5tuZ1IfEEZN1dUXJwxSv5gV1r3W/dJ4PVau3XCP0B45bUI5WljFag2jzik6O8W1SueFlAb9vZV48TBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078745; c=relaxed/simple;
	bh=mFPZDSHvP8Le1U0FYOUeZC8kLtJLo4HKLNy8tuJwyLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dNFviEzGP+qd34Ynhzdnli2JtvRLtm3m6fFvMqA+DSM9SoWprG+JwcoNCrNyuPZ1DajhpTjM/I53/hW/Uj5oNJpmypBHuDVA8nvfPr0PrQflcewHwHSzy0B+lKwyrwlK19HprrsPBlB1P090Ki3koSBhFJygM8vYuLo4LdK488o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwOZ9b50; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso502739a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078743; x=1749683543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jAZB46rUPJ2qgJnBZa+KjMxZRHXtnvSFd09hYheqHc=;
        b=WwOZ9b50CcFJ/wm3IB6VuA/HxVwianTtZUaQUeL2KSQd1BI5PZqlvBTSX/jlrCQkvE
         IqCfrU3a0uHtExmUJzhxuQW4HhCWNTksxA7Im+l++qZWZ7ygS+H+5Ggsj+7mGTHFjW8C
         BGw82tPYAILg+5KXdHjolumTsZhR7/eiWN9pI3fAA06wV/6i0uPTOkyK0bYTPkc8FrT8
         dGwkQWyUIOq/CtTQYwEa2tXtERqnUQVOUTesv8pA2fNZ6E3sWZXNSEzVGuJtXMvDctjU
         kRXFcFHyIj+kucixuO1ZymrRaPljKN03btyfy1LRj+GrK0Bo4cb2Xlc7ScDWnncTjC/c
         Qh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078743; x=1749683543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jAZB46rUPJ2qgJnBZa+KjMxZRHXtnvSFd09hYheqHc=;
        b=KJeNNviNzGZL/sY2yW1V9jv0ii+dSOjton4Up/AguXsk18P0kcPsNHY7+5BmnDOpsI
         IPh0P/4NY3LGFdfdvw7/ISiGnXQb8aBTEP4OVKvhTr8ujstb8EZfojy657l4I50r/89m
         jmSSBLqyzWRYv8cBILDyyOA5BVOMzI8Keh5ZaiwtxRLqmXyl77BlMdSsonkLE5nzu9Ga
         su+fUImWe6970BuorBCHs2/4I3Ky00P5KghOqRKsUPidXUa1HncwepcwJRIqcJAEHK0v
         JDgOWvB69vYPAkDRQC1RwzxUUG7qDVlgq350yNpNPy7CBj9c59E+ykSPXorL8w+XROMl
         xX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCMKXD5gD1ltKp7pCzEkdaDMVktg7DJbvniu/E9LyyQl8sFhtwSccDaKa5MeCOukqHqfYARzHs2GnwiEpS@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmB9flbjVGLCs7999WBWK3vtoz9NUb94rtIKEjyYIDcrgUC/D
	PQMxmHsHJ9GtD2xoz8ZFWQpKoRfoXois9IEvilLtVUoXjJhGVTmzDEqAheuwwwpn23PAz96lZ1K
	OOQXksQ==
X-Google-Smtp-Source: AGHT+IHqF47aW9M08yO3toeqc2RtzX4uDZyQH+hhMJ0NwJbs8GXHWVPLg8Azianm01zLeglCaQIlbi3uDTU=
X-Received: from pjbpl16.prod.google.com ([2002:a17:90b:2690:b0:312:1c59:43a6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274b:b0:312:e90b:419c
 with SMTP id 98e67ed59e1d1-3130cdad77amr6196366a91.26.1749078742966; Wed, 04
 Jun 2025 16:12:22 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:50 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-7-surenb@google.com>
Subject: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
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
Completely lockless approach would be quite complex with the main issue
being get_vma_name() using callbacks which might not work correctly with
a stable vma copy, requiring original (unstable) vma.
When per-vma lock acquisition fails, we take the mmap_lock for reading,
lock the vma, release the mmap_lock and continue. This guarantees the
reader to make forward progress even during lock contention. This will
interfere with the writer but for a very short time while we are
acquiring the per-vma lock and only when there was contention on the
vma reader is interested in.
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
 fs/proc/internal.h |   6 ++
 fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..3728c9012687 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -379,6 +379,12 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	loff_t last_pos;
+#ifdef CONFIG_PER_VMA_LOCK
+	bool mmap_locked;
+	unsigned int mm_wr_seq;
+	struct vm_area_struct *locked_vma;
+#endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27972c0749e7..36d883c4f394 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -127,13 +127,172 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static struct vm_area_struct *trylock_vma(struct proc_maps_private *priv,
+					  struct vm_area_struct *vma,
+					  unsigned long last_pos,
+					  bool mm_unstable)
+{
+	vma = vma_start_read(priv->mm, vma);
+	if (IS_ERR_OR_NULL(vma))
+		return NULL;
+
+	/* Check if the vma we locked is the right one. */
+	if (unlikely(vma->vm_mm != priv->mm))
+		goto err;
+
+	/* vma should not be ahead of the last search position. */
+	if (unlikely(last_pos >= vma->vm_end))
+		goto err;
+
+	/*
+	 * vma ahead of last search position is possible but we need to
+	 * verify that it was not shrunk after we found it, and another
+	 * vma has not been installed ahead of it. Otherwise we might
+	 * observe a gap that should not be there.
+	 */
+	if (mm_unstable && last_pos < vma->vm_start) {
+		/* Verify only if the address space changed since vma lookup. */
+		if ((priv->mm_wr_seq & 1) ||
+		    mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq)) {
+			vma_iter_init(&priv->iter, priv->mm, last_pos);
+			if (vma != vma_next(&priv->iter))
+				goto err;
+		}
+	}
+
+	priv->locked_vma = vma;
+
+	return vma;
+err:
+	vma_end_read(vma);
+	return NULL;
+}
+
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
+static inline bool lock_content(struct seq_file *m,
+				struct proc_maps_private *priv)
+{
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read with locked vma only.
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
+static inline void unlock_content(struct proc_maps_private *priv)
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
 {
-	struct vm_area_struct *vma = vma_next(&priv->iter);
+	struct vm_area_struct *vma;
+	int ret;
+
+	if (priv->mmap_locked)
+		return vma_next(&priv->iter);
+
+	unlock_vma(priv);
+	/*
+	 * Record sequence number ahead of vma lookup.
+	 * Odd seqcount means address space modification is in progress.
+	 */
+	mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
+	vma = vma_next(&priv->iter);
+	if (!vma)
+		return NULL;
+
+	vma = trylock_vma(priv, vma, last_pos, true);
+	if (vma)
+		return vma;
+
+	/* Address space got modified, vma might be stale. Re-lock and retry */
+	rcu_read_unlock();
+	ret = mmap_read_lock_killable(priv->mm);
+	rcu_read_lock();
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Lookup the vma at the last position again under mmap_read_lock */
+	vma_iter_init(&priv->iter, priv->mm, last_pos);
+	vma = vma_next(&priv->iter);
+	if (vma) {
+		vma = trylock_vma(priv, vma, last_pos, false);
+		WARN_ON(!vma); /* mm is stable, has to succeed */
+	}
+	mmap_read_unlock(priv->mm);
+
+	return vma;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
 
+static inline bool lock_content(struct seq_file *m,
+				struct proc_maps_private *priv)
+{
+	return mmap_read_lock_killable(priv->mm) == 0;
+}
+
+static inline void unlock_content(struct proc_maps_private *priv)
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
 		*ppos = -2UL;
 		vma = get_gate_vma(priv->mm);
@@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return NULL;
 	}
 
-	if (mmap_read_lock_killable(mm)) {
+	if (!lock_content(m, priv)) {
 		mmput(mm);
 		put_task_struct(priv->task);
 		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
+	if (last_addr > 0)
+		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
 	if (last_addr == -2UL)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
@@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 		*ppos = -1UL;
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	unlock_content(priv);
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
-- 
2.49.0.1266.g31b7d2e469-goog


