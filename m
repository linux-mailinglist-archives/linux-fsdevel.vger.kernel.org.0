Return-Path: <linux-fsdevel+bounces-39363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E010A1326A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F92D166CE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A142193077;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dZ+xa51p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBE142E77;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=hXQNmen37SWkaECt2oEPAsTFBI5kLW5Qp0J/z6smGWBQUImSGFaAI4GpyH1AfVgfaEy0iT5Mr3pcSuNvkQudFoUgNMh0FkhZeCUhorlTNxSQRrSp3t/Ymbv5vY15TAxP3Fr3xEUu3pzoFlp9Q842ltqupw3e76MGnEHuQiOyjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=0pqd3ZnC5nmSvMGsKhNDRjsnFN8uYOov2iGfFQiLndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iphwAE3ZFoLGtgjZjKmzq9jlCQ9jjZLd0DlPsXLayulDUBZo/szEchRE6QvKWPt7u7EtdWVaZcMsecVpsubbF6jkNJYPlNoHLbl3XXGwQYKuofFsRRXJLzoPq+BCE45jlDVnzJO3EJQA+k6u2R68Q93intlbsqKgPH+fxj1i6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dZ+xa51p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6yQSgsSx/EuQvVjcfKOTYxHSiedk1IAz8gfPawD+vP8=; b=dZ+xa51palQlKdW7TAes/6yE/X
	C0lZaf4VkBOdhjuzzA3OksVZaRuZJ95AXrBw5/uB3WeeKKfu8EzRH4Y/o7UkYg4n/+3k+LuOc5Sui
	PFrNxiDMDejMj/DIXSQ05Zqvk3wGS/ISRJRI6u4XZ7dVAjrmnGZbJrGYW1GZP28CQrxwYx/WxU/21
	OLjDOb1a8/uM9+yCZZhfa+yBVL4OZaVP/dd4vWGKB03LhXVA4cbr45aPPYJ1sWyDbZaGHEtEdOmWH
	UGSh6Dj4xwSlts2srFFLBuYlBWVLiMdb6mBrTcB7izXFg637RxyXiLGCuqHkK4n70Rq3GZYn6FuKe
	TzJWS9kw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILe-000000022Gk-3E8T;
	Thu, 16 Jan 2025 05:23:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 08/20] afs_d_revalidate(): use stable name and parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:05 +0000
Message-ID: <20250116052317.485356-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No need to bother with boilerplate for obtaining the latter and for
the former we really should not count upon ->d_name.name remaining
stable under us.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/dir.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9780013cd83a..c6ee6257d4c6 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -607,19 +607,19 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
  * Do a lookup of a single name in a directory
  * - just returns the FID the dentry name maps to if found
  */
-static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
+static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 			     struct afs_fid *fid, struct key *key,
 			     afs_dataversion_t *_dir_version)
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_lookup_one_cookie cookie = {
 		.ctx.actor = afs_lookup_one_filldir,
-		.name = dentry->d_name,
+		.name = *name,
 		.fid.vid = as->volume->vid
 	};
 	int ret;
 
-	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
+	_enter("{%lu},{%s},", dir->i_ino, name->name);
 
 	/* search the directory */
 	ret = afs_dir_iterate(dir, &cookie.ctx, key, _dir_version);
@@ -1052,21 +1052,12 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 /*
  * Check the validity of a dentry under RCU conditions.
  */
-static int afs_d_revalidate_rcu(struct dentry *dentry)
+static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 {
-	struct afs_vnode *dvnode;
-	struct dentry *parent;
-	struct inode *dir;
 	long dir_version, de_version;
 
 	_enter("%p", dentry);
 
-	/* Check the parent directory is still valid first. */
-	parent = READ_ONCE(dentry->d_parent);
-	dir = d_inode_rcu(parent);
-	if (!dir)
-		return -ECHILD;
-	dvnode = AFS_FS_I(dir);
 	if (test_bit(AFS_VNODE_DELETED, &dvnode->flags))
 		return -ECHILD;
 
@@ -1097,9 +1088,8 @@ static int afs_d_revalidate_rcu(struct dentry *dentry)
 static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 			    struct dentry *dentry, unsigned int flags)
 {
-	struct afs_vnode *vnode, *dir;
+	struct afs_vnode *vnode, *dir = AFS_FS_I(parent_dir);
 	struct afs_fid fid;
-	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
 	afs_dataversion_t dir_version, invalid_before;
@@ -1107,7 +1097,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	int ret;
 
 	if (flags & LOOKUP_RCU)
-		return afs_d_revalidate_rcu(dentry);
+		return afs_d_revalidate_rcu(dir, dentry);
 
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
@@ -1122,14 +1112,9 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (IS_ERR(key))
 		key = NULL;
 
-	/* Hold the parent dentry so we can peer at it */
-	parent = dget_parent(dentry);
-	dir = AFS_FS_I(d_inode(parent));
-
 	/* validate the parent directory */
 	ret = afs_validate(dir, key);
 	if (ret == -ERESTARTSYS) {
-		dput(parent);
 		key_put(key);
 		return ret;
 	}
@@ -1157,7 +1142,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	afs_stat_v(dir, n_reval);
 
 	/* search the directory for this vnode */
-	ret = afs_do_lookup_one(&dir->netfs.inode, dentry, &fid, key, &dir_version);
+	ret = afs_do_lookup_one(&dir->netfs.inode, name, &fid, key, &dir_version);
 	switch (ret) {
 	case 0:
 		/* the filename maps to something */
@@ -1201,22 +1186,19 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 		goto out_valid;
 
 	default:
-		_debug("failed to iterate dir %pd: %d",
-		       parent, ret);
+		_debug("failed to iterate parent %pd2: %d", dentry, ret);
 		goto not_found;
 	}
 
 out_valid:
 	dentry->d_fsdata = (void *)(unsigned long)dir_version;
 out_valid_noupdate:
-	dput(parent);
 	key_put(key);
 	_leave(" = 1 [valid]");
 	return 1;
 
 not_found:
 	_debug("dropping dentry %pd2", dentry);
-	dput(parent);
 	key_put(key);
 
 	_leave(" = 0 [bad]");
-- 
2.39.5


