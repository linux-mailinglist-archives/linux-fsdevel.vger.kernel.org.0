Return-Path: <linux-fsdevel+bounces-6657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D862F81B2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095A91C23ABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377B4D137;
	Thu, 21 Dec 2023 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpeQciRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EB4CB3E;
	Thu, 21 Dec 2023 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3367601a301so516960f8f.2;
        Thu, 21 Dec 2023 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152457; x=1703757257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k4ZYMkJ+9QUOJsMyCi13TT4mE1WBhCvrauTx4m46Vo=;
        b=EpeQciRRY2M/Ztvx4TcGT7mbBTbRyw2k1PiMqZqk1E1REO+z/8FmoiTlIxecDodEJ0
         u/QNnBQH/FZn7zE1QvWpjHKp/gOIE9p6XnYVy/zbfEvwLvVl0PSUPUeqDNAFvgOSe26j
         e3JUUkGK7ptCLJHReYLbKtPNX8Vmsc/mXZ63eOVSn9FGtINkRwr5RXwaxElBWQJA6hIw
         JrrEU3ZuumdPCuwGpbcLXarHNw3aU9PxySSs5RJRdMUEPk13NeB9+uz6Y5WWtrUVb5Vs
         yX5akdHBJ90285zhzivUmg3sppexyriMfueN2XjcrkDA4VCM7nzOIcdUKVxSGdNhSWBX
         pieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152457; x=1703757257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k4ZYMkJ+9QUOJsMyCi13TT4mE1WBhCvrauTx4m46Vo=;
        b=OcH4Xg/TJrq79XWLUAOZVDIgCvc6mGeXVQSmHB0bKekPqdpSLMm4nbwlMCbXs1zMgN
         0rYAhW9PGgrKvMAMLG2gFOmuZX+IX7GAim6ZDpChVptDUA8kO/p1fXROi7OeUcvQzxii
         pR14Wo0NBcbA+DgYdn2kAsGnQXK94YkVcdsGysXZ31vtbvGrju/6EyfjV+/PY9ye9T5z
         rt1D18fxLDIwOaHo6f3HJOqmnBmNFrtBFqI7WmxdxElzEWlc5fi86XPyk3HzC/vcvlAS
         dlnDajdwQZh0KSVb0hz6Iuo8zB/fhINgvv33VIDQd0acOMlKWHh4filSUzvYfirQwqIu
         cHSg==
X-Gm-Message-State: AOJu0YzV2U8VnNxXewi1UloG2Jaorct8saNde58sAy6gU4LFVr57zbcM
	0IApqmVPcBUPVaJsa+zQyX5AZcGJ+zo=
X-Google-Smtp-Source: AGHT+IF0kMK+U3D5hLdzM1cuu5x9F9D5uUmvMeYJax0L/q+gT38vxn48FJI2QJO+mEtn6J+Aw3/P+A==
X-Received: by 2002:a05:600c:3b8d:b0:40c:34f9:6c14 with SMTP id n13-20020a05600c3b8d00b0040c34f96c14mr396359wms.161.1703152456841;
        Thu, 21 Dec 2023 01:54:16 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm1628082wrq.70.2023.12.21.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:54:16 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [RFC][PATCH 2/4] fs: factor out backing_file_{read,write}_iter() helpers
Date: Thu, 21 Dec 2023 11:54:08 +0200
Message-Id: <20231221095410.801061-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221095410.801061-1-amir73il@gmail.com>
References: <20231221095410.801061-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overlayfs submits files io to backing files on other filesystems.
Factor out some common helpers to perform io to backing files, into
fs/backing-file.c.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 204 +++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 188 +++-----------------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 include/linux/backing-file.h |  15 +++
 5 files changed, 241 insertions(+), 185 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 04b33036f709..c1976ef5c210 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -2,6 +2,9 @@
 /*
  * Common helpers for stackable filesystems and backing files.
  *
+ * Forked from fs/overlayfs/file.c.
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
  * Copyright (C) 2023 CTERA Networks.
  */
 
