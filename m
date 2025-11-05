Return-Path: <linux-fsdevel+bounces-67167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74EC3724C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFC468486C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542B346798;
	Wed,  5 Nov 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWTpsunj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF333B970;
	Wed,  5 Nov 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361681; cv=none; b=ZdGCMo8mcepU6dNRo2ZWOSSFGGF2PEhjnB7dyAyU3MzRpmG8/jyFFeBLG8Rt/cTpxdDxak2ztCsy0lF2N1ZUp9RfCiET6X40pwkSFs59A7KreO+vIIpFFYGAFT7wY3amaP7v+h3aQC5kNzyDZxKtYWSXjBui69uOwg5EGFUN7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361681; c=relaxed/simple;
	bh=4nVJZFd2d/Rjh95mS/P/b1sCz4UVYDxkm9LfEMOl0LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVnKIqnY98huPGfw2Yir2/ZY/pYz04DdWWDvztE5blDy1GpRLlOHowIfx8z24B20o9mO1YWaqe8aDfgZHNx8fAXWPoEKPFrt522nCCptDolfb66gkd1EeZlFDCAg1LvJv9qjAdeoSDnWAj6teqEn0Tn+TiW4D50D3aUzKuT5XX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWTpsunj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE2BC4CEF5;
	Wed,  5 Nov 2025 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361680;
	bh=4nVJZFd2d/Rjh95mS/P/b1sCz4UVYDxkm9LfEMOl0LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XWTpsunjrlrR9H3MKUO+WuoGhTKFe+gT5MuOtbcgVGCXgyxhMA5JD/TM1drbpyv/Z
	 AbW/dSo0urwpWKJFhEYop+UkTdM2aodsuGooP5nSbxyM9WEN9UPnnMwQfJc4vEFtyg
	 u2E/BDg+dJB/M7s3u1pVZt3Cs7QlYtInPUvl36lc10rXbntRhrpQ3QE3gK5JHaLnnU
	 /DQwielOy+Csl3jPWU/WFl8U4FrezKCm9+I8rWPzeFxfTzBV6iCHb99mWy4vgJQ2oX
	 FS3NE1NoO9Hdym8jMcNQpti+8xRpc77Hu9nyONLEPlCIyF5E6zrcWnn4nL5uwoeLK9
	 gadsJbiPPcuZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:55 -0500
Subject: [PATCH v5 09/17] vfs: clean up argument list for vfs_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-9-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6719; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4nVJZFd2d/Rjh95mS/P/b1sCz4UVYDxkm9LfEMOl0LY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EsSmf683IMJJEkFQDDeFR8KQ9kJOcPWCS9j
 Ld41lk/MnyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLAAKCRAADmhBGVaC
 FSKWEADSYwweto3Ce2brU+Y+1k6HqzD/C/qVi8dORz9LzEbHPGW0a6q+7pxVRFbjIavSSUkor8T
 9AWETxZVVdGV8psXf9+VAYWXIkdviyQmasv/ZbQC4jWVbRpwmqk/gV6BEItcu+BjtZm2sjZtxBT
 zcoSoNmNOBH1eDvhzsaejoXNvqn82d3UruM8AYdCsmnS36qO00MN7vxTxI/1APCf6NtSKTDpy2Y
 77Bf89BEZfSTCCm3b4irIMnCetkQFz/5UZKjJIPgZ1cHwGp25xBWb4ZnpN2uWrykf4Lqew5YKkp
 G+UovgCywrg97O8D5+nnr9GfAfToGvvSGyr9yvHbz2O8n5XgNpnKkubXsx+izh6y9lW+ScvbNmj
 dWNxOJVPk/0pBUTJkcXIixt8dGBX1o1gkOaNuib65t2g85UJqNKL2IYhbHFyhIwORt7RLFite+S
 EMmLnQNrwF2NTtkXrk1DLVyXrQ7Ip2et+/FLGyDK4Hz97lsDpCe4EKnq75WnTasQqyQw0AR9QIA
 +B0tFN9gyA8hYJ6v1bvaYAUIR7HcbURu6Lhb5qVW/dlJrV1k6qkQzzcqXhDFH2kEJyNIDjS+W7T
 6WQAtrwcct9BZ4smbdBOeW9ISyQgpqjqd+eU1qrYAWTg7+WWrGhExXQ3hgl84fQmgosNyZACiA2
 40LOJJKY7nDVlGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Neil points out:

