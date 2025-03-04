Return-Path: <linux-fsdevel+bounces-43135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7981A4E88C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138A3425A28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9CF2C3745;
	Tue,  4 Mar 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiFcMxms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553A2D4B7E;
	Tue,  4 Mar 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107460; cv=none; b=P0FfW2DMt1Ji6t8Pv8lH9iIPpDl4dZAfmJM+bl5it7SIDKHkFNXB+DzidTlO7pNKMiD+B4JvUkk9WN0gQ084sj4Ft7Cy10WgrmpTIKnjsc3t7YOJ7Z0l/FZ/Pao8bBZaBzKmrAY+t/1kx5xfcC5qfGjJcW2oLvDoVXjKaXPbGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107460; c=relaxed/simple;
	bh=+l/EjeUA+5d8VX49RYgy4dN7slpwKi8CoheUYsJ1Qpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db5nA1o3uSW8thhHJCe9/QOAa8UQ+LFBJRBgTJaT8sJvwPSIaS8V32Y5IzmAF/fV49qObtgldgSso9od8cpZlpX1BZpO39ak+M9RWZqaC+Vs9nv9SrfXM/gqYko3EnmaK8Wla5iJv1n78kBQVj4aRRdDblJhBi5vHdTY8XAR83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiFcMxms; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac202264f9cso94311066b.0;
        Tue, 04 Mar 2025 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107456; x=1741712256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLsMU/gpYkwvzpJkBRFq1iYDiFQreX0pirlkWTeGy6Q=;
        b=CiFcMxmsMcJP8i1axX8iivkDCe80nIjR3jta5RDI/Z/6Ysg0BX/BcH702E0ZueF2oD
         Q2jYratk0mmtdWvUjs3hVC24wEoimxl6b3bbeu3jEl8eJsnuK4s/2oTDsBVwYrFPS9eM
         Mj9NiyF0mOQUc7U6RuKfkEHgBUXRBXDFQX90WX94LRbjiggLErQ2Mg6sf/F52hT79wiy
         mwUxvcMza85I0SbesQLY29lNxKfA9eSyh9BNA1QiFkWHEWUdLmlQxyiMgaZ/HJtI9j/U
         llHlncX23HbqCfUAd2125RHU3VroDS3qfwuA9k+fkoMsjJvtP1sSHAt4PX7oiygHkrJY
         WwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107456; x=1741712256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLsMU/gpYkwvzpJkBRFq1iYDiFQreX0pirlkWTeGy6Q=;
        b=hkR4ojkVmEWbfALbwi0kHTWuyjlc7YJI6vGfzq754uuxCxlKhqnBRmaC+J6GvyyZXH
         V9MRhicp9ZBmWT/WAMenq21qj9mmTmYNqwWF2LVlGkVt+cU+PcP92rgg0zd4EkKYMczx
         OBYeYet7b5mdoIxMkEbZL7Wub7aezqSied78OFP6JdYRVdbLzhpOEPRdzu1wNlrp8eMF
         B7j8P9yCDbYuUvI3vdnsUJ6fV4iLQS+gvct0SKYSoraWFkBrDwNW6GbkaM0PRpBG4pm3
         qLlPpkZAF+BMGTHCdTVwZOs6Bqyc2gb6PVzCEd5els0KdNTZ4toLQTTrnePZE85CpifA
         osfw==
X-Forwarded-Encrypted: i=1; AJvYcCXBB4/KF+91DkqUhlT0itiAv7lsLR3vx2ypEt0aeASyOJL2smT4CFn7H3TkSZtw1HRUPMUDhsCc0hINR/rK@vger.kernel.org, AJvYcCXruLWBjbI2Fw287aWQnmaKKDxKDph7Jt/O4ng0DAUgIBSYJdCY8argSson5jRv4cO3UTlY+IYpkInQ/ER+@vger.kernel.org
X-Gm-Message-State: AOJu0YwcX4ajUCp3/Z8L9rUyy4nUf9wRsQQJVGhVgr4acxG4LoVkiOFn
	4QkKyeHlWQqzW7QI+tCJm5gf7n/LCd05DqfvLW+WDtqv+XRJ69af7Kz4nUJ9
