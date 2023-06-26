Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54E73DC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFZKXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZKXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB219A;
        Mon, 26 Jun 2023 03:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B844160A20;
        Mon, 26 Jun 2023 10:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C2AC433C8;
        Mon, 26 Jun 2023 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687775024;
        bh=U+sqqAg1oY9cm0iz1CkTZiEz9lG8TvgLO7MacTY1YF4=;
        h=From:Date:Subject:To:Cc:From;
        b=a0zLhUiQcP1EPy+i8NKPT0fR24rGeG8gMLks+VnBQTQGoM9MueahIuZblgSAkGtdC
         XWUMUJV6fKNzNmX6pTPoqZsUcFb+3RjCzWeELasTvxOXcXmPQJDBs1wCWZxPQfMio2
         GQ4iQoX4jnihrTZofG2NiEB0ZkCZmBakxU5VxTjXkiM+858pkiVuUjSS2d7CmH6rre
         vwh7vJJERUpMs8etBhjkdjl5Z+m0x7SQK+8WwWZyX3hi4v7rHR7w0JR+C7BDqZqryo
         cQ8YykHzzXTynH5vkMGY4PrXmqC0Jkcqrr/fi+2pOrc056sw2g8grUkn9Xjnmbe4aU
         4iKzhZeEEN0ew==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 26 Jun 2023 12:23:36 +0200
Subject: [PATCH] ovl: move all parameter handling into params.{c,h}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-fs-overlayfs-mount-api-param-v1-1-29afb997a19f@kernel.org>
X-B4-Tracking: v=1; b=H4sIACdnmWQC/0WNwQqDMBBEf0X23AWNVLS/UnpY46YuaBI2Khbx3
 xt76W0ezLw5ILEKJ3gUByhvkiT4DNWtADuSfzPKkBlMaeqyMXd0CcPGOtEnpzmsfkGKgpGUZuy
 6eqgsUds4B1nRU2LslbwdL8l/6HlfrkJUdrL//p+v8/wCb64me48AAAA=
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=39562; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U+sqqAg1oY9cm0iz1CkTZiEz9lG8TvgLO7MacTY1YF4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMTNdjsbI8yBRrvC3t0ewL4t9Oq5UcS3q/JTRcfLV+o8jH
 oqCkjhIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImIGDIyvGNZ9Mt69Ykcs6vqJ6vP9q
 ffEnvuHZ1nPcVadob4Nmt2WYZv2pPurGpPsDy9YKuC+/sDNz+e1jjAOnnFHm2BC6/Wt+5iBgA=
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

While initially I thought that we couldn't move all new mount api
handling into params.{c,h} it turns out it is possible. So this just
moves a good chunk of code out of super.c and into params.{c,h}.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---
 fs/overlayfs/overlayfs.h |  41 +---
 fs/overlayfs/params.c    | 532 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/overlayfs/params.h    |  42 ++++
 fs/overlayfs/super.c     | 530 +---------------------------------------------
 4 files changed, 581 insertions(+), 564 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5b6ac03af192..ece77737df8d 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -70,14 +70,6 @@ enum {
 	OVL_XINO_ON,
 };
 
-/* The set of options that user requested explicitly via mount options */
-struct ovl_opt_set {
-	bool metacopy;
-	bool redirect;
-	bool nfs_export;
-	bool index;
-};
-
 /*
  * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
  * where:
@@ -134,6 +126,12 @@ struct ovl_fh {
 #define OVL_FH_FID_OFFSET	(OVL_FH_WIRE_OFFSET + \
 				 offsetof(struct ovl_fb, fid))
 
+/* Will this overlay be forced to mount/remount ro? */
+static inline bool ovl_force_readonly(struct ovl_fs *ofs)
+{
+	return (!ovl_upper_mnt(ofs) || !ofs->workdir);
+}
+
 extern const char *const ovl_xattr_table[][2];
 static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 {
@@ -367,30 +365,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 	return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
 }
 
-
-/* params.c */
-#define OVL_MAX_STACK 500
-
-struct ovl_fs_context_layer {
-	char *name;
-	struct path path;
-};
-
-struct ovl_fs_context {
-	struct path upper;
-	struct path work;
-	size_t capacity;
-	size_t nr; /* includes nr_data */
-	size_t nr_data;
-	struct ovl_opt_set set;
-	struct ovl_fs_context_layer *lower;
-};
-
-int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
-			     bool workdir);
-int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
-void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
-
 /* util.c */
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
@@ -790,3 +764,6 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
+
+/* super.c */
+int ovl_fill_super(struct super_block *sb, struct fs_context *fc);
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index d17d6b483dd0..b8c2f6056a9a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1,12 +1,124 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/fs.h>
+#include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/seq_file.h>
 #include <linux/xattr.h>
 #include "overlayfs.h"
