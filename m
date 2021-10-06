Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08812424A6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 01:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJFXQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 19:16:53 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:59676 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhJFXQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:16:53 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 3BA985E92DF;
        Thu,  7 Oct 2021 10:14:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mYG7g-003Hvo-Gu; Thu, 07 Oct 2021 10:14:52 +1100
Date:   Thu, 7 Oct 2021 10:14:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <20211006231452.GF54211@dread.disaster.area>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=615e2df0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=y7N-FL6dZ1VV32BAIJQA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:27:45PM +0200, Vlastimil Babka wrote:
> On 10/5/21 13:09, Michal Hocko wrote:
> > On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
> > [...]
> >> > --- a/include/linux/gfp.h
> >> > +++ b/include/linux/gfp.h
> >> > @@ -209,7 +209,11 @@ struct vm_area_struct;
> >> >   * used only when there is no reasonable failure policy) but it is
> >> >   * definitely preferable to use the flag rather than opencode endless
> >> >   * loop around allocator.
> >> > - * Using this flag for costly allocations is _highly_ discouraged.
> >> > + * Use of this flag may lead to deadlocks if locks are held which would
> >> > + * be needed for memory reclaim, write-back, or the timely exit of a
> >> > + * process killed by the OOM-killer.  Dropping any locks not absolutely
> >> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> >> > + * Using this flag for costly allocations (order>1) is _highly_ discouraged.
> >> 
> >> We define costly as 3, not 1. But sure it's best to avoid even order>0 for
> >> __GFP_NOFAIL. Advising order>1 seems arbitrary though?
> > 
> > This is not completely arbitrary. We have a warning for any higher order
> > allocation.
> > rmqueue:
> > 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> 
> Oh, I missed that.
> 
> > I do agree that "Using this flag for higher order allocations is
> > _highly_ discouraged.
> 
> Well, with the warning in place this is effectively forbidden, not just
> discouraged.

Yup, especially as it doesn't obey __GFP_NOWARN.

See commit de2860f46362 ("mm: Add kvrealloc()") as a direct result
of unwittingly tripping over this warning when adding __GFP_NOFAIL
annotations to replace open coded high-order kmalloc loops that have
been in place for a couple of decades without issues.

Personally I think that the way __GFP_NOFAIL is first of all
recommended over open coded loops and then only later found to be
effectively forbidden and needing to be replaced with open coded
loops to be a complete mess.

Not to mention on the impossibility of using __GFP_NOFAIL with
kvmalloc() calls. Just what do we expect kmalloc_node(__GFP_NORETRY
| __GFP_NOFAIL) to do, exactly?

So, effectively, we have to open-code around kvmalloc() in
situations where failure is not an option. Even if we pass
__GFP_NOFAIL to __vmalloc(), it isn't guaranteed to succeed because
of the "we won't honor gfp flags passed to __vmalloc" semantics it
has.

Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
kvmalloc via memalloc_nofs_save/restore(), so this behavioural
restriction w.r.t. gfp flags just makes no sense at all.

That leads to us having to go back to writing extremely custom open
coded loops to avoid awful high-order kmalloc direct reclaim
behaviour and still fall back to vmalloc and to still handle NOFAIL
semantics we need:

https://lore.kernel.org/linux-xfs/20210902095927.911100-8-david@fromorbit.com/

So, really, the problems are much deeper here than just badly
documented, catch-22 rules for __GFP_NOFAIL - we can't even use
__GFP_NOFAIL consistently across the allocation APIs because it
changes allocation behaviours in unusable, self-defeating ways....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
