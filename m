Return-Path: <linux-fsdevel+bounces-24552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69994072B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939A91F2370B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F2195380;
	Tue, 30 Jul 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpUf/K+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749C194C76;
	Tue, 30 Jul 2024 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316505; cv=none; b=TB40OMMhSRsG2vUaNxWCe3mtGMl9i6gePY8+KzCxi+fMC8TrCxOMPJTPxzldLE1eYS8xPjSdJGdAbXZqqeOzN1YstBVu8Vwzv7UjivMcl6v2++2DWh7P/xWoNL3GErKuPqLzHrVEUMTNDlLJE5rr1RJnmKofHzh7L21aSVpgplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316505; c=relaxed/simple;
	bh=l3O87FdfOjLuZ8CwEqQhN3fTHBkrzqpDT28oFGVW2Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9qZupDBs1DtXFQR1+RqfKdCeqDVvVC19+XwrF542AqW0blLgj4bTcXxAZG5VCt8fDNj9wGHnUdMyJzWZUB3fqLvyWrGNQhkh4GTQTxYD1V+VlK7TjPq0gGq+usGa06GuxuZnJWygFTKkHpoH/vIIXiDQLyzZrAf2Cuxt3jpl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpUf/K+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82B9C4AF0C;
	Tue, 30 Jul 2024 05:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316505;
	bh=l3O87FdfOjLuZ8CwEqQhN3fTHBkrzqpDT28oFGVW2Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpUf/K+uN7KK+WUnEht33s938Pyg+LmxVc+YqFzmaqjzdg7RYnSN1//OOvAy8e+Qe
	 bNjGd+dStZCID6/wpGgGnmxv2Wv1YvyewBTC3vUyTe9/tMh8SNb6ro6FuGl+SyDNtn
	 qmpytH5+WsAoUXDwvclqNrrg9GrJ7VIFChSkCF/DpwkAmfFEqRDxRMuiFrw7AKkOcY
	 lNf0tn43wVtVHh8o4DRpyj3Gw0l79Cc90Vx+O+NzVPxaAJBTlPuYsNXHd238rFvaKA
	 jhurrqIf7UQ+c+bL3yQpXR76LXZmSDf8Bka2gVgtjcSil/JrqXs4ddhR0Hr50Bu+3t
	 F/LUADSUTGFNw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 20/39] introduce "fd_pos" class, convert fdget_pos() users to it.
Date: Tue, 30 Jul 2024 01:16:06 -0400
Message-Id: <20240730051625.14349-20-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

fdget_pos() for constructor, fdput_pos() for cleanup, all users of
fd..._pos() converted trivially.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/osf_sys.c |  5 ++---
 fs/read_write.c             | 34 +++++++++++++---------------------
 fs/readdir.c                | 28 ++++++++++------------------
 include/linux/file.h        |  1 +
 4 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 56fea57f9642..09d82f0963d0 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -152,7 +152,7 @@ SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
 		long __user *, basep)
 {
 	int error;
-	struct fd arg = fdget_pos(fd);
+	CLASS(fd_pos, arg)(fd);
 	struct osf_dirent_callback buf = {
 		.ctx.actor = osf_filldir,
 		.dirent = dirent,
@@ -160,7 +160,7 @@ SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
 		.count = count
 	};
 
-	if (!fd_file(arg))
+	if (fd_empty(arg))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(arg), &buf.ctx);
@@ -169,7 +169,6 @@ SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
 	if (count != buf.count)
 		error = count - buf.count;
 
-	fdput_pos(arg);
 	return error;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 59d6d0dee579..7e5a2e50e12b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -293,8 +293,8 @@ EXPORT_SYMBOL(vfs_llseek);
 static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	off_t retval;
-	struct fd f = fdget_pos(fd);
-	if (!fd_file(f))
+	CLASS(fd_pos, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	retval = -EINVAL;
@@ -304,7 +304,6 @@ static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
-	fdput_pos(f);
 	return retval;
 }
 
@@ -327,15 +326,14 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned int, whence)
 {
 	int retval;
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	loff_t offset;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	retval = -EINVAL;
 	if (whence > SEEK_MAX)
-		goto out_putf;
+		return -EINVAL;
 
 	offset = vfs_llseek(fd_file(f), ((loff_t) offset_high << 32) | offset_low,
 			whence);
@@ -346,8 +344,6 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		if (!copy_to_user(result, &offset, sizeof(offset)))
 			retval = 0;
 	}
-out_putf:
-	fdput_pos(f);
 	return retval;
 }
 #endif
@@ -607,10 +603,10 @@ static inline loff_t *file_ppos(struct file *file)
 
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 {
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
-	if (fd_file(f)) {
+	if (!fd_empty(f)) {
 		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
@@ -619,7 +615,6 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 		ret = vfs_read(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 	return ret;
 }
@@ -631,10 +626,10 @@ SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 {
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
-	if (fd_file(f)) {
+	if (!fd_empty(f)) {
 		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
@@ -643,7 +638,6 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 		ret = vfs_write(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 
 	return ret;
@@ -982,10 +976,10 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 			unsigned long vlen, rwf_t flags)
 {
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
-	if (fd_file(f)) {
+	if (!fd_empty(f)) {
 		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
@@ -994,7 +988,6 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 		ret = vfs_readv(fd_file(f), vec, vlen, ppos, flags);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 
 	if (ret > 0)
@@ -1006,10 +999,10 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, rwf_t flags)
 {
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
-	if (fd_file(f)) {
+	if (!fd_empty(f)) {
 		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
@@ -1018,7 +1011,6 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 		ret = vfs_writev(fd_file(f), vec, vlen, ppos, flags);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 
 	if (ret > 0)
diff --git a/fs/readdir.c b/fs/readdir.c
index 6d29cab8576e..0038efda417b 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -219,20 +219,19 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 		struct old_linux_dirent __user *, dirent, unsigned int, count)
 {
 	int error;
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	struct readdir_callback buf = {
 		.ctx.actor = fillonedir,
 		.dirent = dirent
 	};
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (buf.result)
 		error = buf.result;
 
-	fdput_pos(f);
 	return error;
 }
 
@@ -309,7 +308,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct linux_dirent __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
 		.count = count,
@@ -317,8 +316,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -333,7 +331,6 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 
@@ -392,7 +389,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		struct linux_dirent64 __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
 		.count = count,
@@ -400,8 +397,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -417,7 +413,6 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 
@@ -477,20 +472,19 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 		struct compat_old_linux_dirent __user *, dirent, unsigned int, count)
 {
 	int error;
-	struct fd f = fdget_pos(fd);
+	CLASS(fd_pos, f)(fd);
 	struct compat_readdir_callback buf = {
 		.ctx.actor = compat_fillonedir,
 		.dirent = dirent
 	};
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (buf.result)
 		error = buf.result;
 
-	fdput_pos(f);
 	return error;
 }
 
@@ -560,7 +554,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct compat_linux_dirent __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
 		.current_dir = dirent,
@@ -568,8 +562,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -584,7 +577,6 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 #endif
diff --git a/include/linux/file.h b/include/linux/file.h
index d3165d7a8112..2a0f4e13e1af 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -108,6 +108,7 @@ static inline void fdput_pos(struct fd f)
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
+DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
-- 
2.39.2


