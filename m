Return-Path: <linux-fsdevel+bounces-10211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D423848AAB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE551F246BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CA1869;
	Sun,  4 Feb 2024 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VdNoWbJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B2EDE;
	Sun,  4 Feb 2024 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013670; cv=none; b=L+V0tAR4ucs0a6NB3UrBNE8m44nU8ANwBSNFHcQbaOIqP5/1pyo0d5t7VO1v1ckw/eWI+K7tf2OUHri19qa1e7Hmr0E+2QVzB/Vkunfdoew4lMZIxLxQfNKO9DOZmZvAGDUKOJpjPBeedPDak1o4oMY+3OM6Dt2AuGDlb/kPRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013670; c=relaxed/simple;
	bh=AgBoP/pTn50k1EBS94+w7qvCmCMgjjHQelEwWrEnLa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrcVRfGKn163cvYbtn/kSGfbKG6UmwbS3MSDfPVLWpPJrW801zHRb1CuqqV73+WgIGTKmuFvBhrdSYpbJDzyQDrm7ZMBO8PeRXyWgsHdyWWBl0Sdbih39hvSEOUUK6bJ7U8ZpfYscXVxmPD5jKQJDIJfIxrt4LLuF0jp4cKQjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VdNoWbJU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wxXhP2KZAKa2PBF3pJ3N+ndgOlucxvRYdGYpFXgXRr4=; b=VdNoWbJUiQNMcws4MoZU/W29i8
	w/uxfBDhtzfv9nwG9Qwy9Coz3bqKfNa9lE8RQcFxmg4uT/b52BEhqvIjUheXWJQ/sxGEikKv6QuRJ
	GQ+77H78ZDNZ2Sn/EYeBRltX2Wo/+r95hr4fSpBUkhlIQrpoUNact1iRs3bG2WvkiGA9IQYPLj2Xj
	+/9ToKG5XXji6irmUaYgn72vJR/x2GnaogwTmoEOjIPj6zHD122t0oiYW6qlFTQSqYL7EA/6pzyAz
	8rGwus5/MHJf2MPUsdxAUhIXR+LtQNSQ+qtk0LxwHzoUmPp3XMm5qgYMnthvxur0xelDLJMiy5VK+
	lHniD9pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWSER-004rUk-37;
	Sun, 04 Feb 2024 02:27:44 +0000
Date: Sun, 4 Feb 2024 02:27:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: RCU pathwalk audit notes
Message-ID: <20240204022743.GI2087318@ZenIV>
References: <20240204021436.GH2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204021436.GH2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Below are my notes from that code audit; a part of that would probably
be useful for filesystem maintainers - right now it's between the
braindump and usable documentation.  If anyone finds it useful - great;
if somebody helps with turning that into proper documentation - even
better.
--------------------------------------------------------------------------
PRELIMINARY NOTE: it is possible for a lazy pathwalk to run into a dentry
on a filesystem that is getting shut down.  Here's how:
	* have two threads sharing fs_struct chdir'ed on that filesystem.
	* lazy-umount it, so that the only thing holding it alive is
cwd of these threads.
	* one of the threads does relative pathname resolution
and gets to e.g. ->d_hash().  It's holding rcu_read_lock().
	* at the same time another thread does fchdir(), moving to
different directory.  set_fs_pwd() flips to the new place and does
mntput() on the old one.  No RCU delays here, we calculate the
refcount of that mount and see that we are dropping the last reference.
We make sure that the first thread will fail when it comes to
legitimize_mnt() and do this:
			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
				return;
As we leave the syscall, we have __cleanup_mnt() run; it calls
cleanup_mnt() on our mount, which hits deactivate_super().  That was
the last reference to superblock.

	Voila - we have a filesystem shutdown right under the nose of
a thread running in ->d_hash() of something on that filesystem.
	Mutatis mutandis, one can arrange the same for other methods
called by rcu pathwalk.

	It's not easy to hit (especially if you want to get through the
entire ->kill_sb() before the first thread gets through ->d_hash()),
and it's probably impossible on the real hardware; on KVM it might be
borderline doable.  However, it is possible and I would not swear that
other ways of arranging the same thing are equally hard to hit.

	The bottom line: methods that can be called in RCU mode need to
be careful about the per-superblock objects destruction.
[end of note]

	Exposure of filesystem code to lockless environment, or
the ways in which RCU pathwalk may fuck filesystem maintainer over.


	Filesystem methods can usually count upon VFS-provided warranties
regarding the stability of objects they are called to act upon; at the
very least, they can expect the dentries/inodes/superblocks involved to
remain live throughout the operation.

	Life would be much more painful without that; however, such
warranties do not come for free.  The problem is that access patterns are
heavily biased; every system call getting an absolute pathname will have
to start at root directory, etc.  Having each of them in effect write
"I'd been here" on the same memory objects would cost quite a bit.
As the result, we try to keep the fast path stores-free, bumping no
refcounts and taking no locks.	Details are described elsewhere, but the
bottom line for filesystems is that some methods may be called with much
looser warranties than usual.  Of course, from the filesystem POV each
of those is a potential source of headache - you are asked to operate
on an object that might start to be torn down right under you, possibly
along with the filesystem instance it lives on.

	The list of the methods that could run into that fun:

	method		| indication that the call is unsafe	| unstable objects
