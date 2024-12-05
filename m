Return-Path: <linux-fsdevel+bounces-36566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE39E5F35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558F316B5EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1F225781;
	Thu,  5 Dec 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDFqA/bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A62EB1F;
	Thu,  5 Dec 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428868; cv=none; b=ftCCmRFXUPT+FusP6qlvC/63MCLtvQ1usy3cprBrbQPpAUfTt6mUJDnixqKMqXk5m0G0gkhW4Qsd3qLSl5vcjrYtcYd+1PF2fKzmEEljHLSql7cCvXasI47xREPETdlhNBYccIqQ7nFxE3jhxjZP1PUAvjataOMiPyavT6CqdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428868; c=relaxed/simple;
	bh=OhkwOeu9XnLmPUB+pIA/JrXoeOZMruEMRrO3YTd2x2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuvQKXCFKTnQ8i5YDq2Fcq+w+t42D+koC7FrVLcQSL9ZsZoPdjcuZpNi/YBJHSRRbzeIfRY0fh4GkSjH3I3AdwAcPNlloKZHPNWS/54bjr+NDR5isanFs8tysjAuV0aoP7/wPTKWfcTojTyr2jIwCRIMIYoruivffJ4EOXMSiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDFqA/bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7942AC4CEDC;
	Thu,  5 Dec 2024 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733428867;
	bh=OhkwOeu9XnLmPUB+pIA/JrXoeOZMruEMRrO3YTd2x2E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uDFqA/bHGhTHZkFwo0GffmHLmiciYOOdE5yUCmeDlCW8obefOmyuAbOrKGIkzgwrN
	 INJfecKPw3KcOErzDRsWuR8cT0Ykx9xiGCMAtO+eXuXhrzU27twEfRpB5coCHYlNlV
	 yLk9SqqLzHTugUkubyhSewKMjmeVg6ivkM317f5wLqblPCJgvNHhDcTRUEHLiUe+hU
	 Qco2EJsjX68eZMv68WmxWItyz+nIr9gDYtGZ2esPMYTWbY8YpiEfLnPe+U5Anm0SHc
	 9J1iTHZLMKsySXlsmYZyRraWzOqgFNYKCPNr11hyKPlyCjXSEkk2C2/VokF6pJ5vn7
	 QEKKMvSbrx9GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8A4CCE0774; Thu,  5 Dec 2024 12:01:06 -0800 (PST)
Date: Thu, 5 Dec 2024 12:01:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <5a5bda20-f53f-40fe-96ab-a5ae4b39a746@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
 <CAGudoHGRaJZWM5s7s7bxXrDFyTEaZd1zEJOPX15yAdqEYr07eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGRaJZWM5s7s7bxXrDFyTEaZd1zEJOPX15yAdqEYr07eA@mail.gmail.com>

