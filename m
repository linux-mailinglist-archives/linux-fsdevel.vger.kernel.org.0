Return-Path: <linux-fsdevel+bounces-10479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A284B7C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8592728C04D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1291132C0D;
	Tue,  6 Feb 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWorjpzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50076132C0A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229510; cv=none; b=FD27uzFJJdDfDDEo2nwq7o8w2/vU95QXNtmN1FgDsMAkV+wrItAMfIOoaJrhGrJSmpFB2/S+nNdzl9+zVz3nOhJ5IN/Nq54QW4JwiN4kyS2OY6Y/Wy0YLRePFzIUwFq5t4ApKAs8pxEt4044hkbMOprDfIhp+mASvVv3N0sS9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229510; c=relaxed/simple;
	bh=P+btxCY7RSVXwfrXfDOZGKZUmiasY3ovEnSE8AP6xmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Smq8Jzt8vZnROQkAwKRAuAaG3VZKoAeCKzIP6exjdH2Yo7X0//2N5ydTl2zeM/uHPlOv0G7D9FYkU8epHSOB+B9hytbDTDoKWspgtDJyjgx7Ah+3ZCztioCbYqIK0+N3eB4Mb7qo6yXhhVbuHzAojq6fkIIvj6gkMCaKuSxsS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWorjpzX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc654a718so37166715e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229506; x=1707834306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCKsYMVjhCqPV/y73w6CgCE26tRKOupMcaRLuTEMIAU=;
        b=YWorjpzXzEnh/75gWq5Yez7+5rKJv+nUHCDhKoMP6n/h3QUDuOIz3DW8ihBzUSFLXU
         DaznF02SOfesG40J8uC/T/Gk8lBMP8JQWsl4ao03XiJ/1nG6FxHNXc9+eXo8YaHZehBB
         c/pnDxg9uEA/yWzC0VXgc4L5h/UktK1jvWsj0bLU/KgNndB63f0wkqv6qy9m9pEEAAI6
         4RFU8i+ndS+lmqa3Vpt6kF3tu+KrJsVA5T/p79w2P6FMShHvu7lG7n7Jnpd3iPVxOz2y
         pYX1sXRAL9QMm3D3wlPoCYQiIbMdW3MFYwrFX5ZS+2xqOfGhZekWp8OPclPRe1Ef4AB9
         pIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229506; x=1707834306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCKsYMVjhCqPV/y73w6CgCE26tRKOupMcaRLuTEMIAU=;
        b=C0RcP/9YAXsMNB2UAnSK7yeu1Bk+VEuf4/cSgwXdhhvNimygMJtWZvNLhtxz4viZOJ
         Y3Jt6fUtgEhAZounH4wKU5AQWQm5+OEzDekqKjDvtMmcy3HfK8vCLv01cfTDT0BkmtUs
         QvOypUtRlxENQ+wjYbtL5zeexWf0sKGysSWmSR+j8Usf0XGnuf15jP7clSr/zeuKjtJc
         ffNEqeShXaI9PQe7C544O+4ueos6rTWQHZbVe6mT8rkE3DO4mJ+Zgb6H5hfNPMdSAQHK
         4C0CtH3Ep83qt2WneJEWrLh6HFh/cK3uPOCXfVQuKhhx/N1VFLuhmJTOsUO9fdavxuNI
         M47g==
X-Gm-Message-State: AOJu0Yy8rLV/KAHxJCT+N2W238TfMsAfW3eYZr6ERWalzvMosx92kvv+
	k4AY2RpbB+CZ9ZCSIiKHJk31rt0qI5Kg6o+vtPQPoaeEWNR+R3IX5LvHXRRA
X-Google-Smtp-Source: AGHT+IEMcxil83lH0Bvl1Ymn4wI9PF6EyIF1KuMAzUh60TtxLBF0ClOiYfMK/jHL0aAnj0w/IHU0nQ==
X-Received: by 2002:a5d:47c2:0:b0:33b:481e:8ddd with SMTP id o2-20020a5d47c2000000b0033b481e8dddmr1805367wrc.62.1707229506234;
        Tue, 06 Feb 2024 06:25:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgg1gZtAyewyLmbTv7miB8+Ktdo/QP0JhL9xDF1syzUlSG2zlPTB7Ddq8U0rKfph4FfkzG5B8g/Oh3wFEWl/SL/cTD1pC+g34uhtFMFA==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:05 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 5/9] fuse: implement open in passthrough mode
Date: Tue,  6 Feb 2024 16:24:49 +0200
Message-Id: <20240206142453.1906268-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142453.1906268-1-amir73il@gmail.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After getting a backing file id with FUSE_DEV_IOC_BACKING_OPEN ioctl,
a FUSE server can reply to an OPEN request with flag FOPEN_PASSTHROUGH
and the backing file id.