->d_hash(d, ...) 	|	none - any call might be	|	d
->d_compare(d, ...)	|	none - any call might be	|	d
->d_revalidate(d, f)	|	f & LOOKUP_RCU			|	d
->d_manage(d, f)	|	f				|	d
->permission(i, m)	|	m & MAY_NOT_BLOCK		|	i
->get_link(d, i, ...)	|	d == NULL			|	i
->get_inode_acl(i, t, f)|	f == LOOKUP_RCU			|	i


	Additionally, callback set by set_delayed_call() from unsafe call of
->get_link() will be run in the same environment; that one is usually not
a problem, though.

	For the sake of completeness, three of LSM methods
(->inode_permission(), ->inode_follow_link() and ->task_to_inode())
might be called in similar environment, but that's a problem for LSM
crowd, not for filesystem folks.


	Any method call is, of course, required not to crash - no stepping on
freed memory, etc.  All of the unsafe calls listed above are done under
rcu_read_lock(), so they are not allowed to block.  Further requirements
vary between the methods.


	Before going through the list of affected methods, several notes on
the things that _are_ guaranteed:
	* if a reference to struct dentry is passed to such call, it will
not be freed until the method returns.	The same goes for a reference to
struct inode and to struct super_block pointed to by ->d_sb or ->i_sb
members of dentry and inode resp.  Any of those might be in process of
being torn down or enter such state right under us; the entire point of
those unsafe calls is that we make them without telling anyone they'd
need to wait for us.
	* following ->d_parent and ->d_inode of such dentries is fine,
provided that it's done by READ_ONCE() (for ->d_inode the preferred form
is d_inode_rcu(dentry)).  The value of ->d_parent is never going to be
NULL and it will again point to a struct dentry that will not be freed
until the method call finishes.  The value of ->d_inode might be NULL;
if non-NULL, it'll be pointing to a struct inode that will not be freed
until the method call finishes.
	* none of the inodes passed to an unsafe call could have reached
fs/inode.c:evict() before the caller grabbed rcu_read_lock().
	* for inodes 'not freed' means 'not entered ->free_inode()', so
anything that won't be destroyed until ->free_inode() is safe to access.
Anything synchronously destroyed in ->evict_inode() or ->destroy_inode()
is not safe; however, one can count upon the call_rcu() callbacks issued
in those yet to be entered.  Note that unlike dentries and superblocks,
inodes are embedded into filesystem-private objects; anything stored
directly in the containing object is safe to access.
	* for dentries anything destroyed by ->d_prune() (synchronously or
not) is not safe; the same goes for the things synchronously destroyed by
->d_release().  However, call_rcu() callbacks issued in ->d_release() are
yet to be entered.
	* for superblocks we can count upon call_rcu() callbacks issued
from inside the ->kill_sb() (including the ones issued from ->put_super())
yet to be entered.
	* NOTE: we can not count upon the things like ->d_parent
being positive (or a directory); a race with rename()+rmdir()+mknod()
and you might find a FIFO as parent's inode.  NULL is even easier -
just have the dentry *and* its ex-parent already past dentry_kill()
(which is a normal situation for eviction on memory pressure) and there
you go.  Normally such pathologies are prevented by the locking (and
dentry refcounting), but... the entire point of that stuff is to avoid
informing anyone that we are there, so those mechanisms are bypassed.
What's more, if dentry is not pinned by refcount, grabbing its ->d_lock
will *not* suffice to prevent that kind of mess - the scenario with
eviction by memory pressure won't be prevented by that; you might have
grabbed ->d_lock only after the dentry_kill() had released it, and at
that point ->d_parent still points to what used to be the parent, but
there's nothing to prevent its eviction.
	* [with fix in this series] for superblocks we can count
upon ->s_user_ns still being pinned and ->s_security have not
been freed yet.


	1. ->d_compare().

	For ->d_compare() we just need to make sure it won't crash
when called for dying dentry - an incorrect return value won't harm the
caller in such case.  False positives and false negatives alike - the
callers take care of that.  To be pedantic, make that "false positives
do not cause problems unless they have ->d_manage()", but ->d_manage()
is present only on autofs and there's no autofs ->d_compare() instances.

