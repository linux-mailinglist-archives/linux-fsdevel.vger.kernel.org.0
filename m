Return-Path: <linux-fsdevel+bounces-41225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81998A2C7B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348D47A4595
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400A2451F3;
	Fri,  7 Feb 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psz3MFn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AB24817F;
	Fri,  7 Feb 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943217; cv=none; b=EVAy8lDqZRSDDoTA1FpvbVYBqbhSMQdD1wuDxpPxsK0wMcdFGduuO+G+O9XAnuvZgljV0mZpPw4q4mVcdlnyRU1pS7/TfmGjuIdpd/kyTA9UdIB3pfKKJbjRwf9oinT5oaOnw6ywbIPiIz9IenfV9ubsFDcghYYVQz+pz5rnDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943217; c=relaxed/simple;
	bh=P42K1GRagtuM4ndm7X1Qeq6DLr8cl569VusbGO0FnfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/p4N24YRqqAoTheey6vaezxwiIc4wcRuPVKf4Nx1f836/GwQx/7JSmrQPEbs02tW5yuwcr/e8nmEIsqRst5CalaFoc6RcSXIzBjaOr/6qpSY1b8O8ePu5dP5iPUI7K6Q/9g9p7X/Cn5zwSEtnrHON2TCMX8PRrmcLMLG/McKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psz3MFn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CCC4CEEB;
	Fri,  7 Feb 2025 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738943216;
	bh=P42K1GRagtuM4ndm7X1Qeq6DLr8cl569VusbGO0FnfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Psz3MFn7mdl9vi6vMvf7wrqwn1imT05iTZ+64ijjZ1kOvN6j/uP3EO73cn5Q2HR1W
	 63HOMMk7t9RkR8n4YMm9QCT6xuTCb1wLIQsZqDh32h+gFEs1B6VAIxJlx+BKrPjRz5
	 Xc5lULg99seZkZlTI9x7tUM+09feT3dUA1yWY80FQuu+aJTZO8NO5NVVaOEaHdxdiM
	 TI612m51tAtHF+E1/aGAXIeNwlwn+goJBdMxLEzOUsu8pbzxgWPTTPEXenn2rZoObf
	 DZepP5Z73Z0fuzwlrn8PkLJYI8tgT9ClY6SI2ZkHveGYhzMX8GIQRu1Zf9HOjw+1oI
	 bf0tUkLQs+Xcg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Feb 2025 16:46:39 +0100
Subject: [PATCH 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-work-overlayfs-v1-1-611976e73373@kernel.org>
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
In-Reply-To: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650; i=brauner@kernel.org;
 h=from:subject:message-id; bh=P42K1GRagtuM4ndm7X1Qeq6DLr8cl569VusbGO0FnfY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv03rzKe1esfUlyWJnfm21KW7vJ/HsTHUrfDTDXMAk4
 EBC/MNLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZbMbwV+IYd8D5gqlLjR/+
 sJ++Sfyo9N+iW9LhG/83bnvI7byEvYvhn40Yl29FfLrgbvc1gozVjX7JZze3ch074xL+aJnwgif
 9PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
useful in the context of overlayfs where layers can be specified via
file descriptors instead of paths. But userspace must currently use
non-O_PATH file desriptors which is often pointless especially if
the file descriptors have been created via open_tree(OPEN_TREE_CLONE).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_parser.c             | 12 +++++++-----
 fs/fsopen.c                |  7 +++++--
 fs/overlayfs/params.c      | 10 ++++++----
 include/linux/fs_context.h |  1 +
 include/linux/fs_parser.h  |  6 +++---
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index e635a81e17d9..35aaea224007 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -310,15 +310,17 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
-int fs_param_is_file_or_string(struct p_log *log,
-			       const struct fs_parameter_spec *p,
-			       struct fs_parameter *param,
-			       struct fs_parse_result *result)
+int fs_param_is_raw_file_or_string(struct p_log *log,
+				   const struct fs_parameter_spec *p,
+				   struct fs_parameter *param,
+				   struct fs_parse_result *result)
 {
 	switch (param->type) {
 	case fs_value_is_string:
 		return fs_param_is_string(log, p, param, result);
 	case fs_value_is_file:
+		fallthrough;
+	case fs_value_is_raw_file:
 		result->uint_32 = param->dirfd;
 		if (result->uint_32 <= INT_MAX)
 			return 0;
@@ -328,7 +330,7 @@ int fs_param_is_file_or_string(struct p_log *log,
 	}
 	return fs_param_bad_value(log, param);
 }
-EXPORT_SYMBOL(fs_param_is_file_or_string);
+EXPORT_SYMBOL(fs_param_is_raw_file_or_string);
 
 int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 094a7f510edf..3b5fc9f1f774 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -451,11 +451,14 @@ SYSCALL_DEFINE5(fsconfig,
 		param.size = strlen(param.name->name);
 		break;
 	case FSCONFIG_SET_FD:
-		param.type = fs_value_is_file;
 		ret = -EBADF;
-		param.file = fget(aux);
+		param.file = fget_raw(aux);
 		if (!param.file)
 			goto out_key;
+		if (param.file->f_mode & FMODE_PATH)
+			param.type = fs_value_is_raw_file;
+		else
+			param.type = fs_value_is_file;
 		param.dirfd = aux;
 		break;
 	default:
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..846afa6081a5 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -141,10 +141,10 @@ static int ovl_verity_mode_def(void)
 
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
-	fsparam_file_or_string("lowerdir+", Opt_lowerdir_add),
-	fsparam_file_or_string("datadir+",  Opt_datadir_add),
-	fsparam_file_or_string("upperdir",  Opt_upperdir),
-	fsparam_file_or_string("workdir",   Opt_workdir),
+	fsparam_raw_file_or_string("lowerdir+", Opt_lowerdir_add),
+	fsparam_raw_file_or_string("datadir+",  Opt_datadir_add),
+	fsparam_raw_file_or_string("upperdir",  Opt_upperdir),
+	fsparam_raw_file_or_string("workdir",   Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
 	fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_redirect_dir),
 	fsparam_enum("index",               Opt_index, ovl_parameter_bool),
@@ -438,6 +438,8 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 			return err;
 		err = ovl_do_parse_layer(fc, param->string, &layer_path, layer);
 		break;
+	case fs_value_is_raw_file:
+		fallthrough;
 	case fs_value_is_file: {
 		char *buf __free(kfree);
 		char *layer_name;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 4b4bfef6f053..4ba18211046e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -55,6 +55,7 @@ enum fs_value_type {
 	fs_value_is_blob,		/* Value is a binary blob */
 	fs_value_is_filename,		/* Value is a filename* + dirfd */
 	fs_value_is_file,		/* Value is a file* */
+	fs_value_is_raw_file,		/* Value is an O_PATH/FMODE_PATH file* */
 };
 
 /*
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 53e566efd5fd..77d5d3c78d39 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -29,7 +29,7 @@ typedef int fs_param_type(struct p_log *,
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
 	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid,
-	fs_param_is_file_or_string;
+	fs_param_is_raw_file_or_string;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -136,8 +136,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
-#define fsparam_file_or_string(NAME, OPT) \
-				__fsparam(fs_param_is_file_or_string, NAME, OPT, 0, NULL)
+#define fsparam_raw_file_or_string(NAME, OPT) \
+				__fsparam(fs_param_is_raw_file_or_string, NAME, OPT, 0, NULL)
 #define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
 #define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 

-- 
2.47.2