The FUSE server should reuse the same backing file id for all the open
replies of the same FUSE inode and open will fail (with -EIO) if a the
server attempts to open the same inode with conflicting io modes or to
setup passthrough to two different backing files for the same FUSE inode.
Using the same backing file id for several different inodes is allowed.

Opening a new file with FOPEN_DIRECT_IO for an inode that is already
open for passthrough is allowed, but only if the FOPEN_PASSTHROUGH flag
and correct backing file id are specified as well.

The read/write IO of such files will not use passthrough operations to
the backing file, but mmap, which does not support direct_io, will use
the backing file insead of using the page cache as it always did.

Even though all FUSE passthrough files of the same inode use the same
backing file as a backing inode reference, each FUSE file opens a unique
instance of a backing_file object to store the FUSE path that was used
to open the inode and the open flags of the specific open file.

The per-file, backing_file object is released along with the FUSE file.
The inode associated fuse_backing object is released when the last FUSE
passthrough file of that inode is released AND when the backing file id
is closed by the server using the FUSE_DEV_IOC_BACKING_CLOSE ioctl.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        |  9 ++++++-
 fs/fuse/fuse_i.h      | 35 ++++++++++++++++++++++++-
 fs/fuse/iomode.c      | 51 ++++++++++++++++++++++++++++++++-----
 fs/fuse/passthrough.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 04be04b6b2af..bdcee82fef9a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -295,6 +295,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = &ff->args->release_args;
 
+	if (fuse_file_passthrough(ff))
+		fuse_passthrough_release(ff, fuse_inode_backing(fi));
+
 	/* Inode is NULL on error path of fuse_create_open() */
 	if (likely(fi)) {
 		spin_lock(&fi->lock);
@@ -1372,7 +1375,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 		 * have raced, so check it again.
 		 */
 		if (fuse_io_past_eof(iocb, from) ||
-		    fuse_file_uncached_io_start(inode) != 0) {
+		    fuse_file_uncached_io_start(inode, NULL) != 0) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
@@ -2522,6 +2525,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	/* TODO: implement mmap to backing file */
+	if (fuse_file_passthrough(ff))
+		return -ENODEV;
+
 	/*
 	 * FOPEN_DIRECT_IO handling is special compared to O_DIRECT,
 	 * as does not allow MAP_SHARED mmap without FUSE_DIRECT_IO_ALLOW_MMAP.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index eea8f1ffc766..407b24c79ebb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -266,6 +266,12 @@ struct fuse_file {
 	/** Wait queue head for poll */
 	wait_queue_head_t poll_wait;
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	/** Reference to backing file in passthrough mode */
+	struct file *passthrough;
+	const struct cred *cred;
+#endif
+
 	/** Has flock been performed on this file? */
 	bool flock:1;
 
@@ -1398,7 +1404,7 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 /* iomode.c */
 int fuse_file_cached_io_start(struct inode *inode);
 void fuse_file_cached_io_end(struct inode *inode);
-int fuse_file_uncached_io_start(struct inode *inode);
+int fuse_file_uncached_io_start(struct inode *inode, struct fuse_backing *fb);
 void fuse_file_uncached_io_end(struct inode *inode);
 
 int fuse_file_io_open(struct file *file, struct inode *inode);
@@ -1431,11 +1437,38 @@ static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
 #endif
 }
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
+#else
+
+static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
+{
+	return NULL;
+}
+
+static inline void fuse_backing_put(struct fuse_backing *fb)
+{
+}
+#endif
+
 void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
+struct fuse_backing *fuse_passthrough_open(struct file *file,
+					   struct inode *inode,
+					   int backing_id);
+void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb);
+
+static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return ff->passthrough;
+#else
+	return NULL;
+#endif
+}
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 48105f3c00f6..dce369f3b201 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -115,13 +115,24 @@ void fuse_file_cached_io_end(struct inode *inode)
 }
 
 /* Start strictly uncached io mode where cache access is not allowed */
-int fuse_file_uncached_io_start(struct inode *inode)
+int fuse_file_uncached_io_start(struct inode *inode, struct fuse_backing *fb)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int err;
+	struct fuse_backing *oldfb;
+	int err = -EBUSY;
 
 	spin_lock(&fi->lock);
-	err = fuse_inode_deny_io_cache(fi);
+	/* deny conflicting backing files on same fuse inode */
+	oldfb = fuse_inode_backing(fi);
+	if (!oldfb || oldfb == fb)
+		err = fuse_inode_deny_io_cache(fi);
+	/* fuse inode holds a single refcount of backing file */
+	if (!oldfb && !err) {
+		oldfb = fuse_inode_backing_set(fi, fb);
+		WARN_ON_ONCE(oldfb != NULL);
+	} else if (!err) {
+		fuse_backing_put(fb);
+	}
 	spin_unlock(&fi->lock);
 	return err;
 }
