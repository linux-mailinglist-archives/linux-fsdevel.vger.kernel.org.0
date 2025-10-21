Return-Path: <linux-fsdevel+bounces-64949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4309BF75D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68BE506A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91501347FEE;
	Tue, 21 Oct 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBQG02Eb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDB347FC1;
	Tue, 21 Oct 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060382; cv=none; b=rHJH83vs4fBZTX/Whi7bk9FjTMu/2WhPeL4UKY/1w2pNCuGLsMwSgVMDzEEu/Q5LkZrJxqiK2bkzR2ViYPzTo/0SD7+8VtLGPDgZRWZ0pkfpRlHztXd+lSBPkEGE9QnsDO1yd9hCcffpp9qX/bDx0VgzMyDK+9+b9azsnfrttQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060382; c=relaxed/simple;
	bh=1if+7pIcycx8q41cWWMlMqA3QfQkY2owvRZn4v6lKC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyHfZGiuq6jbPGmjEYdkTNq0TiVZAeL30Tw37aBjaL0RMl1W0wIPd5Mx2UYjNHBrgcqEE/1caowushb3sqkAPnQWz9C3jkUldSOXuRjzgIW++EzFPP2L4+q5AXK0XrxLGpyJ9rphd1mNY5yBr51n0LCr/wpJ8lPAhI8wzxe+Rno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBQG02Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EFC19421;
	Tue, 21 Oct 2025 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060382;
	bh=1if+7pIcycx8q41cWWMlMqA3QfQkY2owvRZn4v6lKC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HBQG02EbwsAw3KkIwEEybgzGqDgYbEUd8viqGcfF9a/mMqT0//aZRQGwsBx8qFqSP
	 Tpoz7UW8trCDkYt/NMtE7AM9h3L7LqocH4xhxXJVdMJO3XfiTIxFZ9/QczFiIV1Gfy
	 zJqEGy2HV5ssPCJwuZXbshTNPmN74JbsuZntIi+7xVNmAF8FwFslghavATo5L9nEPP
	 x6J48BL5cCHfdErMyjzCbAbS7aOxI6XncB2y8h1oJZz8TyBAi8LmAHX+5bpMahCIGH
	 Aw5xrgnfyFxBVUO7bTb2W89y39/ghwkVMaX74+wSuKh3Hxz9lJU72sa9CIF3PrpM8Q
	 QnqsDIOGkd4zA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:41 -0400
Subject: [PATCH v3 06/13] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-6-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7451; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1if+7pIcycx8q41cWWMlMqA3QfQkY2owvRZn4v6lKC8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YFKWV6I0Px7WL6VsPpL9jFbX+1T+qvjmzr2
 8wvSHv0cteJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBQAKCRAADmhBGVaC
 FaqnEACa0vhuueepIFqyIn+koGRzeI1c9QE2xXVQZmuS9YRNKktNcdk2B8aU873Iekpl8Oh4EPl
 g/Axm2ZeOHuHEjybkyxs1uNAdn/JgI3y/be3vEXxgzu5xKnag0hwbBvCPJPxuRseIbGWsMJ4UxO
 zFmGCfEaJU4uRi4Z2/PA658oqAIYuCpHjoc20+YE6mGJudRtaXzdtJePuTAV/ayIOFUMHki4QPl
 tCZJiQVumIXNnS54I1ABc35gdb/ay0cDics+aYiXbsINNCwy1x8X+hxh9B6a0ThX/NoAsLngV75
 TL4huPIYtYrrB4HvG6l91EoSFPWHdl1gPd+R4Np+dXRp0K7Q6s7TXNaJzd2ia+wO5lazc+GUJdO
 9Ns1W0X4I8zmDUe77vRsnioPEG31RH3qE8vlwcwhmOKQyCPkMvji+eLi/mhovy09d4G7PNYa6V4
 EvJL6QJ0ijIKSU3zsgS2veB6bP4eGYEeiR89Fq0WaonREYCswxVpbP+guP4XCT8PK5vUAkSZ41E
 MVES+E0IFXYpEnG4RWCN+iSkOOZTgmY+Yt/ghPgfLE0UawzPz5qFZnKz6ZdWu9DTzXqr63dR2mp
 tz6WpLw9qhniUAN/fyKfyT1q3illcgVtaQBTFnmtIG92jtGVn8tEVTlzVo03sim6puwxlmsGJD2
 i6XtuMeZIW+gEYg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to vfs_create. Most callers are
converted to pass in NULL, but do_mknodat() is changed to wait for a
delegation break if there is one.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
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
index ad14b34583bb9fd7cd1e29f5f8676fa3442dd661..dbf70d184c0276d198599a22eb0953a2a1dde2c8 100644
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
index 85afd2fad7e08b66b1a9ce372afdea1df52086be..7eaae44467188fab0909fabec986e103bcd52457 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1639,8 +1639,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


