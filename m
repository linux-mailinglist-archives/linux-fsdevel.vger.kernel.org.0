Return-Path: <linux-fsdevel+bounces-31784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1799AE40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01511C2596E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF31D1E6D;
	Fri, 11 Oct 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVuRNoe3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096201D1721;
	Fri, 11 Oct 2024 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683177; cv=none; b=upYqtn+iZGQkIKrloOFp/xM2R0ErtWK0BkZxEqux+MnfOZnBRAKiK4HkCwLjNBySXWh8/joZ9IvG/fX1PqRP3SmUMXMk5ZX3T3DxCOfL6uieWU5u37PiDZvNfbOmvQB1Helum2uYEYzofySWaPZCPYjqruRH7S0/CiChpEH/4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683177; c=relaxed/simple;
	bh=No1W/7ZwuqncBOVOAg5NNUk9ZiY7MM4gM5ISkS161hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcRzqA1GZueOQtaaGauIz6wvVZw+rRmbVStLwAtuHChBPok50OLEWRBvbRI3GnpDDzfBKuayzzrMajXdFKXt0A9Ws8VUbuBK2SPYvDqh1j3YGCrRcSiQIvarQsJ+ddJEk5LLX3o5fa3H6QVBfkk5RlX9NwZJ6M0WQGl1dxt/dCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVuRNoe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6CC4CECE;
	Fri, 11 Oct 2024 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683176;
	bh=No1W/7ZwuqncBOVOAg5NNUk9ZiY7MM4gM5ISkS161hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sVuRNoe3iBq3s6zFhNWtd8IKfpNNi+TKZXkjkvXfYKdXwMskv/vRAqR2jOpW8meFu
	 OUKLTqaPWifz5D3EAAqxsSRIPaoQ3j+XlZ8Ai+Loz6ryGANKv3EPr5l5qe5JdHgSn0
	 vtFJ8hBrIdPhGM0wIRwaA5WH1Mis1FDPLxG7JO3QsxjA3Dl1Z/wLBuue2foYUjZbJK
	 i2+6dqujmcqkHCbF0bsVchGkMgbsO9kCizyusreJJM1zuhRkQf/SA/lS1r04J6XTEZ
	 0KQCble13T+LbM9t2fI7El0PpYkJ0DB4zuLzaaU73QD8TSM294M3woE2HdD+dS31if
	 UF42XGNTpmgDA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 23:45:51 +0200
Subject: [PATCH RFC v2 2/4] ovl: specify layers via file descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=5781; i=brauner@kernel.org;
 h=from:subject:message-id; bh=No1W/7ZwuqncBOVOAg5NNUk9ZiY7MM4gM5ISkS161hA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzzlnclsbl2/TwzJf6js1ptdMZp89L6EgJlXlxxvLXu
 asiSe1vO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSa8DI8MvOqkWtb/1F8fhr
 FSd+n5+iGn3utCBrzZOAwouior5P/jL8FTmtqGWy0qJjh93Dpqjq73zP4r5sy9jme3etzU3Jqj+
 SfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users such as systemd that want to assemble an
overlayfs mount purely based on file descriptors.

This enables user to specify both:

    fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);

in addition to:

    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
    fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/params.c | 106 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 27 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index e42546c6c5dfbea930414856d791e3e4424a999e..2d5a072b8683ce94b6cec4b75ce5ddd6d6db8dc6 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -141,10 +141,10 @@ static int ovl_verity_mode_def(void)
 
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
-	fsparam_string("lowerdir+",         Opt_lowerdir_add),
-	fsparam_string("datadir+",          Opt_datadir_add),
-	fsparam_string("upperdir",          Opt_upperdir),
-	fsparam_string("workdir",           Opt_workdir),
+	fsparam_fd_or_path("lowerdir+",     Opt_lowerdir_add),
+	fsparam_fd_or_path("datadir+",      Opt_datadir_add),
+	fsparam_fd_or_path("upperdir",      Opt_upperdir),
+	fsparam_fd_or_path("workdir",       Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
 	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_redirect_dir),
 	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
