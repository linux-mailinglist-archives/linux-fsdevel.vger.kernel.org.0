Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656DA7BC631
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjJGIo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjJGIoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:44:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A6CA;
        Sat,  7 Oct 2023 01:44:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3231dff4343so1762928f8f.0;
        Sat, 07 Oct 2023 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696668283; x=1697273083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh64KTLq811QxyIR1Rlgppwwt1J8bEjNPZST/gnUEfU=;
        b=VUFr0JWlmP5DGQ7Yl1Q9zLgOoS7nx85NVR5JXgJU42PbFab2fLAYp3x/CAxaN2KHGZ
         Wrr5Lbn+tY/4J1y9IRHTwRtaATufFKUXsNs8xXNl16UWoxWYML96fcp9/CRKNMPRPsz1
         ncUp34Bknlb04yuq8Ys47IZnMrH8qLtvhOQDtUXKUWBG3j51YowG3X043RYb5y4gDR73
         mGR7dGjtJJoso+v8AXrrPHpdAmi7fqo9FEXiL/NV4AL4VJ0vo/zGQehyQBY4WNRCpwnl
         Ps5uezHK4J98nx3ipiERIS8wcKF/IxylmpD6WT3tzyEcO44dgZkjVbnezQ36XZIzyIIX
         gEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668283; x=1697273083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh64KTLq811QxyIR1Rlgppwwt1J8bEjNPZST/gnUEfU=;
        b=Nasgr07K3PDA3y5wWXj+1UmDNC+ocC7zl+q9dk2vOiWMer87KuazAR+L95PQrLJL6l
         JLVXRPmF+lVMF9zIDkY/pNjhYFjnaeYf/0JEpqH+x0h5Ih1ZUz1Hgi8MNW2jXo+FbtQA
         /gs64Dqtw7Ct6jcVCCc43feqh+uNgIylpzI2ckVhDlyGXajQMeD//MbofgR2hS5UEeO1
         BjOWT16deQnJ262dLz46GrRDOsK+j8+dgi2/SlOBREVbJyBW0CmgjriCX9FJ+uezyI5/
         cSfgIKKvqPxRIDHpj6G8a2WTMoU5f5RbvLodC7PKTme8K8B6zzFyGUlaewm29LZaL5pa
         d0aA==
X-Gm-Message-State: AOJu0Yxw8hesZJueW5hodiAOJYmYtddG0lddXa1H9x2Lcr8EY0GTluHI
        VcYK7FKGE9knz+gk4Prn6Bk=
X-Google-Smtp-Source: AGHT+IHT/e0dm68Vul7ENxp5BKPFXpt6nxCtq+TXetgIqL33dKDXE0ja0ZbpxIFJU63oiiWIwCMJ5Q==
X-Received: by 2002:adf:f9c8:0:b0:31f:d8be:a313 with SMTP id w8-20020adff9c8000000b0031fd8bea313mr7063228wrr.5.1696668283196;
        Sat, 07 Oct 2023 01:44:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm3677850wrq.56.2023.10.07.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:44:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] fs: store real path instead of fake path in backing file f_path
Date:   Sat,  7 Oct 2023 11:44:33 +0300
Message-Id: <20231007084433.1417887-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007084433.1417887-1-amir73il@gmail.com>
References: <20231007084433.1417887-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A backing file struct stores two path's, one "real" path that is referring
to f_inode and one "fake" path, which should be displayed to users in
/proc/<pid>/maps.

There is a lot more potential code that needs to know the "real" path, then
code that needs to know the "fake" path.

Instead of code having to request the "real" path with file_real_path(),
store the "real" path in f_path and require code that needs to know the
"fake" path request it with file_user_path().
Replace the file_real_path() helper with a simple const accessor f_path().

After this change, file_dentry() is not expected to observe any files
with overlayfs f_path and real f_inode, so the call to ->d_real() should
not be needed.  Leave the ->d_real() call for now and add an assertion
in ovl_d_real() to catch if we made wrong assumptions.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c          | 12 ++++++------
 fs/internal.h            |  6 +++---
 fs/open.c                | 27 +++++++++++++--------------
 fs/overlayfs/super.c     | 11 ++++++++++-
 include/linux/fs.h       | 19 +++++--------------
 include/linux/fsnotify.h |  3 +--
 6 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 08fd1dd6d863..fa92743ba6a9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -44,10 +44,10 @@ static struct kmem_cache *filp_cachep __read_mostly;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
-/* Container for backing file with optional real path */
+/* Container for backing file with optional user path */
 struct backing_file {
 	struct file file;
-	struct path real_path;
+	struct path user_path;
 };
 
 static inline struct backing_file *backing_file(struct file *f)
@@ -55,11 +55,11 @@ static inline struct backing_file *backing_file(struct file *f)
 	return container_of(f, struct backing_file, file);
 }
 
-struct path *backing_file_real_path(struct file *f)
+struct path *backing_file_user_path(struct file *f)
 {
-	return &backing_file(f)->real_path;
+	return &backing_file(f)->user_path;
 }
