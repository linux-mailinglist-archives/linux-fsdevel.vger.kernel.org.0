Return-Path: <linux-fsdevel+bounces-53253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92455AED293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AD11894C00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980D1DF974;
	Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t8FXN4/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705118FDBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=jWQYCg0ay6XBOh62kX5cGIkGMYqpvcWHfdPr8NOaSDMJNr4w12pmyRitahsvxICD6rhkLqf1oHSdpqecbwD7vdqYkzMigi3pgwImrNnguqJDXZoA+C49vi8mgQ5C41a2MMFHXuu8m3K0mrmSOEfatNqEOpQCN2ILCszFVESmueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=9OVvObU1d40y30nWwByStcuw8PN5aobDhnrvPYJwQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmRHzCYW4oIgaIvy/qyUd6OAxEUZKxkO8cm61hFisNTSfb6EAylgbLw9YHauhdfByqeZWyXnv934BSAtXVQtJ6+93RV3rhm3DqwG6twTIMPHZtoysq9WjFKkmZ1Lj+zi4L2tzCMAa381Oe9GSfgQPzZn0oLXzwBWpUgxmS2iQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t8FXN4/R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I0pXJQBwt9blh9wRrY2y68xn2W732lAIhw8lwoEdVLM=; b=t8FXN4/RbB2zqvHAGUPryhwpA5
	CrxbVjIUGMtPXkzO2TY1UitVFbFbHMHYIxf4r8MI2RbtXQCI+VLYL3tHzgNpDEArsVEycqnGWvH0J
	CzzJXpVLmFVbQOj9/u3x+dVyU3e7O8vBkwwGKwiWxTV4pBNe+yVTp71TscItynAZfEDQNZYME/6ZB
	xEfydUZA4w++02WToJrw3z4RacmepJ5pP8gROeLeVTqjvBLxCE7n5qEjygjvCT8Sd4y2ByanGOLkp
	cy2ZoI4UG9HHU1692u8AOLwlnGrG3u/fS1ztqEfsSWpCMQvTRK7x4yP/WU5zkmzIBwaYooQuHMRKe
	2+PgiI9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005oww-1pZO;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 12/48] don't set MNT_LOCKED on parentless mounts
Date: Mon, 30 Jun 2025 03:52:19 +0100
Message-ID: <20250630025255.1387419-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Originally MNT_LOCKED meant only one thing - "don't let this mount to
be peeled off its parent, we don't want to have its mountpoint exposed".
Accordingly, it had only been set on mounts that *do* have a parent.
Later it got overloaded with another use - setting it on the absolute
root had given free protection against umount(2) of absolute root
(was possible to trigger, oopsed).  Not a bad trick, but it ended
up costing more than it bought us.  Unfortunately, the cost included
both hard-to-reason-about logics and a subtle race between
mount -o remount,ro and mount --[r]bind - lockless &= ~MNT_LOCKED in
the end of __do_loopback() could race with sb_prepare_remount_readonly()
setting and clearing MNT_HOLD_WRITE (under mount_lock, as it should
be).  The race wouldn't be much of a problem (there are other ways to
deal with it), but the subtlety is.

Turns out that nobody except umount(2) had ever made use of having
MNT_LOCKED set on absolute root.  So let's give up on that trick,
clever as it had been, add an explicit check in do_umount() and
return to using MNT_LOCKED only for mounts that have a parent.

It means that
	* clone_mnt() no longer copies MNT_LOCKED
	* copy_tree() sets it on submounts if their counterparts had
been marked such, and does that right next to attach_mnt() in there,
in the same mount_lock scope.
	* __do_loopback() no longer needs to strip MNT_LOCKED off the
root of subtree it's about to return; no store, no race.
	* init_mount_tree() doesn't bother setting MNT_LOCKED on absolute
root.
	* lock_mnt_tree() does not set MNT_LOCKED on the subtree's root;
accordingly, its caller (loop in attach_recursive_mnt()) does not need to
bother stripping that MNT_LOCKED on root.  Note that lock_mnt_tree() setting
MNT_LOCKED on submounts happens in the same mount_lock scope as __attach_mnt()
(from commit_tree()) that makes them reachable.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 75d45d0b615c..791904128f1e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1313,7 +1313,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1988,6 +1988,9 @@ static int do_umount(struct mount *mnt, int flags)
 	if (mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 
+	if (!mnt_has_parent(mnt)) /* not the absolute root */
+		goto out;
+
 	event++;
 	if (flags & MNT_DETACH) {
 		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
@@ -2257,6 +2260,8 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			if (IS_ERR(dst_mnt))
 				goto out;
 			lock_mount_hash();
+			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
+				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
@@ -2489,7 +2494,7 @@ static void lock_mnt_tree(struct mount *mnt)
 		if (flags & MNT_NOEXEC)
 			flags |= MNT_LOCK_NOEXEC;
 		/* Don't allow unprivileged users to reveal what is under a mount */
-		if (list_empty(&p->mnt_expire))
+		if (list_empty(&p->mnt_expire) && p != mnt)
 			flags |= MNT_LOCKED;
 		p->mnt.mnt_flags = flags;
 	}
@@ -2704,7 +2709,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
-		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
 		if (q) {
@@ -2985,26 +2989,21 @@ static inline bool may_copy_tree(struct path *path)
 
 static struct mount *__do_loopback(struct path *old_path, int recurse)
 {
-	struct mount *mnt = ERR_PTR(-EINVAL), *old = real_mount(old_path->mnt);
+	struct mount *old = real_mount(old_path->mnt);
 
 	if (IS_MNT_UNBINDABLE(old))
-		return mnt;
+		return ERR_PTR(-EINVAL);
 
 	if (!may_copy_tree(old_path))
-		return mnt;
+		return ERR_PTR(-EINVAL);
 
 	if (!recurse && __has_locked_children(old, old_path->dentry))
-		return mnt;
+		return ERR_PTR(-EINVAL);
 
 	if (recurse)
-		mnt = copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
+		return copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
 	else
-		mnt = clone_mnt(old, old_path->dentry, 0);
-
-	if (!IS_ERR(mnt))
-		mnt->mnt.mnt_flags &= ~MNT_LOCKED;
-
-	return mnt;
+		return clone_mnt(old, old_path->dentry, 0);
 }
 
 /*
@@ -4749,11 +4748,11 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	if (!path_mounted(&root))
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(root_mnt))
-		goto out4; /* not attached */
+		goto out4; /* absolute root */
 	if (!path_mounted(&new))
 		goto out4; /* not a mountpoint */
 	if (!mnt_has_parent(new_mnt))
-		goto out4; /* not attached */
+		goto out4; /* absolute root */
 	/* make sure we can reach put_old from new_root */
 	if (!is_path_reachable(old_mnt, old.dentry, &new))
 		goto out4;
@@ -6154,7 +6153,6 @@ static void __init init_mount_tree(void)
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
-	mnt->mnt_flags |= MNT_LOCKED;
 
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
-- 
2.39.5


