Return-Path: <linux-fsdevel+bounces-15634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5F8910D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E6BB22FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2742079;
	Fri, 29 Mar 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="011HA22H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1B4086D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677268; cv=none; b=nZaq93Irja5MQGXwgPWiIQXevp26ZnLu+EsiTr7vEKR7ujy4hNDsmtnvp0W8JQQ3s9rTwVsC3nShGiZGtA8dPUeEW6CVfXCR90YO1h2vPeSANNT32+Ta1DA6uWBZa67cbS32xlJWMX/iDAdN2E4bt1M9kJL1+xk0bhYNFBU3HqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677268; c=relaxed/simple;
	bh=JLW59NjmZEXXJzbkpxfd4s8AQSfi6of7y8Bzc4kj/Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gU4CqtPqhVVCcAnadqxbg6NWaQu8PPldqZKyXTui9K6CCfmlVZRddHqZqQal339pJJBfDGqj6d2+0/yl333Wpl/dBbpgpWk4XuWVVeWF8FNvmV+NMNczUfB3zkuhKD+ot6v/6GdDVq+L87xk5w5cGQbp88bdQkH6tUpe2lcrJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=011HA22H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so2426117276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677265; x=1712282065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktsTVmyBdlTiNpg1aGMp+wH2qwaXK1AaKKS16VfXuCw=;
        b=011HA22Hps4cpxNx2buAPfy87SMOxluGxh315GZYczaGqPRp4j9AoAPv5j9X4RUHkl
         GnLdAUrxCinE4g7n7FixzGrAEYgVt4KJynpx+F/eB3YdzFr5h6BUB4oKCwfaxGJCaxek
         6ZMHrsiKhPtQySHXW5cn1jLxfe/cxdTekgCnhY3t5KoCCrPR6YhHVIa+ujDwZK/XojtI
         vxTZCIzx8sHMXu52K9r9OXUUUor8zm586LajpDNEE65gWU431Ae9/yGPf6ZzElTCayWM
         vuvf2aUGrbTbBUl4M3ZjJ1wftcvdD5L7WhT46VMgjoiLHnGw9312mKQAySbOjaAH6M3o
         en5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677265; x=1712282065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktsTVmyBdlTiNpg1aGMp+wH2qwaXK1AaKKS16VfXuCw=;
        b=A3y0mDARClK1QzKW3R9CyR5x17/rhDRdFbelSOw4ReqrFnw7vjafBpq8T0+ouzIhW0
         pRA6MGM/qE9EzRMuYqEw5iorIsFfCp/Hauyiz2QOpXsRBhTe7XM9dlZZt3G5ymGImstm
         7BgNWrhkhmUQMP4baf5fK8cuQp3EHZZb/HRjJjXyrvXrs88tEebKsbe1M7bkhx/ZTRzT
         uLID8xunfrMnyaGzKVOGGyU+ZPjXuX6/mDj+LrBLZD9/iIzaZIrx2vWf2kyyvIt3Ef1F
         pDEpSJq8Mvp3vKZ8gBv4mZ6G94/p/pkiCuAELaxX73Y+jV6JHXqr9QhQelSbnboYbo75
         DFbg==
X-Forwarded-Encrypted: i=1; AJvYcCWe4shJLh1VKjMmu6SSPuAiUcknKfAaxn77Oq3iAgeh2DMZMOVYvY0qDh7vDQn7CtWLSebK7XnQT1TF3bxZODvhRDatQrxbPbIqbyvNYg==
X-Gm-Message-State: AOJu0Yzxl5QD3Fc1mqGrUTvQC2up1h8ZeryZZz59pFugEKvsRerSA+W9
	HHUHyKvmzKmmypEac2jGzH2c9aYvG3kUJ3Ckg9HEwofnI9r861K1ECzmRJHs1DqT87/caeoSn9R
	9iw==
X-Google-Smtp-Source: AGHT+IHwPuMmlvt3RvgB+vaylOM9ssMbHVx7dCYSMOX3mHYJDBemyI25mz8XasllVr+OtJ/G4RkvvbuGvgc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2503:b0:dc9:c54e:c5eb with SMTP id
 dt3-20020a056902250300b00dc9c54ec5ebmr307231ybb.7.1711677265603; Thu, 28 Mar
 2024 18:54:25 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:27 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-13-drosen@google.com>
