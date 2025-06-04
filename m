Return-Path: <linux-fsdevel+bounces-50691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A2ACE712
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F8E169BBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C326FDB7;
	Wed,  4 Jun 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJVzIoT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93E26B0A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078750; cv=none; b=XpTJAhJRXbxfkzDCCyKExT4Wrdbe0o+1yddoONCNAJ39stW/tkRTPvd+KDqygPS5EOVP+AcsTMFrIR4RBytTTnd02hjkujziF+K3FP1v9h9JZRD8v7WAGCVy3U3RnmI2gakdGYH+17/QulHPfo3QaGpxRituu8fyq0KifoA7Hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078750; c=relaxed/simple;
	bh=1JKj07CL69YetOd3eAJtrIP/4dLtscsRaKvQHy9XVnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WK9F9JVw1/TA9uFw0nqIF1wH5j/s/zhxB24omznqdhspiag+os/oGpo/uojsUl7ZfR2BAcRad93j5elsy23nuYvTniA7RCBI2tH+euuLYYUFy3wBpm/nfNkLJpHaib5zv7VwbV1dx5dv9c9tdOeogBDMD0eSF90704OvbeVJHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJVzIoT7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so2373355ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078749; x=1749683549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S3jZ35KMoBO4RnXYNxi81hGE/ddSIH7so+ydU69UE8=;
        b=TJVzIoT7pt0B4DP3NqlGSwg+ostgG6dZHP9ZCFbM08kEnoc/yLCT8ucyA5vOT69UqA
         fjFl/ATtuT79r9sxhVk124XfOrFtgCj3vsaazrKFARHV8xy8gkpJzOu/ejj/3SFxLNkH
         2uqw2nIArev12mAI/KwDY8/Xz8hFN6J8fY2/n2MXa0+yiI7IyaOPLp3kHYbrYXikpc/+
         ogPP1HBxI43rS9SvkfueoI2VBftoRrrK4yMnvAZZChy0ML05Eh9ddz1VS1jCnuiYHCLK
         /6lw/qhFjCsrsCV79QL4q5b5xy4npLqBg3KcSGwrobupJJxbYXcCQ718vilBFuc0PGX1
         CXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078749; x=1749683549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S3jZ35KMoBO4RnXYNxi81hGE/ddSIH7so+ydU69UE8=;
        b=lGIS19Ph9mH3DYRkjF7xCdKTfPVykYZG9fSDK7GqEee0lHVWuQWN873Sc89wndfZi9
         WRrgG1eT5dSaBMyySr7laSHVSVpnBe8Qgsnl5mXakLGPL/uj/UvC6jLHMMApx9CG1h8G
         /vNd0hQpNp20sFwmuuF55/LwP7cHFjQcOPagWRbOTNOouuabkZlu0k1u69kZkfXMWGcs
         y4NbWO7Wq7iXdEJJ6ivEVtkMfHwmk4fcsHb3EiCaRQDIqbZUckccrRRZgyj6oJbR2muM
         MlHOPLrvkCKj+KksjWCCOSjdDchDc6PG4JU1mU9o26v5CxI1ayBLZRsqkj8TYtdEP+NN
         79jg==
X-Forwarded-Encrypted: i=1; AJvYcCWKr1DlwKy+pTKaMSNaNRWs5W3CHBf5C6jafof9qHKHL/4ME06KDX2g6UOhKYiJXUwoZeLbQEgZglFLfgYs@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1m6jsuEjTZGRGribt9w4NmkPMjPMF3cRlQmfuSI6xBpTjxA4
	Os9hYVnjoMPeeCDzZjPGKDCFUhWhn+Qw57UOOonwCKrwcOkifEhX/xp0ozoef+F8ZVOEQ8QMQ1f
	hLyzcng==
X-Google-Smtp-Source: AGHT+IGoGwd/Y8vsxaXkZq3lcq5gV0uAcPoWJqxGcCejiu9rQZwPdtbf9qfiVIzoSAsbfmD8Xw6SbN6aqVM=
X-Received: from plnz4.prod.google.com ([2002:a17:902:8344:b0:231:e2fb:ebf])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:234:e655:a62e
 with SMTP id d9443c01a7336-235e101356bmr63542455ad.9.1749078748733; Wed, 04
 Jun 2025 16:12:28 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:51 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-8-surenb@google.com>
Subject: [PATCH v4 7/7] mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks
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

Utilize per-vma locks to stabilize vma after lookup without taking
mmap_lock during PROCMAP_QUERY ioctl execution. While we might take
mmap_lock for reading during contention, we do that momentarily only
to lock the vma.
This change is designed to reduce mmap_lock contention and prevent
PROCMAP_QUERY ioctl calls from blocking address space updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 36d883c4f394..93ba35a84975 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -550,28 +550,60 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_private *priv)
 {
-	return mmap_read_lock_killable(mm);
+	rcu_read_lock();
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
+	rcu_read_unlock();
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
+{
+	vma_iter_init(&priv->iter, priv->mm, addr);
+	return get_next_vma(priv, addr);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_private *priv)
+{
+	return mmap_read_lock_killable(priv->mm);
+}
+
+static void query_vma_teardown(struct proc_maps_private *priv)
+{
+	mmap_read_unlock(priv->mm);
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
 {
-	return find_vma(mm, addr);
+	return find_vma(priv->mm, addr);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
 
@@ -647,13 +679,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
@@ -738,7 +770,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -758,7 +790,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
-- 
2.49.0.1266.g31b7d2e469-goog


