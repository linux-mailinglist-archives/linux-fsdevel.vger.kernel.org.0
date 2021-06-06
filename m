Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3792939D096
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFFTKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFTJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:09:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E2C061766;
        Sun,  6 Jun 2021 12:08:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpy7k-0056Q2-VB; Sun, 06 Jun 2021 19:07:53 +0000
Date:   Sun, 6 Jun 2021 19:07:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC][PATCHSET] iov_iter work
Message-ID: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Large part of the problems with iov_iter comes from its history -
it was not designed, it accreted over years.  Worse, its users sit on
rather hots paths, so touching any of the primitives can come with
considerable performance cost.

	iov_iter first appeared as a replacement for mutable iovec
arrays - it carried the state that needed to be modified, allowing
to leave iovecs themselves unchanged through the operations.  Rewrites
of iovec arrays had been costly and avoiding them on the fairly hot
paths made a lot of sense.

	Several years later it had been expanded - instead of wrapping
the operations dealing with kernel memory rather than userland one into
set_fs(), we'd added the "do those iovecs refer to userland memory?" flag
into iov_iter and had primitives act accordingly.  Soon after that
we'd added a flavour that used <page,offset,length> triples instead of
<address,length> pairs (i.e. bio_vec instead of iovec); that simplified
a lot of stuff.  At that stage the code coalesced into lib/iov_iter.c
and include/linux/uio.h.  Another thing that happened at that time was
the conversion of sendmsg/recvmsg to iov_iter; that added some primitives
and mostly killed the mutable iovecs off.

	Then we'd grown yet another flavour, when destination had
been a pipe.  That simplified a lot of stuff around splice(2).

	Unfortunately, all of that had lead to a lot of boilerplate
code in lib/iov_iter.c.  As much as I loathe templates, I'd ended up
implementing something similar.  In preprocessor, at that.  Result had
been predictably revolting.

	Later more primitives got added; these macros made that more
or less easy.  Unfortunately, the same macros had lead to shitty
code generation - usual results of trying to be too smart with
microoptimizations.

	Then a new flavour ("discard") had been added.  That one was
trivial, but the last cycle a new one ("xarray") went in.  Dave tried
to turn that into per-flavour set of methods, but performance cost of
indirect calls had been considerable, so we ended up with even grottier
macros.

	It really needs to be cleaned up, without performance loss -
this stuff *does* sit on performance-critical paths.  We also need to
fix a bunch of corner cases in there.

	The series attempting to do so lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.iov_iter
and it seems to survive the local beating.  Diffstat is
 Documentation/filesystems/porting.rst |    9 +
 fs/btrfs/file.c                       |   23 +-
 fs/fuse/file.c                        |    4 +-
 fs/iomap/buffered-io.c                |   35 +-
 fs/ntfs/file.c                        |   33 +-
 include/linux/uio.h                   |   66 +-
 include/net/checksum.h                |   14 +-
 lib/iov_iter.c                        | 1236 +++++++++++++++------------------
 mm/filemap.c                          |   36 +-
 9 files changed, 652 insertions(+), 804 deletions(-)
and IMO iov_iter.c does get better.  37 commits, individual patches
in followups, series overview follows.  Please, review and help
with testing.

	Part 1: preliminary bits and pieces.

	First, several patches removing the bogus uses of
iov_iter_single_seg_count() in "copy into page cache" kind of loops.
It used to make sense back when that was the way to tell how much
would iov_iter_fault_in_readable() try to fault in; these days
iov_iter_fault_in_readable() is not limited to the first iovec.
	There are uses besides the heuristics for short copy handling,
so the primitive itself is not going away.  Many of its uses are,
though.
(1/37)  ntfs_copy_from_user_iter(): don't bother with copying iov_iter
(2/37)  generic_perform_write()/iomap_write_actor(): saner logics for short copy
(3/37)  fuse_fill_write_pages(): don't bother with iov_iter_single_seg_count()

	Dead code removal:
(4/37)  iov_iter: Remove iov_iter_for_each_range()
	Dave's patch that should've probably been included into xarray
series.  The last user of that primitive went away when lustre got dropped.
Very prone to abuse - trying to get it right (at the moment it's only
implemented for iovec and kvec flavours) would lead to very tricky
locking environments for the callback.  E.g. for xarray flavour it would
happen under rcu_read_lock, etc.  RIP.

	Several fixes:
(5/37)  teach copy_page_to_iter() to handle compound pages
	In situation when copy_page_to_iter() got a compound page the current
