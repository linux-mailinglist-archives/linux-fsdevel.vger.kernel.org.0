Return-Path: <linux-fsdevel+bounces-52449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088FCAE3476
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F3188A875
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EF18DF6D;
	Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nhzoJ4N8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1161C8612
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=FPnoykKhUq8p28mVGgxBhxrJnZAYgojE49nx0uUs91p8fqAXdfL94YPmn3ZojB2s+qVrpSwSUnAVX8yvK1BkAS9EB4H7nZZT3wWgDemg+py/DvlJ8tzRn+cbFyFHz5A+uFvTzqI5cL8VvxY3MuRP61MLjAOM+upes9AqowZUcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=eUnEbrrZ3hZopgDzRccysiMbAsySD7d/uynx+TkSNVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWomU8nejPEXIFuCEAQz4Rp/hAWaIObtiDqXYdL6mPY3HSnFFpwalU4JHWxVapCbusI5gPRGjid4Y3vAYV7AJ20K2sCn+R24+mpmqx9GjHBr41ZQmLCptWoEIGzz77l9km03XAiQLfC77W1SWc/ZCNuF8XotMB9nIgFlVJQqtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nhzoJ4N8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v8kQcW4J4BFnojp2PpktKzxAdhzRWigtnSyN8ktr/C4=; b=nhzoJ4N8+/5a/KjuIm9TdaMbvX
	NSOXYfeSvsK0gs/EJYx4iSCldfYWzhRo7JMpOlChPS3mqNYh+fwewVK7kQLHQDu9Br0nwv6fB2xme
	Px5lCWF6KMG2UPAxMh+jdAbfGO5hIsfJb2WelQfCDb6L0LsqUooiGCUPkWBK/iS3RaGBNhkkYMgUK
	xD3po/tPtO3XX2VRfZvkg65KXtNPPVBrX9AYNydh4KNlZUaZLwHMznnRvG4cJa9YZQ9TCV8grUYLr
	3jWa1PzyUL49kaw8o5ZdJIk1ulcEEbNtbaJfjCItuDZc8CFAcZRMdUuhQ+u284eBPjQQRxjK0WJ2O
	O8FaQkAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005Kq8-3SZi;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 14/35] don't set MNT_LOCKED on parentless mounts
Date: Mon, 23 Jun 2025 05:54:07 +0100
Message-ID: <20250623045428.1271612-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
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
index 9ac9a82d2aee..bfc85d50e8cb 100644
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
@@ -6158,7 +6157,6 @@ static void __init init_mount_tree(void)
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
-	mnt->mnt_flags |= MNT_LOCKED;
 
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
-- 
2.39.5


