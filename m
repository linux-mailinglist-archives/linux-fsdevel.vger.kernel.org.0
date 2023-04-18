Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18146E56C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjDRBnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDRBmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896707D9B
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fbc270950so116950307b3.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782085; x=1684374085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EclmRuCEs8AtdYsWbPtv7S1s8N7D3XoEPaguP9KMkfI=;
        b=mmwYVHjRAK5Z159C4imU0XQjkYtfnCBYjv6l4C4bOCpMXKwBtApNX02vwb7wGKRz4N
         5XN3HQ4NzLI38FzrpsJ+pijncme7++sNr3Lhf5SYjX2+5hrrxG0qic8LTCsLQ/L3V1tl
         ZnXYn62ItIO97Ypuoa624x4qnYf6vElPXxFcygSYU7x1tbJdV1rnJIz2kFBABcJUHC/R
         ODYpnlJdo3GOx6g8lnndopkLGXfrP5bGFTxF2LWebBVsKgZtSOfuB1fZS4av1rYR4v8d
         dXRXapxs4gY9IzCAWPPhicID2CTLtG3lyLn96zZ5kfplK6rLfb34n9wqbKDNzu3jXRVL
         DyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782085; x=1684374085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EclmRuCEs8AtdYsWbPtv7S1s8N7D3XoEPaguP9KMkfI=;
        b=Me398ZRLkOh4fTk96pDpNnH/z0GIUlGxczPlKrlUN03kgGPzKerggqkrnmQczRyUKq
         ZJFsbbs7INEy4Nobpb+OYVodRvwKn4JzpIbUoZUV9hLKkfN3aj8kCvl7uTwZODThuY12
         DEHFeiYSohPGhzrUQO/5pmCvvKNBMHsohsjMoYpgnDIFE5AmS3I0vVSmCQ4WDDFbzl1W
         ooFPJegE1/jlsgq7ycoF5l5Im495AlSdf6v37XPfulhKgDsEbPcfb26RH8XpWgEJWDQZ
         EefYp5+S9+l6cbCX+09NRDfwGUirZY3kClYAqdfgcfuKgDrRMLU7utlEet7q9kzMjioc
         D+Ew==
X-Gm-Message-State: AAQBX9dcytc1L9Qps+2y7RaQimp+43wQ7P7b5Z6ob67jgpo2JNmhejgP
        +j9ww9Ss27fH0PRA1vBeHoSryABp6Bw=
X-Google-Smtp-Source: AKy350ZZ9Icx+O5cAn8L7UL4LyCuWNAJhMF/AQzRrb3mRpbXzhEHNdWb1PPKet4jhSmTfS5WrLVoXSBCA6Y=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d08d:0:b0:b7c:1144:a708 with SMTP id
 h135-20020a25d08d000000b00b7c1144a708mr10996656ybg.12.1681782084915; Mon, 17
 Apr 2023 18:41:24 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:15 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-16-drosen@google.com>
