Return-Path: <linux-fsdevel+bounces-53893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD01AF87B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DB61891D79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336882512DE;
	Fri,  4 Jul 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xh6vLH/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDD24A067
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609270; cv=none; b=crQSAeeF+OE0Dn/wewliA+A4dyh7yGhXRSu6gYoYTeecG1HunJCsgaK8bm6fRbXCl015z85MLX2aPddDenM6dMQp1aQFXqA+9ByEqXwyKBF/KgztI98rVdqInz/f7H+inE8wr6qWaHZmdYVebvQU7SMIX7FdrzOJ6uhIq1Js05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609270; c=relaxed/simple;
	bh=GVjaIfP3+dNOMqyxREilBSvkaK3Gx5u4JJ4xi47FD70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNqx0Lqye9JkTU66ghw1XPlqfq3mLCO9W+ehwelfVYalFcfBdU8CHukQISpxwu6VxF1/mVojfQeAcHgtCyaC2SKmX1Evt4gkS2NtTrZR2D6icMiCXyQKQbUGmdtELg8vuyVaC/6BIKjEzZPT1LKV0BeBKQX0yOdiVVLT+YJmBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xh6vLH/s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-749177ad09fso290382b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609267; x=1752214067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vVO5jxx/ZJrgheBL7RPOjE/kXWGqgLicQNUNDfyGkA=;
        b=Xh6vLH/sg5bApKW5O+yFJNSR0Abp8YRJNBuAQkeSGKOxuvU9ZOyqqi+YwBkF7tVhy2
         Eb9IWYQTOTnV72EVrcNGhOkmXKO02lsJdLHY+i9i6me6z6+CvGW6w3tEo1YyTokwCmKh
         LCTPWbBT8ngpnuOv8NR47Y7zgJsvbhemwV0VjWa8Gc7GFqlBPjN5pl1UsFgVx8oGl4I3
         e1hTEH9QthLWYWnWr7o6OCzXWPuM2LGJjrTaKGBy5A8DiiOQmM6xS35bKQZ+bGA5JW99
         WchrVmOyC2DDQWDnREhz4beYygqDqbWPVlJIbvQpYFijhxoebdn82fKDhn6bHPgdIMon
         qRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609267; x=1752214067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vVO5jxx/ZJrgheBL7RPOjE/kXWGqgLicQNUNDfyGkA=;
        b=oyx1FZGuqzTrwH0+ma/sF3HJ28OCYWc/obrZqwag2L+fj3bvhwf7V9UMDhBbn6kJiZ
         yJjodFlVz5kW6d0G7+qK1EeTIZV72zUIBnZbtcZw0tWCAnQz2194LfQG4AMH01Hr2Hac
         kpteK4mwrXQEpkaXd0xfZ1JzHgAHDsvyiuEqh5dTSQT6k+EA8lwiVJr2gCs20GnzRrVC
         ZnOBUp+LOYF16m5UWD6e+Jr76K00dLrswICQ61nA4OtdNEgiP1D8FSXnyG1WaXihVyeP
         dQJfkql8YCqE+bWF278U28aOGg3IBK8taQXkV5lAQaHEJzvCWS6j6ZcegD0QxZeVNUv2
         YRZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/HVyVubB7PYCoAZdDVReoeSAB4J1JzcCVzj34eMVL/dJ1Fiie5tPwAGl3VzGV738VhsMLlxLzNLcaAciH@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKTL396COhZpSUZ5jllNrmImy/nfVeHnKieVSlCgtKs7GXrDW
	JGdoR1UMVI+iHgwhBjwrhR+WElgNBl5+iIbP8d5kikdfM4j+yqIosQZ6HJ+wXXySUTWIekr7P6u
	InPkt7Q==
X-Google-Smtp-Source: AGHT+IGK2PS7F/Js/FFS6q/dLVUjbaZBo7PGzhlpQvuYSYZ/AxLr1RaHAdn4y2306pdsG4prKULLG7rLEWE=
X-Received: from pftb16.prod.google.com ([2002:a05:6a00:2d0:b0:746:3185:144e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8b:b0:748:3485:b99d
 with SMTP id d2e1a72fcca58-74ce65c53bamr2551001b3a.18.1751609267282; Thu, 03
 Jul 2025 23:07:47 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:26 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-9-surenb@google.com>
Subject: [PATCH v6 8/8] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
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
mmap_lock during PROCMAP_QUERY ioctl execution. While we might take
mmap_lock for reading during contention, we do that momentarily only
to lock the vma.
This change is designed to reduce mmap_lock contention and prevent
PROCMAP_QUERY ioctl calls from blocking address space updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 60 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ff3fe488ce51..0496d5969a51 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -487,28 +487,64 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_private *priv)
 {
-	return mmap_read_lock_killable(mm);
+	priv->locked_vma = NULL;
+	priv->mmap_locked = false;
+
+	return 0;
 }
 
-static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+static void query_vma_teardown(struct proc_maps_private *priv)
 {
-	mmap_read_unlock(mm);
+	unlock_vma(priv);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	rcu_read_lock();
+	vma_iter_init(&priv->iter, priv->mm, addr);
+	vma = get_next_vma(priv, addr);
+	rcu_read_unlock();
+
+	return vma;
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_private *priv)
 {
-	return find_vma(mm, addr);
+	return mmap_read_lock_killable(priv->mm);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
+static void query_vma_teardown(struct proc_maps_private *priv)
+{
+	mmap_read_unlock(priv->mm);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
+{
+	return find_vma(priv->mm, addr);
+}
+
+#endif  /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *query_matching_vma(struct proc_maps_private *priv,
 						 unsigned long addr, u32 flags)
 {
 	struct vm_area_struct *vma;
 
 next_vma:
-	vma = query_vma_find_by_addr(mm, addr);
+	vma = query_vma_find_by_addr(priv, addr);
+	if (IS_ERR(vma))
+		return vma;
+
 	if (!vma)
 		goto no_vma;
 
@@ -584,13 +620,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	err = query_vma_setup(mm);
+	err = query_vma_setup(priv);
 	if (err) {
 		mmput(mm);
 		return err;
 	}
 
-	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
+	vma = query_matching_vma(priv, karg.query_addr, karg.query_flags);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
 		vma = NULL;
@@ -675,7 +711,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -695,7 +731,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
-- 
2.50.0.727.gbf7dc18ff4-goog


