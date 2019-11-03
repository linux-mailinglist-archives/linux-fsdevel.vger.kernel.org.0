Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E287ED39A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKCOlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 09:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfKCOlL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 09:41:11 -0500
Received: from paulmck-ThinkPad-P72.home (28.234-255-62.static.virginmediabusiness.co.uk [62.255.234.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CFD20679;
        Sun,  3 Nov 2019 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572792069;
        bh=0YStxeRqFY8gXgXnkpgy5bxJi1uu8ndDck+oqaM1Dug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R7mXUNGAIkujaSvopF2S9oGbwrLCL+8YWGEdbvplTJxuChiIy6iXJZ3qD7H7Rp3sp
         ttrjnqTvLBRo2VAzHMLx9bp6fcr8nQaM5ou9j6BSW2rB6juNkj8tjsuYMrdlWeDwcG
         6zx6V9EipKK5M31jLzaOozDtOid2qAc6waUgSr3A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 12689352038A; Sun,  3 Nov 2019 06:41:07 -0800 (PST)
Date:   Sun, 3 Nov 2019 06:41:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191103144107.GW20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102180842.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:08:42PM +0000, Al Viro wrote:
> On Sat, Nov 02, 2019 at 10:22:29AM -0700, Paul E. McKenney wrote:
> > Ignoring the possibility of the more exotic compiler optimizations, if
> > the first task's load into f sees the value stored by the second task,
> > then the pair of memory barriers guarantee that the first task's load
> > into d will see the second task's store.
> 
> The question was about the load into i being also safe.
> 
> > In fact, you could instead say this in recent kernels:
> > 
> > 	f = READ_ONCE(fdt[n])  // provides dependency ordering via mb on Alpha
> > 	mb
> 
> Er... that mb comes from expanded READ_ONCE(), actually - the call chain
> is
> 	fdget_pos() -> __fdget_pos() -> __fdget() -> __fget_light() ->
> 	__fcheck_files(), either directly or via
> 			__fget() -> fcheck_files() -> __fcheck_files()
> 	rcu_dereference_raw() -> READ_ONCE() -> smp_read_barrier_depends()
> which yields mb on alpha.

Exactly.  But yes, my "provides dependency ordering via mb on Alpha"
comment was not as clearly stated as it should have been.  Something about
my having dispensed with proofreading in order to catch my plane...  :-/

> > 	d = f->f_path.dentry
> > 	i = d->d_inode  // But this is OK only if ->f_path.entry is
> > 			// constant throughout
> 
> Yes, it is - once you hold a reference to a positive dentry, it can't
> be made negative by anybody else.  See d_delete() for details; basically,
> if you have refcount > 1, dentry will be unhashed, but not made negative.

Very good, then.  At least assuming that you are double-checking the ordering
(as opposed to trying to figure out what is wrong with the ordering).  ;-)

> > The result of the first task's load into i requires information outside
> > of the two code fragments.
> > 
> > Or am I missing your point?
> 
> My point is that barriers sufficient to guarantee visibility of *f in
> the reader will also suffice to guarantee visibility of *f->f_path.dentry.
> 
> On alpha it boils down to having load of d->d_inode when opening the
> file orders before the barrier prior to storing the reference to f
> in the descriptor table, so if it observes the store to d->d_inode done
> by the same CPU, that store is ordered before the barrier due to
> processor instruction order constraints and if it observes the store
> to d->d_inode done by some other CPU, that store is ordered before
> the load and before the barrier by transitivity.  So in either case
> that store is ordered before the store into descriptor table.
> IOW, the reader that has enough barriers to guarantee seing ->f_path.dentry
> will be guaranteed to see ->f_path.dentry->d_inode.
> 
> And yes, we will need some barriers added near some positivity checks in
> pathname resolution - that's what has started the entire thread.  This
> part ("any place looking at file->f_path.dentry will have ->d_inode and
> mode bits of ->d_flags visible and stable") covers quite a few places
> that come up in the analysis...
> 
> This morning catch, BTW:
> 
>     audit_get_nd(): don't unlock parent too early
>     
>     if the child has been negative and just went positive
>     under us, we want coherent d_is_positive() and ->d_inode.
>     Don't unlock the parent until we'd done that work...
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 1f31c2f1e6fc..4508d5e0cf69 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -351,12 +351,12 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
>         struct dentry *d = kern_path_locked(watch->path, parent);
>         if (IS_ERR(d))
>                 return PTR_ERR(d);
> -       inode_unlock(d_backing_inode(parent->dentry));
>         if (d_is_positive(d)) {
>                 /* update watch filter fields */
>                 watch->dev = d->d_sb->s_dev;
>                 watch->ino = d_backing_inode(d)->i_ino;
>         }
> +       inode_unlock(d_backing_inode(parent->dentry));
>         dput(d);
>         return 0;
>  }
> 
> For other fun bits and pieces see ceph bugs caught this week and crap in
> dget_parent() (not posted yet).  The former had been ceph violating the
> "turning a previously observable dentry positive requires exclusive lock
> on parent" rule, the latter - genuine insufficient barriers in the fast
> path of dget_parent().
> 
> It is converging to a reasonably small and understandable surface, actually,
> most of that being in core pathname resolution.  Two big piles of nightmares
> left to review - overlayfs and (somewhat surprisingly) setxattr call chains,
> the latter due to IMA/EVM/LSM insanity...
> 
> There's also some secondary stuff dropping out of that (e.g. ceph seeding
> dcache on readdir and blindly unhashing dentries it sees stale instead of
> doing d_invalidate() as it ought to - leads to fun results if you had
> something mounted on a subdirectory that got removed/recreated on server),
> but that's a separate pile of joy - doesn't affect this analysis, so
> it'll have to be dealt with later.  It had been an interesting couple of
> weeks...

Looks like you are making a very productive (if perhaps somewhat painful)
tour through the code, good show!

							Thanx, Paul
