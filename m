Return-Path: <linux-fsdevel+bounces-14492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948587D1A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C001F22BF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9B54756;
	Fri, 15 Mar 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY22mtdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0E5476B;
	Fri, 15 Mar 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521600; cv=none; b=HrPpBnBiMTD4apcGj5D2dQ7SLBD5a3o0v5chHhrPifCJiJeAbOIRPFJUg80BMaPmIuJZyaLzEsI53kyvbC8I8pfXAmlYEekEa7DPKD9f6aL6GWdtLdIamMsZpoDPWLrNrlD+7Fgl4NNOLMOiYxfWzcI3TyZUh8LCYpxGwSsBSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521600; c=relaxed/simple;
	bh=dYFxokjKa1qkijO4rvlZtg8suVitMd6Maf1anlNcBeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/u3F2aMBlYaNk/rfyctSAxp0H+2WOQCKFj2AktIrjXFul8ekjjxY76Ko9tKqDo27fcE2eggS3FQEDtx/Z1pDzcoc8gX3+9UdkzoFVxvBIZNt/TxHJXK9KmR+0gOot94berOS7djrEUiGAsiH/4oit6Te9PPqF0QKg3qB0Pg2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY22mtdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60F9C43390;
	Fri, 15 Mar 2024 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521599;
	bh=dYFxokjKa1qkijO4rvlZtg8suVitMd6Maf1anlNcBeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dY22mtdp8I4Lw1p+jspcjYw3FPUZ2tA76A3yQ+5QvWSDLBLCCsEWeFvLtQxHBlrhm
	 9q/YpywBlcMbfj7kNYwnbhTpEAon5efpJIKJkCzHwJ8dXzKyZW8U8VI9JCoNF8ydaH
	 d522wue/Bds2QDfkur6Ykfk4rM5z45uWosouYEln+jSZGX5kOw6+wwicomBTJJgOPy
	 ydSTRaIL2fvCNWzvQqdq5VdZOQogTsEGP+Xj+pQbxbG0izAFaYjr8Vov+nYfPPUISN
	 K/L0o5132ayJIEgJ/9hyCBUsZIjHB6nN1IkyrRzpvlRgqvlUsVyaUX5BC4GPJ4qpby
	 ql15tpb2aBQMA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:55 -0400
Subject: [PATCH RFC 04/24] vfs: allow mkdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-4-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7376; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dYFxokjKa1qkijO4rvlZtg8suVitMd6Maf1anlNcBeo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzt2YNTHp03zBF3TkT69pRtsIg/EwN1lwb+0
 DNF7I1m+CiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FVWBEACABlZC1oNdEVOjMMtqfTwWD7iCcDQX+oI8naMY1y4jsOXn5COAN2wyDD/QkFaBB9GZRag
 jGbN68ItVtP2FVFEwM0D/gY/mOH8BO9m6CbsLBVXdSZ82DcAPk5dDN9lRvHgVquyKpW+VXFdgIb
 xS1rKJ0hOzNesNYV/Gpe4ZwCfdgiSo4zsk14LQU48YtcS67inPIRgDdnsZFxafpfP7k4VX42Wmp
 k1NFfK1T3Nblr/xxAAiOPJouQsXWCaIi33jJPdFETHRB3n6elTJujufZEzxwCr6KasE8Nm3fPtq
 /MNn1P3gmZIdfkazUhgIpZIfb8ZTEFQg0sl8pqvAKml8/ViZ8kQfxFI8znVeiqR+W7NNS2aReDE
 ZkUCeuyH8pmm7zEXbOzhDaCZuiDizF2N8pcyEhgL2clYRk2FtOKXj6nAO/bbGiZdAflD+4jENVB
 504/JNpZFJudybsqPz2w1kM/5LDD6Q+XLsxQ3kSeX+A29JRdtyv8y8yXgECScXF0fkASmaTJCVR
 aWOgDQGOjhSGAdDzAPXUNBFPSDOMn1S+uqoEyhl/6dubT5kGJ+7pX8UejAKvfqSu8ALsxkETLre
 +xqJWXOrZfC1tbZPG9WFV/UpP6D2sihSS7IPOp2vyfE5S798+HkB7gzx65MHJMw2AlE52Eqi7sV
 urPcS/YCYaLhlfg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a new delegated_inode parameter to vfs_mkdir. Most callers will set
that to NULL, but do_mkdirat can use that to wait for the delegation
break to complete and then retry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/cachefiles/namei.c    |  2 +-
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 17 +++++++++++++----
 fs/nfsd/nfs4recover.c    |  2 +-
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  2 +-
 include/linux/fs.h       |  2 +-
 10 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..8d1dbcad69f7 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -166,7 +166,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
+	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode, NULL);
 	if (!err)
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7ade836beb58..4e3e31320275 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
-			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5ed1e4cf6c0b..d26b4484fa60 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -513,7 +513,7 @@ static int ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	if (!rc)
 		rc = vfs_mkdir(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode);
+			       lower_dentry, mode, NULL);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
diff --git a/fs/init.c b/fs/init.c
index e9387b6c4f30..325c9e4d9b20 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -232,7 +232,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
 		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+				  dentry, mode, NULL);
 	done_path_create(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 56d3ebed7bac..6a22517f9938 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4103,7 +4103,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+	      struct dentry *dentry, umode_t mode, struct inode **delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4123,6 +4123,10 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
@@ -4136,6 +4140,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct inode *delegated_inode = NULL;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4145,11 +4150,15 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
-	if (!error) {
+	if (!error)
 		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
-	}
+				  dentry, mode, &delegated_inode);
 	done_path_create(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2c060e0b1604..5bfced783a70 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -234,7 +234,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU, NULL);
 out_put:
 	dput(dentry);
 out_unlock:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6a4c506038e0..e42e58825590 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1496,7 +1496,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
+		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NULL);
 		if (!host_err && unlikely(d_unhashed(dchild))) {
 			struct dentry *d;
 			d = lookup_one_len(dchild->d_name.name,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ee949f3e7c77..baa371947f86 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -242,7 +242,7 @@ static inline int ovl_do_mkdir(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode)
 {
-	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
 }
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c487e834331a..3760e0dda349 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -227,7 +227,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
-	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
+	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode, NULL);
 	if (!err && d_unhashed(dentry)) {
 		struct dentry *d;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfcddafdb3d..18eb7d628290 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1839,7 +1839,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
 int vfs_mkdir(struct mnt_idmap *, struct inode *,
-	      struct dentry *, umode_t);
+	      struct dentry *, umode_t, struct inode **);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,

-- 
2.44.0


