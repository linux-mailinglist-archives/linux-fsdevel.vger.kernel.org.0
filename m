Return-Path: <linux-fsdevel+bounces-5434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD180BB98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AFD280DEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2952168A7;
	Sun, 10 Dec 2023 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k86YW1P1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23558F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso5138347a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217953; x=1702822753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqJdpciEoyojq8phh7lg/JWqmF7QLNIHT6XgCGaxHrA=;
        b=k86YW1P12HvxIaiDnrWbYiN8jc5IsYv9FAZL3D6augpvqU6MrHntIQkcDjtK8MiX5c
         e9eEZ5gL80puL5U4T+xUNpWdHuCVPvhC5X/xOsmNAGZy/d+NHhd5OLRc75X7IYJHW3DA
         hcoyX2zZVWxwWvQL19X+xPzLIQyjvTS+LDPKRweX6UpArOYT+bSj+kI/vmRYeu4FTs1G
         H2Uw9xbvKXupg/6GdwAcKTevIELqy6ZsDtwMO51eTXuwROw5h/iv4rHIFEedrTOMqdrt
         ddStYYbWJd6+CgtUN8BR2KzEMqgPd6st9IGKPHOJRUtxXx/yTjEwdarEd1phtA8e7Zqe
         w+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217953; x=1702822753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqJdpciEoyojq8phh7lg/JWqmF7QLNIHT6XgCGaxHrA=;
        b=ikQUIrUfpAFcQLSajXSmvfCja9GNXjP2QoxxviE0XB1BUXhQutct7c1bdkDrCGJ6JE
         Lew6UUgNDL9gYXgHEdZEWR5vxA/T8SA3f5B4eFxu3o1JWI3ZhSbIxmJ61J4+NIDMN/H7
         iAzCXpZ4QbRyE0H3hWbhFco13mmg/xyC7PRG6n0gAqalYTo2zqPu+ruu/oIF2/BU/MVU
         6VyYrLdwFsrvsIoXSsnq/S1aV8CFxgSdRVSi2w5kg7l54q3drdzw0SGsJ3sCHRq9LIbV
         PQqHJOiMCQrQ/9lSIS20PDxDbMlivmcSszOvYs2+Iov4hZKW+VXoJI+tDr5QhcBVYQH+
         VoHA==
X-Gm-Message-State: AOJu0Ywv4KDbihNaa6RKzR7FHJmFkbUeBzwzGxO62JjMyquBZAlSrq6F
	Rsx3lCjO4zenX+anoOsw1pM=
X-Google-Smtp-Source: AGHT+IF65+RTH4umvmBhX4c9CStym4rPpDZZMUBJrpLnxQduTBfMd3OwrafGQWBagt7lERxaiNm/yA==
X-Received: by 2002:a50:d0c2:0:b0:54f:4b64:55ec with SMTP id g2-20020a50d0c2000000b0054f4b6455ecmr1050439edf.110.1702217953466;
        Sun, 10 Dec 2023 06:19:13 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:13 -0800 (PST)
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
Subject: [PATCH v2 5/5] fsnotify: optionally pass access range in file permission hooks
Date: Sun, 10 Dec 2023 16:19:01 +0200
Message-Id: <20231210141901.47092-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210141901.47092-1-amir73il@gmail.com>
References: <20231210141901.47092-1-amir73il@gmail.com>
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


