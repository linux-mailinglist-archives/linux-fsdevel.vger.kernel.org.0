Return-Path: <linux-fsdevel+bounces-25139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D094959E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59C31C213DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3F3CF58;
	Tue,  6 Aug 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieLjQ3lR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D54AEE0;
	Tue,  6 Aug 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961986; cv=none; b=LtY5pq5yTf0BTIZ26jQHT41VHLpkgq8SO5Se8zU2wcShD+EiBLsR8Eh+jyHsvRdnFKBjK+IS9/dtqdBBxmxHCOzzYxJ0v1aLJsR1aolao7AtcSzmpS7C1eX3OtjkjqgibmLywhKUL0lWfz7vF5eFQmcFsfYVLIvqrN6mGgglIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961986; c=relaxed/simple;
	bh=566wAyXOpiqU1O82gz3vDJ7RUFpvtKpN82ioekzGPY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cU7iA8L0z9IEpbAhcLhl0ZiRyU3Ds17VIB8tsfBEknO36Kn5u6WZMU+3kxabJwaqUeNymU5ZS1RyrrfLimDtpCNWnc0F3ps21PizBYwiPeWd1SYZL47X2J62YLC0TE0sUbE8SG7lDEA9sK8klTrwwBQBO8RR+JvDF89WKxV1ips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieLjQ3lR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so87648766b.1;
        Tue, 06 Aug 2024 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722961983; x=1723566783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9lOceRSQXe5XyV96b7OxiJnOBX35L4zgaI+kg/nMLM=;
        b=ieLjQ3lRCSPrQTShbpqdfitSwRhbGSS0zz3hHSpb0SeyvO/xmAGv5MCE9si/KuDW5C
         jKhKuNHHOV+4nsfxPhvy/mf+DVAB+HjC459+1f9RSgcFhxnB9e7FuYwFtpi4iIeYA511
         wmd13aLHE310bcT2hfiFcUx7191+OrF/NMCg77y1/CvM5O7OU/yjfKENhIca4LQL9yz4
         MUKHoQvkAvbiAC403JgT1qnYLiZ17wqlTggojA4hV7zwjpZBUrTa8sE3/lv6wrHV4LhJ
         izST7+2fcY6ihigswM54Aoui2soF9h+heQIylqPJ+L+fcDlBRwWsgDUaphGmpf+7IzBi
         5dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961983; x=1723566783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9lOceRSQXe5XyV96b7OxiJnOBX35L4zgaI+kg/nMLM=;
        b=bo5/MRV8jLihmQqqpqfDrHjMr//1Lw7AbkEbU1U/6foybWNMQzwld8QQFFzHOu9ddv
         dDwFBMZ34TD7QyzxZWXu99q/z5WJmYN48gKZHgY4LjShdDPiF8+tpNQ0X308ddATdshn
         Iho+ZOJUvD5QMpELZ/Q6U1FZxnaRUkPGl/CZSX5xvx1QiFb6/t2TgU5vB6rfx1idiTFO
         FAo9vQxu2xjM2vpM8tTBCF/3OcciNgwzzdDDbXYAtihWvXVNIZcYKl0DB7pz/A5I8XIR
         S2d5P9cwvVJZPvtZRUcp051NZPyXbpO/3Wr4OI7MiqxIrBTikzJEyIkbLTztrfi4cdTp
         tRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPUGjZ26ZLhbPz6v+NQlLI6qKfUBHTI1xnu/b/d386VprT6HM57xzbhWRi938c1Iv3ROB3vgvTZOy1aPVsBPHhM4VjmOTIAYgrw01aJn3ucVOnRRAwIBVuJQ4Oy9fY0uYsFkt/LJ57LU/xhw==
X-Gm-Message-State: AOJu0Yx0b+1G/TT7PgO3V62J6iHvyO4mhbvL0rpcSmVGA2aL1peE2W10
	vIvod3vTWSm5WthkNxtZRRUtN9MQW7ITG1NKPPifQ/6ukLEg3YbQ