[[ footnote:
		Some callers prevent being called for dying dentry (holding
	->d_lock and having verified !d_unhashed() or finding it in the list
	of inode's aliases under ->i_lock).  For those the scenario in question
	simply cannot arise.
		Some follow the match with lockref_get_not_dead() and treat
	the failure as mismatch.  That takes care of false positives, and false
	negatives on dying dentry are still correct - we simply pretend to have
	lost the race.
		The only caller that does not fit into the classes above is
	__d_lookup_rcu_op_compare().  There we sample ->d_seq and verify !d_unhashed()
	before calling ->d_compare().  That is not enough to prevent dentry
	from starting to die right under us; however, the sampled value of ->d_seq
	will be rechecked when the caller gets to step_into(), so for a false
	positive we will end up with a mismatch.  The corner case around ->d_manage()
	is due to the handle_mounts() done before step_into() gets to ->d_seq
	validation...
]]

	There is no indication that ->d_compare() is called in RCU mode;
the majority of callers are such, anyway, so we need to cope with that.
VFS guarantees that dentry won't be freed under us; the same goes for
the superblock pointed to by its ->d_sb.  Name points to memory object
that won't get freed under us and length does not exceed the size of
that object.  The contents of that object is *NOT* guaranteed to be
stable; d_move() might race with us, modifying the name.  However, in
that case we are free to return an arbitrary result - the callers will
take care of both false positives and false negatives in such case.
The name we are comparing dentry with (passed in qstr) is stable,
thankfully...

	If we need to access any other data, it's up to the filesystem
to protect it.  In practice it means that destruction of fs-private part
of superblock (and possibly unicode tables hanging off it, etc.) might
need to be RCU-delayed.

	*IF* you want the behaviour that varies depending upon the parent
directory, you get to be very careful with READ_ONCE() and watch out
for the object lifetimes.

	Basically, if the things get that tricky, ask for help.
Currently there are two such instances in the tree - proc_sys_compare()
and generic_ci_d_compare().  Both are... special.


	2. ->d_hash().

	For ->d_hash() on a dying dentry we are free to report any hash
value; the only extra requirement is that we should not return stray
hard errors.  In other words, if we return anything other than 0 or
-ECHILD, we'd better make sure that this error would've been correct
before the parent started dying.  Since ->d_hash() error-reporting is
usually done to reject unacceptable names (too long, contain unsuitable
characters for this filesystem, etc.), that's really not a problem -
hard errors depend only upon the name, not the parent.

	Again, VFS guarantees that freeing of dentry and of the superblock
pointed to by dentry->d_sb won't happen under us.  The name passed to
us (in qstr) is stable.  If you need anything beyond that, you are
in the same situation as with ->d_compare().  Might want to RCU-delay
freeing private part of superblock (if that's what we need to access),
might want the same for some objects hanging off that (unicode tables,
etc.).  If you need something beyond that - ask for help.


	3. ->d_revalidate().

	For this one we do have an indication of call being unsafe -
flags & LOOKUP_RCU.  With ->d_revalidate we are always allowed to bail
out and return -ECHILD; that will have the caller drop out of RCU mode.
We definitely need to do that if revalidate would require any kind of IO,
mutex-taking, etc.; we can't block in RCU mode.

	Quite a few instances of ->d_revalidate() simply treat LOOKUP_RCU
in flags as "return -ECHILD and be done with that"; it's guaranteed to
do the right thing, but you lose the benefits of RCU pathwalks whenever
you run into such dentry.

	Same as with the previous methods, we are guaranteed that
dentry and dentry->d_sb won't be freed under us.  We are also guaranteed
that ->d_parent (which is *not* stable, so use READ_ONCE) points to a
struct dentry that won't get freed under us.  As always with ->d_parent,
it's not NULL - for a detached dentry it will point to dentry itself.
d_inode_rcu() of dentry and its parent will be either NULL or will
point to a struct inode that won't get freed under us.	Anything beyond
than that is not guaranteed.  We may find parent to be negative - it can
happen if we race with d_move() and removal of old parent.  In that case
just return -ECHILD and be done with that.

	On non-RCU side you could use dget_parent() instead - that
would give a positive dentry and its ->d_inode would remain stable.
dget_parent() has to be paired with dput(), though, so it's not usable
in RCU mode.

	If you need fs-private objects associated with dentry, its parent
inode(s) or superblock - see the general notes above on how to access
those.


	4. ->d_manage()

	Can be called in RCU mode; gets an argument telling it if it has
been called so.  Pretty much autofs-only; for everyone's sanity sake,
don't inflict more of those on the kernel.  Definitely don't do that
without asking first...


	5.  ->permission()

	Can be called in RCU mode; that is indicated by MAY_NOT_BLOCK
in mask, and it can only happen for MAY_EXEC checks on directories.
In RCU mode it is not allowed to block, and it is allowed to bail out
by returning -ECHILD.  It might be called for an inode that is getting
torn down, possibly along with its filesystem.	Errors other than -ECHILD
should only be returned if they would've been returned in non-RCU mode;
several instances in procfs currently (6.5) run afoul of that one.  That's
an instructive example, BTW - what happens is that proc_pid_permission()
uses proc_get_task() to find the relevant process.  proc_get_task()
uses PID reference stored in struct proc_inode our inode is embedded
into; inode can't have been freed yet, so fetching ->pid member in that
is safe.  However, using the value you've fetched is a different story
- proc_evict_inode() would have passed it to put_pid() and replaced
it with NULL.  Unsafe caller has no way to tell if that is happening
right under it.  Solution: stop zeroing ->pid in proc_evict_inode()
and move put_pid() from proc_pid_evict_inode() to proc_free_inode().
That's not all that is needed (there's access to procfs-private part of
superblock as well), but it does make a good example of how such stuff
can be dealt with.

	Note that idmap argument is safe on all calls - its destruction
is rcu-delayed.

	The amount of headache is seriously reduced (for now) by the fact
that a lot of instances boil down to generic_permission() (which will
do the right thing in RCU mode) when mask is MAY_EXEC | MAY_NOT_BLOCK.
If we ever extend RCU mode to other ->permission() callers, the thing will
get interesting; that's not likely to happen, though, unless access(2)
goes there [this is NOT a suggestion, folks].


	6. ->get_link()

	Again, this can be called in RCU mode.	Even if your
->d_revalidate() always returns -ECHILD in RCU mode and kicks the
pathwalk out of it, you can't assume that ->get_link() won't be reached;
binding a symlink on a regular file on another filesystem is possible
and that's all it takes for RCU pathwalk to get there.	NULL dentry
argument is an indicator of unsafe call; if you can't handle it, just
return ERR_PTR(-ECHILD).  Any allocations you need to do (and with this
method you really might need that) should be done with GFP_ATOMIC in
the unsafe case.

	Whatever you pass to set_delayed_call() is going to be called
in the same mode as ->get_link() itself; not a problem for most of the
instances.  The string you return needs to stay there until the
callback gets called or, if no callback is set, until at least the
freeing of inode.  As usual, for an unsafe call the inode might be
in process of teardown, possibly along with the hosting filesystem.
The usual considerations apply.  The same, BTW, applies to whatever
you set in ->i_link - it must stay around at least until ->free_inode().


	7. ->get_inode_acl()

	Very limited exposure for that one - unsafe call is possible
only if you explicitly set ACL_DONT_CACHE as cached ACL value.
Only two filesystems (fuse and overlayfs) even bother.  Unsafe call
is indicated by explicit flag (the third argument of the method),
bailout is done by returning ERR_PTR(-CHILD) and the usual considerations
apply for any access to data structures you might need to do.


	List of potentially relevant instances:

d_hash:
	adfs_hash()
		safe; dereferences ->s_fs_info, which is freed by
		kfree_rcu() from ->put_super().  All errors are
		directory-independent.
	affs_hash_dentry()
		UAF; checks a bit in object referenced to by ->s_fs_info
		->s_fs_info is freed (synchronously) by ->kill_sb().
		Fixed by switch to kfree_rcu() ("affs: free affs_sb_info with kfree_rcu()")
		All errors are directory-independent.
	affs_intl_hash_dentry()
		same as affs_hash_dentry() above.
	cifs_ci_hash()
		safe; uses ->s_fs_info->local_nls.  
		->s_fs_info is freed from delayed_free(), via call_rcu() from
		cifs_umount() from ->kill_sb().  ->local_nls is dropped in
		the same place.
		All errors are directory-independent.
	efivarfs_d_hash()
		safe - no access to fs objects.
		All errors are directory-independent.
	exfat_d_hash()
		UAF; uses ->s_fs_info->nls_io and ->s_fs_info->vol_utbl.
		->s_fs_info and ->vol_utbl are freed (synchronously) from
		->kill_sb().  ->nls_io is dropped (also synchronously)
		from ->put_super().  All errors are directory-independent.
		Fixed by moving freeing all that stuff into a rcu-delayed helper
		called from ->kill_sb() ("exfat: move freeing sbi, upcase table and
		dropping nls into rcu-delayed helper").
	exfat_utf8_d_hash()
		UAF; similar to exfat_d_hash(), except that ->nls_io is not used.
		Fix of exfat_d_hash() covers that one.
	generic_ci_d_hash()
		safe; probably would be more idiomatic to use d_inode_rcu() in
		there...
	gfs2_dhash()
		safe - no access to fs objects.
		No errors at all.
	hfs_hash_dentry()
		safe - no access to fs objects.
		No errors at all.
	hfsplus_hash_dentry()
		UAF (and oops); access to ->s_fs_info->nls.  Dropped and freed
		(and ->s_fs_info zeroed) in ->put_super().  Fixed by making their
		destruction rcu-delayed ("hfsplus: switch to rcu-delayed unloading
		of nls and freeing ->s_fs_info").  Might be worth moving that from
		->put_super() to ->kill_sb(), but that's a separate story...
		All errors are directory-independent.
	hpfs_hash_dentry()
		safe - no access to fs objects.
		No errors at all.
	isofs_hashi()
		safe - no access to fs objects.
		No errors at all.
	isofs_hashi_ms()
		safe - no access to fs objects.
		No errors at all.
	isofs_hash_ms()
		safe - no access to fs objects.
		No errors at all.
	jfs_ci_hash()
		safe - no access to fs objects.
		No errors at all.
	msdos_hash()
		safe - dereferences ->s_fs_info, freeing is rcu-delayed
		(in delayed_free(), from ->put_super()).
		All errors are directory-independent.
	vfat_hash()
		safe - no access to fs objects.
		No errors at all.
	vfat_hashi()
		safe - uses ->s_fs_info->nls_io, freeing and unloading
		is rcu-delayed	(in delayed_free(), from ->put_super()).
		No errors at all.
	ntfs_d_hash()
		fucked in head - blocking allocations, UAF, etc.
		Not touching that one, sorry.

d_compare:
	adfs_compare()
		safe - no fs objects accessed
	affs_compare_dentry()
		same as affs_hash_dentry(), fixed by the same patch
	affs_intl_compare_dentry()
		same as affs_hash_dentry(), fixed by the same patch
	cifs_ci_compare()
		safe; uses ->s_fs_info->local_nls.  
		->s_fs_info is freed from delayed_free(), via call_rcu() from
		cifs_umount() from ->kill_sb().  ->local_nls is dropped in
		the same place.
	efivarfs_d_compare()
		safe - no access to fs objects.
	exfat_d_cmp()
		UAF; similar to exfat_d_hash(), fixed by the same patch
	exfat_utf8_d_cmp()
		UAF; similar to exfat_utf8_d_hash(), fixed by the same patch
	generic_ci_d_compare()
		safe, even though it's a really scary one.
	hfs_compare_dentry()
		safe - no access to fs objects.
	hfsplus_compare_dentry()
		UAF; similar to hfsplus_hash_dentry(), fixed by the same patch
	hpfs_compare_dentry()
		safe - uses ->s_fs_info->sb_cp_table; freeing is rcu-delayed
		(in lazy_free_sbi(), from hpfs_put_super().
	isofs_dentry_cmpi()
		safe - no access to fs objects.
	isofs_dentry_cmpi_ms()
		safe - no access to fs objects.
	isofs_dentry_cmp_ms()
		safe - no access to fs objects.
	jfs_ci_compare()
		safe - no access to fs objects.
	msdos_cmp()
		safe - dereferences ->s_fs_info, freeing is rcu-delayed
		(in delayed_free(), from ->put_super()).
	proc_sys_compare()
		safe - access of ->sysctl of containing proc_inode,
		with barriers provided by rcu_dereference() and
		protection against the case it had already been zeroed.
		Freeing of the object it points to is rcu-delayed
		(kfree_rcu() from ->evict_inode()).
	vfat_cmp()
		safe - no access to fs objects.
	vfat_cmpi()
		safe - uses ->s_fs_info->nls_io, freeing and unloading
		is rcu-delayed (in delayed_free(), from ->put_super()).
	ntfs_d_compare()
		fucked in head - blocking allocations, UAF, etc.
		Not touching that one, sorry.

d_revalidate:
	afs_d_revalidate()
		race - we might end up doing __afs_break_callback() there,
		and it could race with afs_drop_open_mmap(), leading to
		stray queued work on object that might be about to be
		freed, with nothing to flush or cancel the sucker.
		Fixed by making sure that afs_drop_open_mmap()
		will only do the final decrement while under ->cb_lock;
		since the entire __afs_break_callback() is done under
		the same, it will either see zero mmap count and do
		nothing, or it will finish queue_work() before afs_drop_open_mmap()
		gets to its flush_work() ("afs: fix __afs_break_callback() /
		afs_drop_open_mmap() race").
	afs_dynroot_d_revalidate()
		safe - no access to fs objects, no errors.
		Probably no point keeping it...
	cifs_d_revalidate()
		safe - bails out in unsafe case
	coda_dentry_revalidate()
		safe - bails out in unsafe case
	ecryptfs_d_revalidate()
		safe - bails out in unsafe case
	exfat_d_revalidate()
		safe - bails out in unsafe case
	fscrypt_d_revalidate()
		safe - accesses dentry, then either accesses no fs objects,
		or bails out in unsafe case
	fuse_dentry_revalidate()
		safe - fetches ->d_inode (safely), then accesses fields
		of dentry and of the structure inode is embedded into.
		In 32bit case we also dereference ->d_fsdata, but there
		its freeing is done by kfree_rcu() from ->d_release(),
		which means that it won't be freed until we drop
		rcu_read_lock().  Probably needs cleaning its control
		flow, but that's a separate story...
	gfs2_drevalidate()
		buggered.  Used to bail out in unsafe case, now it will
		go and do blocking IO.  Revert; proposed fixes still
		don't deal with everything - they treat "can't do it
		in RCU mode" as "invalid", not "unlazy and repeat".
		[Reverted in mainline now]
	hfs_revalidate_dentry()
		safe - bails out in unsafe case
	jfs_ci_revalidate()
		safe - accesses dentry, then no access to fs objects.
	kernfs_dop_revalidate()
		safe - bails out in unsafe case
	map_files_d_revalidate()
		safe - bails out in unsafe case
	nfs4_lookup_revalidate()
		oops - nfs_set_verifier() makes an assumption that
		having grabbed ->d_lock is enough to keep dentry's
		parent positive.  That's only true if dentry is pinned
		down...  Fixed by rechecking parent's ->d_inode in
		there ("nfs: make nfs_set_verifier() safe for use in RCU
		pathwalk").  Also a UAF - we dereference ->s_fs_info, and
		that's freed synchronously in ->kill_sb().  The same goes
		for ->s_fs_info->io_stats (ditto) and, worse yet, for
		->s_fs_info->nfs_client->rpc_ops.  nfs_client might get
		freed synchronously, if our superblock is holding the
		last reference, and this is not just a use-after-free -
		it's chasing pointers through the freed structure, so we
		might end up dereferencing an address that had never been
		mapped/is in iomem/whatnot.  What's more, after we get to
		rpc_ops, we fetch a function pointer from there and call
		it...  Fixed by RCU-delaying the actual freeing of
		objects in question (" nfs: fix UAF on pathwalk running
		into umount").
	nfs_lookup_revalidate()
		same story as with nfs4_lookup_revalidate().
	ocfs2_dentry_revalidate()
		safe - bails out in unsafe case
	orangefs_d_revalidate()
		safe - accesses dentry, then either accesses no fs objects,
		or bails out in unsafe case
	ovl_dentry_revalidate()
		Safe.  Access to dentry, verifying that it's positive,
		then walking through the ovl_entry for associated inode
		(freeing of which is RCU-delayed) and calling ->d_revalidate()
		on all components (dput() is _not_ RCU-delayed, but it isn't
		initiated until the inode refcount reaches zero, so we are
		essentially in the same conditions as with RCU calls of 
		>d_revalidate() - refcounts of dentries in question are not
		reached until after our rcu_read_lock() done by path_init().
		_WAY_ too subtle, IMO - it relies upon DCACHE_OP_REVALIDATE
		being turned off for negative dentries, so it can run into
		a negative only in RCU mode (in non-RCU we are holding a reference,
		so positive would've stayed positive).  In that case we must've
		had successful unlink or rmdir and both would've unhashed
		the sucker, so legitimization would fail.  _Ouch_.
	pid_revalidate()
		UAF; uses proc_pid(); not safe, since it's dropped in
		->evict_inode().  Fixed by dropping it in ->free_inode()
		instead ("procfs: move dropping pde and pid from ->evict_inode()
		to ->free_inode()".  It also might access LSM shite associated
		with inode; safe, AFAICS, in both LSM flavours that care
		about ->task_to_inode() hook.
	proc_misc_d_revalidate()
		safe - bails out in unsafe case.
		Incidentally, it wouldn't take much to make it work unsafe
		case - by the end of the series we would have everything
		we need for that...
	proc_net_d_revalidate()
		safe - no access to fs objects
	proc_sys_revalidate()
		safe - bails out in unsafe case
	tid_fd_revalidate()
		safe - bails out in unsafe case
	v9fs_lookup_revalidate()
		safe - bails out in unsafe case
	vboxsf_dentry_revalidate()
		safe - bails out in unsafe case.
	vfat_revalidate()
		safe - bails out in unsafe case.
	vfat_revalidate_ci()
		safe - bails out in unsafe case.
	xattr_hide_revalidate
		safe - no access to fs objects
	ceph_d_revalidate()
		broken - races on fs shutdown, AFAICS, and with that
		one I'm not familiar enough with the codebase, so
		I'd rather leave that to ceph maintainers...
		Lifetime of ceph_mds_client, etc.

d_manage:
	autofs_d_manage()
		safe; accesses fs-private objects associated
		with dentry and with superblock (freeing either is
		rcu-delayed).  The only non-obvious part is the call of
		autofs_oz_mode(), which looks like it might try to compare
		task_pgrp(current) with potentially dangling pointer;
		however, it only becomes dangling after ->kill_sb()
		had called autofs_catatonic_mode(), at which point we
		want autofs_oz_mode() to return true, same PGRP or not.
		IOW, potential false positives on struct pid reuse
		are not false at all.

permission: [reordered with the default instance put in front]
	generic_permission()
		safe; accesses fields of struct inode, relies upon the rcu-delayed
		freeing of cached acls.  Bails out if an unsafe call would have
		to extract acls from filesystem (with narrow exception used by
		fuse and overlayfs).
	afs_permission()
		same race as in afs_d_revalidate(), same fix
	autofs_dir_permission()
		safe - boils down to generic_permission() if no MAY_WRITE is given.
		Even with MAY_WRITE it would be safe - it accesses ->s_fs_data
		in that case, but that gets freed with kfree_rcu()...
	bad_inode_permission()
		safe - no access to filesystem objects
	btrfs_permission()
		safe - boils down to generic_permission() if no MAY_WRITE is given.
		With MAY_WRITE it would boil down to access to btrfs_root; no
		idea where does that get freed.
	ceph_permission()
		safe - bails out in unsafe case
	cifs_permission()
		safe - derefences ->s_fs_info, then possibly does generic_permission().
		see above (cifs_ci_hash() entry) for the reasons that's safe.
	coda_ioctl_permission()
		safe - no access to filesystem objects
	coda_permission()
		safe - bails out in unsafe case
	ecryptfs_permission()
		safe - it fetches ->wii_inode of containing
		ecryptfs_inode_info, then passes it to inode_permission().
		Note that this call of inode_permission() is itself
		unsafe; the inode passed to it might be getting torn down.
		However, the reference held in ecryptfs_inode_info does
		contribute to inode refcount and it is not dropped until
		ecryptfs_evict_inode().   IOW, that inode must have had
		a positive refcount at some point after the caller had
		grabbed rcu_read_lock().
	fuse_permission()
		UAF; accesses ->s_fs_info->fc, and ->s_fs_info
		points to struct fuse_mount which gets freed
		synchronously by fuse_mount_destroy(), from
		the end of ->kill_sb().  It proceeds to accessing
		->fc, but that part is safe - ->fc freeing is
		done via kfree_rcu() (called via ->fc->release())
		after the refcount of ->fc drops to zero.
		That can't happen until the call of fuse_conn_put()
		(from fuse_mount_destroy() from ->kill_sb()), so anything
		rcu-delayed from there won't get freed until the end of
		rcu pathwalk.
		
		Unfortunately, we also dereference fc->user_ns (pass it
		to current_in_userns).  That gets dropped via put_user_ns()
		(non-rcu-delayed) from the final fuse_conn_put() and it
		needs to be delayed.

		Solution: make freeing in ->release() synchronous
		and do call_rcu(delayed_release, &fc->rcu), with
		delayed_release() doing put_user_ns() and calling
		->release() ("fuse: fix UAF in rcu pathwalks").

		In case of MAY_ACCESS | MAY_CHDIR it would blow up in
		rcu mode; thankfully, we are not calling it that way.
	gfs2_permission()
		currently safe, with breakage reverted.
		carefully dereferences ->ip_gl of containing gfs2_inode,
		bails out if NULL.  Freeing of the object being accessed
		is rcu-delayed, and past that point it either bails
		out or does generic_permission().
	hostfs_permission()
		safe - bails out in unsafe case
	kernfs_iop_permission()
		safe - bails out in unsafe case
	nfs_permission()
		same UAF as for nfs4_lookup_revalidate(), same fix
		NB: might make sense to tell nfs_revalidate_inode() that
		we are in non-blocking mode and have it bail out with -ECHILD
		if it's about to talk to server; then bailout at
		out_notsup: would go away.
	nilfs_permission()
		safe - boils down to generic_permission() if no MAY_WRITE is given.
		IF we want to support MAY_WRITE|MAY_NOT_BLOCK, it becomes more
		interesting.  We dereference a pointer (->i_root) in
		nilfs object inode is embedded into.  Probably would be enough
		to rcu-delay freeing nilfs_root - just the kfree() -> kfree_rcu()
		in nilfs_put_root().
	ocfs2_permission()
		safe - bails out in unsafe case
	orangefs_permission()
		safe - bails out in unsafe case
	ovl_permission()
		safe.  Accesses the object inode is embedded into,
		dereferences a pointer to ovl_entry (->oe) in that
		object, accesses inodes and dentries found in ovl_entry.
		Freeing of ->oe is done from ->free_inode(), i.e. past
		an RCU delay; dropping dentry references in it happens
		from ->destroy_inode(), which couldn't have happened
		before we'd grabbed rcu_read_lock(), so wrt the dentries
		we are in the same situation as for anything found
		during the pathwalk - they might be going down, but they
		couldn't have started to do so until after our rcu_read_lock().
		We dereference ->layer pointer picked from oe and pick
		struct mount reference from there; safe, since the object
		it points to is taken apart in ovl_free_fs(), after
		ovl_free_fs() has called kern_unmount_array(), with its RCU delay.
		Probably worth a comment - it's fairly subtle.
		Call of generic_permission() is safe, as usual.
		We also access ->creator_cred in fs-private part of
		superblock; that gets dropped from ovl_free_fs(),
		again, after the call of kern_unmount_array().
	proc_fd_permission()
		UAF; same story as with pid_revalidate(), same fix
	proc_pid_permission()
		UAF; same as with pid_revalidate() + use of
		->s_fs_info, which is freed synchronously from ->kill_sb();
		to fix that part, make freeing ->s_fs_info
		rcu-delayed.  Dropping pidns doesn't need
		to be rcu-delayed - it's already careful enough.
		Fixed in "procfs: make freeing proc_fs_info rcu-delayed"
	proc_tid_comm_permission()
		safe, because it's a non-directory and will see no
		unsafe calls.  IF we allow MAY_NOT_BLOCK in other
		callers, same UAF as in pid_revalidate() (with the same
		fix).
	proc_sys_permission()
		race; we start with fetching ->sysctl of the proc_inode our
		inode is embedded into.  That gets cleared from ->evict_inode(),
		without an RCU delay.  Freeing of that thing *is* RCU-delayed,
		so dereference is safe.  However, running into a directory
		that is getting evicted is indistinguishable from running
		into /proc/sys itself, since there ->sysctl is NULL all
		along; that's an artefact of the way we represent the root
		sysctl inode.  Race is harmless, not quite by an accident -
		/proc/sys permissions are the least restrictive in the entire
		subtree, so we do not get bogus hard errors and if rcu pathwalk
		observes such inode getting evicted, we are going to get ->d_seq
		mismatch anyway.  Fixing the race would still be nice (and
		getting rid of that artefact would simplify things there),
		but that's out of scope for this series.
	reiserfs_permission()
		safe - accesses fields of inode, then proceeds to generic_permission()
	reject_all()
		safe - no access to filesystem objects

get_link: [reordered with two common instances put in front]
	simple_get_link()
		safe; returns ->i_link, which should be pointing to something
		that will live at least until inode freeing.  Separate code
		audit, but AFAICS everything's currently fine with that one.
	page_get_link()
		safe; that's "grab page in inode->i_mapping, bail out if
		not there or not uptodate" and inode->i_mapping points to
		&inode->i_data for all symlinks.
		NOTE: hitting busy symlink inodes in generic_shutdown_super()
		will poison ->i_mapping; that's really a data corruption
		scenario, though - the possibility of race hitting UAF
		here is the least of concerns.  Might insert synchronize_rcu()
		before the poisoning loop for shits and giggles, but...
		no point, really.
	autofs_get_link()
		safe - bails out in unsafe case
	bad_inode_get_link()
		safe - no fs objects accessed
	ceph_encrypted_get_link()
		safe - bails out in unsafe case
	cifs_get_link()
		buggered - unconditional GFP_KERNEL allocation
		looks like they'd assumed that ->d_revalidate() bailing
		out would suffice; it isn't.  Obvious fix: bail out in
		unsafe case and be done with that ("cifs_get_link(): bail
		out in unsafe case").  It might be tempting
		to try and return ->symlink_target and to hell with any
		allocations, but...  the damn thing can get freed and
		replaced at any point.	Might be possible to work around
		(add a refcount, store new value with rcu_assign_pointer,
		add rcu delay between refcount hitting zero and freeing
		the sucker), but that's way out of scope for this.
	ecryptfs_get_link()
		safe - bails out in unsafe case
	ext4_encrypted_get_link()
		safe - bails out in unsafe case
	ext4_get_link()
		leak - checks a bit in containing ext4_inode_info, then
		either bails out in unsafe case, or does buffer_head
		analogue of what page_get_link() would do for pages.
		Unfortunately, it has two problems - potentially bogus
		hard errors from ext4_getblk() and leak in case when
		we get a bh that is not uptodate.  Fixed in
		"ext4_get_link(): fix breakage in RCU mode".
	f2fs_encrypted_get_link()
		safe - bails out in unsafe case
	f2fs_get_link()
		safe - page_get_link(), followed by no access of fs objects
	fuse_get_link()
		UAF, similar to one in fuse_permission(),
		but without the ->user_ns part - we only check
		->s_fs_info->fc->cached_symlinks flag.	After that it
		either uses page_get_link() or buggers off in unsafe case.
		So fix for fuse_permission() is sufficient here.
	gfs2_get_link()
		safe - bails out in unsafe case
	hostfs_get_link()
		safe - bails out in unsafe case
	kernfs_iop_get_link()
		safe - bails out in unsafe case
	nfs_get_link()
		same UAF as for nfs4_lookup_revalidate(), same fix
	ntfs_get_link()
		safe - bails out in unsafe case
	ovl_get_link()
		safe - bails out in unsafe case
	policy_get_link()
		safe - bails out in unsafe case
	proc_get_link()
		UAF (and oops) - dereferences ->pde of containing
		proc_inode, which is dropped (and field zeroed) from
		->evict_inode().  Fixed in "procfs: move dropping pde
		and pid from ->evict_inode() to ->free_inode()"
	proc_map_files_get_link()
		safe - possible hard error, without any fs objects being
		accessed, then bails out in unsafe case
	proc_ns_get_link()
		safe - fetches a field of procfs container of inode, then
		bails out in unsafe case
	proc_pid_get_link()
		safe - bails out in unsafe case
	proc_self_get_link()
		UAF - accesses the result of proc_pid_ns(), i.e.
		->s_fs_info->pid_ns.  ->s_fs_info is freed synchronously
		from ->kill_sb(), immediately after (also synchronous)
		put_pid_ns() in there.  Fixed by having that taken to
		rcu-delayed helper in "procfs: make freeing proc_fs_info
		rcu-delayed".
	proc_thread_self_get_link()
		same UAF as in proc_self_get_link(), same fix
	rawdata_get_link_abi()
		safe - bails out in unsafe case
	rawdata_get_link_data()
		safe - bails out in unsafe case
	rawdata_get_link_sha1()
		safe - bails out in unsafe case
	shmem_get_link()
		safe; essentially the same thing page_get_link() does.
	ubifs_get_link()
		safe; checks inode field, then either returns a pointer into
		containing ubifs_inode or bails out in unsafe case
	v9fs_vfs_get_link()
		safe - bails out in unsafe case
	v9fs_vfs_get_link_dotl()
		safe - bails out in unsafe case
	vboxsf_get_link()
		safe - bails out in unsafe case
	xfs_vn_get_link()
		safe - bails out in unsafe case
		NOTE: really ancient comment about recursion(!) next to
		that one.  Comment ought to go...  No idea why bother
		recalculating the symlink every time, BTW - might as
		well cache the sucker in ->i_link on the first access
		and leave freeing to the time we free the inode...
		Oh, wait - XFS doesn't free them at all, they are playing
		games with reuse...  Alternatively, they could shove
		the symlink contents in page cache, a-la e.g. NFS does.
		Anyway, well out of scope for this...

get_inode_acl:
	fuse_get_inode_acl()
		same UAF as in fuse_get_link(), except that we are
		fetching a different flag from ->s_fs_info->fc.  Same fix...
	ovl_get_inode_acl()
		safe; pretty much parallel to ovl_permission(), except
		that it calls get_cached_acl_rcu() rather than inode_permission()

