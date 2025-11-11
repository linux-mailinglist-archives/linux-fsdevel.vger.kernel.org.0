Return-Path: <linux-fsdevel+bounces-67947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C6C4E6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786DE4E7E21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6033659E8;
	Tue, 11 Nov 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxpQbyBn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED3364EBC;
	Tue, 11 Nov 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870418; cv=none; b=AJAGTz1xnHduls4Y3++Ia9AxJyzaX3aMeJ0AF1gNh0d/KVPci+ueHtzKbPnDFstbp8NLcO+noCVDv1Azrvm+/dK+ULNYDlk5erWEnP5Fnjt9R3OxJ9GqSA858STDYs2i4tMkwnhLYpV06u2kwvKhfZaUtnYncFuNuS53tKl/1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870418; c=relaxed/simple;
	bh=lN/bhsS6C0iz3//+qsII4EritkMB9eULzkMq+tuTUUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bV1WHZTTTG9dwZeuowz7XRsCyYDGYBJQW1kxVMcdLDSMIYtVBx2/J2Klr/68JJU3MWe7xAXDi20Wx5ibO0xfl765RM8GBisI7Yk9WRXl1mmkVTDEwQF9v/1NKpX9UC6khJapqAFMSs3/wYQE0pZ0sdQdB2qAMnEQdwcDG3J3wRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxpQbyBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0078C2BC86;
	Tue, 11 Nov 2025 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870418;
	bh=lN/bhsS6C0iz3//+qsII4EritkMB9eULzkMq+tuTUUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bxpQbyBnEDn4k2874wXDcs6fPo20+05L8C8tc4UkWZ+n61WuGEqY/QdQOqaP+uxZD
	 p8MOsh4qzPx6KtoCfxJ9c2PmdL1+9nHeYWyh39lZ/JF9x7+v5ZPnFPu7gorPJGtZv3
	 X8cI+aurUhJnPCoD+4HTTKkmG5140yC2rmJcjFc25w/pXQAeCT4+NShXB/3nScMy3h
	 W0XPXF84m5+HOARD0HZ9zMeg7GWK2fifdvLN84slz9fVWnMjs68HWqDoPZebuwXEVu
	 b4ijoQWNPNeNugffPU3JvDoc7ArLg6O5YUycOL70rTqUJNtmgNPyoIXaij8DyHlJka
	 /RiGPSMNVhZyQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:51 -0500
Subject: [PATCH v6 10/17] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-10-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7095; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lN/bhsS6C0iz3//+qsII4EritkMB9eULzkMq+tuTUUM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RoDY3I/ZordAIE3HZI2IoRn2BQcUK7gh082
 A6xqK+nn3eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEaAAKCRAADmhBGVaC
 FWWhEACfQTAsSvIZiFlM/og07msAYn4Zs0NFwDE2wjAEm21Se4GIhV6xFwICLJL0OaVUpEmCdcC
 MDxcvsPS2Gd6fTbY0E9iM/ex9R/0CBYTwc0aVFKLOlMXPbvo7kKfhF6/1wPUOeBdPjtZSISzxk2
 rlyBvv1PG7RSTinK1wd0PePzJAdudVXHwk7rtkjuFIn3V6dHvoWZbS/G0qZBcNl0lEzz1Mhaja5
 Usy1UVQ7T5gJmp4FvJXQ74nqPSoDEeasr+p5k7qpRU0J/KR71/DbO6UZO0fcCoBTV0DNDDdMzX3
 xvvntFoxygTuazM/tFnMBLpgCvkK62o0SnSs2ReJbp0/Rt7MVsysbLQM4HWCpLmEdX83Ikbh5W0
 DkmuTAdkWzsN1oQ7p4gwCNJYaabfctPyAbk7EbPAbkn5Q9loTZUMpqTmBQTK2cqenZnzdsVI+zo
 YdgeUPR6mYAGYV1d02dEAUJo+dQCu0IFn8MF5qnBiYCu9qlDWwg5OEDGxL5hbwJ/9JlV384zVkg
 cvYIbcXG2m8MpbqLrz07cgddIhWx5qQQYOCRyjzaRGEjnV9O8bw3X3TYvfDXklsftRyz8qNiObm
 9e1lS4s/z/nBB9hdWLOm4VT+FAuw2K9G9QSCy4qNzYBmxSXbfHSrv0BBNFD3QBxMy/UhEimQlhh
 QY32I8+Q8J5Z6iQ==
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
 fs/namei.c               | 15 +++++++++++++--
 fs/nfsd/nfs3proc.c       |  2 +-
 fs/nfsd/vfs.c            |  2 +-
 fs/open.c                |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/smb/server/vfs.c      |  2 +-
 include/linux/fs.h       |  3 ++-
 8 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d109e3763a88150bfe64cd2d5564dc9802ef3386..3341f00dd08753c8feab184dd82b8bfa63d3724a 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -188,7 +188,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 
 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode);
