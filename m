Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDE6E56F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjDRBo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDRBnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0F728F
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 85-20020a250d58000000b00b8f380b2bccso15565196ybn.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782106; x=1684374106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvRLddSkeIm9PecIuzQsl89859K3ZUpPQfxG17id1Mk=;
        b=XlxFgRg0kxYxSjyZXrqofVDZz+iSvTOODqUtf12czQ/mSsTbgNfeu3peW779Uw8Dc2
         18GKMXLuUG+C+s8RgVUM+pHcTAB4mu2P0Oa2/5s3x2TJHxPzoaNL0gqI9Ve2X2bcARlj
         8OtlZ4AlEhFGz0C72gRftnGxUtBvNhSxFRzbv5iJaoXCIKt7BX4WeruaHXiCykenQ9ZP
         0MXj57A6OYaCu2AkWRsuzJcjqTUNLUf1dqEO2GjZ6bkHl298GXkexM1oElOZAKVXcdsA
         COWy7z5p3ou2wEN10bVz4/gExra0QrVpaW+GfbTKy+ZCyMZynWOs0Tp9Dtm3XdypbrDI
         YBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782106; x=1684374106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvRLddSkeIm9PecIuzQsl89859K3ZUpPQfxG17id1Mk=;
        b=PKRDNL9/vs9/57AxZ4IVOQPeOVRpcK4rP2x1tu1SuLF8TzQGxK88uE+C66dFXfA1FZ
         OMi2IKz0IwraorF7aEiGz29GfF/kfpvncqkK7Kl2iqtvLaACpId4pVWzg6n3khQvQnxd
         wfMnZt3YMP7rL1Ttn0MK2fIP7jQt7Zk2UaxrnmMxdbuqP4uE3VQCSfApFoDS7NMAUgra
         ERPsaINC3CG55jtOrnaJ8nzQGXiNAGkmKAHYs0U0fD6uYGUal3/Lq7b8Q6c8XhprHewD
         CvdgYf3QI1UxMe0o964dyfEVXSgwvmrviHS3nKVNQSR2JGEVi6QixIHjkpTN6QhLFJG1
         /+Wg==
X-Gm-Message-State: AAQBX9c45d6KXij40gMEhHfSeuDEhe7O1vjhGXxqlBVnYVSnXTriUgT8
        469Y2jQwc1m/RrU7r7Tkpt2ml+ObOJc=
X-Google-Smtp-Source: AKy350bnnjuHdh4NImroO7h36oSrvoNCrPKP80I7mzBIz856gdltQzBiy3nX4BcegzARjsg+1e/Y1F6L+7o=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:cc05:0:b0:b8b:eea7:525a with SMTP id
 l5-20020a25cc05000000b00b8beea7525amr8483126ybf.7.1681782106223; Mon, 17 Apr
 2023 18:41:46 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:24 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-25-drosen@google.com>
Subject: [RFC PATCH v3 24/37] fuse-bpf: Add symlink/link support
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds backing support for FUSE_LINK, FUSE_READLINK, and FUSE_SYMLINK

