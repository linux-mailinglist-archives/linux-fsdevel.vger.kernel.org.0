Return-Path: <linux-fsdevel+bounces-52807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BCAE6FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC61317B396
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F72ED148;
	Tue, 24 Jun 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkdiY3j0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1412ECEA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793659; cv=none; b=Uq5Z9lnypt0sES/ltsmPWBx4oanpM4ry3DGf+xc3yqSieBrufFR/hoT/tEXICgXSJHhnUhyVgD4eGp32DR8lnOYYKshlOr6usBIw3uEyyoDNtQqq91aAjr/H+Xv3wUj7KAXS/nIgySN9/xMnHfe1bcYQgOg+iGyYlYretxPTcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793659; c=relaxed/simple;
	bh=XrkCL8NpzlaF/n3BVH9B6erYWI4M51jhFfWUSpSZR4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5/tnWLP3aq5vamc5A7lz6NBiDdpJbFLH+CdtmflSFMSY6gUsySqlGOVg84H8oOs6HAZvp98CoZ150zTNF2dp8/oIZZsH9xfC1/+sx2H8qnkmGWHjxcm/hns1gej3dyYw8Qa6HcUwT5YmjJr3zqVjEkhh0xhTccIcBvEd+vmjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkdiY3j0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso490356b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750793657; x=1751398457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BERKeqLlcPDyrSUuZIHMWPi0iaWreXsjzz5dAn8mkk=;
        b=bkdiY3j0wIAYJhRcwLEPLslfcOeGaFBVIfREiNARIzV5FYSH6FpPb+wcz8zxnXa+J3
         cGE/tATlBHEhPYlAOlkqtacmgwIxmJAkg1qhoX6OOEo/6cjEWsl3DXqIl68JnK1zpsU5
         sWUV+TlmnqXj6FvKVgvPLaeC1FLaBCpF9q3aTV/cbP03D/fCc0KhiJqxGzVJy7SAQTa2
         Vv9HLX/cEOXYDXST7Xz1K7WtnPINeVwhSRj74qg1kcMbGS4p+kM0NR1cJYDfwIgusuif
         Xg94RBzMYwwkTuNt04bEL6Av8VKA0E74ObMtmwkwxsR7JcwhZ9D4ywtJrQbGklPpAEFb
         tyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793657; x=1751398457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BERKeqLlcPDyrSUuZIHMWPi0iaWreXsjzz5dAn8mkk=;
        b=cru9pQZrqJ8/hcCVKech4h+9pWgr5oJInJLAN5nE6n5c9VxD0IuUfflsMUC12m2bII
         Rz4V3888Klw3vQe6JfkCeVix7++NxhWSu0p0P73iscMZ9Kjz0hFxqS3MCwafwkUeiSCZ
         psYn2yq+SGEuRQymNpZVZPYf3ZwgnRjY4g7sFIH4h8au7rZ9Y7BatD+GS1GdBGytlumY
         0RWa1ZA38/eLQBluQLEFDhKMgYZHMep6/4WRD1yyQMCT6MMvOlNQVq3UTSku5sC41THR
         8A0V+WO5i0xZKn3ff/YRLWSU2AWdfgz3J0HfFG6ywjyLhg/5W7SHpr7fuJnveAoT1khc
         QnXA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGoiiMTQC+Zq4Ini+SN/XZ6kiTM70X+uNJVDTMDD4KI5dw12/Php3dpeZMe4sCpQFbDKa/nrMF1egVuMU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eNdKMYTAg1Fx+tllSZvviN4TAAgr06q2DJukXs1namEiGMhP
	OH+TUIIKG4698RFWCsRx3RhYwx8qi9VOu3rf/T1gK0k8j0k3Doy1bIqoQ88xehuGsbpXTueN8pu
	amEtjvw==
X-Google-Smtp-Source: AGHT+IHtLljtrcUhHYC7Wt+7WKI/a5PDJ4OrDvfWNeRaq5sGEKU3TQKgRzLNMXpoHYXyrtGwyT6oPA3hh2M=
X-Received: from pfrh7.prod.google.com ([2002:aa7:9f47:0:b0:748:4f7c:c605])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f8b:b0:220:7b2e:5b3f
 with SMTP id adf61e73a8af0-2207f27d61amr271750637.19.1750793657223; Tue, 24
 Jun 2025 12:34:17 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:33:59 -0700
In-Reply-To: <20250624193359.3865351-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624193359.3865351-8-surenb@google.com>
Subject: [PATCH v5 7/7] mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 33171afb5364..f3659046efb7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -492,28 +492,60 @@ static int pid_maps_open(struct inode *inode, struct file *file)
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
 }
 
-static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+static void query_vma_teardown(struct proc_maps_private *priv)
 {
-	return find_vma(mm, addr);
+	mmap_read_unlock(priv->mm);
 }
 
-static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
 
@@ -589,13 +621,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
@@ -680,7 +712,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -700,7 +732,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(mm, vma);
+	query_vma_teardown(priv);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
-- 
2.50.0.714.g196bf9f422-goog


