Return-Path: <linux-fsdevel+bounces-2469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B847E63AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AF92811D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1AD2ED;
	Thu,  9 Nov 2023 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EKkqYyct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A73D289
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:19:34 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530326A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=viMKCkXDcFD7MSOzCXKVTK3wO58oGiXQaMHvSqXUpUc=; b=EKkqYyct/HanAt/WSRPIkJXlwQ
	yYT4xwV0o+MLCZ99wUAxRNTSYYFsJcflP1LebG8VkZ1WsbE0oIaGujDz+zWC193zYePzF8jJGB0KQ
	EnrKmyUKg7xHK/ShLcyYkNilUK+5GRK8uI4gUsNeBFu1LftKgsirss+71S9RSNBWrV9Jdr4o8Z/jm
	d4XFXy1rpFPCtROTeFLhlhPOQTLRDuVIef0rGMcFylIClV2dmV3814KsHt889xTo5bI/9ZYbl8lUb
	Xxmo9UNzLPdRQUhoprWVL+HVOvOS7TTYtEO0ZHIw7cSopRz0Sy3dGixEDUZyBP6ytWYXde/L+mhkO
	N5eBALbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yO4-00DLh7-1G;
	Thu, 09 Nov 2023 06:19:32 +0000
Date: Thu, 9 Nov 2023 06:19:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [RFC][PATCHSET v2] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231109061932.GA3181489@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231105195416.GA2771969@ZenIV>
 <20231106055353.GT1957730@ZenIV>
 <20231107020805.GA2940624@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107020805.GA2940624@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

	The series below is the fallout of trying to document the dentry
refcounting and life cycle - basically, getting rid of the bits that
had been too subtle and ugly to write them up.

	Results so far:
* -136LoC (-170LoC not counting the additions in D/f/porting ;-)
* considerably simpler locking for __dentry_kill()
* fast_dput() is pretty much "dput() sans killing dentry; returns true if
we are done, false - if dentry needs killing (in which case dentry will
be left locked and refcount is known to be 0).
* retain_dentry() not messing with refcounting - called with refcount 0
and ->d_lock held, returns whether we want the dentry retained in cache.
* rules for shrink lists are much simpler now - to_shrink_list() puts
a locked dentry with zero refcount into a shrink list, no need to guarantee
that filesystem containing that dentry won't get shut down before we get
to eventual shrink_dentry_list() - it would do the right thing.
* ->d_iput() and ->d_release() no longer have weird corner cases when they
could get called with parent already killed.  That happened to be avoided
in the cases where in-kernel instances would bother to work with the parent,
but that used to be very brittle and convoluted.  Now it's "parent is kept
pinned until __dentry_kill() of child is done".
* a bunch of other subtle shit is gone (e.g. the logics in shrink_lock_dentry()
had rather subtle corner cases, with convoluted reasons why they won't break
things - except that in some cases they would, etc.)

	This stuff lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache2
individual patches are in followups.  Help with reviewing and testing would
be very welcome - it seems to survive the local beating, but it definitely
needs more.

Shortlog:
Al Viro (22):
      struct dentry: get rid of randomize_layout idiocy
      switch nfsd_client_rmdir() to use of simple_recursive_removal()
      coda_flag_children(): cope with dentries turning negative
      dentry: switch the lists of children to hlist
      centralize killing dentry from shrink list
      get rid of __dget()
      shrink_dentry_list(): no need to check that dentry refcount is marked dead
      fast_dput(): having ->d_delete() is not reason to delay refcount decrement
      fast_dput(): handle underflows gracefully
      fast_dput(): new rules for refcount
      __dput_to_list(): do decrement of refcount in the callers
      Make retain_dentry() neutral with respect to refcounting
      __dentry_kill(): get consistent rules for victim's refcount
      dentry_kill(): don't bother with retain_dentry() on slow path
      Call retain_dentry() with refcount 0
      fold the call of retain_dentry() into fast_dput()
      don't try to cut corners in shrink_lock_dentry()
      fold dentry_kill() into dput()
      to_shrink_list(): call only if refcount is 0
      switch select_collect{,2}() to use of to_shrink_list()
      d_prune_aliases(): use a shrink list
      __dentry_kill(): new locking scheme

