Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E047BE516
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbjJIPiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377773AbjJIPht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A4133;
        Mon,  9 Oct 2023 08:37:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405417465aaso45093405e9.1;
        Mon, 09 Oct 2023 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865845; x=1697470645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+HQeegMFxdTmIDUpikNUTP1EtMcJMa5JsrdaHT+oHI=;
        b=RTONlsEOkrCOArytf6/vvcav2wand0FWjRSCuvH9GyLIQO1XlpiBzEl0EKlKHRFy+Z
         qUL21DjsuE42Pgt30EjUF6H/Xcu08KR+j2lExMP6wwnJT+A9rD7tw0lJ/oWv7b9NKKoS
         AuS44COFYNCO/vcYZVmZBISvd7jbJ1MWWJ49aOHwTR/YLDVw20EP0KWhtZrULA7w8DMn
         4d5BaTaHrRyc9u276BgiAogZ2uGC5N4VcHDTIyj1YuiNOUzHllJp9LzakbQpjNc+j2UP
         b37JUnKKIcwXra05GwzeIe9O7f1PiPD3gg7jmbCQpcJFbdbxNe9QrjvVvPLoeOHGPbXx
         YBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865845; x=1697470645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+HQeegMFxdTmIDUpikNUTP1EtMcJMa5JsrdaHT+oHI=;
        b=OlKvk2PvEKCdSeROV5M8EMBDIcwFZO7HsIieNLhcZBt8Gbzky2FM5yVbUSzqs917LG
         6OJ6Ua6ew+elWHZr4pDmMnu8TpQ7u2LwFDyJ6lA4PnDK7oVkc3PW1U7yJo1AO1IB+qTo
         8MRkMg45hXpgA+tjmAkxVHZqcdZZnZ1lsRsmIABur5fY7nK6HzSNdmxaAV1NdfvNA8qb
         jh0HcOJAcCnkEcmPmWUN1yG42jRQvYjvmm2ocytE6/Fm8huRKzoBpWWWrHTziursrwUs
         fV6OpquDFTW8/gZCFzhTR7bVY5qRYzBUmJvvzITISpxz1F1o09VWEUXW9+3XPgYNF82L
         yQbA==
X-Gm-Message-State: AOJu0YwWtR2Xq/nZNioVse/xkcCTqPqOnk1ZcjdBCiQbTT6hIQRLVcKB
        ASrjdqmlBBdi50vgxwP6tnA=
X-Google-Smtp-Source: AGHT+IFgK5KMOpEDr9wVY4CaERQNmSjbu5seeXhEaWKuEXZ/0l5iKQo6/MWCUvdOiy6PL/vWXvZQ0g==
X-Received: by 2002:adf:f74f:0:b0:319:68ba:7c8e with SMTP id z15-20020adff74f000000b0031968ba7c8emr13896792wrp.38.1696865844676;
        Mon, 09 Oct 2023 08:37:24 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm9939924wrx.44.2023.10.09.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:37:24 -0700 (PDT)
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
Subject: [PATCH v3 3/3] fs: store real path instead of fake path in backing file f_path
Date:   Mon,  9 Oct 2023 18:37:12 +0300
Message-Id: <20231009153712.1566422-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009153712.1566422-1-amir73il@gmail.com>
References: <20231009153712.1566422-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 fs/internal.h            |  2 +-
 fs/open.c                | 23 +++++++++++------------
 fs/overlayfs/super.c     | 16 ++++++++++++----
 include/linux/fs.h       | 22 ++++------------------
 include/linux/fsnotify.h |  3 +--
 6 files changed, 35 insertions(+), 43 deletions(-)

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
index 4e93a685bdaa..58e43341aebf 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -101,7 +101,7 @@ static inline void file_put_write_access(struct file *file)
 	put_write_access(file->f_inode);
 	mnt_put_write_access(file->f_path.mnt);
 	if (unlikely(file->f_mode & FMODE_BACKING))
-		mnt_put_write_access(backing_file_real_path(file)->mnt);
+		mnt_put_write_access(backing_file_user_path(file)->mnt);
 }
 
 static inline void put_file_access(struct file *file)
diff --git a/fs/open.c b/fs/open.c
index fe63e236da22..02dc608d40d8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -881,7 +881,7 @@ static inline int file_get_write_access(struct file *f)
 	if (unlikely(error))
 		goto cleanup_inode;
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		error = mnt_get_write_access(backing_file_real_path(f)->mnt);
+		error = mnt_get_write_access(backing_file_user_path(f)->mnt);
 		if (unlikely(error))
 			goto cleanup_mnt;
 	}
@@ -1182,20 +1182,19 @@ EXPORT_SYMBOL_GPL(kernel_file_open);
 
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
@@ -1206,9 +1205,9 @@ struct file *backing_file_open(const struct path *path, int flags,
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
index 3fa2416264a4..400a925a8ad2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -34,14 +34,22 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
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
+	else if (inode)
+		goto bug;
 
 	if (!d_is_reg(dentry)) {
-		if (!inode || inode == d_inode(dentry))
-			return dentry;
-		goto bug;
+		/* d_real_inode() is only relevant for regular files */
+		return dentry;
 	}
 
 	real = ovl_dentry_upper(dentry);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a8e4e1cac48e..b0624d83c2db 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2451,26 +2451,10 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct file *backing_file_open(const struct path *path, int flags,
+struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
-struct path *backing_file_real_path(struct file *f);
-
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
-{
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		return backing_file_real_path(f);
-	return &f->f_path;
-}
+struct path *backing_file_user_path(struct file *f);
 
 /*
  * file_user_path - get the path to display for memory mapped file
@@ -2483,6 +2467,8 @@ static inline const struct path *file_real_path(struct file *f)
  */
 static inline const struct path *file_user_path(struct file *f)
 {
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		return backing_file_user_path(f);
 	return &f->f_path;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ed48e4f1e755..bcb6609b54b3 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -96,8 +96,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	/* Overlayfs internal files have fake f_path */
-	path = file_real_path(file);
+	path = &file->f_path;
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
-- 
2.34.1