Subject: [RFC PATCH v4 12/36] fuse-bpf: Support mknod/unlink/mkdir/rmdir
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

This adds backing support for FUSE_MKNOD, FUSE_MKDIR, FUSE_RMDIR,
and FUSE_UNLINK

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  14 ++
 fs/fuse/fuse_i.h  |  24 ++++
 3 files changed, 380 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 317a3adbbb3e..567f859d300c 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -947,6 +947,348 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 	return 1;
 }
 
+struct fuse_mknod_args {
+	struct fuse_mknod_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_mknod_initialize_in(struct bpf_fuse_args *fa, struct fuse_mknod_args *args,
+				    struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	*args = (struct fuse_mknod_args) {
+		.in = (struct fuse_mknod_in) {
+			.mode = mode,
+			.rdev = new_encode_dev(rdev),
+			.umask = current_umask(),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_MKNOD,
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
+static int fuse_mknod_initialize_out(struct bpf_fuse_args *fa, struct fuse_mknod_args *args,
+				     struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+static int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = vfs_mknod(&nop_mnt_idmap, backing_inode, backing_path.dentry, mode,
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
+static int fuse_mknod_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return bpf_fuse_backing(dir, struct fuse_mknod_args, out,
+				fuse_mknod_initialize_in, fuse_mknod_initialize_out,
+				fuse_mknod_backing, fuse_mknod_finalize,
+				dir, entry, mode, rdev);
+}
+
+struct fuse_mkdir_args {
+	struct fuse_mkdir_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_mkdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_mkdir_args *args,
+				    struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	*args = (struct fuse_mkdir_args) {
+		.in = (struct fuse_mkdir_in) {
+			.mode = mode,
+			.umask = current_umask(),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_MKDIR,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.value = &args->name,
+			.is_buffer = true,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_mkdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_mkdir_args *args,
+				     struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+static int fuse_mkdir_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = vfs_mkdir(&nop_mnt_idmap, backing_inode, backing_path.dentry,
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
+static int fuse_mkdir_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return bpf_fuse_backing(dir, struct fuse_mkdir_args, out,
+				fuse_mkdir_initialize_in, fuse_mkdir_initialize_out,
+				fuse_mkdir_backing, fuse_mkdir_finalize,
+				dir, entry, mode);
+}
+
+static int fuse_rmdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				    struct inode *dir, struct dentry *entry)
+{
+	*name = (struct fuse_buffer) {
+		.data = (void *) entry->d_name.name,
+		.size = entry->d_name.len + 1,
+		.flags = BPF_FUSE_IMMUTABLE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_RMDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rmdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				     struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out,
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
+	*out = vfs_rmdir(&nop_mnt_idmap, backing_inode, backing_path.dentry);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
+{
+	return bpf_fuse_backing(dir, struct fuse_buffer, out,
+				fuse_rmdir_initialize_in, fuse_rmdir_initialize_out,
+				fuse_rmdir_backing, fuse_rmdir_finalize,
+				dir, entry);
+}
+
+static int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				     struct inode *dir, struct dentry *entry)
+{
+	*name = (struct fuse_buffer) {
+		.data = (void *) entry->d_name.name,
+		.size = entry->d_name.len + 1,
+		.flags = BPF_FUSE_IMMUTABLE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_UNLINK,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				      struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
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
+	*out = vfs_unlink(&nop_mnt_idmap, backing_inode, backing_path.dentry,
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
+static int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
+{
+	return bpf_fuse_backing(dir, struct fuse_buffer, out,
+				fuse_unlink_initialize_in, fuse_unlink_initialize_out,
+				fuse_unlink_backing, fuse_unlink_finalize,
+				dir, entry);
+}
+
 static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 09bb4c63fd71..a5b6aef788b2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -957,6 +957,10 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mknod(&err, dir, entry, mode, rdev))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -1003,6 +1007,10 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mkdir(&err, dir, entry, mode))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -1089,6 +1097,9 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_unlink(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_UNLINK;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
@@ -1112,6 +1123,9 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_rmdir(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_RMDIR;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a133010fde1c..9b176f78999f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1441,6 +1441,10 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
 int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
@@ -1461,6 +1465,26 @@ static inline int fuse_bpf_create_open(int *out, struct inode *dir, struct dentr
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
2.44.0.478.gd926399ef9-goog


