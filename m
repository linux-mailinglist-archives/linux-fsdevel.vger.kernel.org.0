Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492024C2258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiBXD2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiBXD2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:28:13 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A814CD8C;
        Wed, 23 Feb 2022 19:27:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 75so637511pgb.4;
        Wed, 23 Feb 2022 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=EqTqbG22nPy0+F73wZdoZ2+JENECZ7gltb4t3SUedlU=;
        b=fCeqiNLIn6cD3ibV5it1hkRppJHEs7urCEdW+JndTbN9BUWY7Fa2wO9byY62Y38JCE
         xVoVvqMLPlD3xgZh0uPdHeORM913opyRuOqGXZr3wJpggAD0NDjLxkDUtLlAEeHonnm0
         oNMO4v6yZid5DY5WmYxgvsWs2VOTc+q9+qF7CLOY//jWGjm6nj8ZkuWUVSQkR3rrhiyN
         BpvMo2ujFMVVH48lKQYwkIvAgtmToj+kRMfMVkdfoa5IYAkEekWJbOqV8MVMRJNtwHrJ
         c8TmdEXr+je6KqvDcB7NcA5Fo2PyYRRNFzAJop4dtVJDvyV+oYVN6RZkE8P7i8RKifG5
         kT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=EqTqbG22nPy0+F73wZdoZ2+JENECZ7gltb4t3SUedlU=;
        b=gZTAYvmwFNDzSe0LhpuzVp9YvCvfeXwIJowAdC2wFeOEYSiJvZmMjPL5vyHTqDT3uG
         pLsWLJLZbSFlrC6E3LJ30CoofEuggGVGO+xYec7gi86dO+qvu/zPfFR+6AwCkAXMizhV
         En2j7RuOf1x24PyS6ya/xTrQLs3jWAbiiEmUjw5pv0CPIpw2YZgDbC4eSm/k8vBgvBHo
         QQF5tkimZfP13Cf8NrH0o0kGc37Fm2haFVsetTHtTtgLWENHoCVZQwUc8/hm0jFI8uis
         B08cmbk3Uzvjail9c++oe5CFBOCBG/kePADpFDVrQyTF1wN5cLHi2AKkiTGdyS35RSFR
         nkVA==
X-Gm-Message-State: AOAM531bA3esHM7cJ3xvpfKyYYgVhROR9NxOYkrVOW1uPsgDJbfc6ZFl
        vpkCNZmZZlu+KYBwAgOlrryWtrm/2tAlUODWZvM=
X-Google-Smtp-Source: ABdhPJzx9UjexHA8CQiEehW/T/5pTebS+BXzno38AEHglZXF8ROKW9k748udpBMHngfemGWb5E+vEw==
X-Received: by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id t18-20020a63d252000000b00363271cfe63mr771426pgi.524.1645673262909;
        Wed, 23 Feb 2022 19:27:42 -0800 (PST)
Received: from localhost.localdomain ([123.201.194.48])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm7236178pju.1.2022.02.23.19.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:27:42 -0800 (PST)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 2/2] FUSE: Avoid lookup in d_revalidate()
Date:   Thu, 24 Feb 2022 08:53:37 +0530
Message-Id: <20220224032337.19284-3-dharamhans87@gmail.com>
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

With atomic open + lookup implemented, it is possible
to avoid lookups in FUSE d_revalidate() for objects
other than directories.

If FUSE is mounted with default permissions then this
optimization is not possible as we need to fetch fresh
inode attributes for permission check. This lookup
skipped in d_revalidate() can be performed  as part of
open call into libfuse which is made from fuse_file_open().
And when we return from USER space with file opened and
fresh attributes, we can revalidate the inode.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c    | 81 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/file.c   | 30 ++++++++++++++++--
 fs/fuse/fuse_i.h | 10 +++++-
 fs/fuse/ioctl.c  |  2 +-
 4 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 48fb126d44ad..76c60eaee0c0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -196,6 +196,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
  * the lookup once more.  If the lookup results in the same inode,
  * then refresh the attributes, timeouts and mark the dentry valid.
  */
