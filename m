Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E1728497
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjFHQIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHQH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713911A;
        Thu,  8 Jun 2023 09:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15FF64EC7;
        Thu,  8 Jun 2023 16:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87AC433EF;
        Thu,  8 Jun 2023 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240473;
        bh=zyvdT0lzmE/fAbsJSGwljB8RsNTQ0E8EQtJfaiAXeBc=;
        h=From:Date:Subject:To:Cc:From;
        b=lYhyBIR+6YnZH9CzKJmyYlZV9/uyyDUo024o5I5l3if2yJo+RJgErDnHmrDPzm6AL
         MNdb3Orh8Qhu/AtT4SSHKfghfBD6Nz+PjGrUEoqpdD34Z6zdD/VFRBpQVPFYicnGOu
         IcxywClHiZqSKJipcIW3BbefdMmDJZzUnJRw9fhioFU0F4ah2szCiSdA9sVFTVFI8L
         HAfG7QYjO2d+LTrCvflGboFJvrd/1I5eOj8tQE553RxyQqNz7Lss3i0EiarRvVJ7SQ
         SXLEy3m8dbM4fpQX23PRGzLFtsYCiNmwFHnHgtLpeHMgt+xrDRVz0mjgTNfijCz7m7
         Fu85/gEdKKaJQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Thu, 08 Jun 2023 18:07:45 +0200
Subject: [PATCH] ovl: port to new mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAND8gWQC/x2NUQrCQAwFr1LybSCuVcSriEi2Zm3A7pakFqX07
 m79e8NjmAVcTMXh0ixgMqtryRX2uwa6nvNTUB+VIVA40ImOmBzLLPbib11DeefpzqNiIOFzpFZ
 SaqHKkV0wGueu3/SBfRLbjtEk6edfvN7W9QdS/r6vgQAAAA==
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=35830; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zyvdT0lzmE/fAbsJSGwljB8RsNTQ0E8EQtJfaiAXeBc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ0/rm+u+z6rotLipcs9mpIN9ptbLj57LOwJw90Lcxd5+5S
 bW3P7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6b+MDPeuzV/NMmXWHt3jUkfnNb
 3NSDLuqxb5lZI9S9iO46+GLS8jw6rPz68LrqqLTfiiyPFgS0OLY+LPstt7f19qT3rhrcIxkQEA
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

For overlayfs specifically we ran into issues where mount(8) passed
multiple lower layers as one big string through fsconfig(). But the
fsconfig() FSCONFIG_SET_STRING option is limited to 256 bytes in
strndup_user(). While this would be fixable by extending the fsconfig()
buffer I'd rather encourage users to append layers via multiple
fsconfig() calls as the interface allows nicely for this. This has also
been requested as a feature before.

With this port to the new mount api the following will be possible:

        fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);

	/* set upper layer */
	fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);

	/* append "/lower2", "/lower3", and "/lower4" */
        fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower3:/lower4", 0);

	/* turn index feature on */
	fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);

	/* append "/lower5" */
        fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);

Specifying ':' would have been rejected so this isn't a regression. And
we can't simply use "lowerdir=/lower" to append on top of existing
layers as "lowerdir=/lower,lowerdir=/other-lower" would make
"/other-lower" the only lower layer so we'd break uapi if we changed
this. So the ':' prefix seems a good compromise.

Users can choose to specify multiple layers at once or individual
layers. A layer is appended if it starts with ":". This requires that
the user has already added at least one layer before. If lowerdir is
specified again without a leading ":" then all previous layers are
dropped and replaced with the new layers. If lowerdir is specified and
empty than all layers are simply dropped.

An additional change is that overlayfs will now parse and resolve layers
right when they are specified in fsconfig() instead of deferring until
super block creation. This allows users to receive early errors.

It also allows users to actually use up to 500 layers something which
was theoretically possible but ended up not working due to the mount
option string passed via mount(2) being too large.

This also allows a more privileged process to set config options for a
lesser privileged process as the creds for fsconfig() and the creds for
fsopen() can differ. We could restrict that they match by enforcing that
the creds of fsopen() and fsconfig() match but I don't see why that
needs to be the case and allows for a good delegation mechanism.

