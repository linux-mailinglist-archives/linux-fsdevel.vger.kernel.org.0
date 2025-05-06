Return-Path: <linux-fsdevel+bounces-48162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECAAAB942
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6505506256
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E9289342;
	Tue,  6 May 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KMWQWDJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C5202998
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498317; cv=none; b=oNMyB1pXGbFMTKNpR4417U3Rdfyw87MdlAD6MP8WXdL1sT9UkwghFL0F6swfKc/GR7/+njwPqojYbd78nYuFJcGoSycC574u54NVikGI0hXMRyrN46JciNS+Nh+8Q6RUpb8WuNubRBabJ2IhET/RxmnmJ4KAnxQk2pk78MgLZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498317; c=relaxed/simple;
	bh=n4dPN7wAD9npJr/nizY53yXeyAXyrXHg8YJr9ymyrnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROqwAmDlE7vDXZTf/qdC8LPLzh3/Ig1Eo7Zlx3kfRyq979emXfiUzEAIdpKOsTQfewUglBo6KFp+/ZTgygQ+BApBlygTx28Xo9Ro5wJtJq+BP8BbFaMW1HdmU4xA5IJN+wYHUcNKsle8pkHYNNDrFOChmKBiCxceS20FJheXLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KMWQWDJe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TTjO9FVT8AMn4y+ZaWkMDn84kdaTZxX3hyJLAkPjnkA=; b=KMWQWDJeXtjgYCv8fS5Wy36afg
	a7B/p26ypkdVPSJ623AEUgIMVjnV0pwfOOiy/nW6YTjUetorKEpEB8NNvdH/p3X4DZT7zjzzGdWNK
	fQA60MYnuqErutvzlVXSJiie0f1CajS7ZBsUf0Jtd8fq/tgmRs+7eLKM4UxqZWL1PwrdQYWwEvKjw
	FqFPfMjUyLpdVc6AgCCGWBBgwsE6GNgA/IfKRIfHlPBDZWAKQc1panHjNf+P8MrjgtSbVzGt/jZFN
	BW2ua5p4WEpR1UxRq22lrMrWNgEhK3b+RgpRM+eZqtfWTCELzh/JlKUb2Lex6zfMhG0V5jpTQSqKJ
	K1giwBrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC7zb-00000008993-06xS;
	Tue, 06 May 2025 02:25:11 +0000
Date: Tue, 6 May 2025 03:25:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
Message-ID: <20250506022511.GL2023217@ZenIV>
References: <20250501201506.GS2023217@ZenIV>
 <87plgq8igd.fsf@email.froward.int.ebiederm.org>
 <20250504232441.GC2023217@ZenIV>
 <877c2v88rz.fsf@email.froward.int.ebiederm.org>
 <20250505190215.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505190215.GG2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 08:02:15PM +0100, Al Viro wrote:

> Said that, from digging I'd done last night there might be a different
> long-term approach; the thing is, there are very few places where we
> ever look at MNT_LOCKED for mounts with !mnt_has_parent():
> 	do_umount()
> 	can_umount()
> 	do_move_mount()
> 	pivot_root()
> and two of those four are of dubious use - can_umount() will be followed
> by rechecking in do_umount(), so there's not much point in bailing out
> early in a very pathological case.  And do_move_mount() might check
> MNT_LOCKED on such, but only in move-from-anon case, where we do *NOT*
> set MNT_LOCKED on namespace root.

Even better, we have a check for !mnt_has_parent() downstream of that in
pivot_root() and we reject such there.  So having that set on absolute
root of non-anon namespaces buys us very little - do_umount() is the only
place that would need to explicitly check for that.

