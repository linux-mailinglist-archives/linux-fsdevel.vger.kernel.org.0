Return-Path: <linux-fsdevel+bounces-9649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CD8440B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361121F2C16A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514280BF8;
	Wed, 31 Jan 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV0HHOgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233080BE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708222; cv=none; b=oF9MdF0/+5PERAuab4/gnsIES+ts0rrcDqQLgQWhdZ2V2zfn6avEN2sCWsP/XfRCrZ4wzJyrT1PeF2vizY/zvBXgPHX0AAwzKEHT7XVLg6RIZl9hA8bB1slBTJ1gLjhpx1UW8tedssv74Yoo835BSOLSf+v/MN/0uw2sHrd9Xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708222; c=relaxed/simple;
	bh=ZUrbo5js4L16Fo0vIaPMD1KJIGQEeF4g1bIUbS162nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H43q/0WwcyIizJ35uB2G/w6MDU9KyEkrBSPntOHVXJKN25Gqh8331TP/MDHz8sZ+dlErbDv7o31cTr2DP4WgTlmqUB+lh6wB10hs2sKgBw5FaRqNF7Nq3/uH6Csy75SOwlxwRugC7vhV5tlieyufNhTWNXIDp9d/zTTcW/cXRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV0HHOgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD2C43394;
	Wed, 31 Jan 2024 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708221;
	bh=ZUrbo5js4L16Fo0vIaPMD1KJIGQEeF4g1bIUbS162nI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aV0HHOgzdYI5Rht/oqs9s4080UyE3PNTZgYbW8XjPZve3lAhTmn1dcCcsmuRf5wNT
	 G/wjMoX85n9786I7p8L/iiFk31hLYt0nrydzcmbL/W5cvQRUTOJTG8edw/3n3mBDLQ
	 X7itLZLdEkO3VcYuet/6d89csga9uJVlFakegSizlzyTA/YpaRTNYTSTDY7oDOHMZc
	 mKMjZVDZdHGTmGFreTiVQitpuedrUodkjoFoCdNT4TmAo/Ao6PDbDtJIFXIxufkCua
	 TKj+9rXhISA8p06Xf52Zs/4dzvyJ89ZChc35Hilo11GLyyEAObNiECKsUxUy52UNMY
	 kAUTVD+YLeqiw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jan 2024 14:36:38 +0100
Subject: [PATCH DRAFT 1/4] : tracefs: port to kernfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-tracefs-kernfs-v1-1-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=27328; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZUrbo5js4L16Fo0vIaPMD1KJIGQEeF4g1bIUbS162nI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8vkhwlp4MmPbElexcKkPHzcIScRserQ1OvrXJ5dnQ
 g/Kk97YdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkugHD/1z7xul8M/b/830w
 /UKpY3qwRldNpfK2aHWpbB3exDL2LkaGGUvcjJ6ZrLeMjBCb+e3dt68xaUXKfWoJD4+mPdZ4sia
 BHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/mount.c       |  10 +
 fs/tracefs/inode.c      | 649 ++++++++++++++++--------------------------------
 include/linux/kernfs.h  |   3 +
 include/linux/tracefs.h |  18 +-
 kernel/trace/trace.c    |   6 +-
 5 files changed, 244 insertions(+), 442 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0c93cad0f0ac..68907c9f9377 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -243,6 +243,16 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	} while (true);
 }
 
+kuid_t kernfs_node_owner(struct kernfs_node *kn)
+{
+	return kn->iattrs->ia_uid;
+}
+
+kuid_t kernfs_node_group(struct kernfs_node *kn)
+{
+	return kn->iattrs->ia_gid;
+}
+
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..944a95ff8b48 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_parser.h>
 #include <linux/mount.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
@@ -24,47 +25,41 @@
 #include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
-static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
+static struct kernfs_root *trace_fs_root;
+static struct kernfs_node *trace_kfs_root_node;
 
 static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
-static struct inode *tracefs_alloc_inode(struct super_block *sb)
+static ssize_t trace_fs_kf_read(struct kernfs_open_file *of, char *buf,
+				size_t count, loff_t pos)
 {
-	struct tracefs_inode *ti;
-
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
-	if (!ti)
-		return NULL;
-
-	ti->flags = 0;
-
-	return &ti->vfs_inode;
+	return 0;
 }
 
