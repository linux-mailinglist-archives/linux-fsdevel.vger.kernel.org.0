Return-Path: <linux-fsdevel+bounces-15638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F086F8910E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA3628C3CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3E5025C;
	Fri, 29 Mar 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIas3dmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31722324
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677279; cv=none; b=YNvi87BBVlqJuOt262Ur2pUqkGVtrE2EQ/R7YIZCc3BbY5N5PplJBiztYtAMewn9C1PN3bpl66IPJtGXj7NsMMmgjxm+qeFmXW/MMLsw2icweZinzv3hKokOyW1cKd2/pVAajRDExLfRimoCHy929fZ6pl8iIAFO+qevTo98Nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677279; c=relaxed/simple;
	bh=seVXvwMXgA0k5B5i3rtJiPJjVyPtrH17rjRa+Ib3NxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J0nvLGAT0iICpoEKMpEOOk6bPylaouWj3qZ37VfhHQKENI8znIkwJFXaobG230Lqx2B+7TWwwoyNe93n0GLcW3g7SUnfZ6Fap6WkztveexozKcxujAzkBjoNMqD7NdA56XNT5bvTXPaaoyZnxL3orwVDu+cDYqeRTNqvJkyd1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIas3dmj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610c23abd1fso29393577b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677275; x=1712282075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RvKFKfzlaqvNJCMsDkIXVlyZd4roHhNkix9YqBfVGw=;
        b=jIas3dmjUe8q1KNTkMCw7YqZ99wXpIBLGOiCNzlaG2QZ53A/iNsJpfqFHM66kRq3aF
         zLwwPU1Aa8HHw4KNuKcAb8ciR/2SsVv4OP4wIzUltSlB2qvmKIYyOJU15gTLrqdcb7nK
         TXJ05PbM7sCruXCtb2sGoxPdveKjX9cpky+ZyoylvCI4fuLVjzTz5D0V3QIkgGGfBZtc
         oQp5rR8nKmp3VAGxeN93cbMIMSOMq7wNX9Y1IxKvoag1D2ZwU2JuhoIDgAph/+wgXEsi
         6PAfMZ1Ewh5gdaGdiDTqydnXzfPwVBdL96wY1AVRmSL54NgVEM7tvhJzGygnOyG/zxhk
         yt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677275; x=1712282075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RvKFKfzlaqvNJCMsDkIXVlyZd4roHhNkix9YqBfVGw=;
        b=MyAXK/831tB9/YuUCRt/4bIHSgiplbCMjfslK4mCILjyCWYIyTUGy708WQ0SFbj/WU
         ggSRyxH8LDsdG4243U+a5j7QI7ZEZxYXnNeCDHpFelSp/6xKm0aARoEI6Ss7rLAjf5Q5
         Mj1hMFtGTsSSSE4/FOXqTVU7JmJWFeKkWuVJG991/bFqTDjlZNCCpt5v93RE0sABK44B
         UyJZYI0Nzng7Dd1NHbjmQCWx9eV4MBjYsyGXP5uHbeLNona4/idGISllDCYj6ruDZIrk
         7owY+yVTF+xnJuNsb0aX/KrnQA0h/YIrrvq7IqcQ/BQ170uClnuH15VmZY/eFcxxvBCJ
         9nvw==
X-Forwarded-Encrypted: i=1; AJvYcCXYWzMmhFwalkJoGL8JMGjnhISLwTL4G9O4zFsJsnvsqwwfmDuQJ/3lxnQHwFhRxckG7oVGrs2I1g5xmTn5aUUxioXi8Y5IA+UAA/M7TA==
X-Gm-Message-State: AOJu0YwnC4GckIxIOMAwwpKv0ap/dRDC1Hj5VUHcgqrG2Iwq8Nr3xjvz
	A/sa3RdLadp+7xPp/7ImLvGthPmKVelaRlDf9kz/EhKwXhcATLP+xg5ZQYLUNjwkn4hDWS5hUXk
	Xwg==
X-Google-Smtp-Source: AGHT+IHsWOvc3Xo3vBsc98bEWBAPo7Ucv4KOtI122IiuAOiG69fT08BIPjlwpkCXP2ftn3U/Pi18R6ZCx00=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d8c5:0:b0:614:4c1:c8d with SMTP id
 a188-20020a0dd8c5000000b0061404c10c8dmr308429ywe.6.1711677275050; Thu, 28 Mar
 2024 18:54:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:31 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-17-drosen@google.com>
Subject: [RFC PATCH v4 16/36] fuse-bpf: Add Rename support
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

