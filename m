Return-Path: <linux-fsdevel+bounces-33516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE929B9CE6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2DF282D90
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5A16130C;
	Sat,  2 Nov 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BuD4km0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F091494C3;
	Sat,  2 Nov 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524112; cv=none; b=sxwqwXNJFzIy0T/YDRjDjq0R6IZ23dZa7KVztf4qDG5QBNMVcnRfrR40vFEy28eN+RxbcCes1KHZyhWvIGc+6Tu/diQgw1eAyaSe1oYpo2FnBDd2uxG+twoLdF5JdJvcySd/dK0Oeuj/emTQHg5QuW92CT6GCYGXheqrmkG8I/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524112; c=relaxed/simple;
	bh=AQ8OCwSUShVUrvIDtivh1DD7a16QhAptrvprbnf7X5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCajkhAZZcNXkork5xyQw+iE6OLaK7DFrNm4buw0StYUnpdPIH/a32R+tdYYgYrUi8acJHdRmYwu5kxIw60FTnxLdBPXALucJp6uBTAPNXbVLYgjv/+gF5ehWZI2sPOI3nm7E8d32LuScf0iioX6+aMh8NBxbjs8xFbNMGDkoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BuD4km0B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I8hquyXn1/m8swv7wjUgDJO2YHt5RlgtWbjHnCU6gG8=; b=BuD4km0BjXhsg9hzzxNKsmOeO5
	JJzkSi9b6812UjNzYpuT8uymZbNulqaf3FKcRda8Ot9DmMOS5egMKd2rUyWO3DBmpyu9PR+B1mlB/
	pHl84uhV5MLcK4GhjcyMQQnZ50hmnVRT51f8Dvi+bhZiTcyyR55bBl+pHvUuP8dfuPabpNgid1cua
	S7aZ/hyk+krtdGXypxQA+JAZVT3lwEbOTkYExVDVdqDImrnyTvyS7OBmyxhQk4cXVWajYK9Blbf69
	WO7M8htPw3BEmh7jLPcTiViIhZM6BqE0nPqm+P1VqL4Je1F/G94uxy0AuriQvLMkdQZdjWXgg2ZC5
	lFKS6PDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHml-2XVJ;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 11/28] introduce "fd_pos" class, convert fdget_pos() users to it.
Date: Sat,  2 Nov 2024 05:08:09 +0000
Message-ID: <20241102050827.2451599-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdget_pos() for constructor, fdput_pos() for cleanup, all users of
fd..._pos() converted trivially.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/osf_sys.c |  5 ++---
 fs/read_write.c             | 34 +++++++++++++---------------------
 fs/readdir.c                | 28 ++++++++++------------------
 include/linux/file.h        |  1 +
 4 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index c0424de9e7cd..86185021f75a 100644
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
index 64dc24afdb3a..ef3ee3725714 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -386,8 +386,8 @@ EXPORT_SYMBOL(vfs_llseek);
 static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	off_t retval;
-	struct fd f = fdget_pos(fd);
-	if (!fd_file(f))
+	CLASS(fd_pos, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	retval = -EINVAL;
@@ -397,7 +397,6 @@ static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
-	fdput_pos(f);
 	return retval;
 }
 
@@ -420,15 +419,14 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
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
@@ -439,8 +437,6 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		if (!copy_to_user(result, &offset, sizeof(offset)))
 			retval = 0;
 	}
-out_putf:
-	fdput_pos(f);
 	return retval;
 }
 #endif
@@ -700,10 +696,10 @@ static inline loff_t *file_ppos(struct file *file)
 
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
@@ -712,7 +708,6 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 		ret = vfs_read(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 	return ret;
 }
@@ -724,10 +719,10 @@ SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 
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
@@ -736,7 +731,6 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 		ret = vfs_write(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 
 	return ret;
@@ -1075,10 +1069,10 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
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
@@ -1087,7 +1081,6 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 		ret = vfs_readv(fd_file(f), vec, vlen, ppos, flags);
 		if (ret >= 0 && ppos)
 			fd_file(f)->f_pos = pos;
-		fdput_pos(f);
 	}
 
 	if (ret > 0)
@@ -1099,10 +1092,10 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
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
@@ -1111,7 +1104,6 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
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
index b49a92295b3f..4b09a8de2fd5 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -81,6 +81,7 @@ static inline void fdput_pos(struct fd f)
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
+DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
-- 
2.39.5


