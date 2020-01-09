Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2613579E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 12:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAILIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 06:08:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:38962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgAILIM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:08:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76C966A34E;
        Thu,  9 Jan 2020 11:07:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B06581E0798; Thu,  9 Jan 2020 12:07:51 +0100 (CET)
Date:   Thu, 9 Jan 2020 12:07:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200109110751.GF27035@quack2.suse.cz>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106232100.GL23195@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 10:21:00, Dave Chinner wrote:
> On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> > On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > > 
> > > I don't want to present this topic; I merely noticed the problem.
> > > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > > thread here:
> > 
> > Thanks for bringing this up Matthew! The change in the behavior came as
> > a surprise to me. I can lead the session for the MM side.
> > 
> > > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > > 
> > > Summary: Congestion is broken and has been for years, and everybody's
> > > system is sleeping waiting for congestion that will never clear.
> > > 
> > > A good outcome for this meeting would be:
> > > 
> > >  - MM defines what information they want from the block stack.
> > 
> > The history of the congestion waiting is kinda hairy but I will try to
> > summarize expectations we used to have and we can discuss how much of
> > that has been real and what followed up as a cargo cult. Maybe we just
> > find out that we do not need functionality like that anymore. I believe
> > Mel would be a great contributor to the discussion.
> 
> We most definitely do need some form of reclaim throttling based on
> IO congestion, because it is trivial to drive the system into swap
> storms and OOM killer invocation when there are large dirty slab
> caches that require IO to make reclaim progress and there's little
> in the way of page cache to reclaim.

Agreed, but I guess the question is how do we implement that in a reliable
fashion? More on that below...

> This is one of the biggest issues I've come across trying to make
> XFS inode reclaim non-blocking - the existing code blocks on inode
> writeback IO congestion to throttle the overall reclaim rate and
> so prevents swap storms and OOM killer rampages from occurring.
> 
> The moment I remove the inode writeback blocking from the reclaim
> path and move the backoffs to the core reclaim congestion backoff
> algorithms, I see a sustantial increase in the typical reclaim scan
> priority. This is because the reclaim code does not have an
> integrated back-off mechanism that can balance reclaim throttling
> between slab cache and page cache reclaim. This results in
> insufficient page reclaim backoff under slab cache backoff
> conditions, leading to excessive page cache reclaim and swapping out
> all the anonymous pages in memory. Then performance goes to hell as
> userspace then starts to block on page faults swap thrashing like
> this:
> 
> page_fault
>   swap_in
>     alloc page
>       direct reclaim
>         swap out anon page
> 	  submit_bio
> 	    wbt_throttle
> 
> 
> IOWs, page reclaim doesn't back off until userspace gets throttled
> in the block layer doing swap out during swap in during page
> faults. For these sorts of workloads there should be little to no
> swap thrashing occurring - throttling reclaim to the rate at which
> inodes are cleaned by async IO dispatcher threads is what is needed
> here, not continuing to wind up reclaim priority  until swap storms
> and the oom killer end up killng the machine...
> 
> I also see this when the inode cache load is on a separate device to
> the swap partition - both devices end up at 100% utilisation, one
> doing inode writeback flat out (about 300,000 inodes/sec from an
> inode cache of 5-10 million inodes), the other is swap thrashing
> from a page cache of only 250-500 pages in size.
> 
> Hence the way congestion was historically dealt with as a "global
> condition" still needs to exist in some manner - congestion on a
> single device is sufficient to cause the high level reclaim
> algroithms to misbehave badly...
> 
> Hence it seems to me that having IO load feedback to the memory
> reclaim algorithms is most definitely required for memory reclaim to
> be able to make the correct decisions about what to reclaim. If the
> shrinker for the cache that uses 50% of RAM in the machine is saying
> "backoff needed" and it's underlying device is
> congested and limiting object reclaim rates, then it's a pretty good
> indication that reclaim should back off and wait for IO progress to
> be made instead of trying to reclaim from other LRUs that hold an
> insignificant amount of memory compared to the huge cache that is
> backed up waiting on IO completion to make progress....

Yes and I think here's the key detail: Reclaim really needs to wait for
slab object cleaning to progress so that slab cache can be shrinked.  This
is related, but not always in a straightforward way, with IO progress and
even less with IO congestion on some device. I can easily imagine that e.g.
cleaning of inodes to reclaim inode slab may not be efficient enough to
utilize full paralelism of a fast storage so the storage will not ever
become congested - sure it's an inefficiency that could be fixed but should
it misguide reclaim? I don't think so... So I think that to solve this
problem in a robust way, we need to provide a mechanism for slab shrinkers
to say something like "hang on, I can reclaim X objects you asked for but
it will take time, I'll signal to you when they are reclaimable". This way
we avoid blocking in the shrinker and can do more efficient async batched
reclaim and on mm side we have the freedom to either wait for slab reclaim
to progress (if this slab is fundamental to memory pressure) or just go try
reclaim something else. Of course, the devil is in the details :).

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
