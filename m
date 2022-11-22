Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF063330B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiKVCSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiKVCRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D28E6775
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so12554827ybc.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydyHUSUVRLNupkLXr6P8WzdsU341BmaDDMAW+LRksTY=;
        b=k+KyxhZMTRllx3lQFyjWbf+28UVtsTsFqm5n+/aW2I9WhizNoXiOdaaQkDKJd5Rj0u
         hO64pYowvIgPhLWK5B50w4OIjBXWqMsmXMsK3BpMofw9xupyoMj8iGDFjKiS5ZLGtIQM
         vf2CqSanuhwMpqzaA6j2GmjhW+C6WXaqn+aCrvwrJyf+Bg+VKdVJX3zH/5z95QjOmAYR
         6oG/oLULfWKPkw2tcp6VjKDSHdn66CHYe0CqwzBwuBYF2/GVTIHJUuPWJD7jLAuH3wlr
         DX4zRU8SXoKcbpHwtFdX+EOOV3uwqJ+eie1fI7Ta+5aREznvRvC2rn3Gi6vz7/pJw9gI
         dVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydyHUSUVRLNupkLXr6P8WzdsU341BmaDDMAW+LRksTY=;
        b=uOSFwuWK7AL05sIV4L4za5g4GlIYWMx6OkCatNjq0bNi+5ecu/G4SGDITmn016ksjm
         LPMypTLdIHhjukWgTWs78N4Azwavq+AW9/RZ/i0+Suzxyw0EVJdY78uUhwGM1NvRkqDr
         1cGQ/z4WXsvXG9djR/Bm/YsBLtgi7m8WYIx7GWZ+asSDC8zy0dFgieJbnHnaWpGlXLyk
         gpgtjC4S9iRXIH1VGInBHDANNw1bKdBG1ta6FQfZRKYd4pZmhStVrw4cKJDiMaBN72XN
         mRL5mGu+h1fxyCls0soRk/LDe+1mdsrCaEw02LQsO1stMAZrfzY5iRJFf2sXhyNZG/Ud
         RLpA==
X-Gm-Message-State: ANoB5pkcYYsMpr+7n3OJF5sg/lqvG0/Ie/69twDLUcHc8H/CLpFX5wEd
        TQn+bDKgsedilrlXs1lqD9Fks4GZhkA=
X-Google-Smtp-Source: AA0mqf6RY+vOUOe+eEVuThyyVpCLoTK7JOhwb/Ik9aUtjrjQNd+3UCndd6B+au4Ss8OmcBoTTY5ZlCo+/Nc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a0d:ea96:0:b0:3a6:4f96:2639 with SMTP id
 t144-20020a0dea96000000b003a64f962639mr1916559ywe.440.1669083381448; Mon, 21
 Nov 2022 18:16:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:27 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-13-drosen@google.com>
Subject: [RFC PATCH v2 12/21] fuse-bpf: Support mknod/unlink/mkdir/rmdir
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  14 +++
 fs/fuse/fuse_i.h  |  24 ++++
 3 files changed, 344 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c8e95abc04aa..a7505d6887e0 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -205,6 +205,13 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+/*
+ * Unused io passed to fuse_bpf_backing when io operation needs no scratch space
+ */
+struct fuse_unused_io {
+	int unused;
+};
+
 struct fuse_open_io {
 	struct fuse_open_in foi;
 	struct fuse_open_out foo;
@@ -930,6 +937,305 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 	return 1;
 }
 