code would only work on systems with no CONFIG_HIGHMEM.  It *is* the majority
of real-world setups, or we would've drown in bug reports by now.  Rare setups
or not, it needed fixing.  -stable fodder.
(6/37)  copy_page_to_iter(): fix ITER_DISCARD case
	Another corner case - copy_page_to_iter() forgot to advance the
iterator for "discard" flavour.  Unfortunately, while discard doesn't have
anything like current position, it does have the amount of space left
and users expect it to change properly.  -stable fodder.
(7/37)  [xarray] iov_iter_fault_in_readable() should do nothing in xarray case
	iov_iter_fault_in_readable() used to check that the flavour had
been neither kvec nor bvec.  It relied upon being called only for data
sources, which excludes the possibility of pipe and discard flavours.
It worked (despite being ugly as hell) until xarray got merged - xarray
*can* be data source and it does need to be excluded.
	The predicate it wanted to check all along was "it's an iovec-backed
one"...
(8/37)  iov_iter_advance(): use consistent semantics for move past the end
	Another corner case - iov_iter_advance() on more than left in iov_iter
should move to the very end.  bvec and discard used to be broken in such
case.

	Trimming the primitives:
(9/37)  iov_iter: switch ..._full() variants of primitives to use of iov_iter_revert()
	As suggested by Linus, all "copy everything or fail, advance only
in case of success" can be done as normal copy + revert in the unlikely case
a short copy happens.

	Part 2: saner flavour representation

	Flavour encoding is one of the microoptimizations that shouldn't
have been done in the first place; we store it in a kinda-sorta bitmap,
along with "is it a data source or data destination" flag.  The ability
to check if flavour is e.g. kvec or bvec in one test is not worth the
trouble - compiler can't show that we never get more than one of "type"
bits set in iter->type and the effects on code generation are not nice.

(10/37)  iov_iter: reorder handling of flavours in primitives
	Make all flavour checks use iov_iter_is_...(), *including* the
iovec case.  Allows to reorder them sanely and makes the things a lot
more robust, since iovec case is checked explicitly and does not depend
upon everything else having been already excluded by the earlier tests.

(11/37)  iov_iter_advance(): don't modify ->iov_offset for ITER_DISCARD
	... seeing that ->iov_offset is not used for those.  What's more,
now we can drop the iov_iter_is_discard() case there completely.

(12/37)  iov_iter: separate direction from flavour
	Separate the "direction" bit into a separate field and turn
the type into flat enumeration.  Oh, and rename the 'type' field into
something easier to grep for - my fault, that.

	Part 3: reducing abuses of iterating macros

	In a bunch of places the iterating macros are misused - it's
simpler *and* faster to do explicit loops.  The next pile eliminates
those.

(13/37)  iov_iter: optimize iov_iter_advance() for iovec and kvec
	First to go: iov_iter_advance().  Sure, iterate_and_advance() with
"do nothing" as step sounds like an elegant solution.  Except that it's
a bad overkill in this case.  That had already been spotted for bvec a while
ago, but iovec/kvec cases are no different.
(14/37)  sanitize iov_iter_fault_in_readable()
	Stray iterate_iovec() use gone.  Particularly unpleasant one, since
it had step that might return from the entire function.  Use of ({...}) with
execution leaving *not* through the end of block should be considered a bug,
IMO.
(15/37)  iov_iter_alignment(): don't bother with iterate_all_kinds()
(16/37)  iov_iter_gap_alignment(): get rid of iterate_all_kinds()
(17/37)  get rid of iterate_all_kinds() in iov_iter_get_pages()/iov_iter_get_pages_alloc()
	Another "return inside a step" one; all we used iterate_all_kinds()
for was to locate the first non-empty iovec.  This one has an extra (minor)
behaviour improvement in it - bvec case with compound page in it will get
all subpages of that page now, not just the first one.
(18/37)  iov_iter_npages(): don't bother with iterate_all_kinds()
	Yet another "return inside a step" case...
(19/37)  [xarray] iov_iter_npages(): just use DIV_ROUND_UP()
	minor followup to the previous

(20/37)  iov_iter: replace iov_iter_copy_from_user_atomic() with iterator-advancing variant
	iov_iter_copy_from_user_atomic() is the last remaining user of
iterate_all_kinds(), and we could just as well make its replacement use
iterate_and_advance() instead.  Callers can revert if they end up using
only a part of what's been copied.  Replacement primitive is called
copy_page_from_iter_atomic(), all callers converted.

	With that we are rid of the last user of iterate_all_kinds().  RIP.
What's more, all remaining users of iterate_and_advance() are copying
stuff to/from iterator - they actually access the data, not just counting
pages, etc.

