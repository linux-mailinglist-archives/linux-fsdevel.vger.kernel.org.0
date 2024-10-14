Return-Path: <linux-fsdevel+bounces-31869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9699C602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391EE2865DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CE15B13D;
	Mon, 14 Oct 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE4aH/AZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43D15B0EE;
	Mon, 14 Oct 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898871; cv=none; b=Iu6HNtfToLoqhUZsl0ztmAtZJE7fBb3GA4YdXykZz7N0DcYeZ1SoeNLEhfVuxFh71qTZ5ApRSNJW1aFg9PYfFfKub1gdJcELeRR7u1+r+13vYCqQll5JRYDSTMHYBbuOD73mRJlk2KvhXzFOLajyL7jZRvXmMsN+TI0/D/rFfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898871; c=relaxed/simple;
	bh=oS0VlFmrovOBWOMBqrVsyJ9XuzXsXw2KKkMkW9YTpH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhSW6pwFJuQE+GK9YdMBm9CejDBsRFnEI4lgB6VebuImAC6HHGDXf1ShH48YmePTVKcJcCK7hIf58jMsFgg+j2z2PCnvQeKR+DtGGOi90kzALB8qlOYEewuUl4A5Mqp4Et6DB3kQLxwN+ZUSJZ1KwsBO56Q4G3IhxftoRiFzzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE4aH/AZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA72C4CEC3;
	Mon, 14 Oct 2024 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898870;
	bh=oS0VlFmrovOBWOMBqrVsyJ9XuzXsXw2KKkMkW9YTpH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VE4aH/AZMF0jat5D+2rqomzh6IqU+tytpRbMPBdQ//r5kxj4F2vwfTW3pc3WMlnbC
	 Ovet3rA8YM+WRQqyF1Pyck9hGznrU6ZtHM5W05Ow9WF1ck2TN9qiGVsKAtSvTB1fnR
	 ydEFMcHYTAKzZkuZPSoL5W5RpewHZ/G+/+hk+cmZb9rkz4rJJC5jF0l0VxW+JqcF8S
	 1mikMlr52W1C/LLCyPDzm0rdjZpQr0aaBrkR8RG3rs4V/hlOt5hkUarswM/Bnsrias
	 z0Qku20rOwanzRIVtnYkhKebGhtJInemPDeQuL6fs2UPT14pqwEvlnDdhZ/DrepT/W
	 LPS7lXtp7p0hA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Oct 2024 11:40:57 +0200
Subject: [PATCH v3 2/5] ovl: specify layers via file descriptors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-work-overlayfs-v3-2-32b3fed1286e@kernel.org>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=5893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oS0VlFmrovOBWOMBqrVsyJ9XuzXsXw2KKkMkW9YTpH8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDc0MmBz+ZeWoFDxr3FF9S+J1sUT/Hfs5U+0C97PX
 fBwY8OnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInU3Gf4H9694Vx/2/9dxuof
 rgfH8+14o3t0xfPZic+sEs/rsPi7SjIy/A+t5Lv5m9mjWOzR6lJRLfdXz/MKmeMPiX/M4YjmuPC
 eBQA=
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
 fs/overlayfs/params.c | 116 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 25 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index e42546c6c5dfbea930414856d791e3e4424a999e..1115c22deca0cb97a2c70fdff5eac1b4f09e504d 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -141,10 +141,10 @@ static int ovl_verity_mode_def(void)
 
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
-	fsparam_string("lowerdir+",         Opt_lowerdir_add),
-	fsparam_string("datadir+",          Opt_datadir_add),
-	fsparam_string("upperdir",          Opt_upperdir),
-	fsparam_string("workdir",           Opt_workdir),
+	fsparam_file_or_string("lowerdir+", Opt_lowerdir_add),
+	fsparam_file_or_string("datadir+",  Opt_datadir_add),
+	fsparam_file_or_string("upperdir",  Opt_upperdir),
+	fsparam_file_or_string("workdir",   Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
 	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_redirect_dir),
 	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
@@ -367,40 +367,100 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 	}
 }
 
-static int ovl_parse_layer(struct fs_context *fc, const char *layer_name, enum ovl_opt layer)
+static inline bool is_upper_layer(enum ovl_opt layer)
+{
+	return layer == Opt_upperdir || layer == Opt_workdir;
+}
+
+/* Handle non-file descriptor-based layer options that require path lookup. */
+static inline int ovl_kern_path(const char *layer_name, struct path *layer_path,
+				enum ovl_opt layer)
 {
-	char *name = kstrdup(layer_name, GFP_KERNEL);
-	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
-	struct path path;
 	int err;
 
+	switch (layer) {
+	case Opt_upperdir:
+		fallthrough;
+	case Opt_workdir:
+		fallthrough;
+	case Opt_lowerdir:
+		err = ovl_mount_dir(layer_name, layer_path);
+		break;
+	case Opt_lowerdir_add:
+		fallthrough;
+	case Opt_datadir_add:
+		err = ovl_mount_dir_noesc(layer_name, layer_path);
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int ovl_do_parse_layer(struct fs_context *fc, const char *layer_name,
+			      struct path *layer_path, enum ovl_opt layer)
+{
+	char *name __free(kfree) = kstrdup(layer_name, GFP_KERNEL);
+	bool upper;
+	int err = 0;
+
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
+	ovl_add_layer(fc, layer, layer_path, &name);
+	return err;
+}
+
+static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
+			   enum ovl_opt layer)
+{
+	struct path layer_path __free(path_put) = {};
+	int err = 0;
+
+	switch (param->type) {
+	case fs_value_is_string:
+		err = ovl_kern_path(param->string, &layer_path, layer);
+		if (err)
+			return err;
+		err = ovl_do_parse_layer(fc, param->string, &layer_path, layer);
+		break;
+	case fs_value_is_file: {
+		char *buf __free(kfree);
+		char *layer_name;
+
+		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
+		if (!buf)
+			return -ENOMEM;
+
+		layer_path = param->file->f_path;
+		path_get(&layer_path);
+
+		layer_name = d_path(&layer_path, buf, PATH_MAX);
+		if (IS_ERR(layer_name))
+			return PTR_ERR(layer_name);
+
+		err = ovl_do_parse_layer(fc, layer_name, &layer_path, layer);
+		break;
+	}
+	default:
+		WARN_ON_ONCE(true);
+		err = -EINVAL;
+	}
 
-out_put:
-	path_put(&path);
-out_free:
-	kfree(name);
 	return err;
 }
 
@@ -474,7 +534,13 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 
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
 
@@ -555,7 +621,7 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
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


