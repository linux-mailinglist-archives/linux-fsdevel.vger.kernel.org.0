Return-Path: <linux-fsdevel+bounces-16332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BC89B3F3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 22:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B32815AD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A893D993;
	Sun,  7 Apr 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxqtcBUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE13D569
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520692; cv=none; b=LR8hkqi0wWY42HutcMKajWrL4Re+A8onCLJH+rsXeIQTWowYHJ89zEa0DTD26n8fOp1b5yowEn+XllSIRul1h9nDIqkckoiC9WYkIRSwsA4o8+/t0roOC2RslrYk+Ryh6ED01mxfJfBxMOnISHpxyeJBLapv/cxWnMRduI6DIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520692; c=relaxed/simple;
	bh=HumBzKPe+RYytsEYhacEELPkiNv+7DTXfXQUcLE1Qv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+9+95UuNrkxtRhbcWigWdq6dyfxUUC/Cs1JwsURIhTLtXZyh0cdNQJSKbi2CTMW4QH+96TjhJLXhavjMwm3PjK5AXeg1HSE4MSPHyyF+b+lMEcLcrsVaxZYv78e/JnmBZEG54r9fTw6B/jfRiEwAPh/D4c13seUaSiaCxpkmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxqtcBUh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=UQsOFvL5oFgV4srGasbjfHyPJshGZk1x51pSsspYdxY=; b=oxqtcBUhDSBPZDEBGm2OpZsLq0
	FFqjpc+7u5M9XrJ0e7rzqd42GGHmfsjUdd2hF4tyuBYFiYwTjhiTQwA/LzOWpmvcbFdVOtnGI7YNC
	vQe+Loe0axTb6dncgKtJaLNlKte20i/q7BLokpxYAXpiCyB3BYPQzEkDl+BOsa4nVFQzkez7hSSiV
	EKGDWP8VxUjRvSD4yK0iipZ5K8pRelU3G7FG4FatU3ad9PMrVwynBOOprCNEEYb1SnMmQxPh78xou
	iw5kvciKg4qSUwbplo6ximwob/2Gsw8T6lv05RlbXz1FkCPvyNpoff6P9hs10JtEIvenk6PK9SXLZ
	drTfDktw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYrP-0000000FsMo-0Ae2;
	Sun, 07 Apr 2024 20:11:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Add FOP_HUGE_PAGES
Date: Sun,  7 Apr 2024 21:11:20 +0100
Message-ID: <20240407201122.3783877-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for specific file_operations, add a bit to
file_operations which denotes a file that only contain hugetlb pages.
This lets us make hugetlbfs_file_operations static, and removes
is_file_shm_hugepages() completely.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c    |  5 +++--
 include/linux/fs.h      |  2 ++
 include/linux/hugetlb.h |  8 ++------
 include/linux/shm.h     |  5 -----
 ipc/shm.c               | 10 +++-------
 5 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 2f4e88552d3f..412f295acebe 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -40,7 +40,7 @@
 #include <linux/sched/mm.h>
 
 static const struct address_space_operations hugetlbfs_aops;
-const struct file_operations hugetlbfs_file_operations;
+static const struct file_operations hugetlbfs_file_operations;
 static const struct inode_operations hugetlbfs_dir_inode_operations;
 static const struct inode_operations hugetlbfs_inode_operations;
 
@@ -1298,13 +1298,14 @@ static void init_once(void *foo)
 	inode_init_once(&ei->vfs_inode);
 }
 
-const struct file_operations hugetlbfs_file_operations = {
+static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
+	.fop_flags		= FOP_HUGE_PAGES,
 };
 
 static const struct inode_operations hugetlbfs_dir_inode_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 883b72478f61..736ffe2c6863 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2043,6 +2043,8 @@ struct file_operations {
 #define FOP_MMAP_SYNC		((__force fop_flags_t)(1 << 2))
 /* Supports non-exclusive O_DIRECT writes from multiple threads */
 #define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
+/* Contains huge pages */
+#define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bebf4c3a53ef..aaa11eeb939d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -526,17 +526,13 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 	return container_of(inode, struct hugetlbfs_inode_info, vfs_inode);
 }
 
-extern const struct file_operations hugetlbfs_file_operations;
 extern const struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 				int creat_flags, int page_size_log);
 
-static inline bool is_file_hugepages(struct file *file)
+static inline bool is_file_hugepages(const struct file *file)
 {
-	if (file->f_op == &hugetlbfs_file_operations)
-		return true;
-
-	return is_file_shm_hugepages(file);
+	return file->f_op->fop_flags & FOP_HUGE_PAGES;
 }
 
 static inline struct hstate *hstate_inode(struct inode *i)
diff --git a/include/linux/shm.h b/include/linux/shm.h
index c55bef0538e5..1d3d3ae958fb 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -16,7 +16,6 @@ struct sysv_shm {
 
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr,
 	      unsigned long shmlba);
-bool is_file_shm_hugepages(struct file *file);
 void exit_shm(struct task_struct *task);
 #define shm_init_task(task) INIT_LIST_HEAD(&(task)->sysvshm.shm_clist)
 #else
@@ -30,10 +29,6 @@ static inline long do_shmat(int shmid, char __user *shmaddr,
 {
 	return -ENOSYS;
 }
-static inline bool is_file_shm_hugepages(struct file *file)
-{
-	return false;
-}
 static inline void exit_shm(struct task_struct *task)
 {
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index a89f001a8bf0..3e3071252dac 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -662,8 +662,8 @@ static const struct file_operations shm_file_operations = {
 };
 
 /*
- * shm_file_operations_huge is now identical to shm_file_operations,
- * but we keep it distinct for the sake of is_file_shm_hugepages().
+ * shm_file_operations_huge is now identical to shm_file_operations
+ * except for fop_flags
  */
 static const struct file_operations shm_file_operations_huge = {
 	.mmap		= shm_mmap,
@@ -672,13 +672,9 @@ static const struct file_operations shm_file_operations_huge = {
 	.get_unmapped_area	= shm_get_unmapped_area,
 	.llseek		= noop_llseek,
 	.fallocate	= shm_fallocate,
+	.fop_flags	= FOP_HUGE_PAGES,
 };
 
-bool is_file_shm_hugepages(struct file *file)
-{
-	return file->f_op == &shm_file_operations_huge;
-}
-
 static const struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
-- 
2.43.0


