Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66B5EB588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiIZXUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiIZXTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDEB24BA
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k11-20020a5b038b000000b006bbf786c30aso1832978ybp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=malZpJUM8aeiB5PpOhWGfEGrHf69STNe9BgM0txZt6o=;
        b=et9wN4BIZzySzU0TfwfMFo9P/sSXh6JPfwkaaX4xvh2dpm1eZ4Bx0fclmOUAN/EJAq
         j7iIXu+GiIQO4tRMZGA2HXRRaEXO7HsLK+3WgkULqakNoNr3nI72mFQubau/OZyzRhwB
         LnHIDLQ1Jb9cCXcb/h92DSvdvifxhegotDwi2RW0OjINxKLLEzcxn/JOFLBlcCrPUAQG
         QKUw8yw8CF6rZCqGoire4bdiaAZLOSTVsDwOsAbpX3GEvLLzpI54ZU+ios6tZ/FhtTms
         mY7fec5NfMvxp4whM9hVPav/NbHcIG8bKOir14ppsQ6gWQ96KgtuyX/ZbIB8WLyC1djJ
         WmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=malZpJUM8aeiB5PpOhWGfEGrHf69STNe9BgM0txZt6o=;
        b=xqtWV4F0W5cJB6pbjlI1iD3D1FuawPwIdvho3gTA7ryH/CYDsF5ruaHTqY0iWo97+f
         wq6I5zWs9ktqpRjY1Oz1PxpUo+gqp3VTkIjae6hWKIITY5T4FxGbWj0Xo/J2J2RuCdLk
         3dQ5MT0hFGlwai8R4/JtkKcc0Q5pNJ+OZTcc6T7B4QdemPnGMiSFpdIM949JIc0CvVG3
         FMZ8zkS2NyHtIJkMblVLBNHsXtiyJG9/RUsvJSm5x/sPTiiYFw7F/hHxfADFDGyPyZE6
         PiOL8qnGMVaIeBuqnkM6RJ20gbPk1i7b+9vSb1kWopN9WO/trwCVVrM0gLTbYb0K9Ypg
         Kfbg==
X-Gm-Message-State: ACrzQf0nrhvTkTMZ8XaGDQigZkE6CmBkaR86aI2HKKUmafwtkhi5oyaz
        N0FIKoWQjZNAIoUWncMxoyZ763B/Bxg=
X-Google-Smtp-Source: AMsMyM44N4BpqnFmNwQ7bzON76oubPtIKRmRWtAB9gfiIO2UYXNTd0lFpfaXqNK1TR3Ji7gQlU6IrQSFja8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a05:6902:13c8:b0:6af:f2b8:e164 with SMTP id
 y8-20020a05690213c800b006aff2b8e164mr22871421ybu.466.1664234344219; Mon, 26
 Sep 2022 16:19:04 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:09 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-14-drosen@google.com>
Subject: [PATCH 13/26] fuse-bpf: Support file/dir open/close
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
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
 fs/fuse/backing.c | 318 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  21 +++
 fs/fuse/file.c    |  21 +++
 fs/fuse/fuse_i.h  |  48 +++++++
 4 files changed, 408 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 95c60d6d7597..1a2a89ddd535 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -77,6 +77,324 @@ int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb)
 	return err;
 }
 
