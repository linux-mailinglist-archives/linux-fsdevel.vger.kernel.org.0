Return-Path: <linux-fsdevel+bounces-56849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DCB1C97C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8276175BE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A028FFCD;
	Wed,  6 Aug 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Budp1pRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8EC29A9E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495957; cv=none; b=JzgFCL3Lite1OuxtH2OPnnNsIaY156AiiBPeo4J47piC5k5+/vJiWGrqRlapyQEthWVKINAVu9KXycGl3E0RJXLtXna9Uv5jbIiRGa39z/3rllSszMFka5pG34bNQMcm4d2sFps7rVfQ5ZYkgm/lQcNQXPq30SvlCYkxN/O/iBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495957; c=relaxed/simple;
	bh=JRfgX1mdsRBhfL5iUYnonjqsaZrBRF+pfu+2IoIqfMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9f492Pb+x8JZldO+behoOKXCLGsPiSmn8JSOUzHTmpBPoWpaZUama2FTLYS8nCBuJT7DK39HvrxI3yZuzjiRfHPI5occVUk0Z3kdTn7bcI4zjuZiWNf8AO2XEPLx4VVqwvpsVVZT/CGhpRx3jwWl+GDaOL+p0HlOFm29kWCc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Budp1pRU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24011ceafc8so60487045ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754495954; x=1755100754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=79cST+DpT8JLjhSc853c7Vp44fp4YLe4km92lxkzOhQ=;
        b=Budp1pRUx6mYa0epyo7zbp+kkDKr3RN/i8el8R7Gka6OmrHe2dFDFDdc+iDTLUKKiC
         iq40KT4Z5+N9+8HmW49DP/HxNSsTFIzoP30ciMT9uw8AeFodCJqI6ZEdtg9hnks+JGHl
         xZoBMksg8rh0B18GhOcwGnnPUsoKD54LGiyKNA3erREfPj6wpwDRuMrPdDoFPXgCrh0q
         Lo0mJa3l3ezZkJrQ9XJPpiSLn0TwfCXe/2ffk5VJZXxr8LYJF29c9J5g6v9woFjbRH+8
         Ryz0j8obquz+9LqjwKt+gymvn94TrB4q8xSYgGRCXLW7KO3UMTw2Aas+6mWmJKGs5X1s
         9U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495954; x=1755100754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79cST+DpT8JLjhSc853c7Vp44fp4YLe4km92lxkzOhQ=;
        b=ZN5F7JRMTRgsiiA0/l34WEPPvyKxwiTXfI0IB/cYLOCvjfeoDwlFlBlmR7N/OLNoXZ
         7qZeQqlhb9XWsIXQqE6Um2j9p9B6MzDFd8FBuUyUw/Q1g6XAtJ/M9SxS83fPXT1Xbf1Y
         eBHQN+EtE+YKeOJQUZc/+ZQXpoBYwDdBNXnonSFsDdQXiX6ZjQ7V0uQyqQcFW/WZffCX
         sQPSR9AQzPw7s+t6OTq1+aFC8002hsceC3EM3ffI+CjfGBiFZTGOJSSTLXjFdb6rCAOs
         AqLMIFjOSN4+DCnTLDk13QX5cpw+HHdrci6/3XdpwBxsUmoByPju3wjYOq28R2J6GryS
         tp6w==
X-Forwarded-Encrypted: i=1; AJvYcCXizKTz2LTq1ZbsN2AiT19xMMPEzEBelSsQW512pQzNF0ZEhFEoGvbIpZj0w1GGVjW84fFcVwnCiN9Ycb71@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdXuzQ35WIDwoUCbUwkbZaETXWq91ndV/r0AjEwEYIHgOLYFX
	HSkB3FVD/xRJB0yQa+M4JtQlTr+p82L6AvT5Q1/8/jnqCnWDnJoXrhdb82smR690n8kpkU14iua
	kkV57bA==
