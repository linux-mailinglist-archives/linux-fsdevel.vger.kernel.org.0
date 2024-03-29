Return-Path: <linux-fsdevel+bounces-15633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD88910CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EC9B24DD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2140C14;
	Fri, 29 Mar 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjaSbV0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAF1EB2C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677266; cv=none; b=so+7y/l2o8LEVKJYJ7B0BLZubBg8dUGhchkh0KcoDGB9fXxQStndWCTqYkWoKVmtYruF2cfh2a6RhTr9AhkL7ZqNgPqtCKYRQ5/uTfLaWRYbAlXQEO0rJz7kk73MhCy+0qG9TOJzF5V0dWRZ41S3o5CAqWKlB/XWHvUYkN8gsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677266; c=relaxed/simple;
	bh=Fkk92+rnt1CGnhyzsoVnRC9lfBnZyOPhYO5QkWWNTvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJZEtCvpj5Q5+W64mgLWndS/WYOrMVoaOSDvvIqmAVxEaW9f9nFQ95BzLoBp2z7q6Sv9dY7neY3oBV3d1kCLYKvM2gssGj/pTNFOWAsiV/S+MgX4exGVYNXo8Yw+kkqoDfUWD8GXKxCb2yckmtswlidaDMSGSJHoY09yXCc9jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjaSbV0p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso26412647b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677263; x=1712282063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrUtVK6+k7+1QZ3C4cNIecBhDWMks4vBEWUta1bw0HE=;
        b=IjaSbV0pq+ZhIw2JDU9172KAypV2z/sAra6GyIXNHfPWa6tVO4zVGBqjrbOBbKPFSJ
         NRW0P9HACSxAwJbXWDFWirAtHpO80z7DRd8i/xYssYH1cINthA84h7Cq2dte/Oh2VTu0
         5nrki2MngvFok2xGhao6GGN/nmLqvylB/AXRcSBJGYmnD7ofI20RcWR+pgvRMYqvWyGz
         zj//82gNuLlrf8M5r9rJb9dwXnBH9Vz4TEBTN2UmwWURCcNHKLIc6k2NxHqDKjKGSkiD
         IYz8CqtACNItAXKUGYH7AKJ71FyKfMCKpXQqmkCW+H2Tlo4FvwtZiOUYasyelJmIHRpB
         cZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677263; x=1712282063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrUtVK6+k7+1QZ3C4cNIecBhDWMks4vBEWUta1bw0HE=;
        b=iZZaOn2hDupuaspyf2n8QobHs9EifHBWsKYpUQ1apjCTy88Sks/MzpjhTldREWW2O2
         BCiT7rTbAOGXSmwSOEB6cKFQKCAYbF0E+6/9210i8QHNEM9cC9lIfd2+a4mkTabT9MEx
         wWSbF068y39BZydL9Oz96Q9ovSaWFVS4pxnW9hdvSIM6x10SfB7W+DcwCNt0GCdEihte
         OFyQOouDaV4pUQaiidbHb09a9thdSaKTWedRvGIeiaoneV/TGt1XNxl/xXKVx8pRdHfl
         uWqIy7Sojwx3uaOaUDof3RNpqEKCf43LBAzRLJs36C6+1AgJvR6qUF9SZyDdapzBZY43
         1mQw==
X-Forwarded-Encrypted: i=1; AJvYcCXcV8In33qeFxp0izBZHtu8gi8Vw13d7QJlf9zTeyf4CoRKN9ZpX8PsQBeAckXbfBO3QgYX7PGqocBh1jDkzRDj45d5fOJ7L5w7UTZrnQ==
X-Gm-Message-State: AOJu0Yyod8jDBc9U9942zDtFU0HgQ9ZnKNPUJMIFMK5NhYBYAhBwwK8l
	LPgItiXmM6OGSMHW+4RKVqqtp6Gjw2OwGEsuASYyllnDWZqqiX8kN2cmIijINvup1I63QzEeSVW
	f8Q==
X-Google-Smtp-Source: AGHT+IHUlRTQe/24H5Rd3XUF8D0L0jK5ORat1YiNu2Hnuiw60ohY9AVaFKP7PVzv+457HzOJe+gS/LwEsZk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:f910:0:b0:611:7166:1a4d with SMTP id
 x16-20020a81f910000000b0061171661a4dmr302696ywm.3.1711677263590; Thu, 28 Mar
 2024 18:54:23 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:26 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-12-drosen@google.com>