Subject: [RFC PATCH v3 15/37] fuse-bpf: Support file/dir open/close
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds backing support for FUSE_OPEN, FUSE_OPENDIR, FUSE_CREATE,
FUSE_RELEASE, and FUSE_RELEASEDIR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   8 +
 fs/fuse/file.c    |   7 +
 fs/fuse/fuse_i.h  |  26 ++++
 4 files changed, 409 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index ee315598bc3f..d4a214cadc15 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -207,6 +207,374 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+struct fuse_open_args {
+	struct fuse_open_in in;
+	struct fuse_open_out out;
+};
+
+static int fuse_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_open_args *args,
+				   struct inode *inode, struct file *file, bool isdir)
+{
+	args->in = (struct fuse_open_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(inode)->nodeid,
+			.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_open_args *args,
+				    struct inode *inode, struct file *file, bool isdir)
+{
+	args->out = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->out),
+		.value = &args->out,
+	};
+
+	return 0;
+}
+
+static int fuse_open_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = inode_permission(&nop_mnt_idmap,
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
+static int fuse_open_finalize(struct bpf_fuse_args *fa, int *out,
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
+	return bpf_fuse_backing(inode, struct fuse_open_args, out,
+				fuse_open_initialize_in, fuse_open_initialize_out,
+				fuse_open_backing, fuse_open_finalize,
+				inode, file, isdir);
+}
+
+struct fuse_create_open_args {
+	struct fuse_create_in in;
+	struct fuse_buffer name;
+	struct fuse_entry_out entry_out;
+	struct fuse_open_out open_out;
+};
+
+static int fuse_create_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_create_open_args *args,
+					  struct inode *dir, struct dentry *entry,
+					  struct file *file, unsigned int flags, umode_t mode)
+{
+	args->in = (struct fuse_create_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+		.mode = mode,
+	};
+
+	args->name = (struct fuse_buffer) {
+		.data = (void *) entry->d_name.name,
+		.size = entry->d_name.len + 1,
+		.flags = BPF_FUSE_IMMUTABLE,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_CREATE,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_create_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_create_open_args *args,
+					   struct inode *dir, struct dentry *entry,
+					   struct file *file, unsigned int flags, umode_t mode)
+{
+	args->entry_out = (struct fuse_entry_out) { 0 };
+	args->open_out = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->entry_out),
+		.value = &args->entry_out,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->open_out),
+		.value = &args->open_out,
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
+static int fuse_create_open_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = vfs_create(&nop_mnt_idmap, d_inode(backing_parent),
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
+static int fuse_create_open_finalize(struct bpf_fuse_args *fa, int *out,
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
+	return bpf_fuse_backing(dir, struct fuse_create_open_args, out,
+				fuse_create_open_initialize_in,
+				fuse_create_open_initialize_out,
+				fuse_create_open_backing,
+				fuse_create_open_finalize,
+				dir, entry, file, flags, mode);
+}
+
+static int fuse_release_initialize_in(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
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
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(inode)->nodeid,
+			.opcode = FUSE_RELEASE,
+		},		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fri),
+		.in_args[0].value = fri,
+	};
+
+	return 0;
+}
+
+static int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+				       struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_releasedir_initialize_in(struct bpf_fuse_args *fa,
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
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(inode)->nodeid,
+			.opcode = FUSE_RELEASEDIR,
+		},		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fri),
+		.in_args[0].value = fri,
+	};
+
+	return 0;
+}
+
+static int fuse_releasedir_initialize_out(struct bpf_fuse_args *fa,
+					  struct fuse_release_in *fri,
+					  struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct inode *inode, struct file *file)
+{
+	fuse_file_free(file->private_data);
+	*out = 0;
+	return 0;
+}
+
+int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
+{
+	return bpf_fuse_backing(inode, struct fuse_release_in, out,
+				fuse_release_initialize_in, fuse_release_initialize_out,
+				fuse_release_backing, fuse_release_finalize,
+				inode, file);
+}
+
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
+{
+	return bpf_fuse_backing(inode, struct fuse_release_in, out,
+				fuse_releasedir_initialize_in, fuse_releasedir_initialize_out,
+				fuse_release_backing, fuse_release_finalize, inode, file);
+}
+
 struct fuse_lseek_args {
 	struct fuse_lseek_in in;
 	struct fuse_lseek_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 535e6cf9e970..1df2bbc72396 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -719,6 +719,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+	if (fuse_bpf_create_open(&err, dir, entry, file, flags, mode))
+		return err;
+
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -1629,6 +1632,11 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 
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
index 58cff04660db..1836d09d9ce3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -243,6 +243,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
+	if (fuse_bpf_open(&err, inode, file, isdir))
+		return err;
+
 	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
 
@@ -351,6 +354,10 @@ static int fuse_open(struct inode *inode, struct file *file)
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
index 1dd9cc9720df..feecc1ebfdda 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1405,6 +1405,11 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
+int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
+			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
@@ -1412,6 +1417,27 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
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
2.40.0.634.g4ca3ef3211-goog

