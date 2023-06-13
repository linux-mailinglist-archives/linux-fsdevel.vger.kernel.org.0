Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1672E635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbjFMOuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbjFMOtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007619BC;
        Tue, 13 Jun 2023 07:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FAF6364A;
        Tue, 13 Jun 2023 14:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD22C433F2;
        Tue, 13 Jun 2023 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686667776;
        bh=6ASy+MOp7tAn7rzcvmLybrlXz5CPjUFSAqv9O9MzpYQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JqsqsaHw2/f/GpzWfIlfnuKIiD6c4lzeLlI+yY85StJVBnLl31Bcx7T//TXU0auhv
         sNogGCSCywl/BBoOUDc345/EJmYNOtBRilbRUpLF0BHxgf+qPNNq6prqS3suHP9FHp
         2qZAqH0fCEShpPVuLCmJ9yr4zBldNKsAAF9ZaiJeBr+f2tT6Q9gPjTaDWJjog+iS6F
         W9lkzk6wuiVVrgyrnouYlii2tPkj21zADEJIplV7fMpdPg8ZOlXpvVj+BMNDccjqDK
         dJgStytAfoG8SopgplpOhOZoCHXMUBRlEVhH+vySwn5KqpKFwG/v3x2OesmZmgEkUq
         rNWf+4sW84gIg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 13 Jun 2023 16:49:18 +0200
Subject: [PATCH v3 3/3] ovl: change layer mount option handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v3-3-730d9646b27d@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=37512; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6ASy+MOp7tAn7rzcvmLybrlXz5CPjUFSAqv9O9MzpYQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0NP4qfrHxSsPL6aKtk4WfK3JUXN/7TumDdLLZF2XdJdLT
 p/640VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR/bsZGZpupK+PiLuzK+mUeb3oo7
 q7b5+d5dgb3hzZ+mqVe0+8zXNGhkcvn50IZ9rR57AgxyaxepreLuM/tntPfQn3yE2rqnpfwggA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

This is now also rebased on top of the lazy lowerdata lookup which
allows the specificatin of data only layers using the new "::" syntax.

The rules are simple. A data only layers cannot be followed by any
regular layers and data layers must be preceeded by at least one regular
layer.

Parsing the lowerdir mount option must change because of this. The
original patchset used the old lowerdir parsing function to split a
lowerdir mount option string such as:

        lowerdir=/lower1:/lower2::/lower3::/lower4

simply replacing each non-escaped ":" by "\0". So sequences of
non-escaped ":" were counted as layers. For example, the previous
lowerdir mount option above would've counted 6 layers instead of 4 and a
lowerdir mount option such as:

        lowerdir="/lower1:/lower2::/lower3::/lower4:::::::::::::::::::::::::::"

would be counted as 33 layers. Other than being ugly this didn't matter
much because kern_path() would reject the first "\0" layer. However,
this overcounting of layers becomes problematic when we base allocations
on it where we very much only want to allocate space for 4 layers
instead of 33.

So the new parsing function rejects non-escaped sequences of colons
other than ":" and "::" immediately instead of relying on kern_path().

Link: https://github.com/util-linux/util-linux/issues/2287
Link: https://github.com/util-linux/util-linux/issues/1992
Link: https://bugs.archlinux.org/task/78702
Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/Makefile    |   2 +-
 fs/overlayfs/overlayfs.h |  23 +++
 fs/overlayfs/ovl_entry.h |   3 +-
 fs/overlayfs/params.c    | 388 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/super.c     | 376 +++++++++++++++------------------------------
 5 files changed, 534 insertions(+), 258 deletions(-)

diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
index 9164c585eb2f..4e173d56b11f 100644
--- a/fs/overlayfs/Makefile
+++ b/fs/overlayfs/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_OVERLAY_FS) += overlay.o
 
 overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
