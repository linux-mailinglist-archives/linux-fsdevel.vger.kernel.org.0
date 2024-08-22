Return-Path: <linux-fsdevel+bounces-26590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F995A8BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D001B21446
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5712B64;
	Thu, 22 Aug 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m/ww943d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25076320B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286175; cv=none; b=BWgz4OMISZN5HsfhBZOPTepIuKnmZ24GRN6XxQUoD6fTILfy0XM4gSB+pcT3OpQdilAjr0CyCksN1GAMnq7hdMbT3K06NTPC37wXVo/2goQ60T1npHSYIAeCQVsB6jwf5daBkR4ncaYKCWS4fs3bmsZirgfZ1zLdo7HYAo8iWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286175; c=relaxed/simple;
	bh=vZNZV/4OLDXQ2Fk/8oT+WLSO+yjULwF+NFxG/C3s/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjQ5CWtjZfeiylMM7B/XAHRxkC/8Pfw4SsefsIWgu5Sp4scO5bp4GrcTY1X99SX8IzJUws5IG5sHeWiduZqLjwv1n36+Dm5cyhiRHaEKzLYZMaqC6io4ry6PfID8JlVVgrDWo2XWq452qWG9HJ0SAr/mnyV6hq/0FZiCmvAH3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m/ww943d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pziBuNjCDZIQ4PmsoZL4n2VKnFalxwY2gcOm8FzBHUQ=; b=m/ww943dRmvWQxF+nPv+/NKlfp
	KfFAfR7YHZEOuMiuSJYLMzgHiEVAQbjLeYe4QrxNchKtjs79ezJM2gL/LLP+9vMSdSNIM6neBeVi0
	67KeYBUFN0GHLRtyrgxRomfT2ksNV5Hh9dU8IUG0UcuMl+luEBbhuOb49tVpiNs8V7V9sQg3XwR0v
	92i26w0kaqhs+UEPgZMqnAlkvMAYk/wbDI2sPapKrs+bf971hfjEzVUmBnGsvaEVWyz/zuL2Ri061
	txcLEniw2DvB8w/64YhTRVcsJjtXSKbZBkD/mQCKyzOBqqyPrWMIgrPeli7NEAwtmX0D/w2bBg01Z
	cNR/UtKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbG-00000003w7Z-2VAO;
	Thu, 22 Aug 2024 00:22:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 02/12] get rid of ...lookup...fdget_rcu() family
Date: Thu, 22 Aug 2024 01:22:40 +0100
Message-ID: <20240822002250.938396-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Once upon a time, predecessors of those used to do file lookup
without bumping a refcount, provided that caller held rcu_read_lock()
across the lookup and whatever it wanted to read from the struct
file found.  When struct file allocation switched to SLAB_TYPESAFE_BY_RCU,
that stopped being feasible and these primitives started to bump the
file refcount for lookup result, requiring the caller to call fput()
afterwards.

But that turned them pointless - e.g.
	rcu_read_lock();
	file = lookup_fdget_rcu(fd);
	rcu_read_unlock();
is equivalent to
	file = fget_raw(fd);
and all callers of lookup_fdget_rcu() are of that form.  Similarly,
task_lookup_fdget_rcu() calls can be replaced with calling fget_task().
task_lookup_next_fdget_rcu() doesn't have direct counterparts, but
its callers would be happier if we replaced it with an analogue that
deals with RCU internally.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |  4 +--
 fs/file.c                                    | 28 +++-----------------
 fs/gfs2/glock.c                              | 12 ++-------
 fs/notify/dnotify/dnotify.c                  |  5 +---
 fs/proc/fd.c                                 | 12 +++------
 include/linux/fdtable.h                      |  4 ---
 include/linux/file.h                         |  1 +
 kernel/bpf/task_iter.c                       |  6 +----
 kernel/kcmp.c                                |  4 +--
 9 files changed, 14 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 18daafbe2e65..301ee7d8b7df 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -73,9 +73,7 @@ static struct spu_context *coredump_next_context(int *fd)
 		return NULL;
 	*fd = n - 1;
 
-	rcu_read_lock();
-	file = lookup_fdget_rcu(*fd);
-	rcu_read_unlock();
+	file = fget_raw(*fd);
 	if (file) {
 		ctx = SPUFS_I(file_inode(file))->i_ctx;
 		get_spu_context(ctx);
diff --git a/fs/file.c b/fs/file.c
index c2403cde40e4..8c5b8569045c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1037,29 +1037,7 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
-struct file *lookup_fdget_rcu(unsigned int fd)
-{
-	return __fget_files_rcu(current->files, fd, 0);
-
-}
-EXPORT_SYMBOL_GPL(lookup_fdget_rcu);
-
-struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd)
-{
-	/* Must be called with rcu_read_lock held */
-	struct files_struct *files;
-	struct file *file = NULL;
-
-	task_lock(task);
-	files = task->files;
-	if (files)
-		file = __fget_files_rcu(files, fd, 0);
-	task_unlock(task);
-
-	return file;
-}
-
-struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *ret_fd)
+struct file *fget_task_next(struct task_struct *task, unsigned int *ret_fd)
 {
 	/* Must be called with rcu_read_lock held */
 	struct files_struct *files;
@@ -1069,17 +1047,19 @@ struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *
 	task_lock(task);
 	files = task->files;
 	if (files) {
+		rcu_read_lock();
 		for (; fd < files_fdtable(files)->max_fds; fd++) {
 			file = __fget_files_rcu(files, fd, 0);
 			if (file)
 				break;
 		}
+		rcu_read_unlock();
 	}
 	task_unlock(task);
 	*ret_fd = fd;
 	return file;
 }
-EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
+EXPORT_SYMBOL(fget_task_next);
 
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 12a769077ea0..a4f5940c3e0a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -34,7 +34,6 @@
 #include <linux/lockref.h>
 #include <linux/rhashtable.h>
 #include <linux/pid_namespace.h>
-#include <linux/fdtable.h>
 #include <linux/file.h>
 
 #include "gfs2.h"
@@ -2765,25 +2764,18 @@ static struct file *gfs2_glockfd_next_file(struct gfs2_glockfd_iter *i)
 		i->file = NULL;
 	}
 
-	rcu_read_lock();
 	for(;; i->fd++) {
-		struct inode *inode;
-
-		i->file = task_lookup_next_fdget_rcu(i->task, &i->fd);
+		i->file = fget_task_next(i->task, &i->fd);
 		if (!i->file) {
 			i->fd = 0;
 			break;
 		}
 
-		inode = file_inode(i->file);
-		if (inode->i_sb == i->sb)
+		if (file_inode(i->file)->i_sb == i->sb)
 			break;
 
-		rcu_read_unlock();
 		fput(i->file);
-		rcu_read_lock();
 	}
-	rcu_read_unlock();
 	return i->file;
 }
 
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index f3669403fabf..65521c01d2a4 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -16,7 +16,6 @@
 #include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/fdtable.h>
 #include <linux/fsnotify_backend.h>
 
 static int dir_notify_enable __read_mostly = 1;
@@ -343,9 +342,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		new_fsn_mark = NULL;
 	}
 
-	rcu_read_lock();
-	f = lookup_fdget_rcu(fd);
-	rcu_read_unlock();
+	f = fget_raw(fd);
 
 	/* if (f != filp) means that we lost a race and another task/thread
 	 * actually closed the fd we are still playing with before we grabbed
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 586bbc84ca04..077c51ba1ba7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -116,9 +116,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 {
 	struct file *file;
 
-	rcu_read_lock();
-	file = task_lookup_fdget_rcu(task, fd);
-	rcu_read_unlock();
+	file = fget_task(task, fd);
 	if (file) {
 		*mode = file->f_mode;
 		fput(file);
@@ -258,19 +256,17 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	if (!dir_emit_dots(file, ctx))
 		goto out;
 
-	rcu_read_lock();
 	for (fd = ctx->pos - 2;; fd++) {
 		struct file *f;
 		struct fd_data data;
 		char name[10 + 1];
 		unsigned int len;
 
-		f = task_lookup_next_fdget_rcu(p, &fd);
+		f = fget_task_next(p, &fd);
 		ctx->pos = fd + 2LL;
 		if (!f)
 			break;
 		data.mode = f->f_mode;
-		rcu_read_unlock();
 		fput(f);
 		data.fd = fd;
 
@@ -278,11 +274,9 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		if (!proc_fill_cache(file, ctx,
 				     name, len, instantiate, p,
 				     &data))
-			goto out;
+			break;
 		cond_resched();
-		rcu_read_lock();
 	}
-	rcu_read_unlock();
 out:
 	put_task_struct(p);
 	return 0;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index b1c5722f2b3c..e25e2cb65d30 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -92,10 +92,6 @@ static inline struct file *files_lookup_fd_locked(struct files_struct *files, un
 	return files_lookup_fd_raw(files, fd);
 }
 
-struct file *lookup_fdget_rcu(unsigned int fd);
-struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd);
-struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *fd);
-
 static inline bool close_on_exec(unsigned int fd, const struct files_struct *files)
 {
 	return test_bit(fd, files_fdtable(files)->close_on_exec);
diff --git a/include/linux/file.h b/include/linux/file.h
index 237931f20739..006005f621d1 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -51,6 +51,7 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
+extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
 extern unsigned long __fdget_pos(unsigned int fd);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 02aa9db8d796..7fe602ca74a0 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -5,7 +5,6 @@
 #include <linux/namei.h>
 #include <linux/pid_namespace.h>
 #include <linux/fs.h>
-#include <linux/fdtable.h>
 #include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
@@ -286,17 +285,14 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 			curr_fd = 0;
 	}
 
-	rcu_read_lock();
-	f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
+	f = fget_task_next(curr_task, &curr_fd);
 	if (f) {
 		/* set info->fd */
 		info->fd = curr_fd;
-		rcu_read_unlock();
 		return f;
 	}
 
 	/* the current task is done, go to the next task */
-	rcu_read_unlock();
 	put_task_struct(curr_task);
 
 	if (info->common.type == BPF_TASK_ITER_TID) {
diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index b0639f21041f..2c596851f8a9 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -63,9 +63,7 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 {
 	struct file *file;
 
-	rcu_read_lock();
-	file = task_lookup_fdget_rcu(task, idx);
-	rcu_read_unlock();
+	file = fget_task(task, idx);
 	if (file)
 		fput(file);
 
-- 
2.39.2


