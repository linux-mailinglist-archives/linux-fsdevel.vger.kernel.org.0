Return-Path: <linux-fsdevel+bounces-43996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD183A6082D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4D19C365D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84415D5C4;
	Fri, 14 Mar 2025 04:57:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F0126BF1;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928234; cv=none; b=nooQBweZMwSN7mbcsQMw6OjK27wEwj53BZfeLrkRqlF44aPrifGDdd4P8dDKIQPqgwNQgAC1c+l96DzaTuugRvwVfZY7y8pN6pzbHHhS+NPxquQ/N1IpXQSnOv4m+qLrMirAy0D/AmrMX2r4w5OEq7esDrmeC6KOshRGXwjKjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928234; c=relaxed/simple;
	bh=9EgO9GVucLKgNNWzj/aDBAWgwaGLI0wpp8PpIH+o8LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+50fw/YbV6V1iBV8DZdeIQVCEJevmtM4wmOMMehYc3Q5haUfvoLqnGDbA6Dfxlw88n/wkraFC3T/TBcTbS3PDGF4Bt3tvh8TIvkywPtIxWCpGNoEqo6oZckAOLsBaOA8AzBVGNGaPsj9YEopBF3/+mJhc5shDIYpu2zMrPsf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6Y-00E3vn-4R;
	Fri, 14 Mar 2025 04:57:06 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] nfsd: use correct idmap for all accesses.
Date: Fri, 14 Mar 2025 11:34:09 +1100
Message-ID: <20250314045655.603377-4-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When accessing the exported filesystem, or the filesystem storing
state-recovery data, we should use the idmap associated with the mount,
or incorrect behaviour could eventuate of an idmapped filesystem were in
use.

This patch adds fh_idmap() to return the mnt_idmap for a given svc_fh()
and uses that or other means to provide the correct mnt_idmap.  nfsd no
longer users nop_mnt_idmap.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs2acl.c     |  4 ++--
 fs/nfsd/nfs3acl.c     |  4 ++--
 fs/nfsd/nfs3proc.c    |  2 +-
 fs/nfsd/nfs4recover.c |  7 ++++---
 fs/nfsd/nfs4state.c   |  9 ++++++---
 fs/nfsd/nfs4xdr.c     |  2 +-
 fs/nfsd/state.h       |  4 +++-
 fs/nfsd/vfs.h         | 12 ++++++++++++
 8 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 5fb202acb0fd..cb15d2d0dd50 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -115,11 +115,11 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
+	error = set_posix_acl(fh_idmap(fh), fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(fh_idmap(fh), fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 	if (error)
 		goto out_drop_lock;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7b5433bd3019..2e92a5673021 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -105,11 +105,11 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
+	error = set_posix_acl(fh_idmap(fh), fh->fh_dentry, ACL_TYPE_ACCESS,
 			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
+	error = set_posix_acl(fh_idmap(fh), fh->fh_dentry, ACL_TYPE_DEFAULT,
 			      argp->acl_default);
 
 out_drop_lock:
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 457638bf0f32..d32ce5956ca0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -344,7 +344,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
+	host_err = vfs_create(fh_idmap(fhp), inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 10d24bec532f..f8fe23941873 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -233,7 +233,8 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	dentry = vfs_mkdir(mnt_idmap(nn->rec_file->f_path.mnt), d_inode(dir),
+				  dentry, S_IRWXU);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
 out_put:
@@ -357,7 +358,7 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
+	status = vfs_rmdir(mnt_idmap(nn->rec_file->f_path.mnt), d_inode(dir), dentry);
 out:
 	dput(dentry);
 out_unlock:
@@ -447,7 +448,7 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+	status = vfs_rmdir(mnt_idmap(nn->rec_file->f_path.mnt), d_inode(parent), child);
 	if (status)
 		printk("failed to remove client recovery directory %pd\n",
 				child);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 153eeea2c7c9..1796a6aeedd8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9079,7 +9079,8 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
 	return true;
 }
 
-static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
+static int cb_getattr_update_times(struct vfsmount *mnt, struct dentry *dentry,
+				   struct nfs4_delegation *dp)
 {
 	struct inode *inode = d_inode(dentry);
 	struct timespec64 now = current_time(inode);
@@ -9111,7 +9112,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 
 	attrs.ia_valid |= ATTR_DELEG;
 	inode_lock(inode);
-	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+	ret = notify_change(mnt_idmap(mnt), dentry, &attrs, NULL);
 	inode_unlock(inode);
 	return ret;
 }
@@ -9120,6 +9121,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
  * @dentry: dentry of inode to be checked for a conflict
+ * @exp: svc_export being accessed
  * @pdp: returned WRITE delegation, if one was found
  *
  * This function is called when there is a conflict between a write
@@ -9135,6 +9137,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
  */
 __be32
 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
+			     struct svc_export *exp,
 			     struct nfs4_delegation **pdp)
 {
 	__be32 status;
@@ -9203,7 +9206,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		 * not update the file's metadata with the client's
 		 * modified size
 		 */
-		err = cb_getattr_update_times(dentry, dp);
+		err = cb_getattr_update_times(exp->ex_path.mnt, dentry, dp);
 		if (err) {
 			status = nfserrno(err);
 			goto out_status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 64ab2c605e93..e7c87653e979 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3618,7 +3618,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
 			    FATTR4_WORD1_TIME_MODIFY |
 			    FATTR4_WORD1_TIME_METADATA))) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
+		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, exp, &dp);
 		if (status)
 			goto out;
 	}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74d2d7b42676..8ef2bec43afa 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -826,5 +826,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct dentry *dentry, struct nfs4_delegation **pdp);
+					   struct dentry *dentry,
+					   struct svc_export *exp,
+					   struct nfs4_delegation **pdp);
 #endif   /* NFSD4_STATE_H */
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 5a60004468b8..1bb75d740427 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -205,4 +205,16 @@ static inline struct vfsmount *fh_mnt(struct svc_fh *fhp)
 	return fhp->fh_export->ex_path.mnt;
 }
 
+/**
+ * fh_idmap - access idmap of vfsmount of a given file handle
+ * @fhp:  the filehandle
+ *
+ * Returns the struct idmap from the vfsmount of the export referenced in the
+ * filehandle.
+ */
+static inline struct mnt_idmap *fh_idmap(struct svc_fh *fhp)
+{
+	return mnt_idmap(fh_mnt(fhp));;
+}
+
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.48.1


