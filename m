Return-Path: <linux-fsdevel+bounces-47012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDEA97C1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C19A17EA99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827E261571;
	Wed, 23 Apr 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ih041xFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEA25F7B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371839; cv=none; b=pNb537Vhyd1/VxU/BEHW3Sl82l9yZXHZDxo1foHjHvUmzyxisCineUA3BCUv/UMGj05t7xIDuX36Ar0yVn3Pqb585kgsn7AulhI5/2ZlcDYIP4PRMiUX28+nemutdqZSIkUf+9cGMr5G0bsJy9ifjjsnPZCTDl+aZu4l+loaHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371839; c=relaxed/simple;
	bh=67VQVOzqU6991n3VIb3I71OoHJ2kl2ftZj3gjjMGpSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw1aJT8b5mJUHg77u34VFslnhH0fKY0+IJ61/gtYEkY9Oc493Y48FpPdeQLGXEQVoqUNh7j1AVzNtxZiJ6eMmT3+gXrf/0Im4FXCCdD0oz0QOT+Pz4hgnyKAtRGKtwTZ9LQxLgkke7dJEoMZbZ40tbLxwnwEBYdVaKe7safeFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ih041xFF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wm4mVOwWD1abhnGIAPqhpwY8YFdZ5zVbenTb/d9Onvc=; b=Ih041xFFAYwxp0Ssfs7vVHgKjE
	tpFqWrwNERbQ8id7hNPOn40qgSqtwidJtGmAywqZnWWo0uytUvOBBO36jkfKqol1Drgsgu/SQVUhL
	HLUz8kL6OzH0Ytobv1yf1iLUsFAcQkI/Y6lX8jOjlp6lnhnwUqrXcePBS179+s5HjekNHMEVXbJVP
	P+6NyldMq5koJV08uPi7fzQn6pQlRtuhGvbh55qdhYzF66tLgQqL1TWu2nN+3qTDmjBVpiGCS+1VJ
	Qbth2SgeJAA6fZ6jtFGVEGAdlf6kDvzBCO5XZk6lFuuejYF7eTgEI/wYR9udr8ZDRVLQBg5tuLmLU
	mUNcBteQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Owc-00000008Bnq-20Zy;
	Wed, 23 Apr 2025 01:30:34 +0000
Date: Wed, 23 Apr 2025 02:30:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250423013034.GB2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250422-erbeten-ambiente-f6b13eab8a29@brauner>
 <20250422122514.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122514.GZ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 22, 2025 at 01:25:14PM +0100, Al Viro wrote:

> Consider the following setup:
> 
> mkdir foo
> mkdir bar
> mkdir splat
> mount -t tmpfs none foo		# mount 1
> mount -t tmpfs none bar		# mount 2
> mkdir bar/baz
> mount -t tmpfs none bar/baz	# mount 3

> 
> then
> 
> A: move_mount(AT_FDCWD, "foo", AT_FDCWD, "bar/baz", MOVE_MOUNT_BENEATH)
> gets to do_move_mount() and into do_lock_mount() called by it.
> 
> path->mnt points to mount 3, path->dentry - to its root.  Both are pinned.
> do_lock_mount() goes into the first iteration of loop.  beneath is true,
> so it picks dentry - that of #3 mountpoint, i.e. "/baz" on #2 tmpfs instance.
> 
> At that point refcount of that dentry is 3 - one from being a positive on
> tmpfs, one from being a mountpoint and one more just grabbed by do_lock_mount().
> 
> Now we enter inode_lock(dentry->d_inode).  Note that at that point A is not
> holding any locks.  Suppose it gets preempted at this moment for whatever reason.
> 
> B: mount --move bar/baz splat
> Proceeds without any problems, mount #3 gets moved to "splat".  Now refcount
> of mount #2 is not pinned by anything and refcount of "/baz" on it is 2, since
> it's no longer a mountpoint.
> 
> B: umount bar

BTW, another way to hit the same would be umount("bar", MNT_DETACH) instead of
mount --move + umount - just one syscall to get in; as long as it hits
namespace_lock() first before the move_mount() does, that's it.

And yes, on mainline with
	if (unlikely(strcmp(current->comm, "wanker") == 0))
		msleep(60000);
in front of that inode_lock() the above does trigger the spew about busy dentries
and inodes on umount -l and an oops from do_move_mount() -> do_lock_mount() ->
dput() -> iput() once the damn thing notices that mnt got unmounted and tries
to clean up.  Commit below + same debugging patch => no problem.

I'd prefer a reproducer with decent hit rate without an artificial delay inserted
just before that inode_lock() - that's fine to demonstrate that bug exists in
mainline (and fixed by the patch), but for CI it's not a good idea...

Any suggestions (as well as more testing the fix itself) would be very welcome...

commit e8dbfe567bc5362ecb5ebadb4457a2110163a901
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Apr 22 15:27:03 2025 -0400

fix a couple of races in MNT_TREE_BENEATH handling by do_move_mount()
    
Normally do_lock_mount(path, _) is locking a mountpoint pinned by
*path and at the time when matching unlock_mount() unlocks that
location it is still pinned by the same thing.

