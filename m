Return-Path: <linux-fsdevel+bounces-32463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF009A63A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC21C21C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9B1EBA01;
	Mon, 21 Oct 2024 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj4IPv5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB31E570D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506831; cv=none; b=Ak3jZ6eDbKYW6E09oOUQT55mLPDJFttPS9mw5I+hYTGex5C0KFNypnHu8CKyZ09EwR49+VH3MGZTvMKiYBPtchbFYddiNP/O2UE+lFVNVZE4ni8Jn9it2r0UR0U3WtV0JcdsPWvEmzElHzNkHcbU9eXSkGx22trw4IQGXfaPKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506831; c=relaxed/simple;
	bh=cefhr9/rt98W0iSS9lMbJ00cj5AUFW5dP47CLzGi3Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSIqj5TJtevGJGzk5tm8nTF/KlOlz2kau+kyEf7teFHd0BUOVSEtPvro+9sO2vhiGy+k+3DZEVI5Rkw2+bd2lzYcgdznBBDPjq2YJmNDkwlD/GeRPj/AIpX86+03UycuNtCjAQAfOEFZIG2OgmsWLuZVBv+T7ytnD1718BdMzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vj4IPv5j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729506827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KDkPFQytbxQUHWycOjrRp0rxxf/wEHNTIPWcOumTl5M=;
	b=Vj4IPv5jxWmlYQcbAYWMQu4tQotfHBpUFo60gPnb4qWjqjtUohyv4xhMlTSzPybIfZ9CZ7
	CpWlbyW6lBAnEjbSPZJImvg8uRzbnVazhMJt27wNbOFGfTUsi3Qjio1884S0NnyGvEOPPb
	gJKZc28Lm8UPG2FN+NyN4Q/yQsNjfTQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-l1jNKXQTPHGgq230vSN8uQ-1; Mon, 21 Oct 2024 06:33:46 -0400
X-MC-Unique: l1jNKXQTPHGgq230vSN8uQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43159c07193so38232885e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 03:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506825; x=1730111625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDkPFQytbxQUHWycOjrRp0rxxf/wEHNTIPWcOumTl5M=;
        b=TzRCWb7uIStfEkfXpzJ1a1CBu/KvE8G6aPm+4zIupmoAFqYvMpuvp5K5f5YZGG9rKU
         e4jZq0fm0ajIR1L1CK0KtXlgeadkAcrpvmYqhPLQyfqBj9WuMFi5nVLpcujOgmXnMd+q
         FE5cdJ4LgbJxmmU/mFSsT5WYHieXHULGDSwPLz/VVKPmgey76OkjNhR4p2pPdS6l790q
         Z05qoeV4zo9PhJqZsJjgnm9y5Emwveav9D4spSAlywBqn1D03fOpoxYXPqXTg1hRqEuM
         m/hKHsUcO21uPK4DfzxAJ6N6LZ1GTAoP+TaxwiXAxQX9WgpwlgC/DsHm8SxkNNckomyZ
         pZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxBm9npS3uwuCjnNjAzp7swazQpmZjtOES9YisPFpX0Ti84oTRV//TDFy/KrbTpdyMScGKGM7h144v0Mxh@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/rRhpqq0Y6GseX19C575zexpHDNBhWMX9ZGkP6b5GPcFiWwd
	XQjbN3Ku2KEwyy8vcGDvJaBFdUQc6FfllmQNsEIWlXZB9z+g/tZnESNH6p+CapkiFmkKq6jMegh
	mQ9dKI5xUDKk0Fl/dpWrJX3vTA8U5kmuqtSiSWpvyHfcMuoJsftiKavstvfTysKE=
X-Received: by 2002:adf:facb:0:b0:37d:53d1:84f2 with SMTP id ffacd0b85a97d-37ea21c3ac9mr9953483f8f.11.1729506824723;
        Mon, 21 Oct 2024 03:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRKaccL38kL95FgjaM6LH4UpW770qRU65jy8v+DvRiLWDOI1atFu/0qor28Z8lVcm/ZwLLXQ==
X-Received: by 2002:adf:facb:0:b0:37d:53d1:84f2 with SMTP id ffacd0b85a97d-37ea21c3ac9mr9953413f8f.11.1729506823005;
        Mon, 21 Oct 2024 03:33:43 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-214-118.pool.digikabel.hu. [193.226.214.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706d3sm188119266b.134.2024.10.21.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:33:42 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] backing-file: clean up the API
