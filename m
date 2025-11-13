Return-Path: <linux-fsdevel+bounces-68324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5EC590B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C0B563B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304536827E;
	Thu, 13 Nov 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5KboCH3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B680351FBA;
	Thu, 13 Nov 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051907; cv=none; b=HE8h10v7z+6DnFMW94QvKw4xkDxXWoNphPvZHpVplA476tS2tEu5o7frEFqPS7juj+FwV8vvnPI62Mi/XZkJL5aIviHK2D2xZzJCNkGBU8yPQolSJgFoAMEmksOfS/ttUE0ogGuMEjktj38I+LjOm40jlxW9b2vPh23YDfb5bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051907; c=relaxed/simple;
	bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JM0DXJweuVYbluc/EibSJgbHkYLqr4bn84SN2JKCy10E0+wRx375AXoZ1CfIuMTSsnSzzP/5BE/IvcmXdEs6bv76RNF5zIQlPgPqGn6oNrxtfdU34FA3nKv0izSZVsXAw22D84vftG5GRLCs5zDox5D2LR82mJPQf/6/l46IRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5KboCH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE73AC4CEF1;
	Thu, 13 Nov 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051907;
	bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z5KboCH3MHmCDI0HT0Q9TFfCZzWLhWiimhnr39SLst6QwGliD02763apBBaHeGU0+
	 2qxwXWKduvnpmFl0wpQ4IqyPCe/OV6xvmAmv3kF16QYzupacF74BdfV2OzTNE0shai
	 ivAjyRHB7zKcwHvDP0LV/JgHNsoVzmOvCTKtCqldabr09y054xsja5hNUJxS3j3Lqr
	 AsplH25nH1Ib43F/dqbzYhtsty89V77AP3j3lU8hauwVlHkNWbqXt2Q/9Yb382lVSn
	 cF4ZoixPNuckwU+0EyQ2JyU3cjzc48LzevSQs6v28pkoVgoKlAQNwDwuoBQ3zUTzwl
	 ZEIYPbd0/Nt7g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:36 +0100
Subject: [PATCH v2 31/42] ovl: port ovl_xattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-31-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcborVXZsvjZF0sIqZ2tqcypH57KSs43Na5uqJoQVc
 PQ4Jmh1lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCQjl+F/RXXo2mrzLLn1fxu8
 q9ukHx6aUv+w8E1taZSSmW9/l9R8RoYXDU27ozoTOmbKLlkhsG/ttG+f9ScbPHSf4ClWWrTSWYs
 dAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 787df86acb26..788182fff3e0 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -81,15 +81,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 			 void *value, size_t size)
 {
-	ssize_t res;
-	const struct cred *old_cred;
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	ovl_revert_creds(old_cred);
-	return res;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
 }
 
 static bool ovl_can_list(struct super_block *sb, const char *s)

-- 
2.47.3


