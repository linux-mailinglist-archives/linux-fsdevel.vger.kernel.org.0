Return-Path: <linux-fsdevel+bounces-43992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00136A60825
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F83BFDA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02D1537AC;
	Fri, 14 Mar 2025 04:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B67F7FC;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928233; cv=none; b=L+xlCpQqpsfnbVYbyUXMDlsmhyZEr5z/Jl10lXA7IH5gLobvgWAcItY4i+ZGSTMRmDdcdnp23jwfnW/fD/p7H7jbZO1RwTIXUHBjUmN8uKeblAEyuXV5987zXylOjhi7IHDbs9tSV2V6oE8XdDQL+f8XXTN1U2HfADYyB0yP0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928233; c=relaxed/simple;
	bh=W2FYcGlxuu0kpeT/emanIqjd3BlSiJ3xteCDMrQJCSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbuSNCEpIRN30UlBvlR+ALCfPb7YTO6vYKrOUpTPhjeMUUMkhqlVyIviEdQsX6mc4FkJEzQOR2CB14hxN07U175adPbMVdXcDoPd0jSUSxPjUY+owsh8LRlGgaNKly71lVPefSclQF5yWuflROIdR630/4QhBHGWYbQ/YHRB8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6X-00E3vl-J0;
	Fri, 14 Mar 2025 04:57:05 +0000
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
Subject: [PATCH 2/8] nfsd: Use lookup_one() rather than lookup_one_len()
Date: Fri, 14 Mar 2025 11:34:08 +1100
Message-ID: <20250314045655.603377-3-neil@brown.name>
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

lookup_one_len() does not support idmapped mounts and does permission
checking on the non-mapped uids.  This means that nfsd cannot correctly
export idmapped mounts.

This patch changes to use lookup_one(), lookup_one_unlocked(), and
lookup_one_positive_unlocked() passing the relevant vfsmount so
idmapping can be honoured.

This requires passing the name in a qstr.  Currently this is a little
clumsy, but if nfsd is changed to use qstr more broadly it will result
in a net improvement.

Note that there are still many places where nfsd uses nop_mnt_idmap so
more work is needed to properly support idmapped mounts.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs3proc.c    |  3 ++-
 fs/nfsd/nfs3xdr.c     |  4 +++-
 fs/nfsd/nfs4proc.c    |  4 +++-
 fs/nfsd/nfs4recover.c | 13 +++++++------
 fs/nfsd/nfs4xdr.c     |  4 +++-
 fs/nfsd/nfsproc.c     |  5 +++--
 fs/nfsd/vfs.c         | 17 +++++++++--------
 fs/nfsd/vfs.h         | 12 ++++++++++++
 8 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..457638bf0f32 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -284,7 +284,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 
-	child = lookup_one_len(argp->name, parent, argp->len);
+	child = lookup_one(fh_mnt(fhp), QSTR_LEN(argp->name, argp->len),
+			   parent);
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
 		goto out;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a7a07470c1f8..54fcc814e398 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1001,7 +1001,9 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		} else
 			dchild = dget(dparent);
 	} else
-		dchild = lookup_positive_unlocked(name, dparent, namlen);
+		dchild = lookup_one_positive_unlocked(fh_mnt(fhp),
+						      QSTR_LEN(name, namlen),
+						      dparent);
 	if (IS_ERR(dchild))
 		return rv;
 	if (d_mountpoint(dchild))
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6e06c779d09..9e29663aaeb1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -266,7 +266,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 
-	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	child = lookup_one(fh_mnt(fhp),
+			   QSTR_LEN(open->op_fname, open->op_fnamelen),
+			   parent);
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
 		goto out;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c1d9bd07285f..10d24bec532f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -218,7 +218,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	/* lock the parent */
 	inode_lock(d_inode(dir));
 