Date: Mon, 21 Oct 2024 12:33:38 +0200
Message-ID: <20241021103340.260731-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Pass iocb to ctx->end_write() instead of file + pos

 - Get rid of ctx->user_file, which is redundant most of the time

 - Instead pass iocb to backing_file_splice_read and
   backing_file_splice_write

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
    Pass ioctb to backing_file_splice_{read|write}()

Applies on fuse.git#for-next.

 fs/backing-file.c            | 33 ++++++++++++++++-----------------
 fs/fuse/passthrough.c        | 32 ++++++++++++++++++--------------
 fs/overlayfs/file.c          | 22 +++++++++++++---------
 include/linux/backing-file.h | 11 +++++------
 4 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 09a9be945d45..a38737592ec7 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -80,7 +80,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
-	void (*end_write)(struct file *, loff_t, ssize_t);
+	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
 };
@@ -108,10 +108,10 @@ static void backing_aio_cleanup(struct backing_aio *aio, long res)
 	struct kiocb *iocb = &aio->iocb;
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
+	orig_iocb->ki_pos = iocb->ki_pos;
 	if (aio->end_write)
-		aio->end_write(orig_iocb->ki_filp, iocb->ki_pos, res);
+		aio->end_write(orig_iocb, res);
 
-	orig_iocb->ki_pos = iocb->ki_pos;
 	backing_aio_put(aio);
 }
 
@@ -200,7 +200,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	revert_creds(old_cred);
 
 	if (ctx->accessed)
-		ctx->accessed(ctx->user_file);
+		ctx->accessed(iocb->ki_filp);
 
 	return ret;
 }
@@ -219,7 +219,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = file_remove_privs(ctx->user_file);
+	ret = file_remove_privs(iocb->ki_filp);
 	if (ret)
 		return ret;
 
@@ -239,7 +239,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 
 		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
 		if (ctx->end_write)
-			ctx->end_write(ctx->user_file, iocb->ki_pos, ret);
+			ctx->end_write(iocb, ret);
 	} else {
 		struct backing_aio *aio;
 
@@ -270,7 +270,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
 
-ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
@@ -282,19 +282,19 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 		return -EIO;
 
 	old_cred = override_creds(ctx->cred);
-	ret = vfs_splice_read(in, ppos, pipe, len, flags);
+	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
 	revert_creds(old_cred);
 
 	if (ctx->accessed)
-		ctx->accessed(ctx->user_file);
+		ctx->accessed(iocb->ki_filp);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(backing_file_splice_read);
 
 ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
-				  struct file *out, loff_t *ppos, size_t len,
-				  unsigned int flags,
+				  struct file *out, struct kiocb *iocb,
+				  size_t len, unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
 	const struct cred *old_cred;
@@ -306,18 +306,18 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (!out->f_op->splice_write)
 		return -EINVAL;
 
-	ret = file_remove_privs(ctx->user_file);
+	ret = file_remove_privs(iocb->ki_filp);
 	if (ret)
 		return ret;
 
 	old_cred = override_creds(ctx->cred);
 	file_start_write(out);
-	ret = out->f_op->splice_write(pipe, out, ppos, len, flags);
+	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
 	file_end_write(out);
 	revert_creds(old_cred);
 
 	if (ctx->end_write)
-		ctx->end_write(ctx->user_file, ppos ? *ppos : 0, ret);
+		ctx->end_write(iocb, ret);
 
 	return ret;
 }
@@ -329,8 +329,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	const struct cred *old_cred;
 	int ret;
 
-	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
-	    WARN_ON_ONCE(ctx->user_file != vma->vm_file))
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
 		return -EIO;
 
 	if (!file->f_op->mmap)
@@ -343,7 +342,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	revert_creds(old_cred);
 
 	if (ctx->accessed)
-		ctx->accessed(ctx->user_file);
+		ctx->accessed(vma->vm_file);
 
 	return ret;
 }
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index bbac547dfcb3..607ef735ad4a 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -18,11 +18,11 @@ static void fuse_file_accessed(struct file *file)
 	fuse_invalidate_atime(inode);
 }
 
-static void fuse_passthrough_end_write(struct file *file, loff_t pos, ssize_t ret)
+static void fuse_passthrough_end_write(struct kiocb *iocb, ssize_t ret)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 
-	fuse_write_update_attr(inode, pos, ret);
+	fuse_write_update_attr(inode, iocb->ki_pos, ret);
 }
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
@@ -34,7 +34,6 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
-		.user_file = file,
 		.accessed = fuse_file_accessed,
 	};
 
@@ -62,7 +61,6 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
-		.user_file = file,
 		.end_write = fuse_passthrough_end_write,
 	};
 
@@ -88,15 +86,20 @@ ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
 	struct file *backing_file = fuse_file_passthrough(ff);
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
-		.user_file = in,
 		.accessed = fuse_file_accessed,
 	};
