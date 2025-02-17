Return-Path: <linux-fsdevel+bounces-41833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C6A38006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3231898649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5E217718;
	Mon, 17 Feb 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4BOodQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E573217678;
	Mon, 17 Feb 2025 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787644; cv=none; b=DOLYlH/+DrfePR1AwmLHy06DXTtnISLid/BqCaNNcO2iEzzOFIzMeSpZ7NcNZ3b4/joGyHht91ZsF7MqXIj1CeCeoGumtgA458fVp0/bNtE+4TpTiUJpfROI5RarT67U9yf34fxFCBd4fiztcE62VnILTaYPOkd89+yQWraCCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787644; c=relaxed/simple;
	bh=WGm3EsRfuAsH/inUGgB8AWi/uc4avEW2hUSantZkxTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eURigl+lzaNM4X3wmd/xL7sw+n/XzETsDzMMVOZI5mn5tQ6DIVyzPZaHZ5PV/4fdde1UPtpBhbviBwJQEgOa8uti/L1w0GloF11zehQRSu5vXOxXWYPC01FOxMlgNl/iYCGTsmw7WiJ2B8jFu13YCNB4EQbHa50ehpRD5b6zz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4BOodQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA945C4CEE4;
	Mon, 17 Feb 2025 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739787642;
	bh=WGm3EsRfuAsH/inUGgB8AWi/uc4avEW2hUSantZkxTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U4BOodQYZ3GkopGzVn6zzUIfwpNeuf/ezYHIiMZVg76tPNTrCWR5txOxOGWn7C+PF
	 lA+2EhLjDunNMR9bhRH3EC/95fG2pp0RTPNkha59fO/MEAc8XtmZ8OSmxL4MhpYB5o
	 Wa/VwXKpUenE/9f5gy2iC7QucegynUfaSmQ9g1nLGn/qxcX1HsA7q1IblIRQvW/5is
	 2mYOMA4B0v1buRdBK6c0/bq0unN9l/mtWQUQd1H6qjM8ddVUCUikpfVSzl+yi+THcf
	 IehR2uFvIApnORxrh4/DE+yPoTds0aPTyce//cZCjmZ1exPS5F22mZTpzo+RieUbQk
	 76hoczcRL+GWg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Feb 2025 11:20:29 +0100
Subject: [PATCH RFC v2 1/2] ovl: allow to specify override credentials
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-work-overlayfs-v2-1-41dfe7718963@kernel.org>
References: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org>
In-Reply-To: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WGm3EsRfuAsH/inUGgB8AWi/uc4avEW2hUSantZkxTE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv5i2bZKGoM12ksX/xwYu/MxgmG+VcfRl10qKjL8rw8
 CyWh35tHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOplGdk+J38/NCdExXWK/MU
 Tlzq9tdLrow7aLTA+0r21+l9sVfr3zEyTBFKktD41q3PkxRU8+3a5VlJt5z+P/LmNG8IvG57pGc
 NKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently overlayfs uses the mounter's credentials for it's
override_creds() calls. That provides a consistent permission model.

This patches allows a caller to instruct overlayfs to use its
credentials instead. The caller must be located in the same user
namespace as the user namespace the overlayfs instance will be mounted
in. This provides a consistent and simple security model.

With this it is possible to e.g., mount an overlayfs instance where the
mounter must have CAP_SYS_ADMIN but the credentials used for
override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
custom fs{g,u}id different from the callers and other tweaks.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/params.c | 22 ++++++++++++++++++++++
 fs/overlayfs/super.c  | 11 ++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..f2bc8acf6bf1 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -59,6 +59,7 @@ enum ovl_opt {
 	Opt_metacopy,
 	Opt_verity,
 	Opt_volatile,
+	Opt_override_creds,
 };
 
 static const struct constant_table ovl_parameter_bool[] = {
@@ -155,6 +156,7 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
 	fsparam_enum("verity",              Opt_verity, ovl_parameter_verity),
 	fsparam_flag("volatile",            Opt_volatile),
+	fsparam_flag_no("override_creds",   Opt_override_creds),
 	{}
 };
 
@@ -662,6 +664,26 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_userxattr:
 		config->userxattr = true;
 		break;
+	case Opt_override_creds: {
+		const struct cred *cred = ofs->creator_cred;
+
+		if (!result.negated) {
+			if (fc->user_ns != current_user_ns()) {
+				err = -EINVAL;
+				break;
+			}
+
+			ofs->creator_cred = prepare_creds();
+			if (!ofs->creator_cred) {
+				err = -EINVAL;
+				break;
+			}
+		} else {
+			ofs->creator_cred = NULL;
+		}
+		put_cred(cred);
+		break;
+	}
 	default:
 		pr_err("unrecognized mount option \"%s\" or missing value\n",
 		       param->key);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..a85071fe18fd 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1305,6 +1305,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct ovl_fs_context *ctx = fc->fs_private;
+	const struct cred *old_cred = NULL;
 	struct dentry *root_dentry;
 	struct ovl_entry *oe;
 	struct ovl_layer *layers;
@@ -1318,10 +1319,15 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op = &ovl_dentry_operations;
 
 	err = -ENOMEM;
-	ofs->creator_cred = cred = prepare_creds();
+	if (!ofs->creator_cred)
+		ofs->creator_cred = cred = prepare_creds();
+	else
+		cred = (struct cred *)ofs->creator_cred;
 	if (!cred)
 		goto out_err;
 
+	old_cred = ovl_override_creds(sb);
+
 	err = ovl_fs_params_verify(ctx, &ofs->config);
 	if (err)
 		goto out_err;
@@ -1481,6 +1487,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_root = root_dentry;
 
+	ovl_revert_creds(old_cred);
 	return 0;
 
 out_free_oe:
@@ -1488,6 +1495,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 out_err:
 	ovl_free_fs(ofs);
 	sb->s_fs_info = NULL;
+	if (old_cred)
+		ovl_revert_creds(old_cred);
 	return err;
 }
 

-- 
2.47.2


