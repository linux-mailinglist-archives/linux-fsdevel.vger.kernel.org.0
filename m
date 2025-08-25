Return-Path: <linux-fsdevel+bounces-58947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11695B33592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF053A2E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A8285CB4;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sYI8XCIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C027E056
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=L2QKJRuAPQdyqApXrn0IhVKcyxovT05z4ejreeUPo90dIho0LEhDSVWfw51QP9gbv0MYn96Xafz8l9YZ3uPPMwHKwke2boJ8EhlFd/osanmA7rC/tOXA8e2ztzTrKUNB6ivXtBx1Ex8yUMFVWqE2Dj5rCTMCYp6l+CRVTkUC2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=HRvZQsP12BGGJBGhcYAVUD6OLwnxh3X4HQCBqKNVLVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk9eSY6h4Oq7qriqeFEEn7KZmv20X7ZYJSxCngpNPZAp4nqJFOjSQlypQrfoYJDzLdFulpEkhUek8Q8muv3oZuL910YMUczcwA6wRyjwXQs7l2TY2f/e6oXdIivUGrCGzaoy2qvD+QYbSNb8Ow0A+G2Q36o9GDJ5uLH8IlRkBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sYI8XCIA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bzuenF8YvHkk5OIowHDhfQRQnGfvblW+mmWPI5xWAv0=; b=sYI8XCIAXESIcWmJAAGJgRtxR4
	AF4tCOIBYSPVhAWFouzPUNY0U/GCk8us1leppa5Dqtd7J74dTnGFbu0N0qtmBGtcMZgh1b7BmUbPD
	uJcAdJ8SDfSFGa0qXxJ3CpGF3+r7Pon4dTacXd5QOEPahc5LXxn7K75asskzJBEuiH6Uku2AvQrnw
	dCibNkdeZxB3kvDd0oYOSOUfo8uCU9q93fKA29KQbia0JYUjIjQ0hzIzi9EsWOlOreu/Lyw72t9C5
	XtmZWnqnm/Fy8zBoqA1OUxI9dS4EC+gKzHiylwGlu2/0TG4re6JLCHRDqvT19suUBMzvnKJfHWGLZ
	dFieDEnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TDP-0M7c;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 34/52] do_lock_mount(): don't modify path.
Date: Mon, 25 Aug 2025 05:43:37 +0100
Message-ID: <20250825044355.1541941-34-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently do_lock_mount() has the target path switched to whatever
might be overmounting it.  We _do_ want to have the parent
mount/mountpoint chosen on top of the overmounting pile; however,
the way it's done has unpleasant races - if umount propagation
removes the overmount while we'd been trying to set the environment
up, we might end up failing if our target path strays into that overmount
just before the overmount gets kicked out.

Users of do_lock_mount() do not need the target path changed - they
have all information in res->{parent,mp}; only one place (in
do_move_mount()) currently uses the resulting path->mnt, and that value
is trivial to reconstruct by the original value of path->mnt + chosen
parent mount.

Let's keep the target path unchanged; it avoids a bunch of subtle races
and it's not hard to do:
	do
		as mount_locked_reader
			find the prospective parent mount/mountpoint dentry
			grab references if it's not the original target
		lock the prospective mountpoint dentry
		take namespace_sem exclusive
		if prospective parent/mountpoint would be different now
			err = -EAGAIN
		else if location has been unmounted
			err = -ENOENT
		else if mountpoint dentry is not allowed to be mounted on
			err = -ENOENT
		else if beneath and the top of the pile was the absolute root
			err = -EINVAL
		else
			try to get struct mountpoint (by dentry), set
			err to 0 on success and -ENO{MEM,ENT} on failure
		if err != 0
			res->parent = ERR_PTR(err)
			drop locks
		else
			res->parent = prospective parent
		drop temporary references
	while err == -EAGAIN

A somewhat subtle part is that dropping temporary references is allowed.
Neither mounts nor dentries should be evicted by a thread that holds
namespace_sem.  On success we are dropping those references under
namespace_sem, so we need to be sure that these are not the last
references remaining.  However, on success we'd already verified (under
namespace_sem) that original target is still mounted and that mount
and dentry we are about to drop are still reachable from it via the
mount tree.  That guarantees that we are not about to drop the last
remaining references.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 126 ++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 93eba16e42b6..f95e12ab6c9a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2728,6 +2728,27 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	return err;
 }
 
+static inline struct mount *where_to_mount(const struct path *path,
+					   struct dentry **dentry,
+					   bool beneath)
+{
+	struct mount *m;
+
+	if (unlikely(beneath)) {
+		m = topmost_overmount(real_mount(path->mnt));
+		*dentry = m->mnt_mountpoint;
+		return m->mnt_parent;
+	} else {
+		m = __lookup_mnt(path->mnt, *dentry = path->dentry);
+		if (unlikely(m)) {
+			m = topmost_overmount(m);
+			*dentry = m->mnt.mnt_root;
+			return m;
+		}
+		return real_mount(path->mnt);
+	}
+}
+
 /**
  * do_lock_mount - acquire environment for mounting
  * @path:	target path
@@ -2759,84 +2780,69 @@ static int attach_recursive_mnt(struct mount *source_mnt,
  * case we also require the location to be at the root of a mount
  * that has a parent (i.e. is not a root of some namespace).
  */
