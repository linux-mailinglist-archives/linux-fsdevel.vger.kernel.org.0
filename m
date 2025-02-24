Return-Path: <linux-fsdevel+bounces-42371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D5A4128F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570ED16C603
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095D3FBB3;
	Mon, 24 Feb 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hxUthlYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F81B7F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359190; cv=none; b=VoPyE2HQj94Wn4QOJMlYA2ebb/8KF5cpQ0xZ4nR19oGqc5EYy4zvLj4weHkV3dpoP/LfNsVh504LYBZ0unAUMkZ1nj8SRP5R0hx41QtxkadNv5K3fFUAoCU4M/U4YlfWKnaDtpqOzzCv6TdTc5CD2vxc0OwEJwogZPkrtWT4WA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359190; c=relaxed/simple;
	bh=R322m38iLz0yOLyAUGYwwB71NCxyTIoPI/jticofwhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NAsVHiQ5Pq6azAXnbDY+B7DxUF+Lc3QWiZrEBb5laf2Qci6QZhpYpvikHU9d/V5xIp2OEo/yjs9Yo98nNOz9YrZQ9EJuNOVCNMset2F0TEEnn8DeufpJh5mGY9VYjzKgk/XjLOh37v6fLxPWL7LsgLFJJFd9lxEaeN+Ozy4qOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hxUthlYU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cRA9K7g9Aa2u4sJljqkiDsPdwuuaUgjVyE9rtRasVCA=; b=hxUthlYUMmntfxrzUqxbybKpo+
	mhn0MvhaWGbm6LN70Qg3jFpZhxJ9tOxAOQOPa+QkdPGiF6Dp0JyngwrQcEwxORpmCakKPxiGD7Qf1
	s5ciS53jM3Cs2T+NkVuDN3uI8VIvpGWjC5U+j6pKphIa5iHqXjYVggiRW7GLCPU85nlAJMV6DMLmQ
	CxiAhv4IUQOsPCeMqc53YoTitu187hBchA1aN0ha6s9AA5zJDSLMwZJgW5t6tbwLDBJAH6APL9RHC
	ep21XU6iqh5swtDFIQaADV4T9jsR7NgGCFSZu4TtpwDz/3UPYLW//XIQZ+WvH81L7faUMuAbiydSF
	bzYYM9Dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmMvQ-00000006YAb-3XSC;
	Mon, 24 Feb 2025 01:06:25 +0000
