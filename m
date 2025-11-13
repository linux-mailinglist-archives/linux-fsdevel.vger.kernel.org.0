Return-Path: <linux-fsdevel+bounces-68370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F8C5A2FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8224F1B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A4432694F;
	Thu, 13 Nov 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itjoiN3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD78324B2B;
	Thu, 13 Nov 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069556; cv=none; b=QhZLDCTkXaQDMgLsE0niLKlCzI91K732NtucRNBAbgyeXtMB0yKqWTxMvkO9Efc77TtDtrlCH5CSdHcmf89oRF0AhXUF2Pgulfk0ywoNxYzU6PYapB/7gKNBD862fbY/ixVbvf5SN+0g0mkdUL8q5HaPuBqbRTAquvadXME9NhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069556; c=relaxed/simple;
	bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZLP9TcpXZmVsuV6UE4LaN6wv/HnjWfLSTzxFaTq+k8JO19+g3nm6A0i+WhQpm7/WX874Z0HrrzjqDMn/KR/hsKmIUodCaTOKNw6pIXKVgXHg91Z/AjxpmIdLPucCuvnuJak/i/EMEOlILEklMhHxYg7gNglxtsZHJNm+h2BBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itjoiN3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED61C4CEFB;
	Thu, 13 Nov 2025 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069555;
	bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=itjoiN3ZcHoZEFSgxTvdKUznbocukx4x9YfGlvKl3X1uLQjQ2COL33mD5G8ntMHw2
	 GH0DNUF/Vd/oSkn3ixGrF83N2hbKQEo6EqPJ++hqMP62ivB7r3+HA5uciehSI1bWSw
	 BsfhvR/cj5/r5rzH5q/+jBm1Rw6teolmwSLG8oulf9u+40D3hdBo2I2tA/J0Q+mEIZ
	 Ghp6LuxaiEgETtl6VwkoIfv+D4OLAd6S/wF8fwO4abripKhyPJQD773fuimlP2/3uD
	 MRHlZqxwmseGpnjpSJNdhOc2EVwB7w5MYooTjafW7+h54WeFyPgOhwK0ndFEwVEeDB
	 EzvZ79cTMNZXQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:57 +0100
Subject: [PATCH v3 14/42] ovl: port ovl_getattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-14-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QHsWsw4Yc9TJE+hYwZeoZkVhyL9Hm28xFKHnkT6zA/I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YXFpP0sUXprXsUtqlIo1RIa07jv20TpWBH9vjnaK
 Xqm+7s6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJsJ+j+F/YcWZ2ZXebmERIZsn
 lf80cqhyXrCw/7r27wlfBO4e26Dxj5GhaXdc0jF5hRf1GsGKVVtlV3z8citoy6zoi8ov97cc8j/
 NBgA=
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