+#include "params.h"
+
+static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
+module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
+MODULE_PARM_DESC(redirect_dir,
+		 "Default to on or off for the redirect_dir feature");
+
+static bool ovl_redirect_always_follow =
+	IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
+module_param_named(redirect_always_follow, ovl_redirect_always_follow,
+		   bool, 0644);
+MODULE_PARM_DESC(redirect_always_follow,
+		 "Follow redirects even if redirect_dir feature is turned off");
+
+static bool ovl_xino_auto_def = IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AUTO);
+module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
+MODULE_PARM_DESC(xino_auto,
+		 "Auto enable xino feature");
+
+static bool ovl_index_def = IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
+module_param_named(index, ovl_index_def, bool, 0644);
+MODULE_PARM_DESC(index,
+		 "Default to on or off for the inodes index feature");
+
+static bool ovl_nfs_export_def = IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EXPORT);
+module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
+MODULE_PARM_DESC(nfs_export,
+		 "Default to on or off for the NFS export feature");
+
+static bool ovl_metacopy_def = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
+module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
+MODULE_PARM_DESC(metacopy,
+		 "Default to on or off for the metadata only copy up feature");
+
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
+	{ "off",	OVL_XINO_OFF  },
+	{ "auto",	OVL_XINO_AUTO },
+	{ "on",		OVL_XINO_ON   },
+	{}
+};
+
+const char *ovl_xino_mode(struct ovl_config *config)
+{
+	return ovl_parameter_xino[config->xino].name;
+}
+
+static int ovl_xino_def(void)
+{
+	return ovl_xino_auto_def ? OVL_XINO_AUTO : OVL_XINO_OFF;
+}
+
+const struct constant_table ovl_parameter_redirect_dir[] = {
+	{ "off",	OVL_REDIRECT_OFF      },
+	{ "follow",	OVL_REDIRECT_FOLLOW   },
+	{ "nofollow",	OVL_REDIRECT_NOFOLLOW },
+	{ "on",		OVL_REDIRECT_ON       },
+	{}
+};
+
+const char *ovl_redirect_mode(struct ovl_config *config)
+{
+	return ovl_parameter_redirect_dir[config->redirect_mode].name;
+}
+
+static int ovl_redirect_mode_def(void)
+{
+	return ovl_redirect_dir_def	  ? OVL_REDIRECT_ON :
+	       ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
+					    OVL_REDIRECT_NOFOLLOW;
+}
+
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
+const struct fs_parameter_spec ovl_parameter_spec[] = {
+	fsparam_string_empty("lowerdir",    Opt_lowerdir),
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
 
 static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 {
@@ -110,8 +222,8 @@ static int ovl_mount_dir(const char *name, struct path *path)
 	return err;
 }
 
-int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
-			     bool workdir)
+static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
+				    bool workdir)
 {
 	int err;
 	struct ovl_fs *ofs = fc->s_fs_info;
@@ -154,7 +266,7 @@ int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
 	return 0;
 }
 
