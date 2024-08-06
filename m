Return-Path: <linux-fsdevel+bounces-25112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FD94938B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3CB1C21126
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879E1C4601;
	Tue,  6 Aug 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs05C8G2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74017ADFD;
	Tue,  6 Aug 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955599; cv=none; b=dZKJpV6vnd0KQ0PGvww4NMvefB08QTx6zJzdAMqBzHT58YVGrWXPc8eb7mf4c1CM1/qhwbNbgWpgWWAEaHRjhJgfwnXAHv6/iXE7sQZ6JECUO4RxYEF0Lr2BWPpIv9bo4VhQ9a3VfedLWt0ylfAhbEItqeKDZAh1e41ErHjmIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955599; c=relaxed/simple;
	bh=RmBbJu1TgpSzvGALuwZTXfGVwNT54c2Lub564D6jxCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjBrG3E9kfd42wgcZl1PYruLX03ObZZv3gBi7l9csbwHfW/f0h6PL7whSo3VkczI4DB7iv5gHH6U0fXy6hEn1aEB9Wv7WwRHaa8K8q9aRtIhXQtBTyBVRUrdc0SNHZo8zCRxDsVD/cJizxYwaf4HjGEUkbqE93UfjfYqjZq+JRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs05C8G2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a728f74c23dso84029666b.1;
        Tue, 06 Aug 2024 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722955595; x=1723560395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgP2wWVmL6FM6THg0mvDQ9WSWyQkjMnUEneO3058pTM=;
        b=bs05C8G2WBBCGAJQMxjI/4v3GPyYBA4+jawx7eAGm5yDvj09FuJ3tPKt7/oLAjyOXD
         H1TwBr2toUpBwe1EmAwK+J7kGMj6yRUFcpZAGXWvPRZKUColvIA1sp9RBsiIL6vU2WZJ
         RibiOjQaFGe0IMPihIFcZ7DVgDgo38FAi3XafjS+xfz9V+7W/g4XZQJe3h8R/Ql3fvwU
         hkybjBLeDVRPDsZ5w5FMRFX23R2b4NxLtFNfo5PSnKY5RHYdL29zZMFACbQWRUIaaWfz
         tJvobVFy1cjbQ7tH9hoeykZ6yn1gn4to6MVvCnu6gkwmQmanePfPJAIXH+kRH7pSdWDe
         DuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955595; x=1723560395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgP2wWVmL6FM6THg0mvDQ9WSWyQkjMnUEneO3058pTM=;
        b=pIVwaFqklkJ4MrkrQjXIbaISyFVSppNJ3T9n05kGd7nqDbfZcUfgwt4RHBBNR87WKX
         yE/rxYM1l5vgfHQS/igA/LXoD+ibzy4F/JjKymV00eSdf3usuppZNvnYobWlXzhmOToH
         2tMIcZe0RDmFpsOWbxipkmczPkuJytuIkLu8KI2Qyov5/42pR+YbBO+Sy5O0Vk4SEgpA
         OlGEt29+ChkHqgYkaYohbEtitQ7cnny4PuT529fhs343+wgihbVEDDnV2XmrWlHvi0nK
         x+pCe8ClD7XS5g6pHmZpkhYUnEjmGlzJxRIbEKjxinUAuzqtzq00fY5oPem1BrpELdpP
         aMOA==
X-Forwarded-Encrypted: i=1; AJvYcCV9glFv3blPNIYiDRsEMXINTz/l0XrhilTKBoG5Q9a6/FLB+9MvHGLFmLsLesS75F5w8G9ZFSq/SN1c42wioVgcdEMWqHRj/SHtCJBZtpXA8xOu1XLtfO+/KLH6JT3k48ix6Uq6l5tbhxwlAw==
X-Gm-Message-State: AOJu0YzA0gz1LY2qZc/zLS4gxE2QK9K7jQUyKUEvMPnpxzDuv3+2j7KS
	XZBg5YIjuN+M2HVXfFg0CCuZKCNIhaRJZW+qSv/xuytRHepAK7Le
X-Google-Smtp-Source: AGHT+IGvn80pGS6jhKSCW5CgiBEcqEjIUKYOWYxFMZxnz85DufNBz7RztlGtiII14Nc8uiEg1hoxuA==
X-Received: by 2002:a17:907:1c19:b0:a6f:4fc8:2666 with SMTP id a640c23a62f3a-a7dc506ce86mr1193200066b.44.1722955595066;
        Tue, 06 Aug 2024 07:46:35 -0700 (PDT)
