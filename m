Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED8529EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiEQKJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbiEQKIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 06:08:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC432F3AF;
        Tue, 17 May 2022 03:08:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso1816330pjb.3;
        Tue, 17 May 2022 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=KC2IL7bq9JaftL0PBIHzRSzDKaZoyx/rqcDB3M8Fc1c=;
        b=FheqoOtNnbai//NihxwErCMS8fCSMCwGzE0rOFHhUfTl/knBuOmyY+2Oy7WPtlI0Wl
         eB5ywjvR0vzP/af0YkFJHH7f8v3Ak3tA5N2STkinB3bhcTKJ/E1ixdzBTAx5DR1yui3+
         KCtILyaTy2RLlKqq/V+apBmYuyMRhQv8xaLUqEKD+VqH6g+6o0Iz6leATav98xuGM8zv
         CcI0vqeRtlnRMDPD/cCwihkqXnZt8+dYgUzpBvFpK0y96cGz7XtfCFnbHV1xuvDsSzfa
         cVMIR6SQZ3w4kDY8e+xfGjRSp6FPN6wrvVvpMQ2FLoEnJU6BLpT7Q/zIA8nRIXmNomb/
         kOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=KC2IL7bq9JaftL0PBIHzRSzDKaZoyx/rqcDB3M8Fc1c=;
        b=y74fwugfetgCl2Cg0n6+Me+B3bsaQ2uwB02UgTQBgDqJL8RQ6b5Kvti2Zzmg+Krx7t
         996WMnd/8kkdKx2UQqJTzu4o4pTVgO56wY8vL/WqjeS4TjNsuwS6tLLFJFOtniCNncGW
         EjAT5ufd4Wmc3AGB8/XbwFvA4+qNBT7AdFbSbBWQCWjgmObKGto7HBppxHJBY5SwWzbd
         OSh1n07g+Bk7+LgYmp9VKXBkNy1PqdEr7lzCRWmOFRgyV4TyjeRx1g4dj98kNxr3poog
         meMJHVgVRHTSUW5NICgdoF3q6Pj6Vi1MBfWf87bcKa4d1Q2En+xfZa7on9jYRJpN7oKP
         S9xA==
X-Gm-Message-State: AOAM530GbDsLe1NLDQ6+3uKUUKaEIThTZ/vsaF/m4H6pNKgstqOxXgx8
        VLGUkITn4VZMcSlgZjQjDTk=
X-Google-Smtp-Source: ABdhPJytqSM+LRkVD/ZDSIVem1/MzIRqNvzDCVWiqI4gMrVJmeUCXmrAqh50p+VEgQdT82WMMdPLlQ==
X-Received: by 2002:a17:902:a583:b0:15d:197b:9259 with SMTP id az3-20020a170902a58300b0015d197b9259mr22135914plb.51.1652782086087;
        Tue, 17 May 2022 03:08:06 -0700 (PDT)
Received: from localhost.localdomain ([219.91.171.244])
        by smtp.googlemail.com with ESMTPSA id a10-20020a631a0a000000b003c6ab6ba06csm8202595pga.79.2022.05.17.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:08:05 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v5 1/3] FUSE: Avoid lookups in fuse create
Date:   Tue, 17 May 2022 15:37:42 +0530
Message-Id: <20220517100744.26849-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517100744.26849-1-dharamhans87@gmail.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
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
a lookup to FUSE USER space. It is very  much likely
that file does not exist yet as O_CREAT is passed to
open(). This extra lookup call can be avoided.

Here is how current fuse create works:

A. Looks up dentry (if d_in_lookup() is set.
B. If dentry is positive or O_CREAT is not set, return.
C. If server supports atomic create + open, use that to create file
   and open it as well.
D. If server does not support atomic create + open, just create file
   using "mknod" and return. VFS will take care of opening the file.

Here is how the proposed patch would work:

A. Skip lookup if extended create is supported and file is being
   created.
B. Remains same. if dentry is positive or O_CREATE is not set, return.
C. If server supports new extended create, use that.
D. If not, if server supports atomic create + open, use that
E. If not, fall back to mknod and do not open file.

(Current code returns file attributes from user space as part of
 reply of FUSE_CREATE call itself.)

It is expected that USER SPACE create the file, open it and fills in
the attributes which are then used to make inode stand/revalidate
in the kernel cache. Also if file was newly created(does not
exist yet by this time) in USER SPACE then it should be indicated
in `struct fuse_file_info` by setting a bit which is again used by
libfuse to send some flags back to fuse kernel to indicate that
that file was newly created. These flags are used by kernel to
indicate changes in parent directory.

Fuse kernel automatically detects if extended create is implemented
by libfuse/USER SPACE or not. And depending upon the outcome of
this check all further creates are decided to be extended create or
the old create way.

If libfuse/USER SPACE has not implemented the extended create operation
then by default behaviour remains same i.e we do not optimize lookup
calls which are triggered before create calls into libfuse.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c             | 84 +++++++++++++++++++++++++++++++++------
 fs/fuse/fuse_i.h          |  6 +++
 include/uapi/linux/fuse.h |  3 ++
 3 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..ed9da8d6b57b 100644
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
+	bool ext_create = (opcode == FUSE_CREATE_EXT ? true : false);
 
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
@@ -613,9 +615,37 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 	}
 	kfree(forget);
