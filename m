Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFDECFED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKBRWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 13:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBRWc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:22:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [65.158.186.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F95C217D9;
        Sat,  2 Nov 2019 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572715350;
        bh=fUKnwJdEEJ7lhdsYPyo4KEEqmuNRzDo6MVch2U4DC9I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UmmbAAb199FWUxRROaa50n06O0doLhg0Jv44otpbLLfpcZkudiRurflm8dE9bxkaY
         3Wkq9KwE3z8hqum6zb1/ndCIk337yHzfK/cbkXXw6DnkXEV2iAY3SPDrPChM/7S3XZ
         YrhP0y9ESbpLPf+KjBICcxRGnWjCszO0eoeGGefk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ECEB035204A2; Sat,  2 Nov 2019 10:22:29 -0700 (PDT)
Date:   Sat, 2 Nov 2019 10:22:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191102172229.GT20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101234622.GM26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:46:22PM +0000, Al Viro wrote:
> On Wed, Oct 23, 2019 at 04:35:50PM +0530, Ritesh Harjani wrote:
> 
> > > > What we have guaranteed is
> > > > 	* ->d_lock serializes ->d_flags/->d_inode changes
> > > > 	* ->d_seq is bumped before/after such changes
> > > > 	* positive dentry never changes ->d_inode as long as you hold
> > > > a reference (negative dentry *can* become positive right under you)
> > > > 
> > > > So there are 3 classes of valid users: those holding ->d_lock, those
> > > > sampling and rechecking ->d_seq and those relying upon having observed
> > > > the sucker they've pinned to be positive.
> > 
> > :) Thanks for simplifying like this. Agreed.
> 
> FWIW, after fixing several ceph bugs, add to that the following:
> 	* all places that turn a negative dentry into positive one are
> holding its parent exclusive or dentry has not been observable for
> anybody else.  It had been present in the parent's list of children
> (negative and unhashed) and it might have been present in in-lookup
> hashtable.  However, nobody is going to grab a reference to it from there
> without having grabbed ->d_lock on it and observed the state after
> it became positive. 
> 
> Which means that holding a reference to dentry *and* holding its
> parent at least shared stabilizes both ->d_inode and type bits in
> ->d_flags.  The situation with barriers is more subtle - *IF* we
> had sufficient barriers to have ->d_inode/type bits seen right
> after having gotten the reference, we are fine.  The only change
> possible after that point is negative->positive transition and
> that gets taken care of by barriers provided by ->i_rwsem.
> 
> If we'd obtained that reference by d_lookup() or __d_lookup(),
> we are fine - ->d_lock gives a barrier.  The same goes for places
> that grab references during a tree traversal, provided that they
> hold ->d_lock around that (fs/autofs/expire.c stuff).  The same goes
> for having it found in inode's aliases list (->i_lock).
> 
> I really hope that the same applies to accesses to file_dentry(file);
> on anything except alpha that would be pretty much automatic and
> on alpha we get the things along the lines of
> 
> 	f = fdt[n]
> 	mb
> 	d = f->f_path.dentry
> 	i = d->d_inode
> 	assert(i != NULL)
> vs.
> 	see that d->d_inode is non-NULL
> 	f->f_path.dentry = d
> 	mb
> 	fdt[n] = f

Ignoring the possibility of the more exotic compiler optimizations, if
the first task's load into f sees the value stored by the second task,
then the pair of memory barriers guarantee that the first task's load
into d will see the second task's store.

In fact, you could instead say this in recent kernels:

	f = READ_ONCE(fdt[n])  // provides dependency ordering via mb on Alpha
	mb
	d = f->f_path.dentry
	i = d->d_inode  // But this is OK only if ->f_path.entry is
			// constant throughout
	assert(i != NULL)
vs.
	see that d->d_inode is non-NULL
	f->f_path.dentry = d
	mb
	fdt[n] = f

The result of the first task's load into i requires information outside
of the two code fragments.

Or am I missing your point?

> IOW, the barriers that make it safe to fetch the fields of struct file
> (rcu_dereference_raw() in __fcheck_files() vs. smp_store_release()
> in __fd_install() in the above) should *hopefully* take care of all
> stores visible by the time of do_dentry_open().  Sure, alpha cache
> coherency is insane, but AFAICS it's not _that_ insane.

Agreed, not -that- insane.  ;-)

> Question to folks familiar with alpha memory model:
> 
> A = 0, B = NULL, C = NULL
> CPU1:
> 	A = 1
> 
> CPU2:
> 	r1 = A
> 	if (r1) {
> 		B = &A
> 		mb
> 		C = &B
> 	}
> 
> CPU3:
> 	r2 = C;
> 	mb
> 	if (r2) {	// &B
> 		r3 = *r2	// &A
> 		r4 = *r3	// 1
> 		assert(r4 == 1)
> 	}
> 
> is the above safe on alpha?

Looks that way to me.  LKMM agrees:

	C viro

	{
	}

	P0(int *a)
	{
		WRITE_ONCE(*a, 1);
	}

	P1(int *a, int **b, int ***c)
	{
		int r1;

		r1 = READ_ONCE(*a);
		if (r1) {
			WRITE_ONCE(*b, a);
			smp_mb();
			WRITE_ONCE(*c, b);
		}
	}

	P2(int ***c)
	{
		int **r2;
		int *r3;
		int r4;

		r2 = READ_ONCE(*c);
		smp_mb();
		if (r2) {
			r3 = READ_ONCE(*r2);
			r4 = READ_ONCE(*r3);
		}
	}

	exists (1:r1=1 /\ ~2:r2=0 /\ 2:r4=0)

Which gets us this:

	$ herd7 -conf linux-kernel.cfg /tmp/viro.litmus 
	Test viro Allowed
	States 3
	1:r1=0; 2:r2=0; 2:r4=0;
	1:r1=1; 2:r2=0; 2:r4=0;
	1:r1=1; 2:r2=b; 2:r4=1;
	No
	Witnesses
	Positive: 0 Negative: 3
	Condition exists (1:r1=1 /\ not (2:r2=0) /\ 2:r4=0)
	Observation viro Never 0 3
	Time viro 0.01
	Hash=cabcc7f3122771a04dd21686b2d58124

The state "1:r1=1; 2:r2=b; 2:r4=0;" does not appear, as expected.

							Thanx, Paul

> [snip]
> 
> > We may also need similar guarantees with __d_clear_type_and_inode().
> 
> Not really - pinned dentry can't go negative.  In any case, with the
> audit I've done so far, I don't believe that blanket solutions like
> that are good idea - most of the places doing checks are safe as it is.
> The surface that needs to be taken care of is fairly small, actually;
> most of that is in fs/namei.c and fs/dcache.c.
