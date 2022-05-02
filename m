Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC257516E1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377522AbiEBK3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384682AbiEBK3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 06:29:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3DFD24;
        Mon,  2 May 2022 03:25:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso7005187pjb.5;
        Mon, 02 May 2022 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=l1dSrjQAuEBdUacWP6Ms303wdXzk6rFGelJiALQ8vx8=;
        b=OphJ2JRi6IalQLYDk5xioo+CJUSZo6HPlh9cPqp4cXNbYCbWpi/sd5e6hnuXArOfC+
         /YAR7jZXZYb8wDdm/3Ker+mcVmnpxsDcsm2/vrTlalB5KIJ5rKs+Fnv7nf6CJ4xfwEom
         FQT1Al1QXwvckFr/ZSoNOabjL0yn5v/97IEHCijw4COjsnGhd6Xc3H6tiFma8RNB2iWe
         8TKxe+gyzsVJXOw+4O+dYsfFTDKAiStetNRG+MHXmhatT0hCRMI38mTdm3j3MdFnETK0
         UQ3b2DX8EGaJqecIjnWPMJ73NM0UOkugkttB6mjru4A99cKbF0KDS8L9r48SNMVk8IUz
         Kzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=l1dSrjQAuEBdUacWP6Ms303wdXzk6rFGelJiALQ8vx8=;
        b=x1KmTWzJOEDETMmiNbRTRxfJfUaJbquXJgjjem7rCiUzrI/YKOhyr2QkjPMn2TPoRQ
         xM7Jd/mhBmyCYV482L7VriryT6ySNWjsJa263KwsFpUx2f+CePtzab4OYRJXBEhMJITP
         XISh+EzhdAzyDYJn4rVMq9Q29Nb35sF0ZoMgHKJqms2Su3KWFUJyABFWTOs7UP708h8e
         x6JnVi338moURx+CE1kYBmAeeCpnTZUjQaiVQ7Te228lq32Qh224mxtVyrGCFsGmXjI/
         Gfmdnz1r+eXScp1L8AcVNwAZVShPbCnTKEIGGLxgB4tnnKEDOBRio8ALWRNQC+KVoCHp
         hXqQ==
X-Gm-Message-State: AOAM533G2FKsPHzu/wY5+cxJ19VuwEV8YQaLOAkoz37Jxh25vx9f923m
        P4fkIlYUa4kUWulqrbvpbqc=
X-Google-Smtp-Source: ABdhPJzqSYbaNTH6joCYeUBSa7O5obu7n0hk3kK9x4ISQZ9KhBeOs6fVM6YHi3+2fWANS68A9k3CJA==
X-Received: by 2002:a17:90a:e7cb:b0:1dc:6602:7178 with SMTP id kb11-20020a17090ae7cb00b001dc66027178mr2423427pjb.175.1651487143059;
        Mon, 02 May 2022 03:25:43 -0700 (PDT)
Received: from localhost.localdomain ([123.201.245.164])
        by smtp.googlemail.com with ESMTPSA id j14-20020aa7800e000000b0050dc762816bsm4347953pfi.69.2022.05.02.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:25:42 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v4 2/3] FUSE: Implement atomic lookup + open
Date:   Mon,  2 May 2022 15:55:20 +0530
Message-Id: <20220502102521.22875-3-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220502102521.22875-1-dharamhans87@gmail.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dharmendra Singh <dsingh@ddn.com>

We can optimize aggressive lookups which are triggered when
there is normal open for file/dir (dentry is new/negative).

Here in this case since we are anyway going to open the file/dir
with USER SPACE, avoid this separate lookup call into libfuse
and combine it with open call into libfuse.

This lookup + open in single call to libfuse has been named
as atomic open. It is expected that USER SPACE opens the file
and fills in the attributes, which are then used to make inode
stand/revalidate in the kernel cache.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c             | 78 ++++++++++++++++++++++++++++++---------
 fs/fuse/fuse_i.h          |  3 ++
 fs/fuse/inode.c           |  4 +-
 include/uapi/linux/fuse.h |  2 +
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cad3322a007f..6879d3a86796 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -516,18 +516,18 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 }
 
 /*
- * Atomic create+open operation
- *
- * If the filesystem doesn't support this, then fall back to separate
- * 'mknod' + 'open' requests.
+ * This is common function for initiating atomic operations into libfuse.
+ * Currently being used by Atomic create(atomic lookup + create) and
+ * Atomic open(atomic lookup + open).
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, uint32_t opcode)
+static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
+				 struct dentry **alias, struct file *file,
+				 unsigned int flags, umode_t mode, uint32_t opcode)
 {
 	int err;
 	struct inode *inode;
 	struct fuse_mount *fm = get_fuse_mount(dir);
+	struct fuse_conn *fc = get_fuse_conn(dir);
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
 	struct fuse_create_in inarg;
@@ -539,9 +539,13 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
 	bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
+	bool create_op = (opcode == FUSE_CREATE ||
+			  opcode == FUSE_ATOMIC_CREATE) ? true : false;
+	if (alias)
+		*alias = NULL;
 
 	/* Userspace expects S_IFREG in create mode */