X-Gm-Gg: ASbGncu18mvOakECDockP2Qip0selWpszNUWxY8Some4NsS4fvmRg7gcD6/XFc0Udnb
	JgPBlQqhp1OYVziGh6zVKfMeI8p80wCN86nRZUD4ctXAWWlYBmkGkNOuq0hyLHHIAhvqGmv9N6B
	zMA3pHCHzneXa3vVs0LnBmfw30RF9vowVhcuMtCtTqDEUDimqXKBGATrRmIYfOAWK79GiB8rLYJ
	u3RXKXX50FjHc3iC/47kueqMllVXMCMX/mI/A6Yrs/llL86oTr+Zain+eKBxMtrT5FTJlZVaMsE
	LJF3qyOwZTnfOJJkRkfMv7ztNTLRRxGHXw4kX4zt6nc2MfqBYn8vWCufnjDv
X-Google-Smtp-Source: AGHT+IFB5SKAGTk8wLYqM+NjVxEA74LITSloKjBgOg8Ti4DHHLqqSx64hUByZV2SsEp0QhlodEzhAw==
X-Received: by 2002:a17:907:9690:b0:ac1:e30e:bf5a with SMTP id a640c23a62f3a-ac1e30ec2c1mr673779166b.35.1741107455828;
        Tue, 04 Mar 2025 08:57:35 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e5aff06esm231360266b.130.2025.03.04.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:57:35 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] vfs: avoid spurious dentry ref/unref cycle on open
Date: Tue,  4 Mar 2025 17:57:28 +0100
Message-ID: <20250304165728.491785-1-mjguzik@gmail.com>
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

When benchmarking on a 20-core vm using will-it-scale's open3_processes
("Same file open/close"), the results are (ops/s):
before: 3087010
after:  4173977 (+35%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Al, while I originally brought this up you objected to my patch, which I
then rewrote to the form below. You wrote your own more invovled
variant, but the effort to get this in seem stalled:
https://lore.kernel.org/linux-fsdevel/20240822003359.GO504335@ZenIV/

(I think there was a bigger git branch somewhere, but now I can't find
it.)

The lockref thing is increasingly getting in the way of some other stuff
and is just overhead which is not need to be there.

If you don't have time to finish your patches, how about the variant
below? This is rebased v2 I sent a while back and which got no feedback.

I am indifferent as to what lands, as long as the extra ref cycle is
eliminated.

 fs/internal.h |  3 ++-
 fs/namei.c    | 15 ++++++++++++---
 fs/open.c     | 44 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 3d05a989e4fa..1d0eb25a7598 100644
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
index d00443e38d3a..8ce8e6038346 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3796,6 +3796,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct vfsmount *mnt;
 	struct mnt_idmap *idmap;
 	int open_flag = op->open_flag;
 	bool do_truncate;
@@ -3833,11 +3834,17 @@ static int do_open(struct nameidata *nd,
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
@@ -3846,8 +3853,10 @@ static int do_open(struct nameidata *nd,
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
index f2fcfaeb2232..fc1c6118eb30 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -891,6 +891,15 @@ static inline int file_get_write_access(struct file *f)
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
@@ -898,7 +907,6 @@ static int do_dentry_open(struct file *f,
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
-	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
@@ -1042,6 +1050,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
+	path_get(&file->f_path);
 	return do_dentry_open(file, open);
 }
 EXPORT_SYMBOL(finish_open);
@@ -1074,15 +1083,22 @@ char *file_path(struct file *filp, char *buf, int buflen)
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
+	 * do_dentry_open() consumes the reference regardless of its
+	 * return value
+	 */
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
@@ -1095,6 +1111,27 @@ int vfs_open(const struct path *path, struct file *file)
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
@@ -1197,6 +1234,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 		return f;
 
 	f->f_path = *path;
+	path_get(&f->f_path);
 	error = do_dentry_open(f, NULL);
 	if (error) {
 		fput(f);
-- 
2.43.0