@@ -46,3 +49,204 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 	return f;
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
+
+struct backing_aio {
+	struct kiocb iocb;
+	refcount_t ref;
+	struct kiocb *orig_iocb;
+	/* used for aio completion */
+	void (*end_write)(struct file *);
+	struct work_struct work;
+	long res;
+};
+
+static struct kmem_cache *backing_aio_cachep;
+
+#define BACKING_IOCB_MASK \
+	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
+
+static rwf_t iocb_to_rw_flags(int flags)
+{
+	return (__force rwf_t)(flags & BACKING_IOCB_MASK);
+}
+
+static void backing_aio_put(struct backing_aio *aio)
+{
+	if (refcount_dec_and_test(&aio->ref)) {
+		fput(aio->iocb.ki_filp);
+		kmem_cache_free(backing_aio_cachep, aio);
+	}
+}
+
+static void backing_aio_cleanup(struct backing_aio *aio, long res)
+{
+	struct kiocb *iocb = &aio->iocb;
+	struct kiocb *orig_iocb = aio->orig_iocb;
+
+	if (aio->end_write)
+		aio->end_write(orig_iocb->ki_filp);
+
+	orig_iocb->ki_pos = iocb->ki_pos;
+	backing_aio_put(aio);
+}
+
+static void backing_aio_rw_complete(struct kiocb *iocb, long res)
+{
+	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
+	struct kiocb *orig_iocb = aio->orig_iocb;
+
+	if (iocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(iocb);
+
+	backing_aio_cleanup(aio, res);
+	orig_iocb->ki_complete(orig_iocb, res);
+}
+
+static void backing_aio_complete_work(struct work_struct *work)
+{
+	struct backing_aio *aio = container_of(work, struct backing_aio, work);
+
+	backing_aio_rw_complete(&aio->iocb, aio->res);
+}
+
+static void backing_aio_queue_completion(struct kiocb *iocb, long res)
+{
+	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
+
+	/*
+	 * Punt to a work queue to serialize updates of mtime/size.
+	 */
+	aio->res = res;
+	INIT_WORK(&aio->work, backing_aio_complete_work);
+	queue_work(file_inode(aio->orig_iocb->ki_filp)->i_sb->s_dio_done_wq,
+		   &aio->work);
+}
+
+static int backing_aio_init_wq(struct kiocb *iocb)
+{
+	struct super_block *sb = file_inode(iocb->ki_filp)->i_sb;
+
+	if (sb->s_dio_done_wq)
+		return 0;
+
+	return sb_init_dio_done_wq(sb);
+}
+
+
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       struct backing_file_ctx *ctx)
+{
+	struct backing_aio *aio = NULL;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	old_cred = override_creds(ctx->cred);
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+	} else {
+		ret = -ENOMEM;
+		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+		if (!aio)
+			goto out;
+
+		aio->orig_iocb = iocb;
+		kiocb_clone(&aio->iocb, iocb, get_file(file));
+		aio->iocb.ki_complete = backing_aio_rw_complete;
+		refcount_set(&aio->ref, 2);
+		ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
+		backing_aio_put(aio);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio, ret);
+	}
+out:
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_read_iter);
+
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	ret = file_remove_privs(ctx->user_file);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	/*
+	 * Stacked filesystems don't support deferred completions, don't copy
+	 * this property in case it is set by the issuer.
+	 */
+	flags &= ~IOCB_DIO_CALLER_COMP;
+
+	old_cred = override_creds(ctx->cred);
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+		if (ctx->end_write)
+			ctx->end_write(ctx->user_file);
+	} else {
+		struct backing_aio *aio;
+
+		ret = backing_aio_init_wq(iocb);
+		if (ret)
+			goto out;
+
+		ret = -ENOMEM;
+		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+		if (!aio)
+			goto out;
+
+		aio->orig_iocb = iocb;
+		aio->end_write = ctx->end_write;
+		kiocb_clone(&aio->iocb, iocb, get_file(file));
+		aio->iocb.ki_flags = flags;
+		aio->iocb.ki_complete = backing_aio_queue_completion;
+		refcount_set(&aio->ref, 2);
+		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
+		backing_aio_put(aio);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio, ret);
+	}
+out:
+	revert_creds(old_cred);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_write_iter);
+
+static int __init backing_aio_init(void)
+{
+	backing_aio_cachep = kmem_cache_create("backing_aio",
+					       sizeof(struct backing_aio),
+					       0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!backing_aio_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+fs_initcall(backing_aio_init);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a6da3eaf6d4f..1b578cb27a26 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -16,19 +16,6 @@
 #include <linux/backing-file.h>
 #include "overlayfs.h"
 
-#include "../internal.h"	/* for sb_init_dio_done_wq */
-
-struct ovl_aio_req {
-	struct kiocb iocb;
-	refcount_t ref;
-	struct kiocb *orig_iocb;
-	/* used for aio completion */
-	struct work_struct work;
-	long res;
-};
-
-static struct kmem_cache *ovl_aio_request_cachep;
-
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -275,84 +262,16 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-#define OVL_IOCB_MASK \
-	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
-
-static rwf_t iocb_to_rw_flags(int flags)
-{
-	return (__force rwf_t)(flags & OVL_IOCB_MASK);
-}
-
-static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
-{
-	if (refcount_dec_and_test(&aio_req->ref)) {
-		fput(aio_req->iocb.ki_filp);
-		kmem_cache_free(ovl_aio_request_cachep, aio_req);
-	}
-}
-
-static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
-{
-	struct kiocb *iocb = &aio_req->iocb;
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	if (iocb->ki_flags & IOCB_WRITE)
-		ovl_file_modified(orig_iocb->ki_filp);
-
-	orig_iocb->ki_pos = iocb->ki_pos;
-	ovl_aio_put(aio_req);
-}
-
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
-{
-	struct ovl_aio_req *aio_req = container_of(iocb,
-						   struct ovl_aio_req, iocb);
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	if (iocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(iocb);
-
-	ovl_aio_cleanup_handler(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res);
-}
-
-static void ovl_aio_complete_work(struct work_struct *work)
-{
-	struct ovl_aio_req *aio_req = container_of(work,
-						   struct ovl_aio_req, work);
-
-	ovl_aio_rw_complete(&aio_req->iocb, aio_req->res);
-}
-
-static void ovl_aio_queue_completion(struct kiocb *iocb, long res)
-{
-	struct ovl_aio_req *aio_req = container_of(iocb,
-						   struct ovl_aio_req, iocb);
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	/*
-	 * Punt to a work queue to serialize updates of mtime/size.
-	 */
-	aio_req->res = res;
-	INIT_WORK(&aio_req->work, ovl_aio_complete_work);
-	queue_work(file_inode(orig_iocb->ki_filp)->i_sb->s_dio_done_wq,
-		   &aio_req->work);
-}
-
-static int ovl_init_aio_done_wq(struct super_block *sb)
-{
-	if (sb->s_dio_done_wq)
-		return 0;
-
-	return sb_init_dio_done_wq(sb);
-}
-
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct fd real;
-	const struct cred *old_cred;
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(file)->i_sb),
+		.user_file = file,
+		.accessed = ovl_file_accessed,
+	};
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -361,37 +280,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(iocb->ki_flags);
-
-		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos, rwf);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-		refcount_set(&aio_req->ref, 2);
-		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup_handler(aio_req);
-	}
-out:
-	revert_creds(old_cred);
-	ovl_file_accessed(file);
-out_fdput:
+	ret = backing_file_read_iter(real.file, iter, iocb, iocb->ki_flags,
+				     &ctx);
 	fdput(real);
 
 	return ret;
