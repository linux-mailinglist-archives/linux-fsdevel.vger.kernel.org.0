Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA172E62E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbjFMOuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbjFMOtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A419B3;
        Tue, 13 Jun 2023 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D99F63649;
        Tue, 13 Jun 2023 14:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E3DC433F1;
        Tue, 13 Jun 2023 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686667774;
        bh=mR8KImFQwgQk9Ddz6ZLC2b+Vf1MzmIFN6Pn2N3bf1GQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=f6cny0aMbAwh4Jy1lu5a49I22AV8udOgXVe2iVwKGwHiBFzUFLH9x6WovCbV1T9Rh
         ZfphwCCCT8yn3b3+bGNT03CMfQeNHsUP1FouvzdVR+k8vVqRYaSB8ClVF3svzPqacz
         LkPS7yIeBtOFIdWq6yUUoJQxKX1C99qSgqFp6LDNXe7k07GU6oAJ4FVX2nLneWIrQc
         hKs7BXI2+l/NeeBSUSpCy3n0haUJ+UyVKqcLwjO4vwlee8cbqaCxZ1H4qGs6vD/vUF
         GiVnH7NAaoZI80JP4sdY/KKBzvwA9oSrAdSAC1437YWaxIqEqj1f03+qXZQbnl8QSm
         cxiwIcEUC1OOQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 13 Jun 2023 16:49:17 +0200
