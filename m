Return-Path: <linux-fsdevel+bounces-68236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C58DC57950
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F073A9861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBA352933;
	Thu, 13 Nov 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPI3Alet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8B35292A;
	Thu, 13 Nov 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038985; cv=none; b=jXdi1q8O+ddWCy4VxrYcVE5ktM7Ssor2pnMb0e+vYYe+pE002Adaa0vMkvhZbBUO7cVw0ggcHGbsGrhWaX8pmFucMlbykEXc75Jmy9zOG4EHRCna9AjAlIajpWKBrBqO8+sr6aVvwit9O94yuNUPgXXtrnng6eNhn8Vk4vnv+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038985; c=relaxed/simple;
	bh=miFKXa2hcztIPvCpNGDRlnZgy6iefln/j266Ln6mDKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oR77xOrc9HQ6iXmj80YA8/mlkL+dgZr0pLEMDQVe8VZI0x4q6JjFHYABHd0Ma+apr4OMANGt4eqSRlC2veKL1DcrQDPn+rlF6qhuBJsIcnle0Qg+aGIxkEygDYNfXxKXVSJLcTezBi8hpHq2ZfsVWCcc8zHarvaAzAja1kTTCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPI3Alet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C312EC4CEF8;
	Thu, 13 Nov 2025 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038985;
	bh=miFKXa2hcztIPvCpNGDRlnZgy6iefln/j266Ln6mDKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PPI3Alet+nHLiTQmfCBKA6LQ7pq+r2L5Lkio5iBcrxZj2nK8ErzyPpvKCmWzXEkEE
	 qz93qcxnTPHK8O4MGa2U3Y+tnZOts5bc3lAwH36YOP62N8IKzqH0LOXZHkXjN8fHuM
	 T99c4S+CJfbqp4qzK3YQIIfzkXPeRSFNsM5viGIxpB9e1+w6AwbF9V6u1shvRILXLV
	 SQidqFa7KLvexFx310P4wle7ABGOtucMA1FMS3gwIzOy2B16liTUoYxnhoi5Xz1Lm9
	 Vh4CcqaTypyhuOz5DHeNwUtNcBSM1K9CmAr327amWZoM5R7UNObmlMjVY6s8A98l+M
	 ++yBDcYHjqgmA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:39 +0100
Subject: [PATCH RFC 19/42] ovl: port ovl_set_or_remove_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-19-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=brauner@kernel.org;
 h=from:subject:message-id; bh=miFKXa2hcztIPvCpNGDRlnZgy6iefln/j266Ln6mDKg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnscX/tUvl30wDnZ7a97ehsPm61eILP9VLHF18lK8
 Wfr2aZP7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI5FWGX8y/u27si/7S/m+q
 QHDCS0175r6rUpMcGXaeWv7sxH7Gk7yMDAf/z/v5/pOylHGtC9sO2fd18wrXn9c6HiC2Y9/XXxp
 qWWwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 1e74b3d9b7f3..e6d6cfd9335d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -474,7 +474,6 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	int err;
 	struct path realpath;
 	const char *acl_name;
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
@@ -488,10 +487,8 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
-				       acl_name);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(dentry->d_sb)
+			real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry, acl_name);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -511,12 +508,12 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (acl)
-		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
-	else
-		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb) {
+		if (acl)
+			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+		else
+			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3