-static void tracefs_free_inode(struct inode *inode)
+static ssize_t trace_fs_kf_write(struct kernfs_open_file *of, char *buf,
+				 size_t count, loff_t pos)
 {
-	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+	return 0;
 }
 
-static ssize_t default_read_file(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static loff_t trace_fs_kf_llseek(struct kernfs_open_file *of, loff_t offset,
+				 int whence)
 {
-	return 0;
+	return noop_llseek(of->file, offset, whence);
 }
 
-static ssize_t default_write_file(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static int trace_fs_kf_open(struct kernfs_open_file *of)
 {
-	return count;
+	return 0;
 }
 
-static const struct file_operations tracefs_file_operations = {
-	.read =		default_read_file,
-	.write =	default_write_file,
-	.open =		simple_open,
-	.llseek =	noop_llseek,
+static const struct kernfs_ops tracefs_file_kfops = {
+	.read		= trace_fs_kf_read,
+	.write		= trace_fs_kf_write,
+	.open		= trace_fs_kf_open,
+	.llseek		= trace_fs_kf_llseek,
 };
 
 static struct tracefs_dir_ops {
@@ -72,157 +67,6 @@ static struct tracefs_dir_ops {
 	int (*rmdir)(const char *name);
 } tracefs_ops __ro_after_init;
 
-static char *get_dname(struct dentry *dentry)
-{
-	const char *dname;
-	char *name;
-	int len = dentry->d_name.len;
-
-	dname = dentry->d_name.name;
-	name = kmalloc(len + 1, GFP_KERNEL);
-	if (!name)
-		return NULL;
-	memcpy(name, dname, len);
-	name[len] = 0;
-	return name;
-}
-
-static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
-				 struct inode *inode, struct dentry *dentry,
-				 umode_t mode)
-{
-	struct tracefs_inode *ti;
-	char *name;
-	int ret;
-
-	name = get_dname(dentry);
-	if (!name)
-		return -ENOMEM;
-
-	/*
-	 * This is a new directory that does not take the default of
-	 * the rootfs. It becomes the default permissions for all the
-	 * files and directories underneath it.
-	 */
-	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_INSTANCE_INODE;
-	ti->private = inode;
-
-	/*
-	 * The mkdir call can call the generic functions that create
-	 * the files within the tracefs system. It is up to the individual
-	 * mkdir routine to handle races.
-	 */
-	inode_unlock(inode);
-	ret = tracefs_ops.mkdir(name);
-	inode_lock(inode);
-
-	kfree(name);
-
-	return ret;
-}
-
-static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
-{
-	char *name;
-	int ret;
-
-	name = get_dname(dentry);
-	if (!name)
-		return -ENOMEM;
-
-	/*
-	 * The rmdir call can call the generic functions that create
-	 * the files within the tracefs system. It is up to the individual
-	 * rmdir routine to handle races.
-	 * This time we need to unlock not only the parent (inode) but
-	 * also the directory that is being deleted.
-	 */
-	inode_unlock(inode);
-	inode_unlock(d_inode(dentry));
-
-	ret = tracefs_ops.rmdir(name);
-
-	inode_lock_nested(inode, I_MUTEX_PARENT);
-	inode_lock(d_inode(dentry));
-
-	kfree(name);
-
-	return ret;
-}
-
-static void set_tracefs_inode_owner(struct inode *inode)
-{
-	struct tracefs_inode *ti = get_tracefs(inode);
-	struct inode *root_inode = ti->private;
-
-	/*
-	 * If this inode has never been referenced, then update
-	 * the permissions to the superblock.
-	 */
-	if (!(ti->flags & TRACEFS_UID_PERM_SET))
-		inode->i_uid = root_inode->i_uid;
-
-	if (!(ti->flags & TRACEFS_GID_PERM_SET))
-		inode->i_gid = root_inode->i_gid;
-}
-
-static int tracefs_permission(struct mnt_idmap *idmap,
-			      struct inode *inode, int mask)
-{
-	set_tracefs_inode_owner(inode);
-	return generic_permission(idmap, inode, mask);
-}
-
-static int tracefs_getattr(struct mnt_idmap *idmap,
-			   const struct path *path, struct kstat *stat,
-			   u32 request_mask, unsigned int flags)
-{
-	struct inode *inode = d_backing_inode(path->dentry);
-
-	set_tracefs_inode_owner(inode);
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
-}
-
-static int tracefs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			   struct iattr *attr)
-{
-	unsigned int ia_valid = attr->ia_valid;
-	struct inode *inode = d_inode(dentry);
-	struct tracefs_inode *ti = get_tracefs(inode);
-
-	if (ia_valid & ATTR_UID)
-		ti->flags |= TRACEFS_UID_PERM_SET;
-
-	if (ia_valid & ATTR_GID)
-		ti->flags |= TRACEFS_GID_PERM_SET;
-
-	return simple_setattr(idmap, dentry, attr);
-}
-
-static const struct inode_operations tracefs_instance_dir_inode_operations = {
-	.lookup		= simple_lookup,
-	.mkdir		= tracefs_syscall_mkdir,
-	.rmdir		= tracefs_syscall_rmdir,
-	.permission	= tracefs_permission,
-	.getattr	= tracefs_getattr,
-	.setattr	= tracefs_setattr,
-};
-
-static const struct inode_operations tracefs_dir_inode_operations = {
-	.lookup		= simple_lookup,
-	.permission	= tracefs_permission,
-	.getattr	= tracefs_getattr,
-	.setattr	= tracefs_setattr,
-};
-
-static const struct inode_operations tracefs_file_inode_operations = {
-	.permission	= tracefs_permission,
-	.getattr	= tracefs_getattr,
-	.setattr	= tracefs_setattr,
-};
-
 struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -241,80 +85,101 @@ struct tracefs_mount_opts {
 	unsigned int opts;
 };
 
-enum {
+struct tracefs_mount_opts global_opts = {
+	.mode	= TRACEFS_DEFAULT_MODE,
+	.uid	= GLOBAL_ROOT_UID,
+	.gid	= GLOBAL_ROOT_GID,
+	.opts	= 0,
+};
+
+enum trace_fs_param {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
-	Opt_err
 };
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec trace_fs_parameters[] = {
+	fsparam_u32   ("gid",		Opt_gid),
+	fsparam_u32oct("mode",		Opt_mode),
+	fsparam_u32   ("uid",		Opt_uid),
+	{}
 };
 
-struct tracefs_fs_info {
+struct trace_fs_context {
+	struct kernfs_fs_context kfc;
 	struct tracefs_mount_opts mount_opts;
 };
 
-static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
+static inline struct trace_fs_context *trace_fc2context(struct fs_context *fc)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	int token;
-	kuid_t uid;
-	kgid_t gid;
-	char *p;
-
-	opts->opts = 0;
-	opts->mode = TRACEFS_DEFAULT_MODE;
-
-	while ((p = strsep(&data, ",")) != NULL) {
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return -EINVAL;
-			opts->uid = uid;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return -EINVAL;
-			opts->gid = gid;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->mode = option & S_IALLUGO;
-			break;
+	struct kernfs_fs_context *kfc = fc->fs_private;
+
+	return container_of(kfc, struct trace_fs_context, kfc);
+}
+
+static int trace_fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct trace_fs_context *ctx = trace_fc2context(fc);
+	struct tracefs_mount_opts *mount_opts = &ctx->mount_opts;
+	struct fs_parse_result result;
+	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
+
+	opt = fs_parse(fc, trace_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_mode:
+		mount_opts->mode = result.uint_32 & 07777;
+		mount_opts->opts |= BIT(Opt_mode);
+		break;
+	case Opt_uid:
+		kuid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(kuid))
+			goto bad_value;
+
 		/*
-		 * We might like to report bad mount options here;
-		 * but traditionally tracefs has ignored all mount options
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
 		 */
-		}
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			goto bad_value;
+
+		mount_opts->uid = kuid;
+		mount_opts->opts |= BIT(Opt_uid);
+		break;
+	case Opt_gid:
+		kgid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(kgid))
+			goto bad_value;
 
-		opts->opts |= BIT(token);
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
+			goto bad_value;
+
+		mount_opts->gid = kgid;
+		mount_opts->opts |= BIT(Opt_gid);
+		break;
+	default:
+		return invalfc(fc, "Unsupported parameter '%s'", param->key);
 	}
 
-	return 0;
+bad_value:
+	return invalfc(fc, "Bad value for '%s'", param->key);
 }
 
 static int tracefs_apply_options(struct super_block *sb, bool remount)
 {
-	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
-	struct tracefs_mount_opts *opts = &fsi->mount_opts;
+	kuid_t kuid = global_opts.uid;
+	kgid_t kgid = global_opts.gid;
+	umode_t mode = global_opts.mode;
+	unsigned int opts = global_opts.opts;
 	umode_t tmp_mode;
 
 	/*
@@ -322,126 +187,126 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	 * options.
 	 */
 
-	if (!remount || opts->opts & BIT(Opt_mode)) {
+	if (!remount || opts & BIT(Opt_mode)) {
 		tmp_mode = READ_ONCE(inode->i_mode) & ~S_IALLUGO;
-		tmp_mode |= opts->mode;
+		tmp_mode |= mode;
 		WRITE_ONCE(inode->i_mode, tmp_mode);
 	}
 
-	if (!remount || opts->opts & BIT(Opt_uid))
-		inode->i_uid = opts->uid;
+	if (!remount || opts & BIT(Opt_uid))
+		inode->i_uid = kuid;
 
-	if (!remount || opts->opts & BIT(Opt_gid))
-		inode->i_gid = opts->gid;
+	if (!remount || opts & BIT(Opt_gid))
+		inode->i_gid = kgid;
 
 	return 0;
 }
 
-static int tracefs_remount(struct super_block *sb, int *flags, char *data)
+static int trace_fs_reconfigure(struct fs_context *fc)
 {
-	int err;
-	struct tracefs_fs_info *fsi = sb->s_fs_info;
+	tracefs_apply_options(fc->root->d_sb, true);
+	return 0;
+}
 
-	sync_filesystem(sb);
-	err = tracefs_parse_options(data, &fsi->mount_opts);
-	if (err)
-		goto fail;
+static int trace_fs_show_options(struct seq_file *seq, struct kernfs_root *kf_root)
+{
+	kuid_t kuid = global_opts.uid;
+	kgid_t kgid = global_opts.gid;
+	umode_t mode = global_opts.mode;
 
-	tracefs_apply_options(sb, true);
+	if (!uid_eq(kuid, GLOBAL_ROOT_UID))
+		seq_printf(seq, ",uid=%u", from_kuid_munged(&init_user_ns, kuid));
+	if (!gid_eq(kgid, GLOBAL_ROOT_GID))
+		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, kgid));
+	if (mode != TRACEFS_DEFAULT_MODE)
+		seq_printf(seq, ",mode=%o", mode);
 
