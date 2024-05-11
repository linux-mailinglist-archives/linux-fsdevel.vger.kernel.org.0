Return-Path: <linux-fsdevel+bounces-19335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313158C33AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 22:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F280DB210F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9C200A0;
	Sat, 11 May 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C8pDhnNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED12032B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457833; cv=none; b=uQ70tyWK2xcc3oshuDm4VveVA10tttJn2oNE2yw17p9nsNsU4PlZn7uf/mPJ55zxBzW5l9dSxW8YZKMq+mNZ2ZMVSn5cqp/6RYmReA9pH+g90L4XtZMDVgdwepiZ69uHV+yN4blBFXQ18mIQWl5bOi2h/2ler/rCtNj2HJcUv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457833; c=relaxed/simple;
	bh=XaX43gA7ypBYQnP2Agl1MKz7CWl3O127uNeLcMWcNd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT2oOUcjcr79qFS+ePQbDahGmeBNR5JipukeKMrhq/0epKADDGcj5YAhpZDs6hHAjM9aiEY1CbxMxliDbZufs9g3Yu2xxC7v4PM8w4G1oO5o8pxfiHrxSd/+GgT1I5k/wu8TV7EeHjAnfBQxpBqbxkL5zKX80Dz7XzDM5aMtDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C8pDhnNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B667C2BBFC;
	Sat, 11 May 2024 20:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715457833;
	bh=XaX43gA7ypBYQnP2Agl1MKz7CWl3O127uNeLcMWcNd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8pDhnNRPZinoCOyON6qV+FXeqZW3TIlr3yimvXPCu6L+M3zS5aaUqYNxjGKVGdYb
	 tbLLF6QUswXoCQsQHuE1+Xy5IcWDhjqAQk5CcVNG2eiE1x2ldzlQ2as76nj3mkXLbo
	 TgHlykTMDrxavGvKOxC8UdR19ywBP9xuLnVu4nYQ=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	walters@verbum.org,
	wangkai86@huawei.com,
	willy@infradead.org
Subject: [PATCH v2] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
Date: Sat, 11 May 2024 13:02:41 -0700
Message-ID: <20240511200240.6354-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.44.0.330.g4d18c88175
In-Reply-To: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
References: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yafang Shao reports that he has seen loads that generate billions of
negative dentries in a directory, which then when the directory is
removed causes excessive latencies for other users because the dentry
shrinking is done under the directory inode lock.

There seems to be no actual reason for holding the inode lock any more
by the time we get rid of the now uninteresting negative dentries, and
it's an effect of the calling convention.

Split the 'vfs_rmdir()' function into two separate phases:

 - 'vfs_rmdir_raw()' does the actual main rmdir heavy lifting

 - 'vfs_rmdir_cleanup()' needs to be run by the caller after a
   successful raw call, after the caller has dropped the inode locks.

We leave the 'vfs_rmdir()' function around, since it has multiple
callers, and only convert the main system call path to the new two-phase
model.  The other uses will be left as an exercise for the reader for
when people find they care.

[ Side note: I think the 'dget()/dput()' pair in vfs_rmdir_raw() is
  superfluous, since callers always have to have a dentry reference over
  the call anyway. That's a separate issue.    - Linus ]

Reported-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lore.kernel.org/all/20240511022729.35144-1-laoar.shao@gmail.com/
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Second version - this time doing the dentry pruning even later, after
releasing the parent inode lock too. 

I did the same amount of "extensive testing" on this one as the previous
one.  IOW, little-to-none. 

 fs/namei.c | 61 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 28e62238346e..15b4ff6ed1e5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4176,21 +4176,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 	return do_mkdirat(AT_FDCWD, getname(pathname), mode);
 }
 
-/**
- * vfs_rmdir - remove directory
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
- *
- * Remove a directory.
- *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
- * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply pass @nop_mnt_idmap.
- */
-int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+static int vfs_rmdir_raw(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
@@ -4217,18 +4203,43 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	shrink_dcache_parent(dentry);
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
-
 out:
 	inode_unlock(dentry->d_inode);
 	dput(dentry);
-	if (!error)
-		d_delete_notify(dir, dentry);
 	return error;
 }
+
+static inline void vfs_rmdir_cleanup(struct inode *dir, struct dentry *dentry)
+{
+	shrink_dcache_parent(dentry);
+	d_delete_notify(dir, dentry);
+}
+
+/**
+ * vfs_rmdir - remove directory
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of @dentry
+ * @dentry:	pointer to dentry of the base directory
+ *
+ * Remove a directory.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ */
+int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+		     struct dentry *dentry)
+{
+	int retval = vfs_rmdir_raw(idmap, dir, dentry);
+	if (!retval)
+		vfs_rmdir_cleanup(dir, dentry);
+	return retval;
+}
 EXPORT_SYMBOL(vfs_rmdir);
 
 int do_rmdir(int dfd, struct filename *name)
@@ -4272,7 +4283,17 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	error = vfs_rmdir_raw(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	if (error)
+		goto exit4;
+	inode_unlock(path.dentry->d_inode);
+	mnt_drop_write(path.mnt);
+	vfs_rmdir_cleanup(path.dentry->d_inode, dentry);
+	dput(dentry);
+	path_put(&path);
+	putname(name);
+	return 0;
+
 exit4:
 	dput(dentry);
 exit3:
-- 
2.44.0.330.g4d18c88175


