Return-Path: <linux-fsdevel+bounces-57106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578CB1EC26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD52D173390
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FD284B41;
	Fri,  8 Aug 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/ZGTQ36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7F284679
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666940; cv=none; b=EGs7KCJb+cseiaOjEQNwm8JfXN+juSbEvt25hRYJt1Emw0N5Wm7RgM/4kgTKOThostFvHnyVMZWOX5YT19FF+kghjGT/2puOtgpox4cLZfxCmioCIwNxP8FvkTpMvR4UpsbnzMRSu93yyzernFiJCLQD0l8Iejmz4ZZTmx/ZGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666940; c=relaxed/simple;
	bh=8OpkCmKw3cH6l8CeUegwMH8CJE9pwSj6mNLkROJG1EU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQsQzqUCzfOxj+KZEptxWcH+KW3bUjsigv6WplmbU3Rq8a1zZgxdGRf890HJcw2qsDJ1H0ztNAlDH6IJeVlz86UjNNi1+2PdH+jvYiEEEZkZzWLZQbPCTcjq+RFlRu2D5NQm941BbhDcV46r4KZoYzDV+wi6UhyyQQ2bNMk2sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/ZGTQ36; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2424aaa9840so24049125ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754666938; x=1755271738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaaNxrFIYW8u5Zqt1umxh8jF3epFz2+2Ag+pI49sCxs=;
        b=S/ZGTQ36COb95MWDNuMPX0f3SboiluAtmYfellRrvJBfjVWDIybNe+/MigQ0/oBGJJ
         LHmLyCZl/+4925zY2Be73Ou5TDBDNH4wAE2Q+98a80uzQLu1lEWJ1j2gNeXTZMS2lc0l
         /qU3FIgGHvJMdRri7qmS1QsswIs5oCGxqlfc8O5ctzvlGIhdTTI2PzZmHN8EgWMpODLh
         FIM7/EgmaqBddsGy/L4V6iRfSkQd00EA/cyaC8r22gmYkBQOyKb4aDo7Z2/+SQHu/XiM
         Z5RjCXPD7UkW0Iz8xchkJf/E9+tKiwfOHW5oXokBBoCFDvQBBrZzkVB+qJjsIqHUMzE4
         wbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666938; x=1755271738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaaNxrFIYW8u5Zqt1umxh8jF3epFz2+2Ag+pI49sCxs=;
        b=PiYGQhkPT5aBkBTN9gaxTs7p4ziuMiHEThEv3ZAqS4AOcCk54xFudFNnKSU7UFbNNo
         r1Ue3EHJHg2ED50FvosHtBO0XMguHEZIm2Sh6AHr3PYhvxgqrdQmQ9Jj0hvDTgBOnsMP
         pUA+1FC4417KWR4xphMegpQuI4i5mVko1j80MyXB05x18BylHeeJ355CPgr+Lvc/z59l
         7DkzCjj+EAh6vKZI030lIO20ir2gPDzCOQUZECZDYe/+SVyCxjK5eddBqQxAfrVT8SH8
         Hb23lFqm7TYGLNvImIAEMz+OEF8Wws0ZBH1o4egG9ljfy4muWhzUKlvkyxWqIw9KMYoM
         sQuA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqjMbtJqDCapdPNdlS9z/mg8KLECasqplTORWb/gtJnF3ySOeh5f2tBZ7+RrbK+aiy6RiMYjf3G61YLLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CjrMFiaQpGrwV0rjS2OB9jzDaVmyMz6GZvDSqN6a3nMd9cir
	EBUJzmPWJpXHfX03112WZgXbfXf/Wp4oyvBdV3wK1swk5ddJGbNXjaKoNfUari8ZDpqIiRcD7IF
	wYG86qw==
X-Google-Smtp-Source: AGHT+IHE0hHtw1Xg0PUR8LXW1OvNYnxaIuDbWWkKp1lBoeFA09FI3YbrJczkDR7Cbe5a+Wuqw/7opjyJj9c=
X-Received: from pjqs17.prod.google.com ([2002:a17:90a:ad91:b0:31e:eff2:4575])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64a:b0:240:3f39:2c73
 with SMTP id d9443c01a7336-242c19ac4f0mr49253725ad.0.1754666937755; Fri, 08
 Aug 2025 08:28:57 -0700 (PDT)