Plus, in the future it means we're able to extend overlayfs mount
options and allow users to specify layers via file descriptors instead
of paths:

	fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);

	/* append */
	fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);

	/* append */
	fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);

	/* clear all layers specified until now */
	fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);

This would be especially nice if users create an overlayfs mount on top
of idmapped layers or just in general private mounts created via
open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
anywhere in the filesystem. But for now just do the minimal thing.

We should probably aim to move more validation into ovl_fs_parse_param()
so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
be done in additional patches later.

Link: https://github.com/util-linux/util-linux/issues/2287 [1]
Link: https://github.com/util-linux/util-linux/issues/1992 [2]
Link: https://bugs.archlinux.org/task/78702 [3]
Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner [4]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---

I'm starting to get the feeling that I stared enough at this and I would
need a fresh set of eyes to review it for any bugs. Plus, Amir seems to
have conflicting series and I would have to rebase anyway so no point in
delaying this any further.
---
 fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 568 insertions(+), 328 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..db22cbde1487 100644
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
@@ -67,6 +69,76 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
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
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
+static const struct fs_parameter_spec ovl_parameter_spec[] = {
+	fsparam_string_empty("lowerdir",    Opt_lowerdir),
+	fsparam_string_empty("upperdir",    Opt_upperdir),
+	fsparam_string_empty("workdir",     Opt_workdir),
+	fsparam_flag("default_permissions", Opt_default_permissions),
+	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_xino),
+	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
+	fsparam_enum("uuid",                Opt_uuid, ovl_parameter_bool),
+	fsparam_enum("nfs_export",          Opt_nfs_export, ovl_parameter_bool),
+	fsparam_flag("userxattr",           Opt_userxattr),
+	fsparam_enum("xino",                Opt_xino, ovl_parameter_bool),
+	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
+	fsparam_flag("volatile",            Opt_volatile),
+	{}
+};
+
+struct ovl_fs_context_layer {
+	char *name;
+	struct path path;
+};
+
+/*
+ * These options imply different behavior when they are explicitly
+ * specified than when they are left in their default state.
+ */
+#define OVL_METACOPY_SET	BIT(0)
+#define OVL_REDIRECT_SET	BIT(1)
+#define OVL_NFS_EXPORT_SET	BIT(2)
+#define OVL_INDEX_SET		BIT(3)
+
+struct ovl_fs_context {
+	struct path upper;
+	struct path work;
+	size_t capacity;
+	size_t nr;
+	u8 set;
+	struct ovl_fs_context_layer *lower;
+};
+
 static void ovl_dentry_release(struct dentry *dentry)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
@@ -394,27 +466,6 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
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
@@ -424,76 +475,8 @@ static const struct super_operations ovl_super_operations = {
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
@@ -517,123 +500,14 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
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
@@ -932,10 +806,6 @@ static int ovl_lower_dir(const char *name, struct path *path,
 	int fh_type;
 	int err;
 
-	err = ovl_mount_dir_noesc(name, path);
-	if (err)
-		return err;
-
 	err = ovl_check_namelen(path, ofs, name);
 	if (err)
 		return err;
@@ -984,9 +854,9 @@ static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 	return ok;
 }
 
-static unsigned int ovl_split_lowerdirs(char *str)
+static size_t ovl_parse_param_split_lowerdirs(char *str)
 {
-	unsigned int ctr = 1;
+	size_t ctr = 1;
 	char *s, *d;
 
 	for (s = d = str;; s++, d++) {
@@ -1104,15 +974,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
 }
 
 static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
-			 struct ovl_layer *upper_layer, struct path *upperpath)
+			 struct ovl_layer *upper_layer,
+			 const struct path *upperpath)
 {
 	struct vfsmount *upper_mnt;
 	int err;
 
-	err = ovl_mount_dir(ofs->config.upperdir, upperpath);
-	if (err)
-		goto out;
-
 	/* Upperdir path should not be r/o */
 	if (__mnt_is_readonly(upperpath->mnt)) {
 		pr_err("upper fs is r/o, try multi-lower layers mount\n");
@@ -1399,46 +1266,37 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 }
 
 static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
-			   const struct path *upperpath)
+			   const struct path *upperpath,
+			   const struct path *workpath)
 {
 	int err;
-	struct path workpath = { };
-
-	err = ovl_mount_dir(ofs->config.workdir, &workpath);
-	if (err)
-		goto out;
 
 	err = -EINVAL;
-	if (upperpath->mnt != workpath.mnt) {
+	if (upperpath->mnt != workpath->mnt) {
 		pr_err("workdir and upperdir must reside under the same mount\n");
-		goto out;
+		return err;
 	}
-	if (!ovl_workdir_ok(workpath.dentry, upperpath->dentry)) {
+	if (!ovl_workdir_ok(workpath->dentry, upperpath->dentry)) {
 		pr_err("workdir and upperdir must be separate subtrees\n");
-		goto out;
+		return err;
 	}
 
-	ofs->workbasedir = dget(workpath.dentry);
+	ofs->workbasedir = dget(workpath->dentry);
 
 	if (ovl_inuse_trylock(ofs->workbasedir)) {
 		ofs->workdir_locked = true;
 	} else {
 		err = ovl_report_in_use(ofs, "workdir");
 		if (err)
-			goto out;
+			return err;
 	}
 
 	err = ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_trap,
 			     "workdir");
 	if (err)
-		goto out;
-
-	err = ovl_make_workdir(sb, ofs, &workpath);
-
-out:
-	path_put(&workpath);
+		return err;
 
-	return err;
+	return ovl_make_workdir(sb, ofs, workpath);
 }
 
 static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
@@ -1592,14 +1450,13 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 }
 
 static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
