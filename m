Return-Path: <linux-fsdevel+bounces-20967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A97B8FB80F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5585284380
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F01487DD;
	Tue,  4 Jun 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifBz3601"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73021482F8;
	Tue,  4 Jun 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516400; cv=none; b=IKPwXz1t3ZMpof1j+JcFmq/bFuHCzNvgDKIC3ZgEHwoSjMC+Lx6hI5t2QzhcAHupNuP2Ox+vaoxopBmKf3gkhQkTMkEALgmomAxS/ve9IuStlc5+3T9TffeNnVIpOeKekMQ0Bft0pGdv3h8YY4FHWv98Ec/9KMjQC1VoxeMXwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516400; c=relaxed/simple;
	bh=QkW3SvG5lIBGi+xj5/6s/uyRlY3WWLtM5dqC8ElbGu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWKfmoJf/8hKiV19ILwsJLKOB9YLM2zMwtatTriY9o0XcdqPrzuGAbPRKqY/Im8mWccKinSCGO3uqlo9OMIRiS0TIEt36nFcpdwSPOF2APQDSksN6y37+SGufJX5QQ7WzG0aSKikxux3JTcxsbWwVEeo3s4oWFXpqeDHyZl1mV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifBz3601; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a66e9eac48fso142718766b.2;
        Tue, 04 Jun 2024 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717516397; x=1718121197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkzuhEo4BQwLs6INDRHAya/ilVzdn/qWQpTRJpM6bwU=;
        b=ifBz3601fODlXbkO8fPjY+CNjvptFRteSdJEsSWo1iagp9vkeqTiAXxnAr7ApXfCOW
         OBpydLpfH9q6DYvEAPktrnI3U7XNNi1iqgPoPNAvLx3Z8o63oX8XWhMqkDHs4YOGj5A3
         76yZozo/SjOLw/ImTXk//xgpJaMEPart74nrdHChHgbv6vwt1jrJ9WOTEyFID4CxPRdL
         EkWUFLP0ut2MfTqGid0yWZx4fnN53Zv3ieFlXvM7CZdSXyV2hV8hgA0AbbbNrs+thLHc
         ctHgctwttAoQBM7xD/IixkLXkFXfs6PMeQ8W2kccpQgkpnefWnTM6kGrfQ0AninJBYep
         N6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516397; x=1718121197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkzuhEo4BQwLs6INDRHAya/ilVzdn/qWQpTRJpM6bwU=;
        b=HE7gY8STZvj7vFUstAqSumg1gBzWj/IOtgijjeJLNKGXBJfTVI5+N1UQgafq3rWmkV
         wB8XzpU/lU8D6VeoDr573QudhMNzGwyLJ1pd8KHkrS5xt6FRNE/Lm0AB/j7ga7qVcf9F
         /FK0AfGYkyco5z34/xM9QLm3o5d8xkvwkCws4L2RiIRRxy5Z7gvYUFwyPUkoEtPAI56Y
         ztkmKSadsOJLrFGVlKoZ74Lt0/O/J3lHOqr9soYte1FNWP+LZDVu4Ll+gdo1zoH+vqDe
         gd6WUq56jsDfR6fL9yT0FTIQCu0JtQKxtFvggkHcQ5B6/VVx+k8NJDlDQqNTDpcyXeGF
         YC0A==
X-Forwarded-Encrypted: i=1; AJvYcCUX1X1NxSuH9fhDlsY3zBu2vt9B69wAljoftAlKbRGrdTF6gDrC6XeoEuECXF83e/LdGTSt5rJz9IyzPOESLO8kCy7d2ZqrakeZ4Sr6YQ5FiKvOcaRYQ97eUqfIHmW17tHVilNlcSj6gOa3YA==
X-Gm-Message-State: AOJu0YyCQFdiD6FE7ENJ6+cjzRvrp6/n3PDlfZuBNlJHkNsukwQ9m0it
	4y9uexZtTq7Na8Ew4zjnl+V+wm6d5Ys8Ckyy/LM9bsp60yo2aci8
X-Google-Smtp-Source: AGHT+IFr8HmHXhs0JYPKGkjVrHmJxxh9xiS7V7agvtpCEtFOygZyXTjd/Q2OFd5DXjS1KGIsAf/Lhg==
X-Received: by 2002:a17:906:5957:b0:a68:a958:db18 with SMTP id a640c23a62f3a-a68a958dcbamr681321066b.76.1717516397189;
        Tue, 04 Jun 2024 08:53:17 -0700 (PDT)
