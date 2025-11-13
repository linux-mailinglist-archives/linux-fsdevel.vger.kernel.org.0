Return-Path: <linux-fsdevel+bounces-68311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E83C5943D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03BEA5635E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9FB35E550;
	Thu, 13 Nov 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2/1QTvh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC635A933;
	Thu, 13 Nov 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051883; cv=none; b=sLfnoYowPuHzWkGU8yuOeiCyF2tXN5SBTw+lxyL6CZWko+GYlIohxdeuUB9F2amnbQlaJ6ChWfhXiUzf1AC/G+9ygVlUb6lqpKkGl2iCmu9eVpQupKIJpptAfNQfPFUcTKyDatvwTW5jdTwvqG1+E9Iarzg2Z5p38tcqHeXz8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051883; c=relaxed/simple;
	bh=VQ6je3ukNFOauiL1JeTbPRv0RUhTLL5g9uqAfRWJWyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCza/Mow5NgHjwhhlspsQKmVdy03+2SPGI5P92omcu3Oku5RubNrLWhkk0z08K6TJwLwwkA7ekIzijBD/YOliJ77i2pRwxSrbcPCIyoMXvT65zlx2lXqCX8zDQTet5MRxb+SJIghApisea8nxQw0m5G+olo4lsQs1HN/QJ41Sq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2/1QTvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6215C4CEF7;
	Thu, 13 Nov 2025 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051883;
	bh=VQ6je3ukNFOauiL1JeTbPRv0RUhTLL5g9uqAfRWJWyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H2/1QTvhX6/7mdcD3IkGHpUi8lF+2xYfxb7jQpHztfxuly/3zaGHqZ2NZNBE1P2rh
	 So4FrZ3Dl4cps3IaksVXk5vrKnrfuvq9PyIcb2DlAXaE5MN5q3YP9yjKxWvM3CuWjR
	 Nd4msCRybgiwsSRsQE9TKRK0w9Czh2sp8SXKnnRpAVwXf1Z75kQCkPgNoJIW/YAqoA
	 vQfP5X/rdZInC2cz33BmoHQ9epUut8bsH8ABnWKiSywdowACOqLD5Ye8Sx0t9plR1E
	 MeyaRhXWVwoxJ2JEIl1+ool6uDXapebQt830gHxfwkDnC/CDExMp7Dt/YTxy3GsZsG
	 32ADFzdBx1UyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:23 +0100
Subject: [PATCH v2 18/42] ovl: port ovl_set_or_remove_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-18-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VQ6je3ukNFOauiL1JeTbPRv0RUhTLL5g9uqAfRWJWyw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrxftpjvOFEest1ofBb7o4nZWvlfnel99YfUrpfw
 WYYrRLcUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHEdYwMn2qlmxuC+r4IfX75
 YsoEl1DpHuk/J/Tl7647viKldufzGkaGI7Y7dk3hzNnTc6ZoReXWg71rtW6tqhCa+dT8bsN8kcJ
 1fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

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
+	with_ovl_creds(dentry->d_sb) {
 		if (acl)
 			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
 		else
 			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	ovl_revert_creds(old_cred);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */

-- 
2.47.3