X-Google-Smtp-Source: AGHT+IFlS+JvIsWnRvs7bTfyfgC/5w+RmEgonVOp9GJDKi3AshY2Fhxqa2lT8Ee9l8rZG2GebQuiHk0ZMyQ=
X-Received: from pjboe1.prod.google.com ([2002:a17:90b:3941:b0:31e:c61e:663b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacc:b0:240:92cc:8fcf
 with SMTP id d9443c01a7336-2429f496c6bmr47463745ad.49.1754495954146; Wed, 06
 Aug 2025 08:59:14 -0700 (PDT)
Date: Wed,  6 Aug 2025 08:59:04 -0700
In-Reply-To: <20250806155905.824388-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806155905.824388-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806155905.824388-4-surenb@google.com>
Subject: [PATCH v3 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
 per-vma locks
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

Utilize per-vma locks to stabilize vma after lookup without taking
mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
contended, we fall back to mmap_lock but take it only momentarily
to lock the vma and release the mmap_lock. In a very unlikely case
of vm_refcnt overflow, this fall back path will fail and ioctl is
done under mmap_lock protection.

This change is designed to reduce mmap_lock contention and prevent
PROCMAP_QUERY ioctl calls from blocking address space updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 84 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 45134335e086..0396315dfaee 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -517,28 +517,81 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
 {
-	return mmap_read_lock_killable(mm);
+	lock_ctx->locked_vma = NULL;
+	lock_ctx->mmap_locked = false;
+
+	return 0;
 }
 
-static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
 {
-	mmap_read_unlock(mm);
+	if (lock_ctx->mmap_locked)
+		mmap_read_unlock(lock_ctx->mm);
+	else
+		unlock_vma(lock_ctx);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
+						     unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	if (lock_ctx->mmap_locked)
+		return find_vma(lock_ctx->mm, addr);
+
+	unlock_vma(lock_ctx);
+	rcu_read_lock();
+	vma_iter_init(&vmi, lock_ctx->mm, addr);
+	vma = lock_next_vma(lock_ctx->mm, &vmi, addr);
+	rcu_read_unlock();
+
+	if (!IS_ERR_OR_NULL(vma)) {
+		lock_ctx->locked_vma = vma;
+	} else if (PTR_ERR(vma) == -EAGAIN) {
+		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
+		mmap_read_lock(lock_ctx->mm);
+		vma = find_vma(lock_ctx->mm, addr);
+		lock_ctx->mmap_locked = true;
+	}
+
+	return vma;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
+{
+	return mmap_read_lock_killable(lock_ctx->mm);
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
 {
-	return find_vma(mm, addr);
+	mmap_read_unlock(lock_ctx->mm);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
+						     unsigned long addr)
+{
+	return find_vma(lock_ctx->mm, addr);
+}
+
+#endif  /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *lock_ctx,
 						 unsigned long addr, u32 flags)
 {
 	struct vm_area_struct *vma;
 
 next_vma:
-	vma = query_vma_find_by_addr(mm, addr);
+	vma = query_vma_find_by_addr(lock_ctx, addr);
+	if (IS_ERR(vma))
+		return vma;
+
 	if (!vma)
 		goto no_vma;
 
@@ -579,11 +632,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 	return ERR_PTR(-ENOENT);
 }
 
-static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
+static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 {
+	struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
 	struct procmap_query karg;
 	struct vm_area_struct *vma;
-	struct mm_struct *mm;
 	const char *name = NULL;
 	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
@@ -610,17 +663,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!!karg.build_id_size != !!karg.build_id_addr)
 		return -EINVAL;
 
-	mm = priv->lock_ctx.mm;
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	err = query_vma_setup(mm);
+	err = query_vma_setup(&lock_ctx);
 	if (err) {
 		mmput(mm);
 		return err;
 	}
 
-	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
+	vma = query_matching_vma(&lock_ctx, karg.query_addr, karg.query_flags);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
 		vma = NULL;
@@ -705,7 +757,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -725,7 +777,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
@@ -738,7 +790,7 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
 
 	switch (cmd) {
 	case PROCMAP_QUERY:
-		return do_procmap_query(priv, (void __user *)arg);
+		return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.50.1.565.gc32cd1483b-goog


