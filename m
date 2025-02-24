Return-Path: <linux-fsdevel+bounces-42403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE30A41E18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F9D188CE1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE323C8C9;
	Mon, 24 Feb 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nedADxEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A323BCE0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397554; cv=none; b=BKQ8ocWrJ6S+6uk9laBd8SFRa/aPei0XK/5xvg/JdX+QXbt+V4zTNASAwJpu6hrCrZ8LMi747aAgFtEqsZ5QILhp2KhkGijqOr2+YdCo2qKMYHM7GezW/O8RHFr7YBbBekwP0I6+DoMHX7vPS5XTb3fAw3GmRQ2dbCCZeStNS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397554; c=relaxed/simple;
	bh=c25mZHH4hauYBmgnyNCNtVgw4CnRktlj43MxpkjnCcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWZcCfBgwUe9hkINLSXHLMBydRj9wnOi3MHyaFAjQxMtgERIK4MZuJ/M1k/tm48pL4vuXFsKdiQFJK7dCyfonUEKW/qjUF/8V7OATGFSusTF8rPDzFIEPlglGHNeKH5Rv07ZRKg0hGS73B/bVIhfeuHQwkQuINk+xnM+WTnS44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nedADxEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7647C4CED6;
	Mon, 24 Feb 2025 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740397553;
	bh=c25mZHH4hauYBmgnyNCNtVgw4CnRktlj43MxpkjnCcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nedADxEEgOSWC84eu925WEEPupVOxpZu+by7ppXsZL20BkYCNoGPmkIEUFhSRiSOA
	 9hDC5q4ln1G1ccUKt6w+opld/e9CrcObaKsmUCZL13iqYOqiJ7YNNAiKQdKqrV2bln
	 WZsMaxBPLmRiTxrvncqtSH4ANpq7PvecjDlq5bOkjlBXASytYkOQHy1L4W1AOOZIfV
	 q/oo3OBive+b7+boyEiGwCkP8VEYAz+yKgvZWtGVxTNN5PRxp71EEK11EpmmXTsXIk
	 RvZrqqpPhqiUlrXXpy1qg6an6hraZaQS1pM05GO6Pu50qsbYU6kC5sjdTPd4oxxJ1o
	 1cgfclbNWN+XA==
Date: Mon, 24 Feb 2025 12:45:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250224-anrief-schwester-33e6ca8774de@brauner>
References: <20250224010624.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224010624.GT1977892@ZenIV>

