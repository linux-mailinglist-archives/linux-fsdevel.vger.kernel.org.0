Return-Path: <linux-fsdevel+bounces-15639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F298910E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91785B220FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE7524AF;
	Fri, 29 Mar 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccCqjfS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66914D9E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677281; cv=none; b=EEmIqbBVM/PseCnZb9MNu+EVT/zTdPHNAeUhMOjmlgwxynvsk6Y7idj0BO/pq4TDWDSUZ+QTjKITZBCwxHwoShyOiu8RYdvb6ALm1APQdcfsjIhI/FJJ2nU38+9F60gX6HqujUNr4TbXT7DAphleaSwSMt+CLZgrmGKXs0a0xa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677281; c=relaxed/simple;
	bh=1hYhQpZqd0XXYm/HQ/QbQPqNdnFO8JyYjGoojTz6Mc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=naSoEmazQgdJtA/CmFoRZXKBz6CsO0fITAKYKiIC4BofNXBPNl8FfCYdzfOsuIozQof2mnHvOdRz2FXsS35N/DBH8S9DtzqmfBJjhjm8h7danJN0Kc8rxAjlss5GX3M+D9GnUchgJTADnpgLIfDpBH3tUbKYprSPCFj6QvaKBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccCqjfS/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6fa0bso29201327b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677277; x=1712282077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkEzYxlv6dr5xmGlGpopV2VX8GvnZFbvgbTbydYSehc=;
        b=ccCqjfS/bjdQ2N4Gv/Yi+fO22id8bxq5vZ01OLRgusUt1k4HCQjDvvM8MBwIFQjvjt
         2fVHtGXFACvmj8i5xmTEoaZJDP/4kl+/0EniEN5tZ9MTGIgJf7WneX6fwNx3mI4gdc/l
         b+kJvNddTdq3ztRiPudLHHQfBLqlWB1GAGlGS8YzCAqbWZZMkepBYkZQfWfYqbevccA/
         ygbNNOJTS5SP86TiF6VNXUV+tLXse9mo2/LqEHnSw0FT/K2idP1wG3j+pRYeMAWLz88g
         6gsmAXaN7rJyVByztSYaQa5FPsb6UkFujI3Cs0yl2CJRQdgZGNQkpMScUSbHGoRRGUaD
         Ws8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677277; x=1712282077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkEzYxlv6dr5xmGlGpopV2VX8GvnZFbvgbTbydYSehc=;
        b=wW5S+6F5Yu+ybyuU1R7rx2jlO8irGGVdih1ratYUBnkVyf4A1naRPW5P/CMTn7WiQ6
         R9xQgUlsmMqQpyDK4DvhbUrV44SgIMSxQ2UCihcXxpsrSdjtNxB56/rZY9Mm+i67GliA
         N1SwNcFyQVZ4rVzugVgacwSs2fzU3gijtThxuf29E/Im+GAn6AJLQV3ZSVQazVtjdJVL
         rOhjBmtOgY5xhxXNyZ1hc9a5a1clb7DjVkJmwyOid1d3zT5k9sAZ0d5pxQBT1QDTb3CS
         pwxScjrGkzfrDKxdsei8RgK6qS22jQGpeXsR7UCgD9zAx1uVnypHGH8MCg9klK40lD9R
         Q36w==
X-Forwarded-Encrypted: i=1; AJvYcCXPKX8XB5qQ5IOXCk/+UbNysztiNKzFZsVo8ThUb6yRd8uMBU1L3Nu0R4d4EI3OqW3z7plOJapHDuHR3z6ZcZFu2f5PlrPHvxw9v93dzg==
X-Gm-Message-State: AOJu0YwvHdbat7KZSsJqB1zxZ5aAgR+jmkFiZ4hxQznGrQuGJHJ7I91t
	N4W+WCBURGTLbvpMQ+513cwNChbc/LPUfuOfidP8bYXe8ecUzcjLgS0+NH4aQWgxdrznWxakCnw
	9LA==
X-Google-Smtp-Source: AGHT+IG4o1CxL8Bjxr6xpQB23/9k8WNGx/uQfnx3fQAYtxSCzfzM/VJ9Weo4asX0Z+rhcZDoXimryo87d4s=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d897:0:b0:611:a624:12ea with SMTP id
 a145-20020a0dd897000000b00611a62412eamr287238ywe.0.1711677277090; Thu, 28 Mar
 2024 18:54:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:32 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-18-drosen@google.com>