This adds backing support for FUSE_RENAME and FUSE_RENAME2

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   7 ++
 fs/fuse/fuse_i.h  |  18 ++++
 3 files changed, 275 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c2c5cb3d3d6e..79f14634ae6a 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1735,6 +1735,256 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+static int fuse_rename_backing_common(struct inode *olddir,
+				      struct dentry *oldent,
+				      struct inode *newdir,
+				      struct dentry *newent, unsigned int flags)
+{
+	int err = 0;
+	struct path old_backing_path;
+	struct path new_backing_path;
+	struct dentry *old_backing_dir_dentry;
+	struct dentry *old_backing_dentry;
+	struct dentry *new_backing_dir_dentry;
+	struct dentry *new_backing_dentry;
+	struct dentry *trap = NULL;
+	struct inode *target_inode;
+	struct renamedata rd;
+
+	//TODO Actually deal with changing anything that isn't a flag
+	get_fuse_backing_path(oldent, &old_backing_path);
+	if (!old_backing_path.dentry)
+		return -EBADF;
+	get_fuse_backing_path(newent, &new_backing_path);
+	if (!new_backing_path.dentry) {
+		/*
+		 * TODO A file being moved from a backing path to another
+		 * backing path which is not yet instrumented with FUSE-BPF.
+		 * This may be slow and should be substituted with something
+		 * more clever.
+		 */
+		err = -EXDEV;
+		goto put_old_path;
+	}
+	if (new_backing_path.mnt != old_backing_path.mnt) {
+		err = -EXDEV;
+		goto put_new_path;
+	}
+	old_backing_dentry = old_backing_path.dentry;
+	new_backing_dentry = new_backing_path.dentry;
+	old_backing_dir_dentry = dget_parent(old_backing_dentry);
+	new_backing_dir_dentry = dget_parent(new_backing_dentry);
+	target_inode = d_inode(newent);
+
+	trap = lock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+	if (trap == old_backing_dentry) {
+		err = -EINVAL;
+		goto put_parents;
+	}
+	if (trap == new_backing_dentry) {
+		err = -ENOTEMPTY;
+		goto put_parents;
+	}
+
+	rd = (struct renamedata) {
+		.old_mnt_idmap = &nop_mnt_idmap,
+		.old_dir = d_inode(old_backing_dir_dentry),
+		.old_dentry = old_backing_dentry,
+		.new_mnt_idmap = &nop_mnt_idmap,
+		.new_dir = d_inode(new_backing_dir_dentry),
+		.new_dentry = new_backing_dentry,
+		.flags = flags,
+	};
+	err = vfs_rename(&rd);
+	if (err)
+		goto unlock;
+	if (target_inode)
+		fsstack_copy_attr_all(target_inode,
+				get_fuse_inode(target_inode)->backing_inode);
+	fsstack_copy_attr_all(d_inode(oldent), d_inode(old_backing_dentry));
+unlock:
+	unlock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+put_parents:
+	dput(new_backing_dir_dentry);
+	dput(old_backing_dir_dentry);
+put_new_path:
+	path_put(&new_backing_path);
+put_old_path:
+	path_put(&old_backing_path);
+	return err;
+}
+
+struct fuse_rename2_args {
+	struct fuse_rename2_in in;
+	struct fuse_buffer old_name;
+	struct fuse_buffer new_name;
+};
+
+static int fuse_rename2_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename2_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent,
+				      unsigned int flags)
+{
+	*args = (struct fuse_rename2_args) {
+		.in = (struct fuse_rename2_in) {
+			.newdir = get_node_id(newdir),
+			.flags = flags,
+		},
+		.old_name = (struct fuse_buffer) {
+			.data = (void *) oldent->d_name.name,
+			.size = oldent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.new_name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(olddir),
+			.opcode = FUSE_RENAME2,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->old_name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->new_name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename2_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename2_args *args,
+				       struct inode *olddir, struct dentry *oldent,
+				       struct inode *newdir, struct dentry *newent,
+				       unsigned int flags)
+{
+	return 0;
+}
+
+static int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent,
+				unsigned int flags)
+{
+	const struct fuse_rename2_args *fri = fa->in_args[0].value;
+
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent,
+					  fri->in.flags);
+	return *out;
+}
+
+static int fuse_rename2_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct inode *olddir, struct dentry *oldent,
+				 struct inode *newdir, struct dentry *newent,
+				 unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags)
+{
+	return bpf_fuse_backing(olddir, struct fuse_rename2_args, out,
+				fuse_rename2_initialize_in, fuse_rename2_initialize_out,
+				fuse_rename2_backing, fuse_rename2_finalize,
+				olddir, oldent, newdir, newent, flags);
+}
+
+struct fuse_rename_args {
+	struct fuse_rename_in in;
+	struct fuse_buffer old_name;
+	struct fuse_buffer new_name;
+};
+
+static int fuse_rename_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent)
+{
+	*args = (struct fuse_rename_args) {
+		.in = (struct fuse_rename_in) {
+			.newdir = get_node_id(newdir),
+		},
+		.old_name = (struct fuse_buffer) {
+			.data = (void *) oldent->d_name.name,
+			.size = oldent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.new_name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(olddir),
+			.opcode = FUSE_RENAME,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->old_name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->new_name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent)
+{
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent, 0);
+	return *out;
+}
+
+static int fuse_rename_finalize(struct bpf_fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent)
+{
+	return bpf_fuse_backing(olddir, struct fuse_rename_args, out,
+				fuse_rename_initialize_in, fuse_rename_initialize_out,
+				fuse_rename_backing, fuse_rename_finalize,
+				olddir, oldent, newdir, newent);
+}
+
 static int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
 				     struct inode *dir, struct dentry *entry)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7b661fcd5470..0426243d9345 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1204,6 +1204,10 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 		return -EINVAL;
 
 	if (flags) {
+		if (fuse_bpf_rename2(&err, olddir, oldent, newdir, newent, flags))
+			return err;
+
+		/* TODO: how should this go with bpfs involved? */
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
@@ -1215,6 +1219,9 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
+		if (fuse_bpf_rename(&err, olddir, oldent, newdir, newent))
+			return err;
+
 		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 256e217880c8..8bd78a52a6b5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1444,6 +1444,11 @@ int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
 int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
 int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags);
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
@@ -1486,6 +1491,19 @@ static inline int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *ent
 	return 0;
 }
 
+static inline int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+				   struct inode *newdir, struct dentry *newent,
+				   unsigned int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+				  struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