-void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
+static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
 {
 	for (size_t nr = 0; nr < ctx->nr; nr++) {
 		path_put(&ctx->lower[nr].path);
@@ -179,7 +291,7 @@ void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
  *     Append data "/lower5" as data lower layer. This requires that
  *     there's at least one regular lower layer present.
  */
-int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
+static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 {
 	int err;
 	struct ovl_fs_context *ctx = fc->fs_private;
@@ -387,3 +499,415 @@ int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	/* Intentionally don't realloc to a smaller size. */
 	return err;
 }
+
+static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	int err = 0;
+	struct fs_parse_result result;
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_config *config = &ofs->config;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	int opt;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		/*
+		 * On remount overlayfs has always ignored all mount
+		 * options no matter if malformed or not so for
+		 * backwards compatibility we do the same here.
+		 */
+		if (fc->oldapi)
+			return 0;
+
+		/*
+		 * Give us the freedom to allow changing mount options
+		 * with the new mount api in the future. So instead of
+		 * silently ignoring everything we report a proper
+		 * error. This is only visible for users of the new
+		 * mount api.
+		 */
+		return invalfc(fc, "No changes allowed in reconfigure");
+	}
+
+	opt = fs_parse(fc, ovl_parameter_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_lowerdir:
+		err = ovl_parse_param_lowerdir(param->string, fc);
+		break;
+	case Opt_upperdir:
+		fallthrough;
+	case Opt_workdir:
+		err = ovl_parse_param_upperdir(param->string, fc,
+					       (Opt_workdir == opt));
+		break;
+	case Opt_default_permissions:
+		config->default_permissions = true;
+		break;
+	case Opt_redirect_dir:
+		config->redirect_mode = result.uint_32;
+		if (config->redirect_mode == OVL_REDIRECT_OFF) {
+			config->redirect_mode = ovl_redirect_always_follow ?
+						OVL_REDIRECT_FOLLOW :
+						OVL_REDIRECT_NOFOLLOW;
+		}
+		ctx->set.redirect = true;
+		break;
+	case Opt_index:
+		config->index = result.uint_32;
+		ctx->set.index = true;
+		break;
+	case Opt_uuid:
+		config->uuid = result.uint_32;
+		break;
+	case Opt_nfs_export:
+		config->nfs_export = result.uint_32;
+		ctx->set.nfs_export = true;
+		break;
+	case Opt_xino:
+		config->xino = result.uint_32;
+		break;
+	case Opt_metacopy:
+		config->metacopy = result.uint_32;
+		ctx->set.metacopy = true;
+		break;
+	case Opt_volatile:
+		config->ovl_volatile = true;
+		break;
+	case Opt_userxattr:
+		config->userxattr = true;
+		break;
+	default:
+		pr_err("unrecognized mount option \"%s\" or missing value\n",
+		       param->key);
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+static int ovl_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, ovl_fill_super);
+}
+
+static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
+{
+	ovl_parse_param_drop_lowerdir(ctx);
+	path_put(&ctx->upper);
+	path_put(&ctx->work);
+	kfree(ctx->lower);
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
+int ovl_init_fs_context(struct fs_context *fc)
+{
+	struct ovl_fs_context *ctx;
+	struct ovl_fs *ofs;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		return -ENOMEM;
+
+	/*
+	 * By default we allocate for three lower layers. It's likely
+	 * that it'll cover most users.
+	 */
+	ctx->lower = kmalloc_array(3, sizeof(*ctx->lower), GFP_KERNEL_ACCOUNT);
+	if (!ctx->lower)
+		goto out_err;
+	ctx->capacity = 3;
+
+	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
+	if (!ofs)
+		goto out_err;
+
+	ofs->config.redirect_mode	= ovl_redirect_mode_def();
+	ofs->config.index		= ovl_index_def;
+	ofs->config.uuid		= true;
+	ofs->config.nfs_export		= ovl_nfs_export_def;
+	ofs->config.xino		= ovl_xino_def();
+	ofs->config.metacopy		= ovl_metacopy_def;
+
+	fc->s_fs_info		= ofs;
+	fc->fs_private		= ctx;
+	fc->ops			= &ovl_context_ops;
+	return 0;
+
+out_err:
+	ovl_fs_context_free(ctx);
+	return -ENOMEM;
+
+}
+
+void ovl_free_fs(struct ovl_fs *ofs)
+{
+	struct vfsmount **mounts;
+	unsigned i;
+
+	iput(ofs->workbasedir_trap);
+	iput(ofs->indexdir_trap);
+	iput(ofs->workdir_trap);
+	dput(ofs->whiteout);
+	dput(ofs->indexdir);
+	dput(ofs->workdir);
+	if (ofs->workdir_locked)
+		ovl_inuse_unlock(ofs->workbasedir);
+	dput(ofs->workbasedir);
+	if (ofs->upperdir_locked)
+		ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
+
+	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
+	mounts = (struct vfsmount **) ofs->layers;
+	for (i = 0; i < ofs->numlayer; i++) {
+		iput(ofs->layers[i].trap);
+		mounts[i] = ofs->layers[i].mnt;
+		kfree(ofs->layers[i].name);
+	}
+	kern_unmount_array(mounts, ofs->numlayer);
+	kfree(ofs->layers);
+	for (i = 0; i < ofs->numfs; i++)
+		free_anon_bdev(ofs->fs[i].pseudo_dev);
+	kfree(ofs->fs);
+
+	kfree(ofs->config.upperdir);
+	kfree(ofs->config.workdir);
+	if (ofs->creator_cred)
+		put_cred(ofs->creator_cred);
+	kfree(ofs);
+}
+
+int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
+			 struct ovl_config *config)
+{
+	struct ovl_opt_set set = ctx->set;
+
+	if (ctx->nr_data > 0 && !config->metacopy) {
+		pr_err("lower data-only dirs require metacopy support.\n");
+		return -EINVAL;
+	}
+
+	/* Workdir/index are useless in non-upper mount */
+	if (!config->upperdir) {
+		if (config->workdir) {
+			pr_info("option \"workdir=%s\" is useless in a non-upper mount, ignore\n",
+				config->workdir);
+			kfree(config->workdir);
+			config->workdir = NULL;
+		}
+		if (config->index && set.index) {
+			pr_info("option \"index=on\" is useless in a non-upper mount, ignore\n");
+			set.index = false;
+		}
+		config->index = false;
+	}
+
+	if (!config->upperdir && config->ovl_volatile) {
+		pr_info("option \"volatile\" is meaningless in a non-upper mount, ignoring it.\n");
+		config->ovl_volatile = false;
+	}
+
+	/*
+	 * This is to make the logic below simpler.  It doesn't make any other
+	 * difference, since redirect_dir=on is only used for upper.
+	 */
+	if (!config->upperdir && config->redirect_mode == OVL_REDIRECT_FOLLOW)
+		config->redirect_mode = OVL_REDIRECT_ON;
+
+	/* Resolve metacopy -> redirect_dir dependency */
+	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON) {
+		if (set.metacopy && set.redirect) {
+			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
+			       ovl_redirect_mode(config));
+			return -EINVAL;
+		}
+		if (set.redirect) {
+			/*
+			 * There was an explicit redirect_dir=... that resulted
+			 * in this conflict.
+			 */
+			pr_info("disabling metacopy due to redirect_dir=%s\n",
+				ovl_redirect_mode(config));
+			config->metacopy = false;
+		} else {
+			/* Automatically enable redirect otherwise. */
+			config->redirect_mode = OVL_REDIRECT_ON;
+		}
+	}
+
+	/* Resolve nfs_export -> index dependency */
+	if (config->nfs_export && !config->index) {
+		if (!config->upperdir &&
+		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
+			pr_info("NFS export requires \"redirect_dir=nofollow\" on non-upper mount, falling back to nfs_export=off.\n");
+			config->nfs_export = false;
+		} else if (set.nfs_export && set.index) {
+			pr_err("conflicting options: nfs_export=on,index=off\n");
+			return -EINVAL;
+		} else if (set.index) {
+			/*
+			 * There was an explicit index=off that resulted
+			 * in this conflict.
+			 */
+			pr_info("disabling nfs_export due to index=off\n");
+			config->nfs_export = false;
+		} else {
+			/* Automatically enable index otherwise. */
+			config->index = true;
+		}
+	}
+
+	/* Resolve nfs_export -> !metacopy dependency */
+	if (config->nfs_export && config->metacopy) {
+		if (set.nfs_export && set.metacopy) {
+			pr_err("conflicting options: nfs_export=on,metacopy=on\n");
+			return -EINVAL;
+		}
+		if (set.metacopy) {
+			/*
+			 * There was an explicit metacopy=on that resulted
+			 * in this conflict.
+			 */
+			pr_info("disabling nfs_export due to metacopy=on\n");
+			config->nfs_export = false;
+		} else {
+			/*
+			 * There was an explicit nfs_export=on that resulted
+			 * in this conflict.
+			 */
+			pr_info("disabling metacopy due to nfs_export=on\n");
+			config->metacopy = false;
+		}
+	}
+
+
+	/* Resolve userxattr -> !redirect && !metacopy dependency */
+	if (config->userxattr) {
+		if (set.redirect &&
+		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
+			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
+			       ovl_redirect_mode(config));
+			return -EINVAL;
+		}
+		if (config->metacopy && set.metacopy) {
+			pr_err("conflicting options: userxattr,metacopy=on\n");
+			return -EINVAL;
+		}
+		/*
+		 * Silently disable default setting of redirect and metacopy.
+		 * This shall be the default in the future as well: these
+		 * options must be explicitly enabled if used together with
+		 * userxattr.
+		 */
+		config->redirect_mode = OVL_REDIRECT_NOFOLLOW;
+		config->metacopy = false;
+	}
+
+	return 0;
+}
+
+/**
+ * ovl_show_options
+ * @m: the seq_file handle
+ * @dentry: The dentry to query
+ *
+ * Prints the mount options for a given superblock.
+ * Returns zero; does not fail.
+ */
+int ovl_show_options(struct seq_file *m, struct dentry *dentry)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct ovl_fs *ofs = sb->s_fs_info;
+	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
+	const struct ovl_layer *data_layers = &ofs->layers[nr_merged_lower];
+
+	/* ofs->layers[0] is the upper layer */
+	seq_printf(m, ",lowerdir=%s", ofs->layers[1].name);
+	/* dump regular lower layers */
+	for (nr = 2; nr < nr_merged_lower; nr++)
+		seq_printf(m, ":%s", ofs->layers[nr].name);
+	/* dump data lower layers */
+	for (nr = 0; nr < ofs->numdatalayer; nr++)
+		seq_printf(m, "::%s", data_layers[nr].name);
+	if (ofs->config.upperdir) {
+		seq_show_option(m, "upperdir", ofs->config.upperdir);
+		seq_show_option(m, "workdir", ofs->config.workdir);
+	}
+	if (ofs->config.default_permissions)
+		seq_puts(m, ",default_permissions");
+	if (ofs->config.redirect_mode != ovl_redirect_mode_def())
+		seq_printf(m, ",redirect_dir=%s",
+			   ovl_redirect_mode(&ofs->config));
+	if (ofs->config.index != ovl_index_def)
+		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
+	if (!ofs->config.uuid)
+		seq_puts(m, ",uuid=off");
+	if (ofs->config.nfs_export != ovl_nfs_export_def)
+		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
+						"on" : "off");
+	if (ofs->config.xino != ovl_xino_def() && !ovl_same_fs(ofs))
+		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
+	if (ofs->config.metacopy != ovl_metacopy_def)
+		seq_printf(m, ",metacopy=%s",
+			   ofs->config.metacopy ? "on" : "off");
+	if (ofs->config.ovl_volatile)
+		seq_puts(m, ",volatile");
+	if (ofs->config.userxattr)
+		seq_puts(m, ",userxattr");
+	return 0;
+}
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
new file mode 100644
index 000000000000..8750da68ab2a
--- /dev/null
+++ b/fs/overlayfs/params.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+
+struct ovl_fs;
+struct ovl_config;
+
+extern const struct fs_parameter_spec ovl_parameter_spec[];
+extern const struct constant_table ovl_parameter_redirect_dir[];
+
+/* The set of options that user requested explicitly via mount options */
+struct ovl_opt_set {
+	bool metacopy;
+	bool redirect;
+	bool nfs_export;
+	bool index;
+};
+
+#define OVL_MAX_STACK 500
+
+struct ovl_fs_context_layer {
+	char *name;
+	struct path path;
+};
+
+struct ovl_fs_context {
+	struct path upper;
+	struct path work;
+	size_t capacity;
+	size_t nr; /* includes nr_data */
+	size_t nr_data;
+	struct ovl_opt_set set;
+	struct ovl_fs_context_layer *lower;
+};
+
+int ovl_init_fs_context(struct fs_context *fc);
+void ovl_free_fs(struct ovl_fs *ofs);
+int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
+			 struct ovl_config *config);
+int ovl_show_options(struct seq_file *m, struct dentry *dentry);
+const char *ovl_xino_mode(struct ovl_config *config);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c14c52560fd6..5b069f1a1e44 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -19,6 +19,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include "overlayfs.h"
+#include "params.h"
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Overlay filesystem");
@@ -27,38 +28,6 @@ MODULE_LICENSE("GPL");
 
 struct ovl_dir_cache;
 
