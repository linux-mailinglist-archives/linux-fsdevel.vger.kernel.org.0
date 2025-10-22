Return-Path: <linux-fsdevel+bounces-65038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F1DBF9FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9EDE35422C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E02D8DDA;
	Wed, 22 Oct 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="scV34xL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pAnyD6+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380162D949C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108462; cv=none; b=cNOHKa0hbSQuOZxjVaoelejTr2e7i6Vd5A/u/0wJidGF6Rzvq3C8sSDgVM1KmuANhfJkmiRe+iXfrs0YaxtntBrl6Z2Xd5asT+20CJj/iOjyFxmOJPJuBjsH48GdlVxsUNj6ClLg1pHt5FqEmqrVJxLzN/dcNCeWzhoKh6ixk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108462; c=relaxed/simple;
	bh=CcSxkv5Wabb/t/SJb9cSzphZ+/8fyxP3PEyZA8ZNGi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFP+Cfzn+S+CYkQDpzS8htKbVNTm9jGDi1ky4CevJdMycgrWZB/MFV/+VPaCfNGlNuYy5zLOjBnWCNqAX97iHCsz949uZS91Fl7VPeq6KeeuVjFEFnmUxKDYDzXOQGMoQ+fup8d440Ul4vyUZGg1KAtQFFRdGXfdY4vgArVCHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=scV34xL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pAnyD6+R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D602EC0102;
	Wed, 22 Oct 2025 00:47:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 22 Oct 2025 00:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108458;
	 x=1761194858; bh=mS5MDFtnP9koFyLzAwT9DUAKQGwdQj9NRes8BP2Tz7o=; b=
	scV34xL1qEeNoz44+vR0LgtQpiJ1onYcUbdCOq89vaZsxmB7ZzAD9ekcF6ZZTbev
	VyEWhTYWEl+1ofxTi/FlNWqiEG34yxRUNcsXuSd5WF0YkRKr9JURhLCYLzYEWWh9
	Djco1zQugVVtb1/EbV/oVT0Er7YMEbiGo/hwnfghEmEed0Hu+sRXAXO4QGPmjg5I
	46m9pqYrEY3hDFKkWtbEHczux0sktfglhPs8yPcFKg11oSNfHQQJaDzHEOISSaSU
	H9h87NVhz1T0rnqo7TaiU5SAn7vgsruKaaecqeAUfv/2vrSI99SvJlYHPjC4Gj82
	lUozp4XtkbyyG/twXpV1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108458; x=1761194858; bh=m
	S5MDFtnP9koFyLzAwT9DUAKQGwdQj9NRes8BP2Tz7o=; b=pAnyD6+RpsoGvFeqM
	TZYzt8FzkXLWgtqR8KheqF1DgiR2RbdoVtkUtUCgECufRdz+8XhcXwiLRnCDKcla
	xBMokDV3aYZ/c+ru8Tt9L1+PI8u5GK8w/9i7cYYnpPqKrKlgrN0HaIg8Xfs19wKv
	2VX4jDIveKkBLh3LnbSNtx+ReFk9Ecf5w7U52oblqQxRtQeSyLezx5plxySpk9Lr
	U2fKBnkNUaAvBLRHQHS4rxQSgOCFoMfJHI/bBbPrHjlykPdTVwfbEmMvLSYnfn4M
	szcYKpGHOoc9adpOkPaHhQczllBwnelDuRXrQc0WHAjiluJkuogv6u3p66NzNhgt
	T9sYw==
X-ME-Sender: <xms:6mH4aCtA6d8VLoznSKFs8HFre1B3waMg35LY40OvnzFd1AeSdVYI5A>
    <xme:6mH4aCYTy-a2kEQagx23rZI5IfR1VgVdmVrP2Hk1a5evxdufUzoefNX8oc3JUmG-m
    jx2wFy9huIpt_upiwFU4HgzKjgR5kefWvXf3QoD9dl9QRkA>
