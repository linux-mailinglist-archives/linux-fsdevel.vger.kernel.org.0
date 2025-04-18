Return-Path: <linux-fsdevel+bounces-46687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04855A93C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383EB920855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED9225A4F;
	Fri, 18 Apr 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KygVUAlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7822540B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998622; cv=none; b=KC8G5vPnxyNrJVsHYHBvXDqTUNFBYp3dqvqcJ+dR6XtTJYZrJHLDVODvFz6TE0i5f7cOXZT7SzQ3B3L96iAEx7aCmy3KmLfhAsZAvg55xo8XDlzKCj50S23I7dEm+vr/+TAYwYqZ+aAORJQnJ70LSoCp5flt1T0BucVbjuMAKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998622; c=relaxed/simple;
	bh=20+DFZgTng6ZYblv4okOjrUyBQ5mxE92qM420ijlexM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USxjvzjC8C/9z9Ktc02MkTpMkSTLSWjzweAaqV+9qLBWNknPC2Ec9+pjRKnU3P3rqoac0CL+m5OgNTXwSJLwBxD1NeFg42ll0gWTW4zreeZBDnsy/4l3GIayy6HVU5KB0b2+Pr/hPFPilW7nasQfqSdDfu5viKDu8AJ/WQGa93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KygVUAlx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af9b25da540so1198730a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998618; x=1745603418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zYtkrY7HUMXj6I83iq2T2dcIR3++4RWvz/bo+0QsbU=;
        b=KygVUAlxQS1mQjAnX7J0juIs8PRjKB4JOuOMYE3GwrDNuu1Jvqt8xvy+6QQR4lt1KA
         /CF85Dds4ZVc5+O/TPD5C9dniUOzdO70Tu3Z5o1sKPV7xQBXBEyucKDE1qA24B+sgskq
         suT9T2Ua1so9sAaRknrOfIz9Cht8EjjWHWA30s9B1FarjSUk3zuxjARV4I6tzM4nnvjJ
         +jo5r+RWj0fyKeHLMsQw3Fs9XdDRPJpjFfk3ckJh4trZR/D/M77ffiJVEMcoyWcP4WcZ
         +tYQvlR7ll3W5Oe+7bcyX3OZemHFSYKuHNzU5Q8fhXNLQbyClccKjfv/+WDlDQ7fferR
         9WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998618; x=1745603418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zYtkrY7HUMXj6I83iq2T2dcIR3++4RWvz/bo+0QsbU=;
        b=w5Q/arWypwY5jK4QLCnw98l7GZL5Wx5M5g/xYf5YkcYmwTz6m4Clg2v2YzN0SRUuOP
         ViJBHMMk907aSkCx/Kr1oZB8vcOGevC7oLvmQzAdgHPsSAwZhbBJ0lulpYDEfK5BeQ2u
         GHhHjKuP+gZhyHs0xOI4J+pSLfTFGOIDu5Sp9k4Sa/hhQy2J/U+sFKZ5G8RVBzKro30Q
         fK5L8MMZwAOO/IEO1Ja9xUDrZuP2heUcYkWVHUpSRrVwPoHRmhr28HXZ1wXQ1f1OCSnA
         rq0/iZbrYgxmtjWAIw0xOtXfkpbi9jAPg2i62B4jHtsWoR114TK0vY0UNAtTbBVrgVFo
         bK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/1ktbLVtfl0pUpp4pCbtfuQkL6CnId+6JkkBXonfgWxextEFnHKe1gKw8e6LcdWo9K7R5FoT7MF7YmNN/@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBL/+gWNa4YJuPorM7AXtDnT5QgaRqcU6sWUsCVrdjBPAij62
	hm2o72QO6Tvh7M/DX7WAjk4pMbNvePueItQIz+w2muBEmLmt1MV2+t4ePfTbjBT2x30Tr3uAKW0
	kyg==