@@ -402,9 +292,13 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(inode->i_sb),
+		.user_file = file,
+		.end_write = ovl_file_modified,
+	};
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -412,19 +306,11 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	inode_lock(inode);
 	/* Update mode */
 	ovl_copyattr(inode);
-	ret = file_remove_privs(file);
-	if (ret)
-		goto out_unlock;
 
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		goto out_unlock;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
@@ -433,39 +319,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(ifl);
-
-		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos, rwf);
-		/* Update size */
-		ovl_file_modified(file);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = ovl_init_aio_done_wq(inode->i_sb);
-		if (ret)
-			goto out;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_flags = ifl;
-		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
-		refcount_set(&aio_req->ref, 2);
-		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup_handler(aio_req);
-	}
-out:
-	revert_creds(old_cred);
-out_fdput:
+	ret = backing_file_write_iter(real.file, iter, iocb, ifl, &ctx);
 	fdput(real);
 
 out_unlock:
@@ -777,19 +631,3 @@ const struct file_operations ovl_file_operations = {
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 };
-
-int __init ovl_aio_request_cache_init(void)
-{
-	ovl_aio_request_cachep = kmem_cache_create("ovl_aio_req",
-						   sizeof(struct ovl_aio_req),
-						   0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ovl_aio_request_cachep)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void ovl_aio_request_cache_destroy(void)
-{
-	kmem_cache_destroy(ovl_aio_request_cachep);
-}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 05c3dd597fa8..5ba11eb43767 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -425,6 +425,12 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+
+static inline const struct cred *ovl_creds(struct super_block *sb)
+{
+	return OVL_FS(sb)->creator_cred;
+}
+
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
 bool ovl_index_all(struct super_block *sb);
@@ -837,8 +843,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
-int __init ovl_aio_request_cache_init(void);
-void ovl_aio_request_cache_destroy(void);
 int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
 int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
 int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1d6b98dd9003..8ac4726795ce 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1500,14 +1500,10 @@ static int __init ovl_init(void)
 	if (ovl_inode_cachep == NULL)
 		return -ENOMEM;
 
-	err = ovl_aio_request_cache_init();
-	if (!err) {
-		err = register_filesystem(&ovl_fs_type);
-		if (!err)
-			return 0;
+	err = register_filesystem(&ovl_fs_type);
+	if (!err)
+		return 0;
 
-		ovl_aio_request_cache_destroy();
-	}
 	kmem_cache_destroy(ovl_inode_cachep);
 
 	return err;
@@ -1523,7 +1519,6 @@ static void __exit ovl_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(ovl_inode_cachep);
-	ovl_aio_request_cache_destroy();
 }
 
 module_init(ovl_init);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 55c9e804f780..0648d548a418 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -9,9 +9,24 @@
 #define _LINUX_BACKING_FILE_H
 
 #include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/fs.h>
+
+struct backing_file_ctx {
+	const struct cred *cred;
+	struct file *user_file;
+	void (*accessed)(struct file *);
+	void (*end_write)(struct file *);
+};
 
 struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       struct backing_file_ctx *ctx);
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


