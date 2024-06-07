Return-Path: <linux-fsdevel+bounces-21146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D324F8FF9CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423A31F23802
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649761B800;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nbjxTO8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0F12B82
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725602; cv=none; b=OzVM7FlVao+pah9uU1tPyUf2ncwx3Ks0isnukGeWsb0WfXY6aeuwViR0SqyGM7E9/94D7oHaqxVZOOUfiTEV9h3fod36bkb+6bw16KUzNQpCXUOx2YVR1Y9Y6EF9NnEHh7mkDmxjkXTp8DDfYNemaQofJrxtf9Hjjdy/z26cqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725602; c=relaxed/simple;
	bh=8fbc7BvnZ6QCVHK9jlE1BEcyJHukkBeGKhTjxXxgFbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9mCNmmlf0PGaPqeoZeBh79pjVccFxg2vq5QPhE6mtOnqor0DDrApoIjFLgssznLMQPZhyJFQ4vXPEjgfjSXoBZfhqsRpuQMQwAz+9BkEVeRGsQ2lF9hiwAFW6+eNYQmEZ1kzaiBtu4eAGJgqbTksSOYZcFTpUFCLPiMfyie/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nbjxTO8G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5hQrezu9G7arSViZLyIRbWRWFlOIdN0GDIhUOvk1UYA=; b=nbjxTO8GHkNj0458n7aYTJLVsu
	YtpvV1B+tBpfDPqi966UaIgmqdCs0kqsVoCtCb4Zf7+XQJ+uNsuzPm7ool/YrTxSoLBb60lskM0H5
	POsdSXPFgjBqf3psdW/5yLstszBT9KjplvVJBOGIKRYzCbOG7T/lIH7doNHuy01vDj22cDGTuOgMm
	lGKt9Djth5l3dDX1iYdepzr8p8FsKPQ9hAjOmelfyy8GHq2HB0XiSA7uhBgjZOhRtME6bRuqKekcC
	4BWDL/ZWVVUZec6m/gahLXcBr0BbIKFxx8D7bAOycqLRg5DhRrbmvLI33NiEERRKGNBbz8BjYM3mO
	J4BuyOuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtb-009xC4-13;
	Fri, 07 Jun 2024 01:59:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 10/19] introduce "fd_pos" class
Date: Fri,  7 Jun 2024 02:59:48 +0100
Message-Id: <20240607015957.2372428-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdget_pos() for constructor, fdput_pos() for cleanup, users of
fd..._pos() converted.

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
index 415b509df359..6d49202e2507 100644
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
index eea0e6e9abcf..80888fa467f3 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -221,20 +221,19 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
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
 
@@ -311,7 +310,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct linux_dirent __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
 		.count = count,
@@ -319,8 +318,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -335,7 +333,6 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 
@@ -394,7 +391,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		struct linux_dirent64 __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
 		.count = count,
@@ -402,8 +399,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -419,7 +415,6 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 
@@ -479,20 +474,19 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
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
 
@@ -562,7 +556,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		struct compat_linux_dirent __user *, dirent, unsigned int, count)
 {
-	struct fd f;
+	CLASS(fd_pos, f)(fd);
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
 		.current_dir = dirent,
@@ -570,8 +564,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	};
 	int error;
 
-	f = fdget_pos(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = iterate_dir(fd_file(f), &buf.ctx);
@@ -586,7 +579,6 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		else
 			error = count - buf.count;
 	}
-	fdput_pos(f);
 	return error;
 }
 #endif
diff --git a/include/linux/file.h b/include/linux/file.h
index 6571ef345d35..847f7cb26d4a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -115,6 +115,7 @@ static inline void fdput_pos(struct fd f)
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
+DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
-- 
2.39.2


