Return-Path: <linux-fsdevel+bounces-64951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41CBF75A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8806C354B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38D34AAE5;
	Tue, 21 Oct 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsZ1uu/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BF3491E5;
	Tue, 21 Oct 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060389; cv=none; b=R9gYw9JqtuxbDaN982ScjE5nbN+51np8IAH0H4Nf7poSX6f0P45tfOPj5RLCH/jQrkp21DcFKoK3pE6ZJAODzt1eqvnG/yVyDC5ic5UQUOJm3B/wCHui5sfGReeMQZDzsYNqMXKJEYBze5HbwexE+6ngwdUhYat+rWXnEOLI0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060389; c=relaxed/simple;
	bh=4NHBIizTYeZIawZLQlZrsTm704FnFAPo2u/kNDBqYtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxO3TMRtR92hHl4MxgOXz4bFgM6kniaLkovAyzLYCksj4nSq2Z9Mpzq8FuTiPYmbtMMa5OE4pWcCAdTWDP4SifGLuOA1GFAo71VCDsZK+JkoWdtq9zL0SVgI+n8BfCEK0QBtKNRdPR18O4I/leOtPHUgK1QIjY/BvjZ8rHCGIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsZ1uu/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43498C4CEF5;
	Tue, 21 Oct 2025 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060389;
	bh=4NHBIizTYeZIawZLQlZrsTm704FnFAPo2u/kNDBqYtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JsZ1uu/6iDsPS/DmXUjyUGg2YYgq5qxauC3Ts9u79K0l4C8ltgN1l/LM6obvIO/tV
	 udv22GlqOi1K8AoEfmnajjspWq9pAOeTFmfsrtZv795stqKTR9w7F++c2Iw8CFrZ8r
	 NGGwLhMajg9G+RSEhBe9DKJ3RjhKOR/aLGJRp8nPUDAfLyRp651DJelWrNGRMVqIfm
	 /xig5MxGOb/nruqB54sASRJHHIVu+jULlYiMXEuyeIONZJRB0UEXMzC/2LDn8nXyeX
	 rP8QQeq4gemZpdsCU0B5MABm3+j4XBEWTYdiIs7YU9r5yJ++JLHhMVQHjajlF53B+O
	 6ceFi0oavh9yA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:43 -0400
Subject: [PATCH v3 08/13] vfs: make vfs_symlink break delegations on parent
 dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-8-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5569; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4NHBIizTYeZIawZLQlZrsTm704FnFAPo2u/kNDBqYtI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YFD8gEDdr0xMfhoaOoe6SQiM0eniYWOPjfN
 pC9nHhDYvqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBQAKCRAADmhBGVaC
 Fcm8EACjz3JjPoT5lOHPzhA+bnygMRpD3fh2wF6i4T7uTwVb1KWz7khVxZW4X+3lBVsXIwrv6cV
 b5di8H68GW8ufvJjQu5e1BahopVR/q22LX3GVNdjJeA/332gYvaWdtn36Mg7mtdd2Rxcs7N2OmH
 sDLWluOF7uWtpP53Af4wrWenU3Njp8vJ20Lhpk2TNl3QeeUqXBoKvcUoiQufOIFuKHG0gdZmSN1
 697YbE+Q6LY9jqtjnLAZHiLhfZTSqJkVGQm+ro2s5bqdXJhPCz5Xm0zI6l3dsNWbdRtWIfLNZEN
 eY4E/0POfBuxzRtyKLE/WqW9tiUE55qe3ITvWlf4iJLu2zJQ5TwMaqgiis1YRdH8cH0JQQ/T4ZW
 mqJ5A/ePa6OWX7KKRKk43EtiqJlkcrahbk4eaLIG/JrpGCYoTN2388MCVKhiJ2OjdFnVaJAeSp2
 auaSnr2+beSbO/rYQuoYQk8dWhVk3qQ+BTaIuFRlh/hShnvvo2qpU/c3t8P0vULrF8FpZUgTzGN
 YRVc5RBXBuQ3KJA33a7zQBFnaJvBVEuHp/gQqFiZClZR1flUKxYIwO2VGE0DPp6Ky0VMPW3Kd0i
 2hkkhyDD6PE/VAI0570PiCVe3t1zX6/4QH8TRAxlg3zqaYr6Ei2zQ0Cs6MIv3kkt1mcmia53+OB
 QPtr7Tm+T4yIP4Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we must break delegations
on the parent on any change to the directory.

Add a delegated_inode parameter to vfs_symlink() and have it break the
delegation. do_symlinkat() can then wait on the delegation break before
proceeding.

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
index 639ae42bcd56890d04592f7269e4ffc099b44f09..d430ec5a63094ea4cd42828e7d44f0f8d918fcec 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -480,7 +480,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
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
index 7e400cbdbc6af1c72eb684f051d0571e944a27d7..71af256cdd941e200389570538f64a3f795e6c83 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4851,6 +4851,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * @dir:	inode of the parent directory
  * @dentry:	dentry of the child symlink file
  * @oldname:	name of the file to link to
+ * @delegated_inode: returns victim inode, if the inode is delegated.
  *
  * Create a symlink.
  *
@@ -4861,7 +4862,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, const char *oldname)
+		struct dentry *dentry, const char *oldname,
+		struct inode **delegated_inode)
 {
 	int error;
 
@@ -4876,6 +4878,10 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
@@ -4889,6 +4895,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	if (IS_ERR(from)) {
 		error = PTR_ERR(from);
@@ -4903,8 +4910,13 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	error = security_path_symlink(&path, dentry, from->name);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
-				    dentry, from->name);
+				    dentry, from->name, &delegated_inode);
 	end_creating_path(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 44debf3d0be450ddc245e2fa4f57fe076e1454a2..386f454badce7ed448399ef93e9c8edafbcc4d79 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1829,7 +1829,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
-	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path, NULL);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87b82dada7ec1b8429299c68078cda24176c5607..94bb4540f7ae2e0571b3b88393c180bd73c3c09c 100644
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
index a1e1afe39e01a46bf0a81e241b92690947402851..d8c7245da3bf3200b435c7ea6cafcf7903ebf293 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2117,7 +2117,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 	      umode_t, dev_t, struct inode **);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-		struct dentry *, const char *);
+		struct dentry *, const char *, struct inode **);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct inode **);
 int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.0