+	struct kiocb iocb;
+	ssize_t ret;
 
 	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
-		 backing_file, ppos ? *ppos : 0, len, flags);
+		 backing_file, *ppos, len, flags);
 
-	return backing_file_splice_read(backing_file, ppos, pipe, len, flags,
-					&ctx);
+	init_sync_kiocb(&iocb, in);
+	iocb.ki_pos = *ppos;
+	ret = backing_file_splice_read(backing_file, &iocb, pipe, len, flags, &ctx);
+	*ppos = iocb.ki_pos;
+
+	return ret;
 }
 
 ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
@@ -109,16 +112,18 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
-		.user_file = out,
 		.end_write = fuse_passthrough_end_write,
 	};
+	struct kiocb iocb;
 
 	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
-		 backing_file, ppos ? *ppos : 0, len, flags);
+		 backing_file, *ppos, len, flags);
 
 	inode_lock(inode);
-	ret = backing_file_splice_write(pipe, backing_file, ppos, len, flags,
-					&ctx);
+	init_sync_kiocb(&iocb, out);
+	iocb.ki_pos = *ppos;
+	ret = backing_file_splice_write(pipe, backing_file, &iocb, len, flags, &ctx);
+	*ppos = iocb.ki_pos;
 	inode_unlock(inode);
 
 	return ret;
@@ -130,7 +135,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	struct file *backing_file = fuse_file_passthrough(ff);
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
-		.user_file = file,
 		.accessed = fuse_file_accessed,
 	};
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4444c78e2e0c..12c4d502ff91 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -231,9 +231,9 @@ static void ovl_file_modified(struct file *file)
 	ovl_copyattr(file_inode(file));
 }
 
-static void ovl_file_end_write(struct file *file, loff_t pos, ssize_t ret)
+static void ovl_file_end_write(struct kiocb *iocb, ssize_t ret)
 {
-	ovl_file_modified(file);
+	ovl_file_modified(iocb->ki_filp);
 }
 
 static void ovl_file_accessed(struct file *file)
@@ -271,7 +271,6 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
-		.user_file = file,
 		.accessed = ovl_file_accessed,
 	};
 
@@ -298,7 +297,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	int ifl = iocb->ki_flags;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
-		.user_file = file,
 		.end_write = ovl_file_end_write,
 	};
 
@@ -338,15 +336,18 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(in)->i_sb),
-		.user_file = in,
 		.accessed = ovl_file_accessed,
 	};
+	struct kiocb iocb;
 
 	ret = ovl_real_fdget(in, &real);
 	if (ret)
 		return ret;
 
-	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
+	init_sync_kiocb(&iocb, in);
+	iocb.ki_pos = *ppos;
+	ret = backing_file_splice_read(fd_file(real), &iocb, pipe, len, flags, &ctx);
+	*ppos = iocb.ki_pos;
 	fdput(real);
 
 	return ret;
@@ -368,9 +369,9 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	ssize_t ret;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
-		.user_file = out,
 		.end_write = ovl_file_end_write,
 	};
+	struct kiocb iocb;
 
 	inode_lock(inode);
 	/* Update mode */
@@ -380,9 +381,13 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	if (ret)
 		goto out_unlock;
 
-	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
+	init_sync_kiocb(&iocb, out);
+	iocb.ki_pos = *ppos;
+	ret = backing_file_splice_write(pipe, fd_file(real), &iocb, len, flags, &ctx);
+	*ppos = iocb.ki_pos;
 	fdput(real);
 
+
 out_unlock:
 	inode_unlock(inode);
 
@@ -420,7 +425,6 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	struct file *realfile = file->private_data;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
-		.user_file = file,
 		.accessed = ovl_file_accessed,
 	};
 
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 2eed0ffb5e8f..1476a6ed1bfd 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -14,9 +14,8 @@
 
 struct backing_file_ctx {
 	const struct cred *cred;
-	struct file *user_file;
-	void (*accessed)(struct file *);
-	void (*end_write)(struct file *, loff_t, ssize_t);
+	void (*accessed)(struct file *file);
+	void (*end_write)(struct kiocb *iocb, ssize_t);
 };
 
 struct file *backing_file_open(const struct path *user_path, int flags,
@@ -31,13 +30,13 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx);
-ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx);
 ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
-				  struct file *out, loff_t *ppos, size_t len,
-				  unsigned int flags,
+				  struct file *out, struct kiocb *iocb,
+				  size_t len, unsigned int flags,
 				  struct backing_file_ctx *ctx);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx);
-- 
2.47.0


