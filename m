Return-Path: <linux-fsdevel+bounces-18703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624158BB8BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FA21C22823
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774B139E;
	Sat,  4 May 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irYCdfxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FEA920;
	Sat,  4 May 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782611; cv=none; b=DkFht93wM3DXZiweqZ+TXKR6JaytkrurX1L4jiVIDPcd063d6ANcn8lzpnuVR0FLFcT74mLYkZ47eiryKm7lv510cpFn1WGZdIPWiEBmDlHpCU4VobBBT7MJg2an6blCcIMz/jhohNx9DSPgZ1SdxAS1NkalqtgacwNnjcDrzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782611; c=relaxed/simple;
	bh=OsmoaOeW12SHNusJpkc/eLJf6KgrIDQoVNy4kZW2PTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOAHvphfW5hQeXNi3TQekDQHkk4IwW4wS3602DyjN8S68C8eyYJy3plVdtfdTWUAyWwSgDfsNiBnssqgP5/Z9ngJnZNy7aLAKjXF8dstjPHzdGhBSgPLmoFKkD+TQd3GcJ2ToDFDpk/DFQ+/Ejjcq6Mf5NZRZr9s8z/vmnCJHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irYCdfxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0E4C116B1;
	Sat,  4 May 2024 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782611;
	bh=OsmoaOeW12SHNusJpkc/eLJf6KgrIDQoVNy4kZW2PTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irYCdfxYU679AgBBu/x1QTRLnZGEvoju3sMUjuymybtvTRyAXO34Tu5LrJt7S78GY
	 OYoR1xjPv5idsNALPBfT7OYYvZAVRvGMyGBnqgsAFCh5iwoF6Zj9+pOMlsxs3vOp35
	 ImKr2la/Wynbx9YuuVLBqCV/jZZkBNJ4eDaZdYQbwS4A3J1cMls5s+EgtK5ozteiCq
	 /tYaIw5mCGNRgjh3VARmvmzCzLCsA9n6fr/3fi0mORhOWDmjf8DQfjEiOYKVkIq2ts
	 GlWEUVLdgIHoayTxpXLIO+ah6hUvLFFp4Ih08ljZbPW1C39TkwvEBJbUta+rtjK4Vl
	 QEt+UszXK9gRg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/5] fs/procfs: extract logic for getting VMA name constituents
Date: Fri,  3 May 2024 17:30:02 -0700
Message-ID: <20240504003006.3303334-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
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
index e5a5f015ff03..8e503a1635b7 100644
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


