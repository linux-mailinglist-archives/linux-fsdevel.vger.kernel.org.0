Return-Path: <linux-fsdevel+bounces-48905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD11AB581C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B1C1B4360D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9628E5EC;
	Tue, 13 May 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmR7DopI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252128F514
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149022; cv=none; b=gXf5wSNgXSglKUoazWBKH14w9vlhRcIPqCfQzg+yFHUikxV6CQ041gNW5d/y0rN37briwmdrntZDBAgYhyvYIMCBkMHtzECOzd8yRrAp1ehymi04BBpvZJwXCiwc3Xs+n5mqnKjdUVlZYkK37t0tr91ks8wLpIxTJ8fQ4PkoQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149022; c=relaxed/simple;
	bh=r2d5naLLd/IUBTs31nKPcKJVevfy1hGpxiRckmnNos4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNMU/z528wl03exkXNwFsjoVzWQ2piJN/WTFpiMPV08oRlEp3pUDFFTMHwcokzH4n1/LAn/XfQwAyTuX+R2eSplswkl6m7NUvLP8fpVipZ9/01dGKPqtXGMG6jUBhXATZdsEgwtRNmuoA6BN4h1mQ9ZAhqPH3JYgMFkvBndtsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmR7DopI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747149018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HTJNJGBP9JyRNuGleDgl/Rzy8x5c+65rfXcszwAK3/w=;
	b=FmR7DopIX5O2jMkNnz6G3/46UgsvP0I5tKZClyrXrGBZXUKIDWaUdIsxUqiguQMkeOCBhj
	7x/plZBd6FUj3ZwhNETeNcLwELtlu1GYAOWxynQ9Jh5AP4nBD1ntH0oYdd2jyvGahMJZNp
	ayV8/7YOQOWRo2p/IIxRS80GQ9Lm2PU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-BMIyhOQEO_iYiZj_GMT7gg-1; Tue, 13 May 2025 11:10:17 -0400
X-MC-Unique: BMIyhOQEO_iYiZj_GMT7gg-1
X-Mimecast-MFC-AGG-ID: BMIyhOQEO_iYiZj_GMT7gg_1747149016
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5fca9e8375cso3785909a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747149015; x=1747753815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTJNJGBP9JyRNuGleDgl/Rzy8x5c+65rfXcszwAK3/w=;
        b=YhCioMu3z721AVwn9MUUXNpRKqMeP5xQRdnqlwXiz0FuniG7w8wBwH6wbHmS8MWfgp
         U5649aRcCp/5DvqU7x45f6m6XQBxShSKhYSwSACAh/ZKexxNm/cimKTdHnDK4Dpt11o4
         1Jpb8wN0oby88dQ6Zr0UQhAMBqcZtQWCht+lj9PKkUKxvzYkIrRARQv6hXSbJv3aMQ6s
         dSJ+oDs3s3cKfXBezYbelOWLka/CT2E6TeqTqrVHCkM5eJzr3BCRNh/oh+wsYknw3+76
         xXOmpJ2n9U8VULLbMpBqw/dykE3dJMjhuWAEPHwwLc+is1yZZT9gyGrStkFGG+KdvLyH
         oNCA==
X-Gm-Message-State: AOJu0Yz3uO8LRtzWJa7ErgTI0mhzvZ8u3p5b9GwNmFqH9ITJqB3zdLWd
	qA2i0pJmwbx3144AJpTfbsu+aZ3jtDZa1MtKpkqERPXWtqG1FrYtvf0EJeey7dZs042yLzs6Gam
	nPVGP3jSXFF+uHOMJ/58PSYALjxyZXbd0BBUcKFTXu5tVwnPhKpvBPiigAooNousjDQRUDoJrq9
	leOfX1xAXpP/zvLB+9FTYXinO0fvusJi+pvkN9f0o8QDb7JMmqbw==