Subject: [RFC PATCH v4 17/36] fuse-bpf: Add attr support
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

This adds backing support for FUSE_GETATTR, FUSE_SETATTR, and FUSE_STATFS

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 296 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  67 ++---------
 fs/fuse/fuse_i.h  | 102 ++++++++++++++++
 fs/fuse/inode.c   |  17 +--
 4 files changed, 412 insertions(+), 70 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 79f14634ae6a..e426268aa4e6 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2054,6 +2054,302 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_getattr_args {
+	struct fuse_getattr_in in;
+	struct fuse_attr_out out;
+};
+
+static int fuse_getattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getattr_args *args,
+				      const struct dentry *entry, struct kstat *stat,
+				      u32 request_mask, unsigned int flags)
+{
+	args->in = (struct fuse_getattr_in) {
+		.getattr_flags = flags,
+		.fh = -1, /* TODO is this OK? */
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(entry->d_inode),
+			.opcode = FUSE_GETATTR,
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
+static int fuse_getattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_getattr_args *args,
+				       const struct dentry *entry, struct kstat *stat,
+				       u32 request_mask, unsigned int flags)
+{
+	args->out = (struct fuse_attr_out) { 0 };
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
+/* TODO: unify with overlayfs */
+static inline int fuse_do_getattr(const struct path *path, struct kstat *stat,
+				 u32 request_mask, unsigned int flags)
+{
+	if (flags & AT_GETATTR_NOSEC)
+		return vfs_getattr_nosec(path, stat, request_mask, flags);
+	return vfs_getattr(path, stat, request_mask, flags);
+}
+
+static int fuse_getattr_backing(struct bpf_fuse_args *fa, int *out,
+				const struct dentry *entry, struct kstat *stat,
+				u32 request_mask, unsigned int flags)
+{
+	struct path *backing_path = &get_fuse_dentry(entry)->backing_path;
+	struct inode *backing_inode = backing_path->dentry->d_inode;
+	struct fuse_attr_out *fao = fa->out_args[0].value;
+	struct kstat tmp;
+
+	if (!stat)
+		stat = &tmp;
+
+	*out = fuse_do_getattr(backing_path, stat, request_mask, flags);
+
+	if (!*out)
+		fuse_stat_to_attr(get_fuse_conn(entry->d_inode), backing_inode,
+				  stat, &fao->attr);
+
+	return 0;
+}
+
+static int finalize_attr(struct inode *inode, struct fuse_attr_out *outarg,
+				u64 attr_version, struct kstat *stat)
+{
+	int err = 0;
+
+	if (fuse_invalid_attr(&outarg->attr) ||
+	    ((inode->i_mode ^ outarg->attr.mode) & S_IFMT)) {
+		fuse_make_bad(inode);
+		err = -EIO;
+	} else {
+		fuse_change_attributes(inode, &outarg->attr, NULL,
+				       ATTR_TIMEOUT(outarg), attr_version);
+		if (stat)
+			fuse_fillattr(inode, &outarg->attr, stat);
+	}
+	return err;
+}
+
+static int fuse_getattr_finalize(struct bpf_fuse_args *fa, int *out,
+				 const struct dentry *entry, struct kstat *stat,
+				 u32 request_mask, unsigned int flags)
+{
+	struct fuse_attr_out *outarg = fa->out_args[0].value;
+	struct inode *inode = entry->d_inode;
+	u64 attr_version = fuse_get_attr_version(get_fuse_mount(inode)->fc);
+
+	/* TODO: Ensure this doesn't happen if we had an error getting attrs in
+	 * backing.
+	 */
+	*out = finalize_attr(inode, outarg, attr_version, stat);
+	return 0;
+}
+
+int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+		     u32 request_mask, unsigned int flags)
+{
+	return bpf_fuse_backing(inode, struct fuse_getattr_args, out,
+				fuse_getattr_initialize_in, fuse_getattr_initialize_out,
+				fuse_getattr_backing, fuse_getattr_finalize,
+				entry, stat, request_mask, flags);
+}
+
+static void fattr_to_iattr(struct fuse_conn *fc,
+			   const struct fuse_setattr_in *arg,
+			   struct iattr *iattr)
+{
+	unsigned int fvalid = arg->valid;
+
+	if (fvalid & FATTR_MODE)
+		iattr->ia_valid |= ATTR_MODE, iattr->ia_mode = arg->mode;
+	if (fvalid & FATTR_UID) {
+		iattr->ia_valid |= ATTR_UID;
+		iattr->ia_uid = make_kuid(fc->user_ns, arg->uid);
+	}
+	if (fvalid & FATTR_GID) {
+		iattr->ia_valid |= ATTR_GID;
+		iattr->ia_gid = make_kgid(fc->user_ns, arg->gid);
+	}
+	if (fvalid & FATTR_SIZE)
+		iattr->ia_valid |= ATTR_SIZE, iattr->ia_size = arg->size;
+	if (fvalid & FATTR_ATIME) {
+		iattr->ia_valid |= ATTR_ATIME;
+		iattr->ia_atime.tv_sec = arg->atime;
+		iattr->ia_atime.tv_nsec = arg->atimensec;
+		if (!(fvalid & FATTR_ATIME_NOW))
+			iattr->ia_valid |= ATTR_ATIME_SET;
+	}
+	if (fvalid & FATTR_MTIME) {
+		iattr->ia_valid |= ATTR_MTIME;
+		iattr->ia_mtime.tv_sec = arg->mtime;
+		iattr->ia_mtime.tv_nsec = arg->mtimensec;
+		if (!(fvalid & FATTR_MTIME_NOW))
+			iattr->ia_valid |= ATTR_MTIME_SET;
+	}
+	if (fvalid & FATTR_CTIME) {
+		iattr->ia_valid |= ATTR_CTIME;
+		iattr->ia_ctime.tv_sec = arg->ctime;
+		iattr->ia_ctime.tv_nsec = arg->ctimensec;
+	}
+}
+
+struct fuse_setattr_args {
+	struct fuse_setattr_in in;
+	struct fuse_attr_out out;
+};
+
+static int fuse_setattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_setattr_args *args,
+				      struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+
+	*args = (struct fuse_setattr_args) { 0 };
+	iattr_to_fattr(fc, attr, &args->in, true);
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_SETATTR,
+			.nodeid = get_node_id(dentry->d_inode),
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_setattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_setattr_args *args,
+				       struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
+				struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(dentry->d_inode);
+	const struct fuse_setattr_in *fsi = fa->in_args[0].value;
+	struct iattr new_attr = { 0 };
+	struct path *backing_path = &get_fuse_dentry(dentry)->backing_path;
+
+	fattr_to_iattr(fc, fsi, &new_attr);
+	/* TODO: Some info doesn't get saved by the attr->fattr->attr transition
+	 * When we actually allow the bpf to change these, we may have to consider
+	 * the extra flags more, or pass more info into the bpf. Until then we can
+	 * keep everything except for ATTR_FILE, since we'd need a file on the
+	 * lower fs. For what it's worth, neither f2fs nor ext4 make use of that
+	 * even if it is present.
+	 */
+	new_attr.ia_valid = attr->ia_valid & ~ATTR_FILE;
+	inode_lock(d_inode(backing_path->dentry));
+	*out = notify_change(&nop_mnt_idmap, backing_path->dentry, &new_attr,
+			    NULL);
+	inode_unlock(d_inode(backing_path->dentry));
+
+	if (*out == 0 && (new_attr.ia_valid & ATTR_SIZE))
+		i_size_write(dentry->d_inode, new_attr.ia_size);
+	return 0;
+}
+
+static int fuse_setattr_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return bpf_fuse_backing(inode, struct fuse_setattr_args, out,
+				fuse_setattr_initialize_in, fuse_setattr_initialize_out,
+				fuse_setattr_backing, fuse_setattr_finalize,
+				dentry, attr, file);
+}
+
+static int fuse_statfs_initialize_in(struct bpf_fuse_args *fa, struct fuse_statfs_out *out,
+				     struct dentry *dentry, struct kstatfs *buf)
+{
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(d_inode(dentry)),
+			.opcode = FUSE_STATFS,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_statfs_initialize_out(struct bpf_fuse_args *fa, struct fuse_statfs_out *out,
+				      struct dentry *dentry, struct kstatfs *buf)
+{
+	*out = (struct fuse_statfs_out) { 0 };
+
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(*out);
+	fa->out_args[0].value = out;
+
+	return 0;
+}
+
+static int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
+			       struct dentry *dentry, struct kstatfs *buf)
+{
+	struct path backing_path;
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	*out = 0;
+	get_fuse_backing_path(dentry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+	*out = vfs_statfs(&backing_path, buf);
+	path_put(&backing_path);
+	buf->f_type = FUSE_SUPER_MAGIC;
+
+	//TODO Provide postfilter opportunity to modify
+	if (!*out)
+		convert_statfs_to_fuse(&fso->st, buf);
+
+	return 0;
+}
+
+static int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
+				struct dentry *dentry, struct kstatfs *buf)
+{
+	struct fuse_statfs_out *fso = fa->out_args[0].value;
+
+	if (!fa->info.error_in)
+		convert_fuse_statfs(buf, &fso->st);
+	return 0;
+}
+
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf)
+{
+	return bpf_fuse_backing(dentry->d_inode, struct fuse_statfs_out, out,
+				fuse_statfs_initialize_in, fuse_statfs_initialize_out,
+				fuse_statfs_backing, fuse_statfs_finalize,
+				dentry, buf);
+}
+
 struct fuse_read_args {
 	struct fuse_read_in in;
 	struct fuse_read_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0426243d9345..77d231ab1d9c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1256,7 +1256,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 			  struct kstat *stat)
 {
 	unsigned int blkbits;
@@ -1414,6 +1414,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 }
 
 static int fuse_update_get_attr(struct inode *inode, struct file *file,
+				const struct path *path,
 				struct kstat *stat, u32 request_mask,
 				unsigned int flags)
 {
@@ -1424,6 +1425,8 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
+	if (fuse_bpf_getattr(&err, inode, path->dentry, stat, request_mask, flags))
+			return err;
 
 	/* FUSE only supports basic stats and possibly btime */
 	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
@@ -1469,7 +1472,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(inode, file, &file->f_path, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1833,58 +1836,6 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
 				 FUSE_IOCTL_COMPAT | FUSE_IOCTL_DIR);
 }
 
