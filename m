Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65ED72B3D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjFKTrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKTrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:47:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36806DA;
        Sun, 11 Jun 2023 12:47:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f81b449357so2826385e9.0;
        Sun, 11 Jun 2023 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686512832; x=1689104832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhlghnAl6W2asxV9Y7GGWtOwzuWHqU42v382S3Hk7ls=;
        b=as098wZ+DZHSi/8jpSkOURT4cKnqXSOThqjNwU9btYpjFm225jNO/6ER5TJGXrqALm
         KFxH4T+Lz/dpFRYJdqp/QG5y5h5Moy0mTHw/3I4e6qg8P8jse4WNwjpYtcQ/WT0h4UR5
         qqHEGzThEjZ+tLJ995ANkQGywYkisZKi8OifKLTO3COyyyyTouRSnvqN1teEj3MvZa15
         CBT6QsvsRP9eGL5omMJjWTtH9GWCGZcA9Bg/i492sl90RpdpNO0VSZLhG9Emq4r6S1FL
         bkR00ZC/4fCSxDDqVVCDVueC6wNLAMQhR2qqn65ksigNWBpeGWQEZZlAYXjWjLcmaBBD
         nmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512832; x=1689104832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhlghnAl6W2asxV9Y7GGWtOwzuWHqU42v382S3Hk7ls=;
        b=AqOF2ksnFnBiZWNGAOiqtMpBjdxH/alkdoZGVmZRVI+0KOlQMK2MfmpnpAwAzhCEF0
         ncSIFaTXkuZMzPVQYMNmUPOS0Fd28Ur80r+cFpmTDSzlmA8uK2Y6gzHRdyzFuTDHu5qS
         GszBSzXmCj7C8GGFdlMUchOiIYd/CLaQteZyXpcHQQCSm1CKcRhn0dGTmTrZg3lDubJi
         5CTqIb4ZnvFr+BQfgwqmQQxdK34sr68hPSUCGmpK4ROzQK9N7EH83hb7E0r2yiUj4QcR
         d4PLtOgIboYAlF+epUDqXLKlXp/mCdT4UaL+1k4fDnl5c5Lcu6iR0fOk87Z7xTkeBGqs
         GN0Q==
X-Gm-Message-State: AC+VfDzhhrknRJ8r4Xif57u53rjXi0Y2HHZPziGBBEwAh0qVnO0+DMXo
        1zOlhG8E7+ipBezAQyCZSYA=
X-Google-Smtp-Source: ACHHUZ4hqPcw+G/FckqRo9wFBCsb15HHcJm305lDRhn/GVrXg7UWpQpMJBqqBJaGvu5rcD3r0oznsQ==
X-Received: by 2002:a7b:c84c:0:b0:3f7:371a:ec8f with SMTP id c12-20020a7bc84c000000b003f7371aec8fmr5538701wml.15.1686512832486;
        Sun, 11 Jun 2023 12:47:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c211a00b003f42314832fsm9221902wml.18.2023.06.11.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:47:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v3 1/2] fs: use fake_file container for internal files with fake f_path
Date:   Sun, 11 Jun 2023 22:47:05 +0300
Message-Id: <20230611194706.1583818-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611194706.1583818-1-amir73il@gmail.com>
References: <20230611194706.1583818-1-amir73il@gmail.com>
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

Allocate a container struct file_fake for those internal files, that
is used to hold the fake path along with an optional real path.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/namei.c |  2 +-
 fs/file_table.c       | 91 ++++++++++++++++++++++++++++++++++++-------
 fs/internal.h         |  5 ++-
 fs/namei.c            | 16 ++++----
 fs/open.c             | 28 +++++++------
 fs/overlayfs/file.c   |  2 +-
 include/linux/fs.h    | 15 ++++---
 7 files changed, 117 insertions(+), 42 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..a71bdf2d03ba 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -561,7 +561,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(dentry), cache->cache_cred);
+				   &path, cache->cache_cred);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
 					   PTR_ERR(file),
diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..7c392f639fa1 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -44,18 +44,60 @@ static struct kmem_cache *filp_cachep __read_mostly;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+/* Container for file with optional fake path */
+struct file_fake {
+	struct file file;
+	struct path real_path;
+};
+
+static inline struct file_fake *file_fake(struct file *f)
+{
+	return container_of(f, struct file_fake, file);
+}
+
+/* Returns the real_path field that could be empty */
+struct path *__f_real_path(struct file *f)
+{
+	struct file_fake *ff = file_fake(f);
+
+	if (f->f_mode & FMODE_FAKE_PATH)
+		return &ff->real_path;
+	else
+		return &f->f_path;
+}
+
+/* Returns the real_path if not empty or f_path */
+const struct path *f_real_path(struct file *f)
+{
+	const struct path *path = __f_real_path(f);
+
+	return path->dentry ? path : &f->f_path;
+}
+EXPORT_SYMBOL(f_real_path);
+
+const struct path *f_fake_path(struct file *f)
+{
+	return &f->f_path;
+}
+EXPORT_SYMBOL(f_fake_path);
+
 static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);
 
 	put_cred(f->f_cred);