-static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
-module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
-MODULE_PARM_DESC(redirect_dir,
-		 "Default to on or off for the redirect_dir feature");
-
-static bool ovl_redirect_always_follow =
-	IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
-module_param_named(redirect_always_follow, ovl_redirect_always_follow,
-		   bool, 0644);
-MODULE_PARM_DESC(redirect_always_follow,
-		 "Follow redirects even if redirect_dir feature is turned off");
-
-static bool ovl_index_def = IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
-module_param_named(index, ovl_index_def, bool, 0644);
-MODULE_PARM_DESC(index,
-		 "Default to on or off for the inodes index feature");
-
-static bool ovl_nfs_export_def = IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EXPORT);
-module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
-MODULE_PARM_DESC(nfs_export,
-		 "Default to on or off for the NFS export feature");
-
-static bool ovl_xino_auto_def = IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AUTO);
-module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
-MODULE_PARM_DESC(xino_auto,
-		 "Auto enable xino feature");
-
-static bool ovl_metacopy_def = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
-module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
-MODULE_PARM_DESC(metacopy,
-		 "Default to on or off for the metadata only copy up feature");
-
 static struct dentry *ovl_d_real(struct dentry *dentry,
 				 const struct inode *inode)
 {
@@ -211,43 +180,6 @@ static void ovl_destroy_inode(struct inode *inode)
 		kfree(oi->lowerdata_redirect);
 }
 
