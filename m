Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CF729EE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbjFIPmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbjFIPmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA83588;
        Fri,  9 Jun 2023 08:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD54E61C0D;
        Fri,  9 Jun 2023 15:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C7C433A7;
        Fri,  9 Jun 2023 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325328;
        bh=oioAdjshDQzx3M06TF/aBrgP1J0q/0/FgjQNcbAxPug=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UDPgTM4NMvxIjGO/rJ1c+pjtm4sdBnQ576/G/vZVNE8s4ZI1FS6EU6LYQw2RC3cDM
         mHTktSSgOUs6oOvdbyZpqKUU6OHXwJ4tuXAXX83p1/wZDNhUJ4OTXp+VGmgBmtSqGh
         8koStGdbqqZUby+DL+HYWTUr1f3eNLRFGZxczEZfB8Y6I4MEZxTPb9QsfO/KB0+Nva
         lwLmcaU5G3w9b8I/yPYguR31ai4NWyipBHODHoWBHv7cw4AQlrOjbCQ5rZTHK9RO3z
         NQMS+kpjbED3Nyo+C5fAn65qsl7wp2Mx1fL3FZqVzieZjc4FnxtkLHpNi1uLmUigpV
         8ww4T2ZO5yQiw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 09 Jun 2023 17:41:48 +0200
Subject: [PATCH v2 1/2] ovl: port to new mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=16087; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oioAdjshDQzx3M06TF/aBrgP1J0q/0/FgjQNcbAxPug=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ0e/hw+b+d2HLQwKVfZTmHZMZF3vXPucRinGrPeLSvf/XE
 emt2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQcbjAyLLFqznmh8kBz90n1+5N3iL
 bs0Jn9bl7KdvEL2lOn/7fl287wz+LKcuf2jyfEPs3ZJnNwxtSvO5u75obdi0z+q9uc5Bz0kwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We recently ported util-linux to the new mount api. Now the mount(8)
tool will by default use the new mount api. While trying hard to fall
back to the old mount api gracefully there are still cases where we run
into issues that are difficult to handle nicely.

Now with mount(8) and libmount supporting the new mount api I expect an
increase in the number of bug reports and issues we're going to see with
filesystems that don't yet support the new mount api. So it's time we
rectify this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 515 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 279 insertions(+), 236 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..ceaf05743f45 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -16,6 +16,8 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
 #include <linux/file.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "overlayfs.h"
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -67,6 +69,59 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
 MODULE_PARM_DESC(metacopy,
 		 "Default to on or off for the metadata only copy up feature");
 
+enum {
+	Opt_lowerdir,
+	Opt_upperdir,
+	Opt_workdir,
+	Opt_default_permissions,
+	Opt_redirect_dir,
+	Opt_index,
+	Opt_uuid,
+	Opt_nfs_export,
+	Opt_userxattr,
+	Opt_xino,
+	Opt_metacopy,
+	Opt_volatile,
+};
+
+static const struct constant_table ovl_parameter_bool[] = {
+	{ "on",		true  },
+	{ "off",	false },
+	{}
+};
+
+static const struct constant_table ovl_parameter_xino[] = {
+	{ "on",		OVL_XINO_ON   },
+	{ "off",	OVL_XINO_OFF  },
+	{ "auto",	OVL_XINO_AUTO },
+	{}
+};
+
+static const struct fs_parameter_spec ovl_parameter_spec[] = {
+	fsparam_string("lowerdir",          Opt_lowerdir),
+	fsparam_string("upperdir",          Opt_upperdir),
+	fsparam_string("workdir",           Opt_workdir),
+	fsparam_flag("default_permissions", Opt_default_permissions),
+	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_bool),
+	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
+	fsparam_enum("uuid",                Opt_uuid, ovl_parameter_bool),
+	fsparam_enum("nfs_export",          Opt_nfs_export, ovl_parameter_bool),
+	fsparam_flag("userxattr",           Opt_userxattr),
+	fsparam_enum("xino",                Opt_xino, ovl_parameter_xino),
+	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
+	fsparam_flag("volatile",            Opt_volatile),
+	{}
+};
+
+#define OVL_METACOPY_SET	BIT(0)
+#define OVL_REDIRECT_SET	BIT(1)
+#define OVL_NFS_EXPORT_SET	BIT(2)
+#define OVL_INDEX_SET		BIT(3)
+
+struct ovl_fs_context {
+	u8 set;
+};
+
 static void ovl_dentry_release(struct dentry *dentry)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
@@ -394,27 +449,6 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	return 0;
 }
 
