Return-Path: <linux-fsdevel+bounces-67170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF69C36E53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC331A25348
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87C34CFA0;
	Wed,  5 Nov 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz3ZoRpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A234B1AC;
	Wed,  5 Nov 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361692; cv=none; b=Qk7qJghDuFVOTz7fEtI+kv8jx3vZExzOugjm1fAmoB/HUP2X7loxKuEsl6jiTEXq5F7w+FVHWpHT69WOYtLSXweK3KzfdGR4BjuvIFA8AKgyzNf0/hdkgRrR5ska/n6FdBrqr7gPL+Hd+CWsnOn87VZh2Bue+BN275k8DHrPpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361692; c=relaxed/simple;
	bh=J0QOs1yYKO976WkbjbVTMOts98MrgGnpdHVhMu0ydug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3cmZJkx8IE2IjjwHcNfRf6aNMB31qSyL49YzDnIZ39GXNNA5ypJwVVf5msWG0TMZlsWGSFGXqQ8G0gvVsN3FcGK164QP0qxUAarJsxOzpDTHdLLn69Fy8gJ1zoxAtkpdQewMbxVzzFJWmh1QUrDotwg50yyVrROp02IXK9UlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz3ZoRpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A08C4CEF8;
	Wed,  5 Nov 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361690;
	bh=J0QOs1yYKO976WkbjbVTMOts98MrgGnpdHVhMu0ydug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lz3ZoRpZt3rujfl4kXxHqjXMYsZ5b8CpLjSaKKn3jwrhfo6Btx29lGJVPWdGUgTIA
	 hP4zKJikAj9ztTuRFSUARrXg/hRj4R9faRnlC7HcnKR8cqIQ3FnZV3IP3L/8KfJaz+
	 azDNQqBCiNuLtEx86AfdoZsocgdprekIqeGFI4YGoAOl3/BHm6z5CywUCKZO8kpbMA
	 ZrjTLKtpKjvFbvii5iwf1VgD8qAnBVjC32HHZugBIsMpwNxyiZf0ZmhKCWjm6M6jha
	 SR/VkCnKZcvNrSZwpziLNsPJz7J9WOZTRYpJOMsVwZ5fzz6IA4RTwyASYux2mK8Yz0
	 QWZJvx+euDxLQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:58 -0500
Subject: [PATCH v5 12/17] vfs: make vfs_symlink break delegations on parent
 dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-12-7ebc168a88ac@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5708; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=J0QOs1yYKO976WkbjbVTMOts98MrgGnpdHVhMu0ydug=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4Eskg4XkSvabUSBnpqakaub2rvmBNpOYR8iD
 TVcpj0x7rOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBLAAKCRAADmhBGVaC
 Fd1BEAClj5dA2kD7PSJEz+ptBhsPLDqcYFNvAxxcn3VyXJJgQG3/XneRmGDmz2iqLWzIeqcLkgj
 UqSq78IgAI434yjw8J+OYzfibzv0f86F+B/F44J/B/iVwEi+49FD52ZaXy14cguH+bg009sph1b
 VBHccCWud68gZonoAb9OvsNIAuwNfWRUzrHJOROFTLz+7k8crMMjS8iXaw1zMIY9JsKKrppf13G
 /xKv7pvrZgSHLTz7I7SkoDX7TeAR6vxDbN2OaPKUev1iKUdjdFedckVitT/elR4HpscuaWsxT3d
 DNnNc2yg3nSjnPeOLbagKls/zJra3rYxlzIE78lUNnnzJFZxIbwezkwrg5ApDog5Bbq8zbLQS+g
 7Bp+eq7cz7kj0HQGdTabyTl0zBVbwDS/nikYtto6dqXmUkoI63qBDoFbatprgRtiqHk526ZPyb6
 D+Dfe9xMdF9wofGBz6ngTlsaCbK86DkMv1IrnKuxsJ/YyFBuSGy/wPzPFohcvVcIcm0aoLokVSM
 uajA+MUo2oBjd1ivrJMeYDIo9BTa40eoLgZWkj04JppT66wxHagdAvWjNPKAvzZUaBsRTMfuF6/
 VPjhk/MnHwscAoVmi319IluZj3EPAx6uHHlWyxZ3XlDPdKaYU+sRamWdI9jE6CO6VEOH7zjilTU
 bX8MdhQz6lZSLbw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we must break delegations
on the parent on any change to the directory.

Add a delegated_inode parameter to vfs_symlink() and have it break the
delegation. do_symlinkat() can then wait on the delegation break before
proceeding.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/inode.c      |  2 +-
 fs/init.c                |  2 +-
 fs/namei.c               | 16 ++++++++++++++--
 fs/nfsd/vfs.c            |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 include/linux/fs.h       |  2 +-
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 83f06452476dec4025cc8f50e082ae6ccbbc7914..ba15e7359dfa6e150b577205991010873a633511 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -479,7 +479,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	if (rc)
 		goto out_lock;
 	rc = vfs_symlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-			 encoded_symname);
+			 encoded_symname, NULL);
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out_lock;
diff --git a/fs/init.c b/fs/init.c
index 4f02260dd65b0dfcbfbf5812d2ec6a33444a3b1f..e0f5429c0a49d046bd3f231a260954ed0f90ef44 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -209,7 +209,7 @@ int __init init_symlink(const char *oldname, const char *newname)
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				    dentry, oldname);
+				    dentry, oldname, NULL);
 	end_creating_path(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index e9616134390fb7f0d09a759be69bf677f8800bc5..d5ab28947b2b6c6e19c7bb4a9140ccec407dc07c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4845,6 +4845,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * @dir:	inode of the parent directory
  * @dentry:	dentry of the child symlink file
  * @oldname:	name of the file to link to
+ * @delegated_inode: returns victim inode, if the inode is delegated.
  *
  * Create a symlink.
  *
@@ -4855,7 +4856,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, const char *oldname)
+		struct dentry *dentry, const char *oldname,
+		struct delegated_inode *delegated_inode)
 {
 	int error;
 
@@ -4870,6 +4872,10 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4883,6 +4889,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
+	struct delegated_inode delegated_inode = { };
 
 	if (IS_ERR(from)) {
 		error = PTR_ERR(from);
@@ -4897,8 +4904,13 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	error = security_path_symlink(&path, dentry, from->name);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				    dentry, from->name);
+				    dentry, from->name, &delegated_inode);
 	end_creating_path(&path, dentry);
+	if (is_delegated(&delegated_inode)) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6684935007b17ed40723ff0a744045fd187ace5e..28710da4cce7cc7fc1e14d29420239dc357316f6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1742,7 +1742,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
-	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path, NULL);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index afd95721f76ea761cfe7133c3902028550f3e359..5065961bd370628c9afe914ea570d9998a096660 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -267,7 +267,7 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
 				 struct inode *dir, struct dentry *dentry,
 				 const char *oldname)
 {
-	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname);
+	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname, NULL);
 
 	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1a5d86cfafaa97fc89d15cd1a156968b8c3dd377..64323e618724bc20dc101db13035b042f5f88e4d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2118,7 +2118,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 	      umode_t, dev_t, struct delegated_inode *);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-		struct dentry *, const char *);
+		struct dentry *, const char *, struct delegated_inode *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct delegated_inode *);
 int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


