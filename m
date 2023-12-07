Return-Path: <linux-fsdevel+bounces-5153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F954808AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28DB1F20623
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21844370
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja2C4jV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305D10E0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3334a701cbbso895656f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952719; x=1702557519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91UBnG6fR3LUiwVV9EUqaRpgux2aghoi6YSdfsjb0uk=;
        b=Ja2C4jV/Tmd3N+396gTQbGp2K+K0AUh6bszdsUDqz0qYXSzosHNJOOEhMFvFkEJBIR
         sMgi+GeTpbDIAhEGxn/N8YxhXv7rthOv7SEUAH5dbjLsWu/IXmj0fzqDnzoOK4c/LQC0
         nUNF38YEEm9e0pqdUZOHimBy4lhuJJRYswPLt8359HNcMw1MqnXuxa3CgUDmxT4ybVeD
         VQtM16t6FWFdn2BLe7MVfHxLwDYKcUFckUNDfm2n2aoddF0Itq2fFkcdmLpHWC0+n0Ho
         HqUMXXQwQLDtDf/8Ju5m19/NbGLZrTOIuUUvqhv1dhmc9qHyvibpksSbGKqHTg7AjHeC
         xmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952719; x=1702557519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91UBnG6fR3LUiwVV9EUqaRpgux2aghoi6YSdfsjb0uk=;
        b=ornHxHbnIUrdRktZPdw13J1MyrOn9WhAVhQQ218wl4tqwoDJqnOnhA01pJE14zneiZ
         VkpHKT8h894G2ivS9/PtQI2AoCMt8hSehcLrK744CB/Py8C8TLZWiFe4ohObN3qLX5xY
         q4dWPqpDUyC8/9VCapWFVP4MR+FMpMb8xGMBYTu0IVq/GCe9WsR57hQT2iUvkbAMPcyo
         FEDrLrMVN3vKZ40feMVda7asAwXc7tqDGWAuEz6oyx/K+pQx7lxYgmkDtUFtu147ddZG
         T5oYY0d3vx02+qeeTSq88Xv2aCzLvtszEXcb7jABs8PApu1WRn33Y2azsD7FD+Mi4Wlv
         XtbQ==
X-Gm-Message-State: AOJu0YyqXmVJqg1EqdluqvC8TyH0VKomP7MTQkwajUhUQ0iCWvE0spfv
	sqzO8g9jJSJ1g1dbjG6eHjFYGlb6DOs=
X-Google-Smtp-Source: AGHT+IFOed7UyAWJaBzMuTvt6ql/wcfr7qYMEko5w2Cbqjjc1ODgc+HxZz/l/iVbR9oeVtNFTtYdrA==
X-Received: by 2002:a5d:6711:0:b0:333:2fd2:3bd4 with SMTP id o17-20020a5d6711000000b003332fd23bd4mr1079980wru.141.1701952718761;
        Thu, 07 Dec 2023 04:38:38 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm1332431wrs.47.2023.12.07.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:38:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] fsnotify: pass access range in file permission hooks
Date: Thu,  7 Dec 2023 14:38:25 +0200
Message-Id: <20231207123825.4011620-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for pre-content permission events with file access range,
move fsnotify_file_perm() hook out of security_file_permission() and into
the callers that have the access range information and pass the access
range to fsnotify_file_perm().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c                |  4 ++++
 fs/read_write.c          | 10 ++++++++--
 fs/readdir.c             |  4 ++++
 fs/remap_range.c         |  8 +++++++-
 include/linux/fsnotify.h |  3 ++-
 security/security.c      |  8 +-------
 6 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..530f70da69e1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -304,6 +304,10 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	ret = fsnotify_file_perm(file, MAY_WRITE, &offset, len);
+	if (ret)
+		return ret;
+
 	if (S_ISFIFO(inode->i_mode))
 		return -ESPIPE;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 97a9d5c7ad96..1b5b0883edba 100644
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
+	return fsnotify_file_perm(file, mask, ppos, count);
 }
 EXPORT_SYMBOL(rw_verify_area);
 
diff --git a/fs/readdir.c b/fs/readdir.c
index c8c46e294431..684ae75d94a4 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -96,6 +96,10 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
+	res = fsnotify_file_perm(file, MAY_READ, NULL, 0);
+	if (res)
+		goto out;
+
 	res = down_read_killable(&inode->i_rwsem);
 	if (res)
 		goto out;
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 12131f2a6c9e..ee4729aafbde 100644
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
+	return fsnotify_file_perm(file, mask, &pos, len);
 }
 
 /*
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 0a9d6a8a747a..45e6ecbca057 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 /*
  * fsnotify_file_perm - permission hook before file access
  */
-static inline int fsnotify_file_perm(struct file *file, int perm_mask)
+static inline int fsnotify_file_perm(struct file *file, int perm_mask,
+				     const loff_t *ppos, size_t count)
 {
 	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
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