X-Google-Smtp-Source: AGHT+IFKYCHZmgKM7Mtu032rEJecn9FegLtR6YoLCFPsBbOXHlgg9nmPptdEvP3+KRD01RyOU7WByg==
X-Received: by 2002:a17:906:c156:b0:a77:d1ea:ab26 with SMTP id a640c23a62f3a-a7dc5105151mr1139312366b.65.1722961982200;
        Tue, 06 Aug 2024 09:33:02 -0700 (PDT)
Received: from f.. (cst-prg-92-246.cust.vodafone.cz. [46.135.92.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4304fsm564900866b.128.2024.08.06.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:33:01 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] vfs: avoid spurious dentry ref/unref cycle on open
Date: Tue,  6 Aug 2024 18:32:56 +0200
Message-ID: <20240806163256.882140-1-mjguzik@gmail.com>
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

That's 2 modifications which don't need to be there -- do_dentry_open can
consume the already held reference instead.

In order to facilitate some debugging a dedicated namei state flag was
added to denote this happened.

When benchmarking on a 20-core vm using will-it-scale's open3_processes
("Same file open/close"), the results are (ops/s):
before:	3087010
after:	4173977 (+35%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

- drop the debug flag
- tweak commentary
- make vfs_open_consume clean up the path

perhaps this will do the trick? :)

 fs/internal.h |  3 ++-
 fs/namei.c    | 15 ++++++++++++---
 fs/open.c     | 44 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index cdd73209eecb..6899e6ec9394 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -193,7 +193,8 @@ int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 int chown_common(const struct path *path, uid_t user, gid_t group);
-extern int vfs_open(const struct path *, struct file *);
+int vfs_open_consume(struct path *, struct file *);
+int vfs_open(const struct path *, struct file *);
 
 /*
  * inode.c
diff --git a/fs/namei.c b/fs/namei.c
index 1bf081959066..44ea5353ae26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3683,6 +3683,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct vfsmount *mnt;
 	struct mnt_idmap *idmap;
 	int open_flag = op->open_flag;
 	bool do_truncate;
@@ -3720,11 +3721,17 @@ static int do_open(struct nameidata *nd,
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return error;
+		/*
+		 * We grab an additional reference here because after the call to
+		 * vfs_open_consume() we no longer own the reference in nd->path.mnt
+		 * while we need to undo write access below.
+		 */
+		mnt = mntget(nd->path.mnt);
 		do_truncate = true;
 	}
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
-		error = vfs_open(&nd->path, file);
+		error = vfs_open_consume(&nd->path, file);
 	if (!error)
 		error = security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
@@ -3733,8 +3740,10 @@ static int do_open(struct nameidata *nd,
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
index 22adbef7ecc2..2fdfb3133d0f 100644
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
@@ -1077,15 +1086,22 @@ char *file_path(struct file *filp, char *buf, int buflen)
 EXPORT_SYMBOL(file_path);
 
 /**
- * vfs_open - open the file at the given path
+ * vfs_open_consume - open the file at the given path and consume the reference
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
  */
-int vfs_open(const struct path *path, struct file *file)
+int vfs_open_consume(struct path *path, struct file *file)
 {
 	int ret;
 
 	file->f_path = *path;
+	path->mnt = NULL;
+	path->dentry = NULL;
+
+	/*
+	 * do_dentry_open() does the reference consuming regardless of its
+	 * return value
+	 */
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
@@ -1098,6 +1114,27 @@ int vfs_open(const struct path *path, struct file *file)
 	return ret;
 }
 
+/**
+ * vfs_open - open the file at the given path
+ * @path: path to open
+ * @file: newly allocated file with f_flag initialized
+ *
+ * See commentary in vfs_open_consume. The difference here is that this routine
+ * grabs its own reference and does not clean up the passed path.
+ */
+int vfs_open(const struct path *path, struct file *file)
+{
+	int ret;
+
+	file->f_path = *path;
+	path_get(&file->f_path);
+	ret = do_dentry_open(file, NULL);
+	if (!ret) {
+		fsnotify_open(file);
+	}
+	return ret;
+}
+
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
@@ -1183,6 +1220,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 		return f;
 
 	f->f_path = *path;
+	path_get(&f->f_path);
 	error = do_dentry_open(f, NULL);
 	if (error) {
 		fput(f);
-- 
2.43.0