X-Gm-Gg: ASbGnctkdBCnoG8ewNx3ux7pc04oBapQ9I3FvrvAXMdxDo9iaKJmDIGrNLZXn4RNSPs
	dzgz1EpsVsi/1sKrJot0N59qr1evJM5JKT0mOsvKt2C8DESY4t8W9bUqXzhkUd13HqyxW2ANSG1
	/rnrOUI4cPfEd05LB0n+WEW3TX0pZpNtUPZkwjC4bd+0+C+JzPoXNb0eg2s9g7zLXcgLiEEPgJJ
	eAm3hnmio4TngeY4ws031JuKaGzQq+bOmZfSz4MqDxyYcvmD39sRZXvx+JFntk1K0rYVH9Px8XM
	54xluobLmbzUvtHoXOZ7fFLimwKnLXaBI/sF3uxvs9TXTJxdtpazhgfCBXD7JLE=
X-Received: by 2002:a05:6402:40cc:b0:5e6:17e6:9510 with SMTP id 4fb4d7f45d1cf-5fca0730860mr14889773a12.6.1747149015348;
        Tue, 13 May 2025 08:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9S+2cW69mveJ56zhAOL6xn++lzvNf44tP4E16YUkg5eeC/q+lupdb5qYTtl0fzVQeKDCHjA==
X-Received: by 2002:a05:6402:40cc:b0:5e6:17e6:9510 with SMTP id 4fb4d7f45d1cf-5fca0730860mr14889719a12.6.1747149014620;
        Tue, 13 May 2025 08:10:14 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (91-82-178-33.pool.digikabel.hu. [91.82.178.33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fd1950e6dbsm4791375a12.80.2025.05.13.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:10:14 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jaco Kroon <jaco@uls.co.za>
Subject: [PATCH] readdir: supply dir_context.count as readdir buffer size hint
Date: Tue, 13 May 2025 17:10:08 +0200
Message-ID: <20250513151012.1476536-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation for large readdir buffers in fuse.

Simply setting the fuse buffer size to the userspace buffer size should
work, the record sizes are similar (fuse's is slightly larger than libc's,
so no overflow should ever happen).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Jaco Kroon <jaco@uls.co.za>
---
 fs/exportfs/expfs.c    |  1 +
 fs/overlayfs/readdir.c | 12 +++++++++++-
 fs/readdir.c           | 29 ++++++++++++++---------------
 include/linux/fs.h     |  7 +++++++
 4 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 128dd092916b..48f0c505b50f 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -284,6 +284,7 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
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
index 857d402bc531..7764b8638978 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -222,6 +222,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct readdir_callback buf = {
 		.ctx.actor = fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -252,7 +253,6 @@ struct getdents_callback {
 	struct dir_context ctx;
 	struct linux_dirent __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -275,7 +275,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -300,7 +300,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -315,7 +315,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -333,7 +333,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
@@ -342,7 +342,6 @@ struct getdents_callback64 {
 	struct dir_context ctx;
 	struct linux_dirent64 __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -364,7 +363,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	prev_reclen = buf->prev_reclen;
 	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
@@ -384,7 +383,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 
 efault_end:
@@ -400,7 +399,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -419,7 +418,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		if (put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
@@ -483,6 +482,7 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct compat_readdir_callback buf = {
 		.ctx.actor = compat_fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -507,7 +507,6 @@ struct compat_getdents_callback {
 	struct dir_context ctx;
 	struct compat_linux_dirent __user *current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -530,7 +529,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -554,7 +553,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -569,8 +568,8 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	CLASS(fd_pos, f)(fd);
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
+		.ctx.count = count,
 		.current_dir = dirent,
-		.count = count
 	};
 	int error;
 
@@ -587,7 +586,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	return error;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0f2a1a572e3a..dfc5a3327124 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2071,6 +2071,13 @@ typedef bool (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
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
 
 /* If OR-ed with d_type, pending signals are not checked */
-- 
2.49.0


