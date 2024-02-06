Return-Path: <linux-fsdevel+bounces-10477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FF84B7C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26889B2729C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402B132C04;
	Tue,  6 Feb 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyOwe3/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4973195
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229507; cv=none; b=o6Icl/JgWhulqh5UV6VqiSMfZi+MadFniTE8cNSjtNmH1rixLAD6aoZaIYFJHf/+PkxDAwJfeZAu0Qrdc+QE/XpZXrRrnN6hvm7EzAFzJ6LJdxi5QE9pWj+WD1KidJEx6I2VgAyPh4PVRaiSdjeTz2BBYPi3Dlq20x97iQAwe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229507; c=relaxed/simple;
	bh=/M/pX7CFZkwNXJJ7l9gZf0aR4nyGhj52ycL2nycezDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kM2hPeMiSMUBT/8eTrQR1yPNst6hlslFqdojraesFEfHUyYrwK1abk1ogHtb08szkh2qzSVMqUlkg1b+kKtkxlicql2HzErrTRyV34L9rPHbZEK95O33NH+83J3nLvDBR+2LawqffntqoADxOrfuyFadUU5oZZrr3WS3aNvxXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyOwe3/P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso1311340f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229503; x=1707834303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka/d4U+hcRjXP9iCEYKjVzOWDDwWPs33Is0BPjiquDE=;
        b=YyOwe3/PmHGXhPO1dtfWAb475x9k7Aq5ZcDM3RMk84aWOEwfAyW7gkjS4lU0yMxpVM
         DomrKEq80VdXs1fzSUEUjCsmCwa8q2scDfuh0Uev1bH/J+IN8q6KGEnsCBwdStPpfgQ6
         9q2iy6GSflbSAxEEN4U0so/TCa+JF6DXKm9O/VNFtuofvPpFT1s2ZJCTT6MZ9k37NWZ4
         qIAviJaybUGeaNbb49yYdTSLCA7AVTv7uy3mFz0TJbp+upt1HdTok4kVhY+fu5/jSa0i
         hB4cBywVYwootn3VBastBAJV2wPy3u5hBgxbsuLfTTinQPCqZE4vt2SIf9sOV3p7i4sN
         ecpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229503; x=1707834303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka/d4U+hcRjXP9iCEYKjVzOWDDwWPs33Is0BPjiquDE=;
        b=uJZfbG1aOs0Sgdv/tbKTkCkWWfLRweBeFoUu1bKVM844+45y4Q6Qwrec5ZrJfoa+We
         TO8r0DwtjQ3UHcm5ePDkLYz+G9Fz9T2L35ctabj9Jv1jaWK116Ad/ESJhPB0NNd8Bm8M
         Fz8+8cFVCXZ/jxet4QYm9aaG1tVViPv61qwD/8I+l8VW5lg0zUrHRrptbLHp1ojYYAIa
         6OB08O6QjklFskdHt4ax9ctcVQODGd2p63wNTpCTGW1NKF6nNB9A1u4yQYWMtXzhWO6F
         a/u+vguufHsRcT7FPUFEdCuaNClWPXQz+eiqzmex4t0lsFvoRs9XbBKffQbqWZVwYwk8
         XGJA==
X-Gm-Message-State: AOJu0YxpKgMza9HqwjC1WgU8H3Dw7lWFuETNGCZ3PTOmqveW5RRahhPJ
	YP74Vjv2qR9rLKAjI566M+zbGayr/nlYcJfFYZniPb1VPczEDy1Wm/adM0Vc
X-Google-Smtp-Source: AGHT+IGFJxNsYzNfATqdCMuY5p0AWlmuCi2qdSoPhX1X2jU9ZGXkyc6mU88sv1SyPl/U+/qCM3Aymg==
X-Received: by 2002:adf:f410:0:b0:33b:3fe8:6413 with SMTP id g16-20020adff410000000b0033b3fe86413mr1601538wro.27.1707229503145;
        Tue, 06 Feb 2024 06:25:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnzAD1eK/+eCXs18Pr5SQqhA01qYvSjsCocqA/AVw1rFAjMt1BsQjbvksnLQr16z349GxrYSfSCeaJen2mqlyTeSFHrzQZoPFZoTBp3ZkC+P+sL0VoE7JqqtUMDjIbtRQ+2w==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:02 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Alessio Balsini <balsini@android.com>
Subject: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Date: Tue,  6 Feb 2024 16:24:47 +0200
Message-Id: <20240206142453.1906268-4-amir73il@gmail.com>
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

FUSE server calls the FUSE_DEV_IOC_BACKING_OPEN ioctl with a backing file
descriptor.  If the call succeeds, a backing file identifier is returned.

A later change will be using this backing file id in a reply to OPEN
request with the flag FOPEN_PASSTHROUGH to setup passthrough of file
operations on the open FUSE file to the backing file.

The FUSE server should call FUSE_DEV_IOC_BACKING_CLOSE ioctl to close the
backing file by its id.

This can be done at any time, but if an open reply with FOPEN_PASSTHROUGH
flag is still in progress, the open may fail if the backing file is
closed before the fuse file was opened.

Setting up backing files requires a server with CAP_SYS_ADMIN privileges.
For the backing file to be successfully setup, the backing file must
implement both read_iter and write_iter file operations.