Subject: [PATCH v3 2/3] ovl: port to new mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=20251; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mR8KImFQwgQk9Ddz6ZLC2b+Vf1MzmIFN6Pn2N3bf1GQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0NP6y6M99ql8RZOWxOaz3afTF5kf/NJWPr4s0EauW4Ff6
 vsO+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLLxRkZHlbwmDUKr32Y66njxeZWsH
 2hBttW7qTXYt3b+H+mTbrXzPCHdyp3/wSXd/k1Ct9e5Fz6MX+NYf2eJbx2TBJq07fnyrPxAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/overlayfs/ovl_entry.h |   2 +-
 fs/overlayfs/super.c     | 557 ++++++++++++++++++++++++++---------------------
 2 files changed, 305 insertions(+), 254 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e5207c4bf5b8..c72433c06006 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -12,7 +12,7 @@ struct ovl_config {
 	bool default_permissions;
 	bool redirect_dir;
 	bool redirect_follow;
-	const char *redirect_mode;
+	unsigned redirect_mode;
 	bool index;
 	bool uuid;
 	bool nfs_export;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d9be5d318e1b..3392dc5d2082 100644
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
@@ -59,6 +61,79 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
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
+enum {
+	OVL_REDIRECT_DIR_ON,
+	OVL_REDIRECT_DIR_OFF,
+	OVL_REDIRECT_DIR_FOLLOW,
+	OVL_REDIRECT_DIR_NOFOLLOW,
+};
+
+static const struct constant_table ovl_parameter_redirect_dir[] = {
+	{ "on",		OVL_REDIRECT_DIR_ON       },
+	{ "off",	OVL_REDIRECT_DIR_OFF      },
+	{ "follow",	OVL_REDIRECT_DIR_FOLLOW   },
+	{ "nofollow",	OVL_REDIRECT_DIR_NOFOLLOW },
+	{}
+};
+
+static const char *ovl_redirect_mode(struct ovl_config *config)
+{
+	return ovl_parameter_redirect_dir[config->redirect_mode].name;
+}
+
+static const struct fs_parameter_spec ovl_parameter_spec[] = {
+	fsparam_string("lowerdir",          Opt_lowerdir),
+	fsparam_string("upperdir",          Opt_upperdir),
+	fsparam_string("workdir",           Opt_workdir),
+	fsparam_flag("default_permissions", Opt_default_permissions),
+	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_redirect_dir),
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
 static struct dentry *ovl_d_real(struct dentry *dentry,
 				 const struct inode *inode)
 {
@@ -243,7 +318,6 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	kfree(ofs->config.lowerdir);
 	kfree(ofs->config.upperdir);
 	kfree(ofs->config.workdir);
-	kfree(ofs->config.redirect_mode);
 	if (ofs->creator_cred)
 		put_cred(ofs->creator_cred);
 	kfree(ofs);
@@ -253,7 +327,8 @@ static void ovl_put_super(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
-	ovl_free_fs(ofs);
+	if (ofs)
+		ovl_free_fs(ofs);
 }
 
 /* Sync real dirty inodes in upper filesystem (if it exists) */
@@ -357,6 +432,7 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = sb->s_fs_info;
+	const char *redirect_mode;
 
 	seq_show_option(m, "lowerdir", ofs->config.lowerdir);
 	if (ofs->config.upperdir) {
@@ -365,8 +441,9 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	}
 	if (ofs->config.default_permissions)
 		seq_puts(m, ",default_permissions");
-	if (strcmp(ofs->config.redirect_mode, ovl_redirect_mode_def()) != 0)
-		seq_printf(m, ",redirect_dir=%s", ofs->config.redirect_mode);
+	redirect_mode = ovl_redirect_mode(&ofs->config);
+	if (strcmp(redirect_mode, ovl_redirect_mode_def()) != 0)
+		seq_printf(m, ",redirect_dir=%s", redirect_mode);
 	if (ofs->config.index != ovl_index_def)
 		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
 	if (!ofs->config.uuid)
@@ -386,27 +463,6 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
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
@@ -416,216 +472,42 @@ static const struct super_operations ovl_super_operations = {
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
+static int ovl_set_redirect_mode(struct ovl_config *config)
 {
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
-static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
-{
-	if (strcmp(mode, "on") == 0) {
+	switch (config->redirect_mode) {
+	case OVL_REDIRECT_DIR_ON:
 		config->redirect_dir = true;
 		/*
 		 * Does not make sense to have redirect creation without
 		 * redirect following.
 		 */
 		config->redirect_follow = true;
-	} else if (strcmp(mode, "follow") == 0) {
+		return 0;
+	case OVL_REDIRECT_DIR_FOLLOW:
 		config->redirect_follow = true;
-	} else if (strcmp(mode, "off") == 0) {
+		return 0;
+	case OVL_REDIRECT_DIR_OFF:
 		if (ovl_redirect_always_follow)
 			config->redirect_follow = true;
-	} else if (strcmp(mode, "nofollow") != 0) {
-		pr_err("bad mount option \"redirect_dir=%s\"\n",
-		       mode);
-		return -EINVAL;
+		return 0;
+	case OVL_REDIRECT_DIR_NOFOLLOW:
+		return 0;
 	}
 
-	return 0;
+	pr_err("invalid \"redirect_dir\" mount option\n");
+	return -EINVAL;
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
+	bool metacopy_opt = ctx->set & OVL_METACOPY_SET;
+	bool redirect_opt = ctx->set & OVL_REDIRECT_SET;
+	bool nfs_export_opt = ctx->set & OVL_NFS_EXPORT_SET;
+	bool index_opt = ctx->set & OVL_INDEX_SET;
 
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
@@ -647,7 +529,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		config->ovl_volatile = false;
 	}
 
-	err = ovl_parse_redirect_mode(config, config->redirect_mode);
+	err = ovl_set_redirect_mode(config);
 	if (err)
 		return err;
 
@@ -662,7 +544,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	if (config->metacopy && !config->redirect_dir) {
 		if (metacopy_opt && redirect_opt) {
 			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
-			       config->redirect_mode);
+			       ovl_redirect_mode(config));
 			return -EINVAL;
 		}
 		if (redirect_opt) {
@@ -671,7 +553,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			 * in this conflict.
 			 */
 			pr_info("disabling metacopy due to redirect_dir=%s\n",
-				config->redirect_mode);
+				ovl_redirect_mode(config));
 			config->metacopy = false;
 		} else {
 			/* Automatically enable redirect otherwise. */
@@ -728,7 +610,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	if (config->userxattr) {
 		if (config->redirect_follow && redirect_opt) {
 			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
-			       config->redirect_mode);
+			       ovl_redirect_mode(config));
 			return -EINVAL;
 		}
 		if (config->metacopy && metacopy_opt) {
@@ -1926,12 +1808,128 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	return root;
 }
 
-static int ovl_fill_super(struct super_block *sb, void *data, int silent)
+static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	int err = 0;
+	struct fs_parse_result result;
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_config *config = &ofs->config;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	char *dup;
+	int opt;
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
+		config->redirect_mode = result.uint_32;
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
 {
-	struct path upperpath = { };
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
@@ -1939,36 +1937,24 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -2113,25 +2099,90 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 out_free_oe:
 	ovl_free_entry(oe);
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
+{
+	kfree(ctx);
+}
+
+static void ovl_free(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, raw_data, ovl_fill_super);
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
+	struct ovl_fs_context *ctx;
+	struct ovl_fs *ofs;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		return -ENOMEM;
+
+	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
+	if (!ofs) {
+		ovl_fs_context_free(ctx);
+		return -ENOMEM;
+	}
+
+	if (strcmp(ovl_redirect_mode_def(), "on") == 0)
+		ofs->config.redirect_mode = OVL_REDIRECT_DIR_ON;
+	else
+		ofs->config.redirect_mode = OVL_REDIRECT_DIR_OFF;
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