-static int ovl_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct ovl_fs *ofs = sb->s_fs_info;
-	struct super_block *upper_sb;
-	int ret = 0;
-
-	if (!(*flags & SB_RDONLY) && ovl_force_readonly(ofs))
-		return -EROFS;
-
-	if (*flags & SB_RDONLY && !sb_rdonly(sb)) {
-		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
-		if (ovl_should_sync(ofs)) {
-			down_read(&upper_sb->s_umount);
-			ret = sync_filesystem(upper_sb);
-			up_read(&upper_sb->s_umount);
-		}
-	}
-
-	return ret;
-}
-
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
@@ -424,76 +458,8 @@ static const struct super_operations ovl_super_operations = {
 	.sync_fs	= ovl_sync_fs,
 	.statfs		= ovl_statfs,
 	.show_options	= ovl_show_options,
-	.remount_fs	= ovl_remount,
-};
-
-enum {
-	OPT_LOWERDIR,
-	OPT_UPPERDIR,
-	OPT_WORKDIR,
-	OPT_DEFAULT_PERMISSIONS,
-	OPT_REDIRECT_DIR,
-	OPT_INDEX_ON,
-	OPT_INDEX_OFF,
-	OPT_UUID_ON,
-	OPT_UUID_OFF,
-	OPT_NFS_EXPORT_ON,
-	OPT_USERXATTR,
-	OPT_NFS_EXPORT_OFF,
-	OPT_XINO_ON,
-	OPT_XINO_OFF,
-	OPT_XINO_AUTO,
-	OPT_METACOPY_ON,
-	OPT_METACOPY_OFF,
-	OPT_VOLATILE,
-	OPT_ERR,
-};
-
-static const match_table_t ovl_tokens = {
-	{OPT_LOWERDIR,			"lowerdir=%s"},
-	{OPT_UPPERDIR,			"upperdir=%s"},
-	{OPT_WORKDIR,			"workdir=%s"},
-	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
-	{OPT_REDIRECT_DIR,		"redirect_dir=%s"},
-	{OPT_INDEX_ON,			"index=on"},
-	{OPT_INDEX_OFF,			"index=off"},
-	{OPT_USERXATTR,			"userxattr"},
-	{OPT_UUID_ON,			"uuid=on"},
-	{OPT_UUID_OFF,			"uuid=off"},
-	{OPT_NFS_EXPORT_ON,		"nfs_export=on"},
-	{OPT_NFS_EXPORT_OFF,		"nfs_export=off"},
-	{OPT_XINO_ON,			"xino=on"},
-	{OPT_XINO_OFF,			"xino=off"},
-	{OPT_XINO_AUTO,			"xino=auto"},
-	{OPT_METACOPY_ON,		"metacopy=on"},
-	{OPT_METACOPY_OFF,		"metacopy=off"},
-	{OPT_VOLATILE,			"volatile"},
-	{OPT_ERR,			NULL}
 };
 