-fail:
-	return err;
+	return 0;
 }
 
-static int tracefs_show_options(struct seq_file *m, struct dentry *root)
+static int trace_fs_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
-	struct tracefs_fs_info *fsi = root->d_sb->s_fs_info;
-	struct tracefs_mount_opts *opts = &fsi->mount_opts;
-
-	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
-		seq_printf(m, ",uid=%u",
-			   from_kuid_munged(&init_user_ns, opts->uid));
-	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
-		seq_printf(m, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, opts->gid));
-	if (opts->mode != TRACEFS_DEFAULT_MODE)
-		seq_printf(m, ",mode=%o", opts->mode);
+	int ret;
+	struct kernfs_node *kn;
 
-	return 0;
-}
+	if (parent_kn != trace_instance_dir)
+		return -EPERM;
 
-static const struct super_operations tracefs_super_operations = {
-	.alloc_inode    = tracefs_alloc_inode,
-	.free_inode     = tracefs_free_inode,
-	.drop_inode     = generic_delete_inode,
-	.statfs		= simple_statfs,
-	.remount_fs	= tracefs_remount,
-	.show_options	= tracefs_show_options,
-};
+	kn = tracefs_create_dir(name, parent_kn);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	ret = tracefs_ops.mkdir(name);
+	if (ret)
+		kernfs_remove(kn);
+	return ret;
+}
 
