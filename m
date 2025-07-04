Return-Path: <linux-fsdevel+bounces-53981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85367AF9B46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 21:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF7D7A672D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B152222AF;
	Fri,  4 Jul 2025 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cX1j8QRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785A1F418F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751658260; cv=none; b=ni/hrQlNwsAdWUhVCfcqW8hkNkVNXvz3c2kWEv4HrFof9KgFq0awWvDiRqw84fKNhbLgqbxb586XffS1qhA0P5hu+reNN95Y14secuL0KIyoZqD/ve4M0/Uvp97Hu5HPOo8xXuLIi/Y5VXXONr+P+EqgDqL9NoG1yBMEKKbu40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751658260; c=relaxed/simple;
	bh=8ASbnQ5WPVsSBJdTvk5qu2nGJ8jAr8Wu+6BtlzbcQEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HFLNarGjpyrVwr2lNmGcsnNwmwYXGGQCzYtr3Ricox3xK93KYmF2O1t2MxG6UH6hlUdzLA1qD0kcFkj+NxUmn3zCEU5yZPja92KW/ioDmCoeVdV8W/lRpB/YhyOB86MxguDBz5IcuyEt3ud3YkhmIEHCpWGTuKFVJnXajGr+WPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cX1j8QRg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CRqxQQAiwU26JOAw4HWXi/N9beuhxVU+0SURlzKoOzU=; b=cX1j8QRghaGJuX9EshZlqi2VJf
	qq2hDN93C4dbD2nazDbOJLfc7G1cfqomvO6T6TWfCBwG5qIT7z2PWrKz4FCcN+CC4VGOk663NIDZx
	lkpaszoK4fD8wGnrGrVfyfc3Femvb5the22CabmftgKQBaKo4ulrLXdQ7iZWOkKaLJNBzk8LMUSEv
	YvDZY8vIXLgNT3Fz/HR8TGlF1f7aeLyN0ZfVSi3V09CGnLKb/NQPGNYNk8EP+EELxi94s8+o/wnoc
	c4yC8v51sXRY2DiXokgiJ/6G+op3eRYYVSLNnKTr8R2Y9XJD2Mgl6F5xxUyADETuRqmHn1afNKePp
	0zBE50xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXmKU-0000000EcOb-1qFB;
	Fri, 04 Jul 2025 19:44:14 +0000
Date: Fri, 4 Jul 2025 20:44:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250704194414.GR1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Scalable handling of writers count on a mount had been added
back in 2009, when the counter got split into per-cpu components.
The tricky part, of course, was on the "make it read-only" side and the
way it had been done was to add a flag for "we are adding that shit up,
feel free to increment, but don't get through the mnt_get_write_access()
until we are finished".

	Details are in mnt_get_write_access() and mnt_{,un}hold_writers().
Current rules:
	* mnt_hold_writers()/mnt_unhold_writers() should be in the same
mount_lock scope.
	* any successful mnt_hold_writers() must be followed by mnt_unhold_writers()
within the same scope.
	* mnt_get_write_access() *MAY* take and release mount_lock, but only
