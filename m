Return-Path: <linux-fsdevel+bounces-5646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7780E808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7101F2191E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCA5916F;
	Tue, 12 Dec 2023 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO4zEBVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34463DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3362216835eso1419089f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374292; x=1702979092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZowgpdHWDo29CSzCl+gJH076Mvg+wZkvhPUu+SH0EM=;
        b=bO4zEBVJ71ocXJ0U3gQ01/VOvQ46TfGSpp5DSEiWqEF4q/I0QfhTSnJD6yrc4FioD0
         ZlaWapRpNCawlX5ZUnT7awXL4P8+lcCeJnKt/ZwCrOMW8Tj0EYhT+plhUs8Jav3TZVdK
         ogvhZo906kySthcGqa73zBQcOLYaRIvt/letWuwchd+v3qHux864xgqpUr3pswJuw3UE
         9J8c32wtKIZif6VIRIgoIVVeKBCzrLKBkFiCl7O4zpJFQ/ovHwMs36Ew3lXbS0ftpFvv
         8Jbz/aaQAANsG5FhpuJPyl2m+pzWOfCyaKdU00qmrX8/G2q+7qlrTJyZWBej2XCTG1e0
         ZgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374292; x=1702979092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZowgpdHWDo29CSzCl+gJH076Mvg+wZkvhPUu+SH0EM=;
        b=Vc5O4rt8QkRjGodMeI9oSgYfcqTJys9+mKDLdygiZJ0WsTqTLA3I9nF2vVxovv3IKU
         VVw2TZFRGv0UMPlIHLl9Y8SSA3/0SZ1/S36ol0W2kcknKvETGklRtrmIh0trrgCYI8oY
         GNX9gx+8YgNA6ss6JpHTdhD+3Vh6RQ/nzJAjutcu5YQtj6g9pv5QtgyJwlddOzdeq1sR
         BaRSKhcb9O/28msBVhvKy+lvpS0O69KEUYQIZU4w3DF2BhHanNfxUf5zu/kEw1QHH1a5
         au2abpTG5063Gi+5yVFQI6u0uyWfWgjdyoiY4gxaeAz2x/J+GGi79QMDv9AcbJBBkeJj
         nvJg==
X-Gm-Message-State: AOJu0Yzi6ij9vsFNk67DpvrnqEikFjZmLiY/RSMPj/LtuliP1txFDTNu
	3vngyPskEbfzBFjiNAN3WpA=
X-Google-Smtp-Source: AGHT+IHo7rhRhKxQCxbiB92l0LtIFEckmNTYeKQcYzj45ZKshXsrAMmA4XKwyPlPFCIH8mSpEFKoPg==
X-Received: by 2002:adf:e991:0:b0:333:2fd2:68e8 with SMTP id h17-20020adfe991000000b003332fd268e8mr2685438wrm.123.1702374292532;
        Tue, 12 Dec 2023 01:44:52 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:52 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/5] fsnotify: optionally pass access range in file permission hooks
Date: Tue, 12 Dec 2023 11:44:40 +0200
Message-Id: <20231212094440.250945-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for pre-content permission events with file access range,
move fsnotify_file_perm() hook out of security_file_permission() and into
the callers.

Callers that have the access range information call the new hook
fsnotify_file_area_perm() with the access range.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c                |  4 ++++
 fs/read_write.c          | 10 ++++++++--
 fs/readdir.c             |  4 ++++
 fs/remap_range.c         |  8 +++++++-
 include/linux/fsnotify.h | 13 +++++++++++--
 security/security.c      |  8 +-------
 6 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..d877228d5939 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -304,6 +304,10 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	ret = fsnotify_file_area_perm(file, MAY_WRITE, &offset, len);
+	if (ret)
+		return ret;
+
 	if (S_ISFIFO(inode->i_mode))
 		return -ESPIPE;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index e3abf603eaaf..d4c036e82b6c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -354,6 +354,9 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 
 int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
 {
+	int mask = read_write == READ ? MAY_READ : MAY_WRITE;
+	int ret;
+
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
 
@@ -371,8 +374,11 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 		}
 	}
 
-	return security_file_permission(file,
-				read_write == READ ? MAY_READ : MAY_WRITE);
+	ret = security_file_permission(file, mask);
+	if (ret)
+		return ret;
+
+	return fsnotify_file_area_perm(file, mask, ppos, count);
 }
 EXPORT_SYMBOL(rw_verify_area);
 
diff --git a/fs/readdir.c b/fs/readdir.c
index c8c46e294431..278bc0254732 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -96,6 +96,10 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
+	res = fsnotify_file_perm(file, MAY_READ);
+	if (res)
+		goto out;
+
 	res = down_read_killable(&inode->i_rwsem);
 	if (res)
 		goto out;
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 12131f2a6c9e..f8c1120b8311 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -102,7 +102,9 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
+	int mask = write ? MAY_WRITE : MAY_READ;
 	loff_t tmp;
+	int ret;
 
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
@@ -110,7 +112,11 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 	if (unlikely(check_add_overflow(pos, len, &tmp)))
 		return -EINVAL;
 
-	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
+	ret = security_file_permission(file, mask);
+	if (ret)
+		return ret;
+
+	return fsnotify_file_area_perm(file, mask, &pos, len);
 }
 
 /*
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 0a9d6a8a747a..11e6434b8e71 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -101,9 +101,10 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 /*
- * fsnotify_file_perm - permission hook before file access
+ * fsnotify_file_area_perm - permission hook before access to file range
  */
-static inline int fsnotify_file_perm(struct file *file, int perm_mask)
+static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
+					  const loff_t *ppos, size_t count)
 {
 	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
@@ -120,6 +121,14 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 	return fsnotify_file(file, fsnotify_mask);
 }
 
+/*
+ * fsnotify_file_perm - permission hook before file access
+ */
+static inline int fsnotify_file_perm(struct file *file, int perm_mask)
+{
+	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
+}
+
 /*
  * fsnotify_open_perm - permission hook before file open
  */
diff --git a/security/security.c b/security/security.c
index d7f3703c5905..2a7fc7881cbc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2580,13 +2580,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
  */
 int security_file_permission(struct file *file, int mask)
 {
-	int ret;
-
-	ret = call_int_hook(file_permission, 0, file, mask);
-	if (ret)
-		return ret;
-
-	return fsnotify_file_perm(file, mask);
+	return call_int_hook(file_permission, 0, file, mask);
 }
 
 /**
-- 
2.34.1


