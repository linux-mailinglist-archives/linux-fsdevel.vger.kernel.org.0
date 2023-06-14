Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2D72F6AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjFNHtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjFNHtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27EB10DA;
        Wed, 14 Jun 2023 00:49:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so2445705e9.1;
        Wed, 14 Jun 2023 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686728956; x=1689320956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liBdOI6IQOOHsKY1Byn7cHqISun4VtRQY6LGXOb4iEg=;
        b=cSSr01Fjvuq4gBpAApsngAasc9ro5XyzVknHXf/TgbIs4tMEMBOed69LexEKsH95sb
         M6g8MWgqqIKYK8/BcXtBih4NoxruV4SVcx2sgS/SNIj1pN9ZhsOsOrPUStMarx04OlCG
         vNZiSSAzZRgNgQdHWl4L2/FYbzk7fNNU9iHdUm0Wx65tXYe9Jxa75N2tDXg+5QB2qtWj
         2syhQvsApc0pDfku39dgmrHwKRHrnJUvUylpJlypUUbeWgp4OjRrQTIqn4E9J0aZ/T3Z
         3nXT1Xcw6d9hmZcckOrlr9YAwtJ/kV2KCdsSSOOfJMEH0TIsE3iKfgCCClvZmlpGVzdv
         qNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686728956; x=1689320956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liBdOI6IQOOHsKY1Byn7cHqISun4VtRQY6LGXOb4iEg=;
        b=UgvW/bIaCDw49I/VDiKX5dCBYVaAS1obHqpRJVUs4htxGYG3JyCZsv1GTa1SiwxYvl
         z0e9Z4RKup6Ugz84BSjj1ol60qDydRSodZbofNX25t2vulRphq/JTAMlZSSkVM1ngpSp
         YSzcgzrO6jCUZ7nk9SbEb1iTFl+vGbj9QXp+HMceCkTkrJ1GEgsLyUt1QhNle08q/kAh
         VSDGA3nJVkZJfRunouLYAnVZv+hchbd5ZEEYXwIPcVeg8TkKXrRHoY9sSqMazQM/PIw9
         NpDoF6rmHFq4vASWZAWCkhUm03sI8S3FjsgtGTpgwd5XRSxjHQNZAEfZCm6grSEgN3E0
         4hzA==
X-Gm-Message-State: AC+VfDyrCQKudstorUdWcW7Y9tLGw2B7eLaK21yGM07nTBy+Z//E7l8H
        zMz1CO8+l/OGF1H5IjUYRrY=
X-Google-Smtp-Source: ACHHUZ6WK/HlS/W+44Ic7av/+09h0DnQC6isGYL4U3EAqlR5cQJlNxEC5HZOyedB3fLl7Npk4tKHzw==
X-Received: by 2002:a7b:c446:0:b0:3f8:d898:c936 with SMTP id l6-20020a7bc446000000b003f8d898c936mr622142wmi.38.1686728956012;
        Wed, 14 Jun 2023 00:49:16 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm17588257wrf.72.2023.06.14.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:49:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v4 1/2] fs: use backing_file container for internal files with "fake" f_path
Date:   Wed, 14 Jun 2023 10:49:06 +0300
Message-Id: <20230614074907.1943007-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614074907.1943007-1-amir73il@gmail.com>
References: <20230614074907.1943007-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs and cachefiles use open_with_fake_path() to allocate internal
files, where overlayfs also puts a "fake" path in f_path - a path which
is not on the same fs as f_inode.

Allocate a container struct backing_file for those internal files, that
is used to hold the "fake" ovl path along with the real path.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/namei.c |  4 +--
 fs/file_table.c       | 74 +++++++++++++++++++++++++++++++++++++------
 fs/internal.h         |  5 +--
 fs/open.c             | 30 +++++++++++-------
 fs/overlayfs/file.c   |  4 +--
 include/linux/fs.h    | 24 +++++++++++---
 6 files changed, 109 insertions(+), 32 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..283534c6bc8d 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -560,8 +560,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 */
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(dentry), cache->cache_cred);
+	file = open_backing_file(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				 &path, cache->cache_cred);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
 					   PTR_ERR(file),
diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..138d5d405df7 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -44,18 +44,40 @@ static struct kmem_cache *filp_cachep __read_mostly;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+/* Container for backing file with optional real path */
+struct backing_file {
+	struct file file;
+	struct path real_path;
+};
+
+static inline struct backing_file *backing_file(struct file *f)
+{
+	return container_of(f, struct backing_file, file);
+}
+
+struct path *backing_file_real_path(struct file *f)
+{
+	return &backing_file(f)->real_path;
+}
+EXPORT_SYMBOL_GPL(backing_file_real_path);
+
 static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);
 
 	put_cred(f->f_cred);
