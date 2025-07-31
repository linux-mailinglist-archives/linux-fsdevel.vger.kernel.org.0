Return-Path: <linux-fsdevel+bounces-56452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A96B178C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552CF563BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B5273D6C;
	Thu, 31 Jul 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xo7OSuw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86003270542
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999234; cv=none; b=PdISgFbIuTfEyTio4bWvUXMekFgt/6dZbIYzQSf9MgBUhxfnxeLFmjd22CtNUoVZB8JO3ZOTt8bjFsfKehao8ELC6I2YlJK9p7ckAokDCsjIOUGK1sMPhAfNHMSqCyl2KRahB9XeCfMpjvPttHAfXaSiZkawLYJW5h2n0YD4pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999234; c=relaxed/simple;
	bh=yhEtd1ka8mErusKeRqx/I8nXNg9UEifaYYnXhvMlSKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+uX/R5m5Hl6pvUiCzEJTQ2Kylkh2ZYnolhr/nGupY4p8UfQqwj1DbNs/ytIG6//OUazS+fHtt/M3aIx4ZAwMv3J4nHLEqytfMpLPG9mviH1cHxmRAhS8qUSAbDf0jrDeA1HHR6Vt32IxbJXKN8hKeU+rpKtZCXC+GoWujqIZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xo7OSuw+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2420cfdafcaso2378915ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999232; x=1754604032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nszwvCvPWAmHYDsSOEe6+RDYFjtctgvzjemTCKIEM=;
        b=xo7OSuw+0JbLwCAXadDhWLSr1R6eVL/CuqCdT5bgUUKxS90sKUqc7nJ2wGjdG4dNeW
         Vj4J15Q98xxdZieZGPLd29bFWtIBxtPA1ZZ4UgtsJ4VYY9ZZIs/sZWm5A2els0DQ6OHy
         tgqkY32pQxo6sgZau7OVT87Ka5+fE4PbUYG0XX8Yxgh7B5roqmWCAp+SR7dhi40sxGd0
         OcJ++o7Eo515vM+hk3Mke7DICCKCPo9WuhueRjBPuEkalNItSBX9ceU+ASDAf7e9LPlS
         zlDe9XH8/LpsowmnHA1H2i9SrOV015SfLoljkPJ8mp7uUPQcr5FYGNZs8qVbbR+d9zt1
         53Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999232; x=1754604032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nszwvCvPWAmHYDsSOEe6+RDYFjtctgvzjemTCKIEM=;
        b=Un0ixQqJ21A41XfAtURJ0zk2EeHBwhjERCX6MSSnHIZIc5/+o8VIpYfPY1otKHXUGu
         rTtAchpErgxJHBwb3HqWVnI5mXOIO7AJ+0NSXYw4b4H73SJnun2zZedHUwyafxhooRE5
         lpP04nym8GsZ5EDZQ0r4HqXkgXGWqE0OXcEbuEcToc7nd9G0mFekF8w8g+c0bypYDGEV
         w0/h6PU4eOh/5MrUB5lQwmD7F+GGOGlChQRBhEYA2VDnG98AupUxtXJ9vmswR3aQY1VY
         tKG2RmUi7yENR0jUwkOUSgeoGpXs/Ja5YLMSWB4X/WRzC1/grHN5ln4CPcfjZj8sdLhb
         vX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU36SVZsii6RdaDYLRyIHJwyQ29gzJ7gi8I9D+ACglBhgvJTiO+8HRwUe/y7CiuFEFwUh9Jn4pewTWq8SRp@vger.kernel.org
X-Gm-Message-State: AOJu0YyXI2M+sgP6VGHCtZbEImIqvgfdrdysTC4MkVmKK/p6vMlpNysA
	uB9eUgOIUrcXMtU18TXRA5JvJ0xSpsKOXDIRRjdzbnU0M/o0Zuy3jOAXSFNJ6hqb/AsUaYPZIU+
	WO0tqAA==
X-Google-Smtp-Source: AGHT+IEe6D0EDOa4VLSLQnNt443QGZdBsTsucswGzk0sXMtaRnOh2OfcwLIsh8g7TBhjLjlnLUKia1iuw4c=
X-Received: from plbka16.prod.google.com ([2002:a17:903:3350:b0:240:9ca:fc49])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc50:b0:234:ef42:5d65
 with SMTP id d9443c01a7336-24096c0dcf7mr124221755ad.52.1753999231880; Thu, 31
 Jul 2025 15:00:31 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:00:23 -0700
In-Reply-To: <20250731220024.702621-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731220024.702621-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731220024.702621-3-surenb@google.com>
Subject: [PATCH 2/3] fs/proc/task_mmu: factor out proc_maps_private fields
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
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
ioctl are moved into a separate structure. In the next patch this allows
ioctl to reuse some of the functions used for reading /proc/pid/maps
without using file->private_data. This prevents concurrent modification
of file->private_data members by ioctl and /proc/pid/maps readers.

The change is pure code refactoring and has no functional changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h | 15 ++++++----
 fs/proc/task_mmu.c | 70 +++++++++++++++++++++++-----------------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 7c235451c5ea..e2447b22592e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -379,16 +379,21 @@ extern void proc_self_init(void);
  * task_[no]mmu.c
  */
 struct mem_size_stats;