if there's somebody currently playing with mnt_hold_writers() on the same mount.

	The non-obvious trouble came in 2011 (in 4ed5e82fe77f "vfs: protect
remounting superblock read-only") when we got sb_prepare_remount_readonly(),
esssentially doing mnt_hold_writers() for each mount over given superblock.
I hadn't realized the implications until this year ;-/

	The trouble is, as soon as mount has been added to ->s_mounts
(currently in vfs_create_mount() and clone_mnt()) it becomes accessible
to other threads, even if only in a very limited way.

	That breaks very natural assumptions, just lightly enough to make
the resulting races hard to detect.  Note, for example, this in ovl_get_upper():
	upper_mnt = clone_private_mount(upperpath);
	err = PTR_ERR(upper_mnt);
	if (IS_ERR(upper_mnt)) {
		pr_err("failed to clone upperpath\n");
		goto out;
	}

	/* Don't inherit atime flags */
	upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
See the problem?  upper_mnt has been returned by clone_private_mount() and at
the moment it has no references to it anywhere other than this local variable.
It is not a part of any mount tree, it is not hashed, it is not reachable via
propagation graph, it is not on any expiry lists, etc.  Except that it *is*
on ->s_mounts of underlying superblock (linked via ->mnt_instance) and should
anybody try to call sb_prepare_remount_readonly(), we may end up fucking
the things up in all kinds of interesting ways - e.g.
	mnt_hold_writers() sets MNT_WRITE_HOLD
	we fetch ->mnt_flags
	mnt_unhold_writers() clears MNT_WRITE_HOLD
	we remove the atime bits and store ->mnt_flags, bringing MNT_WRITE_HOLD
back.  Makes for a very unhappy mnt_get_write_access() down the road...

	The races are real.  Some of them can be dealt with by grabbing
mount_lock around the problematic modifications of ->mnt_flags, but that's
not an option outside of fs/namespace.c - I really don't want to export
mount_lock *or* provide a "clear these flags and set these ones" exported
primitive.

	In any case, the underlying problem is that we have this state
of struct mount when it's almost, but not entirely thread-local.  That's
likely to cause future bugs of the same sort.

	I'd been playing with delaying the insertion into ->s_mounts
and making mnt_get_write_access() fail and complain if mount hasn't been
inserted yet.  It's... doable, but not pleasant.  However, there's
another approach that might be better.

	We have ->mnt_instance, which is used only under mount_lock.
We have two places where we insert, one place where we remove and
two places (both in sb_prepare_remount_readonly()) where we iterate
through the list.

	What if we steal LSB of ->mnt_instance.prev for what MNT_WRITE_HOLD
is currently used for?  list_for_each_entry() won't give a damn;
list_del() and list_add_tail() are called in mount_lock scopes that do
not contain any calls of mnt_hold_writers(), so they'll see that LSB
clear and work as usual.  Loop in mnt_get_write_access() could just
as easily do
        while ((unsigned long)READ_ONCE(mnt->mnt_instance.prev) & 1) {
as the current
        while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
and no barriers need to be changed.  We might want to move
->mnt_instance closer to ->mnt or to ->mnt_pcp, for the sake of
the number of cachelines we are accessing, but then ->mnt_instance
is pretty close to ->mnt_pcp as it is.

	Something like the delta below, modulo stale comments, etc.
AFAICS, that removes this "slightly exposed" state, along with the
races caused by it.  This is on top of mainline and it should be
easy to backport.

	Comments?

diff --git a/fs/namespace.c b/fs/namespace.c
index 54c59e091919..7e3145baac8f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -506,7 +506,7 @@ int mnt_get_write_access(struct vfsmount *m)
 	 */
 	smp_mb();
 	might_lock(&mount_lock.lock);
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
+	while ((unsigned long)READ_ONCE(mnt->mnt_instance.prev) & 1) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			cpu_relax();
 		} else {
 			preempt_enable();
-			lock_mount_hash();
-			unlock_mount_hash();
+			read_seqlock_excl(&mount_lock);
+			read_sequnlock_excl(&mount_lock);
 			preempt_disable();
 		}
 	}
@@ -650,6 +650,11 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
+static inline unsigned long __mnt_writers_held(const struct mount *m)
+{
+	return (unsigned long)m->mnt_instance.prev;
+}
+
 /**
  * mnt_hold_writers - prevent write access to the given mount
  * @mnt: mnt to prevent write access to
@@ -670,7 +675,7 @@ EXPORT_SYMBOL(mnt_drop_write_file);
  */
 static inline int mnt_hold_writers(struct mount *mnt)
 {
-	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
+	mnt->mnt_instance.prev = (void *)(__mnt_writers_held(mnt) | 1);
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
 	 * should be visible before we do.
@@ -718,7 +723,7 @@ static inline void mnt_unhold_writers(struct mount *mnt)
 	 * that become unheld will see MNT_READONLY.
 	 */
 	smp_wmb();
-	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	mnt->mnt_instance.prev = (void *)(__mnt_writers_held(mnt) & ~1);
 }
 
 static int mnt_make_readonly(struct mount *mnt)
@@ -755,8 +760,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (!err)
 		sb_start_ro_state_change(sb);
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+		unsigned long v = __mnt_writers_held(mnt);
+		if (v & 1)
+			mnt->mnt_instance.prev = (void *)(v & ~1);
 	}
 	unlock_mount_hash();
 
@@ -1349,7 +1355,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -4959,7 +4965,7 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 		 */
 		for (p = mnt; p; p = next_mnt(p, mnt)) {
 			/* If we had to hold writers unblock them. */
-			if (p->mnt.mnt_flags & MNT_WRITE_HOLD)
+			if (__mnt_writers_held(mnt) & 1)
 				mnt_unhold_writers(p);
 
 			/*
@@ -4999,7 +5005,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 		WRITE_ONCE(m->mnt.mnt_flags, flags);
 
 		/* If we had to hold writers unblock them. */
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
+		if (__mnt_writers_held(mnt) & 1)
 			mnt_unhold_writers(m);
 
 		if (kattr->propagation)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1a508beba446..1728bc50d02b 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -33,7 +33,6 @@ enum mount_flags {
 	MNT_NOSYMFOLLOW	= 0x80,
 
 	MNT_SHRINKABLE	= 0x100,
-	MNT_WRITE_HOLD	= 0x200,
 
 	MNT_SHARED	= 0x1000, /* if the vfsmount is a shared mount */
 	MNT_UNBINDABLE	= 0x2000, /* if the vfsmount is a unbindable mount */
@@ -64,7 +63,7 @@ enum mount_flags {
 				  | MNT_READONLY | MNT_NOSYMFOLLOW,
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
-	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |
+	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_INTERNAL |
 			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED |
 			     MNT_LOCKED,
 };