Received: from f.. (cst-prg-92-246.cust.vodafone.cz. [46.135.92.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42680sm553768566b.118.2024.08.06.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:46:34 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Date: Tue,  6 Aug 2024 16:46:28 +0200
Message-ID: <20240806144628.874350-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening a file grabs a reference on the terminal dentry in
__legitimize_path(), then another one in do_dentry_open() and finally
drops the initial reference in terminate_walk().

That's 2 modifications which don't need to be there -- do_dentry_open()
can consume the already held reference instead.

In order to facilitate some debugging a dedicated namei state flag was
added to denote this happened.

When benchmarking on a 20-core vm using will-it-scale's open3_processes
("Same file open/close"), the results are (ops/s):
before:	3087010
after:	4173977 (+35%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The flag thing is optional and can be dropped, but I think the general
direction should be to add *more* asserts and whatnot (even if they are
to land separately). A debug-only variant would not hurt.

The entire "always consume regardless of error" ordeal stems from the
corner case where open succeeds with a fully populated file object and
then returns an error anyway. While odd, it does mean error handling
does not get more complicated at least.

 fs/internal.h |  3 ++-
 fs/namei.c    | 30 +++++++++++++++++++++++-------
 fs/open.c     | 31 ++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index cdd73209eecb..9eeb7e03f81d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -193,7 +193,8 @@ int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 int chown_common(const struct path *path, uid_t user, gid_t group);
-extern int vfs_open(const struct path *, struct file *);
+int vfs_open_consume(const struct path *, struct file *);
+int vfs_open(const struct path *, struct file *);
 
 /*
  * inode.c
diff --git a/fs/namei.c b/fs/namei.c
index 1bf081959066..20c5823d34dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -595,9 +595,10 @@ struct nameidata {
 	umode_t		dir_mode;
 } __randomize_layout;
 
-#define ND_ROOT_PRESET 1
-#define ND_ROOT_GRABBED 2
-#define ND_JUMPED 4
+#define ND_ROOT_PRESET		0x00000001
+#define ND_ROOT_GRABBED 	0x00000002
+#define ND_JUMPED 		0x00000004
+#define ND_PATH_CONSUMED 	0x00000008
 
 static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
@@ -697,6 +698,7 @@ static void terminate_walk(struct nameidata *nd)
 			nd->state &= ~ND_ROOT_GRABBED;
 		}
 	} else {
+		BUG_ON(nd->state & ND_PATH_CONSUMED);
 		leave_rcu(nd);
 	}
 	nd->depth = 0;
@@ -3683,6 +3685,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct vfsmount *mnt;
 	struct mnt_idmap *idmap;
 	int open_flag = op->open_flag;
 	bool do_truncate;
@@ -3720,11 +3723,22 @@ static int do_open(struct nameidata *nd,
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return error;
+		/*
+		 * We grab an additional reference here because vfs_open_consume()
+		 * may error out and free the mount from under us, while we need
+		 * to undo write access below.
+		 */
+		mnt = mntget(nd->path.mnt);
 		do_truncate = true;
 	}
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
-	if (!error && !(file->f_mode & FMODE_OPENED))
-		error = vfs_open(&nd->path, file);
+	if (!error && !(file->f_mode & FMODE_OPENED)) {
+		BUG_ON(nd->state & ND_PATH_CONSUMED);
+		error = vfs_open_consume(&nd->path, file);
+		nd->state |= ND_PATH_CONSUMED;
+		nd->path.mnt = NULL;
+		nd->path.dentry = NULL;
+	}
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
@@ -3733,8 +3747,10 @@ static int do_open(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (do_truncate)
-		mnt_drop_write(nd->path.mnt);
+	if (do_truncate) {
+		mnt_drop_write(mnt);
+		mntput(mnt);
+	}
 	return error;
 }
 
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..eb69af3676e3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -905,6 +905,15 @@ static inline int file_get_write_access(struct file *f)
 	return error;
 }
 
+/*
+ * Populate struct file
+ *
+ * NOTE: it assumes f_path is populated and consumes the caller's reference.
+ *
+ * The caller must not path_put on it regardless of the error code -- the
+ * routine will either clean it up on its own or rely on fput, which must
+ * be issued anyway.
+ */
 static int do_dentry_open(struct file *f,
 			  int (*open)(struct inode *, struct file *))
 {
@@ -912,7 +921,6 @@ static int do_dentry_open(struct file *f,
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
-	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
@@ -1045,6 +1053,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
+	path_get(&file->f_path);
 	return do_dentry_open(file, open);
 }
 EXPORT_SYMBOL(finish_open);
@@ -1077,15 +1086,19 @@ char *file_path(struct file *filp, char *buf, int buflen)
 EXPORT_SYMBOL(file_path);
 
 /**
- * vfs_open - open the file at the given path
+ * vfs_open_consume - open the file at the given path and consume the reference
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
  */
-int vfs_open(const struct path *path, struct file *file)
+int vfs_open_consume(const struct path *path, struct file *file)
 {
 	int ret;
 
 	file->f_path = *path;
+	/*
+	 * do_dentry_open() does the referene consuming regardless of its return
+	 * value
+	 */
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
@@ -1098,6 +1111,17 @@ int vfs_open(const struct path *path, struct file *file)
 	return ret;
 }
 
+/**
+ * vfs_open - open the file at the given path
+ * @path: path to open
+ * @file: newly allocated file with f_flag initialized
+ */
+int vfs_open(const struct path *path, struct file *file)
+{
+	path_get(path);
+	return vfs_open_consume(path, file);
+}
+
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
@@ -1183,6 +1207,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 		return f;
 
 	f->f_path = *path;
+	path_get(&f->f_path);
 	error = do_dentry_open(f, NULL);
 	if (error) {
 		fput(f);
-- 
2.43.0