Diffstat:
 Documentation/filesystems/porting.rst     |  34 +++
 arch/powerpc/platforms/cell/spufs/inode.c |   5 +-
 fs/afs/dynroot.c                          |   5 +-
 fs/autofs/expire.c                        |   7 +-
 fs/ceph/dir.c                             |   2 +-
 fs/ceph/mds_client.c                      |   2 +-
 fs/coda/cache.c                           |   9 +-
 fs/dcache.c                               | 409 ++++++++++--------------------
 fs/libfs.c                                |  45 ++--
 fs/nfsd/nfsctl.c                          |  70 +----
 fs/notify/fsnotify.c                      |   2 +-
 fs/tracefs/inode.c                        |  34 +--
 include/linux/dcache.h                    |  22 +-
 13 files changed, 255 insertions(+), 391 deletions(-)

Patch description follows:

	Part 1 - preparations

01/22) struct dentry: get rid of randomize_layout idiocy.
	This is beyond ridiculous.  There is a reason why that thing
is cacheline-aligned...

02/22) nfsd_client_rmdir() and its gut open-code simple_recursive_removal();
converting to calling that cleans the things up in there *and* reduces
the amount of places where we touch the list of children, which simplifies
the work later in the series.

03/22) more fun caught while looking at the places that go through the
lists of children: coda_flag_children() assumes that ->d_lock on parent
is enough to prevent children going negative.  Ain't so...

04/22) switch the lists of children to hlist.  We never bother with
accessing the list tail and using hlist saves us a pointer per each
dentry.  Besides, it ends up more readable that way.  Fields used to hold
the lists got renamed - d_children/d_sib instead of d_subdirs/d_child.
Yes, any out-of-tree code that works with the lists of children gets
loudly broken; not hard to fix.

05/22) centralize killing dentry from shrink list
There are identical pieces of code in shrink_dentry_list() and
shrink_dcache_for_umount(); they would require identical massage through
the series below, unifying them into an inlined helper reduces the amount
of noise.

06/22) get rid of __dget()
fold into the sole remaining caller

07/22) shrink_dentry_list(): no need to check that dentry refcount is
marked dead.  We won't see DCACHE_MAY_FREE on anything that is *not*
dead and checking d_flags is just as cheap as checking refcount.

	Part 2 - massage of dput() and friends

08/22) fast_dput(): having ->d_delete() is not reason to delay refcount
decrement.
	->d_delete() is a way for filesystem to tell that dentry is not
worth keeping cached.  It is not guaranteed to be called every time a dentry
has refcount drop down to zero; it is not guaranteed to be called before
dentry gets evicted.  In other words, it is not suitable for any kind
of keeping track of dentry state.
	None of the in-tree filesystems attempt to use it that way,
fortunately.
	So the contortions done by fast_dput() (as well as dentry_kill())
are not warranted.  fast_dput() certainly should treat having ->d_delete()
instance as "can't assume we'll be keeping it", but that's not different
from the way we treat e.g. DCACHE_DONTCACHE (which is rather similar
to making ->d_delete() returns true when called).

09/22) fast_dput(): handle underflows gracefully.
	If refcount is less than 1, we should just warn, unlock
dentry and return true, so that the caller doesn't try to do anything
else.
	Taking care of that leaves the rest of "lockref_put_return() has
failed" case equivalent to "decrement refcount and rejoin the normal
slow path after the point where we grab ->d_lock".

10/22) fast_dput(): new rules for refcount.
	Currently the "need caller to do more work" path in fast_dput()
has refcount decremented, then, with ->d_lock held and refcount verified
to have reached 0 fast_dput() forcibly resets the refcount to 1.
	Move that resetting refcount to 1 into the callers; later in
the series it will be massaged out of existence.

11/22) __dput_to_list(): do decrement of refcount in the callers
... and rename it to to_shrink_list(), seeing that it no longer
does dropping any references.

