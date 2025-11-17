Return-Path: <linux-fsdevel+bounces-68668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26213C634A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D12C4ECB44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128032C930;
	Mon, 17 Nov 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3PgDCL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211C32D0DA;
	Mon, 17 Nov 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372070; cv=none; b=gqSJcMtZe+KtHg2KXbjdvPpiiLAmC1qF/pP+bYLIPy798q3VkGqL2qwMPhFOSKc9jtZpwdKcEEV0Mg7FHjTgedxvVRgHxZwP2UyTpE5z4hNXy45a5U/TylG4+inBTf+dnhutGQXhb3FX92VYPiYrPNmODvp6xtNHW9Mmp0jPiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372070; c=relaxed/simple;
	bh=pOQg8Mr/h6oElY/p1fQqADLlFV0+VeqOM3ClathSr6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZ/KAMmfFwvf4YR4qtJ38W5BMcZHXYKcnwChoU/H2pDg7uKLrJBnk7P1bolCX7HePvwXb/nShQmxXn7OUWMoJZ4IZNz3EJDlNkeKFomLaMSsKFzERfQMPXhdKyCPJsm4aTgfPe6U8+O7yZ5wcHaA0PO7L9QyFDlOU2gBxVxxSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3PgDCL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F8C4CEFB;
	Mon, 17 Nov 2025 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372069;
	bh=pOQg8Mr/h6oElY/p1fQqADLlFV0+VeqOM3ClathSr6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r3PgDCL2iqXfxQcvWNuLrO4tr6aeuxlq/dizHdNiHMQbxTks40aFtKJ0cC7qsJN/j
	 U2rpo8FclbWMD7/uYX3rA3C64AilhCu7c3Wjg/wGEu7/oEwPeMVCmaagnEUCEwE6Gm
	 zkPBv+0mFIXNHL3xs5ZqV9E2wznAZnjs0R41hURo9HXFZYCmo3swiDVF0pKWcIoiB3
	 P5+wqk3DIzJqwhcbQ1/qfn9lmWcrtnwuePjxp1iyUymXJ4hHpPyOS0PTqERmfSH/Ou
	 TQEgFx6K+jwtbJj14Ni14fPZ/Y4XKJmJUXhxcFUmGzbfNENbDz1onzxubqRasBnSbC
	 zGpo/t3IprM2A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:56 +0100
Subject: [PATCH v4 25/42] ovl: refactor ovl_iterate() and port to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-25-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pOQg8Mr/h6oElY/p1fQqADLlFV0+VeqOM3ClathSr6s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf4Wrnnb72lQwoyq/7ysHTP1Nz9RTSt9y7GiLOLW0
 eADnIUnOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiNJuRYeL8n9/cMz2end30
 +uc/nl6bD0tOBB5IP8C5eZr574Tr7kcYGc7f7bDeYnbul9u8tpbHzx5//Lpnle+UFYtPMy6PZdq
 6X4oRAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

factor out ovl_iterate_merged() and move some code into
ovl_iterate_real() for easier use of the scoped ovl cred guard.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 74 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 12f0bb1480d7..f24a044d1b61 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -832,44 +832,20 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	return err;
 }
 
-
-static int ovl_iterate(struct file *file, struct dir_context *ctx)
+static int ovl_iterate_merged(struct file *file, struct dir_context *ctx)
 {
 	struct ovl_dir_file *od = file->private_data;
 	struct dentry *dentry = file->f_path.dentry;
-	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_cache_entry *p;
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (!ctx->pos)
-		ovl_dir_reset(file);
-
-	if (od->is_real) {
-		/*
-		 * If parent is merge, then need to adjust d_ino for '..', if
-		 * dir is impure then need to adjust d_ino for copied up
-		 * entries.
-		 */
-		if (ovl_xino_bits(ofs) ||
-		    (ovl_same_fs(ofs) &&
-		     (ovl_is_impure_dir(file) ||
-		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
-			err = ovl_iterate_real(file, ctx);
-		} else {
-			err = iterate_dir(od->realfile, ctx);
-		}
-		goto out;
-	}
-
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
 		cache = ovl_cache_get(dentry);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
-			goto out;
+			return err;
 
 		od->cache = cache;
 		ovl_seek_cursor(od, ctx->pos);
@@ -881,7 +857,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 			if (!p->ino || p->check_xwhiteout) {
 				err = ovl_cache_update(&file->f_path, p, !p->ino);
 				if (err)
-					goto out;
+					return err;
 			}
 		}
 		/* ovl_cache_update() sets is_whiteout on stale entry */
@@ -892,12 +868,50 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		od->cursor = p->l_node.next;
 		ctx->pos++;
 	}
-	err = 0;
-out:
-	ovl_revert_creds(old_cred);
 	return err;
 }
 
+static bool ovl_need_adjust_d_ino(struct file *file)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+
+	/* If parent is merge, then need to adjust d_ino for '..' */
+	if (ovl_xino_bits(ofs))
+		return true;
+
+	/* Can't do consistent inode numbering */
+	if (!ovl_same_fs(ofs))
+		return false;
+
+	/* If dir is impure then need to adjust d_ino for copied up entries */
+	if (ovl_is_impure_dir(file) ||
+	    OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))
+		return true;
+
+	/* Pure: no need to adjust d_ino */
+	return false;
+}
+
+
+static int ovl_iterate(struct file *file, struct dir_context *ctx)
+{
+	struct ovl_dir_file *od = file->private_data;
+
+	if (!ctx->pos)
+		ovl_dir_reset(file);
+
+	with_ovl_creds(file_dentry(file)->d_sb) {
+		if (!od->is_real)
+			return ovl_iterate_merged(file, ctx);
+
+		if (ovl_need_adjust_d_ino(file))
+			return ovl_iterate_real(file, ctx);
+
+		return iterate_dir(od->realfile, ctx);
+	}
+}
+
 static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t res;

-- 
2.47.3