Received: from f.. (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e624db7esm423380066b.66.2024.06.04.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:53:16 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] vfs: retire user_path_at_empty and drop empty arg from getname_flags
Date: Tue,  4 Jun 2024 17:52:56 +0200
Message-ID: <20240604155257.109500-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604155257.109500-1-mjguzik@gmail.com>
References: <20240604155257.109500-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No users after do_readlinkat started doing the job on its own.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fsopen.c           |  2 +-
 fs/namei.c            | 16 +++++++---------
 fs/stat.c             |  6 +++---
 include/linux/fs.h    |  2 +-
 include/linux/namei.h |  8 +-------
 io_uring/statx.c      |  3 +--
 io_uring/xattr.c      |  4 ++--
 7 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 6593ae518115..e7d0080c4f8b 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -451,7 +451,7 @@ SYSCALL_DEFINE5(fsconfig,
 		fallthrough;
 	case FSCONFIG_SET_PATH:
 		param.type = fs_value_is_filename;
-		param.name = getname_flags(_value, lookup_flags, NULL);
+		param.name = getname_flags(_value, lookup_flags);
 		if (IS_ERR(param.name)) {
 			ret = PTR_ERR(param.name);
 			goto out_key;
diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..950ad6bdd9fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -126,7 +126,7 @@
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
 struct filename *
-getname_flags(const char __user *filename, int flags, int *empty)
+getname_flags(const char __user *filename, int flags)
 {
 	struct filename *result;
 	char *kname;
@@ -190,8 +190,6 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	atomic_set(&result->refcnt, 1);
 	/* The empty path is special. */
 	if (unlikely(!len)) {
-		if (empty)
-			*empty = 1;
 		if (!(flags & LOOKUP_EMPTY)) {
 			putname(result);
 			return ERR_PTR(-ENOENT);
@@ -209,13 +207,13 @@ getname_uflags(const char __user *filename, int uflags)
 {
 	int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
 
-	return getname_flags(filename, flags, NULL);
+	return getname_flags(filename, flags);
 }
 
 struct filename *
 getname(const char __user * filename)
 {
-	return getname_flags(filename, 0, NULL);
+	return getname_flags(filename, 0);
 }
 
 struct filename *
@@ -2922,16 +2920,16 @@ int path_pts(struct path *path)
 }
 #endif
 
-int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
-		 struct path *path, int *empty)
+int user_path_at(int dfd, const char __user *name, unsigned flags,
+		 struct path *path)
 {
-	struct filename *filename = getname_flags(name, flags, empty);
+	struct filename *filename = getname_flags(name, flags);
 	int ret = filename_lookup(dfd, filename, flags, path, NULL);
 
 	putname(filename);
 	return ret;
 }
-EXPORT_SYMBOL(user_path_at_empty);
+EXPORT_SYMBOL(user_path_at);
 
 int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode)
diff --git a/fs/stat.c b/fs/stat.c
index 7f7861544500..16aa1f5ceec4 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -300,7 +300,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
 			return vfs_fstat(dfd, stat);
 	}
 
-	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags), NULL);
+	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
 	putname(name);
 
@@ -496,7 +496,7 @@ static int do_readlinkat(int dfd, const char __user *pathname,
 		return -EINVAL;
 
 retry:
-	name = getname_flags(pathname, lookup_flags, NULL);
+	name = getname_flags(pathname, lookup_flags);
 	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (unlikely(error)) {
 		putname(name);
@@ -710,7 +710,7 @@ SYSCALL_DEFINE5(statx,
 	int ret;
 	struct filename *name;
 
-	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
+	name = getname_flags(filename, getname_statx_lookup_flags(flags));
 	ret = do_statx(dfd, name, flags, mask, buffer);
 	putname(name);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..dfe22a622df6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2685,7 +2685,7 @@ static inline struct file *file_clone_open(struct file *file)
 }
 extern int filp_close(struct file *, fl_owner_t id);
 
-extern struct filename *getname_flags(const char __user *, int, int *);
+extern struct filename *getname_flags(const char __user *, int);
 extern struct filename *getname_uflags(const char __user *, int);
 extern struct filename *getname(const char __user *);
 extern struct filename *getname_kernel(const char *);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 967aa9ea9f96..8ec8fed3bce8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -50,13 +50,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 extern int path_pts(struct path *path);
 
-extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-
-static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
-		 struct path *path)
-{
-	return user_path_at_empty(dfd, name, flags, path, NULL);
-}
+extern int user_path_at(int, const char __user *, unsigned, struct path *);
 
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
diff --git a/io_uring/statx.c b/io_uring/statx.c
index abb874209caa..f7f9b202eec0 100644
--- a/io_uring/statx.c
+++ b/io_uring/statx.c
@@ -37,8 +37,7 @@ int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	sx->flags = READ_ONCE(sqe->statx_flags);
 
 	sx->filename = getname_flags(path,
-				     getname_statx_lookup_flags(sx->flags),
-				     NULL);
+				     getname_statx_lookup_flags(sx->flags));
 
 	if (IS_ERR(sx->filename)) {
 		int ret = PTR_ERR(sx->filename);
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 44905b82eea8..6cf41c3bc369 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -96,7 +96,7 @@ int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
 
-	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
+	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
 	if (IS_ERR(ix->filename)) {
 		ret = PTR_ERR(ix->filename);
 		ix->filename = NULL;
@@ -189,7 +189,7 @@ int io_setxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
 
-	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
+	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
 	if (IS_ERR(ix->filename)) {
 		ret = PTR_ERR(ix->filename);
 		ix->filename = NULL;
-- 
2.39.2


