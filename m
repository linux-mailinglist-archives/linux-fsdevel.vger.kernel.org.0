Return-Path: <linux-fsdevel+bounces-68307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430ABC58E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBDF3A7EE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D0364027;
	Thu, 13 Nov 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7YE8dLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188935A153;
	Thu, 13 Nov 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051876; cv=none; b=ioZ73jvmtTT7UG5tds8AFjUYE3Iuw7u64Lk0fg8R+bjAxYXoKuS3gcbUF+ty1xH53hSwJ8uvynY5vtvPLoGiZKRtR98kPI9i8bF7pwdH35DlFs2FSt/lOHlAWn1RMTO1DSJYiUYID4iSRTkBYSNr1pgpfVNsu2qBPjvOYCEpT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051876; c=relaxed/simple;
	bh=z9m53fQ2q3fNuotUtjovwyW7BZ4Wfcn695n2STigqJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuIeSa/I72r55rLdf2MgeHkOAIIHju0z5HJwfWBk5r4XVxUmLLzsT0GAk5W0PHlR7zURCPraqgNKMoK2JQbochy/dP7RtV7DwnIL5CABLVLRk1anhK41z8MJgRozWvPa9WNjudw/MTM5sfeyddH4SJu3oh3bVRVMNJAETQM/5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7YE8dLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C737C113D0;
	Thu, 13 Nov 2025 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051876;
	bh=z9m53fQ2q3fNuotUtjovwyW7BZ4Wfcn695n2STigqJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W7YE8dLKygKnzCfFnQKb2LJivpmTagSreLqv8lF5R+LbA8l6HiNlUOHYHNM0pP6QZ
	 mZWHSWaVrzA/8HxMd7bAsgxhYU+NCdhzFLse0+ptW3Sh3wHBqzwxajeYrtET0QvsUA
	 jkbQwXV1siialZwWZYbuN4TyLFrSADWYaSxMQd7Mfahj+63OjZ7J6T1s2zt/7jgrkA
	 repULufKr82GVcfXFBdQwOEqnie2KjgegqYujUN6/9mIkjO5PxBeY7sMdimrAWUbzB
	 TIYZtPsjWVpGoWSkIUD0zFtN93jyDa0SyaeO/g/84A+TFD6HPM33/4DuOx2Bh3kC5M
	 xHnTHFszRoynw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:19 +0100
Subject: [PATCH v2 14/42] ovl: port ovl_getattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-14-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z9m53fQ2q3fNuotUtjovwyW7BZ4Wfcn695n2STigqJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbodN3dmPzdPdbL+HqNcVY+ynVJ+rxrzry3kOu3Iv
 cp9kWpvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERaZjMy9P8y0zrHYXVqTzi7
 +bH4Fe98/b9xfxbWVdTeN93v5K/DGxj+Z7QH/7C+tXJ/eH7KPD7FeOs55cnnt/sZPP6wYvL8eyH
 S7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7b28318b7f31..00e1a47116d4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -151,13 +151,22 @@ static void ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 	}
 }
 
+static inline int ovl_real_getattr_nosec(struct super_block *sb,
+					 const struct path *path,
+					 struct kstat *stat, u32 request_mask,
+					 unsigned int flags)
+{
+	with_ovl_creds(sb)
+		return vfs_getattr_nosec(path, stat, request_mask, flags);
+}
+
 int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
+	struct super_block *sb = dentry->d_sb;
 	enum ovl_path_type type;
 	struct path realpath;
-	const struct cred *old_cred;
 	struct inode *inode = d_inode(dentry);
 	bool is_dir = S_ISDIR(inode->i_mode);
 	int fsid = 0;
@@ -167,10 +176,9 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
+	err = ovl_real_getattr_nosec(sb, &realpath, stat, request_mask, flags);
 	if (err)
-		goto out;
+		return err;
 
 	/* Report the effective immutable/append-only STATX flags */
 	generic_fill_statx_attr(inode, stat);
@@ -193,10 +201,10 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 					(!is_dir ? STATX_NLINK : 0);
 
 			ovl_path_lower(dentry, &realpath);
-			err = vfs_getattr_nosec(&realpath, &lowerstat, lowermask,
-						flags);
+			err = ovl_real_getattr_nosec(sb, &realpath, &lowerstat,
+						     lowermask, flags);
 			if (err)
-				goto out;
+				return err;
 
 			/*
 			 * Lower hardlinks may be broken on copy up to different
@@ -246,10 +254,11 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 			ovl_path_lowerdata(dentry, &realpath);
 			if (realpath.dentry) {
-				err = vfs_getattr_nosec(&realpath, &lowerdatastat,
+				err = ovl_real_getattr_nosec(sb, &realpath,
+							     &lowerdatastat,
 							     lowermask, flags);
 				if (err)
-					goto out;
+					return err;
 			} else {
 				lowerdatastat.blocks =
 					round_up(stat->size, stat->blksize) >> 9;
@@ -277,9 +286,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (!is_dir && ovl_test_flag(OVL_INDEX, d_inode(dentry)))
 		stat->nlink = dentry->d_inode->i_nlink;
 
-out:
-	ovl_revert_creds(old_cred);
-
 	return err;
 }
 

-- 
2.47.3