Date: Fri,  8 Aug 2025 08:28:48 -0700
In-Reply-To: <20250808152850.2580887-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808152850.2580887-3-surenb@google.com>
Subject: [PATCH v4 2/3] fs/proc/task_mmu: factor out proc_maps_private fields
 used by PROCMAP_QUERY
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
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
ioctl are moved into a separate structure. In the next patch this allows
ioctl to reuse some of the functions used for reading /proc/pid/maps
without using file->private_data. This prevents concurrent modification
of file->private_data members by ioctl and /proc/pid/maps readers.

The change is pure code refactoring and has no functional changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: SeongJae Park <sj@kernel.org>
---
 fs/proc/internal.h   | 15 +++++---
 fs/proc/task_mmu.c   | 87 +++++++++++++++++++++++---------------------
 fs/proc/task_nommu.c | 14 +++----
 3 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index e737401d7383..d1598576506c 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -378,16 +378,21 @@ extern void proc_self_init(void);
  * task_[no]mmu.c
  */
 struct mem_size_stats;
-struct proc_maps_private {
-	struct inode *inode;
-	struct task_struct *task;
+
+struct proc_maps_locking_ctx {
 	struct mm_struct *mm;
-	struct vma_iterator iter;
-	loff_t last_pos;
 #ifdef CONFIG_PER_VMA_LOCK
 	bool mmap_locked;
 	struct vm_area_struct *locked_vma;
 #endif
+};
+
+struct proc_maps_private {
+	struct inode *inode;
+	struct task_struct *task;
+	struct vma_iterator iter;
+	loff_t last_pos;
+	struct proc_maps_locking_ctx lock_ctx;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 29cca0e6d0ff..c0968d293b61 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -132,18 +132,18 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
-static void unlock_vma(struct proc_maps_private *priv)
+static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
 {
-	if (priv->locked_vma) {
-		vma_end_read(priv->locked_vma);
-		priv->locked_vma = NULL;
+	if (lock_ctx->locked_vma) {
+		vma_end_read(lock_ctx->locked_vma);
+		lock_ctx->locked_vma = NULL;
 	}
 }
 
 static const struct seq_operations proc_pid_maps_op;
 
 static inline bool lock_vma_range(struct seq_file *m,
-				  struct proc_maps_private *priv)
+				  struct proc_maps_locking_ctx *lock_ctx)
 {
 	/*
 	 * smaps and numa_maps perform page table walk, therefore require
@@ -151,25 +151,25 @@ static inline bool lock_vma_range(struct seq_file *m,
 	 * walking the vma tree under rcu read protection.
 	 */
 	if (m->op != &proc_pid_maps_op) {
-		if (mmap_read_lock_killable(priv->mm))
+		if (mmap_read_lock_killable(lock_ctx->mm))
 			return false;
 
-		priv->mmap_locked = true;
+		lock_ctx->mmap_locked = true;
 	} else {
 		rcu_read_lock();
-		priv->locked_vma = NULL;
-		priv->mmap_locked = false;
+		lock_ctx->locked_vma = NULL;
+		lock_ctx->mmap_locked = false;
 	}
 
 	return true;
 }
 
-static inline void unlock_vma_range(struct proc_maps_private *priv)
+static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
 {
-	if (priv->mmap_locked) {
-		mmap_read_unlock(priv->mm);
+	if (lock_ctx->mmap_locked) {
+		mmap_read_unlock(lock_ctx->mm);
 	} else {
-		unlock_vma(priv);
+		unlock_ctx_vma(lock_ctx);
 		rcu_read_unlock();
 	}
 }
@@ -177,15 +177,16 @@ static inline void unlock_vma_range(struct proc_maps_private *priv)
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 					   loff_t last_pos)
 {
+	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
 	struct vm_area_struct *vma;
 
-	if (priv->mmap_locked)
+	if (lock_ctx->mmap_locked)
 		return vma_next(&priv->iter);
 
-	unlock_vma(priv);
-	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
+	unlock_ctx_vma(lock_ctx);
+	vma = lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
 	if (!IS_ERR_OR_NULL(vma))
-		priv->locked_vma = vma;
+		lock_ctx->locked_vma = vma;
 
 	return vma;
 }
@@ -193,14 +194,16 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 					 loff_t pos)
 {
-	if (priv->mmap_locked)
+	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
+
+	if (lock_ctx->mmap_locked)
 		return false;
 
 	rcu_read_unlock();
-	mmap_read_lock(priv->mm);
+	mmap_read_lock(lock_ctx->mm);
 	/* Reinitialize the iterator after taking mmap_lock */
 	vma_iter_set(&priv->iter, pos);
-	priv->mmap_locked = true;
+	lock_ctx->mmap_locked = true;
 
 	return true;
 }
@@ -208,14 +211,14 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline bool lock_vma_range(struct seq_file *m,
-				  struct proc_maps_private *priv)
+				  struct proc_maps_locking_ctx *lock_ctx)
 {
-	return mmap_read_lock_killable(priv->mm) == 0;
+	return mmap_read_lock_killable(lock_ctx->mm) == 0;
 }
 
