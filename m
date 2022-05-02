Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306A516A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383366AbiEBFuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377965AbiEBFuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:50:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AB33EA9E;
        Sun,  1 May 2022 22:46:48 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so10946829pgj.7;
        Sun, 01 May 2022 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=gOhjSMrjCwKbxjE2hP/4KxUnfkTZuZCh55gMElj3XMU=;
        b=hXVt2uaKx83KYv4DnHdOY2xnOK+1ASmvWdNb0jINLT1yhrSSVYEyG+8FVs468XcgkE
         4rOr9DuQQXpU1PYi1X9WVjzrm3OGfFVsD1L2XYWfKS3XoCmNvGXoIIP50cluBvbuH4lV
         8lIsf6vMUlPlL8LiyIBp9WpaoapL3YOCuSVZOWXXMahLHx97GLT8QSAifqajz58G4005
         IMv+QA2ktYtdAfKsrEz23NxfZaf69Ts+JXeObO73eVLlJGaNnAETFm+QsmKc4CIKbYoJ
         iePkNatil7yETgRfLYLzONe+3BKiD9oIVoRXrxsaSmyqE5EPMQgB4vHugFeUrr4d0mPD
         dBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=gOhjSMrjCwKbxjE2hP/4KxUnfkTZuZCh55gMElj3XMU=;
        b=ywqV804m26IHLt9CpDEHLIky9ijvBTY1wMCpBT7O6gori9stK8y9K5KbmD0hfB+g0g
         weYIWNOfwhM43qiJUhCenRhXZxtUyZGN2W6eE8AwTtFROME8ItgC3tSj+svvQZyZVJcE
         uCfjNqTwrt5ZHCNO3CThqocmrXUwVEd7RdIg0dqGtZXALNpB0u5b2hfxW4/KnsUfbA8X
         SBG+7gqoOecWjtrZAr8ErveLE+vWJdpPU1grq8VXAMAvr/u/6MYukaHWeIoLsDR/mWvP
         0mRh2WGxCNpmHUL5wUbN3P85RoikomSBy+gFJtepYGMWHbYzDHHeBDp1KHFxjLFxO3dE
         ZLWQ==
X-Gm-Message-State: AOAM533U+BSAXfkL0ikfa1PEty3OIyUnThQM8afZ+ZJd9kP/eFIE6qEK
        8yCGIzMeEvV9mWjoe0q5GEZAtbj2Ah9qrA==
X-Google-Smtp-Source: ABdhPJxZWYQLQn4lkgn1A4u6tESSLG6jHbD2F5EudzX+9HzON9WoceLp76RaLy3GrDawjV7FEUohrg==
X-Received: by 2002:a63:6fc4:0:b0:393:9567:16dc with SMTP id k187-20020a636fc4000000b00393956716dcmr8380956pgc.593.1651470407862;
        Sun, 01 May 2022 22:46:47 -0700 (PDT)
Received: from localhost.localdomain ([123.201.245.164])
        by smtp.googlemail.com with ESMTPSA id q20-20020a62e114000000b0050dc76281c8sm3787490pfh.162.2022.05.01.22.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 22:46:47 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v3 1/3] FUSE: Implement atomic lookup + create
Date:   Mon,  2 May 2022 11:16:26 +0530
Message-Id: <20220502054628.25826-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220502054628.25826-1-dharamhans87@gmail.com>
References: <20220502054628.25826-1-dharamhans87@gmail.com>
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

When we go for creating a file (O_CREAT), we trigger
a lookup to FUSE USER SPACE. It is very  much likely
that file does not exist yet as O_CREAT is passed to
open(). This lookup can be avoided and can be performed
as part of create call into libfuse.

This lookup + create in single call to libfuse and finally
to USER SPACE has been named as atomic create. It is expected
that USER SPACE create the file, open it and fills in the
attributes which are then used to make inode stand/revalidate
in the kernel cache. Also if file was newly created(does not
exist yet by this time) in USER SPACE then it should be indicated
in `struct fuse_file_info` by setting a bit which is again used by
libfuse to send some flags back to fuse kernel to indicate that
that file was newly created. These flags are used by kernel to
indicate changes in parent directory.

Fuse kernel automatically detects if atomic create is implemented
by libfuse/USER SPACE or not. And depending upon the outcome of
this check all further creates are decided to be atomic or non-atomic
creates.