-static void ovl_free_fs(struct ovl_fs *ofs)
-{
-	struct vfsmount **mounts;
-	unsigned i;
-
-	iput(ofs->workbasedir_trap);
-	iput(ofs->indexdir_trap);
-	iput(ofs->workdir_trap);
-	dput(ofs->whiteout);
-	dput(ofs->indexdir);
-	dput(ofs->workdir);
-	if (ofs->workdir_locked)
-		ovl_inuse_unlock(ofs->workbasedir);
-	dput(ofs->workbasedir);
-	if (ofs->upperdir_locked)
-		ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
-
-	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
-	mounts = (struct vfsmount **) ofs->layers;
-	for (i = 0; i < ofs->numlayer; i++) {
-		iput(ofs->layers[i].trap);
-		mounts[i] = ofs->layers[i].mnt;
-		kfree(ofs->layers[i].name);
-	}
-	kern_unmount_array(mounts, ofs->numlayer);
-	kfree(ofs->layers);
-	for (i = 0; i < ofs->numfs; i++)
-		free_anon_bdev(ofs->fs[i].pseudo_dev);
-	kfree(ofs->fs);
-
-	kfree(ofs->config.upperdir);
-	kfree(ofs->config.workdir);
-	if (ofs->creator_cred)
-		put_cred(ofs->creator_cred);
-	kfree(ofs);
-}
-
 static void ovl_put_super(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -323,122 +255,6 @@ static int ovl_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return err;
 }
 