@@ -367,43 +367,89 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 	}
 }
 
-static int ovl_parse_layer(struct fs_context *fc, const char *layer_name, enum ovl_opt layer)
+static inline bool is_upper_layer(enum ovl_opt layer)
 {
-	char *name = kstrdup(layer_name, GFP_KERNEL);
-	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
-	struct path path;
-	int err;
+	return layer == Opt_upperdir || layer == Opt_workdir;
+}
+
+/* Handle non-file descriptor-based layer options that require path lookup. */
+static inline int ovl_kern_path(const char *layer_name, struct path *layer_path,
+				enum ovl_opt layer)
+{
+	switch (layer) {
+	case Opt_upperdir:
+		fallthrough;
+	case Opt_workdir:
+		fallthrough;
+	case Opt_lowerdir:
+		return ovl_mount_dir(layer_name, layer_path);
+	case Opt_lowerdir_add:
+		fallthrough;
+	case Opt_datadir_add:
+		return ovl_mount_dir_noesc(layer_name, layer_path);
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ovl_do_parse_layer(struct fs_context *fc, const char *layer_name,
+			      struct path *layer_path, enum ovl_opt layer)
+{
+	char *name __free(kfree) = kstrdup(layer_name, GFP_KERNEL);
+	bool upper;
+	int err = 0;
 
 	if (!name)
 		return -ENOMEM;
 
-	if (upper || layer == Opt_lowerdir)
-		err = ovl_mount_dir(name, &path);
-	else
-		err = ovl_mount_dir_noesc(name, &path);
+	upper = is_upper_layer(layer);
+	err = ovl_mount_dir_check(fc, layer_path, layer, name, upper);
 	if (err)
-		goto out_free;
-
-	err = ovl_mount_dir_check(fc, &path, layer, name, upper);
-	if (err)
-		goto out_put;
+		return err;
 
 	if (!upper) {
 		err = ovl_ctx_realloc_lower(fc);
 		if (err)
-			goto out_put;
+			return err;
 	}
 
 	/* Store the user provided path string in ctx to show in mountinfo */
-	ovl_add_layer(fc, layer, &path, &name);
-
-out_put:
-	path_put(&path);
-out_free:
-	kfree(name);
+	ovl_add_layer(fc, layer, layer_path, &name);
 	return err;
 }
 
+static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
+			   enum ovl_opt layer)
+{
+	struct path path __free(path_put) = {};
+	char *buf __free(kfree) = NULL;
+	char *layer_name;
+	int err = 0;
+
+	if (param->type == fs_value_is_file) {
+		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
+		if (!buf)
+			return -ENOMEM;
+
+		path = param->file->f_path;
+		path_get(&path);
+
+		layer_name = d_path(&path, buf, PATH_MAX);
+		if (IS_ERR(layer_name))
+			return PTR_ERR(layer_name);
+	} else {
+		layer_name = param->string;
+		err = ovl_kern_path(layer_name, &path, layer);
+	}
+	if (err)
+		return err;
+
+	return ovl_do_parse_layer(fc, layer_name, &path, layer);
+}
+
 static void ovl_reset_lowerdirs(struct ovl_fs_context *ctx)
 {
 	struct ovl_fs_context_layer *l = ctx->lower;
@@ -474,7 +520,13 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 
 	iter = dup;
 	for (nr = 0; nr < nr_lower; nr++) {
-		err = ovl_parse_layer(fc, iter, Opt_lowerdir);
+		struct path path __free(path_put) = {};
+
+		err = ovl_kern_path(iter, &path, Opt_lowerdir);
+		if (err)
+			goto out_err;
+
+		err = ovl_do_parse_layer(fc, iter, &path, Opt_lowerdir);
 		if (err)
 			goto out_err;
 
@@ -555,7 +607,7 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_datadir_add:
 	case Opt_upperdir:
 	case Opt_workdir:
-		err = ovl_parse_layer(fc, param->string, opt);
+		err = ovl_parse_layer(fc, param, opt);
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;

-- 
2.45.2