Unfortunately, for 'beneath' case it's no longer that simple -
the object being locked is not the one *path points to.  It's the
mountpoint of path->mnt.  The thing is, without sufficient locking
->mnt_parent may change under us and none of the locks are held
at that point.  The rules are
	* mount_lock stabilizes m->mnt_parent for any mount m.
	* namespace_sem stabilizes m->mnt_parent, provided that
m is mounted.
	* if either of the above holds and refcount of m is positive,
we are guaranteed the same for refcount of m->mnt_parent.

namespace_sem nests inside inode_lock(), so do_lock_mount() has
to take inode_lock() before grabbing namespace_sem.  It does
recheck that path->mnt is still mounted in the same place after
getting namespace_sem, and it does take care to pin the dentry.
It is needed, since otherwise we might end up with racing mount --move
(or umount) happening while we were getting locks; in that case
dentry would no longer be a mountpoint and could've been evicted
on memory pressure along with its inode - not something you want
when grabbing lock on that inode.

However, pinning a dentry is not enough - the matching mount is
also pinned only by the fact that path->mnt is mounted on top it
and at that point we are not holding any locks whatsoever, so
the same kind of races could end up with all references to
that mount gone just as we are about to enter inode_lock().
If that happens, we are left with filesystem being shut down while
we are holding a dentry reference on it; results are not pretty.

What we need to do is grab both dentry and mount at the same time;
that makes inode_lock() safe *and* avoids the problem with fs getting
shut down under us.  After taking namespace_sem we verify that
path->mnt is still mounted (which stabilizes its ->mnt_parent) and
check that it's still mounted at the same place.  From that point
on to the matching namespace_unlock() we are guaranteed that
mount/dentry pair we'd grabbed are also pinned by being the mountpoint
of path->mnt, so we can quietly drop both the dentry reference (as
the current code does) and mnt one - it's OK to do under namespace_sem,
since we are not dropping the final refs.

That solves the problem on do_lock_mount() side; unlock_mount()
also has one, since dentry is guaranteed to stay pinned only until
the namespace_unlock().  That's easy to fix - just have inode_unlock()
done earlier, while it's still pinned by mp->m_dentry.

Fixes: 6ac392815628 "fs: allow to mount beneath top mount" # v6.5+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/fs/namespace.c b/fs/namespace.c
index fa17762268f5..bbda516444ff 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2827,56 +2827,62 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct mountpoint *mp = ERR_PTR(-ENOENT);
+	struct path under = {};
 
 	for (;;) {
-		struct mount *m;
+		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
-			m = real_mount(mnt);
+			path_put(&under);
 			read_seqlock_excl(&mount_lock);
-			dentry = dget(m->mnt_mountpoint);
+			under.mnt = mntget(&m->mnt_parent->mnt);
+			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
+			dentry = under.dentry;
 		} else {
 			dentry = path->dentry;
 		}
 
 		inode_lock(dentry->d_inode);
-		if (unlikely(cant_mount(dentry))) {
-			inode_unlock(dentry->d_inode);
-			goto out;
-		}
-
 		namespace_lock();
 
-		if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {
+		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
+			break;		// not to be mounted on
+
+		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
+				        &m->mnt_parent->mnt != under.mnt)) {
 			namespace_unlock();
 			inode_unlock(dentry->d_inode);
-			goto out;
+			continue;	// got moved
 		}
 
 		mnt = lookup_mnt(path);
-		if (likely(!mnt))
+		if (unlikely(mnt)) {
+			namespace_unlock();
+			inode_unlock(dentry->d_inode);
+			path_put(path);
+			path->mnt = mnt;
+			path->dentry = dget(mnt->mnt_root);
+			continue;	// got overmounted
+		}
+		mp = get_mountpoint(dentry);
+		if (IS_ERR(mp))
 			break;
-
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
-		if (beneath)
-			dput(dentry);
-		path_put(path);
-		path->mnt = mnt;
-		path->dentry = dget(mnt->mnt_root);
-	}
-
-	mp = get_mountpoint(dentry);
-	if (IS_ERR(mp)) {
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
+		if (beneath) {
+			/*
+			 * @under duplicates the references that will stay
+			 * at least until namespace_unlock(), so the path_put()
+			 * below is safe (and OK to do under namespace_lock -
+			 * we are not dropping the final references here).
+			 */
+			path_put(&under);
+		}
+		return mp;
 	}
-
-out:
+	namespace_unlock();
+	inode_unlock(dentry->d_inode);
 	if (beneath)
-		dput(dentry);
-
+		path_put(&under);
 	return mp;
 }
 
@@ -2887,14 +2893,11 @@ static inline struct mountpoint *lock_mount(struct path *path)
 
 static void unlock_mount(struct mountpoint *where)
 {
-	struct dentry *dentry = where->m_dentry;
-
+	inode_unlock(where->m_dentry->d_inode);
 	read_seqlock_excl(&mount_lock);
 	put_mountpoint(where);
 	read_sequnlock_excl(&mount_lock);
-
 	namespace_unlock();
-	inode_unlock(dentry->d_inode);
 }
 
 static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)

