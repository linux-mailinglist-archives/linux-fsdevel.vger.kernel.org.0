Return-Path: <linux-fsdevel+bounces-65823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA8C125C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813BC505E23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5202F60A1;
	Tue, 28 Oct 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PMdm5O5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27191204F8B;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612386; cv=none; b=YZmURpGWgjEnRdZHa7u9zK9JqDVYHt9AG/DwAcBqIvTVX8b/G8EcGkuBMRmU6cL2Gap07ROJqYFm37UkK2zfiguGtgWKYr4mTP6DVADtFRjFzXNWkfp/NM9U96+scR6dhTGKnNuz/xFOrNCrUgBFCZYKi9ZEt+794fXRErMbdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612386; c=relaxed/simple;
	bh=jwkFEDrwvTGDwUNpjVB1S2cW3gao1k8zeHmkQ0uUtHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIHoNohrXK85VTaw1DBvLpx6MVXFMhNug8oYCYo8mS9qnghT9lZzCq53wZTGgeb1dV7lInG8CZU8KvbEoZQSq+vQw6PCi0OmIGqbkrXD7gsZ+FFyYTYgU0WlndsjuA2HVKhZNo34PCK+ZO0+K6RmjvujBD7N7HC9qgcBr/t32EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PMdm5O5D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Swq0voO+aKDUTzOh35qGY7dyE9PZZpqvfSqrFdp+4zM=; b=PMdm5O5DypSxNosRCZjXbf6giR
	S2l8ZgeUeQtWvTBS4262ttA2tRFr/P9cDv0mMkWUuwe6X112adNRzW4r23HUpF/ojuTTWgXjLe+GQ
	MGN+aS+r4bxfpr0KR7QFmy8PEFeN1YlHKPje8zdhE4AcUx5zmlNbcdG+wl62rnJUMyO4EuNgaBSLJ
	oIK0GmpMo6fKsZRSZ076+wfNAUETtrSto0G21f+iRy1y2QzEv/R4O0wcRjPswBHWOm/RLr0f9rlph
	ZhsmjECTxwhWxEmxIN+o/2FR0w6S/tXIoxE+sMzpimtpZHVmHkG81YL7LDa6acIFs6lsUq52pdhlz
	rI//EQfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqp-00000001eWT-2AS4;
	Tue, 28 Oct 2025 00:46:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 08/50] convert ramfs and tmpfs
Date: Tue, 28 Oct 2025 00:45:27 +0000
Message-ID: <20251028004614.393374-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Quite a bit is already done by infrastructure changes (simple_link(),
simple_unlink()) - all that is left is replacing d_instantiate() +
pinning dget() (in ->symlink() and ->mknod()) with d_make_persistent(),
and, in case of shmem, using simple_unlink() and simple_link() in
->unlink() and ->link() resp., instead of open-coding those there.
Since d_make_persistent() accepts (and hashes) unhashed ones, shmem
situation gets simpler - we no longer care whether ->lookup() has hashed
the sucker.

With that done, we don't need kill_litter_super() for these filesystems
anymore - by the umount time all remaining dentries will be marked
persistent and kill_litter_super() will boil down to call of
kill_anon_super().

The same goes for devtmpfs and rootfs - they are handled by
ramfs or by shmem, depending upon config.

NB: strictly speaking, both devtmpfs and rootfs ought to use
ramfs_kill_sb() if they end up using ramfs; that's a separate
story and the only impact of "just use kill_{litter,anon}_super()"
is that we fail to free their sb->s_fs_info... on reboot.
That's orthogonal to the changes in this series - kill_litter_super()
is identical to kill_anon_super() for those at this point.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/base/devtmpfs.c |  2 +-
 fs/ramfs/inode.c        |  8 +++-----
 init/do_mounts.c        |  2 +-
 mm/shmem.c              | 38 ++++++++------------------------------
 4 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 9d4e46ad8352..a63b0ff0c432 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -70,7 +70,7 @@ static struct file_system_type internal_fs_type = {
 #else
 	.init_fs_context = ramfs_init_fs_context,
 #endif
-	.kill_sb = kill_litter_super,
+	.kill_sb = kill_anon_super,
 };
 
 /* Simply take a ref on the existing mount */
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 41f9995da7ca..505d10a0cb36 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -110,8 +110,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			goto out;
 		}
 
-		d_instantiate(dentry, inode);
-		dget(dentry);	/* Extra count - pin the dentry in core */
+		d_make_persistent(dentry, inode);
 		error = 0;
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	}
@@ -154,8 +153,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 		error = page_symlink(inode, symname, l);
 		if (!error) {
-			d_instantiate(dentry, inode);
-			dget(dentry);
+			d_make_persistent(dentry, inode);
 			inode_set_mtime_to_ts(dir,
 					      inode_set_ctime_current(dir));
 		} else
@@ -313,7 +311,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 void ramfs_kill_sb(struct super_block *sb)
 {
 	kfree(sb->s_fs_info);
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 }
 
 static struct file_system_type ramfs_fs_type = {
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 6af29da8889e..810878fb55b6 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -507,7 +507,7 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.init_fs_context = rootfs_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 };
 
 void __init init_rootfs(void)
diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..a38f71519813 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3858,12 +3858,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_add(dentry, inode);
-	else
-		d_instantiate(dentry, inode);
-
-	dget(dentry); /* Extra count - pin the dentry in core */
+	d_make_persistent(dentry, inode);
 	return error;
 
 out_iput:
@@ -3924,7 +3919,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 		      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	int ret = 0;
+	int ret;
 
 	/*
 	 * No ordinary (disk based) filesystem counts links as inodes;
@@ -3936,29 +3931,19 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink) {
 		ret = shmem_reserve_inode(inode->i_sb, NULL);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	ret = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
 	if (ret) {
 		if (inode->i_nlink)
 			shmem_free_inode(inode->i_sb, 0);
-		goto out;
+		return ret;
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	inode_set_mtime_to_ts(dir,
-			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inode_inc_iversion(dir);
-	inc_nlink(inode);
-	ihold(inode);	/* New dentry reference */
-	dget(dentry);	/* Extra pinning count for the created dentry */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_add(dentry, inode);
-	else
-		d_instantiate(dentry, inode);
-out:
-	return ret;
+	return simple_link(old_dentry, dir, dentry);
 }
 
 static int shmem_unlink(struct inode *dir, struct dentry *dentry)
@@ -3971,11 +3956,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	inode_set_mtime_to_ts(dir,
-			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inode_inc_iversion(dir);
-	drop_nlink(inode);
-	dput(dentry);	/* Undo the count from "create" - does all the work */
+	simple_unlink(dir, dentry);
 
 	/*
 	 * For now, VFS can't deal with case-insensitive negative dentries, so
@@ -4130,11 +4112,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
-		d_add(dentry, inode);
-	else
-		d_instantiate(dentry, inode);
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 	return 0;
 
 out_remove_offset:
@@ -5334,7 +5312,7 @@ static struct file_system_type shmem_fs_type = {
 #ifdef CONFIG_TMPFS
 	.parameters	= shmem_fs_parameters,
 #endif
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
-- 
2.47.3