-			  struct path *stack, unsigned int numlower,
-			  struct ovl_layer *layers)
+			  struct ovl_fs_context *ctx, struct ovl_layer *layers)
 {
 	int err;
 	unsigned int i;
 
 	err = -ENOMEM;
-	ofs->fs = kcalloc(numlower + 1, sizeof(struct ovl_sb), GFP_KERNEL);
+	ofs->fs = kcalloc(ctx->nr + 1, sizeof(struct ovl_sb), GFP_KERNEL);
 	if (ofs->fs == NULL)
 		goto out;
 
@@ -1623,12 +1480,13 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->fs[0].is_lower = false;
 	}
 
-	for (i = 0; i < numlower; i++) {
+	for (i = 0; i < ctx->nr; i++) {
+		struct ovl_fs_context_layer *l = &ctx->lower[i];
 		struct vfsmount *mnt;
 		struct inode *trap;
 		int fsid;
 
-		err = fsid = ovl_get_fsid(ofs, &stack[i]);
+		err = fsid = ovl_get_fsid(ofs, &l->path);
 		if (err < 0)
 			goto out;
 
@@ -1639,11 +1497,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		 * the upperdir/workdir is in fact in-use by our
 		 * upperdir/workdir.
 		 */
-		err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
+		err = ovl_setup_trap(sb, l->path.dentry, &trap, "lowerdir");
 		if (err)
 			goto out;
 
-		if (ovl_is_inuse(stack[i].dentry)) {
+		if (ovl_is_inuse(l->path.dentry)) {
 			err = ovl_report_in_use(ofs, "lowerdir");
 			if (err) {
 				iput(trap);
@@ -1651,7 +1509,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			}
 		}
 
-		mnt = clone_private_mount(&stack[i]);
+		mnt = clone_private_mount(&l->path);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");
@@ -1712,63 +1570,86 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 }
 
 static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
-				const char *lower, unsigned int numlower,
-				struct ovl_fs *ofs, struct ovl_layer *layers)
+					    struct ovl_fs_context *ctx,
+					    struct ovl_fs *ofs,
+					    struct ovl_layer *layers)
 {
 	int err;
-	struct path *stack = NULL;
 	unsigned int i;
 	struct ovl_entry *oe;
+	size_t len;
+	char *lowerdir;
+	struct ovl_fs_context_layer *l;
 
-	if (!ofs->config.upperdir && numlower == 1) {
+	if (!ofs->config.upperdir && ctx->nr == 1) {
 		pr_err("at least 2 lowerdir are needed while upperdir nonexistent\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	stack = kcalloc(numlower, sizeof(struct path), GFP_KERNEL);
-	if (!stack)
-		return ERR_PTR(-ENOMEM);
-
 	err = -EINVAL;
-	for (i = 0; i < numlower; i++) {
-		err = ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack_depth);
+	len = 0;
+	for (i = 0; i < ctx->nr; i++) {
+		l = &ctx->lower[i];
+
+		err = ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stack_depth);
 		if (err)
-			goto out_err;
+			return ERR_PTR(err);
 
-		lower = strchr(lower, '\0') + 1;
+		len += strlen(l->name);
 	}
 
 	err = -EINVAL;
 	sb->s_stack_depth++;
 	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
 		pr_err("maximum fs stacking depth exceeded\n");
-		goto out_err;
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * Create a string of all lower layers that we store in
+	 * ofs->config.lowerdir which we can display to userspace in
+	 * mount options. For example, this assembles "/lower1",
+	 * "/lower2" into "/lower1:/lower2".
+	 *
+	 * We need to make sure we add a ':'. Thus, we need to account
+	 * for the separators when allocating space when multiple layers
+	 * are specified. That should be easy since we know that ctx->nr
+	 * >= 1. So we know that ctx->nr - 1 will be correct for the
+	 * base case ctx->nr == 1 and all other cases.
+	 */
+	len += ctx->nr - 1;
+	len++; /* and leave room for \0 */
+	lowerdir = kzalloc(len, GFP_KERNEL_ACCOUNT);
+	if (!lowerdir)
+		return ERR_PTR(-ENOMEM);
+
+	ofs->config.lowerdir = lowerdir;
+	for (i = 0; i < ctx->nr; i++) {
+		l = &ctx->lower[i];
+
+		len = strlen(l->name);
+		memcpy(lowerdir, l->name, len);
+		if ((ctx->nr > 1) && ((i + 1) != ctx->nr))
+			lowerdir[len++] = ':';
+		lowerdir += len;
 	}
 
-	err = ovl_get_layers(sb, ofs, stack, numlower, layers);
+	err = ovl_get_layers(sb, ofs, ctx, layers);
 	if (err)
-		goto out_err;
+		return ERR_PTR(err);
 
 	err = -ENOMEM;
-	oe = ovl_alloc_entry(numlower);
+	oe = ovl_alloc_entry(ctx->nr);
 	if (!oe)
-		goto out_err;
+		return ERR_PTR(err);
 
-	for (i = 0; i < numlower; i++) {
-		oe->lowerstack[i].dentry = dget(stack[i].dentry);
-		oe->lowerstack[i].layer = &ofs->layers[i+1];
+	for (i = 0; i < ctx->nr; i++) {
+		l = &ctx->lower[i];
+		oe->lowerstack[i].dentry = dget(l->path.dentry);
+		oe->lowerstack[i].layer = &ofs->layers[i + 1];
 	}
 
-out:
-	for (i = 0; i < numlower; i++)
-		path_put(&stack[i]);
-	kfree(stack);
-
 	return oe;
-
-out_err:
-	oe = ERR_PTR(err);
-	goto out;
 }
 
 /*
@@ -1878,72 +1759,354 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
 	ovl_dentry_update_reval(root, upperdentry, DCACHE_OP_WEAK_REVALIDATE);
+	/*
+	 * We're going to put upper path when we call
+	 * fs_context_operations->free() take an additional
+	 * reference so we can just call path_put().
+	 */
+	dget(upperdentry);
 
 	return root;
 }
 
-static int ovl_fill_super(struct super_block *sb, void *data, int silent)
+static inline void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
+{
+	for (size_t nr = 0; nr < ctx->nr; nr++) {
+		path_put(&ctx->lower[nr].path);
+		kfree(ctx->lower[nr].name);
+		ctx->lower[nr].name = NULL;
+	}
+	ctx->nr = 0;
+}
+
+/*
+ * Parse lowerdir= mount option:
+ *
+ * (1) lowerdir=/lower1:/lower2:/lower3
+ *     Set "/lower1", "/lower2", and "/lower3" as lower layers. Any
+ *     existing lower layers are replaced.
+ * (2) lowerdir=:/lower4
+ *     Append "/lower4" to current stack of lower layers. This requires
+ *     that there already is at least one lower layer configured.
+ */
+static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
+{
+	int err;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs_context_layer *l;
+	char *dup = NULL, *dup_iter;
+	size_t nr_lower = 0, nr = 0;
+	bool append = false;
+
+	/* Enforce that users are forced to specify a single ':'. */
+	if (strncmp(name, "::", 2) == 0)
+		return -EINVAL;
+
+	/*
+	 * Ensure we're backwards compatible with mount(2)
+	 * by allowing relative paths.
+	 */
+
+	/* drop all existing lower layers */
+	if (!*name) {
+		ovl_parse_param_drop_lowerdir(ctx);
+		return 0;
+	}
+
+	if (*name == ':') {
+		/*
+		 * If users want to append a layer enforce that they
+		 * have already specified a first layer before. It's
+		 * better to be strict.
+		 */
+		if (ctx->nr == 0)
+			return -EINVAL;
+
+		/*
+		 * Drop the leading. We'll create the final mount option
+		 * string for the lower layers when we create the superblock.
+		 */
+		name++;
+		append = true;
+	}
+
+	dup = kstrdup(name, GFP_KERNEL);
+	if (!dup)
+		return -ENOMEM;
+
+	err = -EINVAL;
+	nr_lower = ovl_parse_param_split_lowerdirs(dup);
+	if ((nr_lower > OVL_MAX_STACK) ||
+	    (append && (size_add(ctx->nr, nr_lower) > OVL_MAX_STACK))) {
+		pr_err("too many lower directories, limit is %d\n", OVL_MAX_STACK);
+		goto out_err;
+	}
+
+	if (!append)
+		ovl_parse_param_drop_lowerdir(ctx);
+
+	/*
+	 * (1) append
+	 *
+	 * We want nr <= nr_lower <= capacity We know nr > 0 and nr <=
+	 * capacity. If nr == 0 this wouldn't be append. If nr +
+	 * nr_lower is <= capacity then nr <= nr_lower <= capacity
+	 * already holds. If nr + nr_lower exceeds capacity, we realloc.
+	 *
+	 * (2) replace
+	 *
+	 * Ensure we're backwards compatible with mount(2) which allows
+	 * "lowerdir=/a:/b:/c,lowerdir=/d:/e:/f" causing the last
+	 * specified lowerdir mount option to win.
+	 *
+	 * We want nr <= nr_lower <= capacity We know either (i) nr == 0
+	 * or (ii) nr > 0. We also know nr_lower > 0. The capacity
+	 * could've been changed multiple times already so we only know
+	 * nr <= capacity. If nr + nr_lower > capacity we realloc,
+	 * otherwise nr <= nr_lower <= capacity holds already.
+	 */
+	nr_lower += ctx->nr;
+	if (nr_lower > ctx->capacity) {
+		err = -ENOMEM;
+		l = krealloc_array(ctx->lower, nr_lower, sizeof(*ctx->lower),
+				   GFP_KERNEL_ACCOUNT);
+		if (!l)
+			goto out_err;
+
+		ctx->lower = l;
+		ctx->capacity = nr_lower;
+	}
+
+	/* By (1) and (2) we know nr <= nr_lower <= capacity. */
+	dup_iter = dup;
+	for (nr = ctx->nr; nr < nr_lower; nr++) {
+		l = &ctx->lower[nr];
+
+		err = ovl_mount_dir_noesc(dup_iter, &l->path);
+		if (err)
+			goto out_put;
+
+		err = -ENOMEM;
+		l->name = kstrdup(dup_iter, GFP_KERNEL_ACCOUNT);
+		if (!l->name)
+			goto out_put;
+
+		dup_iter = strchr(dup_iter, '\0') + 1;
+	}
+	ctx->nr = nr_lower;
+	kfree(dup);
+	return 0;
+
+out_put:
+	/*
+	 * We know nr >= ctx->nr < nr_lower. If we failed somewhere
+	 * we want to undo until nr == ctx->nr. This is correct for
+	 * both ctx->nr == 0 and ctx->nr > 0.
+	 */
+	for (; nr >= ctx->nr; nr--) {
+		l = &ctx->lower[nr];
+		kfree(l->name);
+		l->name = NULL;
+		path_put(&l->path);
+
+		/* don't overflow */
+		if (nr == 0)
+			break;
+	}
+
+out_err:
+	kfree(dup);
+
+	/* Intentionally don't realloc to a smaller size. */
+	return err;
+}
+
+static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
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
+		err = ovl_parse_param_lowerdir(param->string, fc);
+		break;
+	case Opt_upperdir:
+		err = ovl_mount_dir(param->string, &path);
+		if (err)
+			break;
+
+		/*
+		 * Check whether upper path is read-only here to report
+		 * failures early. Don't forget to recheck when the
+		 * superblock is created as the mount attributes could
+		 * change.
+		 */
+		if (__mnt_is_readonly(path.mnt)) {
+			path_put(&path);
+			err = -EINVAL;
+			break;
+		}
+
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			path_put(&path);
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->upperdir);
+		config->upperdir = dup;
+		path_put(&ctx->upper);
+		ctx->upper = path;
+		break;
+	case Opt_workdir:
+		err = ovl_mount_dir(param->string, &path);
+		if (err)
+			break;
+		dup = kstrdup(param->string, GFP_KERNEL);
+		if (!dup) {
+			path_put(&path);
+			err = -ENOMEM;
+			break;
+		}
+
+		kfree(config->workdir);
+		config->workdir = dup;
+		path_put(&ctx->work);
+		ctx->work = path;
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
 {
-	struct path upperpath = { };
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs_context *ctx = fc->fs_private;
+
 	struct dentry *root_dentry;
 	struct ovl_entry *oe;
-	struct ovl_fs *ofs;
 	struct ovl_layer *layers;
 	struct cred *cred;
-	char *splitlower = NULL;
-	unsigned int numlower;
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
 
+	/*
+	 * Check ctx->nr instead of ofs->config.lowerdir since we're
+	 * going to set ofs->config.lowerdir here after we know that the
+	 * user specified all layers.
+	 */
 	err = -EINVAL;
-	if (!ofs->config.lowerdir) {
-		if (!silent)
+	if (ctx->nr == 0) {
+		if (fc->sb_flags & SB_SILENT)
 			pr_err("missing 'lowerdir'\n");
 		goto out_err;
 	}
 
 	err = -ENOMEM;
-	splitlower = kstrdup(ofs->config.lowerdir, GFP_KERNEL);
-	if (!splitlower)
-		goto out_err;
-
-	err = -EINVAL;
-	numlower = ovl_split_lowerdirs(splitlower);
-	if (numlower > OVL_MAX_STACK) {
-		pr_err("too many lower directories, limit is %d\n",
-		       OVL_MAX_STACK);
-		goto out_err;
-	}
-
-	err = -ENOMEM;
-	layers = kcalloc(numlower + 1, sizeof(struct ovl_layer), GFP_KERNEL);
+	layers = kcalloc(ctx->nr + 1, sizeof(struct ovl_layer), GFP_KERNEL);
 	if (!layers)
 		goto out_err;
 
@@ -1975,7 +2138,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 			goto out_err;
 		}
 
-		err = ovl_get_upper(sb, ofs, &layers[0], &upperpath);
+		err = ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
 		if (err)
 			goto out_err;
 
@@ -1989,7 +2152,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 			}
 		}
 
-		err = ovl_get_workdir(sb, ofs, &upperpath);
+		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
 		if (err)
 			goto out_err;
 
@@ -1999,7 +2162,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
-	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
+	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
 		goto out_err;
@@ -2014,7 +2177,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	if (!ovl_force_readonly(ofs) && ofs->config.index) {
-		err = ovl_get_indexdir(sb, ofs, oe, &upperpath);
+		err = ovl_get_indexdir(sb, ofs, oe, &ctx->upper);
 		if (err)
 			goto out_free_oe;
 
@@ -2055,13 +2218,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
-	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
+	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
 	if (!root_dentry)
 		goto out_free_oe;
 
-	mntput(upperpath.mnt);
-	kfree(splitlower);
-
 	sb->s_root = root_dentry;
 
 	return 0;
@@ -2070,25 +2230,105 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
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
+{
+	ovl_parse_param_drop_lowerdir(ctx);
+	path_put(&ctx->upper);
+	path_put(&ctx->work);
+	kfree(ctx->lower);
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
+	struct ovl_fs_context *ctx = NULL;
+	struct ovl_fs *ofs = NULL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		goto out_err;
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
 

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230605-fs-overlayfs-mount_api-20ea8b04eff4