-static void do_lock_mount(struct path *path, struct pinned_mountpoint *res, bool beneath)
+static void do_lock_mount(const struct path *path,
+			  struct pinned_mountpoint *res,
+			  bool beneath)
 {
-	struct vfsmount *mnt = path->mnt;
-	struct dentry *dentry;
-	struct path under = {};
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(beneath) && !path_mounted(path)) {
 		res->parent = ERR_PTR(-EINVAL);
 		return;
 	}
 
-	for (;;) {
-		struct mount *m = real_mount(mnt);
-
-		if (beneath) {
-			path_put(&under);
-			read_seqlock_excl(&mount_lock);
-			if (unlikely(!mnt_has_parent(m))) {
-				read_sequnlock_excl(&mount_lock);
-				res->parent = ERR_PTR(-EINVAL);
-				return;
+	do {
+		struct dentry *dentry, *d;
+		struct mount *m, *n;
+
+		scoped_guard(mount_locked_reader) {
+			m = where_to_mount(path, &dentry, beneath);
+			if (&m->mnt != path->mnt) {
+				mntget(&m->mnt);
+				dget(dentry);
 			}
-			under.mnt = mntget(&m->mnt_parent->mnt);
-			under.dentry = dget(m->mnt_mountpoint);
-			read_sequnlock_excl(&mount_lock);
-			dentry = under.dentry;
-		} else {
-			dentry = path->dentry;
 		}
 
 		inode_lock(dentry->d_inode);
 		namespace_lock();
 
-		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
-			break;		// not to be mounted on
+		// check if the chain of mounts (if any) has changed.
+		scoped_guard(mount_locked_reader)
+			n = where_to_mount(path, &d, beneath);
 
-		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
-				        &m->mnt_parent->mnt != under.mnt)) {
-			namespace_unlock();
-			inode_unlock(dentry->d_inode);
-			continue;	// got moved
-		}
+		if (unlikely(n != m || dentry != d))
+			err = -EAGAIN;		// something moved, retry
+		else if (unlikely(cant_mount(dentry) || !is_mounted(path->mnt)))
+			err = -ENOENT;		// not to be mounted on
+		else if (beneath && &m->mnt == path->mnt && !m->overmount)
+			err = -EINVAL;
+		else
+			err = get_mountpoint(dentry, res);
 
-		mnt = lookup_mnt(path);
-		if (unlikely(mnt)) {
+		if (unlikely(err)) {
+			res->parent = ERR_PTR(err);
 			namespace_unlock();
 			inode_unlock(dentry->d_inode);
-			path_put(path);
-			path->mnt = mnt;
-			path->dentry = dget(mnt->mnt_root);
-			continue;	// got overmounted
+		} else {
+			res->parent = m;
 		}
-		err = get_mountpoint(dentry, res);
-		if (err)
-			break;
-		if (beneath) {
-			/*
-			 * @under duplicates the references that will stay
-			 * at least until namespace_unlock(), so the path_put()
-			 * below is safe (and OK to do under namespace_lock -
-			 * we are not dropping the final references here).
-			 */
-			path_put(&under);
-			res->parent = real_mount(path->mnt)->mnt_parent;
-			return;
+		/*
+		 * Drop the temporary references.  This is subtle - on success
+		 * we are doing that under namespace_sem, which would normally
+		 * be forbidden.  However, in that case we are guaranteed that
+		 * refcounts won't reach zero, since we know that path->mnt
+		 * is mounted and thus all mounts reachable from it are pinned
+		 * and stable, along with their mountpoints and roots.
+		 */
+		if (&m->mnt != path->mnt) {
+			dput(dentry);
+			mntput(&m->mnt);
 		}
-		res->parent = real_mount(path->mnt);
-		return;
-	}
-	namespace_unlock();
-	inode_unlock(dentry->d_inode);
-	if (beneath)
-		path_put(&under);
-	res->parent = ERR_PTR(err);
+	} while (err == -EAGAIN);
 }
 
-static inline void lock_mount(struct path *path, struct pinned_mountpoint *m)
+static inline void lock_mount(const struct path *path,
+			      struct pinned_mountpoint *m)
 {
 	do_lock_mount(path, m, false);
 }
@@ -3617,7 +3623,11 @@ static int do_move_mount(struct path *old_path,
 	}
 
 	if (beneath) {
-		err = can_move_mount_beneath(old, real_mount(new_path->mnt), mp.mp);
+		struct mount *over = real_mount(new_path->mnt);
+
+		if (mp.parent != over->mnt_parent)
+			over = mp.parent->overmount;
+		err = can_move_mount_beneath(old, over, mp.mp);
 		if (err)
 			return err;
 	}
-- 
2.47.2