-struct proc_maps_private {
-	struct inode *inode;
-	struct task_struct *task;
+
+struct proc_maps_query_data {
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
+	struct proc_maps_query_data query;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..509fa162760a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -132,11 +132,11 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
-static void unlock_vma(struct proc_maps_private *priv)
+static void unlock_vma(struct proc_maps_query_data *query)
 {
-	if (priv->locked_vma) {
-		vma_end_read(priv->locked_vma);
-		priv->locked_vma = NULL;
+	if (query->locked_vma) {
+		vma_end_read(query->locked_vma);
+		query->locked_vma = NULL;
 	}
 }
 
@@ -151,14 +151,14 @@ static inline bool lock_vma_range(struct seq_file *m,
 	 * walking the vma tree under rcu read protection.
 	 */
 	if (m->op != &proc_pid_maps_op) {
-		if (mmap_read_lock_killable(priv->mm))
+		if (mmap_read_lock_killable(priv->query.mm))
 			return false;
 
-		priv->mmap_locked = true;
+		priv->query.mmap_locked = true;
 	} else {
 		rcu_read_lock();
-		priv->locked_vma = NULL;
-		priv->mmap_locked = false;
+		priv->query.locked_vma = NULL;
+		priv->query.mmap_locked = false;
 	}
 
 	return true;
@@ -166,10 +166,10 @@ static inline bool lock_vma_range(struct seq_file *m,
 
 static inline void unlock_vma_range(struct proc_maps_private *priv)
 {
-	if (priv->mmap_locked) {
-		mmap_read_unlock(priv->mm);
+	if (priv->query.mmap_locked) {
+		mmap_read_unlock(priv->query.mm);
 	} else {
-		unlock_vma(priv);
+		unlock_vma(&priv->query);
 		rcu_read_unlock();
 	}
 }
@@ -179,13 +179,13 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 {
 	struct vm_area_struct *vma;
 
-	if (priv->mmap_locked)
+	if (priv->query.mmap_locked)
 		return vma_next(&priv->iter);
 
-	unlock_vma(priv);
-	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
+	unlock_vma(&priv->query);
+	vma = lock_next_vma(priv->query.mm, &priv->iter, last_pos);
 	if (!IS_ERR_OR_NULL(vma))
-		priv->locked_vma = vma;
+		priv->query.locked_vma = vma;
 
 	return vma;
 }
@@ -193,14 +193,14 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 					 loff_t pos)
 {
-	if (priv->mmap_locked)
+	if (priv->query.mmap_locked)
 		return false;
 
 	rcu_read_unlock();
-	mmap_read_lock(priv->mm);
+	mmap_read_lock(priv->query.mm);
 	/* Reinitialize the iterator after taking mmap_lock */
 	vma_iter_set(&priv->iter, pos);
-	priv->mmap_locked = true;
+	priv->query.mmap_locked = true;
 
 	return true;
 }
@@ -210,12 +210,12 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 static inline bool lock_vma_range(struct seq_file *m,
 				  struct proc_maps_private *priv)
 {
-	return mmap_read_lock_killable(priv->mm) == 0;
+	return mmap_read_lock_killable(priv->query.mm) == 0;
 }
 
 static inline void unlock_vma_range(struct proc_maps_private *priv)
 {
-	mmap_read_unlock(priv->mm);
+	mmap_read_unlock(priv->query.mm);
 }
 
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
@@ -258,7 +258,7 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		*ppos = vma->vm_end;
 	} else {
 		*ppos = SENTINEL_VMA_GATE;
-		vma = get_gate_vma(priv->mm);
+		vma = get_gate_vma(priv->query.mm);
 	}
 
 	return vma;
@@ -278,7 +278,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!priv->task)
 		return ERR_PTR(-ESRCH);
 
-	mm = priv->mm;
+	mm = priv->query.mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		put_task_struct(priv->task);
 		priv->task = NULL;
@@ -318,7 +318,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->query.mm;
 
 	if (!priv->task)
 		return;
@@ -339,9 +339,9 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->query.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->query.mm)) {
+		int err = priv->query.mm ? PTR_ERR(priv->query.mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -355,8 +355,8 @@ static int proc_map_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->query.mm)
+		mmdrop(priv->query.mm);
 
 	return seq_release_private(inode, file);
 }
@@ -610,7 +610,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!!karg.build_id_size != !!karg.build_id_addr)
 		return -EINVAL;
 
-	mm = priv->mm;
+	mm = priv->query.mm;
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
@@ -1307,7 +1307,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
 	struct mem_size_stats mss = {};
-	struct mm_struct *mm = priv->mm;
+	struct mm_struct *mm = priv->query.mm;
 	struct vm_area_struct *vma;
 	unsigned long vma_start = 0, last_vma_end = 0;
 	int ret = 0;
@@ -1452,9 +1452,9 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->query.mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR_OR_NULL(priv->query.mm)) {
+		ret = priv->query.mm ? PTR_ERR(priv->query.mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -1472,8 +1472,8 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct proc_maps_private *priv = seq->private;
 
-	if (priv->mm)
-		mmdrop(priv->mm);
+	if (priv->query.mm)
+		mmdrop(priv->query.mm);
 
 	kfree(priv);
 	return single_release(inode, file);
-- 
2.50.1.565.gc32cd1483b-goog