If libfuse/USER SPACE has not implemented the atomic create operation
then by default behaviour remains same i.e we do not optimize lookup
calls which are triggered before create calls into libfuse.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c             | 82 +++++++++++++++++++++++++++++++++++----
 fs/fuse/fuse_i.h          |  3 ++
 include/uapi/linux/fuse.h |  3 ++
 3 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..cad3322a007f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -523,7 +523,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
  */
 static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
-			    umode_t mode)
+			    umode_t mode, uint32_t opcode)
 {
 	int err;
 	struct inode *inode;
@@ -535,8 +535,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	struct dentry *res = NULL;
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
+	bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
@@ -566,7 +568,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = FUSE_CREATE;
+	args.opcode = opcode;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 2;
 	args.in_args[0].size = sizeof(inarg);
@@ -613,9 +615,44 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 	}
 	kfree(forget);
-	d_instantiate(entry, inode);
+	/*
+	 * In atomic create, we skipped lookup and it is very much likely that
+	 * dentry has DCACHE_PAR_LOOKUP flag set on it so call d_splice_alias().
+	 * Note: Only REG file is allowed under create/atomic create.
+	 */
+	/* There is special case when at very first call where we check if
+	 * atomic create is implemented by USER SPACE/libfuse or not, we
+	 * skipped lookup. Now, in case where atomic create is not implemented
+	 * underlying, we fall back to FUSE_CREATE. here we are required to handle
+	 * DCACHE_PAR_LOOKUP flag.
+	 */
+	if (!atomic_create && !d_in_lookup(entry) && fm->fc->no_atomic_create)
+		d_instantiate(entry, inode);
+	else {
+		res = d_splice_alias(inode, entry);
+		if (res) {
+			 /* Close the file in user space, but do not unlink it,
+			  * if it was created - with network file systems other
+			  * clients might have already accessed it.
+			  */
+			if (IS_ERR(res)) {
+				fi = get_fuse_inode(inode);
+				fuse_sync_release(fi, ff, flags);
+				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+				err = PTR_ERR(res);
+				goto out_err;
+			}
+			/* res is expected to be NULL since its REG file */
+			WARN_ON(res);
+		}
+	}
 	fuse_change_entry_timeout(entry, &outentry);
-	fuse_dir_changed(dir);
+	/*
+	 * In case of atomic create, we want to indicate directory change
+	 * only if USER SPACE actually created the file.
+	 */
+	if (!atomic_create || (outopen.open_flags & FOPEN_FILE_CREATED))
+		fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fi = get_fuse_inode(inode);
@@ -634,6 +671,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
+static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
+			      struct file *file, unsigned int flags,
+			      umode_t mode)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fc->no_atomic_create)
+		return -ENOSYS;
+
+	err = fuse_create_open(dir, entry, file, flags, mode,
+			       FUSE_ATOMIC_CREATE);
+	/* If atomic create is not implemented then indicate in fc so that next
+	 * request falls back to normal create instead of going into libufse and
+	 * returning with -ENOSYS.
+	 */
+	if (err == -ENOSYS) {
+		if (!fc->no_atomic_create)
+			fc->no_atomic_create = 1;
+	}
+	return err;
+}
+
 static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
@@ -643,11 +703,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
+	bool create = flags & O_CREAT ? true : false;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
-	if (d_in_lookup(entry)) {
+	if ((!create || fc->no_atomic_create) && d_in_lookup(entry)) {
 		res = fuse_lookup(dir, entry, 0);
 		if (IS_ERR(res))
 			return PTR_ERR(res);
@@ -656,7 +717,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			entry = res;
 	}
 
-	if (!(flags & O_CREAT) || d_really_is_positive(entry))
+	if (!create || d_really_is_positive(entry))
 		goto no_open;
 
 	/* Only creates */
@@ -665,7 +726,13 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode);
+	err = fuse_atomic_create(dir, entry, file, flags, mode);
+	/* Libfuse/user space has not implemented atomic create, therefore
+	 * fall back to normal create.
+	 */
+	if (err == -ENOSYS)
+		err = fuse_create_open(dir, entry, file, flags, mode,
+				       FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -683,6 +750,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 }
 
 /*
+
  * Code shared between mknod, mkdir, symlink and link
  */
 static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e8e59fbdefeb..d577a591ab16 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -669,6 +669,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Is atomic create not implemented by fs? */
+	unsigned no_atomic_create:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..e4b56004b148 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -301,6 +301,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_FILE_CREATED: the file was actually created
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -308,6 +309,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_FILE_CREATED	(1 << 6)
 
 /**
  * INIT request/reply flags
@@ -537,6 +539,7 @@ enum fuse_opcode {
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
+	FUSE_ATOMIC_CREATE	= 51,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.17.1

