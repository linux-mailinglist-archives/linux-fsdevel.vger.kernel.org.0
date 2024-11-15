Return-Path: <linux-fsdevel+bounces-34929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D89CF008
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35021F245F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E91D90A5;
	Fri, 15 Nov 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CN4yeK7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8D1D514B
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684686; cv=none; b=arBe/TLsJ3SSOjMuoK8ZCURQR+WTzPVligfB51uoMzp3x1YZbVdccVIwKyqLV1mnDMnf0tsRzW18kFKZYFCN7Ye2BunPln/dfY8ZlRYAtffHweWj/aN+bmhn1Dl/vdlW2nq9H8YEqZRiihcROEypAnqraBuH7RJSr1hQPjdRG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684686; c=relaxed/simple;
	bh=e50Qfn4GCw5AIdzXYs640LPuGmdwEnwaxcQ/v4hGxAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHKlJFNoJAvj+Mx1uvGfEUtH5hV9ohcN+vaceUU7KfdFX8xT8EyjySsfUFoVz+iLTRUHTAQW0CYmwrpQd7/cl3RYvvCz0FAI6ke294qsUlEpHEckAPhRkXrjv2YDdZA7RKoiQVDh5ZWiiKqiw8AwQFfE4elrvXdzzIseEmjuCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CN4yeK7t; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e38158560d4so2002530276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684683; x=1732289483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR1XeBSj0UKEAyle1L8EQtWLZrkZWI4sB29nFtL0fR8=;
        b=CN4yeK7tk6IllvdX/x8UQxYCoUyVf0de5kGPjaw44ixDSTsNfjDkMP2OUjTIyfzYxq
         UWTgi688CdhA6mj6M1sKRl+DJLmWeEjovDwL7tJVVOIGPTB6M9+NGLZwnIPFQRLaiFix
         M9ILUP5HY1B+giopiMoMayRQ5UW0nvopv6fDtBIEAxVKMCJfClCBhL9g2IzwUvkearKF
         NPfWA/lPOIQA+N05jgxMp4LUGAnsWYJlQVpf1WEqi8E2FhKVbeqXsgXVA22A6hI3HH9M
         173fQqo9IMtaWlkWuAz698Lo8MUIZfwOMXrkJfEOhFCNcG4GGzWOgh5ZODPlwMe5bQ/h
         02OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684683; x=1732289483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR1XeBSj0UKEAyle1L8EQtWLZrkZWI4sB29nFtL0fR8=;
        b=qfoGDdhd3Ftz9211vrqYErLoxjG8VB4+G5YK4/EWM4l3hAI1ZCO8hx0QNR8pBq1bt5
         yxJbablkxwIHD3eYxcq8wLWRRvc5pBo8fjLTpTHcofwSm0QN2LT77Qo4K++J0LERoge9
         Glu14++HaSGHSSpGY0PfpPvdqLqRBcigiye69vq1JGWpkVRFRlGy80/bamAPt8z4GVN+
         VLtFYhuCJPSaJzv7VWu3O50SzIWFUoWnZHhB2v5lSqIDCd8/mKnLs5siPp3aNAiGIwOZ
         iCqrIpGNuGbfPjCKxjVCeMqcUz2v94/RIHM/jkbFdab174JxnzkA5opVny9h1aeCpQz2
         iFwg==
X-Forwarded-Encrypted: i=1; AJvYcCWfL+UJbrNQ8JmeeNHPaMbz0ni9nLtwjvx/KdDva2nJpMKi83vazrZGQijU5ESglW+/X4xHHnhb0TwH7evy@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKjcON8jxdQJ+Q6Z8yIJBDvXEGx3m1cA0CIGBGylLTj/TWKG3
	fOzHjQayR405pp4UEKvzgDk3u+xOd0V/gePWOQzGIkYTA3RyJlmqKlVmJP4Yuoo=
X-Google-Smtp-Source: AGHT+IGBdJCygNHz6DEBCdeiVRgK2IumpYj4jyGOaPbgCKPpYL6CnPz3nA2B5qY78/GCUuIzkqAI7g==
X-Received: by 2002:a05:6902:2b86:b0:e30:e1f3:2aab with SMTP id 3f1490d57ef6-e38263a1b87mr2546246276.39.1731684683163;
        Fri, 15 Nov 2024 07:31:23 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152fe65dsm991511276.35.2024.11.15.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:22 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 01/19] fs: get rid of __FMODE_NONOTIFY kludge