-/* Will this overlay be forced to mount/remount ro? */
-static bool ovl_force_readonly(struct ovl_fs *ofs)
-{
-	return (!ovl_upper_mnt(ofs) || !ofs->workdir);
-}
-
-static const struct constant_table ovl_parameter_redirect_dir[] = {
-	{ "off",	OVL_REDIRECT_OFF      },
-	{ "follow",	OVL_REDIRECT_FOLLOW   },
-	{ "nofollow",	OVL_REDIRECT_NOFOLLOW },
-	{ "on",		OVL_REDIRECT_ON       },
-	{}
-};
-
-static const char *ovl_redirect_mode(struct ovl_config *config)
-{
-	return ovl_parameter_redirect_dir[config->redirect_mode].name;
-}
-
-static int ovl_redirect_mode_def(void)
-{
-	return ovl_redirect_dir_def ? OVL_REDIRECT_ON :
-		ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
-					     OVL_REDIRECT_NOFOLLOW;
-}
-
-static const struct constant_table ovl_parameter_xino[] = {
-	{ "off",	OVL_XINO_OFF  },
-	{ "auto",	OVL_XINO_AUTO },
-	{ "on",		OVL_XINO_ON   },
-	{}
-};
-
-static const char *ovl_xino_mode(struct ovl_config *config)
-{
-	return ovl_parameter_xino[config->xino].name;
-}
-
-static inline int ovl_xino_def(void)
-{
-	return ovl_xino_auto_def ? OVL_XINO_AUTO : OVL_XINO_OFF;
-}
-
-/**
- * ovl_show_options
- * @m: the seq_file handle
- * @dentry: The dentry to query
- *
- * Prints the mount options for a given superblock.
- * Returns zero; does not fail.
- */
-static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
-{
-	struct super_block *sb = dentry->d_sb;
-	struct ovl_fs *ofs = sb->s_fs_info;
-	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
-	const struct ovl_layer *data_layers = &ofs->layers[nr_merged_lower];
-
-	/* ofs->layers[0] is the upper layer */
-	seq_printf(m, ",lowerdir=%s", ofs->layers[1].name);
-	/* dump regular lower layers */
-	for (nr = 2; nr < nr_merged_lower; nr++)
-		seq_printf(m, ":%s", ofs->layers[nr].name);
-	/* dump data lower layers */
-	for (nr = 0; nr < ofs->numdatalayer; nr++)
-		seq_printf(m, "::%s", data_layers[nr].name);
-	if (ofs->config.upperdir) {
-		seq_show_option(m, "upperdir", ofs->config.upperdir);
-		seq_show_option(m, "workdir", ofs->config.workdir);
-	}
-	if (ofs->config.default_permissions)
-		seq_puts(m, ",default_permissions");
-	if (ofs->config.redirect_mode != ovl_redirect_mode_def())
-		seq_printf(m, ",redirect_dir=%s",
-			   ovl_redirect_mode(&ofs->config));
-	if (ofs->config.index != ovl_index_def)
-		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
-	if (!ofs->config.uuid)
-		seq_puts(m, ",uuid=off");
-	if (ofs->config.nfs_export != ovl_nfs_export_def)
-		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
-						"on" : "off");
-	if (ofs->config.xino != ovl_xino_def() && !ovl_same_fs(ofs))
-		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
-	if (ofs->config.metacopy != ovl_metacopy_def)
-		seq_printf(m, ",metacopy=%s",
-			   ofs->config.metacopy ? "on" : "off");
-	if (ofs->config.ovl_volatile)
-		seq_puts(m, ",volatile");
-	if (ofs->config.userxattr)
-		seq_puts(m, ",userxattr");
-	return 0;
-}
-
-static int ovl_reconfigure(struct fs_context *fc)
-{
-	struct super_block *sb = fc->root->d_sb;
-	struct ovl_fs *ofs = sb->s_fs_info;
-	struct super_block *upper_sb;
-	int ret = 0;
-
-	if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
-		return -EROFS;
-
-	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
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
@@ -450,262 +266,6 @@ static const struct super_operations ovl_super_operations = {
 	.show_options	= ovl_show_options,
 };
 
-enum {
-	Opt_lowerdir,
-	Opt_upperdir,
-	Opt_workdir,
-	Opt_default_permissions,
-	Opt_redirect_dir,
-	Opt_index,
-	Opt_uuid,
-	Opt_nfs_export,
-	Opt_userxattr,
-	Opt_xino,
-	Opt_metacopy,
-	Opt_volatile,
-};
-
-static const struct constant_table ovl_parameter_bool[] = {
-	{ "on",		true  },
-	{ "off",	false },
-	{}
-};
-
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
-static const struct fs_parameter_spec ovl_parameter_spec[] = {
-	fsparam_string_empty("lowerdir",    Opt_lowerdir),
-	fsparam_string("upperdir",          Opt_upperdir),
-	fsparam_string("workdir",           Opt_workdir),
-	fsparam_flag("default_permissions", Opt_default_permissions),
-	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_redirect_dir),
-	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
-	fsparam_enum("uuid",                Opt_uuid, ovl_parameter_bool),
-	fsparam_enum("nfs_export",          Opt_nfs_export, ovl_parameter_bool),
-	fsparam_flag("userxattr",           Opt_userxattr),
-	fsparam_enum("xino",                Opt_xino, ovl_parameter_xino),
-	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
-	fsparam_flag("volatile",            Opt_volatile),
-	{}
-};
-
-static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	int err = 0;
-	struct fs_parse_result result;
-	struct ovl_fs *ofs = fc->s_fs_info;
-	struct ovl_config *config = &ofs->config;
-	struct ovl_fs_context *ctx = fc->fs_private;
-	int opt;
-
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
-		/*
-		 * On remount overlayfs has always ignored all mount
-		 * options no matter if malformed or not so for
-		 * backwards compatibility we do the same here.
-		 */
-		if (fc->oldapi)
-			return 0;
-
-		/*
-		 * Give us the freedom to allow changing mount options
-		 * with the new mount api in the future. So instead of
-		 * silently ignoring everything we report a proper
-		 * error. This is only visible for users of the new
-		 * mount api.
-		 */
-		return invalfc(fc, "No changes allowed in reconfigure");
-	}
-
-	opt = fs_parse(fc, ovl_parameter_spec, param, &result);
-	if (opt < 0)
-		return opt;
-
-	switch (opt) {
-	case Opt_lowerdir:
-		err = ovl_parse_param_lowerdir(param->string, fc);
-		break;
-	case Opt_upperdir:
-		fallthrough;
-	case Opt_workdir:
-		err = ovl_parse_param_upperdir(param->string, fc,
-					       (Opt_workdir == opt));
-		break;
-	case Opt_default_permissions:
-		config->default_permissions = true;
-		break;
-	case Opt_redirect_dir:
-		config->redirect_mode = result.uint_32;
-		if (config->redirect_mode == OVL_REDIRECT_OFF) {
-			config->redirect_mode = ovl_redirect_always_follow ?
-						OVL_REDIRECT_FOLLOW :
-						OVL_REDIRECT_NOFOLLOW;
-		}
-		ctx->set.redirect = true;
-		break;
-	case Opt_index:
-		config->index = result.uint_32;
-		ctx->set.index = true;
-		break;
-	case Opt_uuid:
-		config->uuid = result.uint_32;
-		break;
-	case Opt_nfs_export:
-		config->nfs_export = result.uint_32;
-		ctx->set.nfs_export = true;
-		break;
-	case Opt_xino:
-		config->xino = result.uint_32;
-		break;
-	case Opt_metacopy:
-		config->metacopy = result.uint_32;
-		ctx->set.metacopy = true;
-		break;
-	case Opt_volatile:
-		config->ovl_volatile = true;
-		break;
-	case Opt_userxattr:
-		config->userxattr = true;
-		break;
-	default:
-		pr_err("unrecognized mount option \"%s\" or missing value\n",
-		       param->key);
-		return -EINVAL;
-	}
-
-	return err;
-}
-
-static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
-				struct ovl_config *config)
-{
-	struct ovl_opt_set set = ctx->set;
-
-	if (ctx->nr_data > 0 && !config->metacopy) {
-		pr_err("lower data-only dirs require metacopy support.\n");
-		return -EINVAL;
-	}
-
-	/* Workdir/index are useless in non-upper mount */
-	if (!config->upperdir) {
-		if (config->workdir) {
-			pr_info("option \"workdir=%s\" is useless in a non-upper mount, ignore\n",
-				config->workdir);
-			kfree(config->workdir);
-			config->workdir = NULL;
-		}
-		if (config->index && set.index) {
-			pr_info("option \"index=on\" is useless in a non-upper mount, ignore\n");
-			set.index = false;
-		}
-		config->index = false;
-	}
-
-	if (!config->upperdir && config->ovl_volatile) {
-		pr_info("option \"volatile\" is meaningless in a non-upper mount, ignoring it.\n");
-		config->ovl_volatile = false;
-	}
-
-	/*
-	 * This is to make the logic below simpler.  It doesn't make any other
-	 * difference, since redirect_dir=on is only used for upper.
-	 */
-	if (!config->upperdir && config->redirect_mode == OVL_REDIRECT_FOLLOW)
-		config->redirect_mode = OVL_REDIRECT_ON;
-
-	/* Resolve metacopy -> redirect_dir dependency */
-	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON) {
-		if (set.metacopy && set.redirect) {
-			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
-			       ovl_redirect_mode(config));
-			return -EINVAL;
-		}
-		if (set.redirect) {
-			/*
-			 * There was an explicit redirect_dir=... that resulted
-			 * in this conflict.
-			 */
-			pr_info("disabling metacopy due to redirect_dir=%s\n",
-				ovl_redirect_mode(config));
-			config->metacopy = false;
-		} else {
-			/* Automatically enable redirect otherwise. */
-			config->redirect_mode = OVL_REDIRECT_ON;
-		}
-	}
-
-	/* Resolve nfs_export -> index dependency */
-	if (config->nfs_export && !config->index) {
-		if (!config->upperdir &&
-		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
-			pr_info("NFS export requires \"redirect_dir=nofollow\" on non-upper mount, falling back to nfs_export=off.\n");
-			config->nfs_export = false;
-		} else if (set.nfs_export && set.index) {
-			pr_err("conflicting options: nfs_export=on,index=off\n");
-			return -EINVAL;
-		} else if (set.index) {
-			/*
-			 * There was an explicit index=off that resulted
-			 * in this conflict.
-			 */
-			pr_info("disabling nfs_export due to index=off\n");
-			config->nfs_export = false;
-		} else {
-			/* Automatically enable index otherwise. */
-			config->index = true;
-		}
-	}
-
-	/* Resolve nfs_export -> !metacopy dependency */
-	if (config->nfs_export && config->metacopy) {
-		if (set.nfs_export && set.metacopy) {
-			pr_err("conflicting options: nfs_export=on,metacopy=on\n");
-			return -EINVAL;
-		}
-		if (set.metacopy) {
-			/*
-			 * There was an explicit metacopy=on that resulted
-			 * in this conflict.
-			 */
-			pr_info("disabling nfs_export due to metacopy=on\n");
-			config->nfs_export = false;
-		} else {
-			/*
-			 * There was an explicit nfs_export=on that resulted
-			 * in this conflict.
-			 */
-			pr_info("disabling metacopy due to nfs_export=on\n");
-			config->metacopy = false;
-		}
-	}
-
-
-	/* Resolve userxattr -> !redirect && !metacopy dependency */
-	if (config->userxattr) {
-		if (set.redirect &&
-		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
-			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
-			       ovl_redirect_mode(config));
-			return -EINVAL;
-		}
-		if (config->metacopy && set.metacopy) {
-			pr_err("conflicting options: userxattr,metacopy=on\n");
-			return -EINVAL;
-		}
-		/*
-		 * Silently disable default setting of redirect and metacopy.
-		 * This shall be the default in the future as well: these
-		 * options must be explicitly enabled if used together with
-		 * userxattr.
-		 */
-		config->redirect_mode = OVL_REDIRECT_NOFOLLOW;
-		config->metacopy = false;
-	}
-
-	return 0;
-}
-
 #define OVL_WORKDIR_NAME "work"
 #define OVL_INDEXDIR_NAME "index"
 
