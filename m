Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89FE729EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjFIPmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbjFIPmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9483596;
        Fri,  9 Jun 2023 08:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ECE06101B;
        Fri,  9 Jun 2023 15:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83457C433A4;
        Fri,  9 Jun 2023 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325329;
        bh=VUxLOpW+qqH6vobWpOL4ksabrx3fgMBOuFFvM2sT6T4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Qynb5Wge72ixUryd9P8AOvTHPLCosVzhnnLfNVFdVchOWTKM4WxuC9A46ap4DbLAh
         Yt3+YproQ3Tko9XexoEsbw8ylkS21XSD7vLrZMHD6KDkyDanjTHQZB1UCOFaV2hsEj
         qxkhMpGxr2wKtlA47zMZQCzKmj9RC7GxJYhwrED+DKzfFgj6KgDk7inRUKRpYHIijW
         S4+z0PwBmP2fvMsiMeSaVhzuPSiShi7u6u6l74PgBnahOoDnDf9BcjaBuQYODAKIdp
         2ZKXkCFVM4qoAzsxaBwrMv07q88x72dNK08UkWiau995nfEYOen89qZDMKhMkMQ8ep
         tEqPlrlotp+QA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 09 Jun 2023 17:41:49 +0200
Subject: [PATCH v2 2/2] ovl: modify layer parameter parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v2-2-3da91c97e0c0@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=29016; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VUxLOpW+qqH6vobWpOL4ksabrx3fgMBOuFFvM2sT6T4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ0e/goTnMvMUy7xf5nrlK9kd/nQIE5JiJrw+6LC13Sn/Pp
 nfPhjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYzGf4K/NcIeDBK+cNciZHX5qwz5
 NVXDG3O3rjRBFf55Uv96wR2cfI8P7SEnYvZwWj0791lLg+TMzfM4vhspnD4XbpVW8fCX0WZAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We ran into issues where mount(8) passed multiple lower layers as one
big string through fsconfig(). But the fsconfig() FSCONFIG_SET_STRING
option is limited to 256 bytes in strndup_user(). While this would be
fixable by extending the fsconfig() buffer I'd rather encourage users to
append layers via multiple fsconfig() calls as the interface allows
nicely for this. This has also been requested as a feature before.

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

Link: https://github.com/util-linux/util-linux/issues/2287
Link: https://github.com/util-linux/util-linux/issues/1992
Link: https://bugs.archlinux.org/task/78702
Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/Makefile       |   2 +-
 fs/overlayfs/layer_params.c | 288 ++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/ovl_entry.h    |  30 ++++
 fs/overlayfs/super.c        | 328 +++++++++++++++-----------------------------
 4 files changed, 431 insertions(+), 217 deletions(-)

diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
index 9164c585eb2f..a3ad81c2e64e 100644
--- a/fs/overlayfs/Makefile
+++ b/fs/overlayfs/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_OVERLAY_FS) += overlay.o
 
 overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
