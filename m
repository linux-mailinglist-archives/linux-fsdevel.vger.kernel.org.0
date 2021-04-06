Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781C8355DD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbhDFVXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 17:23:07 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:57586 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhDFVXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:23:07 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id CE1511AED50;
        Wed,  7 Apr 2021 07:22:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTt9x-00DPVZ-Ne; Wed, 07 Apr 2021 07:22:53 +1000
Date:   Wed, 7 Apr 2021 07:22:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
        bigeasy@linutronix.de, hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
Message-ID: <20210406212253.GC1990290@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-4-david@fromorbit.com>
 <20210406132834.GP2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406132834.GP2531743@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=IGaBeghDkWcF0HkzdbcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 02:28:34PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 06, 2021 at 10:33:43PM +1000, Dave Chinner wrote:
> > +++ b/fs/inode.c
> > @@ -57,8 +57,7 @@
> >  
> >  static unsigned int i_hash_mask __read_mostly;
> >  static unsigned int i_hash_shift __read_mostly;
> > -static struct hlist_head *inode_hashtable __read_mostly;
> > -static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
> > +static struct hlist_bl_head *inode_hashtable __read_mostly;
> 
> I'm a little concerned that we're losing a lockdep map here.  
> 
> Nobody seems to have done this for list_bl yet, and I'd be reluctant
> to gate your patch on "Hey, Dave, solve this problem nobody else has
> done yet".

I really don't care about lockdep. Adding lockdep support to
hlist_bl is somebody else's problem - I'm just using infrastructure
that already exists. Also, the dentry cache usage of hlist_bl is
vastly more complex and so if lockdep coverage was really necessary,
it would have already been done....

And, FWIW, I'm also aware of the problems that RT kernels have with
the use of bit spinlocks and being unable to turn them into sleeping
mutexes by preprocessor magic. I don't care about that either,
because dentry cache...

> But maybe we can figure out how to do this?  I think we want one lockdep
> map for the entire hashtable (it's split for performance, not because
> they're logically separate locks).  So something like ...
> 
> static struct lockdep_map inode_hash_map =
> 	STATIC_LOCKDEP_MAP_INIT("inode_hash", &inode_hash_map);
> 
> and add:
> 
> static inline void hlist_bl_lock_map(struct hlist_bl_head *b,
> 					struct lockdep_map *map)
> {
> 	bit_spin_lock(0, (unsigned long *)b);
> 	spin_acquire(map, 0, 0, _RET_IP_);
> }
> 
> then use hlist_bl_lock_map() throughout.  Would that work?
> Adding lockdep experts for opinions.

Maybe, but it's kinda messy to have to carry the lockdep map around
externally to the structure. Not to mention it won't support holding
multiple hash chains locked at once if that is ever needed (e.g.
rehashing an object with a different hashval)...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
