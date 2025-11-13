Return-Path: <linux-fsdevel+bounces-68386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A3C5A3C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12D294F4499
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078F32863F;
	Thu, 13 Nov 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk01gkFm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E8328608;
	Thu, 13 Nov 2025 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069585; cv=none; b=LhennT7/zN/mg4Iiry0eglf+OSwqNIlm6QJqNmWgLNkA6OHapjw+Lg6Thv4/MkKcnfRNx5LR50/VMqyGV8LOqAFFfjmA+8PFM2d3dUtZZoLWuSSx1e34KGHld6BR2Nwtq5cLjUWe2k8IiF7jleyE//8Mau2zNaqNArH/uXv0MWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069585; c=relaxed/simple;
	bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+o6nJRP53JVZ8q1J/xhE0g7dHrJu7W9Of1a6eW7ehyUbt5bgR1v5WPd70jZHoGqaeyqNnKwvzgT6u5cSacC0XTiU2BP3EZuwY/c//L7T2TwHsvovoG4ySrNEYq+zklnfAGDOYcgZ65avFTHEQq+gy/Fwu9XhE7Q3UoqIaTS+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk01gkFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63194C4CEF5;
	Thu, 13 Nov 2025 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069584;
	bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qk01gkFmLDxU6rkWTbMF/+plSqYuIaRwT2snTRid9AgI4XNjAiQ7zyRYqEKDSiOZ3
	 QP+gZwuzODVuscm2RL+zeqr6l5Pzl3m0oUupqES15E666ZKvrWz1pgBGwJzJnKDyAN
	 YuLdR8WZfJATKU7/oySk9kA/oI2mlt45mRZFmu/RTx/sb/LSdh+xKtjpkTGRMLENlG
	 9kQbBZQv3bgunI7r2Jc6uVbMrlN+DpowBcLoPzwrLU/aomOkKrYT7HcU8LCVjZcmjw
	 AeAuAj6fg/4aBh7nu2s/KygJR9bnV0qegVT+k7TVf7pf/xawxPPhdnM/VTbe9D9Lib
	 JyMQs8dYebWEA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:13 +0100
Subject: [PATCH v3 30/42] ovl: port ovl_xattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-30-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YPdns7qIIaifTfKk3Q1MjYul7fyQK40wsVqjnYaivfQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YWv/lmezrvun7ts7VpRd7WJvhqhK96fX96REqK4i
 WPZxa2HOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYypYfhn/KHJMNTwsqx3Oc+
 zsyYlsKwKHqzwpdu5qaOGQuNhHPLLjD8U2vas//v83lbK8ISpJ8n2a13vLtDb0dAr7GI2o8Vr09
 cYgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 88055deca936..787df86acb26 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -41,13 +41,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		ovl_revert_creds(old_cred);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +62,14 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size, flags);
 		} else {
 			WARN_ON(flags != XATTR_REPLACE);
 			err = ovl_do_removexattr(ofs, realdentry, name);
 		}
-	ovl_revert_creds(old_cred);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3