-static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+static int trace_fs_rmdir(struct kernfs_node *kn)
 {
-	struct tracefs_inode *ti;
+	int ret;
 
-	if (!dentry || !inode)
-		return;
+	if (kn != trace_instance_dir)
+		return -EPERM;
+
+ 	ret = tracefs_ops.rmdir(kn->name);
+	if (!ret)
+		kernfs_remove(kn);
 
-	ti = get_tracefs(inode);
-	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ei_status_free(ti, dentry);
-	iput(inode);
+	return ret;
 }
 
-static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+static struct kernfs_syscall_ops trace_fs_kf_syscall_ops = {
+	.show_options		= trace_fs_show_options,
+	.mkdir			= trace_fs_mkdir,
+	.rmdir			= trace_fs_rmdir,
 };
 
-static int trace_fill_super(struct super_block *sb, void *data, int silent)
+static int trace_fs_get_tree(struct fs_context *fc)
 {
-	static const struct tree_descr trace_files[] = {{""}};
-	struct tracefs_fs_info *fsi;
-	int err;
-
-	fsi = kzalloc(sizeof(struct tracefs_fs_info), GFP_KERNEL);
-	sb->s_fs_info = fsi;
-	if (!fsi) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	err = tracefs_parse_options(data, &fsi->mount_opts);
-	if (err)
-		goto fail;
+	int ret;
 
-	err  =  simple_fill_super(sb, TRACEFS_MAGIC, trace_files);
-	if (err)
-		goto fail;
+	ret = kernfs_get_tree(fc);
+	if (!ret)
+		tracefs_apply_options(fc->root->d_sb, false);
+	return ret;
+}
 