Date: Mon, 24 Feb 2025 01:06:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC] dentry->d_flags locking
Message-ID: <20250224010624.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Recently I went looking through the ->d_flags locking (long
story, that was a side branch in digging through the issues with
Neil's locking scheme); results are interesting.

	All stores to dentry->d_flags are done by somebody who
* holds a counting reference to dentry or
* has found a counting reference in shared data structures, in
conditions that guarantee that this reference won't go away or
* has found dentry in alias list of some inode (under ->i_lock)
* [fs/dcache.c only] is an LRU walker callback running into that dentry
in LRU list or
* [fs/dcache.c only] is owner of a shrink list running into dentry in that
list or
* [fs/dcache.c only] is a d_walk() callback running into that dentry with zero
refcount (and moving it to shrink list) or
* [fs/dcache.c only] is a d_walk() called by kill_litter_super() running into
that dentry when unpinning theretofore persistent dentries; that can happen
only during filesystem shutdown, when nobody else could be accessing it.

	The above guarantees that dentry won't disappear under us;
another interesting thing is exclusion, and that's where the things
get nasty.  Most of the stores to dentry->d_flags are under
dentry->d_lock.  There are obvious exceptions on the allocation side
(stores done to dentry that is not visible to anybody else), but aside
of those there are two exceptions.

	One is d_set_d_op(), another - setting DCACHE_PAR_LOOKUP in
d_alloc_parallel().

	The former sets ->d_op and marks the presense of several methods
(->d_hash(), ->d_compare(), ->d_revalidate(), ->d_weak_revalidate(),
->d_delete(), ->d_prune() and ->d_real()) in ->d_flags.

	It can't be done more than once and, if the filesystem
has ->s_d_op set in its superblock, it is done by the constructor
(__d_alloc()).	That, obviously, falls under the "on allocation side";
so does another common case - d_alloc_pseudo() setting ->d_op to &anon_ops
if __d_alloc() hadn't set it to ->s_d_op.

	Note that there's no barriers between the stores to ->d_op and
->d_flags in d_set_d_op(); for allocation time uses that's not a problem -
fetches on another CPU would have to be preceded by finding the dentry
in the first place, and barriers on the insertion into wherever it
had been found would suffice.

	There are other callers of d_set_d_op(), though - one in
simple_lookup() (again, if ->s_d_op is NULL) and the rest are all in
procfs.  Those are done with no locking whatsoever and dentry is *not*
entirely invisible.

	It's mostly invisible, though - in all those cases dentry is
* negative, and thus unreachable via the alias list of any inode
* unhashed, and thus can't be found via dcache lookup
* has the only direct reference held by the caller who has been holding
it since it got allocated (i.e. it couldn't have been put into LRU or
shrink lists either).

	That is enough to guarantee that nobody else will be doing stores
to ->d_flags, so our store is safe even without ->d_lock.  It is also
fucking ugly and brittle...

	Moreover, the question about ->d_op vs ->d_flags ordering also
needs to be dealt with - unlike the calls at allocation time, insertion
into wherever it had been found does *not* order fetches past both
stores - not if it had been inserted into that wherever before the
call of d_set_d_op().

	Thankfully, the set of methods present in dentry_operations
ever fed to those late calls of d_set_d_op() is limited: ->d_revalidate,
->d_delete and, in one case, ->d_compare.

	->d_delete() is easy - it's called only from one place (retain_dentry())
and there we have just dropped the last reference to dentry in question.
Since the caller of d_set_d_op() is holding a reference, the usual barriers
on ->d_reflock use are enough.

	->d_compare() is a bit confusing - dentry it's getting as argument
is not the one whose method it is.  We have the parent (already observed
to be positive) and we are checking if this child (with ->d_parent pointing
to parent) matches the name we want to look up.  We take parent's
->d_compare() and give it child dentry, snapshot of child's name and the
name we want to match it against.
	We *CAN* get a dentry in the middle of d_set_d_op() passed to
someone's ->d_compare() - d_alloc_parent() does that to check if there's
an in-lookup dentry matching the name we want.  But ->d_compare() comes
from parent, and that had been already observed to be positive.  Which means
that barriers in __d_set_inode_and_type() (from d_splice_alias()) suffice.

	->d_revalidate() is only called for dentries that had been found
in dcache hash chains at some point, so there the barrier on insertion into
hash (in __d_add() from d_splice_alias()) is enough.

	That covers d_set_d_op() callers; another exception is
d_alloc_parallel() when it decides to insert a new dentry into in-lookup
hash and marks it with DCACHE_PAR_LOOKUP.  Also safe, since dentry is
only visible in the parent's list of children, has positive refcount and
had it all along, so nobody else would try to do a store to ->d_flags
at the same time.

	In case it's not obvious from the above, I'm less than happy with
the entire thing - it may be provably correct, but it's much too brittle.

	If nothing else, d_set_d_op() should be unexported.  Do it to
a hashed or, worse, a positive dentry and you are asking for serious
trouble.  Leaving it as a public API is a really bad idea.

	Something along the lines of d_splice_alias_ops(inode, dentry, ops)
(not exported, until we get a convincing modular user) is worth doing;
all procfs callers of d_set_d_op() follow it with d_splice_alias() pretty
much immediately.  And yes, that could be done under ->d_lock, eliminating
that special case from the proof.

	As for the allocation-time uses...  We could bloody well calculate
the ->d_flags bits to go along with ->s_d_op and just use that; it's not
just about getting rid of recalculating them for each dentry ever allocated
on the filesystem in question, we could get rid of quite a few always_delete_dentry
users while we are at it.

	Look: ->d_delete == always_delete_dentry (and DCACHE_OP_DELETE to
go with it) is equivalent to DCACHE_DONTCACHE; the only place where we
look at either is retain_dentry(), where we have this:
        // ->d_delete() might tell us not to bother, but that requires
        // ->d_lock; can't decide without it
        if (unlikely(d_flags & DCACHE_OP_DELETE)) {
                if (!locked || dentry->d_op->d_delete(dentry))
                        return false;
        }

        // Explicitly told not to bother
        if (unlikely(d_flags & DCACHE_DONTCACHE))
                return false;
The inner if turns into
		if (!locked || 1)
			return false;
so for those DCACHE_DONTCACHE would be equivalent.  And it could be
put into the same "set those bits in all ->d_flags on that fs";
what's more, simple_lookup() doesn't need to set ->d_op at all -
it can just set DCACHE_DONTCACHE in the unlikely case when it's
not been already set.

	How about something along the lines of
0) add d_splice_alias_ops(inode, dentry, dops), have procfs switch
to that.
1) provide set_default_d_op(superblock, dops), use it in place of
assignments to ->s_d_op.  Rename ->s_d_op to catch unconverted
filesystems.  Tree-wide, entirely mechanical.
2) split the calculation of d_flags bits into a separate helper,
add ->s_d_flags, have set_default_d_op() calculate and set
that, have __d_alloc() pick ->s_d_op and ->s_d_flags directly.
3) convert those who wish to move from use of always_delete_dentry
to adding DCACHE_DONTCACHE into ->s_d_flags.  For devpts, for
example, that avoids the need of non-NULL ->d_op.
4) replace d_set_d_op() in simple_lookup() with
	if (unlikely(!(dentry->d_flags & DCACHE_DONTCACHE))) {
		spin_lock(&dentry->d_lock);
		dentry->d_flags |= DCACHE_DONTCACHE;
		spin_unlock(&dentry->d_lock);
	}
5) Kill simple_dentry_operations - no users would be left
6) make d_set_d_op() static in fs/dcache.c

I'll put together something along those lines and post it
later today.

With that done, the last remaining store to ->d_flags without
->d_lock would be in d_alloc_parallel(); it can be killed off
(we could set it in new->d_flags before anyone sees that
dentry), the only reason I'd left that to actual insertion
into in-lookup hash chain is that DCACHE_PAR_LOOKUP currently
corresponds to "it's in in-lookup hash, what would've been
->d_alias is occupied by that hash chain" and at some point
I think we had final dput() scream bloody murder if it saw
such a dentry.

Hell knows...  d_alloc_parallel() is going to be heavily affected
by any locking reworks; what should be done with that wart
depends upon the direction we take for that work.

PS: turns out that set_default_d_op() is slightly more interesting
than I expected - fuse has separate dentry_operations for its
root dentry.  I don't see the point, TBH - the only difference is
that root one lacks
	* ->d_delete() (never even called for root dentry; it's
only called if d_unhashed() is false)
	* ->d_revalidate() (never called for root)
	* ->d_automount() (not even looked at unless you have
S_AUTOMOUNT set on the inode).
What's wrong with using fuse_dentry_operations for root dentry?
Am I missing something subtle here?  Miklos?