@@ -1758,7 +1318,7 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	return root;
 }
 
-static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
+int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct ovl_fs_context *ctx = fc->fs_private;
@@ -1919,92 +1479,6 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	return err;
 }
 
-static int ovl_get_tree(struct fs_context *fc)
-{
-	return get_tree_nodev(fc, ovl_fill_super);
-}
-
-static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
-{
-	ovl_parse_param_drop_lowerdir(ctx);
-	path_put(&ctx->upper);
-	path_put(&ctx->work);
-	kfree(ctx->lower);
-	kfree(ctx);
-}
-
-static void ovl_free(struct fs_context *fc)
-{
-	struct ovl_fs *ofs = fc->s_fs_info;
-	struct ovl_fs_context *ctx = fc->fs_private;
-
-	/*
-	 * ofs is stored in the fs_context when it is initialized.
-	 * ofs is transferred to the superblock on a successful mount,
-	 * but if an error occurs before the transfer we have to free
-	 * it here.
-	 */
-	if (ofs)
-		ovl_free_fs(ofs);
-
-	if (ctx)
-		ovl_fs_context_free(ctx);
-}
-
-static const struct fs_context_operations ovl_context_ops = {
-	.parse_param = ovl_parse_param,
-	.get_tree    = ovl_get_tree,
-	.reconfigure = ovl_reconfigure,
-	.free        = ovl_free,
-};
-
-/*
- * This is called during fsopen() and will record the user namespace of
- * the caller in fc->user_ns since we've raised FS_USERNS_MOUNT. We'll
- * need it when we actually create the superblock to verify that the
- * process creating the superblock is in the same user namespace as
- * process that called fsopen().
- */
-static int ovl_init_fs_context(struct fs_context *fc)
-{
-	struct ovl_fs_context *ctx;
-	struct ovl_fs *ofs;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
-	if (!ctx)
-		return -ENOMEM;
-
-	/*
-	 * By default we allocate for three lower layers. It's likely
-	 * that it'll cover most users.
-	 */
-	ctx->lower = kmalloc_array(3, sizeof(*ctx->lower), GFP_KERNEL_ACCOUNT);
-	if (!ctx->lower)
-		goto out_err;
-	ctx->capacity = 3;
-
-	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
-	if (!ofs)
-		goto out_err;
-
-	ofs->config.redirect_mode = ovl_redirect_mode_def();
-	ofs->config.index	= ovl_index_def;
-	ofs->config.uuid	= true;
-	ofs->config.nfs_export	= ovl_nfs_export_def;
-	ofs->config.xino	= ovl_xino_def();
-	ofs->config.metacopy	= ovl_metacopy_def;
-
-	fc->s_fs_info		= ofs;
-	fc->fs_private		= ctx;
-	fc->ops			= &ovl_context_ops;
-	return 0;
-
-out_err:
-	ovl_fs_context_free(ctx);
-	return -ENOMEM;
-
-}
-
 static struct file_system_type ovl_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "overlay",

---
base-commit: 62149a745eee03194f025021640c80b84353089b
change-id: 20230625-fs-overlayfs-mount-api-param-993d1caa86ff