-	sb->s_op = &tracefs_super_operations;
-	sb->s_d_op = &tracefs_dentry_operations;
+static void trace_fs_context_free(struct fs_context *fc)
+{
+	struct trace_fs_context *ctx = trace_fc2context(fc);
+	kernfs_free_fs_context(fc);
+	kfree(ctx);
+}
 
-	tracefs_apply_options(sb, false);
+static const struct fs_context_operations trace_fs_context_ops = {
+	.free		= trace_fs_context_free,
+	.parse_param	= trace_fs_parse_param,
+	.get_tree	= trace_fs_get_tree,
+	.reconfigure	= trace_fs_reconfigure,
+};
 
-	return 0;
+static int trace_fs_init_fs_context(struct fs_context *fc)
+{
+	struct trace_fs_context *ctx;
 
-fail:
-	kfree(fsi);
-	sb->s_fs_info = NULL;
-	return err;
-}
+	ctx = kzalloc(sizeof(struct trace_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
 
-static struct dentry *trace_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name,
-			void *data)
-{
-	return mount_single(fs_type, flags, data, trace_fill_super);
+	ctx->kfc.magic = TRACEFS_MAGIC;
+	ctx->mount_opts.mode = TRACEFS_DEFAULT_MODE;
+	fc->fs_private = &ctx->kfc;
+	fc->global = true;
+	fc->ops = &trace_fs_context_ops;
+	return 0;
 }
 
 static struct file_system_type trace_fs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"tracefs",
-	.mount =	trace_mount,
-	.kill_sb =	kill_litter_super,
+	.name			= "tracefs",
+	.init_fs_context	= trace_fs_init_fs_context,
+	.parameters		= trace_fs_parameters,
+	.kill_sb		= kill_litter_super,
 };
 MODULE_ALIAS_FS("tracefs");
 
