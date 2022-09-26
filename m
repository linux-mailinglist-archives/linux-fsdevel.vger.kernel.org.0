Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06425EB59D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiIZXV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiIZXUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:20:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453EF392B
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349e6acbac9so75373007b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=wQF6G/HA0Y+V1EPjEVB3vfWMwGjE+u8YI2mwSvpQX+A=;
        b=kSzdpk+0TtLxZlVVK/DVfp1N3TQxI9DGFy/HC2ygJsBTsXc5QTDhng/sqvFU+UQYAU
         9bB2RGN++XitMQ78eIZcdGWQwypjK4/NPr+bT2Lrhatok8KTTr3MJ1jgD3HD6/gGwAxb
         0li8DD9vRKm7COgZGkvjNULUA6L7b99O77pPD6Vcqwbq8bMGPUJuuydUKMRoauulBtl5
         kDRrvC2bGBEpW3R3NlGiL9aWPAXwC8E0OcJBpXymmiVTvpTyPoOFJj9E2suiT2DjaAoF
         onPaqC0lY5BPbg2KJK0nqhACzpU0oPiVrFfRM29M3PCvjDwvk5HQjLqt8oXI0bFsSZSE
         aLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=wQF6G/HA0Y+V1EPjEVB3vfWMwGjE+u8YI2mwSvpQX+A=;
        b=tjhDVpTFWx/vpEeSN1tFU4ZSwQGTBthKdA3QkgIPzDlUm4dWjlvU3YTp4FWItL+Qiz
         52ff4XmcTaAlZavD1+lL/2ZznnYiGsZTv4z2kftRLTOkF+Vx+B1C+jS5lOEN17sm/vG9
         RBIFJVBaaoZtTmIWNgNxqLS1A+ALkDaP9NqdaUWluZbGCNlO1QfycILwdJPwV11H6NLN
         8d2eN/5OiHzz1QSOkSqFrLaQnzZzuHWTyutqJGo7qLXRmbV3JuxFs8d4SCPEiTkbOsKo
         Ej8sVOT1wYobcQB9dXqzH8xnwSg9m0/YgHbH8MWyQW6bLVhnvSJU8lp982WaurGr8M8h
         t4Cg==
X-Gm-Message-State: ACrzQf1CDQOamBCdnOZPuKiHs0DX/VGIxpv/fIuq7F8AP/DQFJjFwfuH
        7OceAmx80jOcIF9FogN8015hKQBuHw4=
X-Google-Smtp-Source: AMsMyM45pPcZ0MK0I2fYYY52zyvKq6iZoagcjyg2ZSR5rYf0mFbYDxV73EIk0/u6BZNq+Tj6XEXL3eP7wp8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:8b8b:0:b0:6af:93be:c53e with SMTP id
 j11-20020a258b8b000000b006af93bec53emr23431948ybl.338.1664234368927; Mon, 26
 Sep 2022 16:19:28 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:18 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-23-drosen@google.com>
Subject: [PATCH 22/26] fuse-bpf: Add symlink/link support
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
 fs/fuse/backing.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  31 ++++++
 fs/fuse/fuse_i.h  |  33 ++++++
 3 files changed, 315 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d8c86234f253..485b6f1e8503 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1951,6 +1951,97 @@ int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+int fuse_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_link_in *fli,
+			    struct dentry *entry, struct inode *dir,
+			    struct dentry *newent)
+{
+	struct inode *src_inode = entry->d_inode;
+
+	*fli = (struct fuse_link_in) {
+		.oldnodeid = get_node_id(src_inode),
+	};
+
+	fa->opcode = FUSE_LINK;
+	fa->in_numargs = 2;
+	fa->in_args[0].size = sizeof(*fli);
+	fa->in_args[0].value = fli;
+	fa->in_args[1].size = newent->d_name.len + 1;
+	fa->in_args[1].max_size = NAME_MAX + 1;
+	fa->in_args[1].value = (void *) newent->d_name.name;
+	fa->in_args[1].flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE;
+
+	return 0;
+}
+
+int fuse_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_link_in *fli,
+			     struct dentry *entry, struct inode *dir,
+			     struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_link_backing(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+		      struct inode *dir, struct dentry *newent)
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
+	*out = vfs_link(backing_old_path.dentry, &init_user_ns,
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
+int fuse_link_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+		       struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
 int fuse_getattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getattr_io *fgio,
 			       const struct dentry *entry, struct kstat *stat,
 			       u32 request_mask, unsigned int flags)
