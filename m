Return-Path: <linux-fsdevel+bounces-25222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE249949F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCE11C228FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFDA1922ED;
	Wed,  7 Aug 2024 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EGdCshzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C71E520;
	Wed,  7 Aug 2024 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008757; cv=none; b=gOFzCZ2KDapExTnaOnjTSwf3H3Iq8wdNbflGELwPfeDhNmVLITiWo1rpZOiUFHskTBv/KVxRhO06KyY1KzwEA026w6BcUGxIUr9PnKFZcscn/lyOiSJSEFDoi8FUX3h5MUEHZynmh48rswghSqjEdouE4TkeSGwy/2gGFC15xOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008757; c=relaxed/simple;
	bh=ZkBZ0byMgmjUuPG+MyDT/wiTBJ/ydUIv6GJH2V1857E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df5GTzhOOL5qfQMRB1gA5PwgbqBYu6NbRQe7zTPdkIEf2Csw07Mui8gSrdZ7bszupm9FAikfO02Ql1qsJA+GZc7Wh1wMYXLDs5XLB3uqmis/1R0+VetXJwPOL6JKPgqUFr7r6BH3MsP6qd+MwN/9XOl3iNULrklHK7JRxHNgQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EGdCshzm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EOUBtwgLZEUBaDmDpKPA0pIpMbLTWeiPWlAQUZXNBXc=; b=EGdCshzmIgauEjUen8KNBP/ZRW
	Wrs16cnqrmeKSM+9FUQ54gZXBMuhCKCe+KKibB5Z5X738GZRoLjWZBmHDcIgNEeHn2WvWELtOKWxa
	8jxdP19Gj2+YGClKGVBYAG1TY4tpCodgOsnJodNskZRBhkW28nGZ2krnl8D+T1R1FTae0kblkYtKb
	gwhTl0HU+aktODVl7K53hdjf/2ZLdC9nM39oJ4u9+gcsb50iEyT2uywjYbS4i1fMFQqyQHo6/gbuU
	TO68uUKXrtNlfTw+QYViOOGIvF7uWnDSjfexW1gNKh9Ku+Q9tmGbROC/899PLSSuwBYi5n+FCRYet
	R5/4n7Yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbZHk-00000002Eop-2MrV;
	Wed, 07 Aug 2024 05:32:32 +0000
Date: Wed, 7 Aug 2024 06:32:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807053232.GT5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV>
 <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 05:57:07AM +0200, Mateusz Guzik wrote:

[there'll be a separate reply with what I hope might be a usable
approach]

> Yes, this is my understanding of the code and part of my compliant. :)
> 
> Things just work(tm) as is with NULLified pointers, but this is error-prone.

And carrying the arseloads of information (which ones do and which do not
need to be dropped) is *less* error-prone?  Are you serious?

> As a hypothetical suppose there is code executing some time after
> vfs_open which looks at nd->path.dentry and by finding the pointer is
> NULL it concludes the lookup did not work out.
> 
> If such code exists *and* the pointer is poisoned in the above sense
> (notably merely branching on it with kasan already traps), then the
> consumer will be caught immediately during coverage testing by
> syzkaller.

You are much too optimistic about the quality of test coverage in this
particular area.

> If such code exists but the pointer is only nullified, one is only
> going to find out the hard way when some functionality weirdly breaks.

To do _useful_ asserts, one needs invariants to check.  And "we got
to this check after having passed through that assignment at some
earlier point" is not it.  That's why I'm asking questions about
the state.

The thing is, suppose I (or you, or somebody else) is trying to modify
the whole thing.  There's a magical mystery assert in the way; what
should be done with it?  Move it/split it/remove it/do something
random and hope syzkaller won't catch anything?  If I can reason
about the predicate being checked, I can at least start figuring out
what should be done.  If not, it's bloody guaranteed to rot.

This particular area (pathwalk machinery) has a nasty history of
growing complexity once in a while, with following cleanups and
massage to get it back into more or less tolerable shape.
And refactoring that had been _painful_ - I'd done more than
a few there.

As far as I can tell, at the moment this flag (and yes, I've seen its
removal in the next version) is "we'd called vfs_open_consume() at
some point, then found ourselves still in RCU mode or we'd called
vfs_open_consume() more than once".

This is *NOT* a property of state; it's a property of execution
history.  The first part is checked in the wrong place - one of
the invariants (trivially verified by code examination) is that
LOOKUP_RCU is never regained after it had been dropped.  The
only place where it can be set is path_init() and calling _that_
between path_init() and terminate_walk() would be
	a) a hard and very visible bug
	b) would've wiped your flag anyway.
So that part of the check is basically "we are not calling
vfs_open_consume() under rcu_read_lock()".  Which is definitely
a desirable property, since ->open() can block.  So can
mnt_want_write() several lines prior.  Invariant here is
"the places where we set FMODE_OPENED or FMODE_CREATED may
not have LOOKUP_RCU".  Having
        if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
		error = complete_walk(nd);
		if (error)
			return error;
	}
in the beginning of do_open() guarantees that for vfs_open()
call there.  All other places where that can happen are in
lookup_open() or called from it (via ->atomic_open() to
finish_open()).  And *that* definitely should not be done
in RCU mode, due to
        if (open_flag & O_CREAT)
                inode_lock(dir->d_inode);
        else
                inode_lock_shared(dir->d_inode);
        dentry = lookup_open(nd, file, op, got_write);
in the sole caller of that thing.  Again, can't grab a blocking
lock under rcu_read_lock().  Which is why we have this
                if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
                        return ERR_PTR(-ECHILD);
        } else {
                /* create side of things */
                if (nd->flags & LOOKUP_RCU) {
                        if (!try_to_unlazy(nd))
                                return ERR_PTR(-ECHILD);
                }
slightly prior to that call.  WARN_ON_ONCE is basically "lookup_fast()
has returned NULL and stayed in RCU mode", which should never happen.
try_to_unlazy() is straight "either switch to non-RCU mode or return an
error" - that's what this function is for.  No WARN_ON after that - it
would only obfuscate things.

*IF* you want to add debugging checks for that kind of stuff, just call
that assert_nonrcu(nd), make it check and whine and feel free to slap
them in reasonable amount of places (anything that makes a reader go
"for fuck sake, hadn't we (a) done that on the entry to this function
and (b) done IO since then, anyway?" is obviously not reasonable, etc. -
no more than common sense limitations).

Another common sense thing: extra asserts won't confuse syzkaller, but
they very much can confuse a human reader.  And any rewrites are done
by humans...

As for the double call of vfs_open_consume()...  You do realize that
the damn thing wouldn't have reached that check if it would ever have
cause to be triggered, right?  Seeing that we call
static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
{
        /* Pairs with smp_store_release() in do_idmap_mount(). */
        return smp_load_acquire(&mnt->mnt_idmap);
}
near the beginning of do_open(), ~20 lines before the place where
you added that check...

I'm not sure it makes sense to defend against a weird loop appearing
out of nowhere near the top of call chain, but if you want to do that,
this is not the right place for that.

