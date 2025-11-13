Return-Path: <linux-fsdevel+bounces-68220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEDAC5791A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D623A4690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC2352F8F;
	Thu, 13 Nov 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g43MySvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8C352948;
	Thu, 13 Nov 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038957; cv=none; b=R9jH/JUdpQgf8doPgJBj+Ugb3BqLIH9TLqLx31vNk1JoszKpH2KvRJL1kI2XUQ1KrJJ73nGUSHM+gmhh7N2B1U9jC/GKOaB0ctjNqUK4r/EEiojm1PymR49I3XM0fe7lRzDtPNMLwjMLArMgdvPDgqquk1RFwrDiln0Y89TonUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038957; c=relaxed/simple;
	bh=+wKFbZIULBYNEmBhtPZO5molTQu4BdVHaPO1xDzSMzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjHrP+hxoogIBc0XYOde/mrE2myyoA53Ec6jnUPVGRt48oNqONatxM7GOq5VCJQotaFHdErdR39tpwoBLuWAI8wFfjkUvISzfr2MdJWezUtEmdUC4ThLALPdOljX/XWQHzj6EpRJvxRVbDAHk4IAWSuCuUBHF9fbPwyA2s47+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g43MySvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE814C2BC86;
	Thu, 13 Nov 2025 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038956;
	bh=+wKFbZIULBYNEmBhtPZO5molTQu4BdVHaPO1xDzSMzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g43MySvbxHWjqZJkbtrHwwtWW9sFMoZmxNOOMD09LGxz4wG62sn5C6LbmLYzwVrbf
	 3nqWRwhorqVnQtTPnbJq9wvjU/l9b4ZkN8z8a0MUPJMlem0waQnuIhCzkMfMsvkMcF
	 tDiKrTCDrTvlS6hgDcUu53hRQdjyijDxn+vU2oYmg3N6uBOYaKtwFob7JvfCQhZ3tD
	 xPjE00V/m4m2Uf60Q2EyF7lThqSkw2w5I2iYrUaSo/XXgcmhI1yG6h00WBKo7AwIQL
	 exugF4uMhEKzyxZ7O1nttfvxBi4jd2kTIX2AxPlqvO7YqV6iqF577mvH8egfX5fAKH
	 NVozFpkmnNDDA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:23 +0100
Subject: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+wKFbZIULBYNEmBhtPZO5molTQu4BdVHaPO1xDzSMzg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntU/PP3d59Cw9lHOtTPqEd+Lpd7mKry9GPe4uvq0
 flMS1NTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby5DEjw79zLlN+vbluKSLq
 bbdGw8pR6cehp5xTvhTmHAz7MjsuVYnhn/XSH/FxZbxLXH/uls+/NzE09FV0rZ9j12ntD6o5k87
 YMQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 71 ++++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a5e9ddf3023b..93b81d4b6fb1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -612,52 +612,45 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred, *new_cred = NULL;
+	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
-	/*
-	 * When linking a file with copy up origin into a new parent, mark the
-	 * new parent dir "impure".
-	 */
-	if (origin) {
-		err = ovl_set_impure(parent, ovl_dentry_upper(parent));
-		if (err)
-			goto out_revert_creds;
-	}
-
-	if (!attr->hardlink) {
+	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
 		/*
-		 * In the creation cases(create, mkdir, mknod, symlink),
-		 * ovl should transfer current's fs{u,g}id to underlying
-		 * fs. Because underlying fs want to initialize its new
-		 * inode owner using current's fs{u,g}id. And in this
-		 * case, the @inode is a new inode that is initialized
-		 * in inode_init_owner() to current's fs{u,g}id. So use
-		 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
-		 *
-		 * But in the other hardlink case, ovl_link() does not
-		 * create a new inode, so just use the ovl mounter's
-		 * fs{u,g}id.
+		 * When linking a file with copy up origin into a new parent, mark the
+		 * new parent dir "impure".
 		 */
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
-						     old_cred);
-		err = PTR_ERR(new_cred);
-		if (IS_ERR(new_cred)) {
-			new_cred = NULL;
-			goto out_revert_creds;
+		if (origin) {
+			err = ovl_set_impure(parent, ovl_dentry_upper(parent));
+			if (err)
+				return err;
 		}
-	}
 
-	if (!ovl_dentry_is_whiteout(dentry))
-		err = ovl_create_upper(dentry, inode, attr);
-	else
-		err = ovl_create_over_whiteout(dentry, inode, attr);
+		if (!attr->hardlink) {
+			/*
+			 * In the creation cases(create, mkdir, mknod, symlink),
+			 * ovl should transfer current's fs{u,g}id to underlying
+			 * fs. Because underlying fs want to initialize its new
+			 * inode owner using current's fs{u,g}id. And in this
+			 * case, the @inode is a new inode that is initialized
+			 * in inode_init_owner() to current's fs{u,g}id. So use
+			 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
+			 *
+			 * But in the other hardlink case, ovl_link() does not
+			 * create a new inode, so just use the ovl mounter's
+			 * fs{u,g}id.
+			 */
+			new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
+			if (IS_ERR(new_cred))
+				return PTR_ERR(new_cred);
+		}
 
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	put_cred(new_cred);
+		if (!ovl_dentry_is_whiteout(dentry))
+			return ovl_create_upper(dentry, inode, attr);
+
+		return ovl_create_over_whiteout(dentry, inode, attr);
+
+	}
 	return err;
 }
 

-- 
2.47.3


