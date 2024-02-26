Return-Path: <linux-fsdevel+bounces-12864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79967867FE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EF1C23D11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221D12F395;
	Mon, 26 Feb 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8AFbkXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1F1DFF7;
	Mon, 26 Feb 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972438; cv=none; b=Dz3DTJdlDl9QwkZu+yrdZz8ntYulpaSaz8JDzRWTxbKt+mgrgbKCKvcQJe9sjLAr7ic3jvu67Kf0yZPUQxak/aUiaYO2M1QrA1YSYHUy9GGxDse6GTednj9TWCd4l1cNkPuZ0z60/tXYv8WNH+Gj6dEbM6dWK4pOQdcdo/HMcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972438; c=relaxed/simple;
	bh=0okxd8ljvtZkXyZauao/N9ilYcVVbU9HDi2DuEMAQxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoULjH18n0B6l4QU81gixl4PzI194JoNRpN5GocNtkysqaPry/iqn40A3/UnPcGdhsKOeizd8mCzGXuUvmIqd/uMuiDZhqxaap9YfOEc260jJITViONM1Lm73nlB544kcA97Ms8LcnE4TKOPuSnj4UmFW95OcpWVgoY3F2RN+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8AFbkXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1356DC433F1;
	Mon, 26 Feb 2024 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708972438;
	bh=0okxd8ljvtZkXyZauao/N9ilYcVVbU9HDi2DuEMAQxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8AFbkXClC5RgiXilOQ6gKBpXrCJ/CS0vBJVrE/8PVqUX08jRpdoQtNb2urXaoZJC
	 RLAFpcajK4nwaaL600Oi4EGjU0AdukTAqCwU6uZa+BYb+jeHngPgwdz76ZxLvTCBAs
	 a9Ggp+XN0QLNPVnymhi42CXEdCyQbs3F5gD1kv7BHTy6Hkm8fPQEJ4K/MRdFp+F+pv
	 EFbympocussYnMeg9IfWbIXgk8qLAEKo8erGV57OPXo+9hfEYhzYK4sCWzdZxPQip8
	 hnxCCijwz3YIrPam2fmWLGBQh5aqArRDzjQUDrpGzvOMRCZnxcwAgD2Yb8TPF956+y
	 uTTTRZ1yRpr0w==
Date: Mon, 26 Feb 2024 13:35:12 -0500
From: Al Viro <viro@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][v2] documentation on filesystem exposure to RCU pathwalk from
 fs maintainers' POV
Message-ID: <ZdzZ4LVrCie2MF3H@duke.home>
References: <Zdu58Jevui1ySBqa@duke.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdu58Jevui1ySBqa@duke.home>

On Sun, Feb 25, 2024 at 05:06:40PM -0500, Al Viro wrote:
> 	The text below is a rough approximation to what should, IMO,
> end up in Documentation/filesystems/rcu-exposure.rst.  It started
> as a part of audit notes.  Intended target audience of the text is
> filesystem maintainers and/or folks who are reviewing fs code;
> I hope the current contents is already useful to an extent, but
> I'm pretty certain that it needs more massage before it could
> go into the tree.
> 
> 	Please, read and review - comments and suggestions would be
> very welcome, both for contents and for markup - I'm *not* familiar
> with ReST or the ways it's used in the kernel (in particular, footnotes
> seem to get lost in PDF).

Updated variant follows.  Changes since the previous:
* beginning has been rewritten
* typos spotted by Randy should be fixed
* dumb braino in "opt out" part fixed (->d_automount is irrelevant, it's
->d_manage one needs to watch out for)
* a stale bit in discussion of ->permission() ("currently (6.5) run afoul")
updated (to "did (prior to 6.8-rc6) run afoul").
* I gave up on ReST footnotes and did something similar manually.

The thing that worries me is the balance in the background part -
keeping it detailed enough to explain what's going on vs.
keeping it short enough so the readers wouldn't get too scared before
they get to "you might have no exposure and you might be able to
opt out" part.

Suggestions and comments would be welcome.

===================================================================
The ways in which RCU pathwalk can ruin filesystem maintainer's day
===================================================================

The problem: exposure of filesystem code to lockless environment
================================================================

Filesystem methods can usually count upon VFS-provided warranties
regarding the stability of objects they are called to act upon.