Date: Fri, 15 Nov 2024 10:30:14 -0500
Message-ID: <d1231137e7b661a382459e79a764259509a4115d.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

All it takes to get rid of the __FMODE_NONOTIFY kludge is switching
fanotify from anon_inode_getfd() to anon_inode_getfile_fmode() and adding
a dentry_open_fmode() helper to be used by fanotify on the other path.
That's it - no more weird shit in OPEN_FMODE(), etc.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/linux-fsdevel/20241113043003.GH3387508@ZenIV/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fcntl.c                         |  4 ++--
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++++++++---------
 fs/open.c                          | 23 +++++++++++++++++++----
 include/linux/fs.h                 |  6 +++---
 include/uapi/asm-generic/fcntl.h   |  1 -
 5 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index ac77dd912412..88db23aa864a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1155,10 +1155,10 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
-			__FMODE_EXEC | __FMODE_NONOTIFY));
+			__FMODE_EXEC));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
 					 sizeof(struct fasync_struct), 0,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2d85c71717d6..919ff59cb802 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -100,8 +100,7 @@ static void __init fanotify_sysctls_init(void)
  *
  * Internal and external open flags are stored together in field f_flags of
  * struct file. Only external open flags shall be allowed in event_f_flags.
- * Internal flags like FMODE_NONOTIFY, FMODE_EXEC, FMODE_NOCMTIME shall be
- * excluded.
+ * Internal flags like FMODE_EXEC shall be excluded.
  */
 #define	FANOTIFY_INIT_ALL_EVENT_F_BITS				( \
 		O_ACCMODE	| O_APPEND	| O_NONBLOCK	| \
@@ -258,12 +257,11 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 		return client_fd;
 
 	/*
-	 * we need a new file handle for the userspace program so it can read even if it was
-	 * originally opened O_WRONLY.
+	 * We provide an fd for the userspace program, so it could access the
+	 * file without generating fanotify events itself.
 	 */
-	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
-			       current_cred());
+	new_file = dentry_open_nonotify(path, group->fanotify_data.f_flags,
+					current_cred());
 	if (IS_ERR(new_file)) {
 		put_unused_fd(client_fd);
 		client_fd = PTR_ERR(new_file);
@@ -1409,6 +1407,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
+	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1477,7 +1476,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | __FMODE_NONOTIFY;
+	f_flags = O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
@@ -1555,10 +1554,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 	}
 
-	fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
+	fd = get_unused_fd_flags(f_flags);
 	if (fd < 0)
 		goto out_destroy_group;
 
+	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
+					f_flags, FMODE_NONOTIFY);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		put_unused_fd(fd);
+		goto out_destroy_group;
+	}
+	fd_install(fd, file);
 	return fd;
 
 out_destroy_group:
diff --git a/fs/open.c b/fs/open.c
index e6911101fe71..c3490286092e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1105,6 +1105,23 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+				  const struct cred *cred)
+{
+	struct file *f = alloc_empty_file(flags, cred);
+	if (!IS_ERR(f)) {
+		int error;
+
+		f->f_mode |= FMODE_NONOTIFY;
+		error = vfs_open(path, f);
+		if (error) {
+			fput(f);
+			f = ERR_PTR(error);
+		}
+	}
+	return f;
+}
+
 /**
  * dentry_create - Create and open a file
  * @path: path to create
@@ -1202,7 +1219,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
@@ -1210,9 +1227,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			 "struct open_flags doesn't yet handle flags > 32 bits");
 
 	/*
-	 * Strip flags that either shouldn't be set by userspace like
-	 * FMODE_NONOTIFY or that aren't relevant in determining struct
-	 * open_flags like O_CLOEXEC.
+	 * Strip flags that aren't relevant in determining struct open_flags.
 	 */
 	flags &= ~strip;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9c13222362f5..23bd058576b1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2750,6 +2750,8 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
 }
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+				  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 struct path *backing_file_user_path(struct file *f);
@@ -3706,11 +3708,9 @@ struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
-#define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
 
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
-#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE)))
 
 static inline bool is_sxid(umode_t mode)
 {
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..613475285643 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -6,7 +6,6 @@
 
 /*
  * FMODE_EXEC is 0x20
- * FMODE_NONOTIFY is 0x4000000
  * These cannot be used by userspace O_* until internal and external open
  * flags are split.
  * -Eric Paris
-- 
2.43.0


