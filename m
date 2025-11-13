Return-Path: <linux-fsdevel+bounces-68329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D861C5916D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20773563DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D535A949;
	Thu, 13 Nov 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chzns+6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC072ED151;
	Thu, 13 Nov 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051916; cv=none; b=uNjIKBFzS4nOArRDxzhn42+Y7PEckAsR8/auXEpiiyFJdkytjlfCJHpHyOVfTvpIWOlOSDq8x7hnCVZIUpXsRYRCCkf6VaXyOSWEXY82ct0mQbSRkOA7e091MayYy7MXywsqFbvXHbzoVuX/xqxCYKbJMmfdFm3EI8qaM1yFkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051916; c=relaxed/simple;
	bh=XfHoqgr/jOzada3r4+zw81o2vnc8LMPvDTKcPUIq/es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQoOOrEYRNza4eApGxc4eLciYiFLXY4gjoDREut4BJ387uyntWjL7XoVqFc7LXv9bESuRC9w8x/0HoR5AIkXT2rl6f0vcxH/sq5hH9yMcG9LE0YQXsQl6geR9PvL8AQmcr3OvwVAazNo1gPaGdVodooyesVQIc0HGLz24hf3WgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chzns+6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5712C4CEF7;
	Thu, 13 Nov 2025 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051916;
	bh=XfHoqgr/jOzada3r4+zw81o2vnc8LMPvDTKcPUIq/es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Chzns+6rqOzWqpjMiWJmofKmIj1dyZFatls3BQYnxmuhkX7XRPl5fQwa+sJB5GpTM
	 JqxbE4JlXlemXoVIMXaZfwGdbJb7Bab40uRQLWdsoJ4rcQbIZXQY+ek4hwNxHWR2At
	 qWBZdFs92Rj+GF+NsY+LbkRoCsR0eSig8F8sMt3a8W/j0wVS7d09qEqdsVyqwTFxDy
	 Trh2t8pA+5HyGC0BM1mEkjPMBG/adNeWv6aR1DaAVqhALZvQ3kRxvE3tqT1qdkOzMj
	 /pcSV6IbRo13CYU86wxILqbh0Ejcg1pEoC8bw3P4q1UhYRWArzwzldLjXFgU6z9tGk
	 S5KPGMI1deXBw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:41 +0100
Subject: [PATCH v2 36/42] ovl: refactor ovl_lookup()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-36-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14580; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XfHoqgr/jOzada3r4+zw81o2vnc8LMPvDTKcPUIq/es=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrvebHpVWEZ69kVs7/9mObEMa007nCHxK+Ku+Lbz
 LYmu30Q6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIVV6G/xn5TQca1u2/nxz3
 YI963qPVqrw7sidxCiXcuFTAZ5Gy9jQjw57pOi+Os6d1MF1MY7O68njB69e6j5e8v3t2A7PQBdG
 EQywA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split the core into a separate helper in preparation of converting the
caller to the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 314 ++++++++++++++++++++++++++-------------------------
 1 file changed, 161 insertions(+), 153 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 49874525cf52..4368f9f6ff9c 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1070,57 +1070,44 @@ static bool ovl_check_follow_redirect(struct ovl_lookup_data *d)
 	return true;
 }
 
-struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
-			  unsigned int flags)
+struct ovl_lookup_ctx {
+	struct dentry *dentry;
+	struct ovl_entry *oe;
+	struct ovl_path *stack;
+	struct ovl_path *origin_path;
+	struct dentry *upperdentry;
+	struct dentry *index;
+	struct inode *inode;
+	unsigned int ctr;
+};
+
+static int do_ovl_lookup(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 {
-	struct ovl_entry *oe = NULL;
-	const struct cred *old_cred;
+	struct dentry *dentry = ctx->dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	struct ovl_entry *roe = OVL_E(dentry->d_sb->s_root);
-	struct ovl_path *stack = NULL, *origin_path = NULL;
-	struct dentry *upperdir, *upperdentry = NULL;
-	struct dentry *origin = NULL;
-	struct dentry *index = NULL;
-	unsigned int ctr = 0;
-	struct inode *inode = NULL;
-	bool upperopaque = false;
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	struct dentry *upperdir;
 	struct dentry *this;
-	unsigned int i;
-	int err;
+	struct dentry *origin = NULL;
+	bool upperopaque = false;
 	bool uppermetacopy = false;
 	int metacopy_size = 0;
-	struct ovl_lookup_data d = {
-		.sb = dentry->d_sb,
-		.dentry = dentry,
-		.name = dentry->d_name,
-		.is_dir = false,
-		.opaque = false,
-		.stop = false,
-		.last = check_redirect ? false : !ovl_numlower(poe),
-		.redirect = NULL,
-		.upperredirect = NULL,
-		.metacopy = 0,
-	};
-
-	if (dentry->d_name.len > ofs->namelen)
-		return ERR_PTR(-ENAMETOOLONG);
+	unsigned int i;
+	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
-		d.layer = &ofs->layers[0];
-		err = ovl_lookup_layer(upperdir, &d, &upperdentry, true);
+		d->layer = &ofs->layers[0];
+		err = ovl_lookup_layer(upperdir, d, &ctx->upperdentry, true);
 		if (err)
-			goto out;
+			return err;
 
-		if (upperdentry && upperdentry->d_flags & DCACHE_OP_REAL) {
-			dput(upperdentry);
-			err = -EREMOTE;
-			goto out;
-		}
-		if (upperdentry && !d.is_dir) {
+		if (ctx->upperdentry && ctx->upperdentry->d_flags & DCACHE_OP_REAL)
+			return -EREMOTE;
+
+		if (ctx->upperdentry && !d->is_dir) {
 			/*
 			 * Lookup copy up origin by decoding origin file handle.
 			 * We may get a disconnected dentry, which is fine,
@@ -1131,50 +1118,50 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			 * number - it's the same as if we held a reference
 			 * to a dentry in lower layer that was moved under us.
 			 */
-			err = ovl_check_origin(ofs, upperdentry, &origin_path);
+			err = ovl_check_origin(ofs, ctx->upperdentry, &ctx->origin_path);
 			if (err)
-				goto out_put_upper;
+				return err;
 
-			if (d.metacopy)
+			if (d->metacopy)
 				uppermetacopy = true;
-			metacopy_size = d.metacopy;
+			metacopy_size = d->metacopy;
 		}
 
-		if (d.redirect) {
+		if (d->redirect) {
 			err = -ENOMEM;
-			d.upperredirect = kstrdup(d.redirect, GFP_KERNEL);
-			if (!d.upperredirect)
-				goto out_put_upper;
-			if (d.redirect[0] == '/')
+			d->upperredirect = kstrdup(d->redirect, GFP_KERNEL);
+			if (!d->upperredirect)
+				return err;
+			if (d->redirect[0] == '/')
 				poe = roe;
 		}
-		upperopaque = d.opaque;
+		upperopaque = d->opaque;
 	}
 
-	if (!d.stop && ovl_numlower(poe)) {
+	if (!d->stop && ovl_numlower(poe)) {
 		err = -ENOMEM;
-		stack = ovl_stack_alloc(ofs->numlayer - 1);
-		if (!stack)
-			goto out_put_upper;
+		ctx->stack = ovl_stack_alloc(ofs->numlayer - 1);
+		if (!ctx->stack)
+			return err;
 	}
 
-	for (i = 0; !d.stop && i < ovl_numlower(poe); i++) {
+	for (i = 0; !d->stop && i < ovl_numlower(poe); i++) {
 		struct ovl_path lower = ovl_lowerstack(poe)[i];
 
-		if (!ovl_check_follow_redirect(&d)) {
+		if (!ovl_check_follow_redirect(d)) {
 			err = -EPERM;
-			goto out_put;
+			return err;
 		}
 
 		if (!check_redirect)
-			d.last = i == ovl_numlower(poe) - 1;
-		else if (d.is_dir || !ofs->numdatalayer)
-			d.last = lower.layer->idx == ovl_numlower(roe);
+			d->last = i == ovl_numlower(poe) - 1;
+		else if (d->is_dir || !ofs->numdatalayer)
+			d->last = lower.layer->idx == ovl_numlower(roe);
 
-		d.layer = lower.layer;
-		err = ovl_lookup_layer(lower.dentry, &d, &this, false);
+		d->layer = lower.layer;
+		err = ovl_lookup_layer(lower.dentry, d, &this, false);
 		if (err)
-			goto out_put;
+			return err;
 
 		if (!this)
 			continue;
@@ -1183,11 +1170,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * If no origin fh is stored in upper of a merge dir, store fh
 		 * of lower dir and set upper parent "impure".
 		 */
-		if (upperdentry && !ctr && !ofs->noxattr && d.is_dir) {
-			err = ovl_fix_origin(ofs, dentry, this, upperdentry);
+		if (ctx->upperdentry && !ctx->ctr && !ofs->noxattr && d->is_dir) {
+			err = ovl_fix_origin(ofs, dentry, this, ctx->upperdentry);
 			if (err) {
 				dput(this);
-				goto out_put;
+				return err;
 			}
 		}
 
@@ -1200,23 +1187,23 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * matches the dentry found using path based lookup,
 		 * otherwise error out.
 		 */
-		if (upperdentry && !ctr &&
-		    ((d.is_dir && ovl_verify_lower(dentry->d_sb)) ||
-		     (!d.is_dir && ofs->config.index && origin_path))) {
-			err = ovl_verify_origin(ofs, upperdentry, this, false);
+		if (ctx->upperdentry && !ctx->ctr &&
+		    ((d->is_dir && ovl_verify_lower(dentry->d_sb)) ||
+		     (!d->is_dir && ofs->config.index && ctx->origin_path))) {
+			err = ovl_verify_origin(ofs, ctx->upperdentry, this, false);
 			if (err) {
 				dput(this);
-				if (d.is_dir)
+				if (d->is_dir)
 					break;
-				goto out_put;
+				return err;
 			}
 			origin = this;
 		}
 
-		if (!upperdentry && !d.is_dir && !ctr && d.metacopy)
-			metacopy_size = d.metacopy;
+		if (!ctx->upperdentry && !d->is_dir && !ctx->ctr && d->metacopy)
+			metacopy_size = d->metacopy;
 
-		if (d.metacopy && ctr) {
+		if (d->metacopy && ctx->ctr) {
 			/*
 			 * Do not store intermediate metacopy dentries in
 			 * lower chain, except top most lower metacopy dentry.
@@ -1226,15 +1213,15 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			dput(this);
 			this = NULL;
 		} else {
-			stack[ctr].dentry = this;
-			stack[ctr].layer = lower.layer;
-			ctr++;
+			ctx->stack[ctx->ctr].dentry = this;
+			ctx->stack[ctx->ctr].layer = lower.layer;
+			ctx->ctr++;
 		}
 
-		if (d.stop)
+		if (d->stop)
 			break;
 
-		if (d.redirect && d.redirect[0] == '/' && poe != roe) {
+		if (d->redirect && d->redirect[0] == '/' && poe != roe) {
 			poe = roe;
 			/* Find the current layer on the root dentry */
 			i = lower.layer->idx - 1;
@@ -1245,12 +1232,12 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	 * Defer lookup of lowerdata in data-only layers to first access.
 	 * Don't require redirect=follow and metacopy=on in this case.
 	 */
-	if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect) {
-		d.metacopy = 0;
-		ctr++;
-	} else if (!ovl_check_follow_redirect(&d)) {
+	if (d->metacopy && ctx->ctr && ofs->numdatalayer && d->absolute_redirect) {
+		d->metacopy = 0;
+		ctx->ctr++;
+	} else if (!ovl_check_follow_redirect(d)) {
 		err = -EPERM;
-		goto out_put;
+		return err;
 	}
 
 	/*
@@ -1261,20 +1248,20 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	 * For metacopy dentry, path based lookup will find lower dentries.
 	 * Just make sure a corresponding data dentry has been found.
 	 */
-	if (d.metacopy || (uppermetacopy && !ctr)) {
+	if (d->metacopy || (uppermetacopy && !ctx->ctr)) {
 		pr_warn_ratelimited("metacopy with no lower data found - abort lookup (%pd2)\n",
 				    dentry);
 		err = -EIO;
-		goto out_put;
-	} else if (!d.is_dir && upperdentry && !ctr && origin_path) {
-		if (WARN_ON(stack != NULL)) {
+		return err;
+	} else if (!d->is_dir && ctx->upperdentry && !ctx->ctr && ctx->origin_path) {
+		if (WARN_ON(ctx->stack != NULL)) {
 			err = -EIO;
-			goto out_put;
+			return err;
 		}
-		stack = origin_path;
-		ctr = 1;
-		origin = origin_path->dentry;
-		origin_path = NULL;
+		ctx->stack = ctx->origin_path;
+		ctx->ctr = 1;
+		origin = ctx->origin_path->dentry;
+		ctx->origin_path = NULL;
 	}
 
 	/*
@@ -1296,38 +1283,39 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	 * is enabled and if upper had an ORIGIN xattr.
 	 *
 	 */
-	if (!upperdentry && ctr)
-		origin = stack[0].dentry;
+	if (!ctx->upperdentry && ctx->ctr)
+		origin = ctx->stack[0].dentry;
 
 	if (origin && ovl_indexdir(dentry->d_sb) &&
-	    (!d.is_dir || ovl_index_all(dentry->d_sb))) {
-		index = ovl_lookup_index(ofs, upperdentry, origin, true);
-		if (IS_ERR(index)) {
-			err = PTR_ERR(index);
-			index = NULL;
-			goto out_put;
+	    (!d->is_dir || ovl_index_all(dentry->d_sb))) {
+		ctx->index = ovl_lookup_index(ofs, ctx->upperdentry, origin, true);
+		if (IS_ERR(ctx->index)) {
+			err = PTR_ERR(ctx->index);
+			ctx->index = NULL;
+			return err;
 		}
 	}
 
-	if (ctr) {
-		oe = ovl_alloc_entry(ctr);
+	if (ctx->ctr) {
+		ctx->oe = ovl_alloc_entry(ctx->ctr);
 		err = -ENOMEM;
-		if (!oe)
-			goto out_put;
+		if (!ctx->oe)
+			return err;
 
-		ovl_stack_cpy(ovl_lowerstack(oe), stack, ctr);
+		ovl_stack_cpy(ovl_lowerstack(ctx->oe), ctx->stack, ctx->ctr);
 	}
 
 	if (upperopaque)
 		ovl_dentry_set_opaque(dentry);
-	if (d.xwhiteouts)
+	if (d->xwhiteouts)
 		ovl_dentry_set_xwhiteouts(dentry);
 
-	if (upperdentry)
+	if (ctx->upperdentry)
 		ovl_dentry_set_upper_alias(dentry);
-	else if (index) {
+	else if (ctx->index) {
+		char *upperredirect;
 		struct path upperpath = {
-			.dentry = upperdentry = dget(index),
+			.dentry = ctx->upperdentry = dget(ctx->index),
 			.mnt = ovl_upper_mnt(ofs),
 		};
 
@@ -1336,77 +1324,97 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * assignment happens only if upperdentry is non-NULL, and
 		 * this one only if upperdentry is NULL.
 		 */
-		d.upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
-		if (IS_ERR(d.upperredirect)) {
-			err = PTR_ERR(d.upperredirect);
-			d.upperredirect = NULL;
-			goto out_free_oe;
-		}
+		upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
+		if (IS_ERR(upperredirect))
+			return PTR_ERR(upperredirect);
+		d->upperredirect = upperredirect;
 
 		err = ovl_check_metacopy_xattr(ofs, &upperpath, NULL);
 		if (err < 0)
-			goto out_free_oe;
-		d.metacopy = uppermetacopy = err;
+			return err;
+		d->metacopy = uppermetacopy = err;
 		metacopy_size = err;
 
-		if (!ovl_check_follow_redirect(&d)) {
+		if (!ovl_check_follow_redirect(d)) {
 			err = -EPERM;
-			goto out_free_oe;
+			return err;
 		}
 	}
 
-	if (upperdentry || ctr) {
+	if (ctx->upperdentry || ctx->ctr) {
+		struct inode *inode;
 		struct ovl_inode_params oip = {
-			.upperdentry = upperdentry,
-			.oe = oe,
-			.index = index,
-			.redirect = d.upperredirect,
+			.upperdentry = ctx->upperdentry,
+			.oe = ctx->oe,
+			.index = ctx->index,
+			.redirect = d->upperredirect,
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctr > 1 && !d.is_dir && !stack[ctr - 1].dentry) {
-			oip.lowerdata_redirect = d.redirect;
-			d.redirect = NULL;
+		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry) {
+			oip.lowerdata_redirect = d->redirect;
+			d->redirect = NULL;
 		}
+
 		inode = ovl_get_inode(dentry->d_sb, &oip);
-		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
-			goto out_free_oe;
-		if (upperdentry && !uppermetacopy)
-			ovl_set_flag(OVL_UPPERDATA, inode);
+			return PTR_ERR(inode);
+
+		ctx->inode = inode;
+		if (ctx->upperdentry && !uppermetacopy)
+			ovl_set_flag(OVL_UPPERDATA, ctx->inode);
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
-			ovl_set_flag(OVL_HAS_DIGEST, inode);
+			ovl_set_flag(OVL_HAS_DIGEST, ctx->inode);
 	}
 
-	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
+	ovl_dentry_init_reval(dentry, ctx->upperdentry, OVL_I_E(ctx->inode));
+
+	return 0;
+}
+
+struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
+			  unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct ovl_entry *poe = OVL_E(dentry->d_parent);
+	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	int err;
+	struct ovl_lookup_ctx ctx = {
+		.dentry = dentry,
+	};
+	struct ovl_lookup_data d = {
+		.sb	= dentry->d_sb,
+		.dentry = dentry,
+		.name	= dentry->d_name,
+		.last	= check_redirect ? false : !ovl_numlower(poe),
+	};
+
+	if (dentry->d_name.len > ofs->namelen)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+
+	err = do_ovl_lookup(&ctx, &d);
 
 	ovl_revert_creds(old_cred);
-	if (origin_path) {
-		dput(origin_path->dentry);
-		kfree(origin_path);
+	if (ctx.origin_path) {
+		dput(ctx.origin_path->dentry);
+		kfree(ctx.origin_path);
 	}
-	dput(index);
-	ovl_stack_free(stack, ctr);
+	dput(ctx.index);
+	ovl_stack_free(ctx.stack, ctx.ctr);
 	kfree(d.redirect);
-	return d_splice_alias(inode, dentry);
 
-out_free_oe:
-	ovl_free_entry(oe);
-out_put:
-	dput(index);
-	ovl_stack_free(stack, ctr);
-out_put_upper:
-	if (origin_path) {
-		dput(origin_path->dentry);
-		kfree(origin_path);
-	}
-	dput(upperdentry);
+	if (err) {
+		ovl_free_entry(ctx.oe);
+		dput(ctx.upperdentry);
 		kfree(d.upperredirect);
-out:
-	kfree(d.redirect);
-	ovl_revert_creds(old_cred);
 		return ERR_PTR(err);
+	}
+
+	return d_splice_alias(ctx.inode, dentry);
 }
 
 bool ovl_lower_positive(struct dentry *dentry)

-- 
2.47.3