-	dentry = lookup_one_len(dname, dir, HEXDIR_LEN-1);
+	dentry = lookup_one(nn->rec_file->f_path.mnt, QSTR(dname), dir);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		goto out_unlock;
@@ -316,7 +316,8 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
 		if (!status) {
 			struct dentry *dentry;
-			dentry = lookup_one_len(entry->name, dir, HEXDIR_LEN-1);
+			dentry = lookup_one(nn->rec_file->f_path.mnt,
+					    QSTR(entry->name), dir);
 			if (IS_ERR(dentry)) {
 				status = PTR_ERR(dentry);
 				break;
@@ -339,16 +340,16 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 }
 
 static int
-nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
+nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 {
 	struct dentry *dir, *dentry;
 	int status;
 
-	dprintk("NFSD: nfsd4_unlink_clid_dir. name %.*s\n", namlen, name);
+	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
 
 	dir = nn->rec_file->f_path.dentry;
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	dentry = lookup_one_len(name, dir, namlen);
+	dentry = lookup_one(nn->rec_file->f_path.mnt, QSTR(name), dir);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		goto out_unlock;
@@ -408,7 +409,7 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 	if (status < 0)
 		goto out_drop_write;
 
-	status = nfsd4_unlink_clid_dir(dname, HEXDIR_LEN-1, nn);
+	status = nfsd4_unlink_clid_dir(dname, nn);
 	nfs4_reset_creds(original_cred);
 	if (status == 0) {
 		vfs_fsync(nn->rec_file, 0);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..64ab2c605e93 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3812,7 +3812,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
+	dentry = lookup_one_positive_unlocked(fh_mnt(cd->rd_fhp),
+					      QSTR_LEN(name, namlen),
+					      cd->rd_fhp->fh_dentry);
 	if (IS_ERR(dentry))
 		return nfserrno(PTR_ERR(dentry));
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..a84719935690 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -312,7 +312,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	dchild = lookup_one(fh_mnt(dirfhp), QSTR_LEN(argp->name, argp->len),
+			    dirfhp->fh_dentry);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_unlock;
@@ -331,7 +332,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		resp->status = nfserr_acces;
 		if (!newfhp->fh_dentry) {
-			printk(KERN_WARNING 
+			printk(KERN_WARNING
 				"nfsd_proc_create: file handle not verified\n");
 			goto out_unlock;
 		}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 34d7aa531662..2829799bcd08 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -265,7 +265,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				goto out_nfserr;
 		}
 	} else {
-		dentry = lookup_one_len_unlocked(name, dparent, len);
+		dentry = lookup_one_unlocked(fh_mnt(fhp), QSTR_LEN(name, len),
+					     dparent);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
@@ -923,7 +924,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	 * directories, but we never have and it doesn't seem to have
 	 * caused anyone a problem.  If we were to change this, note
 	 * also that our filldir callbacks would need a variant of
-	 * lookup_one_len that doesn't check permissions.
+	 * lookup_one_positive_unlocked() that doesn't check permissions.
 	 */
 	if (type == S_IFREG)
 		may_flags |= NFSD_MAY_OWNER_OVERRIDE;
@@ -1555,7 +1556,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return nfserrno(host_err);
 
 	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = lookup_one(fh_mnt(fhp), QSTR_LEN(fname, flen), dentry);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
 		err = nfserrno(host_err);
@@ -1660,7 +1661,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	dentry = fhp->fh_dentry;
 	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = lookup_one(fh_mnt(fhp), QSTR_LEN(fname, flen), dentry);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
 		inode_unlock(dentry->d_inode);
@@ -1726,7 +1727,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	dirp = d_inode(ddir);
 	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = lookup_one(fh_mnt(ffhp), QSTR_LEN(name, len), ddir);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
 		goto out_unlock;
@@ -1839,7 +1840,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (err != nfs_ok)
 		goto out_unlock;
 
-	odentry = lookup_one_len(fname, fdentry, flen);
+	odentry = lookup_one(fh_mnt(ffhp), QSTR_LEN(fname, flen), fdentry);
 	host_err = PTR_ERR(odentry);
 	if (IS_ERR(odentry))
 		goto out_nfserr;
@@ -1851,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (odentry == trap)
 		goto out_dput_old;
 
-	ndentry = lookup_one_len(tname, tdentry, tlen);
+	ndentry = lookup_one(fh_mnt(tfhp), QSTR_LEN(tname, tlen), tdentry);
 	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
@@ -1948,7 +1949,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	dirp = d_inode(dentry);
 	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	rdentry = lookup_one_len(fname, dentry, flen);
+	rdentry = lookup_one(fh_mnt(fhp), QSTR_LEN(fname, flen), dentry);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
 		goto out_unlock;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index f9b09b842856..5a60004468b8 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -193,4 +193,16 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
 
+/**
+ * fh_mnt - access vfsmount of a given file handle
+ * @fhp:  the filehandle
+ *
+ * Returns the struct vfsmount from the export referenced in the
+ * filehandle.
+ */
+static inline struct vfsmount *fh_mnt(struct svc_fh *fhp)
+{
+	return fhp->fh_export->ex_path.mnt;
+}
+
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.48.1