The kernel is inherently multi-threaded environment and the objects one
thread works with might be accessed by other threads to an extent that
depends upon the locking, but there is a pretty fundamental expectation:
if somebody calls your function and passes a reference to some object as
an argument, you can expect that this object will not be destroyed by
another thread right under your nose.  Arranging for that is the callers'
responsibility and the common way to provide such warranties is some form
of refcounting and/or locking.

At the very least, filesystem methods normally expect the files/dentries/inodes/superblocks
involved will live throughout the operation - their destructors will not
be called by another thread while the method is executed.

However, there is a nasty exception to that rule.  The fast path in
pathname resolution (the case when everything we need is in VFS caches)
tries very hard to operate without stores to shared data objects.

The problem is that access patterns are heavily biased; every system call
getting an absolute pathname will have to start at root directory, etc.
Having each of them in effect write "I'd been here" on the same memory
objects would cost quite a bit.

As the result, we try to keep the fast path stores-free, bumping
no refcounts and taking no locks.  Details are described elsewhere
(Documentation/filesystems/path-lookup.txt), but the bottom line for
filesystems is that the methods involved in fast path of pathname
resolution may be called with much looser warranties than usual.

And "looser" might be an understatement - we are talking about having
to work with objects that might be in process of being torn down by
another thread, possibly all the way down to the filesystem instance
that object lives on (yes, really - see [0] for details).  Of course,
from the filesystem POV every call like that is a potential source of
headache.

Such unsafe method calls do get *some* warranties.  Before going into
the details, keep in mind that

* few methods are affected and their defaults (i.e. what we get if the
  method left NULL) are safe.  If your filesystem does not need to override
  any of those defaults, you are fine (there is a minor nit regarding the
  cached fast symlinks, but that's easy to take care of).

* for most of those methods there is a way to bail out and tell VFS to
  piss off and come back when it holds proper references.  That's what
  has to happen when an instance sees that it can't go on without
  a blocking operation, but you can use the same mechanism to bail out
  as soon as you see an unsafe call.


Which methods are affected?
===========================

	The list of the methods that could run into that fun:

========================	==================================	===================	====================
	method			indication that the call is unsafe	unprotected objects	bailout return value
========================	==================================	===================	====================
->d_hash(d, ...) 		none - any call might be		d
->d_compare(d, ...)		none - any call might be		d
->d_revalidate(d, f)		f & LOOKUP_RCU				d			-ECHILD
->d_manage(d, f)		f					d			-ECHILD
->permission(i, m)		m & MAY_NOT_BLOCK			i			-ECHILD
->get_link(d, i, ...)		d == NULL				i			ERR_PTR(-ECHILD)
->get_inode_acl(i, t, f)	f == LOOKUP_RCU				i			ERR_PTR(-ECHILD)
========================	==================================	===================	====================

Additionally, callback set by set_delayed_call() from unsafe call of
->get_link() will be run in the same environment; that one is usually not
a problem, though.

For the sake of completeness, three of LSM methods
(->inode_permission(), ->inode_follow_link() and ->task_to_inode())
might be called in similar environment, but that's a problem for LSM
crowd, not for filesystem folks.


Opting out
==========

To large extent a filesystem can opt out of RCU pathwalk; that loses all
scalability benefits whenever your filesystem gets involved in pathname
resolution, though.  If that's the way you choose to go, just make sure
that

1. any non-default ->d_revalidate(), ->permission(), ->get_link() and
->get_inode_acl() instance bails out if called by RCU pathwalk (see below
for details).  Costs a couple of lines of boilerplate in each.

2. if some symlink inodes have ->i_link set to a dynamically allocated
object, that object won't be freed without an RCU delay.  Anything
coallocated with inode is fine, so's anything freed from ->free_inode().
Usually comes for free, just remember to avoid freeing directly
from ->destroy_inode().

3. any ->d_hash() and ->d_compare() instances (if you have those) do
not access any filesystem objects.

4. there's no ->d_manage() instances in your filesystem.

If your case does not fit the above, the easy opt-out is not for you.
If so, you'll have to keep reading...


What is guaranteed and what is required?
========================================

Any method call is, of course, required not to crash - no stepping on
freed memory, etc.  All of the unsafe calls listed above are done under
rcu_read_lock(), so they are not allowed to block.  Further requirements
vary between the methods.

Before going through the list of affected methods, several notes on
the things that *are* guaranteed:

* if a reference to struct dentry is passed to such call, it will
  not be freed until the method returns.  The same goes for a reference to
  struct inode and to struct super_block pointed to by ->d_sb or ->i_sb
  members of dentry and inode respectively.  Any of those might be in
  process of being torn down or enter such state right under us;
  the entire point of those unsafe calls is that we make them without
  telling anyone they'd need to wait for us.

* following ->d_parent and ->d_inode of such dentries is fine,
  provided that it's done by READ_ONCE() (for ->d_inode the preferred
  form is d_inode_rcu(dentry)).  The value of ->d_parent is never going
  to be NULL and it will again point to a struct dentry that will not be
  freed until the method call finishes.  The value of ->d_inode might
  be NULL; if non-NULL, it'll be pointing to a struct inode that will
  not be freed until the method call finishes.

