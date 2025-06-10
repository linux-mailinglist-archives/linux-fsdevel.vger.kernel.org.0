Return-Path: <linux-fsdevel+bounces-51138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1CAD2FFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24407A6295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAF283FEF;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X39KR3gZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9028030F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=MUSwr2vQDkbb+pEpVaDhzCN4EYIZ/eG/3MRzsITaxsaprMpMPzFFrDBZtx7QPdfS8RF6QykmmsVzToRzdODwC5zA9t3ZHge3HHkSTXFvcWms8qlfIZRVrPNAAf1s0aKA10rYo1yR9Gqi38/FB7DWXwK/xU83JRS4ZWtMXrDkpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=G/4o6FR8d+GcFOxloU36cNWq9e1tCBoar89KJ8r7xBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mus6FhC+wSx5FGLlGfpz8JkgRXZoryBAxK+tWw2l8960f9C3TMHF99FImXjMQU0jMUx30mZ9UoW5yV18PQEgknQAeB66GubdSFr4vFpZFRzmpSTd5lxC9NvQBeO/hhb3fy1nsWayw66y1HQnklN8iRd2iG5VjDKh1tdwKoGNMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X39KR3gZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I8RsmmQsYJ13hGTZ8MuupZcMovRjla3W+ym36533Z2U=; b=X39KR3gZ5CjSegB7WgXsFmG3T6
	YBrov74daQLqhkFRFyU42uhj6dWovNOf9bQ7H4J19MfO2Ft5LzOzEME1KbuL8vCrDGw984533nAWH
	ZCIFpvt/Imf1wBO/9aFeC1OcZBqby27H1VtbuEevesDT/eQf9UNa/Hf6xcIQkbsb68dzx0ARt0xpY
	supRCq/iXEWfmCnVe19miKIohRPdnSlNDBriK+z9B/AjIfXnkp6eIXkMH7ELGgLbnA+FdJCtDa9Xg
	TDeH81xw4g74rNtBgO9FLP37m4mG2+GacsdbK6UbSUgGB+BksR+C/N/ElrHpMyoHsDi1+EQOunD+f
	Ndg0eCqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jLq-0tKq;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 08/26] don't set MNT_LOCKED on parentless mounts
Date: Tue, 10 Jun 2025 09:21:30 +0100
Message-ID: <20250610082148.1127550-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e783eb801060..d6c81eab6a11 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1349,7 +1349,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -2024,6 +2024,9 @@ static int do_umount(struct mount *mnt, int flags)
 	if (mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 
+	if (!mnt_has_parent(mnt))
+		goto out;
+
 	event++;
 	if (flags & MNT_DETACH) {
 		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
@@ -2293,6 +2296,8 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			if (IS_ERR(dst_mnt))
 				goto out;
 			lock_mount_hash();
+			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
+				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
 			unlock_mount_hash();
@@ -2508,7 +2513,7 @@ static void lock_mnt_tree(struct mount *mnt)
 		if (flags & MNT_NOEXEC)
 			flags |= MNT_LOCK_NOEXEC;
 		/* Don't allow unprivileged users to reveal what is under a mount */
-		if (list_empty(&p->mnt_expire))
+		if (list_empty(&p->mnt_expire) && p != mnt)
 			flags |= MNT_LOCKED;
 		p->mnt.mnt_flags = flags;
 	}
@@ -2719,7 +2724,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
-		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
@@ -2992,26 +2996,21 @@ static inline bool may_copy_tree(struct path *path)
 
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
@@ -4756,11 +4755,11 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
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
@@ -6176,7 +6175,6 @@ static void __init init_mount_tree(void)
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
-	mnt->mnt_flags |= MNT_LOCKED;
 
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
-- 
2.39.5


