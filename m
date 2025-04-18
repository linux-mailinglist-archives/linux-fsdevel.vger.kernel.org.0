Return-Path: <linux-fsdevel+bounces-46688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A8A93C53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16711445C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A12F224AFB;
	Fri, 18 Apr 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZqb7kPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEB225793
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998623; cv=none; b=o1m5vuAp/JO8j/QJg9IEgZ04cITJJyeoFxxS2oxz1FRNakIPPIfhhJOuM7v/tvlSFAuvTE9OqqGYNEOXY1NsJYqE86l7uavyKmZnkteUoBf1oIaELoMSJG3ukr0TcBjI1piK2/nO2BeoSODPUYrzC7N/VAxvHN6lIJ+oJ1Jf7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998623; c=relaxed/simple;
	bh=sKg7f329Zs3O82Sqp+e8qxPxOZ/t4mW6H6H8eA3C9lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pALU2TB9p3znABAOAv04qbkkXIkA1f5/mwyHs3lRb10lbjFQLaO9iDfzchncirt7eNdF1qaAEwVv6XQtAR0YuAm48u3kSJkGZKEZPTPoteitYv1nlc20F2N++rHwkLU2w0zJwWYtUzfRT1KcnNTPLuutAK6LrtalZXfCx3IEiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZqb7kPy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ade807fso33216845ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998621; x=1745603421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDNsq3YX7eW5e3apKRRmkWWvDDDuWE0xbjvQjwBgCsE=;
        b=AZqb7kPy/oRHhVyW00nvGWJKO6OQN2L0ukhaFp7qXyDPXhS+GR+w5FMSEtkQa/zcZZ
         dw+GmEy1385+mbG1El3VlhBm2rn6nwWEwg8YHBz3fKKQPMecS+cJiz7tHTUDW0Qsqj9t
         mE4If8izxzVDtWRnhsr+DEHlGTFNgFTEwADD41JxWYc+VnaDBqUST4v0Yw1hdqY0f2gq
         ny+ySQxHj3mGDwHrK2kzMl83Vm/5IzHPJE3USmbUKHK2TjEwu1VvTdMl3yDgwrVlNqjC
         Px0Ezpd8E/c730HRLMwGA+zNHLeiZVxDYWjAAzwkMnWb5aVJ57Kr2hbR0jlJ1M/R+U2G
         qoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998621; x=1745603421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDNsq3YX7eW5e3apKRRmkWWvDDDuWE0xbjvQjwBgCsE=;
        b=AUbK+AttQGz0zb+SIvF32hUHwwbs6/ZtBAJvh8QOD4diRsroSxdF+ZhtusRutD3Edw
         itVSm5JpG+p8E1DWiWPQATAIM4rHxGmgRpNBT3TYSFrqmXGUcIc8cqdUNga8CA7evLyO
         8X/nbnpyuQDbijXsQEmzGOIIj0XqrxJpnNu7kSBkLU90zhsD9T54V0u1Qs+3aVGWOQ2M
         TX4Klb/mbM/qA93Lf9/MIb30G6TfkMfGaYbjGUJC64nRHiqLzEV1wmHQrB3+P7jJf8kq
         7K+3X3cp3AIuIglJWguPqCyo8Bi1YP6kmVTVJhgDQqsdvvNaNg0hNNhj1/TUT5HPjV9l
         cCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXj+WL+LnRICwyooDWwGsRfvBxSm18VtymvlsCdkKCbH7iZxQk6bRUjOWLuObQTLgBwVvFg6OynYNw3Y/MM@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP11TWsWr/0vN1zWMnhusCkvLLYOwQynJ0igU/dd3z4WrZCtx
	Qp1L/MLNm2gG8w1lQW8dopez+dH3wIiLBauy1lpONDDnkXjtYn4INtMhTM6r/RDjQntXUzJNE/V
	SRQ==
X-Google-Smtp-Source: AGHT+IH4SzFcgriEZeEyINeEOYHsKsBduZvh1a8UF65TGxe4ng4DHNhTgv3meBOCFXGKpW1iswhVW2S93bM=
X-Received: from plrd9.prod.google.com ([2002:a17:902:aa89:b0:223:225b:3d83])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cc:b0:224:24d5:f20a
 with SMTP id d9443c01a7336-22c53620caamr57870345ad.48.1744998620802; Fri, 18
 Apr 2025 10:50:20 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:59 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-9-surenb@google.com>
Subject: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
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

Utilize speculative vma lookup to find and snapshot a vma without
taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
address space modifications are detected and the lookup is retried.
While we take the mmap_lock for reading during such contention, we
do that momentarily only to record new mm_wr_seq counter.
This change is designed to reduce mmap_lock contention and prevent
PROCMAP_QUERY ioctl calls (often a low priority task, such as
monitoring/data collection services) from blocking address space
updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f9d50a61167c..28b975ddff26 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -525,9 +525,53 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct mm_struct *mm)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static int query_vma_setup(struct proc_maps_private *priv)
 {
-	return mmap_read_lock_killable(mm);
+	if (!mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq)) {
+		int ret = mmap_read_lock_killable(priv->mm);
+
+		if (ret)
+			return ret;
+
+		/* mmap_lock_speculate_try_begin() succeeds when holding mmap_read_lock */
+		mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
+		mmap_read_unlock(priv->mm);
+	}
+
+	memset(&priv->vma_copy, 0, sizeof(priv->vma_copy));
+	rcu_read_lock();
+
+	return 0;
+}
+
+static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	rcu_read_unlock();
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	vma_iter_init(&priv->iter, priv->mm, addr);
+	vma = vma_next(&priv->iter);
+	if (!vma)
+		return NULL;
+
+	vma = get_stable_vma(vma, priv, addr);
+
+	/* The only possible error is EINTR, just pretend we found nothing */
+	return IS_ERR(vma) ? NULL : vma;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static int query_vma_setup(struct proc_maps_private *priv)
+{
+	return mmap_read_lock_killable(priv->mm);
 }
 
 static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -535,18 +579,21 @@ static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
 	mmap_read_unlock(mm);
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
+						     unsigned long addr)
 {
-	return find_vma(mm, addr);
+	return find_vma(priv->mm, addr);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *query_matching_vma(struct proc_maps_private *priv,
 						 unsigned long addr, u32 flags)
 {
 	struct vm_area_struct *vma;
 
 next_vma:
-	vma = query_vma_find_by_addr(mm, addr);
+	vma = query_vma_find_by_addr(priv, addr);
 	if (!vma)
 		goto no_vma;
 
@@ -622,13 +669,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
-- 
2.49.0.805.g082f7c87e0-goog


