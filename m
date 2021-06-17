Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356853AA848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 02:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhFQAvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 20:51:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53126 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231496AbhFQAvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:51:54 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id ACD431044A50;
        Thu, 17 Jun 2021 10:49:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ltgE2-00DcT4-3U; Thu, 17 Jun 2021 10:49:42 +1000
Date:   Thu, 17 Jun 2021 10:49:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <20210617004942.GF2419729@dread.disaster.area>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
 <YMmD9xhBm9wGqYhf@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmD9xhBm9wGqYhf@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8
        a=9QrUW9syPe-c7OGs3v4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:54:15AM -0400, Johannes Weiner wrote:
> On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> > On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > > > >  			shadow = workingset_eviction(page, target_memcg);
> > > > >  		__delete_from_page_cache(page, shadow);
> > > > >  		xa_unlock_irq(&mapping->i_pages);
> > > > > +		if (mapping_shrinkable(mapping))
> > > > > +			inode_add_lru(mapping->host);
> > > > > +		spin_unlock(&mapping->host->i_lock);
> > > > >  
> > > > 
> > > > No. Inode locks have absolutely no place serialising core vmscan
> > > > algorithms.
> > > 
> > > What if, and hear me out on this one, core vmscan algorithms change
> > > the state of the inode?
> > 
> > Then the core vmscan algorithm has a layering violation.
> 
> You're just playing a word game here.

No, I've given you plenty of constructive justification and ways to
restructure your patches to acheive what you say needs to be done.

You're the one that is rejecting any proposal I make outright and
making unjustified claims that "I don't understand this code".

Serious, Johannes, I understand how the inode cache shrinkers work
better than most people out there, and for you to just reject my
comments and suggestions outright with "you don't understand this
stuff so go learn about it' is pretty obnoxious and toxic behaviour.

I haven't disagreed at all with what you are trying to do, nor do I
think that being more selective about how we track inodes on the
LRUs is a bad thing. What I'm commenting on is that the proposed
changes are *really bad code*.

If you can work out a *clean* way to move inodes onto the LRU when
they are dirty then I'm all for it. But sprinkling inode->i_lock all
over the mm/ subsystem and then adding seemling randomly placed
inode lru manipulations isn't the way to do it.

You should consider centralising all the work involved marking a
mapping clean somewhere inside the mm/ code. Then add a single
callout that does the inode LRU work, similar to how the
fs-writeback.c code does it when the inode is marked clean by
inode_sync_complete().

IOWs, if you can't accept that there are problems with your approach
nor accept that it needs to be improved because *I* said there are
problems (and it seems that you mostly only react this way when *I*
happen to say "needs improvement"), then you need to go take a good
hard look at yourself.

Fix up your code so that it is acceptible to reviewers - telling
reviewers they don't know shit is a sure way to piss people off
unnecesarily. It doesn't make you look very good at all, and it
makes other people think twice about wanting to review your code or
work with you in future.

So, again, until you see fit to be stop being obnoxious and toxic
and that your patches need work before they are acceptible for
merging, I maintain my NACK on this patch as it standsi and I am
complete done with this discusion.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