-static inline void unlock_vma_range(struct proc_maps_private *priv)
+static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
 {
-	mmap_read_unlock(priv->mm);
+	mmap_read_unlock(lock_ctx->mm);
 }
 
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
@@ -258,7 +261,7 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		*ppos = vma->vm_end;
 	} else {
 		*ppos = SENTINEL_VMA_GATE;
-		vma = get_gate_vma(priv->mm);
+		vma = get_gate_vma(priv->lock_ctx.mm);
 	}
 
 	return vma;
@@ -267,6 +270,7 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
+	struct proc_maps_locking_ctx *lock_ctx;
 	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
@@ -278,14 +282,15 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!priv->task)
 		return ERR_PTR(-ESRCH);
 
-	mm = priv->mm;
+	lock_ctx = &priv->lock_ctx;
+	mm = lock_ctx->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		put_task_struct(priv->task);
 		priv->task = NULL;
 		return NULL;
 	}
 
-	if (!lock_vma_range(m, priv)) {
+	if (!lock_vma_range(m, lock_ctx)) {
 		mmput(mm);
 		put_task_struct(priv->task);
 		priv->task = NULL;
@@ -318,13 +323,13 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 
 	if (!priv->task)
 		return;
 
 	release_task_mempolicy(priv);
-	unlock_vma_range(priv);
+	unlock_vma_range(&priv->lock_ctx);
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -339,9 +344,9 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR(priv->lock_ctx.mm)) {
+		int err = PTR_ERR(priv->lock_ctx.mm);
 
 		seq_release_private(inode, file);
 		return err;
@@ -355,8 +360,8 @@ static int proc_map_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	return seq_release_private(inode, file);
 }
@@ -610,7 +615,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!!karg.build_id_size != !!karg.build_id_addr)
 		return -EINVAL;
 
-	mm = priv->mm;
+	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
@@ -1311,7 +1316,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
 	struct mem_size_stats mss = {};
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 	struct vm_area_struct *vma;
 	unsigned long vma_start = 0, last_vma_end = 0;
 	int ret = 0;
@@ -1456,9 +1461,9 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
+		ret = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -1476,8 +1481,8 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	kfree(priv);
 	return single_release(inode, file);
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 59bfd61d653a..d362919f4f68 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -204,7 +204,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!priv->task)
 		return ERR_PTR(-ESRCH);
 
-	mm = priv->mm;
+	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		put_task_struct(priv->task);
 		priv->task = NULL;
@@ -226,7 +226,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->lock_ctx.mm;
 
 	if (!priv->task)
 		return;
@@ -259,9 +259,9 @@ static int maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->lock_ctx.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->lock_ctx.mm)) {
+		int err = priv->lock_ctx.mm ? PTR_ERR(priv->lock_ctx.mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -276,8 +276,8 @@ static int map_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->lock_ctx.mm)
+		mmdrop(priv->lock_ctx.mm);
 
 	return seq_release_private(inode, file);
 }
-- 
2.50.1.703.g449372360f-goog