@@ -2215,6 +2306,166 @@ int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+int fuse_get_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+				struct inode *inode, struct dentry *dentry,
+				struct delayed_call *callback)
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
+	*fa = (struct bpf_fuse_args) {
+		.opcode = FUSE_READLINK,
+		.nodeid = get_node_id(inode),
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = dentry->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value =  (void *) dentry->d_name.name,
+		},
+		/*
+		 * .out_argvar = 1,
+		 * .out_numargs = 1,
+		 * .out_args[0].size = ,
+		 * .out_args[0].value = ,
+		 */
+	};
+
+	return 0;
+}
+
+int fuse_get_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+				 struct inode *inode, struct dentry *dentry,
+				 struct delayed_call *callback)
+{
+	/*
+	 * .out_argvar = 1,
+	 * .out_numargs = 1,
+	 * .out_args[0].size = ,
+	 * .out_args[0].value = ,
+	 */
+
+	return 0;
+}
+
+int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
+			  struct inode *inode, struct dentry *dentry,
+			  struct delayed_call *callback)
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
+int fuse_get_link_finalize(struct bpf_fuse_args *fa, const char **out,
+			     struct inode *inode, struct dentry *dentry,
+			     struct delayed_call *callback)
+{
+	return 0;
+}
+
+int fuse_symlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+			       struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_SYMLINK,
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = len,
+			.max_size = PATH_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value = (void *) link,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_symlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+				struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *dir, struct dentry *entry, const char *link, int len)
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
+	*out = vfs_symlink(&init_user_ns, backing_inode, backing_path.dentry,
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
+int  fuse_symlink_finalize(struct bpf_fuse_args *fa, int *out,
+			   struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
 int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
 			    struct file *file, struct dir_context *ctx,
 			    bool *force_again, bool *allow_force, bool is_continued)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index af1f715a405d..a4fd1cb018be 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -967,6 +967,16 @@ static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	unsigned len = strlen(link) + 1;
 	FUSE_ARGS(args);
 
+#ifdef CONFIG_FUSE_BPF
+	int err;
+
+	if (fuse_bpf_backing(dir, struct fuse_dummy_io, err,
+			fuse_symlink_initialize_in, fuse_symlink_initialize_out,
+			fuse_symlink_backing, fuse_symlink_finalize,
+			dir, entry, link, len))
+		return err;
+#endif
+
 	args.opcode = FUSE_SYMLINK;
 	args.in_numargs = 2;
 	args.in_args[0].size = entry->d_name.len + 1;
@@ -1198,6 +1208,14 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_link_in, err,
+				fuse_link_initialize_in, fuse_link_initialize_out,
+				fuse_link_backing, fuse_link_finalize, entry,
+				newdir, newent))
+		return err;
+#endif
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	args.opcode = FUSE_LINK;
@@ -1609,6 +1627,19 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (fuse_is_bad(inode))
 		goto out_err;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		const char *out = NULL;
+
+		if (fuse_bpf_backing(inode, struct fuse_dummy_io, out,
+				       fuse_get_link_initialize_in, fuse_get_link_initialize_out,
+				       fuse_get_link_backing,
+				       fuse_get_link_finalize,
+				       inode, dentry, callback))
+			return out;
+	}
+#endif
+
 	if (fc->cache_symlinks)
 		return page_get_link(dentry, inode, callback);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b313a45c7774..cbfd56d669c7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1504,6 +1504,17 @@ int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out,
 int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
 			 struct inode *dir, struct dentry *entry);
 
+int fuse_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_link_in *fli,
+			    struct dentry *entry, struct inode *dir,
+			    struct dentry *newent);
+int fuse_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_link_in *fli,
+			     struct dentry *entry, struct inode *dir,
+			     struct dentry *newent);
+int fuse_link_backing(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+		      struct inode *dir, struct dentry *newent);
+int fuse_link_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
+		       struct inode *dir, struct dentry *newent);
+
 int fuse_release_initialize_in(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
 			       struct inode *inode, struct file *file);
 int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
@@ -1742,6 +1753,28 @@ int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
 int fuse_statfs_finalize(struct bpf_fuse_args *fa, int *out,
 			 struct dentry *dentry, struct kstatfs *buf);
 
+int fuse_get_link_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+				struct inode *inode, struct dentry *dentry,
+				struct delayed_call *callback);
+int fuse_get_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+				 struct inode *inode, struct dentry *dentry,
+				 struct delayed_call *callback);
+int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
+			  struct inode *inode, struct dentry *dentry,
+			  struct delayed_call *callback);
+int fuse_get_link_finalize(struct bpf_fuse_args *fa, const char **out,
+			   struct inode *inode, struct dentry *dentry,
+			   struct delayed_call *callback);
+
+int fuse_symlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+			       struct inode *dir, struct dentry *entry, const char *link, int len);
+int fuse_symlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *unused,
+				struct inode *dir, struct dentry *entry, const char *link, int len);
+int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *dir, struct dentry *entry, const char *link, int len);
+int fuse_symlink_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *dir, struct dentry *entry, const char *link, int len);
+
 struct fuse_read_io {
 	struct fuse_read_in fri;
 	struct fuse_read_out fro;
-- 
2.37.3.998.g577e59143f-goog