On Mon, Feb 24, 2025 at 01:06:24AM +0000, Al Viro wrote:
> 	Recently I went looking through the ->d_flags locking (long
> story, that was a side branch in digging through the issues with
> Neil's locking scheme); results are interesting.
> 
> 	All stores to dentry->d_flags are done by somebody who
> * holds a counting reference to dentry or
> * has found a counting reference in shared data structures, in
> conditions that guarantee that this reference won't go away or
> * has found dentry in alias list of some inode (under ->i_lock)
> * [fs/dcache.c only] is an LRU walker callback running into that dentry
> in LRU list or
> * [fs/dcache.c only] is owner of a shrink list running into dentry in that
> list or
> * [fs/dcache.c only] is a d_walk() callback running into that dentry with zero
> refcount (and moving it to shrink list) or
> * [fs/dcache.c only] is a d_walk() called by kill_litter_super() running into
> that dentry when unpinning theretofore persistent dentries; that can happen
> only during filesystem shutdown, when nobody else could be accessing it.
> 
> 	The above guarantees that dentry won't disappear under us;
> another interesting thing is exclusion, and that's where the things
> get nasty.  Most of the stores to dentry->d_flags are under
> dentry->d_lock.  There are obvious exceptions on the allocation side
> (stores done to dentry that is not visible to anybody else), but aside
> of those there are two exceptions.
> 
> 	One is d_set_d_op(), another - setting DCACHE_PAR_LOOKUP in
> d_alloc_parallel().
> 
> 	The former sets ->d_op and marks the presense of several methods
> (->d_hash(), ->d_compare(), ->d_revalidate(), ->d_weak_revalidate(),
> ->d_delete(), ->d_prune() and ->d_real()) in ->d_flags.
> 
> 	It can't be done more than once and, if the filesystem
> has ->s_d_op set in its superblock, it is done by the constructor
> (__d_alloc()).	That, obviously, falls under the "on allocation side";
> so does another common case - d_alloc_pseudo() setting ->d_op to &anon_ops
> if __d_alloc() hadn't set it to ->s_d_op.
> 
> 	Note that there's no barriers between the stores to ->d_op and
> ->d_flags in d_set_d_op(); for allocation time uses that's not a problem -
> fetches on another CPU would have to be preceded by finding the dentry
> in the first place, and barriers on the insertion into wherever it
> had been found would suffice.
> 
> 	There are other callers of d_set_d_op(), though - one in
> simple_lookup() (again, if ->s_d_op is NULL) and the rest are all in
> procfs.  Those are done with no locking whatsoever and dentry is *not*
> entirely invisible.
> 
> 	It's mostly invisible, though - in all those cases dentry is
> * negative, and thus unreachable via the alias list of any inode
> * unhashed, and thus can't be found via dcache lookup
> * has the only direct reference held by the caller who has been holding
> it since it got allocated (i.e. it couldn't have been put into LRU or
> shrink lists either).
> 
> 	That is enough to guarantee that nobody else will be doing stores
> to ->d_flags, so our store is safe even without ->d_lock.  It is also
> fucking ugly and brittle...
> 
> 	Moreover, the question about ->d_op vs ->d_flags ordering also
> needs to be dealt with - unlike the calls at allocation time, insertion
> into wherever it had been found does *not* order fetches past both
> stores - not if it had been inserted into that wherever before the
> call of d_set_d_op().
> 
> 	Thankfully, the set of methods present in dentry_operations
> ever fed to those late calls of d_set_d_op() is limited: ->d_revalidate,
> ->d_delete and, in one case, ->d_compare.
> 
> 	->d_delete() is easy - it's called only from one place (retain_dentry())
> and there we have just dropped the last reference to dentry in question.
> Since the caller of d_set_d_op() is holding a reference, the usual barriers
> on ->d_reflock use are enough.
> 
> 	->d_compare() is a bit confusing - dentry it's getting as argument
> is not the one whose method it is.  We have the parent (already observed
> to be positive) and we are checking if this child (with ->d_parent pointing
> to parent) matches the name we want to look up.  We take parent's
> ->d_compare() and give it child dentry, snapshot of child's name and the
> name we want to match it against.
> 	We *CAN* get a dentry in the middle of d_set_d_op() passed to
> someone's ->d_compare() - d_alloc_parent() does that to check if there's
> an in-lookup dentry matching the name we want.  But ->d_compare() comes
> from parent, and that had been already observed to be positive.  Which means
> that barriers in __d_set_inode_and_type() (from d_splice_alias()) suffice.
> 
> 	->d_revalidate() is only called for dentries that had been found
> in dcache hash chains at some point, so there the barrier on insertion into
> hash (in __d_add() from d_splice_alias()) is enough.
> 
> 	That covers d_set_d_op() callers; another exception is
> d_alloc_parallel() when it decides to insert a new dentry into in-lookup
> hash and marks it with DCACHE_PAR_LOOKUP.  Also safe, since dentry is
> only visible in the parent's list of children, has positive refcount and
> had it all along, so nobody else would try to do a store to ->d_flags
> at the same time.
> 
> 	In case it's not obvious from the above, I'm less than happy with
> the entire thing - it may be provably correct, but it's much too brittle.
> 
> 	If nothing else, d_set_d_op() should be unexported.  Do it to

Agreed.

> a hashed or, worse, a positive dentry and you are asking for serious
> trouble.  Leaving it as a public API is a really bad idea.
> 
> 	Something along the lines of d_splice_alias_ops(inode, dentry, ops)
> (not exported, until we get a convincing modular user) is worth doing;
> all procfs callers of d_set_d_op() follow it with d_splice_alias() pretty
> much immediately.  And yes, that could be done under ->d_lock, eliminating
> that special case from the proof.

That sounds great.

> 
> 	As for the allocation-time uses...  We could bloody well calculate
> the ->d_flags bits to go along with ->s_d_op and just use that; it's not
> just about getting rid of recalculating them for each dentry ever allocated
> on the filesystem in question, we could get rid of quite a few always_delete_dentry
> users while we are at it.

See my reply to your other mail: I'll kill it for pidfs and nsfs.

> 
> 	Look: ->d_delete == always_delete_dentry (and DCACHE_OP_DELETE to
> go with it) is equivalent to DCACHE_DONTCACHE; the only place where we

Also mentioned in my other reply: Can you please make the unhashed case
really explicit ideally at dentry allocation time. IOW, that there's a
flag or some other way of simply identifying a dentry as belonging to an
fs that will never hash them?

> look at either is retain_dentry(), where we have this:
>         // ->d_delete() might tell us not to bother, but that requires
>         // ->d_lock; can't decide without it
>         if (unlikely(d_flags & DCACHE_OP_DELETE)) {
>                 if (!locked || dentry->d_op->d_delete(dentry))
>                         return false;
>         }
> 
>         // Explicitly told not to bother
>         if (unlikely(d_flags & DCACHE_DONTCACHE))
>                 return false;
> The inner if turns into
> 		if (!locked || 1)
> 			return false;
> so for those DCACHE_DONTCACHE would be equivalent.  And it could be
> put into the same "set those bits in all ->d_flags on that fs";
> what's more, simple_lookup() doesn't need to set ->d_op at all -
> it can just set DCACHE_DONTCACHE in the unlikely case when it's
> not been already set.
> 
> 	How about something along the lines of
> 0) add d_splice_alias_ops(inode, dentry, dops), have procfs switch
> to that.
> 1) provide set_default_d_op(superblock, dops), use it in place of
> assignments to ->s_d_op.  Rename ->s_d_op to catch unconverted
> filesystems.  Tree-wide, entirely mechanical.
> 2) split the calculation of d_flags bits into a separate helper,
> add ->s_d_flags, have set_default_d_op() calculate and set
> that, have __d_alloc() pick ->s_d_op and ->s_d_flags directly.
> 3) convert those who wish to move from use of always_delete_dentry
> to adding DCACHE_DONTCACHE into ->s_d_flags.  For devpts, for
> example, that avoids the need of non-NULL ->d_op.
> 4) replace d_set_d_op() in simple_lookup() with
> 	if (unlikely(!(dentry->d_flags & DCACHE_DONTCACHE))) {
> 		spin_lock(&dentry->d_lock);
> 		dentry->d_flags |= DCACHE_DONTCACHE;
> 		spin_unlock(&dentry->d_lock);
> 	}
> 5) Kill simple_dentry_operations - no users would be left
> 6) make d_set_d_op() static in fs/dcache.c

Sounds good.

