Return-Path: <linux-fsdevel+bounces-73741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62740D1F7C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0BD4307F629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B08396B83;
	Wed, 14 Jan 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWjRfuE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EED2F1FC8;
	Wed, 14 Jan 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400969; cv=none; b=kFtTrs2nRXg5WxcEwXpdBIZXyduo3ytu/4eQd6D4CiEZLUHxhT+7Cb/ZeV9YjtgaCHeEY6jdTpsbfEYDrtiOa1cEKOFLdtGlI05GuvHD40yf4S3Pnvjjv/cGuGXAR42EyRo6SDUx8LxE4eCll/9ElLLypfaVxRvdDk8oFhSdq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400969; c=relaxed/simple;
	bh=zNRnLlilQ+zwYGSmKJNro0mykU8HHPTeJj0cdXd16qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJxWA/HIaT3jP5eZOAkv7gkMCqaLzURItoBIKRT4PkrH9j8WqiA7pEi4fpeu7qWzuW4A9gpJqEluE7DWe3bLNAIG4Nwt2UqbWIXlBOESJ2fMY3fz98R5bt7hUtZwBxxXI7cJjzoJuToQvpharr0Pta2SE24OVlZ/rcTSQFfXsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWjRfuE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8796C19422;
	Wed, 14 Jan 2026 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400969;
	bh=zNRnLlilQ+zwYGSmKJNro0mykU8HHPTeJj0cdXd16qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWjRfuE2ruCdFWTDivaPHUSJV7MnD7hXIw6rypDjAF12Vr08pK91FRIbSruPLza47
	 eh962IQ8f6VcrL9AVFmSC6kQxxxzXfwHiIfUWnXraQAVFxFkPF5OdhZOB9797CpyQ8
	 luCQtubRbFD4N5OdsV3vq+xuNHa0vgHblp4UM1+VbAQuI8MmHvSegczjo+KXPMgVXf
	 wpP1ZTwjpaHPdQxiFvixut3wu0NiCqljwHsRlkYYK+F8aCOS9Y/h8jV7oCRNzwxQ77
	 5k59fk5thFs905ZR4ZVQH3iBxzxrW7PeG3iyhDjczvPukltYvSAOSQ19hlngrQoK0L
	 PgQS6IP5trjtw==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 10/16] nfs: Implement fileattr_get for case sensitivity
Date: Wed, 14 Jan 2026 09:28:53 -0500
Message-ID: <20260114142900.3945054-11-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

An NFS server re-exporting an NFS mount point needs to report the
case sensitivity behavior of the underlying filesystem to its
clients. Without this, re-export servers cannot accurately convey
case handling semantics, potentially causing client applications to
make incorrect assumptions about filename collisions and lookups.

The NFS client already retrieves case sensitivity information from
servers during mount via PATHCONF (NFSv3) or the
FATTR4_CASE_INSENSITIVE/FATTR4_CASE_PRESERVING attributes (NFSv4).
Expose this information through fileattr_get by reporting the
case_insensitive and case_preserving flags in file_kattr. NFSv2
lacks PATHCONF support, so mounts using that protocol version
default to standard POSIX behavior: case-sensitive and case-
preserving.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c         |  9 +++++++--
 fs/nfs/inode.c          | 18 ++++++++++++++++++
 fs/nfs/internal.h       |  3 +++
 fs/nfs/nfs3proc.c       |  2 ++
 fs/nfs/nfs3xdr.c        |  7 +++++--
 fs/nfs/nfs4proc.c       |  2 ++
 fs/nfs/proc.c           |  3 +++
 fs/nfs/symlink.c        |  3 +++
 include/linux/nfs_xdr.h |  2 ++
 9 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 2aaea9c98c2c..da437d89e14a 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -935,13 +935,18 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 
 	/* Get some general file system info */
 	if (server->namelen == 0) {
-		struct nfs_pathconf pathinfo;
+		struct nfs_pathconf pathinfo = { };
 
 		pathinfo.fattr = fattr;
 		nfs_fattr_init(fattr);
 
-		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0)
+		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0) {
 			server->namelen = pathinfo.max_namelen;
+			if (pathinfo.case_insensitive)
+				server->caps |= NFS_CAP_CASE_INSENSITIVE;
+			if (pathinfo.case_preserving)
+				server->caps |= NFS_CAP_CASE_PRESERVING;
+		}
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 84049f3cd340..ee8234f8e84a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -41,6 +41,7 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/fileattr.h>
 
 #include "nfs4_fs.h"
 #include "callback.h"
