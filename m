Return-Path: <linux-fsdevel+bounces-44405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E1A68399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F627ABCEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A624F5A0;
	Wed, 19 Mar 2025 03:16:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CC42A80;
	Wed, 19 Mar 2025 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354170; cv=none; b=ppsINB/srs/DOhh+oAnIP5IRoBFNeSPM+NSkCuTryrfvfmj01eYHFbvclQMt1rSTVjYXP74P9LsPpHVD+DX4/re3hBTQRszIHBPZbxLx8LlA0xbgepGXQZTcD+9z2uiJgGtayoFyZYpqD6jSA9Fnmok/wXvtGCawobZYJSPLKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354170; c=relaxed/simple;
	bh=EhqkeYkW+pMj15egrCG8LwXIY7UrMmUNmw6nuqSPTnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrVi0tgHzgNDvFWABLexaR5HCKcEZ9WTFqrCvFoucQNznkOJNhkcB+HkD1t6yjZsBIZhvOI4g0TRWdYN5Gv6Q/p2hq/9d+8Ma+qE5M8OeWU7KMDJwUWjYOopDYC0HOjUJmjLmfJ0R2B+567Xu0y8/lp1D0HpMvCwRbUyOZ4cejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tujuO-00G6oj-4G;
	Wed, 19 Mar 2025 03:15:56 +0000
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
Subject: [PATCH 2/6] nfsd: Use lookup_one() rather than lookup_one_len()
Date: Wed, 19 Mar 2025 14:01:33 +1100
Message-ID: <20250319031545.2999807-3-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319031545.2999807-1-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd uses some VFS interfaces (such as vfs_mkdir) which take an explicit
mnt_idmap, and it passes &nop_mnt_idmap as nfsd doesn't yet support
idmapped mounts.

It also uses the lookup_one_len() family of functions which implicitly
use &nop_mnt_idmap.  This mixture of implicit and explicit could be
confusing.  When we eventually update nfsd to support idmap mounts it
would be best if all places which need an idmap determined from the
mount point were similar and easily found.

So this patch changes nfsd to use lookup_one(), lookup_one_unlocked(),
and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.

This has the benefit of removing some uses of the lookup_one_len
functions where permission checking is actually needed.  Many callers
don't care about permission checking and using these function only where
permission checking is needed is a valuable simplification.

This change requires passing the name in a qstr.  Currently this is a
little clumsy, but if nfsd is changed to use qstr more broadly it will
result in a net improvement.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs3proc.c    |  4 +++-
 fs/nfsd/nfs3xdr.c     |  4 +++-
 fs/nfsd/nfs4proc.c    |  4 +++-
 fs/nfsd/nfs4recover.c | 13 +++++++------
 fs/nfsd/nfs4xdr.c     |  4 +++-
 fs/nfsd/nfsproc.c     |  6 ++++--
 fs/nfsd/vfs.c         | 17 +++++++++--------
 7 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..9fa8ad08b1cd 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -284,7 +284,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 
-	child = lookup_one_len(argp->name, parent, argp->len);
+	child = lookup_one(&nop_mnt_idmap,
+			   QSTR_LEN(argp->name, argp->len),
+			   parent);
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
 		goto out;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a7a07470c1f8..5a626e24a334 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1001,7 +1001,9 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		} else
 			dchild = dget(dparent);
 	} else
-		dchild = lookup_positive_unlocked(name, dparent, namlen);
+		dchild = lookup_one_positive_unlocked(&nop_mnt_idmap,
+						      QSTR_LEN(name, namlen),
+						      dparent);
 	if (IS_ERR(dchild))
 		return rv;
 	if (d_mountpoint(dchild))
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6e06c779d09..5860f3825be2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -266,7 +266,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 
-	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	child = lookup_one(&nop_mnt_idmap, QSTR_LEN(open->op_fname,
+						    open->op_fnamelen),
+			   parent);
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
 		goto out;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c1d9bd07285f..5c1cb5c3c13e 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -218,7 +218,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	/* lock the parent */
 	inode_lock(d_inode(dir));
 
-	dentry = lookup_one_len(dname, dir, HEXDIR_LEN-1);
+	dentry = lookup_one(&nop_mnt_idmap, QSTR(dname), dir);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		goto out_unlock;
@@ -316,7 +316,8 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
 		if (!status) {
 			struct dentry *dentry;
-			dentry = lookup_one_len(entry->name, dir, HEXDIR_LEN-1);
+			dentry = lookup_one(&nop_mnt_idmap,
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
+	dentry = lookup_one(&nop_mnt_idmap, QSTR(name), dir);
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
index e67420729ecd..16be860b1f79 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3812,7 +3812,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
+	dentry = lookup_one_positive_unlocked(&nop_mnt_idmap,
+					      QSTR_LEN(name, namlen),
+					      cd->rd_fhp->fh_dentry);
 	if (IS_ERR(dentry))
 		return nfserrno(PTR_ERR(dentry));
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..ac7d7f858846 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -312,7 +312,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	dchild = lookup_one(&nop_mnt_idmap, QSTR_LEN(argp->name,
+						     argp->len),
+			    dirfhp->fh_dentry);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_unlock;
@@ -331,7 +333,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		resp->status = nfserr_acces;
 		if (!newfhp->fh_dentry) {
-			printk(KERN_WARNING 
+			printk(KERN_WARNING
 				"nfsd_proc_create: file handle not verified\n");
 			goto out_unlock;
 		}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 34d7aa531662..c0c94619af92 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -265,7 +265,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				goto out_nfserr;
 		}
 	} else {
-		dentry = lookup_one_len_unlocked(name, dparent, len);
+		dentry = lookup_one_unlocked(&nop_mnt_idmap,
+					     QSTR_LEN(name, len), dparent);
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
+	dchild = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
 		err = nfserrno(host_err);
@@ -1660,7 +1661,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	dentry = fhp->fh_dentry;
 	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
 		inode_unlock(dentry->d_inode);
@@ -1726,7 +1727,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	dirp = d_inode(ddir);
 	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = lookup_one(&nop_mnt_idmap, QSTR_LEN(name, len), ddir);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
 		goto out_unlock;
@@ -1839,7 +1840,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (err != nfs_ok)
 		goto out_unlock;
 
-	odentry = lookup_one_len(fname, fdentry, flen);
+	odentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), fdentry);
 	host_err = PTR_ERR(odentry);
 	if (IS_ERR(odentry))
 		goto out_nfserr;
@@ -1851,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (odentry == trap)
 		goto out_dput_old;
 
-	ndentry = lookup_one_len(tname, tdentry, tlen);
+	ndentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(tname, tlen), tdentry);
 	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
@@ -1948,7 +1949,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	dirp = d_inode(dentry);
 	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	rdentry = lookup_one_len(fname, dentry, flen);
+	rdentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
 		goto out_unlock;
-- 
2.48.1