On Thu, Dec 05, 2024 at 08:03:24PM +0100, Mateusz Guzik wrote:
> On Thu, Dec 5, 2024 at 7:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Dec 05, 2024 at 03:43:41PM +0100, Mateusz Guzik wrote:
> > > On Thu, Dec 5, 2024 at 3:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> > > > >  void fd_install(unsigned int fd, struct file *file)
> > > > >  {
> > > > > -     struct files_struct *files = current->files;
> > > > > +     struct files_struct *files;
> > > > >       struct fdtable *fdt;
> > > > >
> > > > >       if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
> > > > >               return;
> > > > >
> > > > > +     /*
> > > > > +      * Synchronized with expand_fdtable(), see that routine for an
> > > > > +      * explanation.
> > > > > +      */
> > > > >       rcu_read_lock_sched();
> > > > > +     files = READ_ONCE(current->files);
> > > >
> > > > What are you trying to do with that READ_ONCE()?  current->files
> > > > itself is *not* changed by any of that code; current->files->fdtab is.
> > >
> > > To my understanding this is the idiomatic way of spelling out the
> > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > flag.
> >
> > In Linus, "smp_consume_load()" is named rcu_dereference().
> 
> ok

And rcu_dereference(), and for that matter memory_order_consume, only
orders the load of the pointer against subsequent dereferences of that
same pointer against dereferences of that same pointer preceding the
store of that pointer.

	T1				T2
	a: p->a = 1;			d: q = rcu_dereference(gp);
	b: r1 = p->b;			e: r2 = p->a;
	c: rcu_assign_pointer(gp, p);	f: p->b = 42;

Here, if (and only if!) T2's load into q gets the value stored by
T1, then T1's statements e and f are guaranteed to happen after T2's
statements a and b.  In your patch, I do not see this pattern for the
files->resize_in_progress flag.

> > > Anyway to elaborate I'm gunning for a setup where the code is
> > > semantically equivalent to having a lock around the work.
> >
> > Except that rcu_read_lock_sched() provides mutual-exclusion guarantees
> > only with later RCU grace periods, such as those implemented by
> > synchronize_rcu().
> 
> To my understanding the pre-case is already with the flag set upfront
> and waiting for everyone to finish (which is already taking place in
> stock code) + looking at it within the section.

I freely confess that I do not understand the purpose of assigning to
files->resize_in_progress both before (pre-existing) and within (added)
expand_fdtable().  If the assignments before and after the call to
expand_fdtable() and the checks were under that lock, that could work,
but removing that lockless check might have performance and scalability
consequences.

> > > Pretend ->resize_lock exists, then:
> > > fd_install:
> > > files = current->files;
> > > read_lock(files->resize_lock);
> > > fdt = rcu_dereference_sched(files->fdt);
> > > rcu_assign_pointer(fdt->fd[fd], file);
> > > read_unlock(files->resize_lock);
> > >
> > > expand_fdtable:
> > > write_lock(files->resize_lock);
> > > [snip]
> > > rcu_assign_pointer(files->fdt, new_fdt);
> > > write_unlock(files->resize_lock);
> > >
> > > Except rcu_read_lock_sched + appropriately fenced resize_in_progress +
> > > synchronize_rcu do it.
> >
> > OK, good, you did get the grace-period part of the puzzle.
> >
> > Howver, please keep in mind that synchronize_rcu() has significant
> > latency by design.  There is a tradeoff between CPU consumption and
> > latency, and synchronize_rcu() therefore has latencies ranging upwards of
> > several milliseconds (not microseconds or nanoseconds).  I would be very
> > surprised if expand_fdtable() users would be happy with such a long delay.
> 
> The call is already there since 2015 and I only know of one case where
> someone took an issue with it (and it could have been sorted out with
> dup2 upfront to grow the table to the desired size). Amusingly I see
> you patched it in 2018 from synchronize_sched to synchronize_rcu.
> Bottom line though is that I'm not *adding* it. latency here. :)

Are you saying that the smp_rmb() is unnecessary?  It doesn't seem like
you are saying that, because otherwise your patch could simply remove
it without additional code changes.  On the other hand, if it is a key
component of the synchronization, I don't see how that smp_rmb() can be
removed while still preserving that synchronization without adding another
synchronize_rcu() to that function to compensate.

Now, it might be that you are somehow cleverly reusing the pre-existing
synchronize_rcu(), but I am not immediately seeing how this would work.

And no, I do not recall making that particular change back in the
day, only that I did change all the calls to synchronize_sched() to
synchronize_rcu().  Please accept my apologies for my having failed
to meet your expectations.  And do not be too surprised if others have
similar expectations of you at some point in the future.  ;-)

> So assuming the above can be ignored, do you confirm the patch works
> (even if it needs some cosmetic changes)?
> 
> The entirety of the patch is about removing smp_rmb in fd_install with
> small code rearrangement, while relying on the machinery which is
> already there.

The code to be synchronized is fairly small.  So why don't you
create a litmus test and ask herd7?  Please see tools/memory-model for
documentation and other example litmus tests.  This tool does the moral
equivalent of a full state-space search of the litmus tests, telling you
whether your "exists" condition is always, sometimes, or never satisfied.

							Thnax, Paul