Signed-off-by: Daniel Rosenberg <drosen@google.com
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 327 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  11 ++
 fs/fuse/fuse_i.h  |  20 +++
 3 files changed, 358 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index eb3eb184c867..e807ae4f6f53 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2502,6 +2502,125 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_link_args {
+	struct fuse_link_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_link_args *args,
+				   struct dentry *entry, struct inode *dir,
+				   struct dentry *newent)
+{
+	struct inode *src_inode = entry->d_inode;
+
+	*args = (struct fuse_link_args) {
+		.in = (struct fuse_link_in) {
+			.oldnodeid = get_node_id(src_inode),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_LINK,
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
+static int fuse_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_link_args *args,
+				    struct dentry *entry, struct inode *dir,
+				    struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_link_backing(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+			     struct inode *dir, struct dentry *newent)
+{
+	struct path backing_old_path;
+	struct path backing_new_path;
+	struct dentry *backing_dir_dentry;
+	struct inode *fuse_new_inode = NULL;
+	struct fuse_inode *fuse_dir_inode = get_fuse_inode(dir);
+	struct inode *backing_dir_inode = fuse_dir_inode->backing_inode;
+
+	*out = 0;
+	get_fuse_backing_path(entry, &backing_old_path);
+	if (!backing_old_path.dentry)
+		return -EBADF;
+
+	get_fuse_backing_path(newent, &backing_new_path);
+	if (!backing_new_path.dentry) {
+		*out = -EBADF;
+		goto err_dst_path;
+	}
+
+	backing_dir_dentry = dget_parent(backing_new_path.dentry);
+	backing_dir_inode = d_inode(backing_dir_dentry);
+
+	inode_lock_nested(backing_dir_inode, I_MUTEX_PARENT);
+	*out = vfs_link(backing_old_path.dentry, &nop_mnt_idmap,
+		       backing_dir_inode, backing_new_path.dentry, NULL);
+	inode_unlock(backing_dir_inode);
+	if (*out)
+		goto out;
+
+	if (d_really_is_negative(backing_new_path.dentry) ||
+	    unlikely(d_unhashed(backing_new_path.dentry))) {
+		*out = -EINVAL;
+		/**
+		 * TODO: overlayfs responds to this situation with a
+		 * lookupOneLen. Should we do that too?
+		 */
+		goto out;
+	}
+
+	fuse_new_inode = fuse_iget_backing(dir->i_sb, fuse_dir_inode->nodeid, backing_dir_inode);
+	if (IS_ERR(fuse_new_inode)) {
+		*out = PTR_ERR(fuse_new_inode);
+		goto out;
+	}
+	d_instantiate(newent, fuse_new_inode);
+
+out:
+	dput(backing_dir_dentry);
+	path_put(&backing_new_path);
+err_dst_path:
+	path_put(&backing_old_path);
+	return *out;
+}
+
+static int fuse_link_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+			      struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry,
+		  struct inode *newdir, struct dentry *newent)
+{
+	return bpf_fuse_backing(inode, struct fuse_link_args, out,
+				fuse_link_initialize_in, fuse_link_initialize_out,
+				fuse_link_backing, fuse_link_finalize,
+				entry, newdir, newent);
+}
+
 struct fuse_getattr_args {
 	struct fuse_getattr_in in;
 	struct fuse_attr_out out;
@@ -2790,6 +2909,214 @@ int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct
 				dentry, buf);
 }
 
+struct fuse_get_link_args {
+	struct fuse_buffer name;
+	struct fuse_buffer path;
+};
+
+static int fuse_get_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_get_link_args *args,
+				       struct inode *inode, struct dentry *dentry,
+				       struct delayed_call *callback)
+{
+	/*
+	 * TODO
+	 * If we want to handle changing these things, we'll need to copy
+	 * the lower fs's data into our own buffer, and provide our own callback
+	 * to free that buffer.
+	 *
+	 * Pre could change the name we're looking at
+	 * postfilter can change the name we return
+	 *
+	 * We ought to only make that buffer if it's been requested, so leaving
+	 * this unimplemented for the moment
+	 */
+	*args = (struct fuse_get_link_args) {
+		.name = (struct fuse_buffer) {
+			.data =  (void *) dentry->d_name.name,
+			.size = dentry->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_READLINK,
+			.nodeid = get_node_id(inode),
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_get_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_get_link_args *args,
+					struct inode *inode, struct dentry *dentry,
+					struct delayed_call *callback)
+{
+	// TODO
+#if 0
+	args->path = (struct fuse_buffer) {
+		.data =  NULL,
+		.size = 0,
+		.max_size = PATH_MAX,
+		.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+	};
+	fa->out_numargs = 1;
+	fa->out_args[0].is_buffer = true;
+	fa->out_args[0].buffer = &args->path;
+#endif
+
+	return 0;
+}
+
+static int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
+				 struct inode *inode, struct dentry *dentry,
+				 struct delayed_call *callback)
+{
+	struct path backing_path;
+
+	if (!dentry) {
+		*out = ERR_PTR(-ECHILD);
+		return PTR_ERR(*out);
+	}
+
+	get_fuse_backing_path(dentry, &backing_path);
+	if (!backing_path.dentry) {
+		*out = ERR_PTR(-ECHILD);
+		return PTR_ERR(*out);
+	}
+
+	/*
+	 * TODO: If we want to do our own thing, copy the data and then call the
+	 * callback
+	 */
+	*out = vfs_get_link(backing_path.dentry, callback);
+
+	path_put(&backing_path);
+	return 0;
+}
+
+static int fuse_get_link_finalize(struct bpf_fuse_args *fa, const char **out,
+				  struct inode *inode, struct dentry *dentry,
+				  struct delayed_call *callback)
+{
+	return 0;
+}
+
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback)
+{
+	return bpf_fuse_backing(inode, struct fuse_get_link_args, out,
+				fuse_get_link_initialize_in, fuse_get_link_initialize_out,
+				fuse_get_link_backing, fuse_get_link_finalize,
+				inode, dentry, callback);
+}
+
+struct fuse_symlink_args {
+	struct fuse_buffer name;
+	struct fuse_buffer path;
+};
+
+static int fuse_symlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_symlink_args *args,
+				      struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	*args = (struct fuse_symlink_args) {
+		.name = (struct fuse_buffer) {
+			.data =  (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.path = (struct fuse_buffer) {
+			.data = (void *) link,
+			.size = len,
+			.max_size = PATH_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_SYMLINK,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->path,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_symlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_symlink_args *args,
+				       struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+static int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+
+	*out = 0;
+	//TODO Actually deal with changing the backing entry in symlink
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_symlink(&nop_mnt_idmap, backing_inode, backing_path.dentry,
+			  link);
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
+static int  fuse_symlink_finalize(struct bpf_fuse_args *fa, int *out,
+				  struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+int  fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return bpf_fuse_backing(dir, struct fuse_symlink_args, out,
+				fuse_symlink_initialize_in, fuse_symlink_initialize_out,
+				fuse_symlink_backing, fuse_symlink_finalize,
+				dir, entry, link, len);
+}
+
 struct fuse_read_args {
 	struct fuse_read_in in;
 	struct fuse_read_out out;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7d589241c9b0..d1c3b2bfb0b1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1013,6 +1013,10 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_symlink(&err, dir, entry, link, len))
+		return err;
 
 	args.opcode = FUSE_SYMLINK;
 	args.in_numargs = 2;
@@ -1219,6 +1223,9 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 
+	if (fuse_bpf_link(&err, inode, entry, newdir, newent))
+		return err;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	args.opcode = FUSE_LINK;
@@ -1618,12 +1625,16 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct page *page;
+	const char *out = NULL;
 	int err;
 
 	err = -EIO;
 	if (fuse_is_bad(inode))
 		goto out_err;
 
+	if (fuse_bpf_get_link(&out, inode, dentry, callback))
+		return out;
+
 	if (fc->cache_symlinks)
 		return page_get_link(dentry, inode, callback);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 243a8fe0c343..121d31a04e79 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1417,6 +1417,7 @@ int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
 int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
 		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry, struct inode *dir, struct dentry *newent);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
@@ -1441,6 +1442,9 @@ int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry,
 		     u32 request_mask, unsigned int flags);
 int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
 int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback);
+int fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1490,6 +1494,11 @@ static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *en
 	return 0;
 }
 
+static inline int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry, struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
 {
 	return 0;
@@ -1586,6 +1595,17 @@ static inline int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *
 	return 0;
 }
 
+static inline int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
 {
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

