Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BE633306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiKVCSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiKVCRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A353E6767
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so12727062ybf.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=78iV0IOgPJQWyL/mQIMxjEmfCaR2pA5J6aYjL9H4JYo=;
        b=gHf8zmM74lrP+ge6ba1Qf4CO+Nh8VrJVNTDNaB6851IfJmOnkJ9ucSQHZ88q1KOTd+
         scELBI5K48bn/AvOvHx+ifRIumMlSCEwFxJpxi2umJX8mnAjEqaEO6/stVSz4IJufrDX
         dcFF5dQpT7vbFhruef2o5VdJRcpO8uUmBSSz6S7QfwY0RLpSM6MCa+I2pB3eqEeb3Acp
         M1J1HugnhLOmrs4z2U67ABsYmbFXtQB+TgX2i34vlhHkAiCWRqVvh+kjjkSlgEC0PiRZ
         KZadGpwzL6nMOVpKqP1JCEfC84/rhDeQlsu6WgPM9C+S+FP03gX6W3GRxsTIvDham//l
         h4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78iV0IOgPJQWyL/mQIMxjEmfCaR2pA5J6aYjL9H4JYo=;
        b=yhM4JOW81lsJIidbIvL5SUW33gFsYjh8bpk4sWXM0BBetDzIvvJ8vkPN2467AZs1XA
         CMahbWsVSbj1SDGikygZ9hk4vAMM923VJK7RKW+FuGlYYFy4TWRKj67vd8BZz7sn1hqg
         gf30XAg0GBKsKTfPZuBB10Fr2AqP7DWRmuUHdSKxLfD63/Gy/f7TuhC2bCgaziW0dMNd
         eTU60d8Jq3lahmoUZDplgWlsf6IA1dV1+/wmBJXLJbx185gI6PxMna14jP3xcbVUyCnP
         Ko6qeFPhgZykKiPIn94AmTUq2ms+vhaCbp1m2OHeQvSLXYaiCLdcSx5SSfBebT4U3y5X
         xTYw==
X-Gm-Message-State: ANoB5pmTNFz8+gnOvHZ9LwFaZamPzotCSQ/v7nQK3+nnwQ/BK7OQ7EEh
        lKMMB8vh+d+Ks0bVLu2pGrbicQNnjLs=
X-Google-Smtp-Source: AA0mqf7zD7izU7ao8UfvD9Uu+T9/S4ydpSW8lFWddu0/Ffn632J82EExw5VThXRP1csBheW0dVALIvnRBDc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a5b:bcd:0:b0:6cf:f46b:c28f with SMTP id
 c13-20020a5b0bcd000000b006cff46bc28fmr4030875ybr.520.1669083379336; Mon, 21
 Nov 2022 18:16:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:26 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-12-drosen@google.com>
