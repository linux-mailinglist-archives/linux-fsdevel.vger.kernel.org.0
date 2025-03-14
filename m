Return-Path: <linux-fsdevel+bounces-44097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07CA62099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930F27AB7DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4C1E98F2;
	Fri, 14 Mar 2025 22:39:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9261917E4;
	Fri, 14 Mar 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991964; cv=none; b=p7ckAeCImZPb2+zuqhwNXqSIvhcRJjxb0zkC1XKU+VV4bpBcbmEO7TfgINgOi8/rsKUCQS4BtGUGxSHupDhCC9lVwA7wR9OHlhSN3TpDYXVhj91AhQMzh8pxgN//I64ynbWmfA3osvqMbrksC5jH9XjGxSfgh6Gqk57HYH2KBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991964; c=relaxed/simple;
	bh=AvMCZODPqyEqxenkJhT0T087QAYlL6u5xgFwjjn4G58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8iS3G7XF/IJKNUiqyMuBgxH2YveHqfw0B85kzB6tsH1EUBleFbg3c6gliR+OuFamSx6oKsGMkB7aFA8I8kCyrUViVQEI65WViD5tkLRsxkA1X8n5rdvCBLEd5LoJm9fMPHYtTQKT6vi8sh8Xci/yu4WX0a0jbkqkiy5CYW2AwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.1.104] (helo=plastiekpoot)
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDL0-000000005rG-0V1C;
	Sat, 15 Mar 2025 00:17:06 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDKx-000000003kk-2tYI;
	Sat, 15 Mar 2025 00:17:03 +0200
From: Jaco Kroon <jaco@uls.co.za>
To: jaco@uls.co.za
Cc: bernd.schubert@fastmail.fm,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	rdunlap@infradead.org,
	trapexit@spawn.link
Subject: [PATCH 1/2] fs: Supply dir_context.count as readdir buffer size hint
Date: Sat, 15 Mar 2025 00:16:27 +0200
Message-ID: <20250314221701.12509-2-jaco@uls.co.za>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314221701.12509-1-jaco@uls.co.za>
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

This was provided by Miklos <miklos@szeredi.hu> via LKML on 2023/07/27
subject "Re: [PATCH] fuse: enable larger read buffers for readdir.".

This is thus preperation for an improved fuse readdir() patch.  The
description he provided:

"The best strategy would be to find the optimal buffer size based on the size of
the userspace buffer.  Putting that info into struct dir_context doesn't sound
too complicated...

"Here's a patch.  It doesn't touch readdir.  Simply setting the fuse buffer size
to the userspace buffer size should work, the record sizes are similar (fuse's
is slightly larger than libc's, so no overflow should ever happen)."

Author: Mikros Szeredi <miklos@szeredi.hu>
Signed-off-by: Jaco Kroon <jaco@uls.co.za>
---
 fs/exportfs/expfs.c    |  1 +
 fs/overlayfs/readdir.c | 12 +++++++++++-
 fs/readdir.c           | 31 +++++++++++++++----------------
 include/linux/fs.h     | 19 +++++++++++++------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0c899cfba578..2015eea19097 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -286,6 +286,7 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 	};
 	struct getdents_callback buffer = {
 		.ctx.actor = filldir_one,
+		.ctx.count = INT_MAX,
 		.name = name,
 	};
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 881ec5592da5..126c797751e9 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -351,6 +351,7 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 	struct path realpath;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_merge,
+		.ctx.count = INT_MAX,
 		.dentry = dentry,
 		.list = list,
 		.root = root,
@@ -571,6 +572,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	struct ovl_cache_entry *p, *n;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = list,
 		.root = root,
 	};
@@ -672,6 +674,7 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 	struct ovl_readdir_translate *rdt =
 		container_of(ctx, struct ovl_readdir_translate, ctx);
 	struct dir_context *orig_ctx = rdt->orig_ctx;
+	bool res;
 
 	if (rdt->parent_ino && strcmp(name, "..") == 0) {
 		ino = rdt->parent_ino;
@@ -686,7 +689,10 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 					  name, namelen, rdt->xinowarn);
 	}
 
-	return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
+	res = orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
+	ctx->count = orig_ctx->count;
+
+	return res;
 }
 
 static bool ovl_is_impure_dir(struct file *file)
@@ -713,6 +719,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
+		.ctx.count = ctx->count,
 		.orig_ctx = ctx,
 		.xinobits = ovl_xino_bits(ofs),
 		.xinowarn = ovl_xino_warn(ofs),
@@ -1073,6 +1080,7 @@ int ovl_check_d_type_supported(const struct path *realpath)
 	int err;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_check_d_type,
+		.ctx.count = INT_MAX,
 		.d_type_supported = false,
 	};
 
@@ -1094,6 +1102,7 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	struct ovl_cache_entry *p;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = &list,
 	};
 	bool incompat = false;
@@ -1178,6 +1187,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	struct ovl_cache_entry *p;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = &list,
 	};
 
diff --git a/fs/readdir.c b/fs/readdir.c
index 0038efda417b..90049075a2aa 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -222,6 +222,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct readdir_callback buf = {
 		.ctx.actor = fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -239,7 +240,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 
 /*
  * New, all-improved, singing, dancing, iBCS2-compliant getdents()
- * interface. 
+ * interface.
  */
 struct linux_dirent {
 	unsigned long	d_ino;
@@ -252,7 +253,6 @@ struct getdents_callback {
 	struct dir_context ctx;
 	struct linux_dirent __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -271,7 +271,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -296,7 +296,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -311,7 +311,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -329,7 +329,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
@@ -338,7 +338,6 @@ struct getdents_callback64 {
 	struct dir_context ctx;
 	struct linux_dirent64 __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -356,7 +355,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	prev_reclen = buf->prev_reclen;
 	if (prev_reclen && signal_pending(current))
@@ -376,7 +375,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 
 efault_end:
@@ -392,7 +391,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -411,7 +410,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		if (put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
@@ -475,6 +474,7 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct compat_readdir_callback buf = {
 		.ctx.actor = compat_fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -499,7 +499,6 @@ struct compat_getdents_callback {
 	struct dir_context ctx;
 	struct compat_linux_dirent __user *current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -518,7 +517,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -542,7 +541,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -557,8 +556,8 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
+		.ctx.count = count,
 		.current_dir = dirent,
-		.count = count
 	};
 	int error;
 
@@ -575,7 +574,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2788df98080f..1e426e2b5999 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -308,7 +308,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -318,7 +318,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ * 			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -1151,8 +1151,8 @@ struct file *get_file_active(struct file **f);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/* Page cache limit. The filesystems should put that into their s_maxbytes
+   limits, otherwise bad things can happen in VM. */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2073,6 +2073,13 @@ typedef bool (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
 struct dir_context {
 	filldir_t actor;
 	loff_t pos;
+	/*
+	 * Filesystems MUST NOT MODIFY count, but may use as a hint:
+	 * 0	    unknown
+	 * > 0      space in buffer (assume at least one entry)
+	 * INT_MAX  unlimited
+	 */
+	int count;
 };
 
 /*
@@ -2609,7 +2616,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -3189,7 +3196,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
-- 
2.48.1