* none of the inodes passed to an unsafe call could have reached
  fs/inode.c:evict() before the caller grabbed rcu_read_lock().

* for inodes 'not freed' means 'not entered ->free_inode()', so
  anything that won't be destroyed until ->free_inode() is safe to access.
  Anything synchronously destroyed in ->evict_inode() or ->destroy_inode()
  is not safe; however, one can count upon the call_rcu() callbacks
  issued in those yet to be entered.  Note that unlike dentries and
  superblocks, inodes are embedded into filesystem-private objects;
  anything stored directly in the containing object is safe to access.

* for dentries anything destroyed by ->d_prune() (synchronously or
  not) is not safe; the same goes for the things synchronously destroyed
  by ->d_release().  However, call_rcu() callbacks issued in ->d_release()
  are yet to be entered.

* for superblocks we can count upon call_rcu() callbacks issued
  from inside the ->kill_sb() (including the ones issued from
  ->put_super()) yet to be entered.  You can also count upon
  ->s_user_ns still being pinned and ->s_security still not
  freed.

* NOTE: we **can not** count upon the things like ->d_parent
  being positive (or a directory); a race with rename()+rmdir()+mknod()
  and you might find a FIFO as parent's inode.  NULL is even easier -
  just have the dentry and its ex-parent already past dentry_kill()
  (which is a normal situation for eviction on memory pressure) and there
  you go.  Normally such pathologies are prevented by the locking (and
  dentry refcounting), but... the entire point of that stuff is to avoid
  informing anyone that we are there, so those mechanisms are bypassed.
  What's more, if dentry is not pinned by refcount, grabbing its ->d_lock
  will *not* suffice to prevent that kind of mess - the scenario with
  eviction by memory pressure won't be prevented by that; you might have
  grabbed ->d_lock only after the dentry_kill() had released it, and
  at that point ->d_parent still points to what used to be the parent,
  but there's nothing to prevent its eviction.


->d_compare()
-------------

For ->d_compare() we just need to make sure it won't crash
when called for dying dentry - an incorrect return value won't harm the
caller in such case.  False positives and false negatives alike - the
callers take care of that.  To be pedantic, make that "false positives
do not cause problems unless they have ->d_manage()", but ->d_manage()
is present only on autofs and there's no autofs ->d_compare() instances.
See [1] for details, if you are curious.

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


->d_hash()
----------

For ->d_hash() on a dying dentry we are free to report any hash
value; the only extra requirement is that we should not return stray
hard errors.  In other words, if we return anything other than 0 or
-ECHILD, we'd better make sure that this error would've been correct
before the parent started dying.  Since ->d_hash() error reporting is
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


->d_revalidate()
----------------

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
point to a struct inode that won't get freed under us.  Anything beyond
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


->d_manage()
------------

Can be called in RCU mode; gets an argument telling it if it has
been called so.  Pretty much autofs-only; for everyone's sanity sake,
don't inflict more of those on the kernel.  Definitely don't do that
without asking first...


->permission()
--------------