@@ -566,26 +431,6 @@ struct dentry *eventfs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
-/* Find the inode that this will use for default */
-static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
-{
-	struct tracefs_inode *ti;
-
-	/* If parent is NULL then use root inode */
-	if (!parent)
-		return d_inode(inode->i_sb->s_root);
-
-	/* Find the inode that is flagged as an instance or the root inode */
-	while (!IS_ROOT(parent)) {
-		ti = get_tracefs(d_inode(parent));
-		if (ti->flags & TRACEFS_INSTANCE_INODE)
-			break;
-		parent = parent->d_parent;
-	}
-
-	return d_inode(parent);
-}
-
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
@@ -612,73 +457,24 @@ static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *tracefs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
-				   const struct file_operations *fops)
+struct kernfs_node *tracefs_create_file(const char *name, umode_t mode,
+					struct kernfs_node *parent, void *data,
+					const struct kernfs_ops *ops)
 {
-	struct tracefs_inode *ti;
-	struct dentry *dentry;
-	struct inode *inode;
-
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = tracefs_start_creating(name, parent);
 
-	if (IS_ERR(dentry))
-		return NULL;
+	// inode->i_op = &tracefs_file_inode_operations;
 
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return tracefs_failed_creating(dentry);
-
-	ti = get_tracefs(inode);
-	ti->private = instance_inode(parent, inode);
-
-	inode->i_mode = mode;
-	inode->i_op = &tracefs_file_inode_operations;
-	inode->i_fop = fops ? fops : &tracefs_file_operations;
-	inode->i_private = data;
-	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
-	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
-	d_instantiate(dentry, inode);
-	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return tracefs_end_creating(dentry);
-}
-
-static struct dentry *__create_dir(const char *name, struct dentry *parent,
-				   const struct inode_operations *ops)
-{
-	struct tracefs_inode *ti;
-	struct dentry *dentry = tracefs_start_creating(name, parent);
-	struct inode *inode;
-
-	if (IS_ERR(dentry))
-		return NULL;
-
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return tracefs_failed_creating(dentry);
-
-	/* Do not set bits for OTH */
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
-	inode->i_op = ops;
-	inode->i_fop = &simple_dir_operations;
-	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
-	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
-
-	ti = get_tracefs(inode);
-	ti->private = instance_inode(parent, inode);
-
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return tracefs_end_creating(dentry);
+	return __kernfs_create_file(parent ?: trace_kfs_root_node, name, mode,
+				    kernfs_node_owner(parent),
+				    kernfs_node_group(parent), PAGE_SIZE,
+				    ops ? : &tracefs_file_kfops, data, NULL,
+				    NULL);
 }
 
 /**
@@ -698,12 +494,17 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  * If tracing is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
+struct kernfs_node *tracefs_create_dir(const char *name,
+				       struct kernfs_node *parent)
 {
 	if (security_locked_down(LOCKDOWN_TRACEFS))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
-	return __create_dir(name, parent, &tracefs_dir_inode_operations);
+	return kernfs_create_dir_ns(parent ?: trace_kfs_root_node, name,
+				  S_IFDIR | S_IRWXU | S_IRUSR | S_IRGRP |
+				  S_IXUSR | S_IXGRP,
+				  kernfs_node_owner(parent),
+				  kernfs_node_group(parent), NULL, NULL);
 }
 
 /**
@@ -723,30 +524,23 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Returns the dentry of the instances directory.
  */
-__init struct dentry *tracefs_create_instance_dir(const char *name,
-					  struct dentry *parent,
-					  int (*mkdir)(const char *name),
-					  int (*rmdir)(const char *name))
+__init struct kernfs_node *
+tracefs_create_instance_dir(int (*mkdir)(const char *name),
+			    int (*rmdir)(const char *name))
 {
-	struct dentry *dentry;
+	struct kernfs_node *kn;
 
 	/* Only allow one instance of the instances directory. */
 	if (WARN_ON(tracefs_ops.mkdir || tracefs_ops.rmdir))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
-	dentry = __create_dir(name, parent, &tracefs_instance_dir_inode_operations);
-	if (!dentry)
-		return NULL;
+	kn = tracefs_create_dir("instances", trace_kfs_root_node);
+	if (IS_ERR(kn))
+		return kn;
 
 	tracefs_ops.mkdir = mkdir;
 	tracefs_ops.rmdir = rmdir;
-
-	return dentry;
-}
-
-static void remove_one(struct dentry *victim)
-{
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return kn;
 }
 
 /**
@@ -757,14 +551,12 @@ static void remove_one(struct dentry *victim)
  * was previously created with a call to another tracefs function
  * (like tracefs_create_file() or variants thereof.)
  */
