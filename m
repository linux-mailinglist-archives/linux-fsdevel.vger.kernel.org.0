Return-Path: <linux-fsdevel+bounces-31733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A699A817
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A045D282ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DEF19750B;
	Fri, 11 Oct 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHWwi/CG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384A194AE8;
	Fri, 11 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661424; cv=none; b=TuCZ4Tzp2RANmhkChUtoZp74ZYSP33/3saIioBuVfNSAemP7koWMMduPhWgG8bfy1TdUkM6yPit1IKWpsKB4m9kDoFi5AUL63JHqCSlYbV1qEZNTU16hkUk+EZFXqBJs9LfWdTD+vP/0Nq536BqXUb014N7Hsh/dX6skCgabj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661424; c=relaxed/simple;
	bh=FmDNKZ9WHiF4im2ScJHOv4xmHbseTiUosNqW13aFw6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9wd90KMa2ZzISBiAbenriLXWSDWvajaDoDWzMpCU83Zuw9EW8BvQyu2yOhj3rWbdam13OEQY260tkoCd/+k0u5vC/nJFVcxCGCX5cKGJYpHvYOHkoSTwVZ9MoLv2g7Foxyv6JYQGUn3s88xHrmv2exunXAo31FmUMYpLOIPxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHWwi/CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A34C4CEC7;
	Fri, 11 Oct 2024 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661423;
	bh=FmDNKZ9WHiF4im2ScJHOv4xmHbseTiUosNqW13aFw6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oHWwi/CGg7XWIWRzWHZxfepa2Km6smQbSwGag2KG/LnE+8YCUns18iUwq1wnX44Pq
	 3mUKyZumAY+fOVtEm8S0skEJuqcnK9o9t5ta/Ox9jvOwCAJR2QDV/5BwQhXzF4jF+E
	 NH4UAuYoswtsb62fXtHENwJa2uAUTPXfdiA4Sffh91x8vsH6/aYuNn1TemkA7cTn9V
	 rni5BWRcOkTlq3mwAWvq6jLMi9HiQQePHLQz101DGcjrQDMzr/177ooMsh5QRNhZy5
	 3u2kXwqucpgyvfkEnYcGk1EvhEd3Gv+Pqh0Xobz1kNjuPanTXxScz1iV/34dxPwmfd
	 QrJS2KP4eHJkQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 17:43:35 +0200
Subject: [PATCH RFC 1/3] ovl: specify layers via file descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v1-1-e34243841279@kernel.org>
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=7107; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FmDNKZ9WHiF4im2ScJHOv4xmHbseTiUosNqW13aFw6A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzuq8pnZE5n1Nk6gth6VsWkzZ1WZcb5Vj1/itTmyN80
 1inkHdNRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERK+xgZvlT3tu2ILT+XdSpR
 YWGkzPYV03iW38otsQ4Unm/amRxlwMjQIrRv74qI6Fzmh9t8gw323a9XFCvedHATo0a7/JO7/4I
 YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users such as systemd that want to assemble an
overlayfs mount purely based on file descriptors.

This introduces the new mount options:

    lowerdir_fd+
    datadir_fd+
    upperdir_fd
    workdir_fd

which can be used as follows:

    fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir_fd+", NULL, fd_upper);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir_fd+",  NULL, fd_work);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, fd_lower1);
    fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir_fd+", NULL, fd_lower2);

Since the mount api doesn't allow overloading of mount option parameters
(except for strings and flags). Making this work for arbitrary
parameters would be quite ugly or file descriptors would have to be
special cased. Neither is very appealing. I do prefer the *_fd mount
options because they aren't ambiguous.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/params.c | 132 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 23 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index e42546c6c5dfbea930414856d791e3e4424a999e..2da7f231401ef034bb62d72a5d34f4a7e9179f8b 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -59,6 +59,10 @@ enum ovl_opt {
 	Opt_metacopy,
 	Opt_verity,
 	Opt_volatile,
+	Opt_lowerdir_add_fd,
+	Opt_datadir_add_fd,
+	Opt_upperdir_fd,
+	Opt_workdir_fd,
 };
 
 static const struct constant_table ovl_parameter_bool[] = {
@@ -155,6 +159,10 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
 	fsparam_enum("verity",              Opt_verity, ovl_parameter_verity),
 	fsparam_flag("volatile",            Opt_volatile),
+	fsparam_fd("lowerdir_fd+",          Opt_lowerdir_add_fd),
+	fsparam_fd("datadir_fd+",           Opt_datadir_add_fd),
+	fsparam_fd("upperdir_fd",           Opt_upperdir_fd),
+	fsparam_fd("workdir_fd",            Opt_workdir_fd),
 	{}
 };
 
@@ -343,19 +351,27 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 
 	switch (layer) {
 	case Opt_workdir:
+		fallthrough;
+	case Opt_workdir_fd:
 		swap(config->workdir, *pname);
 		swap(ctx->work, *path);
 		break;
 	case Opt_upperdir:
+		fallthrough;
+	case Opt_upperdir_fd:
 		swap(config->upperdir, *pname);
 		swap(ctx->upper, *path);
 		break;
 	case Opt_datadir_add:
+		fallthrough;
+	case Opt_datadir_add_fd:
 		ctx->nr_data++;
 		fallthrough;
 	case Opt_lowerdir:
 		fallthrough;
 	case Opt_lowerdir_add:
+		fallthrough;
+	case Opt_lowerdir_add_fd:
 		WARN_ON(ctx->nr >= ctx->capacity);
 		l = &ctx->lower[ctx->nr++];
 		memset(l, 0, sizeof(*l));
@@ -367,43 +383,96 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 	}
 }
 
-static int ovl_parse_layer(struct fs_context *fc, const char *layer_name, enum ovl_opt layer)
+static inline bool is_upper_layer(enum ovl_opt layer)
 {
-	char *name = kstrdup(layer_name, GFP_KERNEL);
-	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
-	struct path path;
-	int err;
+	return layer == Opt_upperdir || layer == Opt_upperdir_fd ||
+	       layer == Opt_workdir || layer == Opt_workdir_fd;
+}
+
+static inline bool is_layer_fd(enum ovl_opt layer)
+{
+	return layer == Opt_upperdir_fd || layer == Opt_workdir_fd ||
+	       layer == Opt_lowerdir_add_fd || layer == Opt_datadir_add_fd;
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
-	if (err)
-		goto out_free;
-
-	err = ovl_mount_dir_check(fc, &path, layer, name, upper);
+	upper = is_upper_layer(layer);
+	err = ovl_mount_dir_check(fc, layer_path, layer, name, upper);
 	if (err)
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
+	if (is_layer_fd(layer)) {
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
@@ -474,7 +543,13 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 
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
 
@@ -552,10 +627,21 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		err = ovl_parse_param_lowerdir(param->string, fc);
 		break;
 	case Opt_lowerdir_add:
+		fallthrough;
 	case Opt_datadir_add:
+		fallthrough;
 	case Opt_upperdir:
+		fallthrough;
 	case Opt_workdir:
-		err = ovl_parse_layer(fc, param->string, opt);
+		fallthrough;
+	case Opt_lowerdir_add_fd:
+		fallthrough;
+	case Opt_datadir_add_fd:
+		fallthrough;
+	case Opt_upperdir_fd:
+		fallthrough;
+	case Opt_workdir_fd:
+		err = ovl_parse_layer(fc, param, opt);
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;

-- 
2.45.2


