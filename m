Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6A175001
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCAVv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:51:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41528 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCAVv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:51:28 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WUf-003fIZ-Sd; Sun, 01 Mar 2020 21:51:26 +0000
Date:   Sun, 1 Mar 2020 21:51:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200301215125.GA873525@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223011154.GY23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Extended since the last repost.  The branch is in #work.dotdot;
#work.do_last is its beginning (about 2/3 of the total), slightly
reworked since the last time.

	Individual patches are in the followups.  Branch survives
the local testing (including ltp and xfstests).

	Review and testing would be _very_ welcome; it does a lot
of massage, so there had been a plenty of opportunities to fuck up
and fail to spot that.  The same goes for profiling - it doesn't
seem to slow the things down, but that needs to be verified.  If
nobody screams, in a couple of days I'm going to push the beginning
of that thing (#work.do_last) into -next, with the rest to follow
it there next weekend or so.

	Changes since v2: several followup cleanups in the end of
symlinks-related series (part 3) and large series on ".." handling
added in the end (part 6).  The only thing suggested in review and
not done yet is splitup of pick_link() - it's going to happen, but
I want the tricky parts handled first; pick_link() is trivial
as far as control flow goes.

part 1: follow_automount() cleanups and fixes.

	Quite a bit of that function had been about working around the
wrong calling conventions of finish_automount().  The problem is that
finish_automount() misuses the primitive intended for mount(2) and
friends, where we want to mount on top of the pile, even if something
has managed to add to that while we'd been trying to lock the namespace.
For automount that's not the right thing to do - there we want to discard
whatever it was going to attach and just cross into what got mounted
there in the meanwhile (most likely - the results of the same automount
triggered by somebody else).  Current mainline kinda-sorta manages to do
that, but it's unreliable and very convoluted.  Much simpler approach
is to stop using lock_mount() in finish_automount() and have it bail
out if something turns out to have been mounted on top where we wanted
to attach.  That allows to get rid of a lot of PITA in the caller.
Another simplification comes from not trying to cross into the results
of automount - simply ride through the next iteration of the loop and
let it move into overmount.

	Another thing in the same series is divorcing follow_automount()
from nameidata; that'll play later when we get to unifying follow_down()
with the guts of follow_managed().

	4 commits, the second one fixes a hard-to-hit race.  The first
is a prereq for it.

1/55	do_add_mount(): lift lock_mount/unlock_mount into callers
2/55	fix automount/automount race properly
3/55	follow_automount(): get rid of dead^Wstillborn code
4/55	follow_automount() doesn't need the entire nameidata

part 2: unifying mount traversals in pathwalk.

	Handling of mount traversal (follow_managed()) is currently called
in a bunch of places.  Each of them is shortly followed by a call of
step_into() or an open-coded equivalent thereof.  However, the locations
of those step_into() calls are far from preceding follow_managed();
moreover, that preceding call might happen on different paths that
converge to given step_into() call.  It's harder to analyse that it should
be (especially when it comes to liveness analysis) and it forces rather
ugly calling conventions on lookup_fast()/atomic_open()/lookup_open().
The series below massages the code to the point when the calls of
follow_managed() (and __follow_mount_rcu()) move into the beginning of
step_into().

5/55	make build_open_flags() treat O_CREAT | O_EXCL as implying O_NOFOLLOW
	gets EEXIST handling in do_last() past the step_into() call there.
6/55	handle_mounts(): start building a sane wrapper for follow_managed()
	rather than mangling follow_managed() itself (and creating conflicts
	with openat2 series), add a wrapper that will absorb the required
	interface changes.
7/55	atomic_open(): saner calling conventions (return dentry on success)
	struct path passed to it is pure out parameter; only dentry part
	ever varies, though - mnt is always nd->path.mnt.  Just return
	the dentry on success, and ERR_PTR(-E...) on failure.
8/55	lookup_open(): saner calling conventions (return dentry on success)
	propagate the same change one level up the call chain.
9/55	do_last(): collapse the call of path_to_nameidata()
	struct path filled in lookup_open() call is eventually given to
	handle_mounts(); the only use it has before that is path_to_nameidata()
	call in "->atomic_open() has actually opened it" case, and there
	path_to_nameidata() is an overkill - we are guaranteed to replace
	only nd->path.dentry.  So have the struct path filled only immediately
	prior to handle_mounts().
10/55	handle_mounts(): pass dentry in, turn path into a pure out argument
	now all callers of handle_mount() are directly preceded by filling
	struct path it gets.  path->mnt is nd->path.mnt in all cases, so we can
	pass just the dentry instead and fill path in handle_mount() itself.
	Some boilerplate gone, path is pure out argument of handle_mount()
	now.
11/55	lookup_fast(): consolidate the RCU success case
	massage to gather what will become an RCU case equivalent of
	handle_mounts(); basically, that's what we do if revalidate succeeds
	in RCU case of lookup_fast(), including unlazy and fallback to
	handle_mounts() if __follow_mount_rcu() says "it's too tricky".
12/55	teach handle_mounts() to handle RCU mode
	... and take that into handle_mount() itself.  The other caller of
	__follow_mount_rcu() is fine with the same fallback (it just didn't
	bother since it's in the very beginning of pathwalk), switched to
	handle_mount() as well.
13/55	lookup_fast(): take mount traversal into callers
	Now we are getting somewhere - both RCU and non-RCU success cases of
	lookup_fast() are ended with the same return handle_mounts(...);
	move that to the callers - there it will merge with the identical calls
	that had been on the paths where we had to do slow lookups.
	lookup_fast() returns dentry now.
14/55	new step_into() flag: WALK_NOFOLLOW
	use step_into() instead of open-coding it in handle_lookup_down().
	Add a flag for "don't follow symlinks regardless of LOOKUP_FOLLOW" for
	that (and eventually, I hope, for .. handling).
	Now *all* calls of handle_mounts() and step_into() are right next to
	each other.
15/55	fold handle_mounts() into step_into()
	... and we can move the call of handle_mounts() into step_into(),
	getting a slightly saner calling conventions out of that.
16/55	LOOKUP_MOUNTPOINT: fold path_mountpointat() into path_lookupat()
	another payoff from 14/17 - we can teach path_lookupat() to do
	what path_mountpointat() used to.  And kill the latter, along with
	its wrappers.
17/55	expand the only remaining call of path_lookup_conditional()
	minor cleanup - RIP path_lookup_conditional().  Only one caller left.

Changes so far:
	* mount traversal is taken into step_into().
	* lookup_fast(), atomic_open() and lookup_open() calling conventions
are slightly changed.  All of them return dentry now, instead of returning
an int and filling struct path on success.  For lookup_fast() the old
"0 for cache miss, 1 for cache hit" is replaced with "NULL stands for cache
miss, dentry - for hit".
	* step_into() can be called in RCU mode as well.  Takes nameidata,
WALK_... flags, dentry and, in RCU case, corresponding inode and seq value.
Handles mount traversals, decides whether it's a symlink to be followed.
Error => returns -E...; symlink to follow => returns 1, puts symlink on stack;
non-symlink or symlink not to follow => returns 0, moves nd->path to new location.
	* LOOKUP_MOUNTPOINT introduced; user_path_mountpoint_at() and friends
became calls of user_path_at() et.al. with LOOKUP_MOUNTPOINT in flags.

part 3: untangling the symlink handling.

	Right now when we decide to follow a symlink it happens this way:
	* step_into() decides that it has been given a symlink that needs to
be followed.
	* it calls pick_link(), which pushes the symlink on stack and
returns 1 on success / -E... on error.  Symlink's mount/dentry/seq is
stored on stack and the inode is stashed in nd->link_inode.
	* step_into() passes that 1 to its callers, which proceed to pass it
up the call chain for several layers.  In all cases we get to get_link()
call shortly afterwards.
	* get_link() is called, picks the inode stashed in nd->link_inode
by the pick_link(), does some checks, touches the atime, etc.
	* get_link() either picks the link body out of inode or calls
->get_link().  If it's an absolute symlink, we move to the root and return
the relative portion of the body; if it's a relative one - just return the
body.  If it's a procfs-style one, the call of nd_jump_link() has been
made and we'd moved to whatever location is desired.  And return NULL,
same as we do for symlink to "/".
	* the caller proceeds to deal with the string returned to it.

	The sequence is the same in all cases (nested symlink, trailing
symlink on lookup, trailing symlink on open), but its pieces are not close
to each other and the bit between the call of pick_link() and (inevitable)
call of get_link() afterwards is not easy to follow.  Moreover, a bunch
of functions (walk_component/lookup_last/do_last) ends up with the same
conventions for return values as step_into().  And those conventions
(see above) are not pretty - 0/1/-E... is asking for mistakes, especially
when returned 1 is used only to direct control flow on a rather twisted
way to matching get_link() call.  And that path can be seriously twisted.
E.g. when we are trying to open /dev/stdin, we get the following sequence:
	* path_init() has put us into root and returned "/dev/stdin"
	* link_path_walk() has eventually reached /dev and left
<LAST_NORM, "stdin"> in nd->last_type/nd->last
	* we call do_last(), which sees that we have LAST_NORM and calls
lookup_fast().  Let's assume that everything is in dcache; we get the
dentry of /dev/stdin and proceed to finish_lookup:, where we call step_into()
	* it's a symlink, we have LOOKUP_FOLLOW, so we decide to pick the
damn thing.  Into the stack it goes and we return 1.
	* do_last() sees 1 and returns it.
	* trailing_symlink() is called (in the top-level loop) and it
calls get_link().  OK, we get "/proc/self/fd/0" for body, move to
root again and return "proc/self/fd/0".
	* link_path_walk() is given that string, eventually leading us into
/proc/self/fd, with <LAST_NORM, "0"> left as the component to handle.
	* do_last() is called, and similar to the previous case we
eventually reach the call of step_into() with dentry of /proc/self/fd/0.
	* _now_ we can discard /dev/stdin from the stack (we'd been
using its body until now).  It's dropped (from step_into()) and we get
to look at what we'd been given.  A symlink to follow, so on the stack
it goes and we return 1.
	* again, do_last() passes 1 to caller
	* trailing_symlink() is called and calls get_link().
	* this time it's a procfs symlink and its ->get_link() method
moves us to the mount/dentry of our stdin.  And returns NULL.  But the
fun doesn't stop yet.
	* trailing_symlink() returns "" to the caller
	* link_path_walk() is called on that and does nothing
whatsoever.
	* do_last() is called and sees LAST_BIND left by the get_link().
It calls handle_dots()
	* handle_dots() drops the symlink from stack and returns
	* do_last() *FINALLY* proceeds to the point after its call of
step_into() (finish_open:) and gets around to opening the damn thing.

	Making sense of the control flow through all of that is not fun,
to put it mildly; debugging anything in that area can be a massive PITA,
and this example has touched only one of 3 cases.  Arguably, the worst
one, but...  Anyway, it turns out that this code can be massaged to
considerably saner shape - both in terms of control flow and wrt calling
conventions.

18/55	merging pick_link() with get_link(), part 1
	prep work: move the "hardening" crap from trailing_symlink() into
get_link() (conditional on the absense of LOOKUP_PARENT in nd->flags).
We'll be moving the calls of get_link() around quite a bit through that
series, and the next step will be to eliminate trailing_symlink().
19/55	merging pick_link() with get_link(), part 2
	fold trailing_symlink() into lookup_last() and do_last().
Now these are returning strings; it's not the final calling conventions,
but it's almost there.  NULL => old 0, we are done.  ERR_PTR(-E...) =>
old -E..., we'd failed.  string => old 1, and the string is the symlink
body to follow.  Just as for trailing_symlink(), "/" and procfs ones
(where get_link() returns NULL) yield "", so the ugly song and dance
with no-op trip through link_path_walk()/handle_dots() still remains.
20/55	merging pick_link() with get_link(), part 3
	elimination of that round-trip.  In *all* cases having
get_link() return NULL on such symlinks means that we'll proceed to
drop the symlink from stack and get back to the point near that
get_link() call - basically, where we would be if it hadn't been
a symlink at all.  The path by which we are getting there depends
upon the call site; the end result is the same in all cases - such
symlinks (procfs ones and symlink to "/") are fully processed by
the time get_link() returns, so we could as well drop them from the
stack right in get_link().  Makes life simpler in terms of control
flow analysis...
	And now the calling conventions for do_last() and lookup_last()
have reached the final shape - ERR_PTR(-E...) for error, NULL for
"we are done", string for "traverse this".
21/55	merging pick_link() with get_link(), part 4
	now all calls of walk_component() are followed by the same
boilerplate - "if it has returned 1, call get_link() and if that
has returned NULL treat that as if walk_component() has returned 0".
Eliminate by folding that into walk_component() itself.  Now
walk_component() return value conventions have joined those of
do_last()/lookup_last().
22/55	merging pick_link() with get_link(), part 5
	same as for the previous, only this time the boilerplate
migrates one level down, into step_into().  Only one caller of
get_link() left, step_into() has joined the same return value
conventions.
23/55	merging pick_link() with get_link(), part 6
	move that thing into pick_link().  Now all traces of
"return 1 if we are following a symlink" are gone.
24/55	finally fold get_link() into pick_link()
	ta-da - expand get_link() into the only caller.  As a side
benefit, we get rid of stashing the inode in nd->link_inode - it
was done only to carry that piece of information from pick_link()
to eventual get_link().  That's not the main benefit, though - the
control flow became considerably easier to reason about.

For what it's worth, the example above (/dev/stdin) becomes
	* path_init() has put us into root and returned "/dev/stdin"
	* link_path_walk() has eventually reached /dev and left
<LAST_NORM, "stdin"> in nd->last_type/nd->last
	* we call do_last(), which sees that we have LAST_NORM and calls
lookup_fast().  Let's assume that everything is in dcache; we get the
dentry of /dev/stdin and proceed to finish_lookup:, where we call step_into()
	* it's a symlink, we have LOOKUP_FOLLOW, so we decide to pick the
damn thing.  On the stack it goes and we get its body.  Which is
"/proc/self/fd/0", so we move to root and return "proc/self/fd/0".
	* do_last() sees non-NULL and returns it - whether it's an error
or a pathname to traverse, we hadn't reached something we'll be opening.
	* link_path_walk() is given that string, eventually leading us into
/proc/self/fd, with <LAST_NORM, "0"> left as the component to handle.
	* do_last() is called, and similar to the previous case we
eventually reach the call of step_into() with dentry of /proc/self/fd/0.
	* _now_ we can discard /dev/stdin from the stack (we'd been
using its body until now).  It's dropped (from step_into()) and we get
to look at what we'd been given.  A symlink to follow, so on the stack
it goes.   This time it's a procfs symlink and its ->get_link() method
moves us to the mount/dentry of our stdin.  And returns NULL.  So we
drop symlink from stack and return that NULL to caller.
	* that NULL is returned by step_into(), same as if we had just
moved to a non-symlink.
	* do_last() proceeds to open the damn thing.

Some low-hanging fruits become available: LAST_BIND can be removed and
the predicate controlling may_follow_link() we'd moved into pick_link()
in #18 can be made more straightforward:
25/55	LAST_BIND removal
	The only reason to keep it had just been eliminated - it was
needed to route the control flow through that weird last iteration
through the loop.  With that iteration gone...
26/55	invert the meaning of WALK_FOLLOW
27/55	pick_link(): check for WALK_TRAILING, not LOOKUP_PARENT
	In #18 the checks specific to trailing symlinks got moved into
pick_link(), where they were made conditional upon LOOKUP_PARENT in
nd->flags.  That works, but it's more subtle than I would like it to
be - it depends upon the dynamic state (nd->flags) which gets changed
through the pathwalk and it's sensitive to exact locations where we
flip LOOKUP_PARENT.  Now we have a more robust way to do that - the
call chains that end up in pick_link() with LOOKUP_PARENT in nd->flags
are those that had WALK_TRAILING passed to the immediate caller of
pick_link() (step_into()).  So we can pass WALK_... down to pick_link()
and turn the check into explicit "if we are passed WALK_TRAILING,
it's a trailing symlink and we need to apply the checks in may_follow()".
	We could, in principle, reorder these two commits into the
very beginning of symlink series; that would make #18 slightly simpler
at the cost of (marginally) more boilerplate to carry through the
get_link() call moves.  Not sure if it's worth doing, though...

28/55	link_path_walk(): simplify stack handling
	Another cleanup that becomes possible is handling of the stack(s).
We use nd->stack to store two things: pinning down the symlinks we are
resolving and resuming the name traversal when a nested symlink is finished.
    
Currently, nd->depth is used to keep track of both.  It's 0 when we call
link_path_walk() for the first time (for the pathname itself) and 1 on
all subsequent calls (for trailing symlinks, if any).  That's fine,
as far as pinning symlinks goes - when handling a trailing symlink,
the string we are interpreting is the body of symlink pinned down in
nd->stack[0].  It's rather inconvenient with respect to handling nested
symlinks, though - when we run out of a string we are currently interpreting,
we need to decide whether it's a nested symlink (in which case we need
to pick the string saved back when we started to interpret that nested
symlink and resume its traversal) or not (in which case we are done with
link_path_walk()).
    
Current solution is a bit of a kludge - in handling of trailing symlink
(in lookup_last() and open_last_lookups() we clear nd->stack[0].name.
That allows link_path_walk() to use the following rules when running out of
a string to interpret:
	* if nd->depth is zero, we are at the end of pathname itself.
	* if nd->depth is positive, check the saved string; for
nested symlink it will be non-NULL, for trailing symlink - NULL.
    
It works, but it's rather non-obvious.  Note that we have two sets:
the set of symlinks currently being traversed and the set of postponed
pathname tails.  The former is stored in nd->stack[0..nd->depth-1].link
and it's valid throught the pathname resolution; the latter is valid only
during an individual call of link_path_walk() and it occupies
nd->stack[0..nd->depth-1].name for the first call of link_path_walk() and
nd->stack[1..nd->depth-1].name for subsequent ones.  The kludge is basically
a way to recognize the second set becoming empty.
    
The things get simpler if we keep track of the second set's size explicitly
and always store it in nd->stack[0..depth-1].name.  We access the second set
only inside link_path_walk(), so its size can live in a local variable;
that way the check becomes trivial without the need of that kludge.

part 4.  some mount traversal cleanups.

29/55	massage __follow_mount_rcu() a bit
	make it more similar to non-RCU counterpart
30/55	new helper: traverse_mounts()
	the guts of follow_managed() are very similar to
follow_down().  The calling conventions are different (follow_managed()
works with nameidata, follow_down() - with standalone struct path),
but the core loop is pretty much the same in both.  Turned that loop
into a common helper (traverse_mounts()) and since follow_managed()
becomes a very thin wrapper around it, expand follow_managed() at its
only call site (in handle_mounts()),

part 5.  do_last() untangling.

Control flow in do_last() is an atrocity, and liveness analysis in there
is rather painful.  What follows is a massage of that thing into (hopefully)
more straightforward shape; by the end of the series it's still unpleasant,
but at least easier to follow.

A major source of headache is treatment of "we'd already managed to
open it in ->atomic_open()" and "we'd just created that sucker" cases -
that's what gives complicated control flow graph.  As it is, we
have the following horror:
        #
 /------*				ends with . or ..?
 #      |
 |      #
 |  /---*				found in dcache, no O_CREAT?
 |  |   |
 |  |   #				call lookup_open() here.
 |  |   |
 |  |   *---------------\		already opened in ->atomic_open()?
 |  |   |               #
 |  |   *---\           |		freshly created file?
 |  |   |   #           |
 |  \---+   |           |		finish_lookup:
 |      #   |           |
 |      *--------------------->		is it a symlink?
 \------+   |           |		finish_open:
        #   |           |
        +--/            |		finish_open_created:
        #               |
        +---------------/		opened:
        #
To make it even more unpleasant, there is quite a bit of similar,
but not entirely identical logics on parallel branches, some of it
buried in lookup_open() *and* atomic_open() called by it.  Keeping
track of that has been hard and that had lead to more than one bug.

31/55	atomic_open(): return the right dentry in FMODE_OPENED case
	As it is, several invariants do not hold in "we'd already opened
it in ->atomic_open()" case.  In particular, nd->path.dentry might be
pointing to the wrong place by the time we return to do_last() - on
that codepath we don't care anymore.  That both makes it harder to reason
about and serves as an obstacle to transformations that would untangle
that mess.  Fortunately, it's not hard to regularize.
32/55	atomic_open(): lift the call of may_open() into do_last()
	may_open() is called before vfs_open() in "hadn't opened in
->atomic_open()" case.  Rightfully so, since vfs_open() for e.g.
devices can have side effects.  In "opened in ->atomic_open()" case
we have to do it after the actual opening - the whole point is to
combine open with lookup and we only get the information needed for
may_open() after the combined lookup/open has happened.  That's
OK - no side effects are possible in that case.  However, we don't
have to keep that call of may_open() inside fs/namei.c:atomic_open();
as the matter of fact, lifting it into do_last() allows to simplify
life there...
33/55	do_last(): merge the may_open() calls
	... since now we have the "it's already opened" case in
do_last() rejoin the main path at earlier point.

At that point the horror graph from above has become
        #
 /------*				ends with . or ..?
 #      |
 |      #
 |  /---*				found in dcache, no O_CREAT?
 |  |   |
 |  |   #				call lookup_open() here.
 |  |   |
 |  |   *---------------\		already opened in ->atomic_open()?
 |  |   |               #
 |  |   *---\           |		freshly created file?
 |  |   |   #           |
 |  \---+   |           |		finish_lookup:
 |      #   |           |
 |      *--------------------->		is it a symlink?
 \------+   |           |		finish_open:
        #   |           |
        +--/------------/		finish_open_created:
        #
34/55	do_last(): don't bother with keeping got_write in FMODE_OPENED case
	Another source of unpleasantness is an attempt to be clever and
keep track of write access status; the thing is, it doesn't really buy
us anything - we could as well drop it right after the lookup_open() and
only regain it for truncation, should such be needed.  Makes for much
simpler cleanups on failures and sets the things up for unification of
"already opened" and "new file" branches with the main path...
35/55	do_last(): rejoing the common path earlier in FMODE_{OPENED,CREATED} case
	... which we do here.
36/55	do_last(): simplify the liveness analysis past finish_open_created
	It also makes possible to shrink the liveness intervals for local
variables.
37/55	do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case
	Further unification of parallel branches.

At that point we get
        #
 /------*				ends with . or ..?
 #      |
 |      #
 |  /---*				found in dcache, no O_CREAT?
 |  |   |
 |  |   #				call lookup_open() here.
 |  |   |
 |  |   *---\				opened by ->atomic_open() or freshly creatd?	
 |  \---+   |				finish_lookup:
 |      #   |
 |      *--------------------->		is it a symlink?
 \------+   |				finish_open:
        |   |
        +--/				finish_open_created:
        #
with very little work done between finish_open: and finish_open_created:,
as well as on any of the side branches.  Moreover, we have a pretty clear
separation: most of the work on _opening_ is after finish_open_created
(some of it - conditional), while the work on lookups and creation is all
before that point.  Even better, most of the local variables are used
either only before or only after that cutoff point.

38/55	split the lookup-related parts of do_last() into a separate helper
	... which allows to separate the lookup-related parts from
open-related ones.

	I'm not saying I'm entirely happy with the resulting state of
do_last() clusterfuck, but it got a lot easier to follow and reason
about.  There are more cleanups possible (and needed) in there, though -
there will be followups.

part 6: ".." handling

	The main problem with .. traversal is that it has open-coded mount
crossing in the end.  That mount crossing used to be identical to that done
after the normal name components, but it got overlooked in several series
(most recently - openat2, prior to that - mount traps and automounts) and
now we have an out-of-sync variant (two of them, actually - RCU and non-RCU
cases) festering there and breeding hard-to-spot bugs.  The most recent
example was when openat2 got extra checks added to the normal mount crossing;
it added the same to RCU case of .. handling, but missed the non-RCU one.
Nobody noticed during the many rounds of review - me, Christoph and Linus
included.

	Another issue is that we are heavier on the locking than we need to
during the rootwards mount traversal there; traversing mounts in other
direction (from mountpoint to mounted) gets by without grabbing mount_lock
exclusive (or dirtying its cacheline in any way, for that matter), even
in non-RCU case.  The same should be the case for mounted-to-mountpoint
transitions - except for the case of very rare races with mount --move
and friends, we should be fine with just the seqcount checks there.

	The following is how .. handling behaves on just about any post-v7
Unix:

	while true
		if the caller is chrooted into directory      // rare
(A)			parent = directory
			break
		if directory is absolute root		      // rare
(B)			parent = directory
			break
		if directory is mounted on top of mountpoint // 2nd most common
(C)			directory = mountpoint
		else					     // the most common
(D)			parent = the parent of directory (within its fs)
			break
	while something is mounted on parent		     // unusual setup
(E)		parent = whatever overmounts it
	return parent

There are 3 paths that execution commonly takes, and they cover almost everything
that occurs in practice:
	1) [A]		We are in / and we stay there
	2) [C,D]	We are in root of mounted filesystem,
			we step into the underlying mountpoint,
			then into the parent of mountpoint.
	3) [D]		The place we are in is not a root of mounted filesystem,
			we step into its parent.