+static int fuse_mknod_initialize_in(struct fuse_args *fa, struct fuse_mknod_in *fmi,
+				    struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	*fmi = (struct fuse_mknod_in) {
+		.mode = mode,
+		.rdev = new_encode_dev(rdev),
+		.umask = current_umask(),
+	};
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_MKNOD,
+		.in_numargs = 2,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(*fmi),
+			.value = fmi,
+		},
+		.in_args[1] = (struct fuse_in_arg) {
+			.size = entry->d_name.len + 1,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_mknod_initialize_out(struct fuse_args *fa, struct fuse_mknod_in *fmi,
+				     struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+static int fuse_mknod_backing(struct fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	const struct fuse_mknod_in *fmi = fa->in_args[0].value;
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	mode = fmi->mode;
+	if (!IS_POSIXACL(backing_inode))
+		mode &= ~fmi->umask;
+	*out = vfs_mknod(&init_user_ns, backing_inode, backing_path.dentry, mode,
+			new_decode_dev(fmi->rdev));
+	inode_unlock(backing_inode);
+	if (*out)
+		goto out;
+	if (d_really_is_negative(backing_path.dentry) ||
+	    unlikely(d_unhashed(backing_path.dentry))) {
+		*out = -EINVAL;
+		/**
+		 * TODO: overlayfs responds to this situation with a
+		 * lookupOneLen. Should we do that too?
+		 */
+		goto out;
+	}
+	inode = fuse_iget_backing(dir->i_sb, fuse_inode->nodeid, backing_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+	d_instantiate(entry, inode);
+out:
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_mknod_finalize(struct fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return fuse_bpf_backing(dir, struct fuse_mknod_in, out,
+				fuse_mknod_initialize_in, fuse_mknod_initialize_out,
+				fuse_mknod_backing, fuse_mknod_finalize,
+				dir, entry, mode, rdev);
+}
+
+static int fuse_mkdir_initialize_in(struct fuse_args *fa, struct fuse_mkdir_in *fmi,
+				    struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	*fmi = (struct fuse_mkdir_in) {
+		.mode = mode,
+		.umask = current_umask(),
+	};
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_MKDIR,
+		.in_numargs = 2,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(*fmi),
+			.value = fmi,
+		},
+		.in_args[1] = (struct fuse_in_arg) {
+			.size = entry->d_name.len + 1,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_mkdir_initialize_out(struct fuse_args *fa, struct fuse_mkdir_in *fmi,
+				     struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+static int fuse_mkdir_backing(struct fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	const struct fuse_mkdir_in *fmi = fa->in_args[0].value;
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+	struct dentry *d;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	mode = fmi->mode;
+	if (!IS_POSIXACL(backing_inode))
+		mode &= ~fmi->umask;
+	*out = vfs_mkdir(&init_user_ns, backing_inode, backing_path.dentry,
+			mode);
+	if (*out)
+		goto out;
+	if (d_really_is_negative(backing_path.dentry) ||
+	    unlikely(d_unhashed(backing_path.dentry))) {
+		d = lookup_one_len(entry->d_name.name,
+				   backing_path.dentry->d_parent,
+				   entry->d_name.len);
+		if (IS_ERR(d)) {
+			*out = PTR_ERR(d);
+			goto out;
+		}
+		dput(backing_path.dentry);
+		backing_path.dentry = d;
+	}
+	inode = fuse_iget_backing(dir->i_sb, fuse_inode->nodeid, backing_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+	d_instantiate(entry, inode);
+out:
+	inode_unlock(backing_inode);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_mkdir_finalize(struct fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return fuse_bpf_backing(dir, struct fuse_mkdir_in, out,
+				fuse_mkdir_initialize_in, fuse_mkdir_initialize_out,
+				fuse_mkdir_backing, fuse_mkdir_finalize,
+				dir, entry, mode);
+}
+
+static int fuse_rmdir_initialize_in(struct fuse_args *fa, struct fuse_unused_io *unused,
+				    struct inode *dir, struct dentry *entry)
+{
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_RMDIR,
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = entry->d_name.len + 1,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rmdir_initialize_out(struct fuse_args *fa, struct fuse_unused_io *unused,
+				     struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_rmdir_backing(struct fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry)
+{
+	struct path backing_path;
+	struct dentry *backing_parent_dentry;
+	struct inode *backing_inode;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	backing_parent_dentry = dget_parent(backing_path.dentry);
+	backing_inode = d_inode(backing_parent_dentry);
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_rmdir(&init_user_ns, backing_inode, backing_path.dentry);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_rmdir_finalize(struct fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
+{
+	return fuse_bpf_backing(dir, struct fuse_unused_io, out,
+				fuse_rmdir_initialize_in, fuse_rmdir_initialize_out,
+				fuse_rmdir_backing, fuse_rmdir_finalize,
+				dir, entry);
+}
+
+static int fuse_unlink_initialize_in(struct fuse_args *fa, struct fuse_unused_io *unused,
+				     struct inode *dir, struct dentry *entry)
+{
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_UNLINK,
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = entry->d_name.len + 1,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_unlink_initialize_out(struct fuse_args *fa, struct fuse_unused_io *unused,
+				      struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_unlink_backing(struct fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	struct path backing_path;
+	struct dentry *backing_parent_dentry;
+	struct inode *backing_inode;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	/* TODO Not sure if we should reverify like overlayfs, or get inode from d_parent */
+	backing_parent_dentry = dget_parent(backing_path.dentry);
+	backing_inode = d_inode(backing_parent_dentry);
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_unlink(&init_user_ns, backing_inode, backing_path.dentry,
+			 NULL);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_unlink_finalize(struct fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
+{
+	return fuse_bpf_backing(dir, struct fuse_unused_io, out,
+				fuse_unlink_initialize_in, fuse_unlink_initialize_out,
+				fuse_unlink_backing, fuse_unlink_finalize,
+				dir, entry);
+}
+
 static int fuse_access_initialize_in(struct fuse_args *fa, struct fuse_access_in *fai,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e330a6af9ee7..729a0348fa01 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -869,6 +869,10 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mknod(&err, dir, entry, mode, rdev))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -915,6 +919,10 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mkdir(&err, dir, entry, mode))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -1001,6 +1009,9 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_unlink(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_UNLINK;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
@@ -1024,6 +1035,9 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_rmdir(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_RMDIR;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 794b1a06079c..dc5bba2a75ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1403,6 +1403,10 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
 int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
@@ -1423,6 +1427,26 @@ static inline int fuse_bpf_create_open(int *out, struct inode *dir, struct dentr
 	return 0;
 }
 
+static inline int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

