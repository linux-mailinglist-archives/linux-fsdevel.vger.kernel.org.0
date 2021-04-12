Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2235D2ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 00:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhDLWQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 18:16:11 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:56316 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240100AbhDLWQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:16:11 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 577EE5EC8BF;
        Tue, 13 Apr 2021 08:15:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lW4qG-0059Bc-0b; Tue, 13 Apr 2021 08:15:36 +1000
Date:   Tue, 13 Apr 2021 08:15:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bigeasy@linutronix.de,
        hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
Message-ID: <20210412221536.GQ1990290@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-4-david@fromorbit.com>
 <20210406132834.GP2531743@casper.infradead.org>
 <20210406212253.GC1990290@dread.disaster.area>
 <874kgb1qcq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kgb1qcq.ffs@nanos.tec.linutronix.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=BcQbKYzZlWi3y6IvRCwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 05:20:53PM +0200, Thomas Gleixner wrote:
> Dave,
> 
> On Wed, Apr 07 2021 at 07:22, Dave Chinner wrote:
> > On Tue, Apr 06, 2021 at 02:28:34PM +0100, Matthew Wilcox wrote:
> >> On Tue, Apr 06, 2021 at 10:33:43PM +1000, Dave Chinner wrote:
> >> > +++ b/fs/inode.c
> >> > @@ -57,8 +57,7 @@
> >> >  
> >> >  static unsigned int i_hash_mask __read_mostly;
> >> >  static unsigned int i_hash_shift __read_mostly;
> >> > -static struct hlist_head *inode_hashtable __read_mostly;
> >> > -static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
> >> > +static struct hlist_bl_head *inode_hashtable __read_mostly;
> >> 
> >> I'm a little concerned that we're losing a lockdep map here.  
> >> 
> >> Nobody seems to have done this for list_bl yet, and I'd be reluctant
> >> to gate your patch on "Hey, Dave, solve this problem nobody else has
> >> done yet".
> >
> > I really don't care about lockdep. Adding lockdep support to
> > hlist_bl is somebody else's problem - I'm just using infrastructure
> > that already exists. Also, the dentry cache usage of hlist_bl is
> > vastly more complex and so if lockdep coverage was really necessary,
> > it would have already been done....
> >
> > And, FWIW, I'm also aware of the problems that RT kernels have with
> > the use of bit spinlocks and being unable to turn them into sleeping
> > mutexes by preprocessor magic. I don't care about that either,
> > because dentry cache...
> 
> In the dentry cache it's a non-issue.

Incorrect.

> RT does not have a problem with bit spinlocks per se, it depends on how
> they are used and what nests inside. Most of them are just kept as bit
> spinlocks because the lock held, and therefore preempt disabled times
> are small and no other on RT conflicting operations happen inside.
> 
> In the case at hand this is going to be a problem because inode->i_lock
> nests inside the bit spinlock and we can't make inode->i_lock a raw
> spinlock because it protects way heavier weight code pathes as well.

Yes, that's exactly the "problem" I'm refering to. And I don't care,
precisely because, well, dentry cache....

THat is, the dcache calls wake_up_all() from under the
hlist_bl_lock() in __d_lookup_done(). That ends up in
__wake_up_common_lock() which takes a spin lock embedded inside a
wait_queue_head.  That's not a raw spinlock, either, so we already
have this "spinlock inside bit lock" situation with the dcache usage
of hlist_bl.

FYI, this dentry cache behaviour was added to the dentry cache in
2016 by commit d9171b934526 ("parallel lookups machinery, part 4
(and last)"), so it's not like it's a new thing, either.

If you want to make hlist_bl RT safe, then re-implement it behind
the scenes for RT enabled kernels. All it takes is more memory
usage for the hash table + locks, but that's something that non-RT
people should not be burdened with caring about....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
