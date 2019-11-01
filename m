Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3175FECC07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKAXq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 19:46:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40806 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAXqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 19:46:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQgcY-0003GU-3x; Fri, 01 Nov 2019 23:46:22 +0000
Date:   Fri, 1 Nov 2019 23:46:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191101234622.GM26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:35:50PM +0530, Ritesh Harjani wrote:

> > > What we have guaranteed is
> > > 	* ->d_lock serializes ->d_flags/->d_inode changes
> > > 	* ->d_seq is bumped before/after such changes
> > > 	* positive dentry never changes ->d_inode as long as you hold
> > > a reference (negative dentry *can* become positive right under you)
> > > 
> > > So there are 3 classes of valid users: those holding ->d_lock, those
> > > sampling and rechecking ->d_seq and those relying upon having observed
> > > the sucker they've pinned to be positive.
> 
> :) Thanks for simplifying like this. Agreed.

FWIW, after fixing several ceph bugs, add to that the following:
	* all places that turn a negative dentry into positive one are
holding its parent exclusive or dentry has not been observable for
anybody else.  It had been present in the parent's list of children
(negative and unhashed) and it might have been present in in-lookup
hashtable.  However, nobody is going to grab a reference to it from there
without having grabbed ->d_lock on it and observed the state after
it became positive. 

Which means that holding a reference to dentry *and* holding its
parent at least shared stabilizes both ->d_inode and type bits in
->d_flags.  The situation with barriers is more subtle - *IF* we
had sufficient barriers to have ->d_inode/type bits seen right
after having gotten the reference, we are fine.  The only change
possible after that point is negative->positive transition and
that gets taken care of by barriers provided by ->i_rwsem.

If we'd obtained that reference by d_lookup() or __d_lookup(),
we are fine - ->d_lock gives a barrier.  The same goes for places
that grab references during a tree traversal, provided that they
hold ->d_lock around that (fs/autofs/expire.c stuff).  The same goes
for having it found in inode's aliases list (->i_lock).

I really hope that the same applies to accesses to file_dentry(file);
on anything except alpha that would be pretty much automatic and
on alpha we get the things along the lines of

	f = fdt[n]
	mb
	d = f->f_path.dentry
	i = d->d_inode
	assert(i != NULL)
vs.
	see that d->d_inode is non-NULL
	f->f_path.dentry = d
	mb
	fdt[n] = f

IOW, the barriers that make it safe to fetch the fields of struct file
(rcu_dereference_raw() in __fcheck_files() vs. smp_store_release()
in __fd_install() in the above) should *hopefully* take care of all
stores visible by the time of do_dentry_open().  Sure, alpha cache
coherency is insane, but AFAICS it's not _that_ insane.

Question to folks familiar with alpha memory model:

A = 0, B = NULL, C = NULL
CPU1:
	A = 1

CPU2:
	r1 = A
	if (r1) {
		B = &A
		mb
		C = &B
	}

CPU3:
	r2 = C;
	mb
	if (r2) {	// &B
		r3 = *r2	// &A
		r4 = *r3	// 1
		assert(r4 == 1)
	}

is the above safe on alpha?

[snip]

> We may also need similar guarantees with __d_clear_type_and_inode().

Not really - pinned dentry can't go negative.  In any case, with the
audit I've done so far, I don't believe that blanket solutions like
that are good idea - most of the places doing checks are safe as it is.
The surface that needs to be taken care of is fairly small, actually;
most of that is in fs/namei.c and fs/dcache.c.