@@ -1100,6 +1101,23 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 }
 EXPORT_SYMBOL_GPL(nfs_getattr);
 
+/**
+ * nfs_fileattr_get - Retrieve file attributes
+ * @dentry: object to query
+ * @fa: file attributes to fill in
+ *
+ * Return: 0 on success
+ */
+int nfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	fa->case_insensitive = nfs_server_capable(inode, NFS_CAP_CASE_INSENSITIVE);
+	fa->case_nonpreserving = !nfs_server_capable(inode, NFS_CAP_CASE_PRESERVING);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nfs_fileattr_get);
+
 static void nfs_init_lock_context(struct nfs_lock_context *l_ctx)
 {
 	refcount_set(&l_ctx->count, 1);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2e596244799f..a843e076aad7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -453,6 +453,9 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+struct file_kattr;
+int nfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
 struct nfs_local_dio {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1181f9cc6dbd..60344a83f400 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1048,6 +1048,7 @@ static const struct inode_operations nfs3_dir_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
 	.get_inode_acl	= nfs3_get_acl,
@@ -1059,6 +1060,7 @@ static const struct inode_operations nfs3_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
 	.get_inode_acl	= nfs3_get_acl,
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index e17d72908412..e745e78faab0 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2276,8 +2276,11 @@ static int decode_pathconf3resok(struct xdr_stream *xdr,
 	if (unlikely(!p))
 		return -EIO;
 	result->max_link = be32_to_cpup(p++);
-	result->max_namelen = be32_to_cpup(p);
-	/* ignore remaining fields */
+	result->max_namelen = be32_to_cpup(p++);
+	p++;	/* ignore no_trunc */
+	p++;	/* ignore chown_restricted */
+	result->case_insensitive = be32_to_cpup(p++) != 0;
+	result->case_preserving = be32_to_cpup(p) != 0;
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..e119c6ff61f0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -11041,6 +11041,7 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static const struct inode_operations nfs4_file_inode_operations = {
@@ -11048,6 +11049,7 @@ static const struct inode_operations nfs4_file_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 39df80e4ae6f..48f02a80b800 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -597,6 +597,7 @@ nfs_proc_pathconf(struct nfs_server *server, struct nfs_fh *fhandle,
 {
 	info->max_link = 0;
 	info->max_namelen = NFS2_MAXNAMLEN;
+	info->case_preserving = true;
 	return 0;
 }
 
@@ -718,12 +719,14 @@ static const struct inode_operations nfs_dir_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static const struct inode_operations nfs_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 const struct nfs_rpc_ops nfs_v2_clientops = {
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 58146e935402..74a072896f8d 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -22,6 +22,8 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 
+#include "internal.h"
+
 /* Symlink caching in the page cache is even more simplistic
  * and straight-forward than readdir caching.
  */
@@ -74,4 +76,5 @@ const struct inode_operations nfs_symlink_inode_operations = {
 	.get_link	= nfs_get_link,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 79fe2dfb470f..5f061a9db2c2 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -182,6 +182,8 @@ struct nfs_pathconf {
 	struct nfs_fattr	*fattr; /* Post-op attributes */
 	__u32			max_link; /* max # of hard links */
 	__u32			max_namelen; /* max name length */
+	bool			case_insensitive;
+	bool			case_preserving;
 };
 
 struct nfs4_change_info {
-- 
2.52.0