> IOW, looking at the way things are now, I'm no longer sure that the trick
> you've done in da362b09e42 "umount: Do not allow unmounting rootfs"
> had been a good idea long-term - it certainly made for smaller fix,
> but it overloaded semantics of MNT_LOCKED, making it not just about
> protecting the mountpoint against exposure.
> 
> What if we add explicit checks for mnt_has_parent() in do_umount() and
> pivot_root() next to existing checks for MNT_LOCKED?  Then we can
> 	* have clone_mnt() treat that flag as "internal, ignore" (matter
> of fact, I would simply add MNT_LOCKED to MNT_INTERNAL_FLAGS and have
> clone_mnt() strip that, same as we do in do_add_mount()).
> 	* have copy_tree() set it right next to attach_mnt(), if the source
> had it.  Yes, leaving it clear for root of copied tree.
> 	* no need to clear it in the end of __do_loopback() (racy at the
> moment, BTW - no mount_lock held there, so race with mount -o remount,ro
> for the original is possible, so something is needed there)
> 	* have lock_mnt_tree() skip the MNT_LOCKED not just for the expirable
> but for the root of subtree as well.
> 	* don't bother stripping MNT_LOCKED for roots of propagation copies
> (or anyone, for that matter) in attach_recursive_mnt()
> 	* don't bother setting it on absolute root of initial namespace
> 
> Looks like we end up with overall simpler code that way; it's certainly
> conceptually simpler - MNT_LOCKED is set only on the mounts that do
> have parent we care to protect, with that being done atomically wrt
> mount becoming reachable (lock_mnt_tree() is in the same lock_mount_hash()
> scope where we call commit_tree() that makes the entire subtree reachable).
> 
> Your argument in "mnt: Move the clear of MNT_LOCKED from copy_tree to
> it's callers" about wanting to keep it in collect_mounts() for audit
> purposes is wrong, AFAICS - audit does not see or care about MNT_LOCKED;
> the only thing we use the result of collect_mounts() for is passing
> it to iterate_mounts(), which literally "apply this callback to each
> vfsmount in the set", completely ignoring anything else.  What's more,
> all callbacks audit is passing to it actually look only at the inode of
> that mount's root...
> 
> Anyway, that's longer-term stuff; I'll put together a patch along those
> lines on top of this one.

Here it is, on top of the previous.  Objections, comments?

[PATCH] don't set MNT_LOCKED on parentless mounts

Originally MNT_LOCKED meant only one thing - "don't let this mount to
be peeled off its parent, we don't want to have mountpoint exposed".
Accordingly, it had only been set on mounts that *do* have a parent.
Later it had been overloaded with another use - setting it on the
absolute root had given free protection against umount(2) on absolute
root (possible to trigger, oopsed).  Not a bad trick, but it ended
up costing more than it bought us.  Unfortunately, the cost included
both hard-to-reason-about logics and a subtle race between
mount -o remount,ro and mount --[r]bind - lockless &= ~MNT_LOCKED in
the end of __do_loopback() could race with sb_prepare_remount_readonly()
setting and clearing MNT_HOLD_WRITE (under mount_lock, as it should
be).

Turns out that nobody except umount(2) had ever made use of having
MNT_LOCKED set on absolute root.  So let's give up on that trick,
clever as it had been, add an explicit check in do_umount() and
return to using MNT_LOCKED only for mounts that have a parent.

It means that
	* clone_mnt() no longer copies MNT_LOCKED
	* copy_tree() sets it on submounts if their counterparts had
been marked such, and do that right next to attach_mnt() in there,
in the same mount_lock scope.
	* __do_loopback() no longer needs to strip MNT_LOCKED off the
root of subtree it's about to return; no store, no race.
	* init_mount_tree() doesn't bother setting MNT_LOCKED on absolute
root.
	* lock_mnt_tree() does not set MNT_LOCKED on the subtree's root;
accordingly, its caller (loop in attach_recursive_mnt()) does not need to
bother stripping that MNT_LOCKED.  Note that lock_mnt_tree() setting
MNT_LOCKED on submounts happens in the same mount_lock scope as __attach_mnt()
(from commit_tree()) that makes them reachable.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 04a9bb9f31fa..165b3bd26857 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1363,7 +1363,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -2038,6 +2038,9 @@ static int do_umount(struct mount *mnt, int flags)
 	if (mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
 
+	if (!mnt_has_parent(mnt))
+		goto out;
+
 	event++;
 	if (flags & MNT_DETACH) {
 		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
@@ -2308,6 +2311,8 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			if (IS_ERR(dst_mnt))
 				goto out;
 			lock_mount_hash();
+			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
+				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
 			unlock_mount_hash();
@@ -2547,7 +2552,7 @@ static void lock_mnt_tree(struct mount *mnt)
 		if (flags & MNT_NOEXEC)
 			flags |= MNT_LOCK_NOEXEC;
 		/* Don't allow unprivileged users to reveal what is under a mount */
-		if (list_empty(&p->mnt_expire))
+		if (list_empty(&p->mnt_expire) && p != mnt)
 			flags |= MNT_LOCKED;
 		p->mnt.mnt_flags = flags;
 	}
@@ -2758,7 +2763,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
-		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
@@ -3027,26 +3031,21 @@ static inline bool may_copy_tree(struct path *path)
 
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
 
 	if (!recurse && has_locked_children(old, old_path->dentry))
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
@@ -4789,11 +4788,11 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
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
@@ -6191,7 +6190,6 @@ static void __init init_mount_tree(void)
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
-	mnt->mnt_flags |= MNT_LOCKED;
 
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);

