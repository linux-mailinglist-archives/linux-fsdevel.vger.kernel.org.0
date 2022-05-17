Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05754529EE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiEQKKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbiEQKK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 06:10:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D52B48E5C;
        Tue, 17 May 2022 03:08:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m12so16908832plb.4;
        Tue, 17 May 2022 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=nSi8lK2ej4jIE2r69Kt4C5FMLn19t1lg4OcZ7Ppi7IU=;
        b=UWfYE+cpD9WMJu9KnJuygH3cS+SM3blxo0BVKxeZelk2xlsTyaklywaJVMXsx78o1I
         e7NLkGSQPUa7m5xcJ4WY7cDx01SSVqDjzIw1FQYlGfXCXsI+40h2/hVVrsgvqWfJ0hcz
         pC9QyV3mTFWk0VonSIC1kUSs7JuOnJwSy4C6e7rBo3hwy3MGVhdmzI8wNV59hfub/Tu9
         A7rAFlb4r44YbnrFU1nbwZC+dSJJ/SGeWbRrc7VIyO5j25rTMqxYAbrRNTvVZPys/sXB
         2u7gQP7/txtGSqwiT20JKgRrj8IJw3pXPCTcFRQMu74mz/mGcdHDLXXmtpFmCLaLllnP
         FPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=nSi8lK2ej4jIE2r69Kt4C5FMLn19t1lg4OcZ7Ppi7IU=;
        b=dG5kPtzYZrMXTlDhOsdEWmSTVnby1M6vVSPuWjAmp7LK7zJV+DDLROPBWSir+sZeaM
         a3v6j8BHl+lru0c/gzsb6JkiBRprN9t95HdxlOtv/jtJPfIDeae9eOh6FGAGR7gA3Ke0
         01cBbObRLlgwUwXJnY3RTEJXGdcEoezkJhN/H9EOYLc+6FrbqmufLpjxAMQ7z+nxFGqz
         rpBdgz9wX9OjpSG8vLtdyA/Mc4fFiY3g6MPmXfwiaHnC5+yUFzBgoOpL7frAAFooeP7/
         8lNk9AoNrlmEpRRebCuk3BZ1b71kmCHYV0a3nC+iGZWxe8fDlhv7unUEyl5b9PPo4zzP
         fXlQ==
X-Gm-Message-State: AOAM530/BTnJbXt4jsZOxKHAxMwDweKY7u7y11GSO2DkTG0tZivDjG8v
        HDwqN6ZMPEPslysOraCBKK8CcM9NapalkzZQ
X-Google-Smtp-Source: ABdhPJxgo0Wpy3KbEIsntRkAH+/+GKHFDPPdJ5mefTYTF58kO0wQA3UMMkLkCE2pprzLUInzPxu1Aw==
X-Received: by 2002:a17:902:e84d:b0:15e:b0af:477b with SMTP id t13-20020a170902e84d00b0015eb0af477bmr21452788plg.49.1652782096536;
        Tue, 17 May 2022 03:08:16 -0700 (PDT)
Received: from localhost.localdomain ([219.91.171.244])
        by smtp.googlemail.com with ESMTPSA id a10-20020a631a0a000000b003c6ab6ba06csm8202595pga.79.2022.05.17.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:08:16 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v5 3/3] FUSE: Implement atomic lookup + open