@@ -129,13 +140,18 @@ int fuse_file_uncached_io_start(struct inode *inode)
 void fuse_file_uncached_io_end(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *oldfb = NULL;
 	int uncached_io;
 
 	spin_lock(&fi->lock);
 	uncached_io = fuse_inode_allow_io_cache(fi);
+	if (!uncached_io)
+		oldfb = fuse_inode_backing_set(fi, NULL);
 	spin_unlock(&fi->lock);
 	if (!uncached_io)
 		wake_up(&fi->direct_io_waitq);
+	if (oldfb)
+		fuse_backing_put(oldfb);
 }
 
 /*
@@ -153,6 +169,7 @@ static int fuse_file_passthrough_open(struct file *file, struct inode *inode)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_backing *fb;
 	int err;
 
 	/* Check allowed conditions for file open in passthrough mode */
@@ -160,11 +177,18 @@ static int fuse_file_passthrough_open(struct file *file, struct inode *inode)
 	    (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
 		return -EINVAL;
 
-	/* TODO: implement backing file open */
-	return -EOPNOTSUPP;
+	fb = fuse_passthrough_open(file, inode,
+				   ff->args->open_outarg.backing_id);
+	if (IS_ERR(fb))
+		return PTR_ERR(fb);
 
 	/* First passthrough file open denies caching inode io mode */
-	err = fuse_file_uncached_io_start(inode);
+	err = fuse_file_uncached_io_start(inode, fb);
+	if (!err)
+		return 0;
+
+	fuse_passthrough_release(ff, fb);
+	fuse_backing_put(fb);
 
 	return err;
 }
@@ -177,6 +201,7 @@ static int fuse_file_passthrough_open(struct file *file, struct inode *inode)
 int fuse_file_io_open(struct file *file, struct inode *inode)
 {
 	struct fuse_file *ff = file->private_data;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	int iomode_flags = ff->open_flags & FOPEN_IO_MODE_MASK;
 	int err;
 
@@ -199,6 +224,13 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 		return 0;
 	}
 
+	/*
+	 * Server is expected to use FOPEN_PASSTHROUGH for all opens of an inode
+	 * which is already open for passthrough.
+	 */
+	if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
+		goto fail;
+
 	/*
 	 * FOPEN_CACHE_IO is an internal flag that is set on file not open in
 	 * direct io or passthrough mode and it cannot be set by the server.
@@ -271,9 +303,14 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
 	if (!ff->io_opened)
 		return;
 
-	/* Last caching file close exits caching inode io mode */
+	/*
+	 * Last caching file close allows passthrough open of inode and
+	 * Last passthrough file close allows caching open of inode.
+	 */
 	if (ff->open_flags & FOPEN_CACHE_IO)
 		fuse_file_cached_io_end(inode);
+	else if (ff->open_flags & FOPEN_PASSTHROUGH)
+		fuse_file_uncached_io_end(inode);
 
 	ff->io_opened = false;
 }
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 6604d414adb5..098a1f765e99 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -8,6 +8,7 @@
 #include "fuse_i.h"
 
 #include <linux/file.h>
+#include <linux/backing-file.h>
 
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
@@ -163,3 +164,61 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 
 	return err;
 }
+
+/*
+ * Setup passthrough to a backing file.
+ *
+ * Returns an fb object with elevated refcount to be stored in fuse inode.
+ */
+struct fuse_backing *fuse_passthrough_open(struct file *file,
+					   struct inode *inode,
+					   int backing_id)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = ff->fm->fc;
+	struct fuse_backing *fb = NULL;
+	struct file *backing_file;
+	int err;
+
+	err = -EINVAL;
+	if (backing_id <= 0)
+		goto out;
+
+	rcu_read_lock();
+	fb = idr_find(&fc->backing_files_map, backing_id);
+	fb = fuse_backing_get(fb);
+	rcu_read_unlock();
+
+	err = -ENOENT;
+	if (!fb)
+		goto out;
+
+	/* Allocate backing file per fuse file to store fuse path */
+	backing_file = backing_file_open(&file->f_path, file->f_flags,
+					 &fb->file->f_path, fb->cred);
+	err = PTR_ERR(backing_file);
+	if (IS_ERR(backing_file)) {
+		fuse_backing_put(fb);
+		goto out;
+	}
+
+	err = 0;
+	ff->passthrough = backing_file;
+	ff->cred = get_cred(fb->cred);
+out:
+	pr_debug("%s: backing_id=%d, fb=0x%p, backing_file=0x%p, err=%i\n", __func__,
+		 backing_id, fb, ff->passthrough, err);
+
+	return err ? ERR_PTR(err) : fb;
+}
+
+void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
+{
+	pr_debug("%s: fb=0x%p, backing_file=0x%p\n", __func__,
+		 fb, ff->passthrough);
+
+	fput(ff->passthrough);
+	ff->passthrough = NULL;
+	put_cred(ff->cred);
+	ff->cred = NULL;
+}
-- 
2.34.1


