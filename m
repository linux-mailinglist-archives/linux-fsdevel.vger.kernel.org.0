Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A563332E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiKVCUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKVCTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:19:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ABCE9144
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-39562b26a76so96324547b3.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xynMcMsTuZqMLXL5ELmNHCW5CNZGRvCuOQzJlNlxPiE=;
        b=OUOhjEq4CnL9PVEr0QtLZtsjmGIU43rGzRaSI9yqkOCe/Tq6OgBYhpEJftwd6UWyQ/
         5eeE3FmCGczyreI5r/W4v9N5jqJoGlmQM2q02oW82bjyNtSfMiVAKuuRlyzzRCpqIjcK
         JqE5A8cs7Nov5Mp1Pr5ppPvmjSjUDvqdNwrEJcxCVXa1nPeGGAqVPzHzrRRvLfekRmG7
         QN92GztkE/9jyU1ktQ0mdS+rYMrfjbUKE1XfIg7zDourWrv+MzvWMpNiFOUi1VzoyY63
         oGRcclGwP2xBOMc//CIF4OX7JWonfe7495+rdT4v40NBqMMb/aLuZjA/x9Bb7/9mHKQn
         NAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xynMcMsTuZqMLXL5ELmNHCW5CNZGRvCuOQzJlNlxPiE=;
        b=KJ5zIOYgZxOxVOWjNmISKg3fW6hjNM8jeVF7i7T3dtikTNbjUo8T+/cej8XF0C4Ajy
         Mie30vOrSZpyqRZAqWLYvEFXT6hNHf8h8KsASKmhKOoqOyDhxhYquDqsUlyqcETJVBuO
         uE3Lpe1BcyOZzuT4lKuIeyrcg/Xq+on/aQBdplH8dYyTrKht3gPiaQoLkS98/HxFUoqW
         zuZEC2LL+5fYdJm6czH838YKInidY8R6jRr2VtjPp5Ini/V8N2AAD+WpFnZNNG4+WDt+
         lpLSP87lft1oANcFPby8X+WJzx/j81bNPfqowrIvzgYc5aOC7aFxC/Zgetsl3LfjK61O
         xCNA==
X-Gm-Message-State: ANoB5pmk1aYO+JybsOivypFepgdm6JwzNHXg8XvUSy+PYV9XCbDlOD97
        zmNDTKDZCopEdY9jLDt0HSHvio+OGg0=
X-Google-Smtp-Source: AA0mqf4LGEir7+sUn3JQztooPiTqpoL0ZtXzAn9x3BZieAdky+AC347ieh3djGRKoZYQgLnIiAdZ6bEKgno=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a25:ae12:0:b0:6d0:704:f19f with SMTP id
 a18-20020a25ae12000000b006d00704f19fmr4415884ybj.191.1669083400889; Mon, 21
 Nov 2022 18:16:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:35 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-21-drosen@google.com>
Subject: [RFC PATCH v2 20/21] fuse-bpf: Add symlink/link support
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
 fs/fuse/backing.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  11 ++
 fs/fuse/fuse_i.h  |  20 ++++
 3 files changed, 302 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 05fb88865289..a77414e8f3df 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2319,6 +2319,104 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+static int fuse_link_initialize_in(struct fuse_args *fa, struct fuse_link_in *fli,
+				   struct dentry *entry, struct inode *dir,
+				   struct dentry *newent)
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
+	fa->in_args[1].value = (void *) newent->d_name.name;
+
+	return 0;
+}
+
+static int fuse_link_initialize_out(struct fuse_args *fa, struct fuse_link_in *fli,
+				    struct dentry *entry, struct inode *dir,
+				    struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_link_backing(struct fuse_args *fa, int *out, struct dentry *entry,
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
+static int fuse_link_finalize(struct fuse_args *fa, int *out, struct dentry *entry,
+			      struct inode *dir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry,
+		  struct inode *newdir, struct dentry *newent)
+{
+	return fuse_bpf_backing(inode, struct fuse_link_in, out,
+				fuse_link_initialize_in, fuse_link_initialize_out,
+				fuse_link_backing, fuse_link_finalize, entry,
+				newdir, newent);
+}
+
 struct fuse_getattr_io {
 	struct fuse_getattr_in fgi;
 	struct fuse_attr_out fao;
@@ -2600,6 +2698,179 @@ int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct
 				dentry, buf);
 }
 
+static int fuse_get_link_initialize_in(struct fuse_args *fa, struct fuse_unused_io *unused,
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
+	*fa = (struct fuse_args) {
+		.opcode = FUSE_READLINK,
+		.nodeid = get_node_id(inode),
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = dentry->d_name.len + 1,
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
+static int fuse_get_link_initialize_out(struct fuse_args *fa, struct fuse_unused_io *unused,
+					struct inode *inode, struct dentry *dentry,
+					struct delayed_call *callback)
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
+static int fuse_get_link_backing(struct fuse_args *fa, const char **out,
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
+static int fuse_get_link_finalize(struct fuse_args *fa, const char **out,
+				  struct inode *inode, struct dentry *dentry,
+				  struct delayed_call *callback)
+{
+	return 0;
+}
+
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback)
+{
+	return fuse_bpf_backing(inode, struct fuse_unused_io, out,
+				fuse_get_link_initialize_in, fuse_get_link_initialize_out,
+				fuse_get_link_backing,
+				fuse_get_link_finalize,
+				inode, dentry, callback);
+}
+
+static int fuse_symlink_initialize_in(struct fuse_args *fa, struct fuse_unused_io *unused,
+				      struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	*fa = (struct fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_SYMLINK,
+		.in_numargs = 2,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = entry->d_name.len + 1,
+			.value =  (void *) entry->d_name.name,
+		},
+		.in_args[1] = (struct fuse_in_arg) {
+			.size = len,
+			.value = (void *) link,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_symlink_initialize_out(struct fuse_args *fa, struct fuse_unused_io *unused,
+				       struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+static int fuse_symlink_backing(struct fuse_args *fa, int *out,
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
+static int  fuse_symlink_finalize(struct fuse_args *fa, int *out,
+				  struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return 0;
+}
+
+int  fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len)
+{
+	return fuse_bpf_backing(dir, struct fuse_unused_io, out,
+				fuse_symlink_initialize_in, fuse_symlink_initialize_out,
+				fuse_symlink_backing, fuse_symlink_finalize,
+				dir, entry, link, len);
+}
+
 struct fuse_read_io {
 	struct fuse_read_in fri;
 	struct fuse_read_out fro;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 899de6c84c2e..1f9105edc7e2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -945,6 +945,10 @@ static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_symlink(&err, dir, entry, link, len))
+		return err;
 
 	args.opcode = FUSE_SYMLINK;
 	args.in_numargs = 2;
@@ -1151,6 +1155,9 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 
+	if (fuse_bpf_link(&err, inode, entry, newdir, newent))
+		return err;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	args.opcode = FUSE_LINK;
@@ -1543,12 +1550,16 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
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
index 37b29a3ea330..99c9231ec98b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1412,6 +1412,7 @@ int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
 int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
 		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry, struct inode *dir, struct dentry *newent);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
@@ -1436,6 +1437,9 @@ int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry,
 		     u32 request_mask, unsigned int flags);
 int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struct iattr *attr, struct file *file);
 int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct kstatfs *buf);
+int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dentry,
+		      struct delayed_call *callback);
+int fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const char *link, int len);
 int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1485,6 +1489,11 @@ static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *en
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
@@ -1581,6 +1590,17 @@ static inline int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *
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
2.38.1.584.g0f3c55d4c2-goog

