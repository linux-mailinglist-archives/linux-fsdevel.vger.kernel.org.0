Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6270729136
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjFIHeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjFIHeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:34:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D271F35BD;
        Fri,  9 Jun 2023 00:33:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so1504932f8f.2;
        Fri, 09 Jun 2023 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686295966; x=1688887966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNZfq/ItEyTny/vyyOcqS4JxQFivYJhej+ozQyhKfhU=;
        b=IXTNY21Z4hvhhhp+Es7gJ6+Rbrtg+Ph71F/70XMR1iAIs8qCdsZ8sk1MjGct07L5XV
         LukVxfGBaJES+1GPhh7Qda+/WfromxqIjMGdZ43spJx6BtrPvz+bnhpig+rFgEn94sAl
         gwMOrXvxm0H9H4Wv3/OJF4zHL718W4OdTn92N4ZDenLLTyPeqWBxuhTLD/HVEAsG4hwN
         3j7TIYJ2ySsIpi4clG1GcD8Mf/qh1TIAI09Izi7TPGgd2dmzByPVCy/eGXLoolTUpS9p
         1fNhmItHosKFOvrVXw7CK0SsZZ/P2lsB74WjOX+cqeoccFTPXBIGzJT8blSb9mnvh2Da
         Te9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295966; x=1688887966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNZfq/ItEyTny/vyyOcqS4JxQFivYJhej+ozQyhKfhU=;
        b=LvbP0Qthptmz7+Hx7SDhl62HDQtjkmR3CGjNcU1Rury33cHLUq6nBzucFmVJXiWm/h
         1A8Svye+Mkkq3rErmwLE9M6aX6AL1tXI7pJDJbtc2CNBGkaD8xAz84XwrNYcgGpxSFu8
         99cn0uEbK7uVwB3mGALn9j6pns38OU+Sjye3hfYZ5PnxPWlsCAyZqS4m0O5ywlxpZytc
         Hf9JhtFAIYyP+EVnWsQvkMIuUMvP6keRdly4YGMszLou65sC6pTB/ZUyXX3Q/u/pSwpL
         D28xLpW+XDDyvByQQqqhDcKCBdNAwvTte+RR6Qz9C9QDNvPUkdtV2y4vJWa+oFN3m+MS
         19zQ==
X-Gm-Message-State: AC+VfDxPoRXOB7CCJkqo1K74jMgScicVddAEv+TWuUDH6IkvWgFseMdF
        m6dcQGsWPHhh0FKF44q0xJM=
X-Google-Smtp-Source: ACHHUZ7Kyj1lJmcTA7SDXhb/Ku2BetUZIJWy2fTcGHDy1K9I1AELW8agaqHdwqIcEhGLrR4mR2qmew==
X-Received: by 2002:adf:e28d:0:b0:306:3b78:fe31 with SMTP id v13-20020adfe28d000000b003063b78fe31mr350718wri.69.1686295966423;
        Fri, 09 Jun 2023 00:32:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm3624528wrf.94.2023.06.09.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:32:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 1/3] fs: use fake_file container for internal files with fake f_path
Date:   Fri,  9 Jun 2023 10:32:37 +0300
Message-Id: <20230609073239.957184-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609073239.957184-1-amir73il@gmail.com>
References: <20230609073239.957184-1-amir73il@gmail.com>
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
will be used to hold the fake path qlong with the real path.

This commit does not populate the extra fake_path field and leaves the
overlayfs internal file's f_path fake.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/namei.c |  2 +-
 fs/file_table.c       | 85 +++++++++++++++++++++++++++++++++++--------
 fs/internal.h         |  5 ++-
 fs/namei.c            |  2 +-
 fs/open.c             | 11 +++---
 fs/overlayfs/file.c   |  2 +-
 include/linux/fs.h    | 13 ++++---
 7 files changed, 90 insertions(+), 30 deletions(-)

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
index 372653b92617..adc2a92faa52 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -44,18 +44,48 @@ static struct kmem_cache *filp_cachep __read_mostly;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+/* Container for file with optional fake path to display in /proc files */
+struct file_fake {
+	struct file file;
+	struct path fake_path;
+};
+
+static inline struct file_fake *file_fake(struct file *f)
+{
+	return container_of(f, struct file_fake, file);
+}
+
+/* Returns fake_path if one exists, f_path otherwise */
+const struct path *file_fake_path(struct file *f)
+{
+	struct file_fake *ff = file_fake(f);
+
+	if (!(f->f_mode & FMODE_FAKE_PATH) || !ff->fake_path.dentry)
+		return &f->f_path;
+
+	return &ff->fake_path;
+}
+EXPORT_SYMBOL(file_fake_path);
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
+	struct file_fake *ff = file_fake(f);
+
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (f->f_mode & FMODE_FAKE_PATH)
+		path_put(&ff->fake_path);
+	else
 		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
@@ -131,20 +161,15 @@ static int __init init_fs_stat_sysctls(void)
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
@@ -155,6 +180,22 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
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
 
@@ -201,18 +242,32 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 }
 
 /*
- * Variant of alloc_empty_file() that doesn't check and modify nr_files.
+ * Variant of alloc_empty_file() that allocates a file_fake container
+ * and doesn't check and modify nr_files.
  *
  * Should not be used unless there's a very good reason to do so.
  */
-struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
+struct file *alloc_empty_file_fake(const struct path *fake_path, int flags,
+				   const struct cred *cred)
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
+	if (fake_path) {
+		path_get(fake_path);
+		ff->fake_path = *fake_path;
+	}
+
+	return &ff->file;
 }
 
 /**
diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..8890c694745b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -97,8 +97,9 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 /*
  * file_table.c
  */
-extern struct file *alloc_empty_file(int, const struct cred *);
-extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
+extern struct file *alloc_empty_file(int flags, const struct cred *cred);
+extern struct file *alloc_empty_file_fake(const struct path *fake_path,
+					  int flags, const struct cred *cred);
 
 static inline void put_file_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..5e6de1f29f4e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3721,7 +3721,7 @@ struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
 	struct file *file;
 	int error;
 
-	file = alloc_empty_file_noaccount(open_flag, cred);
+	file = alloc_empty_file_fake(NULL, open_flag, cred);
 	if (!IS_ERR(file)) {
 		error = vfs_tmpfile(idmap, parentpath, file, mode);
 		if (error) {
diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..c9e2300a037d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1116,15 +1116,16 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 }
 EXPORT_SYMBOL(dentry_create);
 
-struct file *open_with_fake_path(const struct path *path, int flags,
-				struct inode *inode, const struct cred *cred)
+struct file *open_with_fake_path(const struct path *fake_path, int flags,
+				 const struct path *path,
+				 const struct cred *cred)
 {
-	struct file *f = alloc_empty_file_noaccount(flags, cred);
+	struct file *f = alloc_empty_file_fake(NULL, flags, cred);
 	if (!IS_ERR(f)) {
 		int error;
 
-		f->f_path = *path;
-		error = do_dentry_open(f, inode, NULL);
+		f->f_path = *fake_path;
+		error = do_dentry_open(f, d_inode(path->dentry), NULL);
 		if (error) {
 			fput(f);
 			f = ERR_PTR(error);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..f5987377e9eb 100644
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
index 21a981680856..b112a3c9b499 100644
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
@@ -2349,11 +2349,14 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
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
+					const struct path *path,
+					const struct cred *cred);
+extern const struct path *file_fake_path(struct file *file);
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
-- 
2.34.1

