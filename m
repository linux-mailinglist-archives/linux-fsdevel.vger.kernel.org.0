Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991272B218
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjFKN1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjFKN1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:27:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B74D2;
        Sun, 11 Jun 2023 06:27:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30af0aa4812so2150139f8f.1;
        Sun, 11 Jun 2023 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686490060; x=1689082060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDMiGgKWvmu6WzWAFPT3sp5vW060cv+7js4Sg0EKubQ=;
        b=Or/p0zJx+HR1+5w/JxNtIY62lwq7nsIT4w1i2k0SxS9govIMuzRyqLcKqiXwWTnUCH
         xcfqV6TgkxhNXwlaL7IpF8bpjdCyjrCeXWk816SpYUQXiPcdBqxtdbubyNmM1aK0lZnj
         GJYXVy8BthWsXM0/Oz1x+YOH4nkvyummGkkGkGxD1hZcEQfi9138TsZObskeTpl+k2OS
         n5CdtPvSk3+b+fLfmIolmq5LjVSNhlUr0fIAUsbphuZgu+jQQdZRZOV/E9e4Onc3Fvr5
         rgyYNg9LtriMsFacGEg6lPVZ56beSBjscJiM7WvykyJtXHbLzZtH53zM8en3JX46AUd/
         naag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686490060; x=1689082060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDMiGgKWvmu6WzWAFPT3sp5vW060cv+7js4Sg0EKubQ=;
        b=fmMmZc2IVIBkDqxIGqeBQ8QI9YkGALuHIDIAfduWZ+kQykfvbDRm4JZbyIgpWmeuJo
         bGkkZYLcnjMZU89O8WJQUm6iJSpvSTuubBOm/ttw75geW0toTldKI+czG2kLvI4zoI65
         Ytz0+G+X32gDKEPIhUz+BE9XqFIjGd9yIRHT0NCmKKwR/gOzHTHfUg5nlWK7arCmxzcJ
         Z/UCt07sKrU7bNRSbUNukFgdt3Ea1aP9akDZE3sRVWCxLlhuxRVxQPeaQCaHyq7EDVyF
         PdSKcf0eE8uqoJFTD4XM4hq9IfFpQENwYFcchVVSUusFEihInwuB+cQiIPH2uyK3pcjZ
         KLTA==
X-Gm-Message-State: AC+VfDwPzU7o5xV8JByXLEcyzYYF7vEfqtJovbfpZNvC74IE9rwKgkNy
        UVCZdlTdUzP7Gpd3U4CJY5Q=
X-Google-Smtp-Source: ACHHUZ760Z6W6dPbRzmR/4VeIMdf+P1UCbDC5cu+LI2HdrSJYHtYoUnWZ6N+WEB+yojWuBh6shdSrw==
X-Received: by 2002:a05:6000:118a:b0:309:46f5:cea7 with SMTP id g10-20020a056000118a00b0030946f5cea7mr2210650wrx.17.1686490060577;
        Sun, 11 Jun 2023 06:27:40 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm9593940wrr.46.2023.06.11.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 06:27:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v2 2/3] fs: introduce f_real_path() helper
Date:   Sun, 11 Jun 2023 16:27:31 +0300
Message-Id: <20230611132732.1502040-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611132732.1502040-1-amir73il@gmail.com>
References: <20230611132732.1502040-1-amir73il@gmail.com>
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

Overlayfs knows the real path of underlying dentries.  Add an optional
struct vfsmount out argument to ->d_real(), so callers could compose the
real path.

Add a helper f_real_path() that uses this new interface to return the
real path of f_inode, for overlayfs internal files whose f_path if a
"fake" overlayfs path and f_inode is the underlying real inode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/locking.rst |  3 ++-
 Documentation/filesystems/vfs.rst     |  3 ++-
 fs/file_table.c                       | 23 +++++++++++++++++++++++
 fs/overlayfs/super.c                  | 27 ++++++++++++++++++---------
 include/linux/dcache.h                | 11 +++++++----
 include/linux/fs.h                    |  4 +++-
 6 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index aa1a233b0fa8..a6063b0c79fd 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -29,7 +29,8 @@ prototypes::
 	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
+	struct dentry *(*d_real)(struct dentry *, const struct inode *,
+				 struct vfsmount **pmnt);
 
 locking rules:
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 769be5230210..edafe824fca4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1264,7 +1264,8 @@ defined:
 		char *(*d_dname)(struct dentry *, char *, int);
 		struct vfsmount *(*d_automount)(struct path *);
 		int (*d_manage)(const struct path *, bool);
-		struct dentry *(*d_real)(struct dentry *, const struct inode *);
+		struct dentry *(*d_real)(struct dentry *, const struct inode *,
+					 struct vfsmount **pmnt);
 	};
 
 ``d_revalidate``
diff --git a/fs/file_table.c b/fs/file_table.c
index d64d3933f3e4..fa187ceb54d6 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -215,6 +215,29 @@ struct file *alloc_empty_file_internal(int flags, const struct cred *cred)
 	return f;
 }
 
