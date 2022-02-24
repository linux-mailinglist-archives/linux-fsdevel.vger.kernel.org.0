Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C164C2262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiBXD2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBXD2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:28:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930151451F3;
        Wed, 23 Feb 2022 19:27:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso4532014pju.4;
        Wed, 23 Feb 2022 19:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=wpWe5O7EFXSzjubgSJYvFawDAlnWMvr3GYY6emfmRhE=;
        b=VyoxDqxegFT4OYZ0T4LGwVRlZ3/5NM0raMJPxOTvOwyBitX+43x6YULdP9LGpeWoag
         GLRtr1czCGTu2pJdJ+C/KZPTMdybX1TLx9p12kp/Aayf4uF4gkWQu8JzuWi49gAY7DlA
         jCtOjpNTblJxYB058JDa6q5s84yo5qvLUTsh3VpSdFlwmrrWXUcga523npQv4dnCSErm
         h/Xc2hCrsuib/lxwFBtsEdGsQqtPt/YoSiywTE3pQBlHoNDzCufgHJwgib8zzT/lSHSC
         V61qXuk8gwNkBgT3wte8+psVHp6VqBh9E4TQLaeUVZnEsHFX5jvAWsKnscxbgKrtJG84
         8UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=wpWe5O7EFXSzjubgSJYvFawDAlnWMvr3GYY6emfmRhE=;
        b=MahQHcFGdx8ASN9ON+/z3dILm0a9EFTUzgu7Irb+GsV4PsXtmlRA/3CTw4Jg5Xv6oX
         qO41qm2/dJ+cJI1npX2333/9nRrNYaE7yHx7+ZIx8/rCRFwkcRMdNDM4znkNfPyaxFrg
         IStiABAkJOKm6hd7rIikRiK+ao9ckPQqMzZbi0gSjebFFFItcuTQiE1tQhRUom+UTrqy
         TKZAd53B13xTX7hnWQuGAYNnJW6d1oNge2XWPiEWWG71g4wgyXmrfufWl+Eg+0T6wngB
         97GAmx5CuGlIl65XkJ2fE27lrgdBVhGTK8P/laD6o+9nGTct7NfdKby2fBP+lHCn04SW
         6TVA==
X-Gm-Message-State: AOAM5320NNe7rzlpQjKupxH+rL7fo41E8+WImZ0QngJiRgsyhXruBhsE
        o1TPNYfRIAcL2y78YwHI1b0=
X-Google-Smtp-Source: ABdhPJxncnTk+OcyBNz5+oTh/qIVH8uAv/3BZCykaSCZ6aoUgUkBuukHFu7cyDng5NTar2vvFeJuFA==
X-Received: by 2002:a17:90a:2e04:b0:1bc:a5db:bcdb with SMTP id q4-20020a17090a2e0400b001bca5dbbcdbmr4807311pjd.116.1645673256980;
        Wed, 23 Feb 2022 19:27:36 -0800 (PST)
Received: from localhost.localdomain ([123.201.194.48])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm7236178pju.1.2022.02.23.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:27:36 -0800 (PST)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 1/2] FUSE: Implement atomic lookup + open
Date:   Thu, 24 Feb 2022 08:53:36 +0530
Message-Id: <20220224032337.19284-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224032337.19284-1-dharamhans87@gmail.com>
References: <20220224032337.19284-1-dharamhans87@gmail.com>
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

There are couple of places in FUSE where we do agressive
lookup.
1) When we go for creating a file (O_CREAT), we do lookup
for non-existent file. It is very much likely that file
does not exists yet as O_CREAT is passed to open(). This
lookup can be avoided and can be performed  as part of
open call into libfuse.

2) When there is normal open for file/dir (dentry is
new/negative). In this case since we are anyway going to open
the file/dir with USER space, avoid this separate lookup call
into libfuse and combine it with open.

This lookup + open in single call to libfuse and finally to
USER space has been named as atomic open. It is expected
that USER space open the file and fills in the attributes
which are then used to make inode stand/revalidate in the
kernel cache.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c             | 105 ++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h          |   3 ++
 fs/fuse/inode.c           |   4 +-
 include/uapi/linux/fuse.h |   2 +
 4 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..48fb126d44ad 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -516,16 +516,14 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 }
 
 /*
- * Atomic create+open operation
- *
- * If the filesystem doesn't support this, then fall back to separate
- * 'mknod' + 'open' requests.
+ * Perform create + open or lookup + open in single call to libfuse
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode)
+static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
+				   struct dentry **alias, struct file *file,
+				   unsigned int flags, umode_t mode,
+				   uint32_t opcode)
 {
-	int err;
+	bool create = (opcode == FUSE_CREATE ? true : false);
 	struct inode *inode;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
@@ -535,11 +533,16 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	struct dentry *res = NULL;
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
+	int err;
+
+	if (alias)
+		*alias = NULL;
 
 	/* Userspace expects S_IFREG in create mode */