"I would be in favour of dropping the "dir" arg because it is always
d_inode(dentry->d_parent) which is stable."

...and...

"Also *every* caller of vfs_create() passes ".excl = true".  So maybe we
don't need that arg at all."

Drop both arguments from vfs_create() and fix up the callers.

Suggested-by: NeilBrown <neilb@ownmail.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      |  3 +--
 fs/namei.c               | 11 ++++-------
 fs/nfsd/nfs3proc.c       |  2 +-
 fs/nfsd/vfs.c            |  3 +--
 fs/open.c                |  4 +---
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  3 +--
 include/linux/fs.h       |  3 +--
 8 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..d109e3763a88150bfe64cd2d5564dc9802ef3386 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -188,8 +188,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 
 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+		rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
diff --git a/fs/namei.c b/fs/namei.c
index f439429bdfa271ccc64c937771ef4175597feb53..9586c6aba6eae05a9fc3c103b8501d98767bef53 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3461,10 +3461,8 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
  * @dentry:	dentry of the child file
  * @mode:	mode of the child file
- * @want_excl:	whether the file must not yet exist
  *
  * Create a new file.
  *
@@ -3474,9 +3472,9 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  */
-int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool want_excl)
+int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode)
 {
+	struct inode *dir = d_inode(dentry->d_parent);
 	int error;
 
 	error = may_create(idmap, dir, dentry);
@@ -3490,7 +3488,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+	error = dir->i_op->create(idmap, dir, dentry, mode, true);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4383,8 +4381,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	idmap = mnt_idmap(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+			error = vfs_create(idmap, dentry, mode);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..30ea7ffa2affdb9a959b0fd15a630de056d6dc3c 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -344,7 +344,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
+	host_err = vfs_create(&nop_mnt_idmap, child, iap->ia_mode);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c400ea94ff2e837fd59719bf2c4b79ef1d064743..464fd54675f3b16fce9ae5f05ad22e0e6b363eb3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1552,8 +1552,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
-				      iap->ia_mode, true);
+		host_err = vfs_create(&nop_mnt_idmap, dchild, iap->ia_mode);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
diff --git a/fs/open.c b/fs/open.c
index fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979..e440f58e3ce81e137aabdf00510d839342a19219 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1171,9 +1171,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 	if (IS_ERR(f))
 		return f;
 
-	error = vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
+	error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode);
 	if (!error)
 		error = vfs_open(path, f);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d215d7349489686b66bb66e939b27046f7d836f6..2bdc434941ebc70f6d4f57cca4f68125112a7bc4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -235,7 +235,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
+	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dentry, mode);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c5f0f3170d586cb2dc4d416b80948c642797fb82..83ece2de4b23bf9209137e7ca414a72439b5cc2e 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -188,8 +188,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	}
 
 	mode |= S_IFREG;
-	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
-			 dentry, mode, true);
+	err = vfs_create(mnt_idmap(path.mnt), dentry, mode);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
 					d_inode(dentry));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 12873214e1c7811735ea5d2dee3d57e2a5604d8f..21876ef1fec90181b9878372c7c7e710773aae9f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2111,8 +2111,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 /*
  * VFS helper functions..
  */
-int vfs_create(struct mnt_idmap *, struct inode *,
-	       struct dentry *, umode_t, bool);
+int vfs_create(struct mnt_idmap *, struct dentry *, umode_t);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


