Return-Path: <linux-fsdevel+bounces-53531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068AAEFF2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3BF1884EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338FA27A92D;
	Tue,  1 Jul 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cEqUCe/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A911A0BF3
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386194; cv=none; b=gxhRvw4XSEKU/VNVmsEdH8sylee1F7MEH9B/uwgYqLDET6wHMU/LHwgRMfPli0apIL0fyr+mPkzdTY2mQBA+lBhWRvqSPpWZNRIUWOaxIQCGJGhODXFELMbLUtfdBjdWtp6wvEem98SGFgdc9Iif5UDDazM84aXWPNq5LJxcsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386194; c=relaxed/simple;
	bh=9QMkRUPmYpOrcWrZ4fgKaBDs4A3YvMn/PXmS0M3lXkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+pjPZEoqNr3HCo1/B5GQ4yEWlF7YbbALh+aa9m29mfUeKHco6ku58iByn8cE/K5Zb6fvs+imM1wr+uZovOQAukcf2rN41KgsQTcd0x785MPAFgOxtw6n/yzoeGVeGRP3mkjo2xlG1YFXL54FTdh3416VOctNWqq8hOJ7jwHBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cEqUCe/m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcdP3NID5qiPNAlxM7JXbFbul+IPKSb8VNQ4b9xBcp0=; b=cEqUCe/mY1SvMVsIMkddXFvPSK
	I/kpgyLomJZHaGj0vF24CZhiBm3jVnNzxVAXBadjwWO1Z3KmKD9JnURLr7HdsxxEC9x9eB4yB158d
	Xx7WPxPLTg8QPcoC4EtOj6PSC2zgBWckirzpNcOflvLrz0GsclrSV0SJarQiNzLZ6aulkV8mkXjg6
	FYzL/Z6aaBeo1SE5OnE6DtNGgBo0gx0MfnvMQRWchgNGH4rety5nbvdcp6FK+ZCmoAkziwoBNwSq6
	U0j/wiIAz/JbAMcyiCny/NX9o10ymVXaOOutcHCKbL6sHUvGxYQh8S+0XONJdRk8EIsYSC6bFKJ5Q
	tSjRXtag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWdYJ-00000003rvZ-45uW;
	Tue, 01 Jul 2025 16:09:48 +0000
Date: Tue, 1 Jul 2025 17:09:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fix proc_sys_compare() handling of in-lookup
 dentries
Message-ID: <20250701160947.GA1880847@ZenIV>
References: <20250630072059.GY1880847@ZenIV>
 <175127332010.565058.1144617640469023041@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175127332010.565058.1144617640469023041@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 30, 2025 at 06:48:40PM +1000, NeilBrown wrote:

> Checking the name first is definitely cleaner.  The fact that
> d_in_lookup() allows the rest to be short-circuited is neat but
> certainly deserves the comment.

	FWIW, I wonder what would be the best tree for the commit below; it's
a resurrected patch from last year, slightly updated to cover the in-lookup vs.
->d_compare().  By default it'll probably go into viro/vfs.git #work.misc...

[PATCH] documenting RCU pathwalk exposure from filesystems' POV

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 11a599387266..ce11c9bde4b3 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -41,6 +41,8 @@ algorithms work.
 
    caching/index
 
+   rcu-exposure
+
    porting
 
 Filesystem support layers
