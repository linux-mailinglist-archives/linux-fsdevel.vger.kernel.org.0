Return-Path: <linux-fsdevel+bounces-21001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725828FC0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A021C214FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3616A03F;
	Wed,  5 Jun 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpgXLkOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0913AD39;
	Wed,  5 Jun 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547125; cv=none; b=XywbvD+Oe4IKHX4eKJDMvxa2FP//Ep+R3kr4gy6SFszGTaE/Tik3BIlDEWtZl6W1bq4GtT6z0uEMYWWdI396OXoAvHvjhPpJKje1A1CO1h+BYg2TfY7G551JTQ+j3wIQbnzV8IrygQuQYD8ruQaO5GahP2YGcVUn2ExxS7H6iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547125; c=relaxed/simple;
	bh=Pq+QGLVWTUWBT2KD39eaZ277HgWCnfkSzzJkgOa7/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cceUYLu4Xo+9tQS+JycjlqF/a/HxbrH9DU/tnxN8RztVU+bOoVEQcw2Nk+aEnwwUgrR64jNTfqXLzBrG5EDfuf8uJkT2mWNcrU8SzP51JKvPV7VVxG8KVvCxlHcZ0uW4otO1bhjgeHtDLso6MEhW3KHte2SjGjABufZhbSdIs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpgXLkOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59CC2BBFC;
	Wed,  5 Jun 2024 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547124;
	bh=Pq+QGLVWTUWBT2KD39eaZ277HgWCnfkSzzJkgOa7/lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpgXLkOCnVfC96uuFhU6H4kf3FRlKyUiWC5AwEmD+MVxxbpcpWofrljXwKK3VDQ6C
	 Atrrq7u8WckvkQnCVMLNC4Jn+q+pukJjrExfB0JctjvySmUVy4339wU7WjsbrsY9Yl
	 wbf5qxJp5OJeLwAYiXGpbl3AFJA0Jn6SM/8TGzyBAo6mGrHPBLpLmBb4z2e+n2i/b/
	 8RpYXfAwc1M7v6AuOdAjRr5hIU/Jr0u+gGyG9iC/WL508facstcWJVdyjFFwiaSmgk
	 E/RRK/3MUxZGhXKbdvlWC9Rbf4UIpEd0cGJJA3Iw3qQtYXNO3Mo9Klt6Qqec2IjKUa
	 2jql6xImxK5VQ==
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
Subject: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in PROCMAP_QUERY API
Date: Tue,  4 Jun 2024 17:24:49 -0700
Message-ID: <20240605002459.4091285-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605002459.4091285-1-andrii@kernel.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempt to use RCU-protected per-VMA lock when looking up requested VMA
as much as possible, only falling back to mmap_lock if per-VMA lock
failed. This is done so that querying of VMAs doesn't interfere with
other critical tasks, like page fault handling.

This has been suggested by mm folks, and we make use of a newly added
internal API that works like find_vma(), but tries to use per-VMA lock.

We have two sets of setup/query/teardown helper functions with different
implementations depending on availability of per-VMA lock (conditioned
on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.

When per-VMA lock is available, lookup is done under RCU, attempting to
take a per-VMA lock. If that fails, we fallback to mmap_lock, but then
proceed to unconditionally grab per-VMA lock again, dropping mmap_lock
immediately. In this configuration mmap_lock is never helf for long,
minimizing disruptions while querying.

When per-VMA lock is compiled out, we take mmap_lock once, query VMAs
using find_vma() API, and then unlock mmap_lock at the very end once as
well. In this setup we avoid locking/unlocking mmap_lock on every looked
up VMA (depending on query parameters we might need to iterate a few of
them).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 614fbe5d0667..140032ffc551 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
+#ifdef CONFIG_PER_VMA_LOCK
+static int query_vma_setup(struct mm_struct *mm)
+{
+	/* in the presence of per-VMA lock we don't need any setup/teardown */
+	return 0;
+}
+
+static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	/* in the presence of per-VMA lock we need to unlock vma, if present */
+	if (vma)
+		vma_end_read(vma);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	/* try to use less disruptive per-VMA lock */
+	vma = find_and_lock_vma_rcu(mm, addr);
+	if (IS_ERR(vma)) {
+		/* failed to take per-VMA lock, fallback to mmap_lock */
+		if (mmap_read_lock_killable(mm))
+			return ERR_PTR(-EINTR);
+
+		vma = find_vma(mm, addr);
+		if (vma) {
+			/*
+			 * We cannot use vma_start_read() as it may fail due to
+			 * false locked (see comment in vma_start_read()). We
+			 * can avoid that by directly locking vm_lock under
+			 * mmap_lock, which guarantees that nobody can lock the
+			 * vma for write (vma_start_write()) under us.
+			 */
+			down_read(&vma->vm_lock->lock);
+		}
+
+		mmap_read_unlock(mm);
+	}
+
+	return vma;
+}
+#else
 static int query_vma_setup(struct mm_struct *mm)
 {
 	return mmap_read_lock_killable(mm);
@@ -402,6 +445,7 @@ static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsig
 {
 	return find_vma(mm, addr);
 }
+#endif
 
 static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 						 unsigned long addr, u32 flags)
@@ -441,8 +485,10 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 skip_vma:
 	/*
 	 * If the user needs closest matching VMA, keep iterating.
+	 * But before we proceed we might need to unlock current VMA.
 	 */
 	addr = vma->vm_end;
+	vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
 no_vma:
-- 
2.43.0