-	kmem_cache_free(filp_cachep, f);
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		kfree(backing_file(f));
+	else
+		kmem_cache_free(filp_cachep, f);
 }
 
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		path_put(backing_file_real_path(f));
+	else
 		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
@@ -131,20 +153,15 @@ static int __init init_fs_stat_sysctls(void)
 fs_initcall(init_fs_stat_sysctls);
 #endif
 
-static struct file *__alloc_file(int flags, const struct cred *cred)
+static int init_file(struct file *f, int flags, const struct cred *cred)
 {
-	struct file *f;
 	int error;
 
-	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
-	if (unlikely(!f))
-		return ERR_PTR(-ENOMEM);
-
 	f->f_cred = get_cred(cred);
 	error = security_file_alloc(f);
 	if (unlikely(error)) {
 		file_free_rcu(&f->f_rcuhead);
-		return ERR_PTR(error);
+		return error;
 	}
 
 	atomic_long_set(&f->f_count, 1);
@@ -155,6 +172,22 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
 
+	return 0;
+}
+
+static struct file *__alloc_file(int flags, const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+	if (unlikely(!f))
+		return ERR_PTR(-ENOMEM);
+
+	error = init_file(f, flags, cred);
+	if (unlikely(error))
+		return ERR_PTR(error);
+
 	return f;
 }
 
@@ -215,6 +248,29 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
+/*
+ * Variant of alloc_empty_file() that allocates a backing_file container
+ * and doesn't check and modify nr_files.
+ *
+ * Should not be used unless there's a very good reason to do so.
+ */
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+{
+	struct backing_file *ff;
+	int error;
+
+	ff = kzalloc(sizeof(struct backing_file), GFP_KERNEL);
+	if (unlikely(!ff))
+		return ERR_PTR(-ENOMEM);
+
+	error = init_file(&ff->file, flags, cred);
+	if (unlikely(error))
+		return ERR_PTR(error);
+
+	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	return &ff->file;
+}
+
 /**
  * alloc_file - allocate and initialize a 'struct file'
  *
diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..9c31078e0d16 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -97,8 +97,9 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 /*
  * file_table.c
  */
-extern struct file *alloc_empty_file(int, const struct cred *);
-extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
+struct file *alloc_empty_file(int flags, const struct cred *cred);
+struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
 
 static inline void put_file_access(struct file *file)
 {
diff --git a/fs/open.c b/fs/open.c
index 005ca91a173b..8f745e07a037 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1121,23 +1121,29 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 }
 EXPORT_SYMBOL(dentry_create);
 
-struct file *open_with_fake_path(const struct path *path, int flags,
-				struct inode *inode, const struct cred *cred)
+struct file *open_backing_file(const struct path *path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred)
 {
-	struct file *f = alloc_empty_file_noaccount(flags, cred);
-	if (!IS_ERR(f)) {
-		int error;
+	struct file *f;
+	int error;
 
-		f->f_path = *path;
-		error = do_dentry_open(f, inode, NULL);
-		if (error) {
-			fput(f);
-			f = ERR_PTR(error);
-		}
+	f = alloc_empty_backing_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	f->f_path = *path;
+	path_get(real_path);
+	*backing_file_real_path(f) = *real_path;
+	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
 	}
+
 	return f;
 }
-EXPORT_SYMBOL(open_with_fake_path);
+EXPORT_SYMBOL(open_backing_file);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
 #define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 39737c2aaa84..8cf099aa97de 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -61,8 +61,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-					       current_cred());
+		realfile = open_backing_file(&file->f_path, flags, realpath,
+					     current_cred());
 	}
 	revert_creds(old_cred);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..8393408b9885 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -171,6 +171,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports non-exclusive O_DIRECT writes from multiple threads */
 #define FMODE_DIO_PARALLEL_WRITE	((__force fmode_t)0x1000000)
 
+/* File is embedded in backing_file object */
+#define FMODE_BACKING		((__force fmode_t)0x2000000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
@@ -2349,11 +2352,22 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
 	return file_open_root(&(struct path){.mnt = mnt, .dentry = mnt->mnt_root},
 			      name, flags, mode);
 }
-extern struct file * dentry_open(const struct path *, int, const struct cred *);
-extern struct file *dentry_create(const struct path *path, int flags,
-				  umode_t mode, const struct cred *cred);
-extern struct file * open_with_fake_path(const struct path *, int,
-					 struct inode*, const struct cred *);
+struct file *dentry_open(const struct path *path, int flags,
+			 const struct cred *creds);
+struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+			   const struct cred *cred);
+struct file *open_backing_file(const struct path *path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred);
+struct path *backing_file_real_path(struct file *f);
+static inline const struct path *f_real_path(struct file *f)
+{
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		return backing_file_real_path(f);
+	else
+		return &f->f_path;
+}
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
-- 
2.34.1