Can be called in RCU mode; that is indicated by MAY_NOT_BLOCK
in mask, and it can only happen for MAY_EXEC checks on directories.
In RCU mode it is not allowed to block, and it is allowed to bail out
by returning -ECHILD.  It might be called for an inode that is getting
torn down, possibly along with its filesystem.  Errors other than -ECHILD
should only be returned if they would've been returned in non-RCU mode;
several instances in procfs did (prior to 6.8-rc6) run afoul of that one.
That's an instructive example, BTW - what happens is that proc_pid_permission()
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


->get_link()
------------

Again, this can be called in RCU mode.  Even if your ->d_revalidate()
always returns -ECHILD in RCU mode and kicks the pathwalk out of it,
you can't assume that ->get_link() won't be reached (see [2] for
details).

NULL dentry argument is an indicator of unsafe call; if you can't handle
it, just return ERR_PTR(-ECHILD).  Any allocations you need to do (and
with this method you really might need that) should be done with GFP_ATOMIC
in the unsafe case.

Whatever you pass to set_delayed_call() is going to be called
in the same mode as ->get_link() itself; not a problem for most of the
instances.  The string you return needs to stay there until the
callback gets called or, if no callback is set, until at least the
freeing of inode.  As usual, for an unsafe call the inode might be
in process of teardown, possibly along with the hosting filesystem.
The usual considerations apply.  The same, BTW, applies to whatever
you set in ->i_link - it must stay around at least until ->free_inode().


->get_inode_acl()
-----------------

Very limited exposure for that one - unsafe call is possible
only if you explicitly set ACL_DONT_CACHE as cached ACL value.
Only two filesystems (fuse and overlayfs) even bother.  Unsafe call
is indicated by explicit flag (the third argument of the method),
bailout is done by returning ERR_PTR(-CHILD) and the usual considerations
apply for any access to data structures you might need to do.


Footnotes
=========

[0]  The fast path of pathname resolution really can run into a dentry on
a filesystem that is getting shut down.

Here's one of the scenarios for that to happen:

	1. have two threads sharing fs_struct chdir'ed on that filesystem.
	2. lazy-umount it, so that the only thing holding it alive is
	   cwd of these threads.
	3. the first thread does relative pathname resolution
	   and gets to e.g. ->d_hash().  It's holding rcu_read_lock().
	4. at the same time the second thread does fchdir(), moving to
	   different directory.

In fchdir(2) we get to set_fs_pwd(), which set the current directory
to the new place and does mntput() on the old one.  No RCU delays here,
we calculate the refcount of that mount and see that we are dropping
the last reference.  We make sure that the pathwalk in progress in
the first thread will fail when it comes to legitimize_mnt() and do this
(in mntput_no_expire())::

	init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
	if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
		return;

As we leave the syscall, we have __cleanup_mnt() run; it calls cleanup_mnt()
on our mount, which hits deactivate_super().  That was the last reference to
superblock.

Voila - we have a filesystem shutdown right under the nose of a thread
running in ->d_hash() of something on that filesystem.  Mutatis mutandis,
one can arrange the same for other methods called by rcu pathwalk.

It's not easy to hit (especially if you want to get through the
entire ->kill_sb() before the first thread gets through ->d_hash()),
and it's probably impossible on the real hardware; on KVM it might be
borderline doable.  However, it is possible and I would not swear that
other ways of arranging the same thing are equally hard to hit.

The bottom line: methods that can be called in RCU mode need to
be careful about the per-superblock objects destruction.

[1]

Some callers prevent being called for dying dentry (holding ->d_lock and
having verified !d_unhashed() or finding it in the list of inode's aliases
under ->i_lock).  For those the scenario in question simply cannot arise.

Some follow the match with lockref_get_not_dead() and treat the failure
as mismatch.  That takes care of false positives, and false negatives on
dying dentry are still correct - we simply pretend to have lost the race.

The only caller that does not fit into the classes above is
__d_lookup_rcu_op_compare().  There we sample ->d_seq and verify
!d_unhashed() before calling ->d_compare().  That is not enough to
prevent dentry from starting to die right under us; however, the sampled
value of ->d_seq will be rechecked when the caller gets to step_into(),
so for a false positive we will end up with a mismatch.  The corner case
around ->d_manage() is due to the handle_mounts() done before step_into()
gets to ->d_seq validation...

[2]

binding a symlink on top of a regular file on another filesystem is possible
and that's all it takes for RCU pathwalk to get there.

