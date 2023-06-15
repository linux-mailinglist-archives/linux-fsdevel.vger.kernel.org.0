Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7C73166F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjFOLW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbjFOLWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDC2686;
        Thu, 15 Jun 2023 04:22:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f762b3227dso853939e87.1;
        Thu, 15 Jun 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828165; x=1689420165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEcbGVFG4tESuaYjS3NTBv8e9m8qkMy1ApkYohHcZTI=;
        b=V8h/G8WwIQREpVfIVxZ7JRE3S9ekP/LM5+AbLePbZBHCVfZ1T+WJJ4aYJAeqd5+vHq
         Wfydy4v6pc5J4oFzGoLKU8UKXcI6PXTa+Swv7Tbp+lDqBoc+O8JNzt0lem7ixs3k6L33
         LR1ZDqb8QNwjNjWRQzTQJ5MLF0U+ao95xOhkWK+IJhmZqaebzCwXy5J5vulAEAqjC913
         3z/4aUay5BYYmaqSzCBZhOThwInGWVIlQ4a7+p1tuT37NdOXEzjhOQp18bWpOrr7Vndo
         hiNEQ5NjUff30K1SY4RvPMKtXeFtWUtKoyLnrpCrbCZDAxcS9cIyi/N8wyq08MGmmWQg
         PA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828165; x=1689420165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEcbGVFG4tESuaYjS3NTBv8e9m8qkMy1ApkYohHcZTI=;
        b=cTeCooisMZpwzt4BkJfVQTvmwHeBfOZ7KlfR4OVGDPcQq04cFy0g3cVYk2uxH2wlXS
         vBj4qYcGNMXDhXUvO205Fb3cqxUCZktml9AjO1ACNumLVCJOn67gfYJGdYnTO7yq4QZO
         /ZYDD2uxRiebHWk7qbmXXMtVtCtVUlJdfcesJ3zW5YiWIq23VMekFpW54rCc9q+zYLCT
         de9TES4RWumWTtI/Y6E04hMKMpxXPM3z5VRlA1FTmuWmbBsiCtj2KhNwM3tyVO6sOKNH
         XTXvb8Z+Tp6MXhlnJE/hkv0jVQVpa/WLTQgI2eLPImytRvn9ZOFu7kGecobcwOkZkFGS
         eIJg==
X-Gm-Message-State: AC+VfDxhDvUDFbCvPywklENUbqNszq9PtGb/JzP83i18YP/Iv099hCb/
        k+YUUyF2Q2UzFAcfvym28Ljcq8dd7y8=
X-Google-Smtp-Source: ACHHUZ4Rb/p6IVCdYxbOxtWFKfIuZb/X2x741ItjNbf0qRtXplfOlyH1hv9SjDCM0FIR3WzgbBlTVg==
X-Received: by 2002:a05:6512:3f18:b0:4eb:46c2:e771 with SMTP id y24-20020a0565123f1800b004eb46c2e771mr1361610lfa.14.1686828165144;
        Thu, 15 Jun 2023 04:22:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 4/5] fs: use backing_file container for internal files with "fake" f_path
Date:   Thu, 15 Jun 2023 14:22:28 +0300
Message-Id: <20230615112229.2143178-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
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

Overlayfs uses open_with_fake_path() to allocate internal kernel files,
with a "fake" path - whose f_path is not on the same fs as f_inode.

Allocate a container struct backing_file for those internal files, that
is used to hold the "fake" ovl path along with the real path.

backing_file_real_path() can be used to access the stored real path.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c     | 50 +++++++++++++++++++++++++++++++++++++++++++--
 fs/internal.h       |  5 +++--
 fs/open.c           | 46 ++++++++++++++++++++++++++++++-----------
 fs/overlayfs/file.c |  4 ++--
 include/linux/fs.h  | 23 ++++++++++++++++-----
 5 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4bc713865212..34a832504369 100644
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
@@ -226,6 +248,30 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
+/*
+ * Variant of alloc_empty_file() that allocates a backing_file container
+ * and doesn't check and modify nr_files.
+ *
+ * This is only for kernel internal use, and the allocate file must not be
+ * installed into file tables or such.
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
index c5da2b3eb105..059d7024155a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1152,23 +1152,45 @@ struct file *kernel_file_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
-struct file *open_with_fake_path(const struct path *path, int flags,
-				struct inode *inode, const struct cred *cred)
+/**
+ * backing_file_open - open a backing file for kernel internal use
+ * @path:	path of the file to open
+ * @flags:	open flags
+ * @path:	path of the backing file
+ * @cred:	credentials for open
+ *
+ * Open a file whose f_inode != d_inode(f_path.dentry).
+ * the returned struct file is embedded inside a struct backing_file
+ * container which is used to store the @real_path of the inode.
+ * The @real_path can be accessed by backing_file_real_path() and the
+ * real dentry can be accessed with file_dentry().
+ * The kernel internal backing file is not accounted in nr_files.
+ * This is only for kernel internal use, and must not be installed into
+ * file tables or such.
+ */
+struct file *backing_file_open(const struct path *path, int flags,
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
+EXPORT_SYMBOL_GPL(backing_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
 #define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 39737c2aaa84..c610ae35b0b9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -61,8 +61,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-					       current_cred());
+		realfile = backing_file_open(&file->f_path, flags, realpath,
+					     current_cred());
 	}
 	revert_creds(old_cred);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1f8486e773af..ecf85a46fb2a 100644
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
 
@@ -2352,11 +2355,21 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
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
+struct file *backing_file_open(const struct path *path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred);
+struct path *backing_file_real_path(struct file *f);
+static inline const struct path *f_real_path(struct file *f)
+{
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		return backing_file_real_path(f);
+	return &f->f_path;
+}
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
-- 
2.34.1

