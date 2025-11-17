Return-Path: <linux-fsdevel+bounces-68656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C21C63418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015304F2A97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC439329398;
	Mon, 17 Nov 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VooAKBwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2E32938D;
	Mon, 17 Nov 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372050; cv=none; b=g0tDwvG9UMDmyBIBUk6x7VvtKgNTMDvGtByMwaUxCt2wn4wHRaXT7FJyeTytSed7ppUoaHHWOvTS/znK0B4DZfvBkdMnqsChndJdhTxzjJHnozYO9a9iWnzHcHdHedMrpT9Q9/Z8/8hwxYNmTRkFNYm1P3Fhp21Q5zfFVotaPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372050; c=relaxed/simple;
	bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUyxbBm0m8MCai2wfR6NgCIw3rsUThEuQCxqlSZLWrVEXYbNoLjbkG+VxPK9UD50f0Iradu0PaVHSLZiL3eeeZ/vDuS1RAMM/EzvQKO/cWA4Wc0tsvOuHhVrBwKoUSNIwAKIXXa1HhqNtdFvw6fzaxzxs97gEdQOtuwxDrHrF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VooAKBwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F71C4CEFB;
	Mon, 17 Nov 2025 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372050;
	bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VooAKBwMnMcM0DWny4oCcrLpbFrTghivKAhG6z0OLo6X7/gC7Xez5Jw1MRU3zNCj5
	 36fd5hNSkcTyB8n678MnUkpIAQY+Ni3OMoQNz+EQIaiJ2S1eLwnB9Xe7bNpVvnWDVT
	 YlxPnPcxPUMBItwLXD0uX9BpYtHqr3FSOA95JbpJGh3zCUUBItUeF2s3IAHd8qMSHX
	 bOZpTVsFeY5YLmYJRfMNbU2HzOV6ZyK2OAsw3KwW4RB5/NOZ/Nm4+xM0al5p/1D+Vk
	 lolv6N+u9MAq217lt7TksM+PPs7mYZuzWBPgxowMk1SbtXmCV8SNcQcMFL4jX7Q9K7
	 nmjk22Wz5d1Ag==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:45 +0100
Subject: [PATCH v4 14/42] ovl: port ovl_getattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-14-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf66vPbJtOpvPrIX4x+8vTwn4bjaKzFPUY13F/trz
 O+v5v9q0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRRA6G/2lTOmVz7rDfLz+p
 fvHBt2tzdKqZs64/rzlvZH4/9tDilykM/5M+rZBZ7LfUWsfojuDsOp/TASq8Bafrp39N//FptkK
 RIScA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