The limitation on the level of filesystem stacking allowed for the
backing file is enforced before setting up the backing file.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dev.c             |  41 ++++++++++++
 fs/fuse/fuse_i.h          |  10 +++
 fs/fuse/inode.c           |   5 ++
 fs/fuse/passthrough.c     | 135 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   9 +++
 5 files changed, 200 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eba68b57bd7c..b680787bd66d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2283,6 +2283,41 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	return res;
 }
 
+static long fuse_dev_ioctl_backing_open(struct file *file,
+					struct fuse_backing_map __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing_map map;
+
+	if (!fud)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&map, argp, sizeof(map)))
+		return -EFAULT;
+
+	return fuse_backing_open(fud->fc, &map);
+}
+
+static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	int backing_id;
+
+	if (!fud)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	if (get_user(backing_id, argp))
+		return -EFAULT;
+
+	return fuse_backing_close(fud->fc, backing_id);
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2292,6 +2327,12 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_CLONE:
 		return fuse_dev_ioctl_clone(file, argp);
 
+	case FUSE_DEV_IOC_BACKING_OPEN:
+		return fuse_dev_ioctl_backing_open(file, argp);
+
+	case FUSE_DEV_IOC_BACKING_CLOSE:
+		return fuse_dev_ioctl_backing_close(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cae525147856..fb9ef02cbf45 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -79,6 +79,7 @@ struct fuse_submount_lookup {
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
+	struct cred *cred;
 
 	/** refcount */
 	refcount_t count;
@@ -897,6 +898,11 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	/** IDR for backing files ids */
+	struct idr backing_files_map;
+#endif
 };
 
 /*
@@ -1414,5 +1420,9 @@ static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
 
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
+void fuse_backing_files_init(struct fuse_conn *fc);
+void fuse_backing_files_free(struct fuse_conn *fc);
+int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
+int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c771bd3c1336..c26a84439934 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -930,6 +930,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
 
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_init(fc);
+
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
@@ -1392,6 +1395,8 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_free(fc);
 	kfree_rcu(fc, rcu);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index e8639c0a9ac6..6604d414adb5 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -18,8 +18,11 @@ struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 
 static void fuse_backing_free(struct fuse_backing *fb)
 {
+	pr_debug("%s: fb=0x%p\n", __func__, fb);
+
 	if (fb->file)
 		fput(fb->file);
+	put_cred(fb->cred);
 	kfree_rcu(fb, rcu);
 }
 
@@ -28,3 +31,135 @@ void fuse_backing_put(struct fuse_backing *fb)
 	if (fb && refcount_dec_and_test(&fb->count))
 		fuse_backing_free(fb);
 }
+
+void fuse_backing_files_init(struct fuse_conn *fc)
+{
+	idr_init(&fc->backing_files_map);
+}
+
+static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	int id;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->lock);
+	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	spin_unlock(&fc->lock);
+	idr_preload_end();
+
+	WARN_ON_ONCE(id == 0);
+	return id;
+}
+
+static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
+						   int id)
+{
+	struct fuse_backing *fb;
+
+	spin_lock(&fc->lock);
+	fb = idr_remove(&fc->backing_files_map, id);
+	spin_unlock(&fc->lock);
+
+	return fb;
+}
+
+static int fuse_backing_id_free(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+
+	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+	fuse_backing_free(fb);
+	return 0;
+}
+
+void fuse_backing_files_free(struct fuse_conn *fc)
+{
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_destroy(&fc->backing_files_map);
+}
+
+int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
+{
+	struct file *file;
+	struct super_block *backing_sb;
+	struct fuse_backing *fb = NULL;
+	int res;
+
+	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	res = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	res = -EINVAL;
+	if (map->flags)
+		goto out;
+
+	file = fget(map->fd);
+	res = -EBADF;
+	if (!file)
+		goto out;
+
+	res = -EOPNOTSUPP;
+	if (!file->f_op->read_iter || !file->f_op->write_iter)
+		goto out_fput;
+
+	backing_sb = file_inode(file)->i_sb;
+	res = -ELOOP;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		goto out_fput;
+
+	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
+	res = -ENOMEM;
+	if (!fb)
+		goto out_fput;
+
+	fb->file = file;
+	fb->cred = prepare_creds();
+	refcount_set(&fb->count, 1);
+
+	res = fuse_backing_id_alloc(fc, fb);
+	if (res < 0) {
+		fuse_backing_free(fb);
+		fb = NULL;
+	}
+
+out:
+	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
+
+	return res;
+
+out_fput:
+	fput(file);
+	goto out;
+}
+
+int fuse_backing_close(struct fuse_conn *fc, int backing_id)
+{
+	struct fuse_backing *fb = NULL;
+	int err;
+
+	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	err = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	err = -EINVAL;
+	if (backing_id <= 0)
+		goto out;
+
+	err = -ENOENT;
+	fb = fuse_backing_id_remove(fc, backing_id);
+	if (!fb)
+		goto out;
+
+	fuse_backing_put(fb);
+	err = 0;
+out:
+	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
+
+	return err;
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index edfc458e5e8f..af0fe3aec329 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1059,9 +1059,18 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_backing_map {
+	int32_t		fd;
+	uint32_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
+					     struct fuse_backing_map)
+#define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1


