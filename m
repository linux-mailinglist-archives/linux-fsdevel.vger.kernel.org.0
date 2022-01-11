Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BAA48B6A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiAKTQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36102 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350438AbiAKTQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 348B56178A;
        Tue, 11 Jan 2022 19:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27282C36AE9;
        Tue, 11 Jan 2022 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928574;
        bh=dDO/k3+l+20uzV0XwxYnwTcnQ3PC7QIuE5FjKri9rTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSk4kv08l8o2mbAGEyBjLgDxJzXZWwHdNApri7uhDQdWpNl0m2i2vI1ZEJH/mGf4O
         jva4HkwLpXal6iQHaD+eCIYw6IlD9Q6aMAJMGgTlkE5sEzfZ9rJr7+nJX5tAmw8Tvh
         G6ZsGv7iLY4oDkVm7K0HfeHCtlB6ng/qmuUjKZC/aVYLIDdkoSau52eKluBfdrmktp
         5y8ky+0gllq+1PtVgUH+AD0Kp+Srt/yUpNfKkZwWNu1ky0K/+1Mws8BOMx+BDGIZAn
         KtnHBJBAcTMDfHMTpDT7Z2YzRtMohhOc+cCcsSA+U3Yh/SAdYc4kGwgzSvAQb7n9uS
         66qNWd5QAFuAQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 05/48] ceph: preallocate inode for ops that may create one
Date:   Tue, 11 Jan 2022 14:15:25 -0500
Message-Id: <20220111191608.88762-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When creating a new inode, we need to determine the crypto context
before we can transmit the RPC. The fscrypt API has a routine for getting
a crypto context before a create occurs, but it requires an inode.

Change the ceph code to preallocate an inode in advance of a create of
any sort (open(), mknod(), symlink(), etc). Move the existing code that
generates the ACL and SELinux blobs into this routine since that's
mostly common across all the different codepaths.

In most cases, we just want to allow ceph_fill_trace to use that inode
after the reply comes in, so add a new field to the MDS request for it
(r_new_inode).

The async create codepath is a bit different though. In that case, we
want to hash the inode in advance of the RPC so that it can be used
before the reply comes in. If the call subsequently fails with
-EJUKEBOX, then just put the references and clean up the as_ctx. Note
that with this change, we now need to regenerate the as_ctx when this
occurs, but it's quite rare for it to happen.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c        | 70 ++++++++++++++++++++-----------------
 fs/ceph/file.c       | 62 ++++++++++++++++++++-------------
 fs/ceph/inode.c      | 82 ++++++++++++++++++++++++++++++++++++++++----
 fs/ceph/mds_client.c |  3 +-
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  7 +++-
 6 files changed, 160 insertions(+), 65 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 133dbd9338e7..288f6f0b4b74 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -852,13 +852,6 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 	}
 
-	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
-	if (err < 0)
-		goto out;
-	err = ceph_security_init_secctx(dentry, mode, &as_ctx);
-	if (err < 0)
-		goto out;
-
 	dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
 	     dir, dentry, mode, rdev);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
@@ -866,6 +859,14 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		err = PTR_ERR(req);
 		goto out;
 	}
+
+	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
+	if (IS_ERR(req->r_new_inode)) {
+		err = PTR_ERR(req->r_new_inode);
+		req->r_new_inode = NULL;
+		goto out_req;
+	}
+
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_parent = dir;
@@ -875,13 +876,13 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-	if (as_ctx.pagelist) {
-		req->r_pagelist = as_ctx.pagelist;
-		as_ctx.pagelist = NULL;
-	}
+
+	ceph_as_ctx_to_req(req, &as_ctx);
+
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+out_req:
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
@@ -904,6 +905,7 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	umode_t mode = S_IFLNK | 0777;
 	int err;
 
 	if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -914,21 +916,24 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 	}
 
-	err = ceph_security_init_secctx(dentry, S_IFLNK | 0777, &as_ctx);
-	if (err < 0)
-		goto out;
-
 	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out;
 	}