X-Google-Smtp-Source: AGHT+IFtA4TMsuStPYu7aoBjj//DZ8se4BNHvSXu+W66hYuPWTAds876LFCU1b60VeWLvlCjpqZ1/KyDDUw=
X-Received: from pjbpa2.prod.google.com ([2002:a17:90b:2642:b0:2ef:7af4:5e8e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528a:b0:2ff:7ad4:77b1
 with SMTP id 98e67ed59e1d1-3087bb3973fmr6045262a91.2.1744998618622; Fri, 18
 Apr 2025 10:50:18 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:58 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-8-surenb@google.com>
Subject: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With maple_tree supporting vma tree traversal under RCU and vma and
its important members being RCU-safe, /proc/pid/maps can be read under
RCU and without the need to read-lock mmap_lock. However vma content
can change from under us, therefore we make a copy of the vma and we
pin pointer fields used when generating the output (currently only
vm_file and anon_name). Afterwards we check for concurrent address
space modifications, wait for them to end and retry. While we take
the mmap_lock for reading during such contention, we do that momentarily
only to record new mm_wr_seq counter. This change is designed to reduce
mmap_lock contention and prevent a process reading /proc/pid/maps files
(often a low priority task, such as monitoring/data collection services)
from blocking address space updates.
Note that this change has a userspace visible disadvantage: it allows
for sub-page data tearing as opposed to the previous mechanism where
data tearing could happen only between pages of generated output data.
Since current userspace considers data tearing between pages to be
acceptable, we assume is will be able to handle sub-page data tearing
as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h        |   6 ++
 fs/proc/task_mmu.c        | 170 ++++++++++++++++++++++++++++++++++----
 include/linux/mm_inline.h |  18 ++++
 3 files changed, 177 insertions(+), 17 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..6e1169c1f4df 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -379,6 +379,12 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	bool mmap_locked;
+	loff_t last_pos;
+#ifdef CONFIG_PER_VMA_LOCK
+	unsigned int mm_wr_seq;
+	struct vm_area_struct vma_copy;
+#endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b9e4fbbdf6e6..f9d50a61167c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -127,13 +127,130 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static const struct seq_operations proc_pid_maps_op;
+
+/*
+ * Take VMA snapshot and pin vm_file and anon_name as they are used by
+ * show_map_vma.
+ */
+static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *copy = &priv->vma_copy;
+	int ret = -EAGAIN;
+
+	memcpy(copy, vma, sizeof(*vma));
+	if (copy->vm_file && !get_file_rcu(&copy->vm_file))
+		goto out;
+
+	if (!anon_vma_name_get_if_valid(copy))
+		goto put_file;
+
+	if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
+		return 0;
+
+	/* Address space got modified, vma might be stale. Re-lock and retry. */
+	rcu_read_unlock();
+	ret = mmap_read_lock_killable(priv->mm);
+	if (!ret) {
+		/* mmap_lock_speculate_try_begin() succeeds when holding mmap_read_lock */
+		mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
+		mmap_read_unlock(priv->mm);
+		ret = -EAGAIN;
+	}
+
+	rcu_read_lock();
+
+	anon_vma_name_put_if_valid(copy);
+put_file:
+	if (copy->vm_file)
+		fput(copy->vm_file);
+out:
+	return ret;
+}
+
+static void put_vma_snapshot(struct proc_maps_private *priv)
+{
+	struct vm_area_struct *vma = &priv->vma_copy;
+
+	anon_vma_name_put_if_valid(vma);
+	if (vma->vm_file)
+		fput(vma->vm_file);
+}
+
+static inline bool drop_mmap_lock(struct seq_file *m, struct proc_maps_private *priv)
+{
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read under RCU.
+	 */
+	if (m->op != &proc_pid_maps_op)
+		return false;
+
+	/* mmap_lock_speculate_try_begin() succeeds when holding mmap_read_lock */
+	mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
+	mmap_read_unlock(priv->mm);
+	rcu_read_lock();
+	memset(&priv->vma_copy, 0, sizeof(priv->vma_copy));
+
+	return true;
+}
+
+static struct vm_area_struct *get_stable_vma(struct vm_area_struct *vma,
+					     struct proc_maps_private *priv,
+					     loff_t last_pos)
+{
+	int ret;
+
+	put_vma_snapshot(priv);
+	while ((ret = get_vma_snapshot(priv, vma)) == -EAGAIN) {
+		/* lookup the vma at the last position again */
+		vma_iter_init(&priv->iter, priv->mm, last_pos);
+		vma = vma_next(&priv->iter);
+	}
+
+	return ret ? ERR_PTR(ret) : &priv->vma_copy;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+/* Without per-vma locks VMA access is not RCU-safe */
+static inline bool drop_mmap_lock(struct seq_file *m,
+				  struct proc_maps_private *priv)
+{
+	return false;
+}
+
+static struct vm_area_struct *get_stable_vma(struct vm_area_struct *vma,
+					     struct proc_maps_private *priv,
+					     loff_t last_pos)
+{
+	return vma;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 {
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = vma_next(&priv->iter);
 
+	if (vma && !priv->mmap_locked)
+		vma = get_stable_vma(vma, priv, *ppos);
+
+	if (IS_ERR(vma))
+		return vma;
+
 	if (vma) {
-		*ppos = vma->vm_start;
+		/* Store previous position to be able to restart if needed */
+		priv->last_pos = *ppos;
+		/*
+		 * Track the end of the reported vma to ensure position changes
+		 * even if previous vma was merged with the next vma and we
+		 * found the extended vma with the same vm_start.
+		 */
+		*ppos = vma->vm_end;
 	} else {
 		*ppos = -2UL;
 		vma = get_gate_vma(priv->mm);
@@ -148,6 +265,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	unsigned long last_addr = *ppos;
 	struct mm_struct *mm;
 
+	priv->mmap_locked = true;
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr == -1UL)
 		return NULL;
@@ -170,12 +288,18 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
+	/* Drop mmap_lock if possible */
+	if (drop_mmap_lock(m, priv))
+		priv->mmap_locked = false;
+
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
@@ -184,7 +308,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 		*ppos = -1UL;
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -196,7 +320,10 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	if (priv->mmap_locked)
+		mmap_read_unlock(mm);
+	else
+		rcu_read_unlock();
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -243,14 +370,20 @@ static int do_maps_open(struct inode *inode, struct file *file,
 static void get_vma_name(struct vm_area_struct *vma,
 			 const struct path **path,
 			 const char **name,
-			 const char **name_fmt)
+			 const char **name_fmt, bool mmap_locked)
 {
-	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;
+	struct anon_vma_name *anon_name;
 
 	*name = NULL;
 	*path = NULL;
 	*name_fmt = NULL;
 
+	if (vma->vm_mm)
+		anon_name = mmap_locked ? anon_vma_name(vma) :
+					  anon_vma_name_get_rcu(vma);
+	else
+		anon_name = NULL;
+
 	/*
 	 * Print the dentry name for named mappings, and a
 	 * special [heap] marker for the heap:
@@ -266,39 +399,41 @@ static void get_vma_name(struct vm_area_struct *vma,
 		} else {
 			*path = file_user_path(vma->vm_file);
 		}
-		return;
+		goto out;
 	}
 
 	if (vma->vm_ops && vma->vm_ops->name) {
 		*name = vma->vm_ops->name(vma);
 		if (*name)
-			return;
+			goto out;
 	}
 
 	*name = arch_vma_name(vma);
 	if (*name)
-		return;
+		goto out;
 
 	if (!vma->vm_mm) {
 		*name = "[vdso]";
-		return;
+		goto out;
 	}
 
 	if (vma_is_initial_heap(vma)) {
 		*name = "[heap]";
-		return;
+		goto out;
 	}
 
 	if (vma_is_initial_stack(vma)) {
 		*name = "[stack]";
-		return;
+		goto out;
 	}
 
 	if (anon_name) {
 		*name_fmt = "[anon:%s]";
 		*name = anon_name->name;
-		return;
 	}
+out:
+	if (anon_name && !mmap_locked)
+		anon_vma_name_put(anon_name);
 }
 
 static void show_vma_header_prefix(struct seq_file *m,
@@ -324,6 +459,7 @@ static void show_vma_header_prefix(struct seq_file *m,
 static void
 show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 {
+	struct proc_maps_private *priv = m->private;
 	const struct path *path;
 	const char *name_fmt, *name;
 	vm_flags_t flags = vma->vm_flags;
@@ -344,7 +480,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
 
-	get_vma_name(vma, &path, &name, &name_fmt);
+	get_vma_name(vma, &path, &name, &name_fmt, priv->mmap_locked);
 	if (path) {
 		seq_pad(m, ' ');
 		seq_path(m, path, "\n");
@@ -549,7 +685,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 		const char *name_fmt;
 		size_t name_sz = 0;
 
-		get_vma_name(vma, &path, &name, &name_fmt);
+		get_vma_name(vma, &path, &name, &name_fmt, true);
 
 		if (path || name_fmt || name) {
 			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 9ac2d92d7ede..436512f1e759 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -434,6 +434,21 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 
 struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
 
+/*
+ * Takes a reference if anon_vma is valid and stable (has references).
+ * Fails only if anon_vma is valid but we failed to get a reference.
+ */
+static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma)
+{
+	return !vma->anon_name || anon_vma_name_get_rcu(vma);
+}
+
+static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma)
+{
+	if (vma->anon_name)
+		anon_vma_name_put(vma->anon_name);
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
@@ -453,6 +468,9 @@ struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
 	return NULL;
 }
 
+static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma) { return true; }
+static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma) {}
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
-- 
2.49.0.805.g082f7c87e0-goog