-void tracefs_remove(struct dentry *dentry)
+void tracefs_remove(struct kernfs_node *kn)
 {
-	if (IS_ERR_OR_NULL(dentry))
+	if (IS_ERR_OR_NULL(kn))
 		return;
 
-	simple_pin_fs(&trace_fs_type, &tracefs_mount, &tracefs_mount_count);
-	simple_recursive_removal(dentry, remove_one);
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	kernfs_remove(kn);
 }
 
 /**
@@ -775,33 +567,30 @@ bool tracefs_initialized(void)
 	return tracefs_registered;
 }
 
-static void init_once(void *foo)
-{
-	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
-
-	inode_init_once(&ti->vfs_inode);
-}
-
 static int __init tracefs_init(void)
 {
 	int retval;
+	struct kernfs_root *kfs_root;
 
-	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
-						 sizeof(struct tracefs_inode),
-						 0, (SLAB_RECLAIM_ACCOUNT|
-						     SLAB_MEM_SPREAD|
-						     SLAB_ACCOUNT),
-						 init_once);
-	if (!tracefs_inode_cachep)
-		return -ENOMEM;
+	kfs_root = kernfs_create_root(&trace_fs_kf_syscall_ops,
+				      KERNFS_ROOT_CREATE_DEACTIVATED, NULL);
+	if (IS_ERR(kfs_root))
+                return PTR_ERR(kfs_root);
 
 	retval = sysfs_create_mount_point(kernel_kobj, "tracing");
-	if (retval)
+	if (retval) {
+		kernfs_destroy_root(kfs_root);
 		return -EINVAL;
+	}
 
 	retval = register_filesystem(&trace_fs_type);
 	if (!retval)
 		tracefs_registered = true;
+	else
+		kernfs_destroy_root(kfs_root);
+
+	trace_fs_root = kfs_root;
+	trace_kfs_root_node = kernfs_root_to_node(kfs_root);
 
 	return retval;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 99aaa050ccb7..50b84a82595f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -244,6 +244,9 @@ struct kernfs_syscall_ops {
 			 struct kernfs_root *root);
 };
 
+kuid_t kernfs_node_owner(struct kernfs_node *kn);
+kgid_t kernfs_node_group(struct kernfs_node *kn);
+
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root);
 
 struct kernfs_open_file {
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..83f6658e1875 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -14,6 +14,7 @@
 
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/kernfs.h>
 
 #include <linux/types.h>
 
@@ -22,6 +23,7 @@ struct file_operations;
 #ifdef CONFIG_TRACING
 
 struct eventfs_file;
+extern struct kernfs_node *trace_instance_dir;
 
 /**
  * eventfs_callback - A callback function to create dynamic files in eventfs
@@ -87,17 +89,17 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
-struct dentry *tracefs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
-				   const struct file_operations *fops);
+struct kernfs_node *tracefs_create_file(const char *name, umode_t mode,
+					struct kernfs_node *parent, void *data,
+					const struct kernfs_ops *ops);
 
-struct dentry *tracefs_create_dir(const char *name, struct dentry *parent);
+struct kernfs_node *tracefs_create_dir(const char *name,
+				       struct kernfs_node *parent);
 
-void tracefs_remove(struct dentry *dentry);
+void tracefs_remove(struct kernfs_node *kn);
 
-struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
-					   int (*mkdir)(const char *name),
-					   int (*rmdir)(const char *name));
+struct kernfs_node *tracefs_create_instance_dir(int (*mkdir)(const char *name),
+						int (*rmdir)(const char *name));
 
 bool tracefs_initialized(void);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..3afc2dd51233 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9494,7 +9494,7 @@ static const struct file_operations buffer_subbuf_size_fops = {
 	.llseek		= default_llseek,
 };
 
-static struct dentry *trace_instance_dir;
+struct kernfs_node *trace_instance_dir;
 
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
@@ -9885,9 +9885,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 {
 	struct trace_array *tr;
 
-	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
-							 instance_mkdir,
-							 instance_rmdir);
+	trace_instance_dir = tracefs_create_instance_dir(instance_mkdir, instance_rmdir);
 	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
 		return;
 

-- 
2.43.0