+int fuse_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_open_io *foio,
+			    struct inode *inode, struct file *file, bool isdir)
+{
+	foio->foi = (struct fuse_open_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+	};
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(inode)->nodeid,
+		.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(foio->foi),
+			.value = &foio->foi,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_open_io *foio,
+			     struct inode *inode, struct file *file, bool isdir)
+{
+	foio->foo = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(foio->foo),
+		.value = &foio->foo,
+	};
+
+	return 0;
+}
+
+int fuse_open_backing(struct bpf_fuse_args *fa, int *out,
+		      struct inode *inode, struct file *file, bool isdir)
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
+				  get_fuse_inode(inode)->backing_inode, mask);
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
+int fuse_open_finalize(struct bpf_fuse_args *fa, int *out,
+		       struct inode *inode, struct file *file, bool isdir)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_open_out *foo = fa->out_args[0].value;
+
+	if (ff)
+		ff->fh = foo->fh;
+	return 0;
+}
+
+int fuse_create_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_create_open_io *fcoio,
+				   struct inode *dir, struct dentry *entry,
+				   struct file *file, unsigned int flags, umode_t mode)
+{
+	fcoio->fci = (struct fuse_create_in) {
+		.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY),
+		.mode = mode,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_CREATE,
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(fcoio->fci),
+			.value = &fcoio->fci,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_create_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_create_open_io *fcoio,
+				    struct inode *dir, struct dentry *entry,
+				    struct file *file, unsigned int flags, umode_t mode)
+{
+	fcoio->feo = (struct fuse_entry_out) { 0 };
+	fcoio->foo = (struct fuse_open_out) { 0 };
+
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(fcoio->feo),
+		.value = &fcoio->feo,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
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
+int fuse_create_open_backing(struct bpf_fuse_args *fa, int *out,
+			     struct inode *dir, struct dentry *entry,
+			     struct file *file, unsigned int flags, umode_t mode)
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
+	if (!dir_fuse_inode)
+		return -EIO;
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
+	if (get_fuse_inode(inode)->bpf)
+		bpf_prog_put(get_fuse_inode(inode)->bpf);
+	get_fuse_inode(inode)->bpf = dir_fuse_inode->bpf;
+	if (get_fuse_inode(inode)->bpf)
+		bpf_prog_inc(dir_fuse_inode->bpf);
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
+int fuse_create_open_finalize(struct bpf_fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry,
+				struct file *file, unsigned int flags, umode_t mode)
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
+int fuse_release_initialize_in(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+			       struct inode *inode, struct file *file)
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
+int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+				struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+int fuse_releasedir_initialize_in(struct bpf_fuse_args *fa,
+				  struct fuse_release_in *fri,
+				  struct inode *inode, struct file *file)
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
+int fuse_releasedir_initialize_out(struct bpf_fuse_args *fa,
+				   struct fuse_release_in *fri,
+				   struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *inode, struct file *file)
+{
+	fuse_file_free(file->private_data);
+	*out = 0;
+	return 0;
+}
+
 int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_io *flio,
 			     struct file *file, loff_t offset, int whence)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index daaf3576fab9..a89690662b3b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -652,6 +652,18 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		if (fuse_bpf_backing(dir, struct fuse_create_open_io, err,
+				       fuse_create_open_initialize_in,
+				       fuse_create_open_initialize_out,
+				       fuse_create_open_backing,
+				       fuse_create_open_finalize,
+				       dir, entry, file, flags, mode))
+			return err;
+	}
+#endif
+
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -1562,6 +1574,15 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
+#ifdef CONFIG_FUSE_BPF
+	int err = 0;
+
+	if (fuse_bpf_backing(inode, struct fuse_release_in, err,
+		       fuse_releasedir_initialize_in, fuse_releasedir_initialize_out,
+		       fuse_release_backing, fuse_release_finalize, inode, file))
+		return err;
+#endif
+
 	fuse_release_common(file, true);
 
 	return 0;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ef6f6b0b3b59..7feb73274c3e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -241,6 +241,17 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		if (fuse_bpf_backing(inode, struct fuse_open_io, err,
+				       fuse_open_initialize_in, fuse_open_initialize_out,
+				       fuse_open_backing,
+				       fuse_open_finalize,
+				       inode, file, isdir))
+			return err;
+	}
+#endif
+
 	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
 
@@ -350,6 +361,16 @@ static int fuse_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+#ifdef CONFIG_FUSE_BPF
+	int err;
+
+	if (fuse_bpf_backing(inode, struct fuse_release_in, err,
+		       fuse_release_initialize_in, fuse_release_initialize_out,
+		       fuse_release_backing, fuse_release_finalize,
+		       inode, file))
+		return err;
+#endif
+
 	/*
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0e4996766c6c..f36a00e30c3f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1406,6 +1406,54 @@ struct fuse_entry_bpf {
 
 int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb);
 
+struct fuse_open_io {
+	struct fuse_open_in foi;
+	struct fuse_open_out foo;
+};
+
+int fuse_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_open_io *foi,
+			    struct inode *inode, struct file *file, bool isdir);
+int fuse_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_open_io *foi,
+			     struct inode *inode, struct file *file, bool isdir);
+int fuse_open_backing(struct bpf_fuse_args *fa, int *out,
+		      struct inode *inode, struct file *file, bool isdir);
+int fuse_open_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct inode *inode, struct file *file, bool isdir);
+
+struct fuse_create_open_io {
+	struct fuse_create_in fci;
+	struct fuse_entry_out feo;
+	struct fuse_open_out foo;
+};
+
+int fuse_create_open_initialize_in(struct bpf_fuse_args *fa, struct fuse_create_open_io *fcoi,
+				   struct inode *dir, struct dentry *entry,
+				   struct file *file, unsigned int flags, umode_t mode);
+int fuse_create_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_create_open_io *fcoi,
+				    struct inode *dir, struct dentry *entry,
+				    struct file *file, unsigned int flags, umode_t mode);
+int fuse_create_open_backing(struct bpf_fuse_args *fa, int *out,
+			     struct inode *dir, struct dentry *entry,
+			     struct file *file, unsigned int flags, umode_t mode);
+int fuse_create_open_finalize(struct bpf_fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry,
+			      struct file *file, unsigned int flags, umode_t mode);
+
+int fuse_release_initialize_in(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+			       struct inode *inode, struct file *file);
+int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+				struct inode *inode, struct file *file);
+int fuse_releasedir_initialize_in(struct bpf_fuse_args *fa,
+				  struct fuse_release_in *fri,
+				  struct inode *inode, struct file *file);
+int fuse_releasedir_initialize_out(struct bpf_fuse_args *fa,
+				   struct fuse_release_in *fri,
+				   struct inode *inode, struct file *file);
+int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *inode, struct file *file);
+int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
+			    struct inode *inode, struct file *file);
+
 struct fuse_lseek_io {
 	struct fuse_lseek_in fli;
 	struct fuse_lseek_out flo;
-- 
2.37.3.998.g577e59143f-goog

