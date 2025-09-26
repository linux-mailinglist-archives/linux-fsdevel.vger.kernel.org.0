Return-Path: <linux-fsdevel+bounces-62843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D4BA23F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBC385C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5520459A;
	Fri, 26 Sep 2025 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ec52y2Ow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeeSzBYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714C1FDE19
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855056; cv=none; b=CVwbrQcXnxYxYJYEXW6nJTwZp1smUancOGtSHOgE0xwPj93QWNvF1SmbGK03n86RJSkEJoVETFoRRLoSUDrsBPFpRKtH6t5YNRaY9QFhy7s89rDym8EyB+RMVXnxS86Ggp9dkvKEqgI0FCB6Dp7Q6MoSyUDIzOSc3hCRZcGuE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855056; c=relaxed/simple;
	bh=P3i59QFEhmD0r2+dj2+k6365a2ix7KvJMFpqEXs8SMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVXvFOruNaNqUqJeH+4RzkQTm6SOCGRkDQ82Iu2ztXk9bIzu7+BX64O2BMVzZW4+sDEdjS3lWRBpbQdNTN65DXgR/MYcZL1w+UcSxfLZp6Y4le8MGJmUIQGe/XRShWvGvhKireNUWBeXP+YaZ5pcvMka9Uuvb/v6gWX1+hUDszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ec52y2Ow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeeSzBYd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3304AEC00C3;
	Thu, 25 Sep 2025 22:50:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 25 Sep 2025 22:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855053;
	 x=1758941453; bh=xZuBFk4sAeQ9wzelSd8B3c74TOxRsFmL/KNzmZ6K63Q=; b=
	Ec52y2Owe0fbjGBvSWODHuRl46+cUyNaJce0cEfP+AzhrMuUoBrUQQBFrmzSxSf2
	5gBmTOTprvJ//NwDjc//lhWn8KWKF0ZVcjvV5it8NkkLC2f85b9IqUMaH7k/Z4H5
	LCL2TKWY876otjYftoB20hR1f6bUOKCXVDx/VXNfMfFAJRnqQGwfQDra59cPVWfy
	SogB0W712z3Txt39FcQ9+x5T7gb+qEDFO5difBLYaH7VHaRS7j4cd2LdMMdjnFEh
	i2P4akBraixLNvhQWELDyMzMbhzRfjd9ZGWqu6X/lbD4yXZSmNq4N1mrotQCM8Sq
	b6GFiAMcsffGyQx/KWIe7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855053; x=1758941453; bh=x
	ZuBFk4sAeQ9wzelSd8B3c74TOxRsFmL/KNzmZ6K63Q=; b=FeeSzBYdmJ9zqNkTE
	DI1QSO/nkdU4jng7IEd6qpRpf6Q7lsvkPiOoaLCfnTqhkV7qT3MKhNN37+/Lyqm8
	X2IWuUQV5f4jD/Ze6CDoTnTw/lFqDk/hRDXpmKesc5P1ivnPQP9a4j+HpoqbCwC9
	V4dhGRNdi+tlrTCosCfJJ1MDGl8+CsRRolZWwwDV51YYOZMd2DxahqCOu9fzN5ZO
	PgQd8R+YVkhrTQt9nMcTdUIsyfpZLyBJ66+MZGoiHdjAS1S+aIxi4xnUws4hPDdx
	Gsx2Jt9rB1u6al7KUSkZjLZCzBinfzAGrPNjsu2PsjtiMyjirQccLD7I2pJOxCV0
	KDNIw==
X-ME-Sender: <xms:jP_VaFfvA6h_gWZzIKw9fU-zlpyuDKWiIg4jW9vQoWqbGHtfSHuqZQ>
    <xme:jP_VaOIwGbjCAhN8HVyPpVQrE5mg_4zTCzdo1QW9AWP6dsY2D_gXA4-WTEdyBbdBO
    tPx4H5okDr0Qqq2nzn2i4sCU6HZRCIxyaeabJDdAFjAuZXXMA>
X-ME-Received: <xmr:jP_VaNhSBR8r_C9uGUztcuRdi0Jb1Snugvr53e7YszvEpfiLkuF3gPQosLk_UJrf81EMIUEBUM3B-vHQlWSTq1a0m_5z8g-DhgHdAjVY6Afa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jP_VaERaoKtX8Pe1P86_Yqn5FyhC5PClEoY7Nl25fyemvHW9fdZxiA>
    <xmx:jP_VaPViUz7gPmDU9uThVLg3j_WEvqxseD_PXSjP74dqUfkOEwdOLQ>
    <xmx:jP_VaISu9LIgydnDAD2oFzdTACZcYu9A7nIfBeFCymu2R47LN3ODQQ>
    <xmx:jP_VaJm6XajM75pxVj8kCHfSgb9l7jL7iJ0oKoACocBm0JQzRxM5VQ>
    <xmx:jf_VaEioJemKiVVkITIrlT6zMRdZNKhgqlMl2f9n3AOYsupY7oPqt_aL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] VFS: introduce start_creating_noperm() and start_removing_noperm()
Date: Fri, 26 Sep 2025 12:49:09 +1000
Message-ID: <20250926025015.1747294-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c            | 19 +++++++---------
 fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/orphanage.c | 11 ++++-----
 include/linux/namei.h    |  2 ++
 ipc/mqueue.c             | 31 +++++++++-----------------
 5 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..88bc512639e2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1404,27 +1404,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
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
@@ -1452,10 +1450,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
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
index 0d9e98961758..bd5c45801756 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3296,6 +3296,54 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_noperm - prepare to create a given name without permission checking
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
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
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
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
index 63941fdbc23d..20a88a46fe92 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -92,6 +92,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
 
 /* end_creating - finish action started with start_creating
  * @child - dentry returned by start_creating()
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..060e8e9c4f59 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -913,13 +913,11 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
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
 	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
 	if (!error) {
 		struct file *file = dentry_open(&path, oflag, current_cred());
@@ -928,13 +926,12 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
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
@@ -957,7 +954,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	int err;
 	struct filename *name;
 	struct dentry *dentry;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
 	struct vfsmount *mnt = ipc_ns->mq_mnt;
 
@@ -969,26 +966,20 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
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
+	err = vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
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