+
+	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
+	if (IS_ERR(req->r_new_inode)) {
+		err = PTR_ERR(req->r_new_inode);
+		req->r_new_inode = NULL;
+		goto out_req;
+	}
+
 	req->r_path2 = kstrdup(dest, GFP_KERNEL);
 	if (!req->r_path2) {
 		err = -ENOMEM;
-		ceph_mdsc_put_request(req);
-		goto out;
+		goto out_req;
 	}
 	req->r_parent = dir;
 	ihold(dir);
@@ -938,13 +943,13 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-	if (as_ctx.pagelist) {
-		req->r_pagelist = as_ctx.pagelist;
-		as_ctx.pagelist = NULL;
-	}
+
+	ceph_as_ctx_to_req(req, &as_ctx);
+
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+out_req:
 	ceph_mdsc_put_request(req);
 out:
 	if (err)
@@ -980,13 +985,6 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 	}
 
-	mode |= S_IFDIR;
-	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
-	if (err < 0)
-		goto out;
-	err = ceph_security_init_secctx(dentry, mode, &as_ctx);
-	if (err < 0)
-		goto out;
 
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
@@ -994,6 +992,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 	}
 
+	mode |= S_IFDIR;
+	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
+	if (IS_ERR(req->r_new_inode)) {
+		err = PTR_ERR(req->r_new_inode);
+		req->r_new_inode = NULL;
+		goto out_req;
+	}
+
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_parent = dir;
@@ -1002,15 +1008,15 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-	if (as_ctx.pagelist) {
-		req->r_pagelist = as_ctx.pagelist;
-		as_ctx.pagelist = NULL;
-	}
+
+	ceph_as_ctx_to_req(req, &as_ctx);
+
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err &&
 	    !req->r_reply_info.head->is_target &&
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+out_req:
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5b9104b8e453..ace72a052254 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -570,7 +570,8 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 	ceph_mdsc_release_dir_caps(req);
 }
 
-static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
+static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
+				    struct dentry *dentry,
 				    struct file *file, umode_t mode,
 				    struct ceph_mds_request *req,
 				    struct ceph_acl_sec_ctx *as_ctx,
@@ -581,7 +582,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_reply_inode in = { };
 	struct ceph_mds_reply_info_in iinfo = { .in = &in };
 	struct ceph_inode_info *ci = ceph_inode(dir);
