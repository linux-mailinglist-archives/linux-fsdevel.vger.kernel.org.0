Return-Path: <linux-fsdevel+bounces-68257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47FC5798C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26800420977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54293557F5;
	Thu, 13 Nov 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjbGCVhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58C34D91E;
	Thu, 13 Nov 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039023; cv=none; b=jplyqTxbIoJHEYXwSfe43Xo8hIhV1YwHRYtpKoDFfnKS8mczemCupOHft/lpTNdGpR1gO5O8at7oD6AZZpdDCNPFUDDJ7u1VdrtUbAmqwI8WMNbbeY/kXQQ79chciLtcIZftv0lW85xehoO4XrKKrzlEQt/YXsbuCsWPs8BVl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039023; c=relaxed/simple;
	bh=ki9MthZ8AnQXjjr4GMgxuLB0YfxecqC/UsKy5Kw53hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoVIDiPzWuwm1zbxU2ZQR9xD0COPSJr082JhyObIEFgvB2sWQCxlo1GlE1rn2Gt/35upLRVk1lIl8yk1iNrhb7Yz2XMtXUAV/Vhko8dU9+BjtNf+uyffA5zxRFgZPnC3fr8oK3PRbCWysDZ9FXTvI37wMbwY7vQbhLjz/oflJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjbGCVhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B78C116D0;
	Thu, 13 Nov 2025 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039023;
	bh=ki9MthZ8AnQXjjr4GMgxuLB0YfxecqC/UsKy5Kw53hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DjbGCVhc8CyBU8DqU1/I45649GjCvugqKX4QIx+KLKNSdWv5iGaKf/rx1v3qADb6C
	 x1oEkKEop/FDmOBNfV//EBKg50Wh9P/5eXFk6nqhplK41g6T9URm0oZKPZSUKNdwNP
	 7WpCm3WzmEB6xNnrgAkjj+B3TwYlmTKhNz2TGs035frhUFM55dhCkPqIziMhzHDolf
	 iEzGs40WMnrbzGlSM/F2uVgj8Q3OugdxAuozZ61xFt4fhwO04WrwvleZUQ5lgOsDQt
	 /whcrM0is+xjzntRMzZvHaqHMltscnFMcB2jSPum5ZVByMOdkfyaHwErRYA3UcQZuH
	 cdyggNveCO5Hg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:02:00 +0100
Subject: [PATCH RFC 40/42] ovl: refactor ovl_fill_super()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-40-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6264; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ki9MthZ8AnQXjjr4GMgxuLB0YfxecqC/UsKy5Kw53hg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntSq59p7Od1IUEsQ6OAo1/l7KtXPKuPLGy69vf79
 OUppiqXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbinMLI0Jq7R2F3a+ypFJf9
 8aYaAcKvvon9rly/evlGreWbwrZ938Dw3zH998foECu5VT9qp/98lz3vDvfEd2JsfPa7ZW5bfTm
 QzA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split the core into a separate helper in preparation of converting the
caller to the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 119 +++++++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 57 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 43ee4c7296a7..6876406c120a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1369,53 +1369,35 @@ static void ovl_set_d_op(struct super_block *sb)
 	set_default_d_op(sb, &ovl_dentry_operations);
 }
 
-int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
+static int do_ovl_fill_super(struct super_block *sb, struct ovl_fs *ofs,
+			      struct fs_context *fc)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
-	struct ovl_fs_context *ctx = fc->fs_private;
-	const struct cred *old_cred = NULL;
-	struct dentry *root_dentry;
-	struct ovl_entry *oe;
+	struct ovl_fs_context *fsctx = fc->fs_private;
 	struct ovl_layer *layers;
-	struct cred *cred;
+	struct ovl_entry *oe = NULL;
+	struct cred *cred = (struct cred *)ofs->creator_cred;
 	int err;
 
-	err = -EIO;
-	if (WARN_ON(fc->user_ns != current_user_ns()))
-		goto out_err;
-
-	ovl_set_d_op(sb);
-
-	err = -ENOMEM;
-	if (!ofs->creator_cred)
-		ofs->creator_cred = cred = prepare_creds();
-	else
-		cred = (struct cred *)ofs->creator_cred;
-	if (!cred)
-		goto out_err;
-
-	old_cred = ovl_override_creds(sb);
-
-	err = ovl_fs_params_verify(ctx, &ofs->config);
+	err = ovl_fs_params_verify(fsctx, &ofs->config);
 	if (err)
-		goto out_err;
+		return err;
 
 	err = -EINVAL;