These cases are obvious.  However, other execution paths are possible;
in fact, the only constraint is that if we leave the first loop via (A) or (B),
the body of the second loop (i.e. going from mountpoint to mounted) will be
executed at least as many times as (C) (going from mounted to mountpoint)
had been.

A closer look at the predicates in the above shows that "is absolute root"
is actually "is root of a mount and that mount is not attached to anything"
while "is mounted on top of mountpoint" is "is a root of a mount and the
mount is attached to mountpoint".  Which suggest the following transformation:

choose_mountpoint(mount, &ancestor)
	while mount is attached to something
		d = mountpoint(mount)
		mount = parent(mount)
		if the caller is chrooted into <mount, d>
			break
		if d is a root of mount
			ancestor = <mount, d>
			return true
	return false

handle_dotdot(directory)
	if unlikely(the caller is chrooted into directory)
		goto in_root
	if unlikely(directory is a root of some mount)
		if !choose_mountpoint(mount, &ancestor)
			goto in_root
		directory = ancestor
	parent = the parent of directory (within its fs)
	while unlikely(something is mounted on parent)
		parent = whatever overmounts it
	return parent
in_root:
	parent = directory
	while unlikely(something is mounted on parent)
		parent = whatever overmounts it
	return parent

In this form we have mounted-to-mountpoint mount traversals clearly
separated.  Moreover, required updates of pathwalk context (nameidata)
can be packed into a call of the same primitive (step_into()) we use
for moves into normal components, including the forward mount
traversals.

