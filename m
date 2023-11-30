Return-Path: <linux-fsdevel+bounces-4438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043267FF689
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADED928168F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262855763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wawHPsSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B0495C2;
	Thu, 30 Nov 2023 16:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D6CC433C7;
	Thu, 30 Nov 2023 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361418;
	bh=MPIJBAUbdy9/Sj7RfaR+8SoYXhklAUN44QUBd6V7Yeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wawHPsSnAfmWrJlWKY5yiXeBF7i3WZmEuWO7kND74y3ql2IIdVaFqenkwj1CqYl3a
	 iagJXEphGC3oqIF6DS5o6KA0o4IgCM7mhHDWbcizpVrkF13ajrhrZXAmDA9uQuWGU+
	 c4rKYp4yRNDMKfS7V8gBURx4PK9mM4uNGe8cOP/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/112] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
Date: Thu, 30 Nov 2023 16:21:02 +0000
Message-ID: <20231130162140.804459950@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit 8a924db2d7b5eb69ba08b1a0af46e9f1359a9bdf ]

When vfs_getattr_nosec() calls a filesystem's getattr interface function
then the 'nosec' should propagate into this function so that
vfs_getattr_nosec() can again be called from the filesystem's gettattr
rather than vfs_getattr(). The latter would add unnecessary security
checks that the initial vfs_getattr_nosec() call wanted to avoid.
Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
with the new getattr_flags parameter to the getattr interface function.
In overlayfs and ecryptfs use this flag to determine which one of the
two functions to call.

In a recent code change introduced to IMA vfs_getattr_nosec() ended up
calling vfs_getattr() in overlayfs, which in turn called
security_inode_getattr() on an exiting process that did not have
current->fs set anymore, which then caused a kernel NULL pointer
dereference. With this change the call to security_inode_getattr() can
be avoided, thus avoiding the NULL pointer dereference.

Reported-by: <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>
Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Co-developed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20231002125733.1251467-1-stefanb@linux.vnet.ibm.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ecryptfs/inode.c        | 12 ++++++++++--
 fs/overlayfs/inode.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h   |  8 ++++++++
 fs/stat.c                  |  6 +++++-
 include/uapi/linux/fcntl.h |  3 +++
 5 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 992d9c7e64ae6..5ab4b87888a79 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -998,6 +998,14 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
 	return rc;
 }
 
+static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
+			       u32 request_mask, unsigned int flags)
+{
+	if (flags & AT_GETATTR_NOSEC)
+		return vfs_getattr_nosec(path, stat, request_mask, flags);
+	return vfs_getattr(path, stat, request_mask, flags);
+}
+
 static int ecryptfs_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
@@ -1006,8 +1014,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
 	struct kstat lower_stat;
 	int rc;
 
-	rc = vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_stat,
-			 request_mask, flags);
+	rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
+				 &lower_stat, request_mask, flags);
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
 				      ecryptfs_inode_to_lower(d_inode(dentry)));
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 83ef66644c213..fca29dba7b146 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -171,7 +171,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	type = ovl_path_real(dentry, &realpath);
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = vfs_getattr(&realpath, stat, request_mask, flags);
+	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
 
@@ -196,8 +196,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 					(!is_dir ? STATX_NLINK : 0);
 
 			ovl_path_lower(dentry, &realpath);
-			err = vfs_getattr(&realpath, &lowerstat,
-					  lowermask, flags);
+			err = ovl_do_getattr(&realpath, &lowerstat, lowermask,
+					     flags);
 			if (err)
 				goto out;
 
@@ -249,8 +249,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 			ovl_path_lowerdata(dentry, &realpath);
 			if (realpath.dentry) {
-				err = vfs_getattr(&realpath, &lowerdatastat,
-						  lowermask, flags);
+				err = ovl_do_getattr(&realpath, &lowerdatastat,
+						     lowermask, flags);
 				if (err)
 					goto out;
 			} else {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9817b2dcb132c..09ca82ed0f8ce 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -397,6 +397,14 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 	return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
 }
 
+static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
+				 u32 request_mask, unsigned int flags)
+{
+	if (flags & AT_GETATTR_NOSEC)
+		return vfs_getattr_nosec(path, stat, request_mask, flags);
+	return vfs_getattr(path, stat, request_mask, flags);
+}
+
 /* util.c */
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa46..5375be5f97ccf 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	idmap = mnt_idmap(path->mnt);
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(idmap, path, stat,
-					    request_mask, query_flags);
+					    request_mask,
+					    query_flags | AT_GETATTR_NOSEC);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
@@ -166,6 +167,9 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
 {
 	int retval;
 
+	if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
+		return -EPERM;
+
 	retval = security_inode_getattr(path);
 	if (retval)
 		return retval;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6c80f96049bd0..282e90aeb163c 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -116,5 +116,8 @@
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+#if defined(__KERNEL__)
+#define AT_GETATTR_NOSEC	0x80000000
+#endif
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.42.0