-	struct inode *inode;
 	struct timespec64 now;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_vino vino = { .ino = req->r_deleg_ino,
@@ -589,10 +589,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 
 	ktime_get_real_ts64(&now);
 
-	inode = ceph_get_inode(dentry->d_sb, vino);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
 	iinfo.inline_version = CEPH_INLINE_NONE;
 	iinfo.change_attr = 1;
 	ceph_encode_timespec64(&iinfo.btime, &now);
@@ -642,8 +638,7 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		ceph_dir_clear_complete(dir);
 		if (!d_unhashed(dentry))
 			d_drop(dentry);
-		if (inode->i_state & I_NEW)
-			discard_new_inode(inode);
+		discard_new_inode(inode);
 	} else {
 		struct dentry *dn;
 
@@ -683,6 +678,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
+	struct inode *new_inode = NULL;
 	struct dentry *dn;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	bool try_async = ceph_test_mount_opt(fsc, ASYNC_DIROPS);
@@ -695,21 +691,21 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
-
+retry:
 	if (flags & O_CREAT) {
 		if (ceph_quota_is_max_files_exceeded(dir))
 			return -EDQUOT;
-		err = ceph_pre_init_acls(dir, &mode, &as_ctx);
-		if (err < 0)
-			return err;
-		err = ceph_security_init_secctx(dentry, mode, &as_ctx);
-		if (err < 0)
+
+		new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
+		if (IS_ERR(new_inode)) {
+			err = PTR_ERR(new_inode);
 			goto out_ctx;
+		}
 	} else if (!d_in_lookup(dentry)) {
 		/* If it's not being looked up, it's negative */
 		return -ENOENT;
 	}
-retry:
+
 	/* do the open */
 	req = prepare_open_request(dir->i_sb, flags, mode);
 	if (IS_ERR(req)) {
@@ -730,25 +726,40 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 
 		req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 		req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-		if (as_ctx.pagelist) {
-			req->r_pagelist = as_ctx.pagelist;
-			as_ctx.pagelist = NULL;
-		}
-		if (try_async &&
-		    (req->r_dir_caps =
-		      try_prep_async_create(dir, dentry, &lo,
-					    &req->r_deleg_ino))) {
+
+		ceph_as_ctx_to_req(req, &as_ctx);
+
+		if (try_async && (req->r_dir_caps =
+				  try_prep_async_create(dir, dentry, &lo, &req->r_deleg_ino))) {
+			struct ceph_vino vino = { .ino = req->r_deleg_ino,
+						  .snap = CEPH_NOSNAP };
+
 			set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 			req->r_args.open.flags |= cpu_to_le32(CEPH_O_EXCL);
 			req->r_callback = ceph_async_create_cb;
+
+			/* Hash inode before RPC */
+			new_inode = ceph_get_inode(dir->i_sb, vino, new_inode);
+			if (IS_ERR(new_inode)) {
+				err = PTR_ERR(new_inode);
+				new_inode = NULL;
+				goto out_req;
+			}
+			WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
+
 			err = ceph_mdsc_submit_request(mdsc, dir, req);
 			if (!err) {
-				err = ceph_finish_async_create(dir, dentry,
+				err = ceph_finish_async_create(dir, new_inode, dentry,
 							file, mode, req,
 							&as_ctx, &lo);
+				new_inode = NULL;
 			} else if (err == -EJUKEBOX) {
 				restore_deleg_ino(dir, req->r_deleg_ino);
 				ceph_mdsc_put_request(req);
+				discard_new_inode(new_inode);
+				ceph_release_acl_sec_ctx(&as_ctx);
+				memset(&as_ctx, 0, sizeof(as_ctx));
+				new_inode = NULL;
 				try_async = false;
 				goto retry;
 			}
@@ -757,6 +768,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	}
 
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_new_inode = new_inode;
+	new_inode = NULL;
 	err = ceph_mdsc_do_request(mdsc,
 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
 				   req);
@@ -799,6 +812,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	}
 out_req:
 	ceph_mdsc_put_request(req);
+	iput(new_inode);
 out_ctx:
 	ceph_release_acl_sec_ctx(&as_ctx);
 	dout("atomic_open result=%d\n", err);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 1ce6561a0bd3..ec35bb98985b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -52,17 +52,85 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
 	return 0;
 }
 
-struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
+/**
+ * ceph_new_inode - allocate a new inode in advance of an expected create
+ * @dir: parent directory for new inode
+ * @dentry: dentry that may eventually point to new inode
+ * @mode: mode of new inode
+ * @as_ctx: pointer to inherited security context
+ *
+ * Allocate a new inode in advance of an operation to create a new inode.
+ * This allocates the inode and sets up the acl_sec_ctx with appropriate
+ * info for the new inode.
+ *
+ * Returns a pointer to the new inode or an ERR_PTR.
+ */
+struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
+			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx)
+{
+	int err;
+	struct inode *inode;
+
+	inode = new_inode_pseudo(dir->i_sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	if (!S_ISLNK(*mode)) {
+		err = ceph_pre_init_acls(dir, mode, as_ctx);
+		if (err < 0)
+			goto out_err;
+	}
+
+	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
+	if (err < 0)
+		goto out_err;
+
+	inode->i_state = 0;
+	inode->i_mode = *mode;
+	return inode;
+out_err:
+	iput(inode);
+	return ERR_PTR(err);
+}
+
+void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as_ctx)
+{
+	if (as_ctx->pagelist) {
+		req->r_pagelist = as_ctx->pagelist;
+		as_ctx->pagelist = NULL;
+	}
+}
+
+/**
+ * ceph_get_inode - find or create/hash a new inode
+ * @sb: superblock to search and allocate in
+ * @vino: vino to search for
+ * @newino: optional new inode to insert if one isn't found (may be NULL)
+ *
+ * Search for or insert a new inode into the hash for the given vino, and return a
+ * reference to it. If new is non-NULL, its reference is consumed.
+ */
+struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino, struct inode *newino)
 {
 	struct inode *inode;
 
 	if (ceph_vino_is_reserved(vino))
 		return ERR_PTR(-EREMOTEIO);
 
-	inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
-			     ceph_set_ino_cb, &vino);
-	if (!inode)
+	if (newino) {
+		inode = inode_insert5(newino, (unsigned long)vino.ino, ceph_ino_compare,
+					ceph_set_ino_cb, &vino);
+		if (inode != newino)
+			iput(newino);
+	} else {
+		inode = iget5_locked(sb, (unsigned long)vino.ino, ceph_ino_compare,
+				     ceph_set_ino_cb, &vino);
+	}
+
+	if (!inode) {
+		dout("No inode found for %llx.%llx\n", vino.ino, vino.snap);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dout("get_inode on %llu=%llx.%llx got %p new %d\n", ceph_present_inode(inode),
 	     ceph_vinop(inode), inode, !!(inode->i_state & I_NEW));
@@ -78,7 +146,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		.ino = ceph_ino(parent),
 		.snap = CEPH_SNAPDIR,
 	};
