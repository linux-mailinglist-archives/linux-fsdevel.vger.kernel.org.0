Return-Path: <linux-fsdevel+bounces-35605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BB9D64EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754B016181E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F973189B8A;
	Fri, 22 Nov 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIf81/fy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F77186E34
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307937; cv=none; b=HtVG9ES1Z5jFEE4pN9tXae60asb/Ylc7SXqu36B2K2nn6bzSsj+9KqprSAEMZ2sCweWTjb5fGrBk44q4XhpFpjwnTULTeL8bzVwNge5q8PT4Zk6yMfwybxvIsOCTjOSTG61pDX5PiErzlnSuLT1cbn7dg9b37vn9AAXMaV/9s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307937; c=relaxed/simple;
	bh=rNPaW9IJZZSPN9rZXAk+w4APo8vudqB5byh9MHmAZQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jR1dmLwpHlqg/EGppr6BAfbqAgYDeoyXFn2GRLULSDJbn0ZzL+Kzw8S6MH5ySdSuVPAaFoeDJ59UHe7m+eV8S782FwY045sFiqd2yejrJjTpJ1QsldAmM8BPUyoLGfPDgmxkD3A8YrBD/lDCQVp/p4eCYJw6IPmuV1dF+NIFh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIf81/fy; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83e5dd0e5faso108491739f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307934; x=1732912734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnpfIdvtT2sXibK3C2QNgXvNfC8tW5qF1zVo5K9odCY=;
        b=mIf81/fyo/OzEi5haLKLjUt7Ny4QGdOddrp92iXK+ncFJYe8eSqI8LXSylpMjqIyxZ
         baDOMVmTVtWPbeVAckH2gxCRySvJm9e9E5/UnMAJfK2kD8iB2UUZ/+d1i8K3jpP6e69g
         OCUtwhF45aPmnPnDs4vYYY+yyH4QNh6nqpsaNl5zJckrR44lhUUOr06oaNDGKUd5A2Bx
         TAXZiK3aeCt1HqHVwiC995asxqbAIt0I1drKh/9EBKO66JHbmb/kCDLBSuBpS2S5hrVB
         O7Km+tUSI3mhlP+I+PfdRfi7wd+yLv60zzAEFF5Fy39TJEjpSer0FZyn1QqcQ55fEQlf
         mYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307934; x=1732912734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnpfIdvtT2sXibK3C2QNgXvNfC8tW5qF1zVo5K9odCY=;
        b=eGvJHFjw64cfGCQiIViVQeaoWRrbmjs2Is6uCizP5//rmoTQdVx0/f8rd6UVLsmwrZ
         No+Oc+iQm1BySp6n/zTf2TagBTZLmmntU4ZuKs8MNXjXp/3s7AX28eUhnGZq5iItKLdR
         s4xHT/UqHzCARjYOrMb7Hgj/v2FCrYengBea5UMoCExVqvvMHj5LE0hInr5ipYvziuCq
         ts74YcWbIEE/jsdxV5/WL8nsfQDUGYFYBWsNFvDgWRoP9PYiSVPDvfkQxqJiyMmm53Eo
         1zmWZjcIMdp+cKsuEQiGIe8E4M1ja+TZu/nYLogF0tXlgAEPha9gwtp8Dk66IQ3HR4jg
         Py3Q==
X-Gm-Message-State: AOJu0Yx1SBp1sFdQibtSjiG9MLTYz7IWyZbAxEEXDnrpi39VWVpOCj0z
	ZWN2o1GZqRkCnqAKJsaG8NW1Zvzz3bGnD9P/vbgA2KXFk6KHyz19Hme3s8Jk