X-ME-Received: <xmr:6mH4aMzBu2CA9Bvti-c74prsChZmdJiry4FH1uPhG5DrK7bakFZkYgacelpN2d4O3xCE5jrvMOYcupuLW1GaqmCp0p68_1hlVQNMOKyJkG7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6mH4aCjQ7G5ViK6j2vjQR6ZO8pY5wWPoSe0Dheo5MQwssaPkgmFRVA>
    <xmx:6mH4aAlt_H2tmgpqNFs0dqIAmGM6EZ21tfWxq2wIX20TPEYxXfYU_w>
    <xmx:6mH4aAjxa0--0QjTq_jO2_aG0ke9VUfU6bSOgIpKzfGJORXzQAThaA>
    <xmx:6mH4aM2klzZKu_S3uPH5KkndoxkUtniddxDFmP8vgTGMbb9NNyQjgw>
    <xmx:6mH4aHmmknPSiXFn8caQpwL0PL1nWOpsrEGCusHfQ3Zrn1mpp-vLSF-_>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()
Date: Wed, 22 Oct 2025 15:41:40 +1100
Message-ID: <20251022044545.893630-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
which do not check permissions.
This patch adds _noperm versions of these functions.

Note that do_mq_open() was only calling mntget() so it could call
path_put() - it didn't really need an extra reference on the mnt.
Now it doesn't call mntget() and uses end_creating() which does
the dput() half of path_put().

Also mq_unlink() previously passed
   d_inode(dentry->d_parent)
as the dir inode to vfs_unlink().  This is after locking
   d_inode(mnt->mnt_root)
These two inodes are the same, but normally calls use the textual
parent.
So I've changes the vfs_unlink() call to be given d_inode(mnt->mnt_root).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

--
changes since v2:
 - dir arg passed to vfs_unlink() in mq_unlink() changed to match
   the dir passed to lookup_noperm()
 - restore assignment to path->mnt even though the mntget() is removed.
---
 fs/fuse/dir.c            | 19 +++++++---------
 fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/orphanage.c | 11 ++++-----
 include/linux/namei.h    |  2 ++
 ipc/mqueue.c             | 32 ++++++++++-----------------
 5 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a1..40ca94922349 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1397,27 +1397,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	if (!parent)
 		return -ENOENT;
 
-	inode_lock_nested(parent, I_MUTEX_PARENT);
 	if (!S_ISDIR(parent->i_mode))
-		goto unlock;
+		goto put_parent;
 
 	err = -ENOENT;
 	dir = d_find_alias(parent);
 	if (!dir)
-		goto unlock;
+		goto put_parent;
 
-	name->hash = full_name_hash(dir, name->name, name->len);
-	entry = d_lookup(dir, name);
+	entry = start_removing_noperm(dir, name);
 	dput(dir);
-	if (!entry)
-		goto unlock;
+	if (IS_ERR(entry))
+		goto put_parent;
 
 	fuse_dir_changed(parent);
 	if (!(flags & FUSE_EXPIRE_ONLY))
 		d_invalidate(entry);
 	fuse_invalidate_entry_cache(entry);
 