-	d_instantiate(entry, inode);
+	/*
+	 * In extended create, fuse_lookup() was skipped, which also uses
+	 * d_splice_alias(). As we come directly here after picking up dentry
+	 * it is very much likely that dentry has DCACHE_PAR_LOOKUP flag set
+	 * on it so call d_splice_alias().
+	 */
+	if (!ext_create && !d_in_lookup(entry))
+		d_instantiate(entry, inode);
+	else {
+		res = d_splice_alias(inode, entry);
+		if (IS_ERR(res)) {
+			/* Close the file in user space, but do not unlink it,
+			 * if it was created - with network file systems other
+			 * clients might have already accessed it.
+			 */
+			fi = get_fuse_inode(inode);
+			fuse_sync_release(fi, ff, flags);
+			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+			err = PTR_ERR(res);
+			goto out_err;
+		}
+	}
 	fuse_change_entry_timeout(entry, &outentry);
-	fuse_dir_changed(dir);
+	/*
+	 * This should be always set when the file is created, but only
+	 * CREATE_EXT introduced FOPEN_FILE_CREATED to user space.
+	 */
+	if (!ext_create || (outopen.open_flags & FOPEN_FILE_CREATED)) {
+		fuse_dir_changed(dir);
+		file->f_mode |= FMODE_CREATED;
+	}
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fi = get_fuse_inode(inode);
@@ -634,6 +664,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
+static int fuse_create_ext(struct inode *dir, struct dentry *entry,
+			   struct file *file, unsigned int flags,
+			   umode_t mode)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fc->no_create_ext)
+		return -ENOSYS;
+
+	err = fuse_create_open(dir, entry, file, flags, mode,
+			       FUSE_CREATE_EXT);
+	/* If ext create is not implemented then indicate in fc so that next
+	 * request falls back to normal create instead of going into libufse and
+	 * returning with -ENOSYS.
+	 */
+	if (err == -ENOSYS) {
+		if (!fc->no_create_ext)
+			fc->no_create_ext = 1;
+	}
+	return err;
+}
+
 static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
@@ -643,29 +696,35 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
+	bool create = flags & O_CREAT ? true : false;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
-	if (d_in_lookup(entry)) {
+lookup:
+	if ((!create || fc->no_create_ext) && d_in_lookup(entry)) {
 		res = fuse_lookup(dir, entry, 0);
 		if (IS_ERR(res))
 			return PTR_ERR(res);
-
 		if (res)
 			entry = res;
 	}
-
-	if (!(flags & O_CREAT) || d_really_is_positive(entry))
+	if (!create || d_really_is_positive(entry))
 		goto no_open;
 
-	/* Only creates */
-	file->f_mode |= FMODE_CREATED;
-
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode);
+	if (!fc->no_create_ext) {
+		err = fuse_create_ext(dir, entry, file, flags, mode);
+		/* If libfuse/user space has not implemented extended create,
+		 * fall back to normal create.
+		 */
+		if (err == -ENOSYS)
+			goto lookup;
+	} else
+		err = fuse_create_open(dir, entry, file, flags, mode,
+				       FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -683,6 +742,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 }
 
 /*
+
  * Code shared between mknod, mkdir, symlink and link
  */
 static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e8e59fbdefeb..266133dcab5e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -669,6 +669,12 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/*
+	 * Is atomic lookup-create-open(extended create) not implemented
+	 * by fs?
+	 */
+	unsigned no_create_ext:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..bebe4be3f1cb 100644
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
+	FUSE_CREATE_EXT		= 51,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.17.1