12/22) make retain_dentry() neutral with respect to refcounting.
It used to decrement refcount if and only if it returned true.
Lift those decrements into the callers.

13/22) __dentry_kill(): get consistent rules for victim's refcount
	Currently we call it with refcount equal to 1 when called from
dentry_kill(); all other callers have it equal to 0.
	Make it always be called with zero refcount; on this step we just
decrement it before the calls in dentry_kill().  That is safe, since
all places that care about the value of refcount either do that under
->d_lock or hold a reference to dentry in question.  Either is sufficient
to prevent observing a dentry immediately prior to __dentry_kill()
getting called from dentry_kill().

14/22) dentry_kill(): don't bother with retain_dentry() on the slow path
	We have already checked it and dentry used to look not worthy
of keeping.  The only hard obstacle to evicting dentry is non-zero
refcount; everything else is advisory - e.g. memory pressure could evict
any dentry found with refcount zero.  On the slow path in dentry_kill()
we had dropped and regained ->d_lock; we must recheck the refcount,
but everything else is not worth bothering with.
	Note that filesystem can not count upon ->d_delete() being
called for dentry - not even once.  Again, memory pressure (as well as
d_prune_aliases(), or attempted rmdir() of ancestor, or...) will not
call ->d_delete() at all.
	So from the correctness point of view we are fine doing the
check only once.  And it makes things simpler down the road.
	The doctor said "To the morgue", so to the morgue it is!

15/22) Call retain_dentry() with refcount 0.
	Instead of bumping it from 0 to 1, calling retain_dentry(),
then decrementing it back to 0 (with ->d_lock held all the way through),
just leave refcount at 0 through all of that.
	It will have a visible effect for ->d_delete() - now it can
be called with refcount 0 instead of 1 and it can no longer play silly
buggers with dropping/regaining ->d_lock.  Not that any in-tree instances
tried to (it's pretty hard to get right).
	Any out-of-tree ones will have to adjust (assuming they need
any changes).

16/22) fold the call of retain_dentry() into fast_dput()
	Calls of retain_dentry() happen immediately after getting false
from fast_dput() and getting true from retain_dentry() is treated the
same way as non-zero refcount would be treated by fast_dput() - unlock
dentry and bugger off.

17/22) don't try to cut corners in shrink_lock_dentry().
	That is to say, do *not* treat the ->d_inode or ->d_parent
changes as "it's hard, return false; somebody must have grabbed it,
so even if has zero refcount, we don't need to bother killing it -
final dput() from whoever grabbed it would've done everything".
	First of all, that is not guaranteed.  It might have been dropped
by shrink_kill() handling of victim's parent, which would've found it
already on a shrink list (ours) and decided that they don't need to put
it on their shrink list.
	What's more, dentry_kill() is doing pretty much the same thing,
cutting its own set of corners (it assumes that dentry can't go from
positive to negative, so its inode can change but only once and only in
one direction).
	Doing that right allows to get rid of that not-quite-duplication
and removes the only reason for re-incrementing refcount before the call
of dentry_kill().
	Replacement is called lock_for_kill(); called under rcu_read_lock
and with ->d_lock held.  If it returns false, dentry has non-zero refcount
and the same locks are held.  If it returns true, dentry has zero refcount
and all locks required by __dentry_kill() are taken.
	Part of __lock_parent() had been lifted into lock_parent() to
allow its reuse.  Now it's called with rcu_read_lock already held and
dentry already unlocked.
	Note that this is not the final change - locking requirements
for __dentry_kill() are going to change later in the series and the set
of locks taken by lock_for_kill() will be adjusted.

18/22) fold dentry_kill() into dput().
	Not worth keeping separate.

19/22) to_shrink_list(): call only if refcount is 0
	The only thing it does if refcount is not zero is d_lru_del();
no point, IMO, seeing that plain dput() does nothing of that sort...
Note that 2 of 3 current callers are guaranteed that refcount is 0.

20/22) switch select_collect{,2}() to use of to_shrink_list()
Same note about d_lru_del() as in (18/22).

