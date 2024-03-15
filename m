Return-Path: <linux-fsdevel+bounces-14495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3687D1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D928177B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3F58136;
	Fri, 15 Mar 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdVoPRdS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E925789A;
	Fri, 15 Mar 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521609; cv=none; b=uZC11cwNWTWbNLlsz67vttcpZO8XfGgrsIGM/j19J7J/SpI1qf++hfzDjNz+UG6miufms7nVHa+Hs/e59rtRLcn8mjX8a8hm2bjpb2bVRhIfh6meqceHA/qowvZtydV0SwK56/+6WB5lVuzng+SnDaBxTxYE0JwGPNAgwRUDrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521609; c=relaxed/simple;
	bh=glgM3noZVvpgC18bf/O/H9XbEIKtml3KkdNnOiy8zrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loNXr8hSaJqdcGLWZt3igTXtXvzAMax8QrBci+VqWNjOzXL8UCg7iOX7D7SAOzf2HHYqBj5QTit0QVawpGUqf+/3xLtY56rYk2wWxAVTCetkbCi87ZuzRBVMeOhtyAwP1m7elOEF4nWTsW/I7XzxZtnqCX71XDkYC3v9onGJY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdVoPRdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3AC433B2;
	Fri, 15 Mar 2024 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521609;
	bh=glgM3noZVvpgC18bf/O/H9XbEIKtml3KkdNnOiy8zrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VdVoPRdS9rWL+OtiSBwfMZSVrxf5PYEtpWN6TxBcbQjAyTwRJJQ4UTV+3Zvc5682A
	 b4Ox2Coe/lFOnomcVJigs43Lgkwu2ezvgnHYVCyuf3d6Q/5DMg1pyHZmF8OlIHri1Z
	 t/pA7Tf3EqRoKEZeNNnldgTeJ7KYXmOg1I6KuhFanOGU5u0bQZz2MZlJwjJAuBnutG
	 01C5N07R8a1WXy71M1wLuSIvxWRKaKGtYfIumdLDoxwooS0QC7gQmGloeRgL2mX0fX
	 fXhmerZjC77g6y922Rs0Q/x3/sYk77aadNc38cJmUC31WjDvoFxlQkMYuCww3Wg8Ij
	 1u04AzH7TQGbg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:58 -0400
Subject: [PATCH RFC 07/24] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-7-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6464; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=glgM3noZVvpgC18bf/O/H9XbEIKtml3KkdNnOiy8zrM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hztj02A0ox+G3fk9c35abnyHv3ewQW8y77IN
 UsVqKDGetGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FYn1D/4u9cH/KKPFevh9JevmDnEzcvgiG2JXDGRTokqAPxsRMA9XL/nlKGK80vAGVfXpnP1sIri
 nC0Cr94CFOIPMr+nC9v11y/qI/IkjtY7ekq/pKXGrIajvynPx69f+OsLUOIfeAlC4lzKmDye47u
 CIhdtAUb3UbcPwEceV69AUdDw2yfNd2zoOrQLDsp+Z41xCX70juLmOPFE6OnrwII2XmJsFT5gFg
 P2H5iw+STZTkKuLMP72816+1oWO09Zc5ZhSaFTG1xXNggjpVk6zAb+7OsbvHlGf/tiyPvK+XGlV
 8ccjpRvAUx7oBCtyyXhFy4EBFGB7668+qOH/39Hdhnm/icffHBzIKQfsxM+nf8fjRWijnubMksM
 Qr1+Diztt2hYsO6FpW0yfdt29ZGcPjh4WMTNMI/jbCwyqTZL9kWrKinmE9QzD3me17lEhbB6oZp
 mjd4c1Ut8MhTEXvMb20LyNBZyEz8xMppipjxXH7qx3y6V7BAXKGnD+qX8OxhrbkbhWFgUjAM1Bq
 axlJ4F/uDHSSyPD17NnBRj1NpvVYQJsSE1+jBz3OOP+QM2NbFt+DKcEIbl/KdEhLW/awo2LvIjw
 aDz7yktrvz4fQgELpfoA7MzB4S2RogS+3A0TODKTeQrHD0NELk9GFs+8k49JyIypqmgSdM0bLHF
 zWUYZZRUnre6OvA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode parameter to vfs_create. Most callers will
set that to NULL, but do_mknodat can use that to synchronously wait
for the delegation break to complete.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      |  2 +-
 fs/namei.c               | 15 +++++++++++++--
 fs/nfsd/nfs3proc.c       |  2 +-
 fs/nfsd/vfs.c            |  2 +-
 fs/open.c                |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  2 +-
 include/linux/fs.h       |  2 +-
 8 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 3d0cddbf037c..a99b1e264c46 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -189,7 +189,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
 	if (!rc)
 		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+				lower_dentry, mode, true, NULL);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
diff --git a/fs/namei.c b/fs/namei.c
index 88598a62ec64..01e04cf155eb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3174,6 +3174,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new file
  * @want_excl:	whether the file must not yet exist
+ * @delegated_inode: return pointer for delegated_inode
  *
  * Create a new file.
  *
@@ -3184,7 +3185,8 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool want_excl)
+	       struct dentry *dentry, umode_t mode, bool want_excl,
+	       struct inode **delegated_inode)
 {
 	int error;
 
@@ -3197,6 +3199,9 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, delegated_inode);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
@@ -4047,6 +4052,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4066,7 +4072,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+					   dentry, mode, true, &delegated_inode);
 			if (!error)
 				ima_post_path_mknod(idmap, dentry);
 			break;
@@ -4081,6 +4087,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	done_path_create(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index dfcc957e460d..e920a6291f2d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -313,7 +313,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
+	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true, NULL);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 34cc2d1a4944..47b8ab1d4b17 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1491,7 +1491,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	switch (type) {
 	case S_IFREG:
 		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
-				      iap->ia_mode, true);
+				      iap->ia_mode, true, NULL);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
diff --git a/fs/open.c b/fs/open.c
index 0a73afe04d34..0b50ea7e8aec 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1137,7 +1137,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 
 	error = vfs_create(mnt_idmap(path->mnt),
 			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
+			   path->dentry, mode, true, NULL);
 	if (!error)
 		error = vfs_open(path, f);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5b1f56294c4d..be2518e6da95 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -232,7 +232,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
+	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true, NULL);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5b4e5876c2ac..b313eb5a1d28 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -187,7 +187,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 
 	mode |= S_IFREG;
 	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
-			 dentry, mode, true);
+			 dentry, mode, true, NULL);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
 					d_inode(dentry));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e72c825476de..8fb4101fea49 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1837,7 +1837,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
  * VFS helper functions..
  */
 int vfs_create(struct mnt_idmap *, struct inode *,
-	       struct dentry *, umode_t, bool);
+	       struct dentry *, umode_t, bool, struct inode **);
 int vfs_mkdir(struct mnt_idmap *, struct inode *,
 	      struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.44.0


