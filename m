Return-Path: <linux-fsdevel+bounces-41736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4764A36366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F35F3AE0A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F313267AF3;
	Fri, 14 Feb 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puS1h8wO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB579264A80;
	Fri, 14 Feb 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551561; cv=none; b=LCkjV7MoyP660FodXYD8LsI1sO0rbSW8YcA8EZo0nfMBviXfrzTLTwR7DCuzbtAD1HYgsCbOs3cJLLVDU6q4+HzfJDqYywtQyRxmZ0O7c3IZt+4eKQufLE9W1QVcwicmvjFukpuK0PS/COaepXq2ihb7LeLvoPC8/CItNc4IJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551561; c=relaxed/simple;
	bh=iD+hWpaFSQurseLgs5aNQss5uk9UudJ/+oV1YXObWVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuavXsu4ZyAtSJDYuTRNPP0zukr/pbP5XDXnT3bt15GuXHWzLp/p5N29Zmh2N82wNeyKYy+gH3X21bjtExk799iQgqEJ6hZPffR37Mu7ccjFRcMZP4L4un3BbrpigBtlhd1jsBo/NdqCA0Q2Cdt3lXQKUp8wsK2xcs7o5dol3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puS1h8wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CDEC4CEDF;
	Fri, 14 Feb 2025 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551561;
	bh=iD+hWpaFSQurseLgs5aNQss5uk9UudJ/+oV1YXObWVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=puS1h8wOQKUXAna14PMtwm8oCIR/jaJvxOue7XCOZpNfA63V1un3S7xrCe659GxcG
	 ZmoRy8XTCFYZ+BQlJZ71UadZ2xM9Jx6JM5Rz6lPcAOPr6tdXXjC4Q9eI5Sy1M6b2z3
	 nGZrQdHKw+auMO3YC5L/t+0JzgYsEG3R1kW/fWy0PkuDg9u9kjOjopV5MecQ485KhQ
	 sNbJL5mboBPApj9FIbHrg7HwYtsqWdAEkVo04dp+GuAKUchKJicJ4fX6E+q461xRqx
	 sqV/Lc+rnhC+81Gjw8dgiIGjCwQHZRNfQkSGLCx6L92uD+yGfocl6f8YU9zvesAkAT
	 VXOITfEyh58nQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Feb 2025 17:45:17 +0100
Subject: [PATCH RFC 1/2] ovl: allow to specify override credentials
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-work-overlayfs-v1-1-465d1867d3d4@kernel.org>
References: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org>
In-Reply-To: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5214; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iD+hWpaFSQurseLgs5aNQss5uk9UudJ/+oV1YXObWVc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvL3Yxa341o5HfXbjlwM36dTJHbr7/d/R2cDTfs2V/m
 fVtWSbwd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEXIvhD/fzarnNKziCXn4y
 97jX/iZfgV+18XNDa3+Y2g/bJb+kpzH8T+d4m6Dhfq6swUA7266zXzMsc2tquH7ejZfTJA7/mfi
 FHQA=
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
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    | 25 +++++++++++++++++++++++++
 fs/overlayfs/super.c     | 13 ++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index cb449ab310a7..ed45553943e1 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -19,6 +19,7 @@ struct ovl_config {
 	bool metacopy;
 	bool userxattr;
 	bool ovl_volatile;
+	bool ovl_credentials;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..5dad23d6f121 100644
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
 
@@ -662,6 +664,27 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
+			if (!ofs->creator_cred)
+				err = -EINVAL;
+			else
+				config->ovl_credentials = true;
+		} else {
+			ofs->creator_cred = NULL;
+			config->ovl_credentials = false;
+		}
+		put_cred(cred);
+		break;
+	}
 	default:
 		pr_err("unrecognized mount option \"%s\" or missing value\n",
 		       param->key);
@@ -1071,5 +1094,7 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	if (ofs->config.verity_mode != ovl_verity_mode_def())
 		seq_printf(m, ",verity=%s",
 			   ovl_verity_mode(&ofs->config));
+	if (ofs->config.ovl_credentials)
+		seq_puts(m, ",override_creds");
 	return 0;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..157ab9e8f6f8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -654,6 +654,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 			    const struct path *workpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
+	const struct cred *old_cred;
 	struct dentry *workdir;
 	struct file *tmpfile;
 	bool rename_whiteout;
@@ -665,6 +666,8 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	if (err)
 		return err;
 
+	old_cred = ovl_override_creds(sb);
+
 	workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
 	err = PTR_ERR(workdir);
 	if (IS_ERR_OR_NULL(workdir))
@@ -788,6 +791,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->config.nfs_export = false;
 	}
 out:
+	ovl_revert_creds(old_cred);
 	mnt_drop_write(mnt);
 	return err;
 }
@@ -830,6 +834,7 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 			    struct ovl_entry *oe, const struct path *upperpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
+	const struct cred *old_cred;
 	struct dentry *indexdir;
 	struct dentry *origin = ovl_lowerstack(oe)->dentry;
 	const struct ovl_fh *fh;
@@ -843,6 +848,8 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 	if (err)
 		goto out_free_fh;
 
+	old_cred = ovl_override_creds(sb);
+
 	/* Verify lower root is upper root origin */
 	err = ovl_verify_origin_fh(ofs, upperpath->dentry, fh, true);
 	if (err) {
@@ -893,6 +900,7 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 		pr_warn("try deleting index dir or mounting with '-o index=off' to disable inodes index.\n");
 
 out:
+	ovl_revert_creds(old_cred);
 	mnt_drop_write(mnt);
 out_free_fh:
 	kfree(fh);
@@ -1318,7 +1326,10 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op = &ovl_dentry_operations;
 
 	err = -ENOMEM;
-	ofs->creator_cred = cred = prepare_creds();
+	if (!ofs->creator_cred)
+		ofs->creator_cred = cred = prepare_creds();
+	else
+		cred = (struct cred *)ofs->creator_cred;
 	if (!cred)
 		goto out_err;
 

-- 
2.47.2


