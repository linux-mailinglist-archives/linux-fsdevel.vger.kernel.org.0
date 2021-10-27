Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7843C76C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhJ0KQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 06:16:16 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:45330 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236906AbhJ0KQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:16:15 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 728BEBAB2C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 11:13:49 +0100 (IST)
Received: (qmail 13566 invoked from network); 27 Oct 2021 10:13:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Oct 2021 10:13:48 -0000
Date:   Wed, 27 Oct 2021 11:13:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-ID: <20211027101346.GQ3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>
 <20211022083927.GI3959@techsingularity.net>
 <163490199006.17149.17259708448207042563@noble.neil.brown.name>
 <20211022131732.GK3959@techsingularity.net>
 <163529540259.8576.9186192891154927096@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163529540259.8576.9186192891154927096@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:43:22AM +1100, NeilBrown wrote:
> On Sat, 23 Oct 2021, Mel Gorman wrote:
> > On Fri, Oct 22, 2021 at 10:26:30PM +1100, NeilBrown wrote:
> > > On Fri, 22 Oct 2021, Mel Gorman wrote:
> > > > On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> > > > 
> > > > > In general, I still don't like the use of wake_up_all(), though it won't
> > > > > cause incorrect behaviour.
> > > > > 
> > > > 
> > > > Removing wake_up_all would be tricky.
> > > 
> > > I think there is a misunderstanding.  Removing wake_up_all() is as
> > > simple as
> > >    s/wake_up_all/wake_up/
> > > 
> > > If you used prepare_to_wait_exclusive(), then wake_up() would only wake
> > > one waiter, while wake_up_all() would wake all of them.
> > > As you use prepare_to_wait(), wake_up() will wake all waiters - as will
> > > wake_up_all(). 
> > > 
> > 
> > Ok, yes, there was a misunderstanding. I thought you were suggesting a
> > move to exclusive wakeups. I felt that the wake_up_all was explicit in
> > terms of intent and that I really meant for all tasks to wake instead of
> > one at a time.
> 
> Fair enough.  Thanks for changing it :-)
> 
> But this prompts me to wonder if exclusive wakeups would be a good idea
> - which is a useful springboard to try to understand the code better.
> 
> For VMSCAN_THROTTLE_ISOLATED they probably are.
> One pattern for reliable exclusive wakeups is for any thread that
> received a wake-up to then consider sending a wake up.
> 
> Two places receive VMSCAN_THROTTLE_ISOLATED wakeups and both then call
> too_many_isolated() which - on success - sends another wakeup - before
> the caller has had a chance to isolate anything.  If, instead, the
> wakeup was sent sometime later, after pages were isolated by before the
> caller (isoloate_migratepages_block() or shrink_inactive_list())
> returned, then we would get an orderly progression of threads running
> through that code.
> 

That should work as the throttling condition is straight-forward. It
might even reduce a race condition where waking all throttled tasks all
then trigger the same "too many isolated" condition.

> For VMSCAN_THROTTLE_WRITEBACK is a little less straight forward.
> There are two different places that wait for the wakeup, and a wake_up
> is sent to all waiters after a time proportional to the number of
> waiters. It might make sense to wake one thread per time unit?

I'd avoid time as a wakeup condition other than the timeout which is
there to guarantee forward progress. I assume you mean "one thread per
SWAP_CLUSTER_MAX completions".

> That might work well for do_writepages - every SWAP_CLUSTER_MAX writes
> triggers one wakeup.
> I'm less sure that it would work for shrink_node().  Maybe the
> shrink_node() waiters could be non-exclusive so they get woken as soon a
> SWAP_CLUSTER_MAX writes complete, while do_writepages are exclusive and
> get woken one at a time.
> 

It should work for either with the slight caveat that the last waiter
may not see SWAP_CLUSTER_MAX completions.

> For VMSCAN_THROTTLE_NOPROGRESS .... I don't understand.
> If one zone isn't making "enough" progress, we throttle before moving on
> to the next zone.  So we delay processing of the next zone, and only
> indirectly delay re-processing of the current congested zone.
> Maybe it make sense, but I don't see it yet.  I note that the commit
> message says "it's messy".  I can't argue with that!
> 

Yes, we delay the processing of the next zone when a given zone cannot
make progress. The thinking is that circumstances that cause one zone to
fail to make progress could spill over to other zones in the absense of
any throttling. Where it might cause problems is where the preferred zone
is very small. If a bug showed up like that, a potential fix would be to
avoid throttling if the preferred zone is very small relative to the total
amount of memory local to the node or total memory (preferably local node).

> I'll follow up with patches to clarify what I am thinking about the
> first two.  I'm not proposing the patches, just presenting them as part
> of improving my understanding.
> 

If I'm cc'd, I'll review and if I think they're promising, I'll run them
through the same tests and machines.

-- 
Mel Gorman
SUSE Labs
