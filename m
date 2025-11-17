Return-Path: <linux-fsdevel+bounces-68683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF1C634C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 818954EC4A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D132E721;
	Mon, 17 Nov 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVi/KPHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15A328262;
	Mon, 17 Nov 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372096; cv=none; b=nEUgAZogxeipBgMbT58N4AxU1Dyz8KCPE+UkUUlnxXxdf5CoVRnhPepBccFE7Vz7C5LIJr68RzbrG42dUyPmsmzNG0wPu63c7Z4hWi/noMV7omtbRS/YuvRWS3D5mQ4d7lQlMPz2jX3YUA2PSAGKXR0DFuXBwC67GbKb/MFC56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372096; c=relaxed/simple;
	bh=R04r3O0eKe+XrSbJ//aU01VPaUr+vWuM38gssByg++I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxU1U45C1GzLqhNaQzwVng3zs4+Jpuz91oWaSR7jzz8Q2Sl5NEEXUbw48fqvZWkNS3jfqoLcu5Z6n61/cOWIFHaGou1hhF7M+QXvsG9egPNYR7+PJhapaFjt81pJyaUS/5tgTxTG2TXiyI0DS+trHYP0vyyNhyOSFZYJO8+ixhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVi/KPHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A65C113D0;
	Mon, 17 Nov 2025 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372096;
	bh=R04r3O0eKe+XrSbJ//aU01VPaUr+vWuM38gssByg++I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bVi/KPHEIGJyY/vniq5pyjLdh/pjQVZlUnCNLyqZkgA3ezhuJWWI+fpZ6xnQom0fq
	 uWsGhYnty/G+nojHIrJ1L9BUBUDeAjP5cLKYR0gOdlkUh3ZvTiWWRkuo4nxD67klmw
	 Iao7BEEmEZWOGYUpaqoh3G3vDHnKgJ6rvyg17jCE3naPR+pDnfVie3tCdT4QwRszSx
	 2h/vNpKlUCmL17ZbPgDoEoRZUp4kEIkM/8mlq2lihwqUOEqi30rzJzTsl27ItMmkrr
	 MFy5EoyV+7vZS2+ix7spIcc4AB8ON2JJwbPFs8UEbhKSmXP4tERno/v0eyLGAygRrb
	 P5TnE84WEOlFw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:11 +0100
Subject: [PATCH v4 40/42] ovl: refactor ovl_fill_super()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-40-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5110; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R04r3O0eKe+XrSbJ//aU01VPaUr+vWuM38gssByg++I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6+3nS3SovXJqf7tZM2CRhxLJR27V3x7PFa652nG
 q++PLZhbUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEPk1h+F9mLLR4X36+9fzj
 r649/R/Jd2ypidibefeWue+60NXz68dBht9sG8Tusb5eOsXnkcCVks87VvtHbvGaY3aAz57pc8H
 Vy1+YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split the core into a separate helper in preparation of converting the
caller to the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 91 +++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 43ee4c7296a7..e3781fccaef8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1369,53 +1369,35 @@ static void ovl_set_d_op(struct super_block *sb)
 	set_default_d_op(sb, &ovl_dentry_operations);
 }
 
-int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
+static int do_ovl_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
+	struct cred *creator_cred = (struct cred *)ofs->creator_cred;
 	struct ovl_fs_context *ctx = fc->fs_private;
-	const struct cred *old_cred = NULL;
-	struct dentry *root_dentry;
-	struct ovl_entry *oe;
 	struct ovl_layer *layers;
-	struct cred *cred;
+	struct ovl_entry *oe = NULL;
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
 	err = ovl_fs_params_verify(ctx, &ofs->config);
 	if (err)
-		goto out_err;
+		return err;
 
 	err = -EINVAL;
 	if (ctx->nr == 0) {
 		if (!(fc->sb_flags & SB_SILENT))
 			pr_err("missing 'lowerdir'\n");
-		goto out_err;
+		return err;
 	}
 
 	err = -ENOMEM;
 	layers = kcalloc(ctx->nr + 1, sizeof(struct ovl_layer), GFP_KERNEL);
 	if (!layers)
-		goto out_err;
+		return err;
 
 	ofs->config.lowerdirs = kcalloc(ctx->nr + 1, sizeof(char *), GFP_KERNEL);
 	if (!ofs->config.lowerdirs) {
 		kfree(layers);
-		goto out_err;
+		return err;
 	}
 	ofs->layers = layers;
 	/*
@@ -1448,12 +1430,12 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
-			goto out_err;
+			return err;
 		}
 
 		err = ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
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
 
 		err = ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work);
 		if (err)
-			goto out_err;
+			return err;
 
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
@@ -1478,7 +1460,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
-		goto out_err;
+		return err;
 
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
@@ -1531,7 +1513,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_export_op = &ovl_export_fid_operations;
 
 	/* Never override disk quota limits or use reserved space */
-	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
+	cap_lower(creator_cred->cap_effective, CAP_SYS_RESOURCE);
 
 	sb->s_magic = OVERLAYFS_SUPER_MAGIC;
 	sb->s_xattr = ovl_xattr_handlers(ofs);
@@ -1549,27 +1531,50 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_iflags |= SB_I_EVM_HMAC_UNSUPPORTED;
 
 	err = -ENOMEM;
-	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
-	if (!root_dentry)
+	sb->s_root = ovl_get_root(sb, ctx->upper.dentry, oe);
+	if (!sb->s_root)
 		goto out_free_oe;
 
-	sb->s_root = root_dentry;
-
-	ovl_revert_creds(old_cred);
 	return 0;
 
 out_free_oe:
 	ovl_free_entry(oe);
-out_err:
-	/*
-	 * Revert creds before calling ovl_free_fs() which will call
-	 * put_cred() and put_cred() requires that the cred's that are
-	 * put are not the caller's creds, i.e., current->cred.
-	 */
-	if (old_cred)
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
+	err = do_ovl_fill_super(fc, sb);
+
 	ovl_revert_creds(old_cred);
+
+out_err:
+	if (err) {
 		ovl_free_fs(ofs);
 		sb->s_fs_info = NULL;
+	}
+
 	return err;
 }
 

-- 
2.47.3