X-Gm-Gg: ASbGncvgU0sbTD/ScynhkfLo8dZV04st/AcBCkoEFcV92yC69w4nfj8mWkNvrl1XR59
	gVKhnWGaFru6xdM+2uE8O4LP+PnP/gvEP/19oExUybCil9f3ucRKdCwINkWjBaF1eDO1ZSLqRgr
	f5837XOqMZKfUylHLneBZekI8GaKZRxj95rizTNoDRKz7bS4DnIu39tYtS2bSyFlzOyrQBcIyQs
	JoarO3xXgt5/f79N+7jJhRf58YLa9a96XN4hTDuIISC3rPpknxvWg6OHeYWPszmDRMVyPiOWFI=
X-Google-Smtp-Source: AGHT+IEjUnZMs6ZIo2aEUHvO/CA9994z49M0T4LNHqFF5eun05YztQPp1GZzjt2Jtr6wmH3T8uzrTw==
X-Received: by 2002:a05:6602:809:b0:82c:da1e:4ae7 with SMTP id ca18e2360f4ac-83ec19dc310mr779558239f.2.1732307934437;
        Fri, 22 Nov 2024 12:38:54 -0800 (PST)
Received: from manaslu.cs.wisc.edu (manaslu.cs.wisc.edu. [128.105.15.4])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe52506sm794682173.77.2024.11.22.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 12:38:54 -0800 (PST)
From: Bijan Tabatabai <bijan311@gmail.com>
X-Google-Original-From: Bijan Tabatabai <btabatabai@wisc.edu>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	btabatabai@wisc.edu
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mingo@redhat.com
Subject: [RFC PATCH 2/4] fbmm: Add helper functions for FBMM MM Filesystems
Date: Fri, 22 Nov 2024 14:38:28 -0600
Message-Id: <20241122203830.2381905-3-btabatabai@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122203830.2381905-1-btabatabai@wisc.edu>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds four helper functions to simplify the implementation of
MFSs.

fbmm_swapout_folio: Takes a folio to swap out.
fbmm_writepage: An implementation of the address_space_operations.writepage
callback that simply writes the page to the default swap space.
fbmm_read_swap_entry: Reads the contents of a swap entry into a page.
fbmm_copy_page_range: Copies the page table corresponding to the VMA of
one process into the page table of another. The pages in both processes
are write protected for CoW.

This patch also adds infrastructure for FBMM to support copy on write.
The dup_mmap function is modified to create new FBMM files for a forked
process. We also add a callback to the super_operations struct called
copy_page_range, which is called in place of the normal copy_page_range
function in dup_mmap to copy the page table entries to the forked process.
The fbmm_copy_page_range helper is our base implementation of this that
MFSs can use to write protect pages for CoW. However, an MFS can have its
own copy_page_range implementation if, for example, the creaters prefer to
do a deep copy of the pages on fork.

Logic is added to FBMM to handle multiple processes sharing files. A forked
process will keep the list of FBMM files it depends on for CoW, and takes a
reference to those FBMM files. To ensure one process doesn't free memory
used by other another, FBMM will only free memory from a file if its
reference count is 1.

Signed-off-by: Bijan Tabatabai <btabatabai@wisc.edu>
---
 fs/exec.c                     |   2 +
 fs/file_based_mm.c            | 105 +++++++++-
 include/linux/file_based_mm.h |  18 ++
 include/linux/fs.h            |   1 +
 kernel/fork.c                 |  54 ++++-
 mm/Makefile                   |   1 +
 mm/fbmm_helpers.c             | 372 ++++++++++++++++++++++++++++++++++
 mm/internal.h                 |  13 ++
 mm/vmscan.c                   |  14 +-
 9 files changed, 558 insertions(+), 22 deletions(-)
 create mode 100644 mm/fbmm_helpers.c

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..f8f8d3d3ccd1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/file_based_mm.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1900,6 +1901,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
+	fbmm_clear_cow_files(current);
 	return retval;
 
 out:
