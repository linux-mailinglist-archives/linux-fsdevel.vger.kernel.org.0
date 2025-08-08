Return-Path: <linux-fsdevel+bounces-57107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC09B1EBF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F000BAA165E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B8285068;
	Fri,  8 Aug 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nek0R3GR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19328469A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666942; cv=none; b=GhVOGwECUucmMy8mn4v6/YJ008UXYUEdbwAblU0hKFTG+tHAGX8WqCSdWIG5+sdcfyyfZEoAo9UB9KSNKvFKva1Nl30cf6nClSRmva5th0tbwVYJoeEBhDmrkpRpRiHmRW/ehVSbgaccs2leUYjjM5bn5CZS8g6IzaWhitUUubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666942; c=relaxed/simple;
	bh=d6ZyZjRCfzLf7EHML4v3fFLKZt6TIu0nk5DduaNsAP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mukSyvml5+2bG0t87M2sNgQdkfIGQfCth/l2TUuR9YEybUXXl1QoYSaDa71v9uT+2IrSkTyb5yrHhIVZXaTf79BZiuI2tgaNvxc6oa7hYMpI5nuKMatMeVDYNAk5zdgdROxXzn8amc23y3YYU+FCflJY6U66jVCKizUbdVQ2KMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nek0R3GR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eac278794so2272874a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754666940; x=1755271740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qaVRp5+Q87psp1cSnwtcdG7GaGDDk1FPXSJsj5vDHc=;
        b=nek0R3GRGl+XTG3LISeIeaSdEiuQzdP73a1OZPhGjJP3QWGubiIOAzxCWJ7o2QUSsI
         v2zkPYqMONnD6mhu8v/VG9/e2C+Jj2edtRxfYSAWhdTwIfpDbbRImZC5W5r6jFT5C1PN
         666Hx8aA61APQXhpdc4eQoV21S63bSUSeUGEpl8HCwoBr0IgzWwq5HZjOEN4PwpWEXHO
         JBCTuQh1SATJid9ZKgyu3Pkct08giNSKbe2ov1g1XE7lg6D5Y4zsM3BlMCvmQxO9Xpak
         OqsevdcRUxpcNFupW9UFEuinOImufn7TCHJruOe2GlCcHEGWHNWmvUFlEaessqD9xD7/
         DVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666940; x=1755271740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qaVRp5+Q87psp1cSnwtcdG7GaGDDk1FPXSJsj5vDHc=;
        b=rPFWmJkZ00kQon/GK+rplw9A8Id168tLPhKX6VJbQrGKcZrjN2oJE0+qrcr3T4Un+Q
         LYR7anhN/eLsnPCCwkIgonfLVRd2CgJ7Yofcdpnz4NVHv8WSXhvHgtubQ9rQDluryLjE
         mOm9T1UFkSS4TWfD1PAeNRd3K5UanBtbr1n4kKA9fTRYcodkR3Zu1K6QqbMdOgpWXzSB
         g8Zt0i1IJXWDHbLPpAisdS+ni88GnTa41fsr+32RG/XJHYB6QDiuQ5XG3SjueoSlBN3E
         tRCETjme/MoVy7OQkHYCubR13EkH5XYeCOB6H6VeDUr5wf/I9w7r3sK3sCzzG926OGa+
         kWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp4LR9pSrVR92KL7v/3E43Se2i+FKZzwT9WWwHI8yrpR3SMUqcwhJUJfxJEJ7QH0mHdelFGhnwZTvmpu/y@vger.kernel.org
X-Gm-Message-State: AOJu0YxXursIOUiB2qEL+V1V9C+LjfXCAV2bnF0pvdMr4pgyOeNjOzLR
	n2Y4G+Z3Z5SOWpMHaztC/ZjkQPdZbQKF5z0R0NMWorsZN8LGI9egiu5lOApqFh5dQH54/54upCA
	HPhsASQ==
X-Google-Smtp-Source: AGHT+IGfHbSuaYkDvkzFDZll/OyuLjbjmWu+3tdj38KsO6i2Mr+NdU7aQQPpEiVzAfcHA2GS7b/edCdIm5g=
X-Received: from pjboe9.prod.google.com ([2002:a17:90b:3949:b0:321:9285:be8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e4b:b0:316:3972:b9d0
 with SMTP id 98e67ed59e1d1-321838a7672mr5733158a91.0.1754666939750; Fri, 08
 Aug 2025 08:28:59 -0700 (PDT)
Date: Fri,  8 Aug 2025 08:28:49 -0700
In-Reply-To: <20250808152850.2580887-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808152850.2580887-4-surenb@google.com>
Subject: [PATCH v4 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
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
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com, 
	SeongJae Park <sj@kernel.org>
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
Acked-by: SeongJae Park <sj@kernel.org>
---
 fs/proc/task_mmu.c | 103 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c0968d293b61..e64cf40ce9c4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -132,6 +132,12 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
+static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
+{
+	lock_ctx->locked_vma = NULL;
+	lock_ctx->mmap_locked = false;
+}
+
 static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
 {
 	if (lock_ctx->locked_vma) {
@@ -157,8 +163,7 @@ static inline bool lock_vma_range(struct seq_file *m,
 		lock_ctx->mmap_locked = true;
 	} else {
 		rcu_read_lock();
-		lock_ctx->locked_vma = NULL;
-		lock_ctx->mmap_locked = false;
+		reset_lock_ctx(lock_ctx);
 	}
 
 	return true;
@@ -522,28 +527,90 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
 {
-	return mmap_read_lock_killable(mm);
+	reset_lock_ctx(lock_ctx);
+
+	return 0;
 }
 
-static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
 {
-	mmap_read_unlock(mm);
+	if (lock_ctx->mmap_locked) {
+		mmap_read_unlock(lock_ctx->mm);
+		lock_ctx->mmap_locked = false;
+	} else {
+		unlock_ctx_vma(lock_ctx);
+	}
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
+						     unsigned long addr)
+{
+	struct mm_struct *mm = lock_ctx->mm;
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	if (lock_ctx->mmap_locked)
+		return find_vma(mm, addr);
+
+	/* Unlock previously locked VMA and find the next one under RCU */
+	unlock_ctx_vma(lock_ctx);
+	rcu_read_lock();
+	vma_iter_init(&vmi, mm, addr);
+	vma = lock_next_vma(mm, &vmi, addr);
+	rcu_read_unlock();
+
+	if (!vma)
+		return NULL;
+
+	if (!IS_ERR(vma)) {
+		lock_ctx->locked_vma = vma;
+		return vma;
+	}
+
+	if (PTR_ERR(vma) == -EAGAIN) {
+		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
+		mmap_read_lock(mm);
+		vma = find_vma(mm, addr);
+		lock_ctx->mmap_locked = true;
+	}
+
+	return vma;
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
+{
+	return mmap_read_lock_killable(lock_ctx->mm);
+}
+
+static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
+{
+	mmap_read_unlock(lock_ctx->mm);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
+						     unsigned long addr)
 {
-	return find_vma(mm, addr);
+	return find_vma(lock_ctx->mm, addr);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
 
@@ -584,11 +651,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
@@ -615,17 +682,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
@@ -710,7 +776,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -730,7 +796,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
@@ -743,7 +809,8 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
 
 	switch (cmd) {
 	case PROCMAP_QUERY:
-		return do_procmap_query(priv, (void __user *)arg);
+		/* priv->lock_ctx.mm is set during file open operation */
+		return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.50.1.703.g449372360f-goog