-	kmem_cache_free(filp_cachep, f);
+	if (f->f_mode & FMODE_FAKE_PATH)
+		kfree(file_fake(f));
+	else
+		kmem_cache_free(filp_cachep, f);
 }
 
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (f->f_mode & FMODE_FAKE_PATH)
+		path_put(__f_real_path(f));
+	else
 		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
@@ -131,20 +173,15 @@ static int __init init_fs_stat_sysctls(void)
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
@@ -155,6 +192,22 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
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
 
@@ -201,18 +254,26 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 }
 
 /*
- * Variant of alloc_empty_file() that doesn't check and modify nr_files.
+ * Variant of alloc_empty_file() that allocates a file_fake container
+ * and doesn't check and modify nr_files.
  *
  * Should not be used unless there's a very good reason to do so.
  */
-struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
+struct file *alloc_empty_file_fake(int flags, const struct cred *cred)
 {
-	struct file *f = __alloc_file(flags, cred);
+	struct file_fake *ff;
+	int error;
 
-	if (!IS_ERR(f))
-		f->f_mode |= FMODE_NOACCOUNT;
+	ff = kzalloc(sizeof(struct file_fake), GFP_KERNEL);
+	if (unlikely(!ff))
+		return ERR_PTR(-ENOMEM);
 
-	return f;
+	error = init_file(&ff->file, flags, cred);
+	if (unlikely(error))
+		return ERR_PTR(error);
+
+	ff->file.f_mode |= FMODE_FAKE_PATH;
+	return &ff->file;
 }
 
 /**
diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..df7956b74b08 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -97,8 +97,9 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 /*
  * file_table.c
  */
-extern struct file *alloc_empty_file(int, const struct cred *);
-extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
+extern struct file *alloc_empty_file(int flags, const struct cred *cred);
+extern struct file *alloc_empty_file_fake(int flags, const struct cred *cred);
+extern struct path *__f_real_path(struct file *f);
 
 static inline void put_file_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..329e89043277 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3721,14 +3721,16 @@ struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
 	struct file *file;
 	int error;
 
-	file = alloc_empty_file_noaccount(open_flag, cred);
-	if (!IS_ERR(file)) {
-		error = vfs_tmpfile(idmap, parentpath, file, mode);
-		if (error) {
-			fput(file);
-			file = ERR_PTR(error);
-		}
+	file = alloc_empty_file_fake(open_flag, cred);
+	if (IS_ERR(file))
+		return file;
+
+	error = vfs_tmpfile(idmap, parentpath, file, mode);
+	if (error) {
+		fput(file);
+		file = ERR_PTR(error);
 	}
+
 	return file;
 }
 EXPORT_SYMBOL(vfs_tmpfile_open);
diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..0398ab38ce0c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1116,20 +1116,26 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 }
 EXPORT_SYMBOL(dentry_create);
 
-struct file *open_with_fake_path(const struct path *path, int flags,
-				struct inode *inode, const struct cred *cred)
+struct file *open_with_fake_path(const struct path *fake_path, int flags,
+				 const struct path *real_path,
+				 const struct cred *cred)
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
+	f = alloc_empty_file_fake(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	f->f_path = *fake_path;
+	path_get(real_path);
+	*__f_real_path(f) = *real_path;
+	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
 	}
+
 	return f;
 }
 EXPORT_SYMBOL(open_with_fake_path);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 39737c2aaa84..6309dab46985 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -61,7 +61,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = open_with_fake_path(&file->f_path, flags, realinode,
+		realfile = open_with_fake_path(&file->f_path, flags, realpath,
 					       current_cred());
 	}
 	revert_creds(old_cred);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..2454025eee1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -180,8 +180,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File represents mount that needs unmounting */
 #define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
 
-/* File does not contribute to nr_files count */
-#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
+/* File is embedded in file_fake and doesn't contribute to nr_files */
+#define FMODE_FAKE_PATH		((__force fmode_t)0x20000000)
 
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
@@ -2349,11 +2349,16 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
 	return file_open_root(&(struct path){.mnt = mnt, .dentry = mnt->mnt_root},
 			      name, flags, mode);
 }
-extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *dentry_open(const struct path *path, int flags,
+				const struct cred *creds);
 extern struct file *dentry_create(const struct path *path, int flags,
 				  umode_t mode, const struct cred *cred);
-extern struct file * open_with_fake_path(const struct path *, int,
-					 struct inode*, const struct cred *);
+extern struct file *open_with_fake_path(const struct path *fake_path, int flags,
+					const struct path *real_path,
+					const struct cred *cred);
+extern const struct path *f_real_path(struct file *file);
+extern const struct path *f_fake_path(struct file *file);
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
-- 
2.34.1

