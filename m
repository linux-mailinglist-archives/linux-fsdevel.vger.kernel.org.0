Return-Path: <linux-fsdevel+bounces-57602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A98B23CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68761890A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19062E7BB3;
	Tue, 12 Aug 2025 23:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE52D7381;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042784; cv=none; b=ccwmdm9jKNLcfzDJgZF5lUQv2oJV7v/+eFZ4suQkahlIeH4Nmd+bNH5C7apjo+epOHur+/wLsgQQDM+LqW+Z3R+ZSR2KzMUq7TpPP1sGm1ea+3R9bKWbR/yiMMFXzgqg3qM6Kr3oEL9bwXm2upG3It2MOdpW2nIcXj9jb6IA4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042784; c=relaxed/simple;
	bh=8H0TpV7kB+G3cWPZv8G4Hm2H3l6DX+JGvz2rgwlSirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY9Gmzt0p62BKOQThcSdgUfqy0QdeMsaXZ7xfpTPZOfpMzs7bl23Q6X+Ya+9DpUWnK7WQuWvvzOLd8WOhjUBmc4dnwFmB4DoM634k/hqyGhKFFiq1HjTgtp+v3aJth6BfwZN24rwi8w3d+yiHJt+thIGKg7tMQ9XlRUMcxQ4UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynO-005Y29-KL;
	Tue, 12 Aug 2025 23:52:48 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on hashed dentries.
Date: Tue, 12 Aug 2025 12:25:11 +1000
Message-ID: <20250812235228.3072318-9-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proposed locking changes will require a dentry to remain hashed during
all directory operations which are currently protected by i_rwsem, or
for there to be a controlled transition from one hashed dentry to
another which maintains the lock - which will then be on the dentry.

The current practice of dropping (unhashing) a dentry before calling
d_splice_alias() and d_add() defeats this need.

This patch changes d_splice_alias() and d_add() to accept a hashed
dentry and to only drop it when necessary immediately before an
alternate dentry is hashed.  These functions will, in a subsequent patch,
transfer the dentry locking across so that the name remains locked in
the directory.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst | 4 ++--
 fs/ceph/file.c                    | 2 --
 fs/ceph/inode.c                   | 3 ---
 fs/dcache.c                       | 8 +++++---
 fs/fuse/dir.c                     | 1 -
 fs/hostfs/hostfs_kern.c           | 1 -
 fs/nfs/dir.c                      | 5 +----
 fs/nfs/nfs4proc.c                 | 1 -
 fs/smb/client/dir.c               | 1 -
 9 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..642dd6afb139 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -580,8 +580,8 @@ otherwise noted.
 	dentry before the first mkdir returns.
 
 	If there is any chance this could happen, then the new inode
-	should be d_drop()ed and attached with d_splice_alias().  The
-	returned dentry (if any) should be returned by ->mkdir().
+	should be attached with d_splice_alias().  The returned dentry
+	(if any) should be returned by ->mkdir().
 
 ``rmdir``
 	called by the rmdir(2) system call.  Only required if you want
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c02f100f8552..27eb1ac06177 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -755,8 +755,6 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
-			if (!d_unhashed(dentry))
-				d_drop(dentry);
 			dn = d_splice_alias(inode, dentry);
 			WARN_ON_ONCE(dn && dn != dentry);
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b827..7acd6ac0d50f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1480,9 +1480,6 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 		}
 	}
 
-	/* dn must be unhashed */
-	if (!d_unhashed(dn))
-		d_drop(dn);
 	realdn = d_splice_alias(in, dn);
 	if (IS_ERR(realdn)) {
 		pr_err_client(cl, "error %ld %p inode %p ino %llx.%llx\n",
diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..0db256098adb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2709,7 +2709,11 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		raw_write_seqcount_end(&dentry->d_seq);
 		fsnotify_update_flags(dentry);
 	}
-	__d_rehash(dentry);
+	if (d_unhashed(dentry))
+		__d_rehash(dentry);
+	else if (inode && (dentry->d_flags &
+			   (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
+		this_cpu_dec(nr_dentry_negative);
 	if (dir)
 		end_dir_add(dir, n, d_wait);
 	spin_unlock(&dentry->d_lock);
@@ -2990,8 +2994,6 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
-
 	if (!inode)
 		goto out;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..60e7763da8c8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -834,7 +834,6 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	}
 	kfree(forget);
 
-	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
 		return d;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 01e516175bcd..8e51fc623301 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -700,7 +700,6 @@ static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
 		dentry = ERR_PTR(err);
 	} else {
 		inode = hostfs_iget(dentry->d_sb, file);
-		d_drop(dentry);
 		dentry = d_splice_alias(inode, dentry);
 	}
 	__putname(file);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..250a826d5480 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2136,7 +2136,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 		put_nfs_open_context(ctx);
-		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
 			d_splice_alias(NULL, dentry);
@@ -2157,6 +2156,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		default:
 			break;
 		}
+		d_drop(dentry);
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
@@ -2304,8 +2304,6 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	struct dentry *d;
 	int error;
 
-	d_drop(dentry);
-
 	if (fhandle->size == 0) {
 		error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
 					       fhandle, fattr);
@@ -2652,7 +2650,6 @@ nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 		old_dentry, dentry);
 
 	trace_nfs_link_enter(inode, dir, dentry);
-	d_drop(dentry);
 	if (S_ISREG(inode->i_mode))
 		nfs_sync_inode(inode);
 	error = NFS_PROTO(dir)->link(inode, dir, &dentry->d_name);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..d8739c286a99 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3175,7 +3175,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	dentry = opendata->dentry;
 	if (d_really_is_negative(dentry)) {
 		struct dentry *alias;
-		d_drop(dentry);
 		alias = d_splice_alias(igrab(state->inode), dentry);
 		/* d_splice_alias() can't fail here - it's a non-directory */
 		if (alias) {
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 5223edf6d11a..8cbc284c5005 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -439,7 +439,6 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 			goto out_err;
 		}
 
-	d_drop(direntry);
 	d_add(direntry, newinode);
 
 out:
-- 
2.50.0.107.gf914562f5916.dirty


