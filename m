Return-Path: <linux-fsdevel+bounces-68661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB1C6344B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A5D4EEB54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1032AABC;
	Mon, 17 Nov 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3QS+ktH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8201E0B9C;
	Mon, 17 Nov 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372057; cv=none; b=gb1KDHe8e13IlI88/hCimpxaC9nHhKSqrUd5SOHoU+dt8bSt5ay0mVUT++8JVmouw3K42zDZNwkLEEU6zlX+V433axjWpjYbCq/4Ttp1QmMqW3OtPnqvsI1GNDXUK3RMRnANN/6wEkeb05m33G+BZRfwu1OqRpAxf0jPo2Li0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372057; c=relaxed/simple;
	bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoyHlvaEiFXYcz8Yxgn7eYkVTTHk53hnop0ldEDtgDwcFROHzWbZyIj2eH3kOFDjkocegpo0skWQ/xBFWHUVg7F3F3wOpNPCzBj6MKB8vMbHwuunSuEuCrC3LmSwnDoq/u/qaLKV5XxHkCOnnjpmY1dMl/p1OfQbhk9YEjhxjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3QS+ktH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C6C113D0;
	Mon, 17 Nov 2025 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372057;
	bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G3QS+ktHInAw55+QsQoBVxJ1oO5JzFdj3D/nOZKBoce1mSlUxec3ZUpDi7WwvMohe
	 BrB8zthSQRxsJV59nb699hq+8vqBfKjKZAYJ9cKyqMzagStDQb1eCQJJGvV7Z0L8BH
	 Jqe8NHqx6Q9cXzsxoMz77xulaUuvHrX9yQWw3UcW52dwwl4vEr0c5lOmBDI+GcnFe2
	 jWlBEgING2qq9u3lEdeSRRLZH0YHKUTSxKIIw+uGEppdUX/FuSb/mk6f56nwqA9pva
	 N96wgXYKsrT1t5VZ6qOz56iDsvEdenqjwfMNwmxwMNWsnRv22r5YUzZ1uxgG4msqc2
	 4HyEmze9oqT3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:49 +0100
Subject: [PATCH v4 18/42] ovl: port ovl_set_or_remove_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-18-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ntIJxwq4IL/xi2aMz0jG9JSu3LvZ3tfRHfUm6SBzyR8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf76v3wy44WzUbIXs4rTy2vf2BnNOPPVPDzNuGX98
 SuHbuvs6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImdUMfyWF4y6dm9Yjp1nL
 0F6rFsUsszd3/czjj6NNXWfu0I7alsHw3+sB5/bk35kvd63eVzhx5uubnLYifDKL15pYKAQL1Jp
 38wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