-		copy_up.o export.o
+		copy_up.o export.o params.o
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index fcac4e2c56ab..7659ea6e02cb 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -119,6 +119,29 @@ struct ovl_fh {
 #define OVL_FH_FID_OFFSET	(OVL_FH_WIRE_OFFSET + \
 				 offsetof(struct ovl_fb, fid))
 
+/* params.c */
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
+	u8 set;
+	struct ovl_fs_context_layer *lower;
+};
+
+int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
+			     bool workdir);
+int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
+void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
+
 extern const char *const ovl_xattr_table[][2];
 static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 {
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index c72433c06006..7888ab33730b 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -6,7 +6,6 @@
  */
 
 struct ovl_config {
-	char *lowerdir;
 	char *upperdir;
 	char *workdir;
 	bool default_permissions;
@@ -41,6 +40,7 @@ struct ovl_layer {
 	int idx;
 	/* One fsid per unique underlying sb (upper fsid == 0) */
 	int fsid;
+	char *name;
 };
 
 /*
@@ -101,7 +101,6 @@ struct ovl_fs {
 	errseq_t errseq;
 };
 
-
 /* Number of lower layers, not including data-only layers */
 static inline unsigned int ovl_numlowerlayer(struct ovl_fs *ofs)
 {
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
new file mode 100644
index 000000000000..a1606af1613f
--- /dev/null
+++ b/fs/overlayfs/params.c
@@ -0,0 +1,388 @@
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
+static ssize_t ovl_parse_param_split_lowerdirs(char *str)
+{
+	ssize_t nr_layers = 1, nr_colons = 0;
+	char *s, *d;
+
+	for (s = d = str;; s++, d++) {
+		if (*s == '\\') {
+			s++;
+		} else if (*s == ':') {
+			bool next_colon = (*(s + 1) == ':');
+
+			nr_colons++;
+			if (nr_colons == 2 && next_colon) {
+				pr_err("only single ':' or double '::' sequences of unescaped colons in lowerdir mount option allowed.\n");
+				return -EINVAL;
+			}
+			/* count layers, not colons */
+			if (!next_colon)
+				nr_layers++;
+
+			*d = '\0';
+			continue;
+		}
+
+		*d = *s;
+		if (!*s) {
+			/* trailing colons */
+			if (nr_colons) {
+				pr_err("unescaped trailing colons in lowerdir mount option.\n");
+				return -EINVAL;
+			}
+			break;
+		}
+		nr_colons = 0;
+	}
+
+	return nr_layers;
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
+	ctx->nr_data = 0;
+}
+
+/*
+ * Parse lowerdir= mount option:
+ *
+ * (1) lowerdir=/lower1:/lower2:/lower3::/data1::/data2
+ *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
+ *     "/data1" and "/data2" as data lower layers. Any existing lower
+ *     layers are replaced.
+ * (2) lowerdir=:/lower4
+ *     Append "/lower4" to current stack of lower layers. This requires
+ *     that there already is at least one lower layer configured.
+ * (3) lowerdir=::/lower5
+ *     Append data "/lower5" as data lower layer. This requires that
+ *     there's at least one regular lower layer present.
+ */
+int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
+{
+	int err;
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs_context_layer *l;
+	char *dup = NULL, *dup_iter;
+	ssize_t nr_lower = 0, nr = 0, nr_data = 0;
+	bool append = false, data_layer = false;
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
+	if (strncmp(name, "::", 2) == 0) {
+		/*
+		 * This is a data layer.
+		 * There must be at least one regular lower layer
+		 * specified.
+		 */
+		if (ctx->nr == 0) {
+			pr_err("data lower layers without regular lower layers not allowed");
+			return -EINVAL;
+		}
+
+		/* Skip the leading "::". */
+		name += 2;
+		data_layer = true;
+		/*
+		 * A data layer is automatically an append as there
+		 * must've been at least one regular lower layer.
+		 */
+		append = true;
+	} else if (*name == ':') {
+		/*
+		 * This is a regular lower layer.
+		 * If users want to append a layer enforce that they
+		 * have already specified a first layer before. It's
+		 * better to be strict.
+		 */
+		if (ctx->nr == 0) {
+			pr_err("cannot append layer if no previous layer has been specified");
+			return -EINVAL;
+		}
+
+		/*
+		 * Once a sequence of data layers has started regular
+		 * lower layers are forbidden.
+		 */
+		if (ctx->nr_data > 0) {
+			pr_err("regular lower layers cannot follow data lower layers");
+			return -EINVAL;
+		}
+
+		/* Skip the leading ":". */
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
+	if (nr_lower < 0)
+		goto out_err;
+
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
+	/*
+	 *   (3) By (1) and (2) we know nr <= nr_lower <= capacity.
+	 *   (4) If ctx->nr == 0 => replace
+	 *       We have verified above that the lowerdir mount option
+	 *       isn't an append, i.e., the lowerdir mount option
+	 *       doesn't start with ":" or "::".
+	 * (4.1) The lowerdir mount options only contains regular lower
+	 *       layers ":".
+	 *       => Nothing to verify.
+	 * (4.2) The lowerdir mount options contains regular ":" and
+	 *       data "::" layers.
+	 *       => We need to verify that data lower layers "::" aren't
+	 *          followed by regular ":" lower layers
+	 *   (5) If ctx->nr > 0 => append
+	 *       We know that there's at least one regular layer
+	 *       otherwise we would've failed when parsing the previous
+	 *       lowerdir mount option.
+	 * (5.1) The lowerdir mount option is a regular layer ":" append
+	 *       => We need to verify that no data layers have been
+	 *          specified before.
+	 * (5.2) The lowerdir mount option is a data layer "::" append
+	 *       We know that there's at least one regular layer or
+	 *       other data layers. => There's nothing to verify.
+	 */
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
+		if (data_layer)
+			nr_data++;
+
+		/* Calling strchr() again would overrun. */
+		if ((nr + 1) == nr_lower)
+			break;
+
+		err = -EINVAL;
+		dup_iter = strchr(dup_iter, '\0') + 1;
+		if (*dup_iter) {
+			/*
+			 * This is a regular layer so we require that
+			 * there are no data layers.
+			 */
+			if ((ctx->nr_data + nr_data) > 0) {
+				pr_err("regular lower layers cannot follow data lower layers");
+				goto out_put;
+			}
+
+			data_layer = false;
+			continue;
+		}
+
+		/* This is a data lower layer. */
+		data_layer = true;
+		dup_iter++;
+	}
+	ctx->nr = nr_lower;
+	ctx->nr_data += nr_data;
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
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3392dc5d2082..b73b14c52961 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -27,8 +27,6 @@ MODULE_LICENSE("GPL");
 
 struct ovl_dir_cache;
 
-#define OVL_MAX_STACK 500
-
 static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
 module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
 MODULE_PARM_DESC(redirect_dir,
@@ -109,8 +107,11 @@ static const char *ovl_redirect_mode(struct ovl_config *config)
 	return ovl_parameter_redirect_dir[config->redirect_mode].name;
 }
 
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
 static const struct fs_parameter_spec ovl_parameter_spec[] = {
-	fsparam_string("lowerdir",          Opt_lowerdir),
+	fsparam_string_empty("lowerdir",    Opt_lowerdir),
 	fsparam_string("upperdir",          Opt_upperdir),
 	fsparam_string("workdir",           Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
@@ -125,15 +126,15 @@ static const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
+/*
+ * These options imply different behavior when they are explicitly
+ * specified than when they are left in their default state.
+ */
 #define OVL_METACOPY_SET	BIT(0)
 #define OVL_REDIRECT_SET	BIT(1)
 #define OVL_NFS_EXPORT_SET	BIT(2)
 #define OVL_INDEX_SET		BIT(3)
 
-struct ovl_fs_context {
-	u8 set;
-};
-
 static struct dentry *ovl_d_real(struct dentry *dentry,
 				 const struct inode *inode)
 {
@@ -308,6 +309,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	for (i = 0; i < ofs->numlayer; i++) {
 		iput(ofs->layers[i].trap);
 		mounts[i] = ofs->layers[i].mnt;
+		kfree(ofs->layers[i].name);
 	}
 	kern_unmount_array(mounts, ofs->numlayer);
 	kfree(ofs->layers);
@@ -315,7 +317,6 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
 	kfree(ofs->fs);
 
-	kfree(ofs->config.lowerdir);
 	kfree(ofs->config.upperdir);
 	kfree(ofs->config.workdir);
 	if (ofs->creator_cred)
@@ -433,8 +434,17 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = sb->s_fs_info;
 	const char *redirect_mode;
-
-	seq_show_option(m, "lowerdir", ofs->config.lowerdir);
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
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
@@ -509,6 +519,11 @@ static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	bool nfs_export_opt = ctx->set & OVL_NFS_EXPORT_SET;
 	bool index_opt = ctx->set & OVL_INDEX_SET;
 
+	if (ctx->nr_data > 0 && !config->metacopy) {
+		pr_err("lower data-only dirs require metacopy support.\n");
+		return -EINVAL;
+	}
+
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
 		if (config->workdir) {
@@ -723,69 +738,6 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
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
@@ -806,10 +758,6 @@ static int ovl_lower_dir(const char *name, struct path *path,
 	int fh_type;
 	int err;
 
-	err = ovl_mount_dir_noesc(name, path);
-	if (err)
-		return err;
-
 	err = ovl_check_namelen(path, ofs, name);
 	if (err)
 		return err;
@@ -858,26 +806,6 @@ static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
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
@@ -978,15 +906,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
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
@@ -1016,6 +941,11 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	upper_layer->idx = 0;
 	upper_layer->fsid = 0;
 
+	err = -ENOMEM;
+	upper_layer->name = kstrdup(ofs->config.upperdir, GFP_KERNEL);
+	if (!upper_layer->name)
+		goto out;
+
 	/*
 	 * Inherit SB_NOSEC flag from upperdir.
 	 *
@@ -1273,46 +1203,37 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
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
@@ -1476,13 +1397,13 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
 
 
 static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
-			  struct path *stack, unsigned int numlower,
-			  struct ovl_layer *layers)
+			  struct ovl_fs_context *ctx, struct ovl_layer *layers)
 {
 	int err;
 	unsigned int i;
+	size_t nr_merged_lower;
 
-	ofs->fs = kcalloc(numlower + 2, sizeof(struct ovl_sb), GFP_KERNEL);
+	ofs->fs = kcalloc(ctx->nr + 2, sizeof(struct ovl_sb), GFP_KERNEL);
 	if (ofs->fs == NULL)
 		return -ENOMEM;
 
@@ -1509,13 +1430,15 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->fs[0].is_lower = false;
 	}
 
-	for (i = 0; i < numlower; i++) {
+	nr_merged_lower = ctx->nr - ctx->nr_data;
+	for (i = 0; i < ctx->nr; i++) {
+		struct ovl_fs_context_layer *l = &ctx->lower[i];
 		struct vfsmount *mnt;
 		struct inode *trap;
 		int fsid;
 
-		if (i < numlower - ofs->numdatalayer)
-			fsid = ovl_get_fsid(ofs, &stack[i]);
+		if (i < nr_merged_lower)
+			fsid = ovl_get_fsid(ofs, &l->path);
 		else
 			fsid = ovl_get_data_fsid(ofs);
 		if (fsid < 0)
@@ -1528,11 +1451,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		 * the upperdir/workdir is in fact in-use by our
 		 * upperdir/workdir.
 		 */
-		err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
+		err = ovl_setup_trap(sb, l->path.dentry, &trap, "lowerdir");
 		if (err)
 			return err;
 
-		if (ovl_is_inuse(stack[i].dentry)) {
+		if (ovl_is_inuse(l->path.dentry)) {
 			err = ovl_report_in_use(ofs, "lowerdir");
 			if (err) {
 				iput(trap);
@@ -1540,7 +1463,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			}
 		}
 
-		mnt = clone_private_mount(&stack[i]);
+		mnt = clone_private_mount(&l->path);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
 			pr_err("failed to clone lowerpath\n");
@@ -1559,6 +1482,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		layers[ofs->numlayer].idx = ofs->numlayer;
 		layers[ofs->numlayer].fsid = fsid;
 		layers[ofs->numlayer].fs = &ofs->fs[fsid];
+		layers[ofs->numlayer].name = l->name;
+		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
 	}
@@ -1599,104 +1524,59 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
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
-	struct ovl_path *lowerstack;
-	unsigned int numlowerdata = 0;
 	unsigned int i;
+	size_t nr_merged_lower;
 	struct ovl_entry *oe;
+	struct ovl_path *lowerstack;
 
-	if (!ofs->config.upperdir && numlower == 1) {
+	struct ovl_fs_context_layer *l;
+
+	if (!ofs->config.upperdir && ctx->nr == 1) {
 		pr_err("at least 2 lowerdir are needed while upperdir nonexistent\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	stack = kcalloc(numlower, sizeof(struct path), GFP_KERNEL);
-	if (!stack)
-		return ERR_PTR(-ENOMEM);
+	err = -EINVAL;
+	for (i = 0; i < ctx->nr; i++) {
+		l = &ctx->lower[i];
 
-	for (i = 0; i < numlower;) {
-		err = ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack_depth);
+		err = ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stack_depth);
 		if (err)
-			goto out_err;
-
-		lower = strchr(lower, '\0') + 1;
-
-		i++;
-		if (i == numlower)
-			break;
-
-		err = -EINVAL;
-		/*
-		 * Empty lower layer path could mean :: separator that indicates
-		 * a data-only lower data.
-		 * Several data-only layers are allowed, but they all need to be
-		 * at the bottom of the stack.
-		 */
-		if (*lower) {
-			/* normal lower dir */
-			if (numlowerdata) {
-				pr_err("lower data-only dirs must be at the bottom of the stack.\n");
-				goto out_err;
-			}
-		} else {
-			/* data-only lower dir */
-			if (!ofs->config.metacopy) {
-				pr_err("lower data-only dirs require metacopy support.\n");
-				goto out_err;
-			}
-			if (i == numlower - 1) {
-				pr_err("lowerdir argument must not end with double colon.\n");
-				goto out_err;
-			}
-			lower++;
-			numlower--;
-			numlowerdata++;
-		}
-	}
-
-	if (numlowerdata) {
-		ofs->numdatalayer = numlowerdata;
-		pr_info("using the lowest %d of %d lowerdirs as data layers\n",
-			numlowerdata, numlower);
+			return ERR_PTR(err);
 	}
 
 	err = -EINVAL;
 	sb->s_stack_depth++;
 	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
 		pr_err("maximum fs stacking depth exceeded\n");
-		goto out_err;
+		return ERR_PTR(err);
 	}
 
-	err = ovl_get_layers(sb, ofs, stack, numlower, layers);
+	err = ovl_get_layers(sb, ofs, ctx, layers);
 	if (err)
-		goto out_err;
+		return ERR_PTR(err);
 
 	err = -ENOMEM;
 	/* Data-only layers are not merged in root directory */
-	oe = ovl_alloc_entry(numlower - numlowerdata);
+	nr_merged_lower = ctx->nr - ctx->nr_data;
+	oe = ovl_alloc_entry(nr_merged_lower);
 	if (!oe)
-		goto out_err;
+		return ERR_PTR(err);
 
 	lowerstack = ovl_lowerstack(oe);
-	for (i = 0; i < numlower - numlowerdata; i++) {
-		lowerstack[i].dentry = dget(stack[i].dentry);
-		lowerstack[i].layer = &ofs->layers[i+1];
+	for (i = 0; i < nr_merged_lower; i++) {
+		l = &ctx->lower[i];
+		lowerstack[i].dentry = dget(l->path.dentry);
+		lowerstack[i].layer = &ofs->layers[i + 1];
 	}
-
-out:
-	for (i = 0; i < numlower; i++)
-		path_put(&stack[i]);
-	kfree(stack);
+	ofs->numdatalayer = ctx->nr_data;
 
 	return oe;
-
-out_err:
-	oe = ERR_PTR(err);
-	goto out;
 }
 
 /*
@@ -1804,6 +1684,12 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
+	/*
+	 * We're going to put upper path when we call
+	 * fs_context_operations->free() take an additional
+	 * reference so we can just call path_put().
+	 */
+	dget(upperdentry);
 
 	return root;
 }
@@ -1815,7 +1701,6 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct ovl_fs *ofs = fc->s_fs_info;
 	struct ovl_config *config = &ofs->config;
 	struct ovl_fs_context *ctx = fc->fs_private;
-	char *dup;
 	int opt;
 
 	/*
@@ -1832,34 +1717,13 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case Opt_lowerdir:
-		dup = kstrdup(param->string, GFP_KERNEL);
-		if (!dup) {
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
@@ -1927,13 +1791,10 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct ovl_fs_context *ctx = fc->fs_private;
-	struct path upperpath = {};
 	struct dentry *root_dentry;
 	struct ovl_entry *oe;
 	struct ovl_layer *layers;
 	struct cred *cred;
-	char *splitlower = NULL;
-	unsigned int numlower;
 	int err;
 
 	err = -EIO;
@@ -1952,28 +1813,20 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
@@ -2005,7 +1858,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto out_err;
 		}
 
-		err = ovl_get_upper(sb, ofs, &layers[0], &upperpath);
+		err = ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
 		if (err)
 			goto out_err;
 
@@ -2019,7 +1872,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			}
 		}
 
-		err = ovl_get_workdir(sb, ofs, &upperpath);
+		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
 		if (err)
 			goto out_err;
 
@@ -2029,7 +1882,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
-	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
+	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
 		goto out_err;
@@ -2044,7 +1897,7 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	if (!ovl_force_readonly(ofs) && ofs->config.index) {
-		err = ovl_get_indexdir(sb, ofs, oe, &upperpath);
+		err = ovl_get_indexdir(sb, ofs, oe, &ctx->upper);
 		if (err)
 			goto out_free_oe;
 
@@ -2085,13 +1938,10 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -2109,6 +1959,10 @@ static int ovl_get_tree(struct fs_context *fc)
 
 static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
 {
+	ovl_parse_param_drop_lowerdir(ctx);
+	path_put(&ctx->upper);
+	path_put(&ctx->work);
+	kfree(ctx->lower);
 	kfree(ctx);
 }
 
@@ -2153,11 +2007,18 @@ static int ovl_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
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
-	if (!ofs) {
-		ovl_fs_context_free(ctx);
-		return -ENOMEM;
-	}
+	if (!ofs)
+		goto out_err;
 
 	if (strcmp(ovl_redirect_mode_def(), "on") == 0)
 		ofs->config.redirect_mode = OVL_REDIRECT_DIR_ON;
@@ -2174,6 +2035,11 @@ static int ovl_init_fs_context(struct fs_context *fc)
 	fc->fs_private		= ctx;
 	fc->ops			= &ovl_context_ops;
 	return 0;
+
+out_err:
+	ovl_fs_context_free(ctx);
+	return -ENOMEM;
+
 }
 
 static struct file_system_type ovl_fs_type = {

-- 
2.34.1

