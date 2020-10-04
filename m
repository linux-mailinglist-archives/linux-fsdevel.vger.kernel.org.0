Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76125282812
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgJDCgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgJDCgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:36:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC0C0613D0;
        Sat,  3 Oct 2020 19:36:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtse-00BUgo-KO; Sun, 04 Oct 2020 02:36:08 +0000
Date:   Sun, 4 Oct 2020 03:36:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC][PATCHSET] epoll cleanups
Message-ID: <20201004023608.GM3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Locking and especilly control flow in fs/eventpoll.c is
overcomplicated.  As the result, the code has been hard to follow
and easy to fuck up while modifying.

	The following series attempts to untangle it; there's more to be done
there, but this should take care of some of the obfuscated bits.  It also
reduces the memory footprint of that thing.

	The series lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #experimental.epoll
and it survives light local beating.  It really needs review and testing.
I'll post the individual patches in followups (27 commits, trimming about 120
lines out of fs/eventpoll.c).

	First we trim struct epitem a bit:
(1/27) epoll: switch epitem->pwqlist to single-linked list
	struct epitem has an associated set of struct eppoll_entry.
It's populated once (at epitem creation), traversed once (at epitem
destruction) and the order of elements does not matter.  No need
to bother with a cyclic list when a single-linked one will work
just fine.
	NB: it might make sense to embed the first (and almost always
the only) element of that list into struct epitem itself.  Not in
this series yet.
(2/27) epoll: get rid of epitem->nwait
	All it's used for is a rather convoluted mechanism for reporting
eppoll_entry allocation failures to ep_insert() at epitem creation time.
Can be done in a simpler way...

	Getting rid of ep_call_nested().  The thing used to have a much
wider use (including being called from wakeup callbacks, etc.); as it is,
it's greatly overcomplicated.  First of all, let's simplify the control
flow there:
(3/27) untangling ep_call_nested(): get rid of useless arguments
	Two of the arguments are always the same.  Kill 'em.
(4/27) untangling ep_call_nested(): it's all serialized on epmutex.
	It's fully serialized (the remaining calls, that is), which
allows to simplify things quite a bit - instead of a list of structures
in stack frames of recursive calls (possibly from many threads at the
same time, so they can be interspersed), all we really need is
a static array.  And very little of those structs is actually needed -
we don't need to separate the ones from different threads, etc.
(5/27) untangling ep_call_nested(): take pushing cookie into a helper
	ep_call_nested() does three things: it checks that the recursion
