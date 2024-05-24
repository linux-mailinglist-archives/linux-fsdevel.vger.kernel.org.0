Return-Path: <linux-fsdevel+bounces-20090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825298CE03E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E5E1F2342C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA5433C9;
	Fri, 24 May 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGF0nsJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764A40875;
	Fri, 24 May 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523851; cv=none; b=c5PjbQ60ATgEI/XQcAe7KSnkO7u8Nu0DxJI2A8mb17gPpY9nPaodFp77OkCFFJBc5fZDGrJ9GwVtFIvDHIfacTSbStBxBk8WxxKkz65QQE/26oGTKIzXd4Z5U3pMCVPS9W3PSj4WU1L9iFATl/Wb5i2BWdP8ZV6OheMmpl8Gj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523851; c=relaxed/simple;
	bh=zTCFNBXKntn3uKNCfQDhX1RMYgRb96MCd/HOF52B5+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAEyJtV54aIEGXw29uL21VfJ8cdV8SfRRHJJMZ4gjeeDwAlU0PiMO48L1wDVSwk1K/zFc2q9sSB5WZvmbju2uh/NdVYx54zubxltNrVuDiKATDv3aWI6uzJ/XfcyqoXvaUZRDgL7znHB6B3YuxsDbDlDEVoUGDbcdAs33ERHtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGF0nsJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C7C2BD11;
	Fri, 24 May 2024 04:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716523851;
	bh=zTCFNBXKntn3uKNCfQDhX1RMYgRb96MCd/HOF52B5+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGF0nsJ4lWUgidH6hqxg85XT6O9QU7bGEJNrb3GUoUgXu3YNA/gte/0Anz3cym+fi
	 RLnmgOxqPJE9j1T9j9iHMwPsG8FCKPMvhH4phSmQFfIL5nzXbogzdgDcVqz9vgnJP6
	 /BxeoQL47G/TpCJLKoQqdpfxx97EPTB4ZRk/4Od/AHkjZlSecdlSR6s336gRHM/XMT
	 echfa9RMAX8053WZ2GLw2zDVLtprp8Fa3/UsIwDd3+P0CPT9OwxEkmGn4O3UGLjIlC
	 //fdBmcelA5uhED0h0hVtCoQIPvYIUDySrU1awCDh7hfPfntgo1ndJkaNdCjhCB0bS
	 6JJ8I/ed7K09w==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 4/9] fs/procfs: use per-VMA RCU-protected locking in PROCMAP_QUERY API
Date: Thu, 23 May 2024 21:10:26 -0700
Message-ID: <20240524041032.1048094-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempt to use RCU-protected per-VAM lock when looking up requested VMA
as much as possible, only falling back to mmap_lock if per-VMA lock
failed. This is done so that querying of VMAs doesn't interfere with
other critical tasks, like page fault handling.

This has been suggested by mm folks, and we make use of a newly added
internal API that works like find_vma(), but tries to use per-VMA lock.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8ad547efd38d..2b14d06d1def 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -389,12 +389,30 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 )
 
 static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
-						 unsigned long addr, u32 flags)
+						 unsigned long addr, u32 flags,
+						 bool *mm_locked)
 {
 	struct vm_area_struct *vma;
+	bool mmap_locked;
+
+	*mm_locked = mmap_locked = false;
 
 next_vma:
-	vma = find_vma(mm, addr);
+	if (!mmap_locked) {
+		/* if we haven't yet acquired mmap_lock, try to use less disruptive per-VMA */
+		vma = find_and_lock_vma_rcu(mm, addr);
+		if (IS_ERR(vma)) {
+			/* failed to take per-VMA lock, fallback to mmap_lock */
+			if (mmap_read_lock_killable(mm))
+				return ERR_PTR(-EINTR);
+
+			*mm_locked = mmap_locked = true;
+			vma = find_vma(mm, addr);
+		}
+	} else {
+		/* if we have mmap_lock, get through the search as fast as possible */
+		vma = find_vma(mm, addr);
+	}
 
 	/* no VMA found */
 	if (!vma)
@@ -428,18 +446,25 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 skip_vma:
 	/*
 	 * If the user needs closest matching VMA, keep iterating.
+	 * But before we proceed we might need to unlock current VMA.
 	 */
 	addr = vma->vm_end;
+	if (!mmap_locked)
+		vma_end_read(vma);
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
 no_vma:
-	mmap_read_unlock(mm);
+	if (mmap_locked)
+		mmap_read_unlock(mm);
 	return ERR_PTR(-ENOENT);
 }
 
-static void unlock_vma(struct vm_area_struct *vma)
+static void unlock_vma(struct vm_area_struct *vma, bool mm_locked)
 {
-	mmap_read_unlock(vma->vm_mm);
+	if (mm_locked)
+		mmap_read_unlock(vma->vm_mm);
+	else
+		vma_end_read(vma);
 }
 
 static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
@@ -447,6 +472,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	struct procmap_query karg;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
+	bool mm_locked;
 	const char *name = NULL;
 	char *name_buf = NULL;
 	__u64 usize;
@@ -475,7 +501,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
+	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags, &mm_locked);
 	if (IS_ERR(vma)) {
 		mmput(mm);
 		return PTR_ERR(vma);
@@ -542,7 +568,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	/* unlock vma/mm_struct and put mm_struct before copying data to user */
-	unlock_vma(vma);
+	unlock_vma(vma, mm_locked);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
@@ -558,7 +584,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	return 0;
 
 out:
-	unlock_vma(vma);
+	unlock_vma(vma, mm_locked);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
-- 
2.43.0