NO_XDEV and BENEATH checks (added by openat2 series) fit into that
just fine - NO_XDEV at "directory = ancestor" part, BENEATH - at
in_root.  Since the forward mount traversal is done by step_into(),
the regular NO_XDEV checks in there take care of the rest.

The following series massages follow_dotdot/follow_dotdot_rcu() to
that form and does choose_mountpoint() implementation with saner
locking than what we do in mainline now - for RCU case we only need
to check mount_lock seqcount once (in the caller), for non-RCU we
can use a loop similar to what lookup_mnt() does for forward traversals.

39/55	path_connected(): pass mount and dentry separately
40/55	path_parent_directory(): leave changing path->dentry to callers
41/55	follow_dotdot(): expand the call of path_parent_directory()
	currently switching to parent is done inside path_parent_directory(),
called from the loop in follow_dotdot().  These 3 commits lift that into
the loop in follow_dotdot() itself...
42/55	follow_dotdot{,_rcu}(): lift switching nd->path to parent out of loop
43/55	follow_dotdot{,_rcu}(): lift LOOKUP_BENEATH checks out of loop
	... and out of the loop(s) (both on the RCU and non-RCU sides)

44/55	move put_link() into handle_dots()
45/55	handle_dots(): return ERR_PTR/NULL instead of -E.../0
46/55	move follow_dotdot() and follow_dotdot_rcu() towards handle_dots()
47/55	follow_dotdot{,_rcu}(): preparation to switch to step_into()
	gather the pieces for step_into() calls we are about to construct.

48/55	follow_dotdot{,_rcu}(): switch to use of step_into()
	... and switch both to it.  Now the RCU and non-RCU variants of
the loop that used to do forward mount traversal on .. are replaced with
step_into() calls...
49/55	lift all calls of step_into() out of follow_dotdot/follow_dotdot_rcu
	... which can be consolidated.  We are done with the forward traversal
parts.

50/55	follow_dotdot{,_rcu}(): massage loops
51/55	follow_dotdot_rcu(): be lazy about changing nd->path
52/55	follow_dotdot(): be lazy about changing nd->path
	get the rootwards traversal into shape described above

53/55	helper for mount rootwards traversal
54/55	non-RCU analogue of the previous commit
	... and introduce choose_mountpoint{,_rcu}(), switching both RCU and
non-RCU variants to it.

55/55	fs/namei.c: kill follow_mount()
	detritus removal - the only remaining caller (path_pts()) ought to
use follow_down() anyway.
