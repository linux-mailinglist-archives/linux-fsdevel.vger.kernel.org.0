Return-Path: <linux-fsdevel+bounces-73428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8612D18E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 710AD310949C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C613921CD;
	Tue, 13 Jan 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioBKVAix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB033904CF;
	Tue, 13 Jan 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308005; cv=none; b=K9qWejUdvjPesOXcmC1cNaf6TiSpgJiEn9vza7VAo0N6ssTsd0YnCYpVOQBk1R1I4GJclShQIrJyRZPeKlIdUCkGufGE7VmsILDRtEM6XO6LISsNoqGruuZSReRDx97YwToj3CXzM3bs+t9RDNr5R4LF0xe7bQLlSjAkFFbxxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308005; c=relaxed/simple;
	bh=JeX/JMvBPkx0JbZBxwHoL8yXEwZJo/JR2r+HkOsD7FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3JzHJNibRFxIRChMXT3uZJ1mJHpA/zLcDk3Vh0rzKPdXHnDe5dtc3b/vX7NVHccEHT+R3AC6JNNbzhitPXqdeXbRjHnnJ0Q7IiAiq9NJSrE4g6X/d4sVyLMazh91io0tayYKnAzwdpQPdH63I+zhQCzCcmdjDUrWfJUP+RfSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioBKVAix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20926C116C6;
	Tue, 13 Jan 2026 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308005;
	bh=JeX/JMvBPkx0JbZBxwHoL8yXEwZJo/JR2r+HkOsD7FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioBKVAixTWkw6givsew5AlLumV0oARROOwUoQ1PQFLryjWIwlbL3HqsdWPx+5B02o
	 JYly7n9J+mhx8BVKVmpj4vF7Ee5HWe1Cu5dNITDKMJKjCKj7VgPXHnQLooxvJIgIPC
	 q9k+NDmugF7mfNw+78L22ejoKtaqGIpLHoolVPj0/zYxnVMg+5o57vgs4iENCXZGyE
	 hL8mgJkyqoQqyIa62tfLxgX7EYmSbH0ID3YXqZyhxwX3DzzpcehJPSz8VFSpzv4139
	 vumbnYL+UX83cGeRLJ2L8z6GNnCt0iYDnF1ZM/YhWEaPSfjZFJxKBWuXodB1MoqI7t
	 4CcrEm9DjuenQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/4] btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
Date: Tue, 13 Jan 2026 12:39:52 +0000
Message-ID: <46b13dc5c957deb72a7f085916757a20878a8e73.1768307858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768307858.git.fdmanana@suse.com>
References: <cover.1768307858.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no longer the need to use btrfs_may_delete(), which was a copy
of the VFS private function may_delete(), since now that functionality
is exported by the VFS as a function named may_delete_dentry(). In fact
our local copy of may_delete() lacks an update that happened to that
function which is point number 7 in that function's comment:

  "7. If the victim has an unknown uid or gid we can't change the inode."

which corresponds to this code:

	/* Inode writeback is not safe when the uid or gid are invalid. */
	if (!vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
		return -EOVERFLOW;

As long as we keep a separate copy, duplicating code, we are also prone
to updates to the VFS being missed in our local copy.

So change btrfs_ioctl_snap_destroy() to use the VFS function and remove
btrfs_may_delete().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 58 +-----------------------------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d9e7dd317670..0cb3cd3d05a5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -815,62 +815,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	return ret;
 }
 
-/*  copy of may_delete in fs/namei.c()
- *	Check whether we can remove a link victim from directory dir, check
- *  whether the type of victim is right.
- *  1. We can't do it if dir is read-only (done in permission())
- *  2. We should have write and exec permissions on dir
- *  3. We can't remove anything from append-only dir
- *  4. We can't do anything with immutable dir (done in permission())
- *  5. If the sticky bit on dir is set we should either
- *	a. be owner of dir, or
- *	b. be owner of victim, or
- *	c. have CAP_FOWNER capability
- *  6. If the victim is append-only or immutable we can't do anything with
- *     links pointing to it.
- *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
- *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
- *  9. We can't remove a root or mountpoint.
- * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
- *     nfs_async_unlink().
- */
-
-static int btrfs_may_delete(struct mnt_idmap *idmap,
-			    struct inode *dir, struct dentry *victim, int isdir)
-{
-	int ret;
-
-	if (d_really_is_negative(victim))
-		return -ENOENT;
-
-	/* The @victim is not inside @dir. */
-	if (d_inode(victim->d_parent) != dir)
-		return -EINVAL;
-	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
-
-	ret = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
-	if (ret)
-		return ret;
-	if (IS_APPEND(dir))
-		return -EPERM;
-	if (check_sticky(idmap, dir, d_inode(victim)) ||
-	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
-	    IS_SWAPFILE(d_inode(victim)))
-		return -EPERM;
-	if (isdir) {
-		if (!d_is_dir(victim))
-			return -ENOTDIR;
-		if (IS_ROOT(victim))
-			return -EBUSY;
-	} else if (d_is_dir(victim))
-		return -EISDIR;
-	if (IS_DEADDIR(dir))
-		return -ENOENT;
-	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
-		return -EBUSY;
-	return 0;
-}
-
 /* copy of may_create in fs/namei.c() */
 static inline int btrfs_may_create(struct mnt_idmap *idmap,
 				   struct inode *dir, const struct dentry *child)
@@ -2420,7 +2364,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	}
 
 	/* check if subvolume may be deleted by a user */
-	ret = btrfs_may_delete(idmap, dir, dentry, 1);
+	ret = may_delete_dentry(idmap, dir, dentry, true);
 	if (ret)
 		goto out_end_removing;
 
-- 
2.47.2