-	BUG_ON((mode & S_IFMT) != S_IFREG);
+	BUG_ON(create && (mode & S_IFMT) != S_IFREG);
 
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
@@ -554,7 +557,13 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
-	flags &= ~O_NOCTTY;
+	if (!create) {
+		flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+		if (!fm->fc->atomic_o_trunc)
+			flags &= ~O_TRUNC;
+	} else {
+		flags &= ~O_NOCTTY;
+	}
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outentry, 0, sizeof(outentry));
 	inarg.flags = flags;
@@ -566,7 +575,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = FUSE_CREATE;
+	args.opcode = opcode;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 2;
 	args.in_args[0].size = sizeof(inarg);
@@ -595,8 +604,12 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (err)
 		goto out_free_ff;
 
+	err = -ENOENT;
+	if (!S_ISDIR(outentry.attr.mode) && !outentry.nodeid)
+		goto out_free_ff;
+
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
+	if (invalid_nodeid(outentry.nodeid) ||
 	    fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
@@ -612,10 +625,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		err = -ENOMEM;
 		goto out_err;
 	}
+	/*
+	 * Close the file in user space, but do not unlink it, if it was
+	 * created - with network file systems other clients might have
+	 * already accessed it.
+	 */
+	res = d_splice_alias(inode, entry);
+	if (res) {
+		if (IS_ERR(res)) {
+			fi = get_fuse_inode(inode);
+			fuse_sync_release(fi, ff, flags);
+			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+			err = PTR_ERR(res);
+			goto out_err;
+		} else {
+			entry = res;
+			if (alias)
+				*alias = res;
+		}
+	}
 	kfree(forget);
-	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
-	fuse_dir_changed(dir);
+	if (create)
+		fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fi = get_fuse_inode(inode);
@@ -634,20 +666,49 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
+/*
+ * Atomic lookup + open
+ */
+
+static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
+			       struct dentry **alias, struct file *file,
+			       unsigned int flags, umode_t mode)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (!fc->do_atomic_open)
+		return -ENOSYS;
+	err = fuse_atomic_open_common(dir, entry, alias, file,
+				      flags, mode, FUSE_ATOMIC_OPEN);
+	return err;
+}
+
 static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
-	int err;
+	bool create = (flags & O_CREAT) ? true : false;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct dentry *res = NULL;
+	struct dentry *res = NULL, *alias = NULL;
+	int err;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
-	if (d_in_lookup(entry)) {
+	/* Atomic lookup + open - dentry might be File or Directory */
+	if (!create) {
+		err = fuse_do_atomic_open(dir, entry, &alias, file, flags, mode);
+		res = alias;
+		if (!err)
+			goto out_dput;
+		else if (err != -ENOSYS)
+			goto no_open;
+	}
+	/* ENOSYS fall back - user space does not have full atomic open */
+	if (!create && d_in_lookup(entry))  {
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
@@ -664,8 +725,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	if (fc->no_create)
 		goto mknod;
-
-	err = fuse_create_open(dir, entry, file, flags, mode);
+	/*
+	 * If the filesystem doesn't support atomic create + open, then fall
+	 * back to separate 'mknod' + 'open' requests.
+	 */
+	err = fuse_atomic_open_common(dir, entry, NULL, file, flags, mode,
+				      FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e8e59fbdefeb..e4dc68a90b28 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -669,6 +669,9 @@ struct fuse_conn {
 	/** Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
+	/** Does the filesystem support atomic open? */
+	unsigned do_atomic_open:1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ee846ce371d8..2a14131cb9fe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1190,6 +1190,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->setxattr_ext = 1;
 			if (flags & FUSE_SECURITY_CTX)
 				fc->init_security = 1;
+			if (arg->flags & FUSE_DO_ATOMIC_OPEN)
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
index d6ccee961891..a28dd60078ff 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -389,6 +389,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_DO_ATOMIC_OPEN	(1ULL << 34)
 
 /**
  * CUSE INIT request/reply flags
@@ -537,6 +538,7 @@ enum fuse_opcode {
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
+	FUSE_ATOMIC_OPEN        = 51,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.17.1

