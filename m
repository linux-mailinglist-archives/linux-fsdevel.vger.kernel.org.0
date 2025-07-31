Return-Path: <linux-fsdevel+bounces-56453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7BB178C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43D65881BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC225273814;
	Thu, 31 Jul 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNlqP4JK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC72737FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999236; cv=none; b=WiWKZCvDnj5LGYXenPNszLzL8D9W74Vpc7CUgWmQM3qp0rWT32r+cT4O6ris8PMyO3IhPnyjlMi5FY8Z0Xeb24YCJyMaDx8ryyQZ95Zzvcs5diW4yUxXFuro20kT493jRcB95g5ioOFIu39DSiBL8CJRH7GA0Rga0V045DD3U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999236; c=relaxed/simple;
	bh=WiIYR43BkynWQ/NHpDxB552UWAXO4+NMreOccpkPwOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mjcbfvu8hdM1oKZFc1DeO/Nqd+vEx/UMnOFvY9AdmFVZIz6NfAQ0nIyes6teK5lfL+3Jz4UK+KpsTf7QKJfJHuTn91EVcJTJomY6gRizUZSgz6i3UiyGnM0emCzoSGE09xN4jaaHhmPO+x61jfA8adzxZHzRHmAplwYEzzBZgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNlqP4JK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235dd77d11fso9778375ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999234; x=1754604034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSpqmXgbYV8j5bsB4IVuVf0tack8DQaHL/QU05OaXgY=;
        b=qNlqP4JK1flJPLxN7zfmFhWvzp8AVpCq61xcPupiHZcXRheMfD6+FfX/VxhHjV4i4s
         WskETkR01ngEblt5Ox5cKCNlR9KQxZVdvGi+/LBGtn4ybiFWR5BrqT+oVt9rb4Q63pYz
         8u84hmO2OGp13c96NuQM2QIHJIQ5LmjR1GNNGSxIwBbXhiDteYyOs6Cy/SMz18YKGGy3
         8+7qgQmhGhEfUVMSylchyagwCYN0ii7O5liTDQo80UFZuazszG1ThGuJ+ss3ikzha/xd
         RTMeDsc7bKLbyOgvWFTCu0UVPMX+xnmlW/4yKnYI0UcEuua+zKeZUulymZtlZ3BBMayc
         DSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999234; x=1754604034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSpqmXgbYV8j5bsB4IVuVf0tack8DQaHL/QU05OaXgY=;
        b=W/EwMDZ3bDa4lXecZClDXqmrn1rQHbuZiFbFTPqNwG0isgy0HZS8dnH1sLoo+rG/C9
         t+H4Rf+MpdpbDtfwFy/Rp23KYBpxfQrKbYIlaGgyS92gjAkPvCGbk8lgEIfCgkY9focx
         0H12376DTRlhl6DBw6Ya4YnVZbZXdW51ZkCj+vscbLp3JoDUvJ7eBR5249mtgyTDCK1Q
         3LDsYK26rrcWjP30ztZ1OGxbL8488+PqX8ghzfg/r3MqWxbDp4ucgNY1MF+IjwXszsxi
         IlzrWNi/eUN3VqR5g57WVeBDKkYAGB/3Et5FVAO+83uow2iW2373rchFVSyt/B3jstEI
         XoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVikGV5zBSAFNY4BKD5TYW39J2Qhu5AJgpUPjxEkBO3U2SQ1UgHLl9chtgVQbRE1sy5j9CHwO5mJhBkmXjR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xvnZWDzTYYaGSkdBSF3wPN9CqkoX0RNwZW0sXrK1lGy5aWcc
	GR/lKdBE07AgrF2AzPTGNCxVeywmoWy9ElxuG8WEXThS0JLMn570ONmXusiIIZm7OzLNVusf6ec
	zWVX3kg==
X-Google-Smtp-Source: AGHT+IG9WPhm5XE/ZfgGaQtzh+SWoXfTwZ/PnXrEVOaIZ7eiVoVCEnZsOmLu+uDuAMPetyxG7jZDFNEKyv8=
X-Received: from plai12.prod.google.com ([2002:a17:902:c94c:b0:240:2b97:90f6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234d:b0:23f:adc0:8cc2
 with SMTP id d9443c01a7336-2422a699c3amr3040655ad.27.1753999233810; Thu, 31
 Jul 2025 15:00:33 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:00:24 -0700
In-Reply-To: <20250731220024.702621-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731220024.702621-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731220024.702621-4-surenb@google.com>
Subject: [PATCH 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
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
index 509fa162760a..b504b798e8fe 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_query_data *query)
 {
-	return mmap_read_lock_killable(mm);
+	query->locked_vma = NULL;
+	query->mmap_locked = false;
+
+	return 0;
 }
 
-static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+static void query_vma_teardown(struct proc_maps_query_data *query)
 {
-	mmap_read_unlock(mm);
+	if (query->mmap_locked)
+		mmap_read_unlock(query->mm);
+	else
+		unlock_vma(query);
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_query_data *query,
+						     unsigned long addr)
 {
-	return find_vma(mm, addr);
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	unlock_vma(query);
+	rcu_read_lock();
+	vma_iter_init(&vmi, query->mm, addr);
+	vma = lock_next_vma(query->mm, &vmi, addr);
+	rcu_read_unlock();
+
+	if (!IS_ERR_OR_NULL(vma)) {
+		query->locked_vma = vma;
+	} else if (PTR_ERR(vma) == -EAGAIN) {
+		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
+		mmap_read_lock(query->mm);
+		vma = find_vma(query->mm, addr);
+		query->mmap_locked = true;
+	}
+
+	return vma;
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_query_data *query)
+{
+	return mmap_read_lock_killable(query->mm);
+}
+
+static void query_vma_teardown(struct proc_maps_query_data *query)
+{
+	mmap_read_unlock(query->mm);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_query_data *query,
+						     unsigned long addr)
+{
+	return find_vma(query->mm, addr);
+}
+
+#endif  /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *query_matching_vma(struct proc_maps_query_data *query,
 						 unsigned long addr, u32 flags)
 {
 	struct vm_area_struct *vma;
 
 next_vma:
-	vma = query_vma_find_by_addr(mm, addr);
+	vma = query_vma_find_by_addr(query, addr);
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
+	struct proc_maps_query_data query = { .mm = mm };
 	struct procmap_query karg;
 	struct vm_area_struct *vma;
-	struct mm_struct *mm;
 	const char *name = NULL;
 	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
@@ -610,17 +660,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!!karg.build_id_size != !!karg.build_id_addr)
 		return -EINVAL;
 
-	mm = priv->query.mm;
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	err = query_vma_setup(mm);
+	err = query_vma_setup(&query);
 	if (err) {
 		mmput(mm);
 		return err;
 	}
 
-	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
+	vma = query_matching_vma(&query, karg.query_addr, karg.query_flags);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
 		vma = NULL;
@@ -705,7 +754,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&query);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -725,7 +774,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(&query);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
@@ -738,7 +787,7 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
 
 	switch (cmd) {
 	case PROCMAP_QUERY:
-		return do_procmap_query(priv, (void __user *)arg);
+		return do_procmap_query(priv->query.mm, (void __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.50.1.565.gc32cd1483b-goog