+
 static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 {
 	struct inode *inode;
@@ -224,6 +225,17 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
+		/* If atomic open is supported by FUSE then use this opportunity
+		 * (only for non-dir) to avoid this lookup and combine
+		 * lookup + open into single call.
+		 */
+		if (!fm->fc->default_permissions && fm->fc->do_atomic_open &&
+		    !(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
+		    (flags & LOOKUP_OPEN) && !S_ISDIR(inode->i_mode)) {
+			ret = 1;
+			goto out;
+		}
+
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -515,13 +527,50 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
+/*
+ * Revalidate the inode after we got fresh attributes from user space.
+ */
+static int fuse_atomic_open_revalidate_inode(struct inode *reval_inode,
+					     struct dentry *entry,
+					     struct fuse_inode *fi,
+					     struct fuse_forget_link *forget,
+					     struct fuse_entry_out *outentry,
+					     u64 attr_version)
+{
+	struct fuse_conn *fc = get_fuse_conn(reval_inode);
+	/* Mode should be other than directory */
+	BUG_ON(S_ISDIR(reval_inode->i_mode));
+
+	if (outentry->nodeid != get_node_id(reval_inode)) {
+		fuse_queue_forget(fc, forget, outentry->nodeid, 1);
+		return -ESTALE;
+	}
+	if (fuse_stale_inode(reval_inode, outentry->generation,
+			     &outentry->attr)) {
+		fuse_make_bad(reval_inode);
+		return -ESTALE;
+	}
+	fi = get_fuse_inode(reval_inode);
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_unlock(&fi->lock);
+
+	forget_all_cached_acls(reval_inode);
+	fuse_change_attributes(reval_inode, &outentry->attr,
+			       entry_attr_timeout(outentry), attr_version);
+	fuse_change_entry_timeout(entry, outentry);
+	return 0;
+}
+
+
+
 /*
  * Perform create + open or lookup + open in single call to libfuse
  */
-static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
-				   struct dentry **alias, struct file *file,
-				   unsigned int flags, umode_t mode,
-				   uint32_t opcode)
+int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
+			    struct dentry **alias, struct file *file,
+			    struct inode *reval_inode, unsigned int flags,
+			    umode_t mode, uint32_t opcode)
 {
 	bool create = (opcode == FUSE_CREATE ? true : false);
 	struct inode *inode;
@@ -536,6 +585,7 @@ static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
 	struct dentry *res = NULL;
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
+	u64 attr_version = fuse_get_attr_version(fm->fc);
 	int err;
 
 	if (alias)
@@ -616,6 +666,19 @@ static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
+
+	/* Inode revalidation was bypassed previously for type other than
+	 * directories, revalidate now as we got fresh attributes.
+	 */
+	if (reval_inode) {
+		err = fuse_atomic_open_revalidate_inode(reval_inode, entry, fi,
+							forget, &outentry,
+							attr_version);
+		if (err)
+			goto out_free_ff;
+		inode = reval_inode;
+		goto out_finish_open;
+	}
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
@@ -649,6 +712,7 @@ static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
 	if (create)
 		fuse_dir_changed(dir);
 	err = finish_open(file, entry, generic_file_open);
+out_finish_open:
 	if (err) {
 		fi = get_fuse_inode(inode);
 		fuse_sync_release(fi, ff, flags);
@@ -679,7 +743,7 @@ static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
 
 	if (!fc->do_atomic_open)
 		return -ENOSYS;
-	err = fuse_atomic_open_common(dir, entry, alias, file,
+	err = fuse_atomic_open_common(dir, entry, alias, file, NULL,
 				      flags, mode, FUSE_ATOMIC_OPEN);
 	return err;
 }
@@ -700,7 +764,8 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	/* Atomic lookup + open - dentry might be File or Directory */
 	if (!create) {
-		err = fuse_do_atomic_open(dir, entry, &alias, file, flags, mode);
+		err = fuse_do_atomic_open(dir, entry, &alias, file,
+					  flags, mode);
 		res = alias;
 		if (!err)
 			goto out_dput;
@@ -729,8 +794,8 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	 * If the filesystem doesn't support atomic create + open, then fall
 	 * back to separate 'mknod' + 'open' requests.
 	 */
-	err = fuse_atomic_open_common(dir, entry, NULL, file, flags, mode,
-				      FUSE_CREATE);
+	err = fuse_atomic_open_common(dir, entry, NULL, file, NULL, flags,
+				      mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..37eebfb90500 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -125,11 +125,15 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 }
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				 struct file *file, unsigned int open_flags,
+				 bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
+	struct dentry *dentry = NULL;
+	struct dentry *parent = NULL;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	int ret;
 
 	ff = fuse_file_alloc(fm);
 	if (!ff)
@@ -138,6 +142,11 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	ff->fh = 0;
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
+
+	/* For directories we already had lookup */
+	if (!isdir && fc->do_atomic_open && file != NULL)
+		goto revalidate_atomic_open;
+
 	if (isdir ? !fc->no_opendir : !fc->no_open) {
 		struct fuse_open_out outarg;
 		int err;
@@ -164,12 +173,27 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	ff->nodeid = nodeid;
 
 	return ff;
+
+revalidate_atomic_open:
+	dentry = file->f_path.dentry;
+	/* Get ref on parent */
+	parent = dget_parent(dentry);
+	ret = fuse_atomic_open_common(d_inode_rcu(parent), dentry, NULL, file,
+				      d_inode_rcu(dentry), open_flags, 0,
+				      FUSE_ATOMIC_OPEN);
+	dput(parent);
+	if (ret)
+		goto err_out;
+	ff = file->private_data;
+	return ff;
+err_out:
+	return ERR_PTR(ret);
 }
 
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file, file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
@@ -252,7 +276,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	}
 
 	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
-	if (!err)
+	if (!err && (!fc->do_atomic_open || isdir))
 		fuse_finish_open(inode, file);
 
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e4dc68a90b28..bb3cd0631ff2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1011,6 +1011,13 @@ void fuse_finish_open(struct inode *inode, struct file *file);
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
 
+/**
+ * Send atomic create + open or lookup + open
+ */
+int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
+			    struct dentry **alias, struct file *file,
+			    struct inode *reval_inode, unsigned int flags,
+			    umode_t mode, uint32_t opcode);
 /**
  * Send RELEASE or RELEASEDIR request
  */
@@ -1314,7 +1321,8 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 /* file.c */
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+				 struct file *file, unsigned int open_flags,
+				 bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fbc09dab1f85..63106a54ba1a 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -408,7 +408,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
-- 
2.17.1

