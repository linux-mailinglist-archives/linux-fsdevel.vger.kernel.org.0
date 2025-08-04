Return-Path: <linux-fsdevel+bounces-56701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9FB1AB58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D383B6F00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693A292B44;
	Mon,  4 Aug 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5VDgKCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C291C33
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349364; cv=none; b=HXIHYoURNBSkU/812C56LpEH6hivcK+KCCzo4FTM7nQbaxkh8Y4zXxH6m2TqNoyIhR3k/GIhvrEr905nws8b6MqoV/55zti5W41tdZDV0UAkzvPC9IiBpN25YwY2cL7msB0IEMCTGXg4MpUeYHxBKfPFmM1YZNqMrg/8fAFGpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349364; c=relaxed/simple;
	bh=BdiowjuFZsdquH1v1qJ0l1K5TohHeQmAGtriPnbOYKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFU+bzWyXe0BEdvL+75xPKT/yc++nqCNLwIFXNiYfLzC5T2wdSuNn4bwyz7hfM2Kf6gB23O0hZT+opvfqZ8Rr9VU2Lstax2d+3b8cLGSJbLFHal8UFjYeFqxp6Yx8gDk/T5syBdbClWxdWs9KO/MphlACCXYshtBLFqR/u8vL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5VDgKCu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b421b03d498so2587178a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349362; x=1754954162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn/QlXxKr04lsk0BQprsWZ8fvAafoan6Kc4Ifd428WQ=;
        b=E5VDgKCuzMlzcOS0yRUa7w4xr22v9RyPFr+ZvBv0mDMtfP959jmEUe7cZNC54RaYsZ
         DkEByUH8FOmw4BShu7TtMaWFxy6vpDeuSxPw4BWw5D9NTLFMCxNCgyBEvLyPwpBtvxm6
         7mkUqE9dXu0D7rUibyPddAhMu/1VNJloSmhzU2d9PvhQ/30wYFd/cZ6mRf+5bkDq+e54
         m6dQXBC4eDCb0SIWZ3byJGB5DfnLg62SCHIxfVVa35SaoiLjcLiSF7750y4IlrxT0Rq9
         dM3FpbtXQDeZPT2R7EyyQ7TkxlErxXODBQ5eZPgJWPsDS19/N8w2AoSfRcZAn2P+5SpL
         +H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349362; x=1754954162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn/QlXxKr04lsk0BQprsWZ8fvAafoan6Kc4Ifd428WQ=;
        b=f5GnFEjgHmTvmYi1TUE6dbp2IwnBMXwbtyflAD6/RomkuaJe1d6ztui8/QC84RIIVK
         u6znr/YzHWBFqDXPkDGyYw2wcE6xY76pYIPW5hR0z32lm4a0syURtPqittuGHopKpm9o
         6dOOwdLHMN1Txaug6o3hfFrE97U/cc8gOtKam2j2vg2cwHLivzjz9XvypGtilMMlbkQF
         8khNO8UElYzxE5KM95qgh45DZNV7OygxXojScckphkbvVGB627Hx3NpIGH/rNQ99F2PV
         xiiDpISavtSqhbGyKP4M+MmHohjZ3uHHNYuAJY4fpXSOXqza/wwtNIOE7ZQCda0oGrK/
         HK/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbO4M7tfwCl5HLutluJ8NZdMsdZJo12aFuSjgO7NLjRdnzAN1xbW0wlAFAApoGfZK7QFlpdS8dSt3rYlSV@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDaMw7CK+Y4x1ggfwNFNYCjmfRwDZwTQjkkJU6tB4uxLnWdpr
	irMO8xr/rAD0scgjw7iph/0IjwZMeYFaayJG5CjakTSh3nNSsGJVKqYskKmysUomjd7PKeWi/7D
	aNspDWQ==
X-Google-Smtp-Source: AGHT+IHSKj2r68iHuJ6mz0Uqid6yqFPSiOF1csXgv0QqUAcL3Sg9DHhAyqp/y83a4PMGePmffR52Td+bl/E=
X-Received: from pgnh8.prod.google.com ([2002:a63:3848:0:b0:b42:14da:59ac])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244f:b0:240:d12:775c
 with SMTP id adf61e73a8af0-2400d12a143mr7876300637.36.1754349362131; Mon, 04
 Aug 2025 16:16:02 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:15:51 -0700
In-Reply-To: <20250804231552.1217132-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804231552.1217132-4-surenb@google.com>
Subject: [PATCH v2 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
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
 fs/proc/task_mmu.c | 81 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 843577aa7a32..1d06ecdbef6f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, struct file *file)
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
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
+						     unsigned long addr)
 {
-	return find_vma(mm, addr);
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
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
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
 
@@ -579,11 +629,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
@@ -610,17 +660,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
@@ -705,7 +754,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -725,7 +774,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
@@ -738,7 +787,7 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
 
 	switch (cmd) {
 	case PROCMAP_QUERY:
-		return do_procmap_query(priv, (void __user *)arg);
+		return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.50.1.565.gc32cd1483b-goog


