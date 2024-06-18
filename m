Return-Path: <linux-fsdevel+bounces-21880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9BA90CFD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338191F23E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCB16130D;
	Tue, 18 Jun 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCINMHNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83C1607AA;
	Tue, 18 Jun 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715106; cv=none; b=iayphM23ownXoWg8GFL5YPCoDayVY3kbnIgDJoRLL77YC3b9eBBDsYGgJr/a3AwNh8/eM4XapVGXg9NbRgZ0b1yJxobZ9nfsjdhh64rT8BTxBXq34d2qP4crj6oSO0FAkR7TWCHq5wFyCui+XXAKhqdAC6V6pcBpdYUZkkCbseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715106; c=relaxed/simple;
	bh=7YnUQ2DjEMFCZ2k8/7KCm+FQiNnV8SiceSkAN5LySik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm3aWaHaKeAYKDJFcyanrmp+Nbhm5XpSlRlZQP0EuGIK8S3vZmPAlCQNbMwFR8uzSIjiUdO2i0m7CkwJxqWX6ICQS2EcCmrUnX+HrnKJe9Uhl5h9sMHQftIimsx7ejttDpWQWutZ9slqIYoTBhLOxC4A3pE+WW46eChaNjTXQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCINMHNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740C2C3277B;
	Tue, 18 Jun 2024 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715105;
	bh=7YnUQ2DjEMFCZ2k8/7KCm+FQiNnV8SiceSkAN5LySik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wCINMHNtWnUNVnGd9ryiHq++kfQtTprPRRTUClM+US+JQ56vDUZDrg5kL4APMf6mB
	 vCo7ycnH7V9tsnOZTaaeAAgRc1mXj9jtcVkJEBmYn6/owPotpns5evbOTabY4+h0b8
	 JEsfW1SeCctSvIJRjW/oxUtd8MSKIl5EOJKYUOmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 196/770] namei: introduce struct renamedata
Date: Tue, 18 Jun 2024 14:30:49 +0200
Message-ID: <20240618123414.841510410@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian.brauner@ubuntu.com>

[ Upstream commit 9fe61450972d3900bffb1dc26a17ebb9cdd92db2 ]

In order to handle idmapped mounts we will extend the vfs rename helper
to take two new arguments in follow up patches. Since this operations
already takes a bunch of arguments add a simple struct renamedata and
make the current helper use it before we extend it.

Link: https://lore.kernel.org/r/20210121131959.646623-14-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
[ cel: backported to 5.10.y, prior to idmapped mounts ]
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/namei.c    |  9 +++++++--
 fs/ecryptfs/inode.c      | 10 +++++++---
 fs/namei.c               | 21 +++++++++++++++------
 fs/nfsd/vfs.c            |  8 +++++++-
 fs/overlayfs/overlayfs.h |  9 ++++++++-
 include/linux/fs.h       | 12 +++++++++++-
 6 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ecc8ecbbfa5ac..7b987de0babe8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -412,9 +412,14 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 	if (ret < 0) {
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
+		struct renamedata rd = {
+			.old_dir	= d_inode(dir),
+			.old_dentry	= rep,
+			.new_dir	= d_inode(cache->graveyard),
+			.new_dentry	= grave,
+		};
 		trace_cachefiles_rename(object, rep, grave, why);
-		ret = vfs_rename(d_inode(dir), rep,
-				 d_inode(cache->graveyard), grave, NULL, 0);
+		ret = vfs_rename(&rd);
 		if (ret != 0 && ret != -ENOMEM)
 			cachefiles_io_error(cache,
 					    "Rename failed with error %d", ret);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c867a0d62f360..1dbe0c3ff38ea 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -598,6 +598,7 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct dentry *lower_new_dir_dentry;
 	struct dentry *trap;
 	struct inode *target_inode;
+	struct renamedata rd = {};
 
 	if (flags)
 		return -EINVAL;
@@ -627,9 +628,12 @@ ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		rc = -ENOTEMPTY;
 		goto out_lock;
 	}
-	rc = vfs_rename(d_inode(lower_old_dir_dentry), lower_old_dentry,
-			d_inode(lower_new_dir_dentry), lower_new_dentry,
-			NULL, 0);
+
+	rd.old_dir	= d_inode(lower_old_dir_dentry);
+	rd.old_dentry	= lower_old_dentry;
+	rd.new_dir	= d_inode(lower_new_dir_dentry);
+	rd.new_dentry	= lower_new_dentry;
+	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
 	if (target_inode)
diff --git a/fs/namei.c b/fs/namei.c
index cb37d7c477e0b..72521a614514b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4277,11 +4277,14 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   ->i_mutex on parents, which works but leads to some truly excessive
  *	   locking].
  */
-int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry,
-	       struct inode **delegated_inode, unsigned int flags)
+int vfs_rename(struct renamedata *rd)
 {
 	int error;
+	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
+	struct dentry *old_dentry = rd->old_dentry;
+	struct dentry *new_dentry = rd->new_dentry;
+	struct inode **delegated_inode = rd->delegated_inode;
+	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
@@ -4429,6 +4432,7 @@ EXPORT_SYMBOL(vfs_rename);
 int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		 struct filename *to, unsigned int flags)
 {
+	struct renamedata rd;
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
 	struct path old_path, new_path;
@@ -4532,9 +4536,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 				     &new_path, new_dentry, flags);
 	if (error)
 		goto exit5;
-	error = vfs_rename(old_path.dentry->d_inode, old_dentry,
-			   new_path.dentry->d_inode, new_dentry,
-			   &delegated_inode, flags);
+
+	rd.old_dir	   = old_path.dentry->d_inode;
+	rd.old_dentry	   = old_dentry;
+	rd.new_dir	   = new_path.dentry->d_inode;
+	rd.new_dentry	   = new_dentry;
+	rd.delegated_inode = &delegated_inode;
+	rd.flags	   = flags;
+	error = vfs_rename(&rd);
 exit5:
 	dput(new_dentry);
 exit4:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3e30788e0046b..d12c3e71ca10e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1812,7 +1812,13 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		close_cached = true;
 		goto out_dput_old;
 	} else {
-		host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
+		struct renamedata rd = {
+			.old_dir	= fdir,
+			.old_dentry	= odentry,
+			.new_dir	= tdir,
+			.new_dentry	= ndentry,
+		};
+		host_err = vfs_rename(&rd);
 		if (!host_err) {
 			host_err = commit_metadata(tfhp);
 			if (!host_err)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 26f91868fbdaf..87b7a4a74f4ed 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -212,9 +212,16 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 				unsigned int flags)
 {
 	int err;
+	struct renamedata rd = {
+		.old_dir 	= olddir,
+		.old_dentry 	= olddentry,
+		.new_dir 	= newdir,
+		.new_dentry 	= newdentry,
+		.flags 		= flags,
+	};
 
 	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
-	err = vfs_rename(olddir, olddentry, newdir, newdentry, NULL, flags);
+	err = vfs_rename(&rd);
 	if (err) {
 		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
 			 olddentry, newdentry, err);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0974e8160f50c..cc3b6ddf58223 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1780,7 +1780,17 @@ extern int vfs_symlink(struct inode *, struct dentry *, const char *);
 extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct inode **);
 extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
-extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct inode **, unsigned int);
+
+struct renamedata {
+	struct inode *old_dir;
+	struct dentry *old_dentry;
+	struct inode *new_dir;
+	struct dentry *new_dentry;
+	struct inode **delegated_inode;
+	unsigned int flags;
+} __randomize_layout;
+
+int vfs_rename(struct renamedata *);
 
 static inline int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-- 
2.43.0




