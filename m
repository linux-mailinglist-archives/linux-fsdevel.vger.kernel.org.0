Return-Path: <linux-fsdevel+bounces-34550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDA9C6311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64156BC4911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411C721A71D;
	Tue, 12 Nov 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nXxeNzPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617221A4A9;
	Tue, 12 Nov 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443196; cv=none; b=aNmzJWNDeiLYqhs/P8vxbcyVteRzOLiHibnT9fChlbKzLXXWRJ9eOy6ffJ0Ih/My+ezZy6j7DcrssIX6EG5yxJq4ccJH3pmhEW9y2TV9KS10hfOytzMudHxvh2rVXfsgDEicSuISs5Hr/0XwL/QiQKcSCuX18DCHkFy+OLHlPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443196; c=relaxed/simple;
	bh=yN8UFcXaces+SH3gJU5MuevjL80ci2Ah0DAyvN5wrqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqtAqTl7HdRNqxnRLQ81RCNMvteLgHWs5UZHOiIUdAW2ATByCnD7YbuOf16GymKIdoSY0etEJc7/Hv7lZlW/E2Hhn6KRQq7Ei+N48VjwzXlefGJY/52KlWu3p7t5lPtccuznVL6kRc3ntObtKvALqTQRGhXkWUPRiIh6yLCtYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nXxeNzPv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dV3THfNVcbtW9+RhYLYYdBzDJtxPB+mxTPlyaLvJx18=; b=nXxeNzPvY0akJqJnu4DHVJLkcI
	hN3IKeMtojQL0X0xwhOHofmHTw6IA66B8K1dQM4VmZ3h9yLZwPxDI4ps6b94zV1dz+a3h1vq0U9jx
	ijeygOdQwnClPYE+KfLbWk0pgC75N9AK0uvy09MBz0OCJB7m4KoM+xKP3AzODLnSHDfiEZ3IHOAFH
	ZMyI7Z8YtM+GBAtH2md1A7FhkhlgMs33JWR3VkSsNJw5reMC2j30TYFHFekp415//Ovw416nOJKyN
	oa3a3zZZde9ndvg4Ei1raQuCXce2M0ZUiYJWWkjnCKKF4KDMJnbdLkRsYEe0bMMtF3kkBiBqb9obl
	YbKtIP+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxT6-0000000EEu9-1twz;
	Tue, 12 Nov 2024 20:26:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Tyler Hicks <code@tyhicks.com>,
	ecryptfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 4/5] fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag
Date: Tue, 12 Nov 2024 20:25:51 +0000
Message-ID: <20241112202552.3393751-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Stefan Berger <stefanb@linux.ibm.com>

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
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/inode.c        | 12 ++----------
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 --------
 fs/stat.c                  |  5 +----
 include/uapi/linux/fcntl.h |  4 ----
 5 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5ed1e4cf6c0b..644e973d5a77 100644
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
index 35fd3e3e1778..8b31f44c12cd 100644
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
index 0bfe35da4b7b..910dbbb2bb7b 100644
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
index 855b995ad09b..011d2160b7af 100644
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
index 87e2dec79fea..a40833bf2855 100644
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


