Return-Path: <linux-fsdevel+bounces-20999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31E8FC0A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0A0B27F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98713A89F;
	Wed,  5 Jun 2024 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2n4XMzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624D13A885;
	Wed,  5 Jun 2024 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547117; cv=none; b=KQLazRBn3OB9ubvZIYqhR/jmrImYubo0Nh1VLbTERwMG3yh40xxXMUE3y/DqOZgQdSjwVgirc7ki1zj1g3e+bTqX4P1Shwa6VEJBwhacJbCB9eN3HFWfoRZVJ2ZISZ7ady7+dI9fWG71zJIWczkfv41bkZWRNeEnSpf1MQO2EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547117; c=relaxed/simple;
	bh=MRe3J2lR02W8fKMz0jOORh8WM6XjEyHtsdoj2x2PKJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDFr/BhRwQG+FFSrZMndLhNrwOYz7QDDh0+ExxhEBa4ass2c6NlhfHT2wOCElqiGZJEp/n2hB0oabSyx4WF5W7mPEtqLRN1U1mVFwP1P6b8ybfJOiTtg2T+qvzdhjyEnBCeIS99sVvQMv9Qv9YnQc/1za0tYiHTp0IyOJldfD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2n4XMzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F9C2BBFC;
	Wed,  5 Jun 2024 00:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547117;
	bh=MRe3J2lR02W8fKMz0jOORh8WM6XjEyHtsdoj2x2PKJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2n4XMzfqQtlHII1pzt80oFo9YPq+fDQa4PXaugpXWcJF4d1I2pk1JT+RuboPqznW
	 WSXGEMTL5blWc5VR6nUNwCIrk7CaRzbzBM5P7G0L0RlKgx3pyNTjuH5cQyw6d+ayJe
	 rp4XqvEIjAxQeYjG5UZH4m3NAPDS1RKlY8tZ2wKqVfcobGVJY8VY4szQLlLQHGJ9ev
	 WkYq9peZRmUxa8FaJZ+a+TZXGGAYdRwyqhrwA8FhDWd92cnQ6hS6NiS5HhispaoK3F
	 OzDpPYsw4203pK+abejqee1NMfjjHnaKRwWsu+r4SXlfLTgXGivRptL5/oF+AOB5kI
	 9KO1xQQMAGJCg==
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
Subject: [PATCH v3 2/9] fs/procfs: extract logic for getting VMA name constituents
Date: Tue,  4 Jun 2024 17:24:47 -0700
Message-ID: <20240605002459.4091285-3-andrii@kernel.org>
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

Extract generic logic to fetch relevant pieces of data to describe VMA
name. This could be just some string (either special constant or
user-provided), or a string with some formatted wrapping text (e.g.,
"[anon_shmem:<something>]"), or, commonly, file path. seq_file-based
logic has different methods to handle all three cases, but they are
currently mixed in with extracting underlying sources of data.

This patch splits this into data fetching and data formatting, so that
data fetching can be reused later on.

There should be no functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 125 +++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8d35f993fe5..334ae210a95a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -239,6 +239,67 @@ static int do_maps_open(struct inode *inode, struct file *file,
 				sizeof(struct proc_maps_private));
 }
 
+static void get_vma_name(struct vm_area_struct *vma,
+			 const struct path **path,
+			 const char **name,
+			 const char **name_fmt)
+{
+	struct anon_vma_name *anon_name = vma->vm_mm ? anon_vma_name(vma) : NULL;
+
+	*name = NULL;
+	*path = NULL;
+	*name_fmt = NULL;
+
+	/*
+	 * Print the dentry name for named mappings, and a
+	 * special [heap] marker for the heap:
+	 */
+	if (vma->vm_file) {
+		/*
+		 * If user named this anon shared memory via
+		 * prctl(PR_SET_VMA ..., use the provided name.
+		 */
+		if (anon_name) {
+			*name_fmt = "[anon_shmem:%s]";
+			*name = anon_name->name;
+		} else {
+			*path = file_user_path(vma->vm_file);
+		}
+		return;
+	}
+
+	if (vma->vm_ops && vma->vm_ops->name) {
+		*name = vma->vm_ops->name(vma);
+		if (*name)
+			return;
+	}
+
+	*name = arch_vma_name(vma);
+	if (*name)
+		return;
+
+	if (!vma->vm_mm) {
+		*name = "[vdso]";
+		return;
+	}
+
+	if (vma_is_initial_heap(vma)) {
+		*name = "[heap]";
+		return;
+	}
+
+	if (vma_is_initial_stack(vma)) {
+		*name = "[stack]";
+		return;
+	}
+
+	if (anon_name) {
+		*name_fmt = "[anon:%s]";
+		*name = anon_name->name;
+		return;
+	}
+}
+
 static void show_vma_header_prefix(struct seq_file *m,
 				   unsigned long start, unsigned long end,
 				   vm_flags_t flags, unsigned long long pgoff,
@@ -262,17 +323,15 @@ static void show_vma_header_prefix(struct seq_file *m,
 static void
 show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 {
-	struct anon_vma_name *anon_name = NULL;
-	struct mm_struct *mm = vma->vm_mm;
-	struct file *file = vma->vm_file;
+	const struct path *path;
+	const char *name_fmt, *name;
 	vm_flags_t flags = vma->vm_flags;
 	unsigned long ino = 0;
 	unsigned long long pgoff = 0;
 	unsigned long start, end;
 	dev_t dev = 0;
-	const char *name = NULL;
 
-	if (file) {
+	if (vma->vm_file) {
 		const struct inode *inode = file_user_inode(vma->vm_file);
 
 		dev = inode->i_sb->s_dev;
@@ -283,57 +342,15 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
-	if (mm)
-		anon_name = anon_vma_name(vma);
 
-	/*
-	 * Print the dentry name for named mappings, and a
-	 * special [heap] marker for the heap:
-	 */
-	if (file) {
+	get_vma_name(vma, &path, &name, &name_fmt);
+	if (path) {
 		seq_pad(m, ' ');
-		/*
-		 * If user named this anon shared memory via
-		 * prctl(PR_SET_VMA ..., use the provided name.
-		 */
-		if (anon_name)
-			seq_printf(m, "[anon_shmem:%s]", anon_name->name);
-		else
-			seq_path(m, file_user_path(file), "\n");
-		goto done;
-	}
-
-	if (vma->vm_ops && vma->vm_ops->name) {
-		name = vma->vm_ops->name(vma);
-		if (name)
-			goto done;
-	}
-
-	name = arch_vma_name(vma);
-	if (!name) {
-		if (!mm) {
-			name = "[vdso]";
-			goto done;
-		}
-
-		if (vma_is_initial_heap(vma)) {
-			name = "[heap]";
-			goto done;
-		}
-
-		if (vma_is_initial_stack(vma)) {
-			name = "[stack]";
-			goto done;
-		}
-
-		if (anon_name) {
-			seq_pad(m, ' ');
-			seq_printf(m, "[anon:%s]", anon_name->name);
-		}
-	}
-
-done:
-	if (name) {
+		seq_path(m, path, "\n");
+	} else if (name_fmt) {
+		seq_pad(m, ' ');
+		seq_printf(m, name_fmt, name);
+	} else if (name) {
 		seq_pad(m, ' ');
 		seq_puts(m, name);
 	}
-- 
2.43.0