diff --git a/fs/file_based_mm.c b/fs/file_based_mm.c
index c05797d51cb3..1feabdea1b77 100644
--- a/fs/file_based_mm.c
+++ b/fs/file_based_mm.c
@@ -30,6 +30,12 @@ struct fbmm_file {
 	unsigned long va_start;
 	/* The ending virtual address assigned to this file (exclusive) */
 	unsigned long va_end;
+	atomic_t refcount;
+};
+
+struct fbmm_cow_list_entry {
+	struct list_head node;
+	struct fbmm_file *file;
 };
 
 static enum file_based_mm_state fbmm_state = FBMM_OFF;
@@ -62,6 +68,7 @@ static struct fbmm_info *fbmm_create_new_info(char *mnt_dir_str)
 	}
 
 	mt_init(&info->files_mt);
+	INIT_LIST_HEAD(&info->cow_files);
 
 	return info;
 }
@@ -74,6 +81,11 @@ static void drop_fbmm_file(struct fbmm_file *file)
 	}
 }
 
+static void get_fbmm_file(struct fbmm_file *file)
+{
+	atomic_inc(&file->refcount);
+}
+
 static pmdval_t fbmm_alloc_pmd(struct vm_fault *vmf)
 {
 	struct mm_struct *mm = vmf->vma->vm_mm;
@@ -212,6 +224,7 @@ struct file *fbmm_get_file(struct task_struct *tsk, unsigned long addr, unsigned
 		return NULL;
 	}
 	fbmm_file->f = f;
+	atomic_set(&fbmm_file->refcount, 1);
 	if (topdown) {
 		/*
 		 * Since VAs in this region grow down, this mapping will be the
@@ -300,9 +313,18 @@ int fbmm_munmap(struct task_struct *tsk, unsigned long start, unsigned long len)
 
 		falloc_len = falloc_end_offset - falloc_start_offset;
 
-		ret = vfs_fallocate(fbmm_file->f,
-				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				falloc_start_offset, falloc_len);
+		/*
+		 * Because shared mappings via fork are hard, only punch a hole if there
+		 * is only one proc using this file.
+		 * It would be nice to be able to free the memory if all procs sharing
+		 * the file have unmapped it, but that would require tracking usage at
+		 * a page granularity.
+		 */
+		if (atomic_read(&fbmm_file->refcount) == 1) {
+			ret = vfs_fallocate(fbmm_file->f,
+					FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+					falloc_start_offset, falloc_len);
+		}
 
 		fbmm_file = mt_next(&info->files_mt, fbmm_file->va_start, ULONG_MAX);
 		if (!fbmm_file || fbmm_file->va_end <= start)
@@ -324,6 +346,8 @@ static void fbmm_free_info(struct task_struct *tsk)
 	}
 	mtree_destroy(&info->files_mt);
 
+	fbmm_clear_cow_files(tsk);
+
 	if (info->mnt_dir_str) {
 		path_put(&info->mnt_dir_path);
 		fput(info->get_unmapped_area_file);
@@ -346,6 +370,7 @@ void fbmm_exit(struct task_struct *tsk)
 int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk, u64 clone_flags)
 {
 	struct fbmm_info *info;
+	struct fbmm_cow_list_entry *src_cow, *dst_cow;
 	char *buffer;
 	char *src_dir;
 
@@ -375,9 +400,83 @@ int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk, u64 clon
 		return -ENOMEM;
 	}
 
+	/*
+	 * If the source has CoW files, they may also be CoW files in the destination
+	 * so we need to copy that too
+	 */
+	list_for_each_entry(src_cow, &info->cow_files, node) {
+		dst_cow = kmalloc(sizeof(struct fbmm_cow_list_entry), GFP_KERNEL);
+		if (!dst_cow) {
+			fbmm_free_info(dst_tsk);
+			dst_tsk->fbmm_info = NULL;
+			return -ENOMEM;
+		}
+
+		get_fbmm_file(src_cow->file);
+		dst_cow->file = src_cow->file;
+
+		list_add(&dst_cow->node, &dst_tsk->fbmm_info->cow_files);
+	}
+
 	return 0;
 }
 
