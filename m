Return-Path: <linux-fsdevel+bounces-66392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18123C1DC39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE13A7091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5E3254AE;
	Wed, 29 Oct 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FaWoikhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpZofkcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4221D59C;
	Wed, 29 Oct 2025 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781560; cv=none; b=uhSzwQZql6FxI4xkRrvp2kKhuwTXVS5gv0ZClvWB8QNkzM8sFkBxXaouewqQqiDUb85T7/xzkOq6N4TftT90q8/ibZNpAu+fr+CJAJrO6GvdxRfOUoAV4P0SVtluYNPwiYzXrGjqxbiNpq+xaSNJwC43xKT5CT7hIiPm2DHcfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781560; c=relaxed/simple;
	bh=CcSxkv5Wabb/t/SJb9cSzphZ+/8fyxP3PEyZA8ZNGi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk7BDHCEcCyOChBU7LJSWW344NOGHi0XPdnU59nIBDEG8PhsabSF2BQ1/KyQQdRAtvWCLGMjDnKVowFEN+vLS6sLA319TFtwTYwwhEVsOh9U/yQHT7PZux31LTbqyDDdWOEDKdg/kyVyzymGrnf0qVejiUcjywB2RMlwIYMKqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FaWoikhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpZofkcA; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id BC387130034B;
	Wed, 29 Oct 2025 19:45:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 29 Oct 2025 19:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781556;
	 x=1761788756; bh=mS5MDFtnP9koFyLzAwT9DUAKQGwdQj9NRes8BP2Tz7o=; b=
	FaWoikhUlLRM2OGVNvEMgtrAvMspXk1z/6hx+98y+ZJzlMMamPF5b9SehU7eOGxy
	NA6crjghzhhJU6al1b6nB08OZyuenflfSmpBzsCM7LIWAv1wBHFxw3ofbutfxNCV
	IlKnF8exn5ZzBXQ6z/wZAjPQ/XGN5+hv4phTjxV2YKrHRUXOsJkNugqv16NUuvUR
	yV83dC9o9buabNFhOQEG/ybgaY17CylxChWS4lW7fcwXqHHZhJhpOjDmokMrQxhn
	N3H8lgWJ8RdxmAxvh+2T8JZZRaVJD1vN40r/Gxewy/0nbfsKQTg3D6Huff0l+zeb
	Nrnmkz4ua5XSLJmoViIGpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781556; x=1761788756; bh=m
	S5MDFtnP9koFyLzAwT9DUAKQGwdQj9NRes8BP2Tz7o=; b=YpZofkcAsdaif2bfE
	StEAz5pxUap41BvN4As4/DZTEQgJfWG6pNPgthtb9R7VrJ97hRg23rMjfVEhYLfn
	Ae8XlLNztQ4G7iPQDzvMiweGHh5bSeL1Lr3BOekDmF7+ueTNbK9mW5f1AL7o6a4d
	P3iTQBe8Q0tormTTDwfyOHSMXTUvEsFPwbtK2U/zWuRH8Pg1m/NjjdJce/9zm6hI
	Gg9hkN49S2RXvGhjP3yRr8rF6TB0HXx3zwkX5aJy+zsZzLXBpG9tXZ43EEaEC+IF
	FwpIqa3J+5eZGzZW8G8C79SWQcLMhFKxO9Yi1CTpoeJhkIyzjsRjRH09nKBEOJgZ
	Jz6yg==
X-ME-Sender: <xms:M6cCaeAal03b5dOA5LouiVcIY8skm75-dTttRLI7fENjSgThW_4NIg>
    <xme:M6cCabYTh8Cee1Qmp8-BgnQdZB9ggknca55GtfP8t7dvLct2AsL-X13IgEt1ke52o
    ZCJkzOLhKuJF49LB805-6ilckKKyD2tIiF0A-y-m05zOJPy>
X-ME-Received: <xmr:M6cCaSaIdDaaRDbhnJSMMs5WBXvasgGjCST-gJbynRSk5BZTMuBdl2azY6Wc6EpXsHCFLl8tjsrKfgtrCTIx5vmPbOd5bfegbTAf4cCD1sDn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:M6cCaenxtIqyHe7MpQN7Ve8hODapyAZnjdBKu7WMQ0rHJLl-J8sEaQ>
    <xmx:M6cCaROJG06YuJng-kbj_-P9-rWGbU7rfi9W7OUsUVaQKTcTLw5Mtg>
    <xmx:M6cCaaZxzOVzT4GjR5mDQQj6ox0MJlgk7FIWnzEDySwhccZzpYXKZg>
    <xmx:M6cCaZG-Xg2GcepdgJQgyDU4pdQedkaGEkr1IBulcOKanapVTrovWw>
    <xmx:NKcCaeqERhqFXTmy5BvllqdEz_mSwoi3rYHy535hhn_aVqr3ymogg_RK>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:45:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()
Date: Thu, 30 Oct 2025 10:31:06 +1100
Message-ID: <20251029234353.1321957-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
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