+		rc = vfs_create(&nop_mnt_idmap, lower_dentry, mode, NULL);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
diff --git a/fs/namei.c b/fs/namei.c
index 9586c6aba6eae05a9fc3c103b8501d98767bef53..b20f053374a578d36fb764e0df80fb7db9230dbe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3463,6 +3463,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * @idmap:	idmap of the mount the inode was found from
  * @dentry:	dentry of the child file
  * @mode:	mode of the child file
+ * @di:		returns parent inode, if the inode is delegated.
  *
  * Create a new file.
  *
@@ -3472,7 +3473,8 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  */
-int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode)
+int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
+	       struct delegated_inode *di)
 {
 	struct inode *dir = d_inode(dentry->d_parent);
 	int error;
@@ -3486,6 +3488,9 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode)
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, di);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, true);
@@ -4358,6 +4363,7 @@ static int may_mknod(umode_t mode)
 static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		unsigned int dev)
 {
+	struct delegated_inode di = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dentry;
 	struct path path;
@@ -4381,7 +4387,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	idmap = mnt_idmap(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(idmap, dentry, mode);
+			error = vfs_create(idmap, dentry, mode, &di);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
@@ -4396,6 +4402,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	end_creating_path(&path, dentry);
+	if (is_delegated(&di)) {
+		error = break_deleg_wait(&di);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 30ea7ffa2affdb9a959b0fd15a630de056d6dc3c..2cb972b5ed994d69995146aeeac8651c1c04fa46 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -344,7 +344,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	host_err = vfs_create(&nop_mnt_idmap, child, iap->ia_mode);
+	host_err = vfs_create(&nop_mnt_idmap, child, iap->ia_mode, NULL);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 464fd54675f3b16fce9ae5f05ad22e0e6b363eb3..de5f46f8c6d3ab24fabddeed9bd59adbe7a486df 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1552,7 +1552,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(&nop_mnt_idmap, dchild, iap->ia_mode);
+		host_err = vfs_create(&nop_mnt_idmap, dchild, iap->ia_mode, NULL);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
diff --git a/fs/open.c b/fs/open.c
index e440f58e3ce81e137aabdf00510d839342a19219..92cf2e11781b0efd16fe0b751286ce943ea6b4e2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1171,7 +1171,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 	if (IS_ERR(f))
 		return f;
 
-	error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode);
+	error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 	if (!error)
 		error = vfs_open(path, f);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 2bdc434941ebc70f6d4f57cca4f68125112a7bc4..e30441cc9c63ff8b6c055db80be7974501d0023b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -235,7 +235,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dentry, mode);
+	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dentry, mode, NULL);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 83ece2de4b23bf9209137e7ca414a72439b5cc2e..3747851b61c8bad4c00e49866c380c32e9f53a4b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -188,7 +188,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	}
 
 	mode |= S_IFREG;
-	err = vfs_create(mnt_idmap(path.mnt), dentry, mode);
+	err = vfs_create(mnt_idmap(path.mnt), dentry, mode, NULL);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
 					d_inode(dentry));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21876ef1fec90181b9878372c7c7e710773aae9f..83b05aec4e10c846d3168018fb62284e45ceb1a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2111,7 +2111,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 /*
  * VFS helper functions..
  */
-int vfs_create(struct mnt_idmap *, struct dentry *, umode_t);
+int vfs_create(struct mnt_idmap *, struct dentry *, umode_t,
+	       struct delegated_inode *);
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


