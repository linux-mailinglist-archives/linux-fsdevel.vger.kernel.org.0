Return-Path: <linux-fsdevel+bounces-70815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88657CA7F71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD02C315D18E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F9232E746;
	Fri,  5 Dec 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3kwLJH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0A2594BD;
	Fri,  5 Dec 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936668; cv=none; b=pgoDO4ONBAhCiu6Y8sVH0hVBte0l456WFvj1xp6DMerpCnKxRyHtJ8jTVR+vBJV4qoCfaFSi8muvM2Ytz7XPvfxsTeI1GsbH026cLOCeL11kzbuU2jj4tQhFn3IIaag6Ao+MlTJG7Ec48Q7tsWoraY2gxCbrD43GEz+xtEqfRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936668; c=relaxed/simple;
	bh=qPy93lNl4VrEcBW4b9BbU+rZ+pDjqFLmvesRdzyVW78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PraTKfDPC656wq+rt2+73RAdMafV0RI1efegw5dyymceVMoen3pvlHDlF3DZgvD4MZ3TMb/j4ZD43zFQAsfoyT7uDqzN35ydBU55L0uwsfcjhBbFqf8UxVOVVQ7Dd+NOMCN2IsKkoTzuNkTNJU4SaGzenmMiFbCWdnguAN3zKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3kwLJH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78236C4CEF1;
	Fri,  5 Dec 2025 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764936666;
	bh=qPy93lNl4VrEcBW4b9BbU+rZ+pDjqFLmvesRdzyVW78=;
	h=From:To:Cc:Subject:Date:From;
	b=K3kwLJH0+qFZiouswYVTpI5AmhJDqNDWlsvMi7YZfth3+KTx3sd+eoe0L2Z0JjTfu
	 NG+CKLVoJ76h78YV1jjIo1zKvKdWB0ZvsxhGYAP5QhAH2CcdUd9IF2keaR5Tm+cJsS
	 Q/SWaip2nr0vv59V7eIEh8SByIGpKS/Os4ScmGX72CFetHwSQP4s28PSrNpqf2Aqo8
	 jZlekUY9qRGiDTfgyaCBIpcOBbUNpPnLLRUkdGDFmqdWHEhjJPIv4P7NMiSd7N1Q4a
	 gpFccpHBjReGNgQsufe2iXQlTi/UsYxWt/O542jn9qeZ/36F1tbm5wkg39PjwSD1xX
	 NuQ17XrepqpQw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: pass original credentials, not mounter credentials during create
Date: Fri,  5 Dec 2025 13:10:48 +0100
Message-ID: <20251205-tortur-amtieren-1273b2eef469@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3633; i=brauner@kernel.org; h=from:subject:message-id; bh=qPy93lNl4VrEcBW4b9BbU+rZ+pDjqFLmvesRdzyVW78=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQanb406XIk6961E/k+p9dqac57us2oXO7aBIGd94OM2 pcye6U1dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEs42R4T6LxaeVn3OK7ns8 SWFOXSdW/k9BWM2wTfFdUu/CUmmtZwz/KwL6PbeKRy/f5z1xQn3s4o2XPqrVznfwuJawa0lX9Nw ZfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When creating new files the security layer expects the original
credentials to be passed. When cleaning up the code this was accidently
changed to pass the mounter's credentials by relying on current->cred
which is already overriden at this point. Pass the original credentials
directly.

Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Reported-by: Paul Moore <paul@paul-moore.com>
Fixes: e566bff96322 ("ovl: port ovl_create_or_link() to new ovl_override_creator_creds")
Link: https://lore.kernel.org/CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvzAAbFij8Q@mail.gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 06b860b9ded6..ff3dbd1ca61f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -581,7 +581,8 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
-static const struct cred *ovl_override_creator_creds(struct dentry *dentry, struct inode *inode, umode_t mode)
+static const struct cred *ovl_override_creator_creds(const struct cred *original_creds,
+						     struct dentry *dentry, struct inode *inode, umode_t mode)
 {
 	int err;
 
@@ -596,7 +597,7 @@ static const struct cred *ovl_override_creator_creds(struct dentry *dentry, stru
 	override_cred->fsgid = inode->i_gid;
 
 	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
-					      current->cred, override_cred);
+					      original_creds, override_cred);
 	if (err)
 		return ERR_PTR(err);
 
@@ -614,8 +615,11 @@ static void ovl_revert_creator_creds(const struct cred *old_cred)
 DEFINE_CLASS(ovl_override_creator_creds,
 	     const struct cred *,
 	     if (!IS_ERR_OR_NULL(_T)) ovl_revert_creator_creds(_T),
-	     ovl_override_creator_creds(dentry, inode, mode),
-	     struct dentry *dentry, struct inode *inode, umode_t mode)
+	     ovl_override_creator_creds(original_creds, dentry, inode, mode),
+	     const struct cred *original_creds,
+	     struct dentry *dentry,
+	     struct inode *inode,
+	     umode_t mode)
 
 static int ovl_create_handle_whiteouts(struct dentry *dentry,
 				       struct inode *inode,
@@ -633,7 +637,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct dentry *parent = dentry->d_parent;
 
-	with_ovl_creds(dentry->d_sb) {
+	scoped_class(override_creds_ovl, original_creds, dentry->d_sb) {
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -661,7 +665,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		if (attr->hardlink)
 			return ovl_create_handle_whiteouts(dentry, inode, attr);
 
-		scoped_class(ovl_override_creator_creds, cred, dentry, inode, attr->mode) {
+		scoped_class(ovl_override_creator_creds, cred, original_creds, dentry, inode, attr->mode) {
 			if (IS_ERR(cred))
 				return PTR_ERR(cred);
 			return ovl_create_handle_whiteouts(dentry, inode, attr);
@@ -1364,8 +1368,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int err;
 
-	with_ovl_creds(dentry->d_sb) {
-		scoped_class(ovl_override_creator_creds, cred, dentry, inode, mode) {
+	scoped_class(override_creds_ovl, original_creds, dentry->d_sb) {
+		scoped_class(ovl_override_creator_creds, cred, original_creds, dentry, inode, mode) {
 			if (IS_ERR(cred))
 				return PTR_ERR(cred);
 
-- 
2.47.3