-	if (ctx->nr == 0) {
+	if (fsctx->nr == 0) {
 		if (!(fc->sb_flags & SB_SILENT))
 			pr_err("missing 'lowerdir'\n");
-		goto out_err;
+		return err;
 	}
 
 	err = -ENOMEM;
-	layers = kcalloc(ctx->nr + 1, sizeof(struct ovl_layer), GFP_KERNEL);
+	layers = kcalloc(fsctx->nr + 1, sizeof(struct ovl_layer), GFP_KERNEL);
 	if (!layers)
-		goto out_err;
+		return err;
 
-	ofs->config.lowerdirs = kcalloc(ctx->nr + 1, sizeof(char *), GFP_KERNEL);
+	ofs->config.lowerdirs = kcalloc(fsctx->nr + 1, sizeof(char *), GFP_KERNEL);
 	if (!ofs->config.lowerdirs) {
 		kfree(layers);
-		goto out_err;
+		return err;
 	}
 	ofs->layers = layers;
 	/*
@@ -1423,8 +1405,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * config.lowerdirs[0] is used for storing the user provided colon
 	 * separated lowerdir string.
 	 */
-	ofs->config.lowerdirs[0] = ctx->lowerdir_all;
-	ctx->lowerdir_all = NULL;
+	ofs->config.lowerdirs[0] = fsctx->lowerdir_all;
+	fsctx->lowerdir_all = NULL;
 	ofs->numlayer = 1;
 
 	sb->s_stack_depth = 0;
@@ -1448,12 +1430,12 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
-			goto out_err;
+			return err;
 		}
 
-		err = ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
+		err = ovl_get_upper(sb, ofs, &layers[0], &fsctx->upper);
 		if (err)
-			goto out_err;
+			return err;
 
 		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
 		if (!ovl_should_sync(ofs)) {
@@ -1461,13 +1443,13 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 			if (errseq_check(&upper_sb->s_wb_err, ofs->errseq)) {
 				err = -EIO;
 				pr_err("Cannot mount volatile when upperdir has an unseen error. Sync upperdir fs to clear state.\n");
-				goto out_err;
+				return err;
 			}
 		}
 
-		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
+		err = ovl_get_workdir(sb, ofs, &fsctx->upper, &fsctx->work);
 		if (err)
-			goto out_err;
+			return err;
 
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
@@ -1475,10 +1457,10 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
-	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
+	oe = ovl_get_lowerstack(sb, fsctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
-		goto out_err;
+		return err;
 
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
@@ -1489,11 +1471,11 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		ofs->config.uuid = OVL_UUID_NULL;
 	} else if (ovl_has_fsid(ofs) && ovl_upper_mnt(ofs)) {
 		/* Use per instance persistent uuid/fsid */
-		ovl_init_uuid_xattr(sb, ofs, &ctx->upper);
+		ovl_init_uuid_xattr(sb, ofs, &fsctx->upper);
 	}
 
 	if (!ovl_force_readonly(ofs) && ofs->config.index) {
-		err = ovl_get_indexdir(sb, ofs, oe, &ctx->upper);
+		err = ovl_get_indexdir(sb, ofs, oe, &fsctx->upper);
 		if (err)
 			goto out_free_oe;
 
@@ -1549,27 +1531,50 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_iflags |= SB_I_EVM_HMAC_UNSUPPORTED;
 
 	err = -ENOMEM;
-	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
-	if (!root_dentry)
+	sb->s_root = ovl_get_root(sb, fsctx->upper.dentry, oe);
+	if (!sb->s_root)
 		goto out_free_oe;
 
-	sb->s_root = root_dentry;
-
-	ovl_revert_creds(old_cred);
 	return 0;
 
 out_free_oe:
 	ovl_free_entry(oe);
+	return err;
+}
+
+int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+	const struct cred *old_cred = NULL;
+	struct cred *cred;
+	int err;
+
+	err = -EIO;
+	if (WARN_ON(fc->user_ns != current_user_ns()))
+		goto out_err;
+
+	ovl_set_d_op(sb);
+
+	err = -ENOMEM;
+	if (!ofs->creator_cred)
+		ofs->creator_cred = cred = prepare_creds();
+	else
+		cred = (struct cred *)ofs->creator_cred;
+	if (!cred)
+		goto out_err;
+
+	old_cred = ovl_override_creds(sb);
+
+	err = do_ovl_fill_super(sb, ofs, fc);
+
+	ovl_revert_creds(old_cred);
+
 out_err:
-	/*
-	 * Revert creds before calling ovl_free_fs() which will call
-	 * put_cred() and put_cred() requires that the cred's that are
-	 * put are not the caller's creds, i.e., current->cred.
-	 */
-	if (old_cred)
-		ovl_revert_creds(old_cred);
-	ovl_free_fs(ofs);
-	sb->s_fs_info = NULL;
+	if (err) {
+		ovl_free_fs(ofs);
+		sb->s_fs_info = NULL;
+	}
+
 	return err;
 }
 

-- 
2.47.3