Subject: [RFC PATCH v4 11/36] fuse-bpf: Support file/dir open/close
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds backing support for FUSE_OPEN, FUSE_OPENDIR, FUSE_CREATE,
FUSE_RELEASE, and FUSE_RELEASEDIR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 336 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   3 +
 fs/fuse/file.c    |  62 +++++----
 fs/fuse/fuse_i.h  |  26 ++++
 4 files changed, 404 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4a22465ecdef..317a3adbbb3e 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -210,6 +210,342 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
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
+	if (!inode) {
+		*out = -EIO;
+		goto out;
+	}
+
+	newent = d_splice_alias(inode, entry);
+	if (IS_ERR(newent)) {
+		*out = PTR_ERR(newent);
+		goto out;
+	}
+
+	inode = NULL;
+	entry = newent ? newent : entry;
+	*out = finish_open(file, entry, fuse_open_file_backing);
+
+out:
+	iput(inode);
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
+				      struct inode *inode, struct fuse_file *ff)
+{
+	/* Always put backing file whatever bpf/userspace says */
+	fput(ff->backing_file);
+
+	*fri = (struct fuse_release_in) {
+		.fh = ff->fh,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(inode)->nodeid,
+			.opcode = S_ISDIR(inode->i_mode) ? FUSE_RELEASEDIR
+							 : FUSE_RELEASE,
+		},		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fri),
+		.in_args[0].value = fri,
+	};
+
+	return 0;
+}
+
+static int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
+				       struct inode *inode, struct fuse_file *ff)
+{
+	return 0;
+}
+
+static int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *inode, struct fuse_file *ff)
+{
+	return 0;
+}
+
+static int fuse_release_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct inode *inode, struct fuse_file *ff)
+{
+	*out = 0;
+	return 0;
+}
+
+int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff)
+{
+	return bpf_fuse_backing(inode, struct fuse_release_in, out,
+				fuse_release_initialize_in, fuse_release_initialize_out,
+				fuse_release_backing, fuse_release_finalize,
+				inode, ff);
+}
+
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff)
+{
+	return bpf_fuse_backing(inode, struct fuse_release_in, out,
+				fuse_release_initialize_in, fuse_release_initialize_out,
+				fuse_release_backing, fuse_release_finalize, inode, ff);
+}
+
 struct fuse_lseek_args {
 	struct fuse_lseek_in in;
 	struct fuse_lseek_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8db6eb6a0848..09bb4c63fd71 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -736,6 +736,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+	if (fuse_bpf_create_open(&err, dir, entry, file, flags, mode))
+		return err;
+
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0ab882e1236a..c43f2d61c41a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -106,25 +106,35 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
+static void fuse_file_put(struct inode *inode, struct fuse_file *ff,
+			  bool sync, bool isdir)
 {
-	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_args *args = &ff->release_args->args;
+	struct fuse_args *args = &ff->release_args->args;
+#ifdef CONFIG_FUSE_BPF
+	int err;
+#endif
+	if (!refcount_dec_and_test(&ff->count))
+		return;
 
-		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
-			/* Do nothing when client does not implement 'open' */
-			fuse_release_end(ff->fm, args, 0);
-		} else if (sync) {
-			fuse_simple_request(ff->fm, args);
-			fuse_release_end(ff->fm, args, 0);
-		} else {
-			args->end = fuse_release_end;
-			if (fuse_simple_background(ff->fm, args,
-						   GFP_KERNEL | __GFP_NOFAIL))
-				fuse_release_end(ff->fm, args, -ENOTCONN);
-		}
-		kfree(ff);
+#ifdef CONFIG_FUSE_BPF
+	 if (fuse_bpf_releasedir(&err, inode, ff)) {
+		 fuse_release_end(ff->fm, args, 0);
+	 } else
+#endif
+
+	if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
+		/* Do nothing when client does not implement 'open' */
+		fuse_release_end(ff->fm, args, 0);
+	} else if (sync) {
+		fuse_simple_request(ff->fm, args);
+		fuse_release_end(ff->fm, args, 0);
+	} else {
+		args->end = fuse_release_end;
+		if (fuse_simple_background(ff->fm, args,
+					   GFP_KERNEL | __GFP_NOFAIL))
+			fuse_release_end(ff->fm, args, -ENOTCONN);
 	}
+	kfree(ff);
 }
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
@@ -243,6 +253,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
+	if (fuse_bpf_open(&err, inode, file, isdir))
+		return err;
+
 	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
 
@@ -334,7 +347,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy, isdir);
+	fuse_file_put(ra->inode, ff, ff->fm->fc->destroy, isdir);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -374,7 +387,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
 	 * synchronous, we are fine with not doing igrab() here"
 	 */
-	fuse_file_put(ff, true, false);
+	fuse_file_put(&fi->inode, ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -930,8 +943,11 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		unlock_page(page);
 		put_page(page);
 	}
-	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+	if (ia->ff) {
+		WARN_ON(!mapping);
+		fuse_file_put(mapping ? mapping->host : NULL, ia->ff,
+			      false, false);
+	}
 
 	fuse_io_free(ia);
 }
@@ -1673,7 +1689,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->inode, wpa->ia.ff, false, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1928,7 +1944,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(inode, ff, false, false);
 
 	return err;
 }
@@ -2326,7 +2342,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(inode, data.ff, false, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7a6cebecd00f..a133010fde1c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1438,6 +1438,11 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
+int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
+			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
+int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
@@ -1445,6 +1450,27 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
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
2.44.0.478.gd926399ef9-goog