Subject: [RFC PATCH v2 11/21] fuse-bpf: Support file/dir open/close
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 356 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   8 ++
 fs/fuse/file.c    |   7 +
 fs/fuse/fuse_i.h  |  26 ++++
 4 files changed, 397 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 51aadeb1b7dc..c8e95abc04aa 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -205,6 +205,362 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+struct fuse_open_io {
+	struct fuse_open_in foi;
+	struct fuse_open_out foo;
+};
+
+static int fuse_open_initialize_in(struct fuse_args *fa, struct fuse_open_io *foio,
+				   struct inode *inode, struct file *file, bool isdir)
+{
+	foio->foi = (struct fuse_open_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+	};
+	*fa = (struct fuse_args) {
+		.nodeid = get_fuse_inode(inode)->nodeid,
+		.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN,
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(foio->foi),
+			.value = &foio->foi,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_open_initialize_out(struct fuse_args *fa, struct fuse_open_io *foio,
+				    struct inode *inode, struct file *file, bool isdir)
+{
+	foio->foo = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct fuse_arg) {
+		.size = sizeof(foio->foo),
+		.value = &foio->foo,
+	};
+
+	return 0;
+}
+
+static int fuse_open_backing(struct fuse_args *fa, int *out,
+			     struct inode *inode, struct file *file, bool isdir)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	const struct fuse_open_in *foi = fa->in_args[0].value;
+	struct fuse_file *ff;
+	int mask;
+	struct fuse_dentry *fd = get_fuse_dentry(file->f_path.dentry);
+	struct file *backing_file;
+
+	ff = fuse_file_alloc(fm);
+	if (!ff)
+		return -ENOMEM;
+	file->private_data = ff;
+
+	switch (foi->flags & O_ACCMODE) {
+	case O_RDONLY:
+		mask = MAY_READ;
+		break;
+
+	case O_WRONLY:
+		mask = MAY_WRITE;
+		break;
+
+	case O_RDWR:
+		mask = MAY_READ | MAY_WRITE;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	*out = inode_permission(&init_user_ns,
+				get_fuse_inode(inode)->backing_inode, mask);
+	if (*out)
+		return *out;
+
+	backing_file =
+		dentry_open(&fd->backing_path, foi->flags, current_cred());
+
+	if (IS_ERR(backing_file)) {
+		fuse_file_free(ff);
+		file->private_data = NULL;
+		return PTR_ERR(backing_file);
+	}
+	ff->backing_file = backing_file;
+
+	*out = 0;
+	return 0;
+}
+
+static int fuse_open_finalize(struct fuse_args *fa, int *out,
+			      struct inode *inode, struct file *file, bool isdir)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_open_out *foo = fa->out_args[0].value;
+
+	if (ff) {
+		ff->fh = foo->fh;
+		ff->nodeid = get_fuse_inode(inode)->nodeid;
+	}
+	return 0;
+}
+
+int fuse_bpf_open(int *out, struct inode *inode, struct file *file, bool isdir)
+{
+	return fuse_bpf_backing(inode, struct fuse_open_io, out,
+				fuse_open_initialize_in, fuse_open_initialize_out,
+				fuse_open_backing,
+				fuse_open_finalize,
+				inode, file, isdir);
+}
+
+struct fuse_create_open_io {
+	struct fuse_create_in fci;
+	struct fuse_entry_out feo;
+	struct fuse_open_out foo;
+};
+
+static int fuse_create_open_initialize_in(struct fuse_args *fa, struct fuse_create_open_io *fcoio,
+					  struct inode *dir, struct dentry *entry,
+					  struct file *file, unsigned int flags, umode_t mode)
+{
+	fcoio->fci = (struct fuse_create_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+		.mode = mode,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_CREATE,
+		.in_numargs = 2,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(fcoio->fci),
+			.value = &fcoio->fci,
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
+static int fuse_create_open_initialize_out(struct fuse_args *fa, struct fuse_create_open_io *fcoio,
+					   struct inode *dir, struct dentry *entry,
+					   struct file *file, unsigned int flags, umode_t mode)
+{
+	fcoio->feo = (struct fuse_entry_out) { 0 };
+	fcoio->foo = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct fuse_arg) {
+		.size = sizeof(fcoio->feo),
+		.value = &fcoio->feo,
+	};
+	fa->out_args[1] = (struct fuse_arg) {
+		.size = sizeof(fcoio->foo),
+		.value = &fcoio->foo,
+	};
+
+	return 0;
+}
+
+static int fuse_open_file_backing(struct inode *inode, struct file *file)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct dentry *entry = file->f_path.dentry;
+	struct fuse_dentry *fuse_dentry = get_fuse_dentry(entry);
+	struct fuse_file *fuse_file;
+	struct file *backing_file;
+
+	fuse_file = fuse_file_alloc(fm);
+	if (!fuse_file)
+		return -ENOMEM;
+	file->private_data = fuse_file;
+
+	backing_file = dentry_open(&fuse_dentry->backing_path, file->f_flags,
+				   current_cred());
+	if (IS_ERR(backing_file)) {
+		fuse_file_free(fuse_file);
+		file->private_data = NULL;
+		return PTR_ERR(backing_file);
+	}
+	fuse_file->backing_file = backing_file;
+
+	return 0;
+}
+
+static int fuse_create_open_backing(struct fuse_args *fa, int *out,
+				    struct inode *dir, struct dentry *entry,
+				    struct file *file, unsigned int flags, umode_t mode)
+{
+	struct fuse_inode *dir_fuse_inode = get_fuse_inode(dir);
+	struct path backing_path;
+	struct inode *inode = NULL;
+	struct dentry *backing_parent;
+	struct dentry *newent;
+	const struct fuse_create_in *fci = fa->in_args[0].value;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	if (IS_ERR(backing_path.dentry))
+		return PTR_ERR(backing_path.dentry);
+
+	if (d_really_is_positive(backing_path.dentry)) {
+		*out = -EIO;
+		goto out;
+	}
+
+	backing_parent = dget_parent(backing_path.dentry);
+	inode_lock_nested(dir_fuse_inode->backing_inode, I_MUTEX_PARENT);
+	*out = vfs_create(&init_user_ns, d_inode(backing_parent),
+			backing_path.dentry, fci->mode, true);
+	inode_unlock(d_inode(backing_parent));
+	dput(backing_parent);
+	if (*out)
+		goto out;
+
+	inode = fuse_iget_backing(dir->i_sb, 0, backing_path.dentry->d_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+
+	newent = d_splice_alias(inode, entry);
+	if (IS_ERR(newent)) {
+		*out = PTR_ERR(newent);
+		goto out;
+	}
+
+	entry = newent ? newent : entry;
+	*out = finish_open(file, entry, fuse_open_file_backing);
+
+out:
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_create_open_finalize(struct fuse_args *fa, int *out,
+				     struct inode *dir, struct dentry *entry,
+				     struct file *file, unsigned int flags, umode_t mode)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_inode *fi = get_fuse_inode(file->f_inode);
+	struct fuse_entry_out *feo = fa->out_args[0].value;
+	struct fuse_open_out *foo = fa->out_args[1].value;
+
+	if (fi)
+		fi->nodeid = feo->nodeid;
+	if (ff)
+		ff->fh = foo->fh;
+	return 0;
+}
+
+int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
+			 struct file *file, unsigned int flags, umode_t mode)
+{
+	return fuse_bpf_backing(dir, struct fuse_create_open_io, out,
+				fuse_create_open_initialize_in,
+				fuse_create_open_initialize_out,
+				fuse_create_open_backing,
+				fuse_create_open_finalize,
+				dir, entry, file, flags, mode);
+}
+
+static int fuse_release_initialize_in(struct fuse_args *fa, struct fuse_release_in *fri,
+				      struct inode *inode, struct file *file)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	/* Always put backing file whatever bpf/userspace says */
+	fput(fuse_file->backing_file);
+
+	*fri = (struct fuse_release_in) {
+		.fh = ((struct fuse_file *)(file->private_data))->fh,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_fuse_inode(inode)->nodeid,
+		.opcode = FUSE_RELEASE,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fri),
+		.in_args[0].value = fri,
+	};
+
+	return 0;
+}
+
+static int fuse_release_initialize_out(struct fuse_args *fa, struct fuse_release_in *fri,
+				       struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_releasedir_initialize_in(struct fuse_args *fa,
+					 struct fuse_release_in *fri,
+					 struct inode *inode, struct file *file)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	/* Always put backing file whatever bpf/userspace says */
+	fput(fuse_file->backing_file);
+
+	*fri = (struct fuse_release_in) {
+		.fh = ((struct fuse_file *)(file->private_data))->fh,
+	};
+
+	*fa = (struct fuse_args) {
+		.nodeid = get_fuse_inode(inode)->nodeid,
+		.opcode = FUSE_RELEASEDIR,
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fri),
+		.in_args[0].value = fri,
+	};
+
+	return 0;
+}
+
+static int fuse_releasedir_initialize_out(struct fuse_args *fa,
+					  struct fuse_release_in *fri,
+					  struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_release_backing(struct fuse_args *fa, int *out,
+				struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_release_finalize(struct fuse_args *fa, int *out,
+				 struct inode *inode, struct file *file)
+{
+	fuse_file_free(file->private_data);
+	*out = 0;
+	return 0;
+}
+
+int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
+{
+	return fuse_bpf_backing(inode, struct fuse_release_in, out,
+				fuse_release_initialize_in, fuse_release_initialize_out,
+				fuse_release_backing, fuse_release_finalize,
+				inode, file);
+}
+
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
+{
+	return fuse_bpf_backing(inode, struct fuse_release_in, out,
+				fuse_releasedir_initialize_in, fuse_releasedir_initialize_out,
+				fuse_release_backing, fuse_release_finalize, inode, file);
+}
+
 struct fuse_lseek_io {
 	struct fuse_lseek_in fli;
 	struct fuse_lseek_out flo;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4e19320889ed..e330a6af9ee7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -635,6 +635,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+	if (fuse_bpf_create_open(&err, dir, entry, file, flags, mode))
+		return err;
+
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -1554,6 +1557,11 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
+	int err = 0;
+
+	if (fuse_bpf_releasedir(&err, inode, file))
+		return err;
+
 	fuse_release_common(file, true);
 
 	return 0;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ab3cd43556e0..70a5bd5403ca 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -241,6 +241,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
+	if (fuse_bpf_open(&err, inode, file, isdir))
+		return err;
+
 	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
 
@@ -349,6 +352,10 @@ static int fuse_open(struct inode *inode, struct file *file)
 static int fuse_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	if (fuse_bpf_release(&err, inode, file))
+		return err;
 
 	/*
 	 * Dirty pages might remain despite write_inode_now() call from
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4351dbc7f10d..794b1a06079c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1400,6 +1400,11 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
+int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
+			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
@@ -1407,6 +1412,27 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
+static inline int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
+				       struct file *file, unsigned int flags, umode_t mode)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
 {
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