-static char *ovl_next_opt(char **s)
-{
-	char *sbegin = *s;
-	char *p;
-
-	if (sbegin == NULL)
-		return NULL;
-
-	for (p = sbegin; *p; p++) {
-		if (*p == '\\') {
-			p++;
-			if (!*p)
-				break;
-		} else if (*p == ',') {
-			*p = '\0';
-			*s = p + 1;
-			return sbegin;
-		}
-	}
-	*s = NULL;
-	return sbegin;
-}
-
 static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
 {
 	if (strcmp(mode, "on") == 0) {
@@ -517,123 +483,14 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
 	return 0;
 }
 
-static int ovl_parse_opt(char *opt, struct ovl_config *config)
+static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
+				struct ovl_config *config)
 {
-	char *p;
 	int err;
-	bool metacopy_opt = false, redirect_opt = false;
-	bool nfs_export_opt = false, index_opt = false;
-
-	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
-	if (!config->redirect_mode)
-		return -ENOMEM;
-
-	while ((p = ovl_next_opt(&opt)) != NULL) {
-		int token;
-		substring_t args[MAX_OPT_ARGS];
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, ovl_tokens, args);
-		switch (token) {
-		case OPT_UPPERDIR:
-			kfree(config->upperdir);
-			config->upperdir = match_strdup(&args[0]);
-			if (!config->upperdir)
-				return -ENOMEM;
-			break;
-
-		case OPT_LOWERDIR:
-			kfree(config->lowerdir);
-			config->lowerdir = match_strdup(&args[0]);
-			if (!config->lowerdir)
-				return -ENOMEM;
-			break;
-
-		case OPT_WORKDIR:
-			kfree(config->workdir);
-			config->workdir = match_strdup(&args[0]);
-			if (!config->workdir)
-				return -ENOMEM;
-			break;
-
-		case OPT_DEFAULT_PERMISSIONS:
-			config->default_permissions = true;
-			break;
-
-		case OPT_REDIRECT_DIR:
-			kfree(config->redirect_mode);
-			config->redirect_mode = match_strdup(&args[0]);
-			if (!config->redirect_mode)
-				return -ENOMEM;
-			redirect_opt = true;
-			break;
-
-		case OPT_INDEX_ON:
-			config->index = true;
-			index_opt = true;
-			break;
-
-		case OPT_INDEX_OFF:
-			config->index = false;
-			index_opt = true;
-			break;
-
-		case OPT_UUID_ON:
-			config->uuid = true;
-			break;
-
-		case OPT_UUID_OFF:
-			config->uuid = false;
-			break;
-
-		case OPT_NFS_EXPORT_ON:
-			config->nfs_export = true;
-			nfs_export_opt = true;
-			break;
-
-		case OPT_NFS_EXPORT_OFF:
-			config->nfs_export = false;
-			nfs_export_opt = true;
-			break;
-
-		case OPT_XINO_ON:
-			config->xino = OVL_XINO_ON;
-			break;
-
-		case OPT_XINO_OFF:
-			config->xino = OVL_XINO_OFF;
-			break;
-
-		case OPT_XINO_AUTO:
-			config->xino = OVL_XINO_AUTO;
-			break;
-
-		case OPT_METACOPY_ON:
-			config->metacopy = true;
-			metacopy_opt = true;
-			break;
-
-		case OPT_METACOPY_OFF:
-			config->metacopy = false;
-			metacopy_opt = true;
-			break;
-
-		case OPT_VOLATILE:
-			config->ovl_volatile = true;
-			break;
-
-		case OPT_USERXATTR:
-			config->userxattr = true;
-			break;
-
-		default:
-			pr_err("unrecognized mount option \"%s\" or missing value\n",
-					p);
-			return -EINVAL;
-		}
-	}
+	bool metacopy_opt = ctx->set & OVL_METACOPY_SET,
+	     redirect_opt = ctx->set & OVL_REDIRECT_SET;
+	bool nfs_export_opt = ctx->set & OVL_NFS_EXPORT_SET,
+	     index_opt = ctx->set & OVL_INDEX_SET;
 
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
@@ -1882,12 +1739,143 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	return root;
 }
 
-static int ovl_fill_super(struct super_block *sb, void *data, int silent)
+static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct path upperpath = { };
+	int err = 0;
+	struct fs_parse_result result;
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_config *config = &ofs->config;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct path path;
+	char *dup;
+	int opt;
+	char *sval;
+
+	/*
+	 * On remount overlayfs has always ignored all mount options no
+	 * matter if malformed or not so for backwards compatibility we
+	 * do the same here.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
+	opt = fs_parse(fc, ovl_parameter_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_lowerdir:
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			path_put(&path);
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->lowerdir);
+		config->lowerdir = dup;
+		break;
+	case Opt_upperdir:
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			path_put(&path);
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->upperdir);
+		config->upperdir = dup;
+		break;
+	case Opt_workdir:
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			path_put(&path);
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->workdir);
+		config->workdir = dup;
+		break;
+	case Opt_default_permissions:
+		config->default_permissions = true;
+		break;
+	case Opt_index:
+		config->index = result.uint_32;
+		ctx->set |= OVL_INDEX_SET;
+		break;
+	case Opt_uuid:
+		config->uuid = result.uint_32;
+		break;
+	case Opt_nfs_export:
+		config->nfs_export = result.uint_32;
+		ctx->set |= OVL_NFS_EXPORT_SET;
+		break;
+	case Opt_metacopy:
+		config->metacopy = result.uint_32;
+		ctx->set |= OVL_METACOPY_SET;
+		break;
+	case Opt_userxattr:
+		config->userxattr = true;
+		break;
+	case Opt_volatile:
+		config->ovl_volatile = true;
+		break;
+	case Opt_xino:
+		config->xino = result.uint_32;
+		break;
+	case Opt_redirect_dir:
+		if (result.uint_32 == true)
+			sval = kstrdup("on", GFP_KERNEL);
+		else
+			sval = kstrdup("off", GFP_KERNEL);
+		if (!sval) {
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->redirect_mode);
+		config->redirect_mode = sval;
+		ctx->set |= OVL_REDIRECT_SET;
+		break;
+	default:
+		pr_err("unrecognized mount option \"%s\" or missing value\n", param->key);
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+
+static int ovl_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct super_block *upper_sb;
+	int ret = 0;
+
+	if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
+		return -EROFS;
+
+	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
+		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
+		if (ovl_should_sync(ofs)) {
+			down_read(&upper_sb->s_umount);
+			ret = sync_filesystem(upper_sb);
+			up_read(&upper_sb->s_umount);
+		}
+	}
+
+	return ret;
+}
+
+static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct path upperpath = {};
 	struct dentry *root_dentry;
 	struct ovl_entry *oe;
-	struct ovl_fs *ofs;
 	struct ovl_layer *layers;
 	struct cred *cred;
 	char *splitlower = NULL;
@@ -1895,36 +1883,24 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	int err;
 
 	err = -EIO;
-	if (WARN_ON(sb->s_user_ns != current_user_ns()))
-		goto out;
+	if (WARN_ON(fc->user_ns != current_user_ns()))
+		goto out_err;
 
+	ofs->share_whiteout = true;
 	sb->s_d_op = &ovl_dentry_operations;
 
-	err = -ENOMEM;
-	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
-	if (!ofs)
-		goto out;
-
 	err = -ENOMEM;
 	ofs->creator_cred = cred = prepare_creds();
 	if (!cred)
 		goto out_err;
 
-	/* Is there a reason anyone would want not to share whiteouts? */
-	ofs->share_whiteout = true;
-
-	ofs->config.index = ovl_index_def;
-	ofs->config.uuid = true;
-	ofs->config.nfs_export = ovl_nfs_export_def;
-	ofs->config.xino = ovl_xino_def();
-	ofs->config.metacopy = ovl_metacopy_def;
-	err = ovl_parse_opt((char *) data, &ofs->config);
+	err = ovl_fs_params_verify(ctx, &ofs->config);
 	if (err)
 		goto out_err;
 
 	err = -EINVAL;
 	if (!ofs->config.lowerdir) {
-		if (!silent)
+		if (fc->sb_flags & SB_SILENT)
 			pr_err("missing 'lowerdir'\n");
 		goto out_err;
 	}
