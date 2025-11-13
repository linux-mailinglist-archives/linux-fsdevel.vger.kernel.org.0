Return-Path: <linux-fsdevel+bounces-68231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6EC578BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C53569BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5D350D44;
	Thu, 13 Nov 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc6mRSJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C233538A2;
	Thu, 13 Nov 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038976; cv=none; b=rrADf3BOXnoMjrJ1QKiI12XYKAq5iRaK1VIM+AuUrwjtFkGbQEZOaj2RW3Fi4hWLIVKunwlAE30htvQRhqSbCavYjVbhFqsTq6Nx8dE/qqcDYGHP83vpZkoB4NQHIR5g4YhAHnLCjO/F1FswpGxw2Toi5dilz6ZlOeMErEop55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038976; c=relaxed/simple;
	bh=XSrJbDUlmsjUyQH/sESchumH6aiEllQygOdyh7xfpBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmtMpUrvJzEJ0jrvWHWPB0Enl+M81LxevXN2+m59zNXoY2tswi3aSZb1qSGvZral0IvKSiTpXghKSh0HftnfBN8jhLNnEXVlo4J1OAXRgHD1UZzlbf2l9T4FYfitb2jUfC0eZ4NpsvQRgCfhU5Q6CHiSWf0KR0rq+zNqDLDccMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc6mRSJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC48C4CEF5;
	Thu, 13 Nov 2025 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038976;
	bh=XSrJbDUlmsjUyQH/sESchumH6aiEllQygOdyh7xfpBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uc6mRSJ3KWUytjPeK1px1a4fq2d40Si5DNoU51Ffh0u7T+pcj0MUWBx2kjdpjPNsK
	 DY2O9OlZks9XuuFZXpIlPR9sQJc42YphHrDWVqKAsN0nYG/QPIfEgpWVNFlBqLcvZ3
	 eRJQjZ3eclDjma4izMQRoGDqb+nHBheMmXwI6e2zbUz/7Fn7q/LI3gK1boEbs4Wunk
	 35vAB1p4kR3xzFiG2UxcmJn1TmSm6dzr/akUaH0j3+5MPMsU/A5e19+rCaex57zaS5
	 RMJzXlungYM0Q+A/MmctyETIogE05BFowR53bVljlv57RjcznEqH452A3u6PmTbTVv
	 lzLfGqvUvreQw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:34 +0100
Subject: [PATCH RFC 14/42] ovl: port ovl_getattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-14-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XSrJbDUlmsjUyQH/sESchumH6aiEllQygOdyh7xfpBY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnu8Z89RiXXi2fPVxTJu+5i5mutNTPjKtb5LT0o+t
 +H17UMcHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM58piR4dGbrFPcTt4TYiY+
 OrbNZ+qPl12fnSyTpx0ITI5h1ZkUpsHIsOeJwGqJlPwgWd26n1OPi15PD9J0NbM+65W+XeKv9aE
 NjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7b28318b7f31..5fa6376f916b 100644
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
@@ -167,8 +176,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
+	err = ovl_real_getattr_nosec(sb, &realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
 
@@ -193,8 +201,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 					(!is_dir ? STATX_NLINK : 0);
 
 			ovl_path_lower(dentry, &realpath);
-			err = vfs_getattr_nosec(&realpath, &lowerstat, lowermask,
-						flags);
+			err = ovl_real_getattr_nosec(sb, &realpath, &lowerstat,
+						     lowermask, flags);
 			if (err)
 				goto out;
 
@@ -246,8 +254,9 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 			ovl_path_lowerdata(dentry, &realpath);
 			if (realpath.dentry) {
-				err = vfs_getattr_nosec(&realpath, &lowerdatastat,
-							lowermask, flags);
+				err = ovl_real_getattr_nosec(sb, &realpath,
+							     &lowerdatastat,
+							     lowermask, flags);
 				if (err)
 					goto out;
 			} else {
@@ -278,8 +287,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	ovl_revert_creds(old_cred);
-
 	return err;
 }
 

-- 
2.47.3