-	if (child_nodeid != 0 && d_really_is_positive(entry)) {
+	if (child_nodeid != 0) {
 		inode_lock(d_inode(entry));
 		if (get_node_id(d_inode(entry)) != child_nodeid) {
 			err = -ENOENT;
@@ -1445,10 +1443,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	} else {
 		err = 0;
 	}
-	dput(entry);
 
- unlock:
-	inode_unlock(parent);
+	end_removing(entry);
+ put_parent:
 	iput(parent);
 	return err;
 }
diff --git a/fs/namei.c b/fs/namei.c
index ae833dfa277c..696e4b794416 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3275,6 +3275,54 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_noperm - prepare to create a given name without permission checking
+ * @parent: directory in which to prepare to create the name
+ * @name:   the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.
+ *
+ * If the name already exists, a positive dentry is returned.
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating_noperm(struct dentry *parent,
+				     struct qstr *name)
+{
+	int err = lookup_noperm_common(name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, LOOKUP_CREATE);
+}
+EXPORT_SYMBOL(start_creating_noperm);
+
+/**
+ * start_removing_noperm - prepare to remove a given name without permission checking
+ * @parent: directory in which to find the name
+ * @name:   the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_removing() should be called when removal is complete, or aborted.
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing_noperm(struct dentry *parent,
+				     struct qstr *name)
+{
+	int err = lookup_noperm_common(name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, 0);
+}
+EXPORT_SYMBOL(start_removing_noperm);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 9c12cb844231..e732605924a1 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -152,11 +152,10 @@ xrep_orphanage_create(
 	}
 
 	/* Try to find the orphanage directory. */
-	inode_lock_nested(root_inode, I_MUTEX_PARENT);
-	orphanage_dentry = lookup_noperm(&QSTR(ORPHANAGE), root_dentry);
+	orphanage_dentry = start_creating_noperm(root_dentry, &QSTR(ORPHANAGE));
 	if (IS_ERR(orphanage_dentry)) {
 		error = PTR_ERR(orphanage_dentry);
-		goto out_unlock_root;
+		goto out_dput_root;
 	}
 
 	/*
@@ -170,7 +169,7 @@ xrep_orphanage_create(
 					     orphanage_dentry, 0750);
 		error = PTR_ERR(orphanage_dentry);
 		if (IS_ERR(orphanage_dentry))
-			goto out_unlock_root;
+			goto out_dput_orphanage;
 	}
 
 	/* Not a directory? Bail out. */
@@ -200,9 +199,7 @@ xrep_orphanage_create(
 	sc->orphanage_ilock_flags = 0;
 
 out_dput_orphanage:
-	dput(orphanage_dentry);
-out_unlock_root:
-	inode_unlock(VFS_I(sc->mp->m_rootip));
+	end_creating(orphanage_dentry, root_dentry);
 out_dput_root:
 	dput(root_dentry);
 out:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9ee76e88f3dd..688e157d6afc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -92,6 +92,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
 
 /**
  * end_creating - finish action started with start_creating
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..6d7610310003 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -913,13 +913,12 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		goto out_putname;
 
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
-	inode_lock(d_inode(root));
-	path.dentry = lookup_noperm(&QSTR(name->name), root);
+	path.dentry = start_creating_noperm(root, &QSTR(name->name));
 	if (IS_ERR(path.dentry)) {
 		error = PTR_ERR(path.dentry);
 		goto out_putfd;
 	}
-	path.mnt = mntget(mnt);
+	path.mnt = mnt;
 	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
 	if (!error) {
 		struct file *file = dentry_open(&path, oflag, current_cred());
@@ -928,13 +927,12 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		else
 			error = PTR_ERR(file);
 	}
-	path_put(&path);
 out_putfd:
 	if (error) {
 		put_unused_fd(fd);
 		fd = error;
 	}
-	inode_unlock(d_inode(root));
+	end_creating(path.dentry, root);
 	if (!ro)
 		mnt_drop_write(mnt);
 out_putname:
@@ -957,7 +955,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	int err;
 	struct filename *name;
 	struct dentry *dentry;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
 	struct vfsmount *mnt = ipc_ns->mq_mnt;
 
@@ -969,26 +967,20 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	err = mnt_want_write(mnt);
 	if (err)
 		goto out_name;
-	inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
-	dentry = lookup_noperm(&QSTR(name->name), mnt->mnt_root);
+	dentry = start_removing_noperm(mnt->mnt_root, &QSTR(name->name));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
-		goto out_unlock;
+		goto out_drop_write;
 	}
 
 	inode = d_inode(dentry);
-	if (!inode) {
-		err = -ENOENT;
-	} else {
-		ihold(inode);
-		err = vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
-				 dentry, NULL);
-	}
-	dput(dentry);
-
-out_unlock:
-	inode_unlock(d_inode(mnt->mnt_root));
+	ihold(inode);
+	err = vfs_unlink(&nop_mnt_idmap, d_inode(mnt->mnt_root),
+			 dentry, NULL);
+	end_removing(dentry);
 	iput(inode);
+
+out_drop_write:
 	mnt_drop_write(mnt);
 out_name:
 	putname(name);
-- 
2.50.0.107.gf914562f5916.dirty