+int fbmm_add_cow_file(struct task_struct *new_tsk, struct task_struct *old_tsk,
+		struct file *file, unsigned long start)
+{
+	struct fbmm_info *new_info;
+	struct fbmm_info *old_info;
+	struct fbmm_file *fbmm_file;
+	struct fbmm_cow_list_entry *cow_entry;
+	unsigned long search_start = start + 1;
+
+	new_info = new_tsk->fbmm_info;
+	old_info = old_tsk->fbmm_info;
+	if (!new_info || !old_info)
+		return -EINVAL;
+
+	/*
+	 * Find the fbmm_file that corresponds with the struct file.
+	 * fbmm files can overlap, so make sure to find the one that corresponds
+	 * to this file
+	 */
+	do {
+		fbmm_file = mt_prev(&old_info->files_mt, search_start, 0);
+		if (!fbmm_file || fbmm_file->va_end <= start) {
+			/* Could not find the corressponding fbmm file */
+			return -ENOMEM;
+		}
+		search_start = fbmm_file->va_start;
+	} while (fbmm_file->f != file);
+
+	cow_entry = kmalloc(sizeof(struct fbmm_cow_list_entry), GFP_KERNEL);
+	if (!cow_entry)
+		return -ENOMEM;
+
+	get_fbmm_file(fbmm_file);
+	cow_entry->file = fbmm_file;
+
+	list_add(&cow_entry->node, &new_info->cow_files);
+	return 0;
+}
+
+void fbmm_clear_cow_files(struct task_struct *tsk)
+{
+	struct fbmm_info *info;
+	struct fbmm_cow_list_entry *cow_entry, *tmp;
+
+	info = tsk->fbmm_info;
+	if (!info)
+		return;
+
+	list_for_each_entry_safe(cow_entry, tmp, &info->cow_files, node) {
+		list_del(&cow_entry->node);
+
+		drop_fbmm_file(cow_entry->file);
+		kfree(cow_entry);
+	}
+}
+
 static ssize_t fbmm_state_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
diff --git a/include/linux/file_based_mm.h b/include/linux/file_based_mm.h
index c1c5e82e36ec..22bb8e890144 100644
--- a/include/linux/file_based_mm.h
+++ b/include/linux/file_based_mm.h
@@ -13,6 +13,7 @@ struct fbmm_info {
 	/* This file exists just to be passed to get_unmapped_area in mmap */
 	struct file *get_unmapped_area_file;
 	struct maple_tree files_mt;
+	struct list_head cow_files;
 };
 
 
@@ -31,6 +32,16 @@ void fbmm_populate_file(unsigned long start, unsigned long len);
 int fbmm_munmap(struct task_struct *tsk, unsigned long start, unsigned long len);
 void fbmm_exit(struct task_struct *tsk);
 int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst_tsk, u64 clone_flags);
+int fbmm_add_cow_file(struct task_struct *new_tsk, struct task_struct *old_tsk,
+	struct file *file, unsigned long start);
+void fbmm_clear_cow_files(struct task_struct *tsk);
+
+/* FBMM helper functions for MFSs */
+int fbmm_swapout_folio(struct folio *folio);
+int fbmm_writepage(struct page *page, struct writeback_control *wbc);
+struct page *fbmm_read_swap_entry(struct vm_fault *vmf, swp_entry_t entry, unsigned long pgoff,
+	struct page *page);
+int fbmm_copy_page_range(struct vm_area_struct *dst, struct vm_area_struct *src);
 
 #else /* CONFIG_FILE_BASED_MM */
 
@@ -76,6 +87,13 @@ static inline int fbmm_copy(struct task_struct *src_tsk, struct task_struct *dst
 {
 	return 0;
 }
+
+static inline int fbmm_add_cow_file(struct task_struct *new_tsk, struct task_struct *old_tsk,
+	struct file *file, unsigned long start) {
+	return 0;
+}
+
+static inline void fbmm_clear_cow_files(struct task_struct *tsk) {}
 #endif /* CONFIG_FILE_BASED_MM */
 
 #endif /* __FILE_BASED_MM_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..d38691819880 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2181,6 +2181,7 @@ struct super_operations {
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
 	void (*shutdown)(struct super_block *sb);
+	int (*copy_page_range)(struct vm_area_struct *dst, struct vm_area_struct *src);
 };
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 2b47276b1300..249367110519 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -625,8 +625,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 }
 
 #ifdef CONFIG_MMU