@@ -2070,25 +2046,92 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	ovl_entry_stack_free(oe);
 	kfree(oe);
 out_err:
-	kfree(splitlower);
-	path_put(&upperpath);
-	ovl_free_fs(ofs);
-out:
 	return err;
 }
 
-static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
-				const char *dev_name, void *raw_data)
+static int ovl_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, ovl_fill_super);
+}
+
+static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
 {
-	return mount_nodev(fs_type, flags, raw_data, ovl_fill_super);
+	kfree(ctx);
+}
+
+static void ovl_free(struct fs_context *fc)
+{
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_fs_context *ctx = fc->fs_private;
+
+	/*
+	 * ofs is stored in the fs_context when it is initialized.
+	 * ofs is transferred to the superblock on a successful mount,
+	 * but if an error occurs before the transfer we have to free
+	 * it here.
+	 */
+	if (ofs)
+		ovl_free_fs(ofs);
+
+	if (ctx)
+		ovl_fs_context_free(ctx);
+}
+
+static const struct fs_context_operations ovl_context_ops = {
+	.parse_param = ovl_parse_param,
+	.get_tree    = ovl_get_tree,
+	.reconfigure = ovl_reconfigure,
+	.free        = ovl_free,
+};
+
+/*
+ * This is called during fsopen() and will record the user namespace of
+ * the caller in fc->user_ns since we've raised FS_USERNS_MOUNT. We'll
+ * need it when we actually create the superblock to verify that the
+ * process creating the superblock is in the same user namespace as
+ * process that called fsopen().
+ */
+static int ovl_init_fs_context(struct fs_context *fc)
+{
+	struct ovl_fs_context *ctx = NULL;
+	struct ovl_fs *ofs = NULL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		goto out_err;
+
+	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
+	if (!ofs)
+		goto out_err;
+
+	ofs->config.redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
+	if (!ofs->config.redirect_mode)
+		goto out_err;
+
+	ofs->config.index	= ovl_index_def;
+	ofs->config.uuid	= true;
+	ofs->config.nfs_export	= ovl_nfs_export_def;
+	ofs->config.xino	= ovl_xino_def();
+	ofs->config.metacopy	= ovl_metacopy_def;
+
+	fc->s_fs_info		= ofs;
+	fc->fs_private		= ctx;
+	fc->ops			= &ovl_context_ops;
+	return 0;
+
+out_err:
+	ovl_fs_context_free(ctx);
+	ovl_free_fs(ofs);
+	return -ENOMEM;
 }
 
 static struct file_system_type ovl_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "overlay",
-	.fs_flags	= FS_USERNS_MOUNT,
-	.mount		= ovl_mount,
-	.kill_sb	= kill_anon_super,
+	.owner			= THIS_MODULE,
+	.name			= "overlay",
+	.init_fs_context	= ovl_init_fs_context,
+	.parameters		= ovl_parameter_spec,
+	.fs_flags		= FS_USERNS_MOUNT,
+	.kill_sb		= kill_anon_super,
 };
 MODULE_ALIAS_FS("overlay");
 

-- 
2.34.1