-static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
-{
-	/* Always update if mtime is explicitly set  */
-	if (ivalid & ATTR_MTIME_SET)
-		return true;
-
-	/* Or if kernel i_mtime is the official one */
-	if (trust_local_mtime)
-		return true;
-
-	/* If it's an open(O_TRUNC) or an ftruncate(), don't update */
-	if ((ivalid & ATTR_SIZE) && (ivalid & (ATTR_OPEN | ATTR_FILE)))
-		return false;
-
-	/* In all other cases update */
-	return true;
-}
-
-static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
-			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
-{
-	unsigned ivalid = iattr->ia_valid;
-
-	if (ivalid & ATTR_MODE)
-		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
-	if (ivalid & ATTR_SIZE)
-		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
-	if (ivalid & ATTR_ATIME) {
-		arg->valid |= FATTR_ATIME;
-		arg->atime = iattr->ia_atime.tv_sec;
-		arg->atimensec = iattr->ia_atime.tv_nsec;
-		if (!(ivalid & ATTR_ATIME_SET))
-			arg->valid |= FATTR_ATIME_NOW;
-	}
-	if ((ivalid & ATTR_MTIME) && update_mtime(ivalid, trust_local_cmtime)) {
-		arg->valid |= FATTR_MTIME;
-		arg->mtime = iattr->ia_mtime.tv_sec;
-		arg->mtimensec = iattr->ia_mtime.tv_nsec;
-		if (!(ivalid & ATTR_MTIME_SET) && !trust_local_cmtime)
-			arg->valid |= FATTR_MTIME_NOW;
-	}
-	if ((ivalid & ATTR_CTIME) && trust_local_cmtime) {
-		arg->valid |= FATTR_CTIME;
-		arg->ctime = iattr->ia_ctime.tv_sec;
-		arg->ctimensec = iattr->ia_ctime.tv_nsec;
-	}
-}
-
 /*
  * Prevent concurrent writepages on inode
  *
@@ -1999,6 +1950,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
 
+	if (fuse_bpf_setattr(&err, inode, dentry, attr, file))
+		return err;
+
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
@@ -2178,7 +2132,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			if (!fuse_bpf_getattr(&ret, inode, entry, NULL, 0, 0))
+				ret = fuse_do_getattr(inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2235,7 +2190,7 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(inode, NULL, path, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8bd78a52a6b5..61a17071ab02 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1460,6 +1460,10 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+		     u32 request_mask, unsigned int flags);
+int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
+int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1559,6 +1563,22 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry, struct kstat *stat,
+				   u32 request_mask, unsigned int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
 {
 	return 0;
@@ -1577,6 +1597,88 @@ int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
+static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
+{
+	/* Always update if mtime is explicitly set  */
+	if (ivalid & ATTR_MTIME_SET)
+		return true;
+
+	/* Or if kernel i_mtime is the official one */
+	if (trust_local_mtime)
+		return true;
+
+	/* If it's an open(O_TRUNC) or an ftruncate(), don't update */
+	if ((ivalid & ATTR_SIZE) && (ivalid & (ATTR_OPEN | ATTR_FILE)))
+		return false;
+
+	/* In all other cases update */
+	return true;
+}
+
+void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
+			  struct kstat *stat);
+
+static inline void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
+			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
+{
+	unsigned int ivalid = iattr->ia_valid;
+
+	if (ivalid & ATTR_MODE)
+		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
+	if (ivalid & ATTR_UID)
+		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
+	if (ivalid & ATTR_GID)
+		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+	if (ivalid & ATTR_SIZE)
+		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
+	if (ivalid & ATTR_ATIME) {
+		arg->valid |= FATTR_ATIME;
+		arg->atime = iattr->ia_atime.tv_sec;
+		arg->atimensec = iattr->ia_atime.tv_nsec;
+		if (!(ivalid & ATTR_ATIME_SET))
+			arg->valid |= FATTR_ATIME_NOW;
+	}
+	if ((ivalid & ATTR_MTIME) && update_mtime(ivalid, trust_local_cmtime)) {
+		arg->valid |= FATTR_MTIME;
+		arg->mtime = iattr->ia_mtime.tv_sec;
+		arg->mtimensec = iattr->ia_mtime.tv_nsec;
+		if (!(ivalid & ATTR_MTIME_SET) && !trust_local_cmtime)
+			arg->valid |= FATTR_MTIME_NOW;
+	}
+	if ((ivalid & ATTR_CTIME) && trust_local_cmtime) {
+		arg->valid |= FATTR_CTIME;
+		arg->ctime = iattr->ia_ctime.tv_sec;
+		arg->ctimensec = iattr->ia_ctime.tv_nsec;
+	}
+}
+
+static inline void convert_statfs_to_fuse(struct fuse_kstatfs *attr, struct kstatfs *stbuf)
+{
+	attr->bsize   = stbuf->f_bsize;
+	attr->frsize  = stbuf->f_frsize;
+	attr->blocks  = stbuf->f_blocks;
+	attr->bfree   = stbuf->f_bfree;
+	attr->bavail  = stbuf->f_bavail;
+	attr->files   = stbuf->f_files;
+	attr->ffree   = stbuf->f_ffree;
+	attr->namelen = stbuf->f_namelen;
+	/* fsid is left zero */
+}
+
+static inline void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
+{
+	stbuf->f_type    = FUSE_SUPER_MAGIC;
+	stbuf->f_bsize   = attr->bsize;
+	stbuf->f_frsize  = attr->frsize;
+	stbuf->f_blocks  = attr->blocks;
+	stbuf->f_bfree   = attr->bfree;
+	stbuf->f_bavail  = attr->bavail;
+	stbuf->f_files   = attr->files;
+	stbuf->f_ffree   = attr->ffree;
+	stbuf->f_namelen = attr->namelen;
+	/* fsid is left zero */
+}
+
 #ifdef CONFIG_FUSE_BPF
 int __init fuse_bpf_init(void);
 void __exit fuse_bpf_cleanup(void);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 825b65117126..bc504e0d0e80 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -696,20 +696,6 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 	}
 }
 
-static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
-{
-	stbuf->f_type    = FUSE_SUPER_MAGIC;
-	stbuf->f_bsize   = attr->bsize;
-	stbuf->f_frsize  = attr->frsize;
-	stbuf->f_blocks  = attr->blocks;
-	stbuf->f_bfree   = attr->bfree;
-	stbuf->f_bavail  = attr->bavail;
-	stbuf->f_files   = attr->files;
-	stbuf->f_ffree   = attr->ffree;
-	stbuf->f_namelen = attr->namelen;
-	/* fsid is left zero */
-}
-
 static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -723,6 +709,9 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 		return 0;
 	}
 
+	if (fuse_bpf_statfs(&err, dentry->d_inode, dentry, buf))
+		return err;
+
 	memset(&outarg, 0, sizeof(outarg));
 	args.in_numargs = 0;
 	args.opcode = FUSE_STATFS;
-- 
2.44.0.478.gd926399ef9-goog