-EXPORT_SYMBOL_GPL(backing_file_real_path);
+EXPORT_SYMBOL_GPL(backing_file_user_path);
 
 static inline void file_free(struct file *f)
 {
@@ -68,7 +68,7 @@ static inline void file_free(struct file *f)
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_real_path(f));
+		path_put(backing_file_user_path(f));
 		kfree(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
diff --git a/fs/internal.h b/fs/internal.h
index 846d5133dd9c..652a1703668e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -101,10 +101,10 @@ static inline void file_put_write_access(struct file *file)
 	put_write_access(file->f_inode);
 	mnt_put_write_access(file->f_path.mnt);
 	if (unlikely(file->f_mode & FMODE_BACKING)) {
-		struct path *real_path = backing_file_real_path(file);
+		struct path *user_path = backing_file_user_path(file);
 
-		if (real_path->mnt)
-			mnt_put_write_access(real_path->mnt);
+		if (user_path->mnt)
+			mnt_put_write_access(user_path->mnt);
 	}
 }
 
diff --git a/fs/open.c b/fs/open.c
index 2f3e28512663..1bfedc314e49 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -881,10 +881,10 @@ static inline int file_get_write_access(struct file *f)
 	if (unlikely(error))
 		goto cleanup_inode;
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		struct path *real_path = backing_file_real_path(f);
+		struct path *user_path = backing_file_user_path(f);
 
-		if (real_path->mnt)
-			error = mnt_get_write_access(real_path->mnt);
+		if (user_path->mnt)
+			error = mnt_get_write_access(user_path->mnt);
 		if (unlikely(error))
 			goto cleanup_mnt;
 	}
@@ -1185,20 +1185,19 @@ EXPORT_SYMBOL_GPL(kernel_file_open);
 
 /**
  * backing_file_open - open a backing file for kernel internal use
- * @path:	path of the file to open
+ * @user_path:	path that the user reuqested to open
  * @flags:	open flags
  * @real_path:	path of the backing file
  * @cred:	credentials for open
  *
  * Open a backing file for a stackable filesystem (e.g., overlayfs).
- * @path may be on the stackable filesystem and backing inode on the
- * underlying filesystem. In this case, we want to be able to return
- * the @real_path of the backing inode. This is done by embedding the
- * returned file into a container structure that also stores the path of
- * the backing inode on the underlying filesystem, which can be
- * retrieved using backing_file_real_path().
+ * @user_path may be on the stackable filesystem and @real_path on the
+ * underlying filesystem.  In this case, we want to be able to return the
+ * @user_path of the stackable filesystem. This is done by embedding the
+ * returned file into a container structure that also stores the stacked
+ * file's path, which can be retrieved using backing_file_user_path().
  */
-struct file *backing_file_open(const struct path *path, int flags,
+struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred)
 {
@@ -1209,9 +1208,9 @@ struct file *backing_file_open(const struct path *path, int flags,
 	if (IS_ERR(f))
 		return f;
 
-	f->f_path = *path;
-	path_get(real_path);
-	*backing_file_real_path(f) = *real_path;
+	path_get(user_path);
+	*backing_file_user_path(f) = *user_path;
+	f->f_path = *real_path;
 	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
 	if (error) {
 		fput(f);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3fa2416264a4..0245db1a3e29 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -34,9 +34,18 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	struct dentry *real = NULL, *lower;
 	int err;
 
-	/* It's an overlay file */
+	/*
+	 * vfs is only expected to call d_real() with NULL from d_real_inode()
+	 * and with overlay inode from file_dentry() on an overlay file.
+	 *
+	 * TODO: remove @inode argument from d_real() API, remove code in this
+	 * function that deals with non-NULL @inode and remove d_real() call
+	 * from file_dentry().
+	 */
 	if (inode && d_inode(dentry) == inode)
 		return dentry;
+	else
+		WARN_ON_ONCE(inode);
 
 	if (!d_is_reg(dentry)) {
 		if (!inode || inode == d_inode(dentry))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a8e4e1cac48e..75073a9d0fab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2451,24 +2451,13 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct file *backing_file_open(const struct path *path, int flags,
+struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
-struct path *backing_file_real_path(struct file *f);
+struct path *backing_file_user_path(struct file *f);
 
-/*
- * file_real_path - get the path corresponding to f_inode
- *
- * When opening a backing file for a stackable filesystem (e.g.,
- * overlayfs) f_path may be on the stackable filesystem and f_inode on
- * the underlying filesystem.  When the path associated with f_inode is
- * needed, this helper should be used instead of accessing f_path
- * directly.
-*/
-static inline const struct path *file_real_path(struct file *f)
+static inline const struct path *f_path(struct file *f)
 {
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		return backing_file_real_path(f);
 	return &f->f_path;
 }
 
@@ -2483,6 +2472,8 @@ static inline const struct path *file_real_path(struct file *f)
  */
 static inline const struct path *file_user_path(struct file *f)
 {
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		return backing_file_user_path(f);
 	return &f->f_path;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ed48e4f1e755..001307e12a49 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -96,8 +96,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	/* Overlayfs internal files have fake f_path */
-	path = file_real_path(file);
+	path = f_path(file);
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
-- 
2.34.1