+/**
+ * f_real_path - return the real path of an internal file with fake path
+ *
+ * @file: The file to query
+ *
+ * If f_path is on a union/overlay and f_inode is not, then return the
+ * underlying real path of f_inode.
+ * Otherwise return f_path (by value).
+ */
+struct path f_real_path(const struct file *f)
+{
+	struct path path;
+
+	if (!(f->f_mode & FMODE_INTERNAL) ||
+	    (d_inode(f->f_path.dentry) == f->f_inode))
+		return f->f_path;
+
+	path.mnt = f->f_path.mnt;
+	path.dentry = d_real(f->f_path.dentry, f->f_inode, &path.mnt);
+	return path;
+}
+EXPORT_SYMBOL(f_real_path);
+
 /**
  * alloc_file - allocate and initialize a 'struct file'
  *
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d9be5d318e1b..591c77b33ff3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -60,9 +60,11 @@ MODULE_PARM_DESC(metacopy,
 		 "Default to on or off for the metadata only copy up feature");
 
 static struct dentry *ovl_d_real(struct dentry *dentry,
-				 const struct inode *inode)
+				 const struct inode *inode,
+				 struct vfsmount **pmnt)
 {
 	struct dentry *real = NULL, *lower;
+	struct path realpath;
 
 	/* It's an overlay file */
 	if (inode && d_inode(dentry) == inode)
@@ -74,12 +76,13 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 		goto bug;
 	}
 
-	real = ovl_dentry_upper(dentry);
+	ovl_path_upper(dentry, &realpath);
+	real = realpath.dentry;
 	if (real && (inode == d_inode(real)))
-		return real;
+		goto found;
 
 	if (real && !inode && ovl_has_upperdata(d_inode(dentry)))
-		return real;
+		goto found;
 
 	/*
 	 * Best effort lazy lookup of lowerdata for !inode case to return
@@ -90,16 +93,22 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	 * when setting the uprobe.
 	 */
 	ovl_maybe_lookup_lowerdata(dentry);
-	lower = ovl_dentry_lowerdata(dentry);
+	ovl_path_lowerdata(dentry, &realpath);
+	lower = realpath.dentry;
 	if (!lower)
 		goto bug;
-	real = lower;
 
 	/* Handle recursion */
-	real = d_real(real, inode);
+	real = d_real(lower, inode, &realpath.mnt);
+
+	if (inode && inode != d_inode(real))
+		goto bug;
+
+found:
+	if (pmnt)
+		*pmnt = realpath.mnt;
+	return real;
 
-	if (!inode || inode == d_inode(real))
-		return real;
 bug:
 	WARN(1, "%s(%pd4, %s:%lu): real dentry (%p/%lu) not found\n",
 	     __func__, dentry, inode ? inode->i_sb->s_id : "NULL",
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..78a54d175662 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -139,7 +139,8 @@ struct dentry_operations {
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
+	struct dentry *(*d_real)(struct dentry *, const struct inode *,
+				 struct vfsmount **);
 } ____cacheline_aligned;
 
 /*
@@ -564,6 +565,7 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
  * d_real - Return the real dentry
  * @dentry: the dentry to query
  * @inode: inode to select the dentry from multiple layers (can be NULL)
+ * @pmnt: returns the real mnt in case @dentry is not real
  *
  * If dentry is on a union/overlay, then return the underlying, real dentry.
  * Otherwise return the dentry itself.
@@ -571,10 +573,11 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
  * See also: Documentation/filesystems/vfs.rst
  */
 static inline struct dentry *d_real(struct dentry *dentry,
-				    const struct inode *inode)
+				    const struct inode *inode,
+				    struct vfsmount **pmnt)
 {
 	if (unlikely(dentry->d_flags & DCACHE_OP_REAL))
-		return dentry->d_op->d_real(dentry, inode);
+		return dentry->d_op->d_real(dentry, inode, pmnt);
 	else
 		return dentry;
 }
@@ -589,7 +592,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 static inline struct inode *d_real_inode(const struct dentry *dentry)
 {
 	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
+	return d_inode(d_real((struct dentry *) dentry, NULL, NULL));
 }
 
 struct name_snapshot {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 13eec1e8ca86..d0129e9e0ae5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1042,7 +1042,7 @@ static inline struct inode *file_inode(const struct file *f)
 
 static inline struct dentry *file_dentry(const struct file *file)
 {
-	return d_real(file->f_path.dentry, file_inode(file));
+	return d_real(file->f_path.dentry, file_inode(file), NULL);
 }
 
 struct fasync_struct {
@@ -2354,6 +2354,8 @@ extern struct file *dentry_create(const struct path *path, int flags,
 				  umode_t mode, const struct cred *cred);
 extern struct file * open_with_fake_path(const struct path *, int,
 					 struct inode*, const struct cred *);
+extern struct path f_real_path(const struct file *f);
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
-- 
2.34.1