21/22) d_prune_aliases(): use a shrink list
	Instead of dropping aliases one by one, restarting, etc., just
collect them into a shrink list and kill them off in one pass.
	We don't really need the restarts - one alias can't pin another
(directory has only one alias, and couldn't be its own ancestor anyway),
so collecting everything that is not busy and taking it out would
take care of everything evictable that had been there as we entered
the function.  And new aliases added while we'd been dropping old ones
could just as easily have appeared right as we return to caller...

22/22) __dentry_kill(): new locking scheme
	Currently we enter __dentry_kill() with parent (along with the
victim dentry and victim's inode) held locked.	Then we
	mark dentry refcount as dead
	call ->d_prune()
	remove dentry from hash
	remove it from the parent's list of children
	unlock the parent, don't need it from that point on
	detach dentry from inode,
	unlock dentry and drop the inode (via ->d_iput())
	call ->d_release()
	regain the lock on dentry
	check if it's on a shrink list (in which case freeing its empty
	  husk has to be left to shrink_dentry_list()) or not (in which
	  case we can free it ourselves).  In the former case, mark it
	  as an empty husk, so that shrink_dentry_list() would know it
	  can free the sucker.
	drop the lock on dentry
... and usually the caller proceeds to drop a reference on the parent,
possibly retaking the lock on it.
	That is painful for a bunch of reasons, starting with the need
to take locks out of order, but not limited to that - the parent of
positive dentry can change if we drop its ->d_lock, so getting these
locks has to be done with care.
	Moreover, as soon as dentry is out of the parent's list of
children, shrink_dcache_for_umount() won't see it anymore, making it
appear as if the parent is inexplicably busy.  We do work around that
by having shrink_dentry_list() decrement the parent's refcount first and
put it on shrink list to be evicted once we are done with __dentry_kill()
of child, but that may in some cases lead to ->d_iput() on child called
after the parent got killed.  That doesn't happen in cases where in-tree
->d_iput() instances might want to look at the parent, but that's brittle
as hell.
	Solution: do removal from the parent's list of children in the
very end of __dentry_kill().  As the result, the callers do not need to
lock the parent and by the time we really need the parent locked, dentry
is negative and is guaranteed not to be moved around.
	It does mean that ->d_prune() will be called with parent not
locked.  It also means that we might see dentries in process of being torn
down while going through the parent's list of children; those dentries
will be unhashed, negative and with refcount marked dead.  In practice,
that's enough for in-tree code that looks through the list of children
to do the right thing as-is.  Out-of-tree code might need to be adjusted.
	Calling conventions: __dentry_kill(dentry) is called with
dentry->d_lock held, along with ->i_lock of its inode (if any).
It either returns the parent (locked, with refcount decremented to 0)
or NULL (if there'd been no parent or if refcount decrement for parent
hadn't reached 0).
	lock_for_kill() is adjusted for new requirements - it doesn't
touch the parent's ->d_lock at all.
	Callers adjusted.  Note that for dput() we don't need to
bother with fast_dput() for the parent - we just need to check
retain_dentry() for it, since its ->d_lock is still held since the
moment when __dentry_kill() had taken it to remove the victim from the
list of children.
	The kludge with early decrement of parent's refcount in
shrink_dentry_list() is no longer needed - shrink_dcache_for_umount()
sees the half-killed dentries in the list of children for as long as
they are pinning the parent.  They are easily recognized and accounted
for by select_collect(), so we know we are not done yet.
	As the result, we always have the expected ordering
for ->d_iput()/->d_release() vs. __dentry_kill() of the parent, no
exceptions.  Moreover, the current rules for shrink lists (one must make
sure that shrink_dcache_for_umount() won't happen while any dentries
from the superblock in question are on any shrink lists) are gone -
shrink_dcache_for_umount() will do the right thing in all cases, taking
such dentries out.  Their empty husks (memory occupied by struct dentry
itself + its external name, if any) will remain on the shrink lists,
but they are no obstacles to filesystem shutdown.  And such husks will
get freed as soon as shrink_dentry_list() of the list they are on gets
to them.

