Return-Path: <linux-fsdevel+bounces-64483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5EFBE8601
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5245E1303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3436CDF6;
	Fri, 17 Oct 2025 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEBSh0gt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B112E6106;
	Fri, 17 Oct 2025 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700763; cv=none; b=tjt3O7/HCTCgn2upUlsJ3rKVrL7c61W4Rzg/6abr8/B3mkEvAHbU5jaFtrE2HThWauLuneC+qj6sGMmc1mNb3jtsvVfd1S2TN0NH7jQgr7xH0Gjn7Nm3cOHtmKYXOwkc+LA6S37TZlEWze07wXQpjyeW5QrxuIIxuDN1WRctq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700763; c=relaxed/simple;
	bh=3eMECg/xYHGrFwt7wDF0a07nGYeeRm/Z0p+5FBUu9A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6DhzbnvxR1XfR2zBSCaL0yYTITN3e0WZcZsHUamVFbzU0hL4jntiLURhR555461sVM78RemhEEVghWiZ6xDH+0K360n9UjcSzWphsg0cjgvowgJMevULOEb3cM7ZodLEMKUq4g7p0oUdZuAmas8hLCwbO+IDz97pX5W0SXlLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEBSh0gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5C0C4CEE7;
	Fri, 17 Oct 2025 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700762;
	bh=3eMECg/xYHGrFwt7wDF0a07nGYeeRm/Z0p+5FBUu9A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bEBSh0gtVXtojF2fsd0sOeuD93IZCUuU3f/YYZLC77Kle9dEpDTMsYWD25pGEfZHZ
	 41VdsqLgmXVoJAJlvNxYS66W/esLTUGmZiTeSdY3xn73MKId4XVwfv3BnLBNqQhXp3
	 UkZQbZPFebLzfcstx/HiF5Cy/EvyLIpmewtN74+TcAnWUxLStb4hUctW0yaTBKX9gF
	 tsKbQaaJhzbUsNBImEDN3Rfbnz6RBnK8ygk30FJ/+3h+Qtgq8WDKmSTjTwYI5uaDGd
	 4dRlv5Yb/po3WkDnw86hlmxwYDJ2JfDOgCMH9tYWwbrH3poTDdRrLpquBwAWqKK0wO
	 Dc3KNR8dHeSsA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:31:58 -0400
Subject: [PATCH v2 06/11] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-6-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3eMECg/xYHGrFwt7wDF0a07nGYeeRm/Z0p+5FBUu9A0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilBffB9t3CH95c5nJkhwKFZR8oHpS61LcS+6
 SugTAvSMHuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQQAKCRAADmhBGVaC
 FcK9D/9IKl5gJSEt7Bto+vzLCgGl6j6sC8dM5EN/RsfBDo6bRj7ud3ZAwh2hMsHzzHrkPpAtpbC
 qdtCKNkKPTx+5gS3Gz+LHdz0/aivYevYRehpXcCvxGWvAGGja4BgeZ0LDVqTDKVLLYIK8Opu59k
 HvGte9jT/1V2NrN83VmLZMoA+HcSPBvWj4S4lwh17Gw8TZhxG8jCVwxk+VHImIEx3ZKuiY1CQkf
 s1o5x04H2maZEQA4c0I/qdxWgsXNSKxxqsxoLLTkB5wQKjpDm+agVLjZoVZ/1N3rtGcqFpfLaK4
 4Xl7br3om1YNqReTElcpx2cvJsPlrmxN9cWiLLvI04eRacJ32X0Cx9ZKECbx528AYjDc7p+rPcE
 x+2F7OKEJPL30ylmPDyy78yaFG+siUtqfcQ3Sx5pF3sgdUVI8lGqC3oHcUzjuaaJy2Luyne5wuE
 cG2g3w5728VLr+3la23LmihzU7xX1ipXPFFPqjjfbajE+tEX3VK4Lpq1bHu21RD3rcXYQcyczaW
 OQb+0v+BI1TnE8UykvcSjtWygf5lfjmQjOyfnsQ+ujsTCr0cAhPmzwqJfnunvFizcePXY8wso03
 +51Wa37QkMJQuypBQAUWWPfQxF6RWn05ihL/AkeHK9VrqUEr6Ym3tmV3n2uVwXh5bbo2NeRMjX5
 H1D4xEwJtIjpGSA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to vfs_create. Most callers are
converted to pass in NULL, but do_mknodat() is changed to wait for a
delegation break if there is one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      |  2 +-
 fs/namei.c               | 26 +++++++++++++++++++-------
 fs/nfsd/nfs3proc.c       |  2 +-
 fs/nfsd/vfs.c            |  3 +--
 fs/open.c                |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  2 +-
 include/linux/fs.h       |  2 +-
 8 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..661709b157ce854c3bfdfdb13f7c10435fad9756 100644
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
index 786f42bd184b5dbf6d754fa1fb6c94c0f75429f2..7510942e0249de19df4363b92f813b3acdfc2254 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3460,11 +3460,12 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 
 /**
  * vfs_create - create new file
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child file
- * @mode:	mode of the child file
- * @want_excl:	whether the file must not yet exist
+ * @idmap:		idmap of the mount the inode was found from
+ * @dir:		inode of the parent directory
+ * @dentry:		dentry of the child file
+ * @mode:		mode of the child file
+ * @want_excl:		whether the file must not yet exist
+ * @delegated_inode:	returns parent inode, if the inode is delegated.
  *
  * Create a new file.
  *
@@ -3475,7 +3476,8 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool want_excl)
+	       struct dentry *dentry, umode_t mode, bool want_excl,
+	       struct inode **delegated_inode)
 {
 	int error;
 
@@ -3488,6 +3490,9 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, delegated_inode);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
@@ -4365,6 +4370,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4384,7 +4390,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+					   dentry, mode, true,
+					   &delegated_inode);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
@@ -4399,6 +4406,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	end_creating_path(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..f3977c52fe27b4ff0c0e2d62cf8c14b49bbd8b13 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -344,7 +344,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
+	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true, NULL);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7d8cd2595f197be9741ee6320d43ed6651896647..8834bc59f5cfcc88797eb09189b6c12d29e98d10 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1638,8 +1638,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
-				      iap->ia_mode, true);
+		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, true, NULL);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc675e4795eb0a0deda10f8f67b95640..4d98f8b52b98bc95e52cb247d14871ff6e4a1b5c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1173,7 +1173,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 
 	error = vfs_create(mnt_idmap(path->mnt),
 			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
+			   path->dentry, mode, true, NULL);
 	if (!error)
 		error = vfs_open(path, f);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d215d7349489686b66bb66e939b27046f7d836f6..d3123f5d97e86b58e4c9608cf6ef2abd1fcddbcd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -235,7 +235,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
+	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true, NULL);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c5f0f3170d586cb2dc4d416b80948c642797fb82..be278bb6b71bab8aa41aed06a8806e7bc2de4cd3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -189,7 +189,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 
 	mode |= S_IFREG;
 	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
-			 dentry, mode, true);
+			 dentry, mode, true, NULL);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
 					d_inode(dentry));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d8bdaf7c87502ff17775602f5391d375738b4ed8..5fcf64d9cf42ce135c0fbcbf6dfbf8816ae0bcb1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2111,7 +2111,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
  * VFS helper functions..
  */
 int vfs_create(struct mnt_idmap *, struct inode *,
-	       struct dentry *, umode_t, bool);
+	       struct dentry *, umode_t, bool, struct inode **);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.0