depth is not too large, it adds a pointer to prohibited set (and fails
if it's already been there) and it calls a callback.  Take handling of
prohibited set into a helper.
(6/27) untangling ep_call_nested(): move push/pop of cookie into the callbacks
	... and move the calls of that helper into the callbacks - all two
of them.  At that point ep_call_nested() has been reduced to an indirect
function call.
(7/27) untangling ep_call_nested(): and there was much rejoicing

	Besides the obfuscated control flow, ep_call_nested() used to have
another nasty effect - the callbacks had been procrusted into the
prototype expected by ep_call_nested().  Now we can untangle those:
(8/27) reverse_path_check_proc(): sane arguments
	'priv' and 'cookie' arguments are always equal here, and both are
actually struct file *, not void *.
(9/27) reverse_path_check_proc(): don't bother with cookies
	all we needed from ep_call_nested() was the recursion depth limit;
we have already checked for loops by the time we call it.
(10/27) clean reverse_path_check_proc() a bit
(11/27) ep_loop_check_proc(): lift pushing the cookie into callers
	move maintaining the prohibited set into the caller; that way
we don't need the 'cookie' argument.
(12/27) get rid of ep_push_nested()
	... and we don't really need the prohibited _set_ - we are adding
an edge to an acyclic graph and we want to verify that it won't create a loop.
Sure. we need to walk through the nodes reachable from the destination of
the edge to be, but all we need to verify is that the soure of that edge is
not among them.  IOW, we only need to check against *one* prohibited node.
That kills the last remnants of ep_call_nested().
(13/27) ep_loop_check_proc(): saner calling conventions
	'cookie' is not used, 'priv' is actually a epoll struct file *and*
we only care about associated struct eventpoll.  So pass that instead.

	Next source of obfuscation (and indirect function calls; I like
Haskell, but this is C and it wouldn't have made a good higher order
function anyway) is ep_scan_ready_list().  We start with splitting the
parts before and after the call of callback into new helpers and expanding
the calls of ep_scan_ready_list(), with the callbacks now called directly.

(14/27) ep_scan_ready_list(): prepare to splitup
	new helpers
(15/27) lift the calls of ep_read_events_proc() into the callers
	expand the calls of ep_scan_ready_list() that get ep_read_events_proc
as callback.  Allows for somewhat saner calling conventions for
ep_read_events_proc() (passing &depth as void *, casting it to int *,
dereferencing and incrementing the value read is better expressed as passing
depth + 1 as a number)...
(16/27) lift the calls of ep_send_events_proc() into the callers
	expand the remaining call (one with ep_send_events_proc() for callback)
(17/27) ep_send_events_proc(): fold into the caller
	... and get rid of the convoluted way ep_send_events_proc() had to
use to get the real arguments from the caller (as well as the messy way of
passing the result to that caller).

	Locking rules for ep_scan_ready_list() were kludgy, to put it mildly.
One of (ex-)callers of ep_scan_ready_list() sometimes had been called with
struct eventpoll already being locked.  That happened when ep_item_poll() had
been called by ep_insert(); the call chain in question had been recognized in
a bloody awful way and "is it already locked" flag used to be passed to
ep_scan_ready_list() (now to ep_{start,done}_scan()).
(18/27) lift locking/unlocking ep->mtx out of ep_{start,done}_scan()
	first we lift locking into the callers of ep_scan_ready_list(), so
that kludge is at least localized.  Makes for simpler calling conventions
for ep_{start,done}_scan().
(19/27) ep_insert(): don't open-code ep_remove() on failure exits
	clean the failure exits in ep_insert() up a bit.
(20/27) ep_insert(): we only need tep->mtx around the insertion itself
	... and shrink the area where ep_insert() has the epoll that is
getting inserted into another epoll down to what's really needed.  Which
gets rid of the irregularity in question - now all callers of ep_item_poll()
have the same locking environment.

	Massage ep_item_poll()/ep_read_events_proc() mutual recursion into
a saner shape:
(21/27) take the common part of ep_eventpoll_poll() and ep_item_poll() into helper
(22/27) fold ep_read_events_proc() into the only caller

	Finally, there's the mess with reverse path check.  When we insert
a new file into a epoll, we need to check that there won't be excessively long
(or excessively many) wakeup chains.  If the target is not an epoll, we need
to check that for the target alone, but if it's another epoll we need the same
check done to everything reachable from that epoll.  The way it's currently
done is Not Nice(tm): we collect the set of files to check and, once we have
verified the absence of loops, created a new epitem and inserted it into
the epoll data structures, we run reverse_path_check_proc() for every file
in the set.  The set is maintained as a (global) cyclic list threaded through
some struct file.  Everything is serialized on epmutex, so the list can be
global.  Unfortunately, each struct file ends up with list_head embedded into
it, all for the sake of operation that is rare *and* involves a small fraction
of all struct file instances on the system.
	Worse, files can end up disappearing while we are collecting the set;
explicit EPOLL_CTL_DEL does not grab epmutex, and final fput() won't touch
epmutex if all epitem refering to that file have already been removed.  This
had been worked around this cycle (by grabbing temporary references to struct
file added to the set), but that's not a good solution.
	What we need is to separate the head of epitem list (->f_ep_links)
from struct file; all we need in struct file is a reference to that head.
We could thread the list representing the set of files through those objects
(getting rid of 3 pointers in each struct file) and have epitem removal
free those objects if there's no epitems left *and* they are not included
into the set.  Reference from struct file would be cleared as soon as there's
no epitems left.  Dissolving the set would free those that have no epitems
left and thus would've been freed by ep_remove() if they hadn't been in the
set.
	With some massage it can be done; we end up with
* 3 pointers gone from each struct file
* one pointer added to struct eventpoll
* two-pointer object kept for each non-epoll file that is currently watched by
some epoll.
	That reduces the memory footprint in pretty much any setup, even when
most of the files are being watched.  And we get rid of the games with file
refcounts.  The locking is fairly mild; we don't need any new locks and there
shouldn't be extra contention and/or cacheline pingpong, AFAICS.  That needs
to be profiled, obviously.
	The next four patches do preliminary massage.  The last patch in the
series converts to new data structure; it's bigger than I would prefer, but
it's not that large - +129/-56 lines.  Maybe it can be carved up; at the moment
I don't see how to split it and I would prefer to post it for review as-is -
the merge window is a week away and nobody will have review bandwidth during
that.

(23/27) ep_insert(): move creation of wakeup source past the fl_ep_links insertion
	with separate allocation of epitem list heads, we will get a new failure
exit in ep_insert(); reorder the things so that we wouldn't need anything fancy
for cleanup on that exit.
(24/27) convert ->f_ep_links/->fllink to hlist
	what it says - we don't care about the order of elements there
(25/27) lift rcu_read_lock() into reverse_path_check()
	currently it's taken (and dropped) inside reverse_path_check_proc(),
covering the recursive calls of the same.  Just do it around the call
of reverse_path_check_proc() done in reverse_path_check().
(26/27) epoll: massage the check list insertion
	insert the target into the set only after it's gotten a epitem.
That way we know that our new structure will have been already allocated
when we need to add it to the list representing our set.

(27/27) epoll: take epitem list out of struct file
Here I'd rather copy the entire commit message:
================================================================================
Move the head of epitem list out of struct file; for epoll ones it's
moved into struct eventpoll (->refs there), for non-epoll - into
the new object (struct epitem_head).  In place of ->f_ep_links we
leave a pointer to the list head (->f_ep).

->f_ep is protected by ->f_lock and it's zeroed as soon as the list
of epitems becomes empty (that can happen only in ep_remove() by
now).

The list of files for reverse path check is *not* going through
struct file now - it's a single-linked list going through epitem_head
instances.  It's terminated by ERR_PTR(-1) (== EP_UNACTIVE_POINTER),
so the elements of list can be distinguished by head->next != NULL.

epitem_head instances are allocated at ep_insert() time (by
attach_epitem()) and freed either by ep_remove() (if it empties
the set of epitems *and* epitem_head does not belong to the
reverse path check list) or by clear_tfile_check_list() when
the list is emptied (if the set of epitems is empty by that
point).  Allocations are done from a separate slab - minimal kmalloc()
size is too large on some architectures.

As the result, we trim struct file _and_ get rid of the games with
temporary file references.

Locking and barriers are interesting (aren't they always); see unlist_file()
and ep_remove() for details.  The non-obvious part is that ep_remove() needs
to decide if it will be the one to free the damn thing *before* actually
storing NULL to head->epitems.first - that's what smp_load_acquire is for
in there.  unlist_file() lockless path is safe, since we hit it only if
we observe NULL in head->epitems.first and whoever had done that store is
guaranteed to have observed non-NULL in head->next.  IOW, their last access
had been the store of NULL into ->epitems.first and we can safely free
the sucker.  OTOH, we are under rcu_read_lock() and both epitem and
epitem->file have their freeing RCU-delayed.  So if we see non-NULL
->epitems.first, we can grab ->f_lock (all epitems in there share the
same struct file) and safely recheck the emptiness of ->epitems; again,
->next is still non-NULL, so ep_remove() couldn't have freed head yet.
->f_lock serializes us wrt ep_remove(); the rest is trivial.

Note that once head->epitems becomes NULL, nothing can get inserted into
it - the only remaining reference to head after that point is from the
reverse path check list.
================================================================================