-	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
+	struct inode *inode = ceph_get_inode(parent->i_sb, vino, NULL);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (IS_ERR(inode))
@@ -1544,7 +1612,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 		vino.ino = le64_to_cpu(rde->inode.in->ino);
 		vino.snap = le64_to_cpu(rde->inode.in->snapid);
 
-		in = ceph_get_inode(req->r_dentry->d_sb, vino);
+		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
 			dout("new_inode badness got %d\n", err);
@@ -1746,7 +1814,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		if (d_really_is_positive(dn)) {
 			in = d_inode(dn);
 		} else {
-			in = ceph_get_inode(parent->d_sb, tvino);
+			in = ceph_get_inode(parent->d_sb, tvino, NULL);
 			if (IS_ERR(in)) {
 				dout("new_inode badness\n");
 				d_drop(dn);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5937cbfafd31..57cf21c9199f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -844,6 +844,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 		iput(req->r_parent);
 	}
 	iput(req->r_target_inode);
+	iput(req->r_new_inode);
 	if (req->r_dentry)
 		dput(req->r_dentry);
 	if (req->r_old_dentry)
@@ -3196,7 +3197,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			.snap = le64_to_cpu(rinfo->targeti.in->snapid)
 		};
 
-		in = ceph_get_inode(mdsc->fsc->sb, tvino);
+		in = ceph_get_inode(mdsc->fsc->sb, tvino, xchg(&req->r_new_inode, NULL));
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
 			mutex_lock(&session->s_mutex);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 97c7f7bfa55f..c3986a412fb5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -259,6 +259,7 @@ struct ceph_mds_request {
 
 	struct inode *r_parent;		    /* parent dir inode */
 	struct inode *r_target_inode;       /* resulting inode */
+	struct inode *r_new_inode;	    /* new inode (for creates) */
 
 #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
 #define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a12a193bc9ad..532ee9fca878 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -968,6 +968,7 @@ static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
 /* inode.c */
 struct ceph_mds_reply_info_in;
 struct ceph_mds_reply_dirfrag;
+struct ceph_acl_sec_ctx;
 
 extern const struct inode_operations ceph_file_iops;
 
@@ -975,8 +976,12 @@ extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_evict_inode(struct inode *inode);
 extern void ceph_free_inode(struct inode *inode);
 
+struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
+			     umode_t *mode, struct ceph_acl_sec_ctx *as_ctx);
+void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as_ctx);
+
 extern struct inode *ceph_get_inode(struct super_block *sb,
-				    struct ceph_vino vino);
+				    struct ceph_vino vino, struct inode *newino);
 extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
-- 
2.34.1