diff --git a/Documentation/filesystems/rcu-exposure.rst b/Documentation/filesystems/rcu-exposure.rst
new file mode 100644
index 000000000000..2c60f115a267
--- /dev/null
+++ b/Documentation/filesystems/rcu-exposure.rst
@@ -0,0 +1,426 @@
+===================================================================
+The ways in which RCU pathwalk can ruin filesystem maintainer's day
+===================================================================
+
+Pathname resolution fast path: the scarier conditions for filesystem code
+=========================================================================
+
+The basic safety assumption for any multithreaded OO code is that
+objects passed to a function will not have been already destroyed by
+another thread.  It may guaranteed by various mechanisms (refcounting,
+some form of exclusion, not having pointers to the object visible to other
+threads, etc.), but no matter how it's done, the caller is expected to
+have done that.
+
+Usually one wants a stronger warranty - that destructors of any objects
+passed to a function would not be called by other threads until the
+function has either done something that explicitly allows that to happen
+(e.g. dropped a reference to refcounted object that had been passed
+to it, stored a pointer in a shared data structure, etc.) or finished
+its execution.
+
+Filesystem methods **usually** can count upon such warranties regarding
+the lifetime of objects they are called to act upon.
+
+However, there is one important case where providing such warranties
+is rather costly.  On the fast path in pathname resolution (the case
+when everything we need is in VFS caches), grabbing and dropping dentry
+references for every visited directory would cause unpleasant scalability
+issues.
+
+The problem is that access patterns are heavily biased; every system call
+getting an absolute pathname will have to start at root directory, etc.
+Having each of them in effect write "I'd been here" on the same memory
+objects would cost quite a bit.
+
+To deal with that we try to keep the fast path stores-free, bumping
+no refcounts and taking no locks.  Details are described elsewhere
+(Documentation/filesystems/path-lookup.txt), but the bottom line for
+filesystems is that the methods involved in fast path of pathname
+resolution may be called with much looser warranties than usual.
+The caller deliberately does *not* take the steps that would normally
+protect the object from being torn down by another thread while the
+method is trying to work with it.  This applies not just to dentries -
+associated inodes and even the filesystem instance the object belongs
+to could be in process of getting torn down (yes, really).\ [#f0]_
+Of course, from the filesystem point of view, every call like that is
+a potential source of headache.
+
+Such unsafe method calls do get *some* warranties.  Before going into
+the details, keep in mind that
+
+* few methods are affected, and their defaults (i.e. what we get if the
+  method is left NULL) are safe.  If your filesystem does not need to
+  override any of those defaults, you are fine (there is a minor nit
+  regarding the cached fast symlinks, but that's easy to take care of).
+
+* for most of those methods there is a way to bail out and tell VFS to
+  leave the fast path and switch to holding proper references from
+  that point on.  That's what has to happen when an instance sees that it
+  can't go on without a blocking operation, but you can use the same
+  mechanism to bail out as soon as you see an unsafe call.
+
+
+Which methods are affected?
+===========================
+
+	The list of the methods that could run into that fun:
+
+========================	==================================	===================	====================
+	method			indication that the call is unsafe	unprotected objects	bailout return value
+========================	==================================	===================	====================
+->d_hash(d, ...) 		none - any call might be		d
+->d_compare(d, ...)		none - any call might be		d
+->d_revalidate(d, f)		f & LOOKUP_RCU				d			-ECHILD
+->d_manage(d, f)		f					d			-ECHILD
+->permission(i, m)		m & MAY_NOT_BLOCK			i			-ECHILD
+->get_link(d, i, ...)		d == NULL				i			ERR_PTR(-ECHILD)
+->get_inode_acl(i, t, f)	f == LOOKUP_RCU				i			ERR_PTR(-ECHILD)
+========================	==================================	===================	====================
+
+Additionally, callback set by set_delayed_call() from unsafe call of
+->get_link() will be run in the same environment; that one is usually not
+a problem, though.
+
+For the sake of completeness, three of LSM methods
+(->inode_permission(), ->inode_follow_link() and ->task_to_inode())
+might be called in similar environment, but that's a problem for LSM
+crowd, not for filesystem folks.
+
+
+Opting out
+==========
+
+To large extent a filesystem can opt out of RCU pathwalk; that loses all
+scalability benefits whenever your filesystem gets involved in pathname
+resolution, though.  If that's the way you choose to go, just make sure
+that
+
+1. any non-default ->d_revalidate(), ->permission(), ->get_link() and
+   ->get_inode_acl() instance bails out if called by RCU pathwalk (see
+   below for details).  Costs a couple of lines of boilerplate in each.
+
+2. if some symlink inodes have ->i_link set to a dynamically allocated
+   object, that object won't be freed without an RCU delay.  Anything
+   coallocated with inode is fine, so's anything freed from ->free_inode().
+   Usually comes for free, just remember to avoid freeing directly
+   from ->destroy_inode().
+
+3. any ->d_hash() and ->d_compare() instances (if you have those) do
+   not access any filesystem objects.
+
+4. there's no ->d_manage() instances in your filesystem.
+
+If your case does not fit the above, the easy opt-out is not for you.
+If so, you'll have to keep reading...
+
+
+What is guaranteed and what is required?
+========================================
+
+Any method call is, of course, required not to crash - no stepping on
+freed memory, etc.  All of the unsafe calls listed above are done under
+rcu_read_lock(), so they are not allowed to block.  Further requirements
+vary between the methods.
+
+Before going through the list of affected methods, several notes on
+the things that *are* guaranteed:
+
+* if a reference to struct dentry is passed to such call, it will
+  not be freed until the method returns.  The same goes for a reference to
+  struct inode and to struct super_block pointed to by ->d_sb or ->i_sb
+  members of dentry and inode respectively.  Any of those might be in
+  process of being torn down or enter such state right under us;
+  the entire point of those unsafe calls is that we make them without
+  telling anyone they'd need to wait for us.
+
+* following ->d_parent and ->d_inode of such dentries is fine,
+  provided that it's done by READ_ONCE() (for ->d_inode the preferred
+  form is d_inode_rcu(dentry)).  The value of ->d_parent is never going
+  to be NULL and it will again point to a struct dentry that will not be
+  freed until the method call finishes.  The value of ->d_inode might
+  be NULL; if non-NULL, it'll be pointing to a struct inode that will
+  not be freed until the method call finishes.
+
+* none of the inodes passed to an unsafe call could have reached
+  fs/inode.c:evict() before the caller grabbed rcu_read_lock().
+
+* for inodes 'not freed' means 'not entered ->free_inode()', so
+  anything that won't be destroyed until ->free_inode() is safe to access.
+  Anything synchronously destroyed in ->evict_inode() or ->destroy_inode()
+  is not safe; however, one can count upon the call_rcu() callbacks
+  issued in those yet to be entered.  Note that unlike dentries and
+  superblocks, inodes are embedded into filesystem-private objects;
+  anything stored directly in the containing object is safe to access.
+
+* for dentries anything destroyed by ->d_prune() (synchronously or
+  not) is not safe; the same goes for the things synchronously destroyed
+  by ->d_release().  However, call_rcu() callbacks issued in ->d_release()
+  are yet to be entered.
+
+* for superblocks we can count upon call_rcu() callbacks issued
+  from inside the ->kill_sb() (including the ones issued from
+  ->put_super()) yet to be entered.  You can also count upon
+  ->s_user_ns still being pinned and ->s_security still not
+  freed.
+
+* NOTE: we **can not** count upon the things like ->d_parent
+  being positive (or a directory); a race with rename()+rmdir()+mknod()
+  and you might find a FIFO as parent's inode.  NULL is even easier -
+  just have the dentry and its ex-parent already past dentry_kill()
+  (which is a normal situation for eviction on memory pressure) and there
+  you go.  Normally such pathologies are prevented by the locking (and
+  dentry refcounting), but... the entire point of that stuff is to avoid
+  informing anyone that we are there, so those mechanisms are bypassed.
+  What's more, if dentry is not pinned by refcount, grabbing its ->d_lock
+  will *not* suffice to prevent that kind of mess - the scenario with
+  eviction by memory pressure won't be prevented by that; you might have
+  grabbed ->d_lock only after the dentry_kill() had released it, and
+  at that point ->d_parent still points to what used to be the parent,
+  but there's nothing to prevent its eviction.
+
+
+->d_compare()
+-------------
+
+For ->d_compare() we just need to make sure it won't crash when called
+for dying dentry - an incorrect return value won't harm the caller in
+such case.  False positives and false negatives alike - the callers take
+care of that.  To be pedantic, make that "false positives do not cause
+problems unless they have ->d_manage()", but ->d_manage() is present
+only on autofs and there's no autofs ->d_compare() instances.\ [#f1]_
+
+There is no indication that ->d_compare() is called in RCU mode;
+the majority of callers are such, anyway, so we need to cope with that.
+VFS guarantees that dentry won't be freed under us; the same goes for
+the superblock pointed to by its ->d_sb.  Name points to memory object
+that won't get freed under us and length does not exceed the size of
+that object.  The contents of that object is *NOT* guaranteed to be
+stable; d_move() might race with us, modifying the name.  However, in
+that case we are free to return an arbitrary result - the callers will
+take care of both false positives and false negatives in such case.
+The name we are comparing dentry with (passed in qstr) is stable,
+thankfully...
+
+If we need to access any other data, it's up to the filesystem
+to protect it.  In practice it means that destruction of fs-private part
+of superblock (and possibly unicode tables hanging off it, etc.) might
+need to be RCU-delayed.
+
+*IF* you want the behaviour that varies depending upon the parent
+directory, you get to be very careful with READ_ONCE() and watch out
+for the object lifetimes.
+
+A dying dentry is not the only unpleasantness we can run into - it's
+possible to run into an in-lookup dentry.  If ->d_compare() instance
+does not care about anything we might set up during ->lookup(), this
+is not a problem; if it does, the things get delicate.  Only one in-tree
+instance is pathological to that extent (proc_sys_compare()).  False
+positives are permissible in that case; false negatives are not.
+
+Basically, if the things get that tricky, ask for help.
+Currently there are two such instances in the tree - proc_sys_compare()
+and generic_ci_d_compare().  Both are... special.
+
+->d_hash()
+----------
+
+For ->d_hash() on a dying dentry we are free to report any hash
+value; the only extra requirement is that we should not return stray
+hard errors.  In other words, if we return anything other than 0 or
+-ECHILD, we'd better make sure that this error would've been correct
+before the parent started dying.  Since ->d_hash() error reporting is
+usually done to reject unacceptable names (too long, contain unsuitable
+characters for this filesystem, etc.), that's really not a problem -
+hard errors depend only upon the name, not the parent.
+
+Again, VFS guarantees that freeing of dentry and of the superblock
+pointed to by dentry->d_sb won't happen under us.  The name passed to
+us (in qstr) is stable.  If you need anything beyond that, you are
+in the same situation as with ->d_compare().  Might want to RCU-delay
+freeing private part of superblock (if that's what we need to access),
+might want the same for some objects hanging off that (unicode tables,
+etc.).  If you need something beyond that - ask for help.
+
+
+->d_revalidate()
+----------------
+
+For this one we do have an indication of call being unsafe -
+flags & LOOKUP_RCU.  With ->d_revalidate we are always allowed to bail
+out and return -ECHILD; that will have the caller drop out of RCU mode.
+We definitely need to do that if revalidate would require any kind of IO,
+mutex-taking, etc.; we can't block in RCU mode.
+
+Quite a few instances of ->d_revalidate() simply treat LOOKUP_RCU
+in flags as "return -ECHILD and be done with that"; it's guaranteed to
+do the right thing, but you lose the benefits of RCU pathwalks whenever
+you run into such dentry.
+
+Same as with the previous methods, we are guaranteed that
+dentry and dentry->d_sb won't be freed under us.  We are also guaranteed
+that ->d_parent (which is *not* stable, so use READ_ONCE) points to a
+struct dentry that won't get freed under us.  As always with ->d_parent,
+it's not NULL - for a detached dentry it will point to dentry itself.
+d_inode_rcu() of dentry and its parent will be either NULL or will
+point to a struct inode that won't get freed under us.  Anything beyond
+than that is not guaranteed.  We may find parent to be negative - it can
+happen if we race with d_move() and removal of old parent.  In that case
+just return -ECHILD and be done with that.
+
+On non-RCU side you could use dget_parent() instead - that
+would give a positive dentry and its ->d_inode would remain stable.
+dget_parent() has to be paired with dput(), though, so it's not usable
+in RCU mode.
+
+If you need fs-private objects associated with dentry, its parent
+inode(s) or superblock - see the general notes above on how to access
+those.
+
+
+->d_manage()
+------------
+
+Can be called in RCU mode; gets an argument telling it if it has
+been called so.  Pretty much autofs-only; for everyone's sanity sake,
+don't inflict more of those on the kernel.  Definitely don't do that
+without asking first...
+
+
+->permission()
+--------------
+
+Can be called in RCU mode; that is indicated by MAY_NOT_BLOCK
+in mask, and it can only happen for MAY_EXEC checks on directories.
+In RCU mode it is not allowed to block, and it is allowed to bail out
+by returning -ECHILD.  It might be called for an inode that is getting
+torn down, possibly along with its filesystem.  Errors other than -ECHILD
+should only be returned if they would've been returned in non-RCU mode;
+several instances in procfs did (prior to 6.8-rc6) run afoul of that one.
+That's an instructive example, BTW - what happens is that proc_pid_permission()
+uses proc_get_task() to find the relevant process.  proc_get_task()
+uses PID reference stored in struct proc_inode our inode is embedded
+into; inode can't have been freed yet, so fetching ->pid member in that
+is safe.  However, using the value you've fetched is a different story
+- proc_evict_inode() would have passed it to put_pid() and replaced
+it with NULL.  Unsafe caller has no way to tell if that is happening
+right under it.  Solution: stop zeroing ->pid in proc_evict_inode()
+and move put_pid() from proc_pid_evict_inode() to proc_free_inode().
+That's not all that is needed (there's access to procfs-private part of
+superblock as well), but it does make a good example of how such stuff
+can be dealt with.
+
+Note that idmap argument is safe on all calls - its destruction
+is rcu-delayed.
+
+The amount of headache is seriously reduced (for now) by the fact
+that a lot of instances boil down to generic_permission() (which will
+do the right thing in RCU mode) when mask is MAY_EXEC | MAY_NOT_BLOCK.
+If we ever extend RCU mode to other ->permission() callers, the thing will
+get interesting; that's not likely to happen, though, unless access(2)
+goes there [this is NOT a suggestion, folks].
+
+
+->get_link()
+------------
+
+Again, this can be called in RCU mode.  Even if your ->d_revalidate()
+always returns -ECHILD in RCU mode and kicks the pathwalk out of it,
+you can't assume that ->get_link() won't be reached.\ [#f2]_
+
+NULL dentry argument is an indicator of unsafe call; if you can't handle
+it, just return ERR_PTR(-ECHILD).  Any allocations you need to do (and
+with this method you really might need that) should be done with GFP_ATOMIC
+in the unsafe case.
+
+Whatever you pass to set_delayed_call() is going to be called
+in the same mode as ->get_link() itself; not a problem for most of the
+instances.  The string you return needs to stay there until the
+callback gets called or, if no callback is set, until at least the
+freeing of inode.  As usual, for an unsafe call the inode might be
+in process of teardown, possibly along with the hosting filesystem.
+The usual considerations apply.  The same, BTW, applies to whatever
+you set in ->i_link - it must stay around at least until ->free_inode().
+
+
+->get_inode_acl()
+-----------------
+
+Very limited exposure for that one - unsafe call is possible
+only if you explicitly set ACL_DONT_CACHE as cached ACL value.
+Only two filesystems (fuse and overlayfs) even bother.  Unsafe call
+is indicated by explicit flag (the third argument of the method),
+bailout is done by returning ERR_PTR(-CHILD) and the usual considerations
+apply for any access to data structures you might need to do.
+
+.. rubric:: Footnotes
+
+.. [#f0]
+
+  The fast path of pathname resolution really can run into a dentry on
+  a filesystem that is getting shut down.
+
+  Here's one of the scenarios for that to happen:
+
+	1. have two threads sharing fs_struct chdir'ed on that filesystem.
+	2. lazy-umount it, so that the only thing holding it alive is
+	   cwd of these threads.
+	3. the first thread does relative pathname resolution
+	   and gets to e.g. ->d_hash().  It's holding rcu_read_lock().
+	4. at the same time the second thread does fchdir(), moving to
+	   different directory.
+
+  In fchdir(2) we get to set_fs_pwd(), which set the current directory
+  to the new place and does mntput() on the old one.  No RCU delays here,
+  we calculate the refcount of that mount and see that we are dropping
+  the last reference.  We make sure that the pathwalk in progress in
+  the first thread will fail when it comes to legitimize_mnt() and do this
+  (in mntput_no_expire())::
+
+	init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
+	if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
+		return;
+
+  As we leave the syscall, we have __cleanup_mnt() run; it calls
+  cleanup_mnt() on our mount, which hits deactivate_super().  That was
+  the last reference to superblock.
+
+  Voila - we have a filesystem shutdown right under the nose of
+  a thread running in ->d_hash() of something on that filesystem.
+  Mutatis mutandis, one can arrange the same for other methods called
+  by rcu pathwalk.
+
+  It's not easy to hit (especially if you want to get through the
+  entire ->kill_sb() before the first thread gets through ->d_hash()),
+  and it's probably impossible on the real hardware; on KVM it might be
+  borderline doable.  However, it is possible and I would not swear that
+  other ways of arranging the same thing are equally hard to hit.
+
+  The bottom line: methods that can be called in RCU mode need to be
+  careful about the per-superblock objects destruction.
+
+.. [#f1]
+
+  Some callers prevent being called for dying dentry (holding ->d_lock
+  and having verified !d_unhashed() or finding it in the list of inode's
+  aliases under ->i_lock).  For those the scenario in question simply
+  cannot arise.
+
+  Some follow the match with lockref_get_not_dead() and treat the failure
+  as mismatch.  That takes care of false positives, and false negatives
+  on dying dentry are still correct - we simply pretend to have lost
+  the race.
+
+  The only caller that does not fit into the classes above is
+  __d_lookup_rcu_op_compare().  There we sample ->d_seq and verify
+  !d_unhashed() before calling ->d_compare().  That is not enough to
+  prevent dentry from starting to die right under us; however, the
+  sampled value of ->d_seq will be rechecked when the caller gets to
+  step_into(), so for a false positive we will end up with a mismatch.
+  The corner case around ->d_manage() is due to the handle_mounts()
+  done before step_into() gets to ->d_seq validation...
+
+.. [#f2]
+
+  binding a symlink on top of a regular file on another filesystem is
+  possible and that's all it takes for RCU pathwalk to get there.