-		copy_up.o export.o
+		copy_up.o export.o layer_params.o
diff --git a/fs/overlayfs/layer_params.c b/fs/overlayfs/layer_params.c
new file mode 100644
index 000000000000..29907afc9d0d
--- /dev/null
+++ b/fs/overlayfs/layer_params.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+#include "overlayfs.h"
+
+static size_t ovl_parse_param_split_lowerdirs(char *str)
+{
+	size_t ctr = 1;
+	char *s, *d;
+
+	for (s = d = str;; s++, d++) {
+		if (*s == '\\') {
+			s++;
+		} else if (*s == ':') {
+			*d = '\0';
+			ctr++;
+			continue;
+		}
+		*d = *s;
+		if (!*s)
+			break;
+	}
+	return ctr;
+}
+
+static int ovl_mount_dir_noesc(const char *name, struct path *path)
+{
+	int err = -EINVAL;
+
+	if (!*name) {
+		pr_err("empty lowerdir\n");
+		goto out;
+	}
+	err = kern_path(name, LOOKUP_FOLLOW, path);
+	if (err) {
+		pr_err("failed to resolve '%s': %i\n", name, err);
+		goto out;
+	}
+	err = -EINVAL;
+	if (ovl_dentry_weird(path->dentry)) {
+		pr_err("filesystem on '%s' not supported\n", name);
+		goto out_put;
+	}
+	if (!d_is_dir(path->dentry)) {
+		pr_err("'%s' not a directory\n", name);
+		goto out_put;
+	}
+	return 0;
+
+out_put:
+	path_put_init(path);
+out:
+	return err;
+}
+
+static void ovl_unescape(char *s)
+{
+	char *d = s;
+
+	for (;; s++, d++) {
+		if (*s == '\\')
+			s++;
+		*d = *s;
+		if (!*s)
+			break;
+	}
+}
+
+static int ovl_mount_dir(const char *name, struct path *path)
+{
+	int err = -ENOMEM;
+	char *tmp = kstrdup(name, GFP_KERNEL);
+
+	if (tmp) {
+		ovl_unescape(tmp);
+		err = ovl_mount_dir_noesc(tmp, path);
+
+		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
+			pr_err("filesystem on '%s' not supported as upperdir\n",
+			       tmp);
+			path_put_init(path);
+			err = -EINVAL;
+		}
+		kfree(tmp);
+	}
+	return err;
+}
+
+int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
+			     bool workdir)
+{
+	int err;
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_config *config = &ofs->config;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct path path;
+	char *dup;
+
+	err = ovl_mount_dir(name, &path);
+	if (err)
+		return err;
+
+	/*
+	 * Check whether upper path is read-only here to report failures
+	 * early. Don't forget to recheck when the superblock is created
+	 * as the mount attributes could change.
+	 */
+	if (__mnt_is_readonly(path.mnt)) {
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	dup = kstrdup(name, GFP_KERNEL);
+	if (!dup) {
+		path_put(&path);
+		return -ENOMEM;
+	}
+
+	if (workdir) {
+		kfree(config->workdir);
+		config->workdir = dup;
+		path_put(&ctx->work);
+		ctx->work = path;
+	} else {
+		kfree(config->upperdir);
+		config->upperdir = dup;
+		path_put(&ctx->upper);
+		ctx->upper = path;
+	}
+	return 0;
+}
+
+void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
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
+int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
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
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index fd11fe6d6d45..269a9a6f177b 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -85,6 +85,36 @@ struct ovl_fs {
 	errseq_t errseq;
 };
 
+#define OVL_MAX_STACK 500
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
+int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
+			     bool workdir);
+int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
+void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
+
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
 {
 	return ofs->layers[0].mnt;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ceaf05743f45..35c61a1d0886 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -27,8 +27,6 @@ MODULE_LICENSE("GPL");
 
 struct ovl_dir_cache;
 
-#define OVL_MAX_STACK 500
-
 static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
 module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
 MODULE_PARM_DESC(redirect_dir,
@@ -97,8 +95,11 @@ static const struct constant_table ovl_parameter_xino[] = {
 	{}
 };
 
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
 static const struct fs_parameter_spec ovl_parameter_spec[] = {
-	fsparam_string("lowerdir",          Opt_lowerdir),
+	fsparam_string_empty("lowerdir",    Opt_lowerdir),
 	fsparam_string("upperdir",          Opt_upperdir),
 	fsparam_string("workdir",           Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
@@ -113,15 +114,6 @@ static const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
-#define OVL_METACOPY_SET	BIT(0)
-#define OVL_REDIRECT_SET	BIT(1)
-#define OVL_NFS_EXPORT_SET	BIT(2)
-#define OVL_INDEX_SET		BIT(3)
-
-struct ovl_fs_context {
-	u8 set;
-};
-
 static void ovl_dentry_release(struct dentry *dentry)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
@@ -706,69 +698,6 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	goto out_unlock;
 }
 
-static void ovl_unescape(char *s)
-{
-	char *d = s;
-
-	for (;; s++, d++) {
-		if (*s == '\\')
-			s++;
-		*d = *s;
-		if (!*s)
-			break;
-	}
-}
-
-static int ovl_mount_dir_noesc(const char *name, struct path *path)
-{
-	int err = -EINVAL;
-
-	if (!*name) {
-		pr_err("empty lowerdir\n");
-		goto out;
-	}
-	err = kern_path(name, LOOKUP_FOLLOW, path);
-	if (err) {
-		pr_err("failed to resolve '%s': %i\n", name, err);
-		goto out;
-	}
-	err = -EINVAL;
-	if (ovl_dentry_weird(path->dentry)) {
-		pr_err("filesystem on '%s' not supported\n", name);
-		goto out_put;
-	}
-	if (!d_is_dir(path->dentry)) {
-		pr_err("'%s' not a directory\n", name);
-		goto out_put;
-	}
-	return 0;
-
-out_put:
-	path_put_init(path);
-out:
-	return err;
-}
-
-static int ovl_mount_dir(const char *name, struct path *path)
-{
-	int err = -ENOMEM;
-	char *tmp = kstrdup(name, GFP_KERNEL);
-
-	if (tmp) {
-		ovl_unescape(tmp);
-		err = ovl_mount_dir_noesc(tmp, path);
-
-		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
-			pr_err("filesystem on '%s' not supported as upperdir\n",
-			       tmp);
-			path_put_init(path);
-			err = -EINVAL;
-		}
-		kfree(tmp);
-	}
-	return err;
-}
-
 static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
 			     const char *name)
 {
@@ -789,10 +718,6 @@ static int ovl_lower_dir(const char *name, struct path *path,
 	int fh_type;
 	int err;
 
-	err = ovl_mount_dir_noesc(name, path);
-	if (err)
-		return err;
-
 	err = ovl_check_namelen(path, ofs, name);
 	if (err)
 		return err;
@@ -841,26 +766,6 @@ static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 	return ok;
 }
 
-static unsigned int ovl_split_lowerdirs(char *str)
-{
-	unsigned int ctr = 1;
-	char *s, *d;
-
-	for (s = d = str;; s++, d++) {
-		if (*s == '\\') {
-			s++;
-		} else if (*s == ':') {
-			*d = '\0';
-			ctr++;
-			continue;
-		}
-		*d = *s;
-		if (!*s)
-			break;
-	}
-	return ctr;
-}
-
 static int ovl_own_xattr_get(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, void *buffer, size_t size)
@@ -961,15 +866,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
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
@@ -1256,46 +1158,37 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
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
@@ -1449,14 +1342,13 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
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
 
@@ -1480,12 +1372,13 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
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
 
@@ -1496,11 +1389,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
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
@@ -1508,7 +1401,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			}
 		}
 
