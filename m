Return-Path: <linux-fsdevel+bounces-47100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D87A98EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786603A997C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A092280A4D;
	Wed, 23 Apr 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlL3R/nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78118DB17;
	Wed, 23 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420118; cv=none; b=Gg6oyCnaUZ79UsHF8SmLl17V2BafBHjCx1M4pettoIUWv8oqdmhqrQV59Cv1dzbpQnm+TDzBThj3YCGbnTs8IEqlv+BfSFscvMYjy0GOkYggYw1vG2cDfF692yqhXAFcuXh9VFEH9LEziHazad1Xgm0BhkWRC+bsIpBUilxhzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420118; c=relaxed/simple;
	bh=Seq9Tn6zd7GgXSLQkR4PQvzHVtjjrW7lTAbTOJcwPCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/0ILhut/jH/O7281AHpxYEn1swFbqbBnl0nAg/N/1fpOFIS5/cr0OEvgwVg9p9O3qVLTTtHwkWOJbSoMu8Bctzn+KmampwH94ziZ3YT21mOeOWzeoDnxAt2daId88AhLVPLSww4XcB1JK64H2Qw7qL3eoScq3WOUHPy38Jq334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlL3R/nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE3EC4CEE2;
	Wed, 23 Apr 2025 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420118;
	bh=Seq9Tn6zd7GgXSLQkR4PQvzHVtjjrW7lTAbTOJcwPCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlL3R/nlhGHSxt/xfdwatbNgTu6fzQaThnxvRVn7DWQtMs/QJsAveVdHcxl5ONZNf
	 zltt3IAAbwjivvNpXq/xnOm9foA5TshdlJtXYElGdP+0I6BQ733mG0zuSoeGc4g3G1
	 7YiAdqVBXDL8g7Okg//3oAich1GIDNNJGLDxOkN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tyler Hicks <code@tyhicks.com>,
	ecryptfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 101/223] fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag
Date: Wed, 23 Apr 2025 16:42:53 +0200
Message-ID: <20250423142621.227689976@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit 95f567f81e43a1bcb5fbf0559e55b7505707300d ]

Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface
function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
call paths only call vfs_getattr_nosec if it is set instead of vfs_getattr.
Now, simplify the getattr interface functions of filesystems where the flag
AT_GETATTR_NOSEC is checked.

There is only a single caller of inode_operations getattr function and it
is located in fs/stat.c in vfs_getattr_nosec. The caller there is the only
one from which the AT_GETATTR_NOSEC flag is passed from.

Two filesystems are checking this flag in .getattr and the flag is always
passed to them unconditionally from only vfs_getattr_nosec:

- ecryptfs:  Simplify by always calling vfs_getattr_nosec in
             ecryptfs_getattr. From there the flag is passed to no other
             function and this function is not called otherwise.

- overlayfs: Simplify by always calling vfs_getattr_nosec in
             ovl_getattr. From there the flag is passed to no other
             function and this function is not called otherwise.

The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC from
any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
important inside this function. Also, since no filesystem is checking the
flag anymore, remove the flag entirely now, including the BUG_ON check that
never triggered.

The net change of the changes here combined with the original commit is
that ecryptfs and overlayfs do not call vfs_getattr but only
vfs_getattr_nosec.

Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@ZenIV/T/#u
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ecryptfs/inode.c        | 12 ++----------
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 --------
 fs/stat.c                  |  5 +----
 include/uapi/linux/fcntl.h |  4 ----
 5 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index cbdf82f0183f3..a9819ddb1ab85 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1008,14 +1008,6 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
-			       u32 request_mask, unsigned int flags)
-{
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
-}
-
 static int ecryptfs_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
@@ -1024,8 +1016,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
 	struct kstat lower_stat;
 	int rc;
 
-	rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
-				 &lower_stat, request_mask, flags);
+	rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
+			       &lower_stat, request_mask, flags);
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index baa54c718bd72..97dd70d631446 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -170,7 +170,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	type = ovl_path_real(dentry, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
+	err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
 
@@ -195,8 +195,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 					(!is_dir ? STATX_NLINK : 0);
 
 			ovl_path_lower(dentry, &realpath);
-			err = ovl_do_getattr(&realpath, &lowerstat, lowermask,
-					     flags);
+			err = vfs_getattr_nosec(&realpath, &lowerstat, lowermask,
+						flags);
 			if (err)
 				goto out;
 
@@ -248,8 +248,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 			ovl_path_lowerdata(dentry, &realpath);
 			if (realpath.dentry) {
-				err = ovl_do_getattr(&realpath, &lowerdatastat,
-						     lowermask, flags);
+				err = vfs_getattr_nosec(&realpath, &lowerdatastat,
+							lowermask, flags);
 				if (err)
 					goto out;
 			} else {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 500a9634ad533..63ad4511c1208 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -412,14 +412,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 	return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
 }
 
-static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
-				 u32 request_mask, unsigned int flags)
-{
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
-}
-
 /* util.c */
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e3..cbc0fcd4fba39 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -165,7 +165,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(idmap, path, stat,
 					    request_mask,
-					    query_flags | AT_GETATTR_NOSEC);
+					    query_flags);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
@@ -198,9 +198,6 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
 {
 	int retval;
 
-	if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
-		return -EPERM;
-
 	retval = security_inode_getattr(path);
 	if (retval)
 		return retval;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87e2dec79fea4..a40833bf2855e 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -154,8 +154,4 @@
 					   usable with open_by_handle_at(2). */
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 
-#if defined(__KERNEL__)
-#define AT_GETATTR_NOSEC	0x80000000
-#endif
-
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.39.5