-	BUG_ON((mode & S_IFMT) != S_IFREG);
+	BUG_ON(create_op && (mode & S_IFMT) != S_IFREG);
 
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
@@ -553,7 +557,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!ff)
 		goto out_put_forget_req;
 
-	if (!fm->fc->dont_mask)
+	if (!fc->dont_mask)
 		mode &= ~current_umask();
 
 	flags &= ~O_NOCTTY;
@@ -642,8 +646,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 				err = PTR_ERR(res);
 				goto out_err;
 			}
-			/* res is expected to be NULL since its REG file */
-			WARN_ON(res);
+			entry = res;
+			if (alias)
+				*alias = res;
 		}
 	}
 	fuse_change_entry_timeout(entry, &outentry);
@@ -681,8 +686,8 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
 	if (fc->no_atomic_create)
 		return -ENOSYS;
 
-	err = fuse_create_open(dir, entry, file, flags, mode,
-			       FUSE_ATOMIC_CREATE);
+	err = fuse_atomic_do_common(dir, entry, NULL, file, flags, mode,
+				    FUSE_ATOMIC_CREATE);
 	/* If atomic create is not implemented then indicate in fc so that next
 	 * request falls back to normal create instead of going into libufse and
 	 * returning with -ENOSYS.
@@ -694,6 +699,29 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
+static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
+				struct dentry **alias, struct file *file,
+				unsigned int flags, umode_t mode)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (!fc->do_atomic_open)
+		return -ENOSYS;
+
+	err = fuse_atomic_do_common(dir, entry, alias, file, flags, mode,
+				    FUSE_ATOMIC_OPEN);
+	/* Atomic open imply atomic trunc as well i.e truncate should be performed
+	 * as part of atomic open call itself.
+	 */
+	if (!fc->atomic_o_trunc) {
+		if (fc->do_atomic_open)
+			fc->atomic_o_trunc = 1;
+	}
+
+	return err;
+}
+
 static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
@@ -702,12 +730,23 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 {
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct dentry *res = NULL;
+	struct dentry *res = NULL, *alias = NULL;
 	bool create = flags & O_CREAT ? true : false;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (!create) {
+		err = fuse_do_atomic_open(dir, entry, &alias,
+					  file, flags, mode);
+		res = alias;
+		if (!err || err != -ENOSYS)
+			goto out_dput;
+	}
+	 /*
+	  * ENOSYS fall back for open- user space does not have full
+	  * atomic open.
+	  */
 	if ((!create || fc->no_atomic_create) && d_in_lookup(entry)) {
 		res = fuse_lookup(dir, entry, 0);
 		if (IS_ERR(res))
@@ -730,9 +769,14 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	/* Libfuse/user space has not implemented atomic create, therefore
 	 * fall back to normal create.
 	 */
-	if (err == -ENOSYS)
-		err = fuse_create_open(dir, entry, file, flags, mode,
-				       FUSE_CREATE);
+	/* Atomic create+open operation
+	 * If the filesystem doesn't support this, then fall back to separate
+	 * 'mknod' + 'open' requests.
+	 */
+	if (err == -ENOSYS) {
+		err = fuse_atomic_do_common(dir, entry, NULL, file, flags,
+					    mode, FUSE_CREATE);
+	}
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d577a591ab16..24793b82303f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -669,6 +669,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is atomic open implemented by fs ? */
+	unsigned do_atomic_open : 1;
+
 	/** Is atomic create not implemented by fs? */
 	unsigned no_atomic_create:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ee846ce371d8..5f667de69115 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1190,6 +1190,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->setxattr_ext = 1;
 			if (flags & FUSE_SECURITY_CTX)
 				fc->init_security = 1;
+			if (flags & FUSE_DO_ATOMIC_OPEN)
+				fc->do_atomic_open = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1235,7 +1237,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX;
+		FUSE_SECURITY_CTX | FUSE_DO_ATOMIC_OPEN;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e4b56004b148..ab91e391241a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -391,6 +391,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_DO_ATOMIC_OPEN	(1ULL << 34)
 
 /**
  * CUSE INIT request/reply flags
@@ -540,6 +541,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_ATOMIC_CREATE	= 51,
+	FUSE_ATOMIC_OPEN	= 52,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.17.1