-static __latent_entropy int dup_mmap(struct mm_struct *mm,
-					struct mm_struct *oldmm)
+static __latent_entropy int dup_mmap(struct task_struct *tsk,
+					struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp;
 	int retval;
@@ -732,7 +732,45 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->vm_ops->open(tmp);
 
 		file = tmp->vm_file;
-		if (file) {
+		if (file && use_file_based_mm(tsk) &&
+				(tmp->vm_flags & (VM_SHARED | VM_FBMM)) == VM_FBMM) {
+			/*
+			 * If this is a private FBMM file, we need to create a new
+			 * file for this allocation
+			 */
+			bool topdown = test_bit(MMF_TOPDOWN, &mm->flags);
+			unsigned long len = tmp->vm_end - tmp->vm_start;
+			unsigned long prot = 0;
+			unsigned long pgoff;
+			struct file *orig_file = file;
+
+			if (tmp->vm_flags & VM_READ)
+				prot |= PROT_READ;
+			if (tmp->vm_flags & VM_WRITE)
+				prot |= PROT_WRITE;
+			if (tmp->vm_flags & VM_EXEC)
+				prot |= PROT_EXEC;
+
+			/*
+			 * topdown may be incorrect if it is true but this is for a region created
+			 * by brk, which grows up, but if it's wrong, it'll only affect the next
+			 * brk allocation
+			 */
+			file = fbmm_get_file(tsk, tmp->vm_start, len, prot, 0, topdown, &pgoff);
+			if (!file) {
+				retval = -ENOMEM;
+				goto loop_out;
+			}
+
+			tmp->vm_pgoff = pgoff;
+			tmp->vm_file = get_file(file);
+			call_mmap(file, tmp);
+
+			retval = fbmm_add_cow_file(tsk, current, orig_file, tmp->vm_start);
+			if (retval) {
+				goto loop_out;
+			}
+		} else if (file) {
 			struct address_space *mapping = file->f_mapping;
 
 			get_file(file);
@@ -747,8 +785,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(tmp, mpnt);
+		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
+			if (file && file->f_inode->i_sb->s_op->copy_page_range)
+				retval = file->f_inode->i_sb->s_op->copy_page_range(tmp, mpnt);
+			else
+				retval = copy_page_range(tmp, mpnt);
+		}
 
 		if (retval) {
 			mpnt = vma_next(&vmi);
@@ -1685,7 +1727,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;
 
-	err = dup_mmap(mm, oldmm);
+	err = dup_mmap(tsk, mm, oldmm);
 	if (err)
 		goto free_pt;
 
diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1..fc5d1c4e0d5e 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -139,3 +139,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
+obj-$(CONFIG_FILE_BASED_MM) += fbmm_helpers.o
diff --git a/mm/fbmm_helpers.c b/mm/fbmm_helpers.c
new file mode 100644
index 000000000000..2c3c5522f34c
--- /dev/null
+++ b/mm/fbmm_helpers.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <linux/file_based_mm.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/rmap.h>
+#include <linux/blkdev.h>
+#include <linux/mmu_notifier.h>
+#include <linux/swap_slots.h>
+#include <linux/pagewalk.h>
+#include <linux/zswap.h>
+
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+#include "swap.h"
+
+/******************************************************************************
+ * Swap Helpers
+ *****************************************************************************/
+static bool fbmm_try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
+				unsigned long address, void *arg)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	pte_t pteval, swp_pte;
+	swp_entry_t entry;
+	struct page *page;
+	bool ret = true;
+	struct mmu_notifier_range range;
+
+	range.end = vma_address_end(&pvmw);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
+							address, range.end);
+	mmu_notifier_invalidate_range_start(&range);
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		page = folio_page(folio, pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		address = pvmw.address;
+
+		pteval = ptep_clear_flush(vma, address, pvmw.pte);
+
+		if (pte_dirty(pteval))
+			folio_mark_dirty(folio);
+
+		entry.val = page_private(page);
+
+		if (swap_duplicate(entry) < 0) {
+			set_pte_at(mm, address, pvmw.pte, pteval);
+			ret = false;
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+
+		dec_mm_counter(mm, MM_FILEPAGES);
+		inc_mm_counter(mm, MM_SWAPENTS);
+		swp_pte = swp_entry_to_pte(entry);
+		if (pte_soft_dirty(pteval))
+			swp_pte = pte_swp_mksoft_dirty(swp_pte);
+
+		set_pte_at(mm, address, pvmw.pte, swp_pte);
+
+		folio_remove_rmap_pte(folio, page, vma);
+		folio_put(folio);
+	}
+
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
+static int folio_not_mapped(struct folio *folio)
+{
+	return !folio_mapped(folio);
+}
+
+static void fbmm_try_to_unmap(struct folio *folio)
+{
+	struct rmap_walk_control rwc = {
+		.rmap_one = fbmm_try_to_unmap_one,
+		.arg = NULL,
+		.done = folio_not_mapped,
+	};
+
+	rmap_walk(folio, &rwc);
+}
+
+/*
+ * fbmm_swapout_folio - Helper function for MFSs to swapout a folio
+ * @folio: The folio to swap out. Must has a reference count of at least 3.
+ * One the thread is holding on to, one for the file mapping, and one for each
+ * page table entry it is mapped to
+ *
+ * Returns 0 on success and nonzero otherwise
+ */
+int fbmm_swapout_folio(struct folio *folio)
+{
+	struct address_space *mapping;
+	struct swap_info_struct *si;
+	unsigned long offset;
+	struct swap_iocb *plug = NULL;
+	swp_entry_t entry;
+
+	if (!folio_trylock(folio))
+		return 1;
+
+	entry = folio_alloc_swap(folio);
+	if (!entry.val)
+		goto unlock;
+
+	offset = swp_offset(entry);
+
+	folio->swap = entry;
+
+	folio_mark_dirty(folio);
+
+	if (folio_ref_count(folio) < 3)
+		goto unlock;
+
+	if (folio_mapped(folio)) {
+		fbmm_try_to_unmap(folio);
+		if (folio_mapped(folio))
+			goto unlock;
+	}
+
+	mapping = folio_mapping(folio);
+	if (folio_test_dirty(folio)) {
+		try_to_unmap_flush_dirty();
+		switch (pageout(folio, mapping, &plug)) {
+		case PAGE_KEEP:
+			fallthrough;
+		case PAGE_ACTIVATE:
+			goto unlock;
+		case PAGE_SUCCESS:
+			/* pageout eventually unlocks the folio on success, so lock it */
+			if (!folio_trylock(folio))
+				return 1;
+			fallthrough;
+		case PAGE_CLEAN:
+			;
+		}
+	}
+
+	remove_mapping(mapping, folio);
+	folio_unlock(folio);
+
+	si = get_swap_device(entry);
+	si->swap_map[offset] &= ~SWAP_HAS_CACHE;
+	put_swap_device(si);
+
+	return 0;
+
+unlock:
+	folio_unlock(folio);
+	return 1;
+}
+EXPORT_SYMBOL(fbmm_swapout_folio);
+
+static void fbmm_end_swap_bio_write(struct bio *bio)
+{
+	struct folio *folio = bio_first_folio_all(bio);
+	int ret;
+
+	/* This is the simplification of __folio_end_writeback */
+	ret = folio_test_clear_writeback(folio);
+	if (!ret)
+		return;
+
+	sb_clear_inode_writeback(folio_mapping(folio)->host);
+
+	/* Simplification of folio_end_writeback */
+	smp_mb__after_atomic();
+	acct_reclaim_writeback(folio);
+}
+
+/* Analogue to __swap_writepage */
+static void __fbmm_writepage(struct folio *folio, struct writeback_control *wbc)
+{
+	struct bio bio;
+	struct bio_vec bv;
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+
+	bio_init(&bio, sis->bdev, &bv, 1,
+			REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc));
+	bio.bi_iter.bi_sector = swap_folio_sector(folio);
+	bio_add_folio_nofail(&bio, folio, folio_size(folio), 0);
+
+	count_vm_events(PSWPOUT, folio_nr_pages(folio));
+	folio_start_writeback(folio);
+	folio_unlock(folio);
+
+	submit_bio_wait(&bio);
+	fbmm_end_swap_bio_write(&bio);
+}
+
+int fbmm_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct folio *folio = page_folio(page);
+	int ret = 0;
+
+	ret = arch_prepare_to_swap(folio);
+	if (ret) {
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		return 0;
+	}
+
+	__fbmm_writepage(folio, wbc);
+	return 0;
+}
+EXPORT_SYMBOL(fbmm_writepage);
+
+struct page *fbmm_read_swap_entry(struct vm_fault *vmf, swp_entry_t entry, unsigned long pgoff,
+		struct page *page)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct swap_info_struct *si;
+	struct folio *folio;
+
+	if (unlikely(non_swap_entry(entry)))
+		return NULL;
+
+	/*
+	 * If a folio is already mapped here, just return that.
+	 * Another process has probably already brought in the shared page
+	 */
+	folio = filemap_get_folio(mapping, pgoff);
+	if (!IS_ERR(folio))
+		return folio_page(folio, 0);
+
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
+
+	folio = page_folio(page);
+
+	folio_lock(folio);
+	folio->swap = entry;
+	/* swap_read_folio unlocks the folio */
+	swap_read_folio(folio, true, NULL);
+	folio->private = NULL;
+
+	swap_free(entry);
+
+	put_swap_device(si);
+	count_vm_events(PSWPIN, folio_nr_pages(folio));
+	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	return folio_page(folio, 0);
+}
+EXPORT_SYMBOL(fbmm_read_swap_entry);
+
+/******************************************************************************
+ * Copy on write helpers
+ *****************************************************************************/
+struct page_walk_levels {
+	struct vm_area_struct *vma;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+};
+
+static int fbmm_copy_pgd(pgd_t *pgd, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct page_walk_levels *dst_levels = walk->private;
+
+	dst_levels->pgd = pgd_offset(dst_levels->vma->vm_mm, addr);
+	return 0;
+}
+
+static int fbmm_copy_p4d(p4d_t *p4d, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct page_walk_levels *dst_levels = walk->private;
+
+	dst_levels->p4d = p4d_alloc(dst_levels->vma->vm_mm, dst_levels->pgd, addr);
+	if (!dst_levels->p4d)
+		return -ENOMEM;
+	return 0;
+}
+
+static int fbmm_copy_pud(pud_t *pud, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct page_walk_levels *dst_levels = walk->private;
+
+	dst_levels->pud = pud_alloc(dst_levels->vma->vm_mm, dst_levels->p4d, addr);
+	if (!dst_levels->pud)
+		return -ENOMEM;
+	return 0;
+}
+
+static int fbmm_copy_pmd(pmd_t *pmd, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct page_walk_levels *dst_levels = walk->private;
+
+	dst_levels->pmd = pmd_alloc(dst_levels->vma->vm_mm, dst_levels->pud, addr);
+	if (!dst_levels->pmd)
+		return -ENOMEM;
+	return 0;
+}
+
+static int fbmm_copy_pte(pte_t *pte, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	struct page_walk_levels *dst_levels = walk->private;
+	struct mm_struct *dst_mm = dst_levels->vma->vm_mm;
+	struct mm_struct *src_mm = walk->mm;
+	pte_t *src_pte = pte;
+	pte_t *dst_pte;
+	spinlock_t *dst_ptl;
+	pte_t entry;
+	struct page *page;
+	struct folio *folio;
+	int ret = 0;
+
+	dst_pte = pte_alloc_map(dst_mm, dst_levels->pmd, addr);
+	if (!dst_pte)
+		return -ENOMEM;
+	dst_ptl = pte_lockptr(dst_mm, dst_levels->pmd);
+	/* The spinlock for the src pte should already be taken */
+	spin_lock_nested(dst_ptl, SINGLE_DEPTH_NESTING);
+
+	if (pte_none(*src_pte))
+		goto unlock;
+
+	/* I don't really want to handle to swap case, so I won't for now */
+	if (unlikely(!pte_present(*src_pte))) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	entry = ptep_get(src_pte);
+	page = vm_normal_page(walk->vma, addr, entry);
+	if (page)
+		folio = page_folio(page);
+
+	folio_get(folio);
+	folio_dup_file_rmap_pte(folio, page);
+	percpu_counter_inc(&dst_mm->rss_stat[MM_FILEPAGES]);
+
+	if (!(walk->vma->vm_flags & VM_SHARED) && pte_write(entry)) {
+		ptep_set_wrprotect(src_mm, addr, src_pte);
+		entry = pte_wrprotect(entry);
+	}
+
+	entry = pte_mkold(entry);
+	set_pte_at(dst_mm, addr, dst_pte, entry);
+
+unlock:
+	pte_unmap_unlock(dst_pte, dst_ptl);
+	return ret;
+}
+
+int fbmm_copy_page_range(struct vm_area_struct *dst, struct vm_area_struct *src)
+{
+	struct page_walk_levels dst_levels;
+	struct mm_walk_ops walk_ops = {
+		.pgd_entry = fbmm_copy_pgd,
+		.p4d_entry = fbmm_copy_p4d,
+		.pud_entry = fbmm_copy_pud,
+		.pmd_entry = fbmm_copy_pmd,
+		.pte_entry = fbmm_copy_pte,
+	};
+
+	dst_levels.vma = dst;
+
+	return walk_page_range(src->vm_mm, src->vm_start, src->vm_end,
+		&walk_ops, &dst_levels);
+}
+EXPORT_SYMBOL(fbmm_copy_page_range);
diff --git a/mm/internal.h b/mm/internal.h
index cc2c5e07fad3..bed53f3a6ed3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1515,4 +1515,17 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+/* possible outcome of pageout() */
+typedef enum {
+	/* failed to write folio out, folio is locked */
+	PAGE_KEEP,
+	/* move folio to the active list, folio is locked */
+	PAGE_ACTIVATE,
+	/* folio has been sent to the disk successfully, folio is unlocked */
+	PAGE_SUCCESS,
+	/* folio is clean and locked */
+	PAGE_CLEAN,
+} pageout_t;
+pageout_t pageout(struct folio *folio, struct address_space *mapping,
+			 struct swap_iocb **plug);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..93291d25eb11 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -591,23 +591,11 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 		wake_up(&pgdat->reclaim_wait[VMSCAN_THROTTLE_WRITEBACK]);
 }
 
-/* possible outcome of pageout() */
-typedef enum {
-	/* failed to write folio out, folio is locked */
-	PAGE_KEEP,
-	/* move folio to the active list, folio is locked */
-	PAGE_ACTIVATE,
-	/* folio has been sent to the disk successfully, folio is unlocked */
-	PAGE_SUCCESS,
-	/* folio is clean and locked */
-	PAGE_CLEAN,
-} pageout_t;
-
 /*
  * pageout is called by shrink_folio_list() for each dirty folio.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct folio *folio, struct address_space *mapping,
+pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			 struct swap_iocb **plug)
 {
 	/*
-- 
2.34.1


