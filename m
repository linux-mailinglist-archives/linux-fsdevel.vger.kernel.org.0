Return-Path: <linux-fsdevel+bounces-67243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD61C388F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEDD1A24427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447B1FA859;
	Thu,  6 Nov 2025 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GU5Jw/b9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/bw3jKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647C1E1DFC;
	Thu,  6 Nov 2025 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390521; cv=none; b=jfO+yuvm8Lj9DBcRTTqlXy+mDqE4QFsKRuLloBerggpag7wzBJysU0xA+IIOU5gy811ALO0aDY2s1RLdvpNMgzr1QhlYKtHMop5pD/F0ET4rmts5bR8XKYbTL5Or7xelnHHmKcRhSqliclxYKMFubMW1Wg/IYpmxcCsR4UL3RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390521; c=relaxed/simple;
	bh=R8bHaHyEJ594zGFKE/fad7JGvr03zpWNes7mrF7tbOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O71kQQ7WgACwOAWg6jMhK7QvJB3kuaiWtO6k7n4C5vmexdnAhM5DwSPvQr8o3L6kM+EkmF0QWCtv/syeUqvKZ7NhctahNWQS1R7I27xcZB9IiPqBvfyrSrDwbc2mLKgiRLhlyYZFSVczSxB0aiFBL8vGpcyTGBPxRdYlHmJQelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GU5Jw/b9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/bw3jKF; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C987D1300618;
	Wed,  5 Nov 2025 19:55:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 19:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390517;
	 x=1762397717; bh=PJzgcrxhiIBIelv8Z38ByCDof4FfjJXhCw99Sa9A6Ac=; b=
	GU5Jw/b9rZy6URDk55s+fBj4Sz8G9mnhiFhFd4Q9WcdaqdatI/nsDgdZGc+fCIXN
	SfRFZNpRNbh0H4qVMjMOwEkKU7ZWwRVmCo+cj0JNxQyVFJhGyONxxcuJvRNbk6j4
	X+ytsrhpsx7irNSdAPchdXPN0GKg6VqU9AuT6VJ+eyVD7IBHOmMJMouXDkrpQNR7
	VDsBjYdqo7aSfkztJp5tw23EMWOP9f1PkLqTMmtyJ1WOh76aVoilfMu9udiVX0CW
	i+JL2xBTsCP/p5MbfZSzmGWRRly5gTVjU7okbKAqWN+GsHTYciGmYayUq/RhvqMM
	yr7wMJy5LufFTB6r0f1Lcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390517; x=1762397717; bh=P
	JzgcrxhiIBIelv8Z38ByCDof4FfjJXhCw99Sa9A6Ac=; b=D/bw3jKFt5ulyzu4q
	/oOBxDbm9n6URhx1AuR7zpzAYiY+anKKuBPTRqfc37RpiSc6uj8vWRk5jhoHoPmD
	J0TrYglOg/YooNVNZaeRC87CkS3BPPnhqL0ggekDiJWHlAQoqyMy9jchjyE553qq
	5QDbxUwzUXchq1rh3jrjMo8w47EL/NKPyHC+IjTQnUkiKCHHDg4WCAGM28mZYHiM
	D2k6h5ZodmmK91d4shDq+OzZnoWok4iriGtioRvCJuwEycg18l1HWxlAXAJyCIBO
	qXyw1JBYJRXJXUE2BBblll0pl2PEVbtHMo+tTW2uQZrO6+0684TsagA97zutUq0D
	8eE+g==
X-ME-Sender: <xms:9fELaVBvANWPedycTHh2z4JUjAUxFxGcozVskVkyW-BDpXXwKt8xcQ>
    <xme:9fELaYkT8__Cp7FOiHxo8rYEHzx4uveSjCghVM2sXNUtEU8Og569OZppYtlOXuerB
    _CkgKiVB1NIye-9f5F9poddJGJZrlqA2zMRyL6Ue7yuNWT8PQ>
X-ME-Received: <xmr:9fELadmsfhlQhYA_09bE4nrTtlmBcpONoBPXeFcT4aHu-aPhTNs92mRNwZIXzoJ_vL-SO1bHbmsalWm1wYf8ffZPxUMzI5ywYrpA-i5rXPtW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:9fELadcvdaVCscCZitQyMjbnnmWz7092ILNo4chCLVmhuR47Cm3piw>
    <xmx:9fELabwfpQPp_BKbnK2FNNjyci-aWlFQqfFRN-yVlmMwBXlLoDswiA>
    <xmx:9fELaXt5_oS67qB9C_gWGIN9Kt_rq2NNEdsFm-RvYt3y5qWnIhgRkQ>
    <xmx:9fELaQpQG8WhHq3Y2mo_ZhzBx2aemlr1hwyQoUoqmFyPlwEM92ttNA>
    <xmx:9fELaRg0X_wyC9atGKbtfIwY2-QlZ1zycEIF1rFYFrKOGDB1KuvBQx9A>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:55:07 -0500 (EST)
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
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v5 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()
Date: Thu,  6 Nov 2025 11:50:50 +1100
Message-ID: <20251106005333.956321-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
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
index 316922d5dd13..a0d5b302bcc2 100644
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
index 38dda29552f6..da01b828ede6 100644
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
index 6d1069f93ebf..0441f5921f87 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -93,6 +93,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
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