-		mnt = clone_private_mount(&stack[i]);
+		mnt = clone_private_mount(&l->path);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");
@@ -1569,63 +1462,86 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
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
@@ -1735,6 +1651,12 @@ static struct dentry *ovl_get_root(struct super_block *sb,
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
@@ -1746,8 +1668,6 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct ovl_fs *ofs = fc->s_fs_info;
 	struct ovl_config *config = &ofs->config;
 	struct ovl_fs_context *ctx = fc->fs_private;
-	struct path path;
-	char *dup;
 	int opt;
 	char *sval;
 
@@ -1765,37 +1685,13 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case Opt_lowerdir:
-		dup = kstrdup(param->string, GFP_KERNEL);
-		if (!dup) {
-			path_put(&path);
-			err = -ENOMEM;
-			break;
-		}
-
-		kfree(config->lowerdir);
-		config->lowerdir = dup;
+		err = ovl_parse_param_lowerdir(param->string, fc);
 		break;
 	case Opt_upperdir:
-		dup = kstrdup(param->string, GFP_KERNEL);
-		if (!dup) {
-			path_put(&path);
-			err = -ENOMEM;
-			break;
-		}
-
-		kfree(config->upperdir);
-		config->upperdir = dup;
-		break;
+		fallthrough;
 	case Opt_workdir:
-		dup = kstrdup(param->string, GFP_KERNEL);
-		if (!dup) {
-			path_put(&path);
-			err = -ENOMEM;
-			break;
-		}
-
-		kfree(config->workdir);
-		config->workdir = dup;
+		err = ovl_parse_param_upperdir(param->string, fc,
+					       (Opt_workdir == opt));
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;
@@ -1873,13 +1769,11 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct ovl_fs_context *ctx = fc->fs_private;
-	struct path upperpath = {};
+
 	struct dentry *root_dentry;
 	struct ovl_entry *oe;
 	struct ovl_layer *layers;
 	struct cred *cred;
-	char *splitlower = NULL;
-	unsigned int numlower;
 	int err;
 
 	err = -EIO;
@@ -1898,28 +1792,20 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto out_err;
 
+	/*
+	 * Check ctx->nr instead of ofs->config.lowerdir since we're
+	 * going to set ofs->config.lowerdir here after we know that the
+	 * user specified all layers.
+	 */
 	err = -EINVAL;
-	if (!ofs->config.lowerdir) {
+	if (ctx->nr == 0) {
 		if (fc->sb_flags & SB_SILENT)
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
 
@@ -1951,7 +1837,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto out_err;
 		}
 
-		err = ovl_get_upper(sb, ofs, &layers[0], &upperpath);
+		err = ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
 		if (err)
 			goto out_err;
 
@@ -1965,7 +1851,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			}
 		}
 
-		err = ovl_get_workdir(sb, ofs, &upperpath);
+		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
 		if (err)
 			goto out_err;
 
@@ -1975,7 +1861,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
-	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
+	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
 		goto out_err;
@@ -1990,7 +1876,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	if (!ovl_force_readonly(ofs) && ofs->config.index) {
-		err = ovl_get_indexdir(sb, ofs, oe, &upperpath);
+		err = ovl_get_indexdir(sb, ofs, oe, &ctx->upper);
 		if (err)
 			goto out_free_oe;
 
@@ -2031,13 +1917,10 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -2056,6 +1939,10 @@ static int ovl_get_tree(struct fs_context *fc)
 
 static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
 {
+	ovl_parse_param_drop_lowerdir(ctx);
+	path_put(&ctx->upper);
+	path_put(&ctx->work);
+	kfree(ctx->lower);
 	kfree(ctx);
 }
 
@@ -2100,6 +1987,15 @@ static int ovl_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		goto out_err;
 
+	/*
+	 * By default we allocate for three lower layers. It's likely
+	 * that it'll cover most users.
+	 */
+	ctx->lower = kmalloc_array(3, sizeof(*ctx->lower), GFP_KERNEL_ACCOUNT);
+	if (!ctx->lower)
+		goto out_err;
+	ctx->capacity = 3;
+
 	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
 	if (!ofs)
 		goto out_err;

-- 
2.34.1