Date:   Tue, 17 May 2022 15:37:44 +0530
Message-Id: <20220517100744.26849-4-dharamhans87@gmail.com>
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
 fs/fuse/dir.c             | 109 ++++++++++++++++++++++++++++----------
 fs/fuse/fuse_i.h          |   3 ++
 include/uapi/linux/fuse.h |   2 +-
 3 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 517c9add014d..cb99e529b3e9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -516,14 +516,15 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 }
 
 /*
- * Atomic create+open operation
+ * If user has not implemented create ext or Atomic open + lookup
+ * then fall back to usual Atomic create/open operations.
  *
- * If the filesystem doesn't support this, then fall back to separate
- * 'mknod' + 'open' requests.
+ * If the filesystem doesn't support Atomic create + open, then
+ * fall back to separate 'mknod' + 'open' requests.
  */
 static int fuse_atomic_common(struct inode *dir, struct dentry *entry,
-			      struct file *file, unsigned int flags,
-			      umode_t mode, uint32_t opcode)
+			      struct dentry **alias, struct file *file,
+			      unsigned int flags, umode_t mode, uint32_t opcode)
 {
 	int err;
 	struct inode *inode;
@@ -538,10 +539,21 @@ static int fuse_atomic_common(struct inode *dir, struct dentry *entry,
 	struct dentry *res = NULL;
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
-	bool ext_create = (opcode == FUSE_CREATE_EXT ? true : false);
+	bool simple_create = (opcode == FUSE_CREATE ? true : false);
+	bool create_ops = (simple_create || opcode == FUSE_CREATE_EXT) ?
+			   true : false;
+	bool skipped_lookup = (opcode == FUSE_CREATE_EXT ||
+			       opcode == FUSE_ATOMIC_OPEN) ? true : false;
+
+	if (alias)
+		*alias = NULL;
 
 	/* Userspace expects S_IFREG in create mode */
-	BUG_ON((mode & S_IFMT) != S_IFREG);
+	if (create_ops && (mode & S_IFMT) != S_IFREG) {
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out_err;
+	}
 
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
@@ -616,33 +628,38 @@ static int fuse_atomic_common(struct inode *dir, struct dentry *entry,
 	}
 	kfree(forget);
 	/*
-	 * In extended create, fuse_lookup() was skipped, which also uses
-	 * d_splice_alias(). As we come directly here after picking up dentry
-	 * it is very much likely that dentry has DCACHE_PAR_LOOKUP flag set
-	 * on it so call d_splice_alias().
+	 * In extended create/atomic open, fuse_lookup() is skipped which also
+	 * uses d_splice_alias(). As we come directly here after picking up
+	 * dentry it is very much likely that dentry has DCACHE_PAR_LOOKUP flag
+	 * set on it so call d_splice_alias().
 	 */
-	if (!ext_create && !d_in_lookup(entry))
-		d_instantiate(entry, inode);
-	else {
+	if (skipped_lookup) {
 		res = d_splice_alias(inode, entry);
-		if (IS_ERR(res)) {
-			/* Close the file in user space, but do not unlink it,
-			 * if it was created - with network file systems other
-			 * clients might have already accessed it.
-			 */
-			fi = get_fuse_inode(inode);
-			fuse_sync_release(fi, ff, flags);
-			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
-			err = PTR_ERR(res);
-			goto out_err;
+		if (res) {
+			if (IS_ERR(res)) {
+				/* Close the file in user space, but do not unlink it,
+				 * if it was created - with network file systems other
+				 * clients might have already accessed it.
+				 */
+				fi = get_fuse_inode(inode);
+				fuse_sync_release(fi, ff, flags);
+				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+				err = PTR_ERR(res);
+				goto out_err;
+			}
+			entry = res;
+			if (alias)
+				*alias = res;
 		}
-	}
+	} else
+		d_instantiate(entry, inode);
+
 	fuse_change_entry_timeout(entry, &outentry);
 	/*
 	 * This should be always set when the file is created, but only
 	 * CREATE_EXT introduced FOPEN_FILE_CREATED to user space.
 	 */
-	if (!ext_create || (outopen.open_flags & FOPEN_FILE_CREATED)) {
+	if (simple_create || (outopen.open_flags & FOPEN_FILE_CREATED)) {
 		fuse_dir_changed(dir);
 		file->f_mode |= FMODE_CREATED;
 	}
@@ -674,7 +691,7 @@ static int fuse_create_ext(struct inode *dir, struct dentry *entry,
 	if (fc->no_create_ext)
 		return -ENOSYS;
 
-	err = fuse_atomic_common(dir, entry, file, flags, mode,
+	err = fuse_atomic_common(dir, entry, NULL, file, flags, mode,
 				 FUSE_CREATE_EXT);
 	/* If ext create is not implemented then indicate in fc so that next
 	 * request falls back to normal create instead of going into libufse and
@@ -687,6 +704,31 @@ static int fuse_create_ext(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
+static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
+				struct dentry **alias, struct file *file,
+				unsigned int flags, umode_t mode)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+
+	if (fc->no_atomic_open)
+		return -ENOSYS;
+
+	err = fuse_atomic_common(dir, entry, alias, file, flags, mode,
+				 FUSE_ATOMIC_OPEN);
+
+	/* Set if atomic open not implemented */
+	if (err == -ENOSYS) {
+		if (!fc->no_atomic_open)
+			fc->no_atomic_open = 1;
+
+	} else if (!fc->atomic_o_trunc) {
+		/* If atomic open is set then imply atomic truncate as well */
+		fc->atomic_o_trunc = 1;
+	}
+	return err;
+}
+
 static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
@@ -695,13 +737,22 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 {
 	int err;
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct dentry *res = NULL;
+	struct dentry *res = NULL, *alias = NULL;
 	bool create = flags & O_CREAT ? true : false;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (!create && !fc->no_atomic_open) {
+		err = fuse_do_atomic_open(dir, entry, &alias,
+					  file, flags, mode);
+		res = alias;
+		if (err != -ENOSYS)
+			goto out_dput;
+	}
+
 lookup:
+	/* Fall back to open- user space does not have full atomic open */
 	if ((!create || fc->no_create_ext) && d_in_lookup(entry)) {
 		res = fuse_lookup(dir, entry, 0);
 		if (IS_ERR(res))
@@ -723,7 +774,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		if (err == -ENOSYS)
 			goto lookup;
 	} else
-		err = fuse_atomic_common(dir, entry, file, flags, mode,
+		err = fuse_atomic_common(dir, entry, NULL, file, flags, mode,
 					 FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 266133dcab5e..949c230e14c7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -675,6 +675,9 @@ struct fuse_conn {
 	 */
 	unsigned no_create_ext:1;
 
+	/** Is atomic open implemented by fs ? */
+	unsigned no_atomic_open : 1;
+
 	/** Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index bebe4be3f1cb..f4c94e5bbffc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -540,7 +540,7 @@ enum fuse_opcode {
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
 	FUSE_CREATE_EXT		= 51,
-
+	FUSE_ATOMIC_OPEN	= 52,
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
-- 
2.17.1