(21/37)  csum_and_copy_to_iter(): massage into form closer to csum_and_copy_from_iter()
	Namely, have off counted starting from 0 rather than from csstate->off.
It's not hard to do so - in case of odd initial offset, just rotate the
initial sum by 8 bits and do the same to result.
	What we get out of that is a bit more redundancy in our variables - from
is always equal to addr + off, which will be useful several commits down the road.
We could mix that into the next series, but that would make it harder to follow.

	Part 4: iterate_and_advance() massage

	By that point we are down to iterate_and_advance() alone.
There are several problems with it:
	* misguided attempts at microoptimizations in iterate_iovec/iterate_kvec
	* only iovec side is ready to deal with short copies; that used to be
OK, but copy_mc_to_iter() can run into short copies on any flavour.  It tries to
cope, but that's inconsistent and not pretty, to put it mildly
	* each of those gets 4 callbacks - for iovec, bvec, kvec and xarray cases.
First of all, xarray and bvec cases are essentially identical.  Furthermore, both
are easily derived from kvec one.
	* there's an additional headache due to the need to maintain the offset in
source or destination of all those copies.   Leads to boilerplate all over the place;
iterate_iovec() et.al. could easily keep track of that stuff.

	The next group massages this stuff to deal with all that fun.  By the end of
that the users go from things like
	iterate_and_advance(i, bytes, v,
		__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
					 v.iov_base, v.iov_len),
		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
				 v.bv_offset, v.bv_len),
		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
				 v.bv_offset, v.bv_len)
	)
to
	iterate_and_advance(i, bytes, base, len, off,
		__copy_from_user_inatomic_nocache(addr + off, base, len),
		memcpy(addr + off, base, len)
	)
and generated code shrinks quite a bit.

(22/37)  iterate_and_advance(): get rid of magic in case when n is 0
	One irregularity had been the handling of case when requested length
is 0.  We don't need to bother with that anymore, now that the only user
that cared about that (iov_iter_advance()) is not using iterate_and_advance().
For everything else length 0 should be a no-op.

(23/37)  iov_iter: massage iterate_iovec and iterate_kvec to logics similar to iterate_bvec
	Attempts to handle the first (partial) segment separately
had actually lead to worse code; better let the compiler deal with
optimizations.  Part of that had been the need to reuse iterate_iovec()
and iterate_kvec() among the advancing and non-advancing iterator macros. 
The latter is gone now, allowing to simplify things.

(24/37)  iov_iter: unify iterate_iovec and iterate_kvec
	Essentially identical now; the only difference is that iovec knows
about the possibility of short copies.

(25/37)  iterate_bvec(): expand bvec.h macro forest, massage a bit
	The logics is not changed, but now one does not follow 4 levels of
macros buried in bvec.h to understand what's going on.  That matters for
the next step, when we teach the sucker about the possibility of short
copies.
	
(26/37)  iov_iter: teach iterate_{bvec,xarray}() about possible short copies
	... allowing to kill "returns in the callback" mess in copy_mc_to_iter()

(27/37)  iov_iter: get rid of separate bvec and xarray callbacks
	payoff of the previous commit - now the relationship between bvec, kvec
and xarray callbacks has lost the last irregularities; we can reduce the
callbacks just to "userland" and "kernel" variants.

(28/37)  iov_iter: make the amount already copied available to iterator callbacks
	teach iterate_...() to keep track of the amount we'd already copied.
Kills quite a bit of boilerplate in users.

(29/37)  iov_iter: make iterator callbacks use base and len instead of iovec
	we used to let the callbacks play with struct iovec, bvec and kvec resp.
With the unifications above it's always struct iovec or struct kvec.  Might
as well pass pointer (userland or kernel one) and length separately.

(30/37)  pull handling of ->iov_offset into iterate_{iovec,bvec,xarray}
	clean iterate_iovec() et.al. a bit.

	Part 5: followup cleanups

(31/37)  iterate_xarray(): only of the first iteration we might get offset != 0
(32/37)  copy_page_to_iter(): don't bother with kmap_atomic() for bvec/kvec cases
(33/37)  copy_page_from_iter(): don't need kmap_atomic() for kvec/bvec cases
(34/37)  iov_iter: clean csum_and_copy_...() primitives up a bit
(35/37)  pipe_zero(): we don't need no stinkin' kmap_atomic()...
(36/37)  clean up copy_mc_pipe_to_iter()
(37/37)  csum_and_copy_to_pipe_iter(): leave handling of csum_state to caller
