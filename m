Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9140D0FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhIPAjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 20:39:19 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:48919 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbhIPAjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:39:18 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 2CA3E87E46;
        Thu, 16 Sep 2021 10:37:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQfPU-00CxNW-5j; Thu, 16 Sep 2021 10:37:52 +1000
Date:   Thu, 16 Sep 2021 10:37:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <20210916003752.GN2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <163165609100.3992.1570739756456048657@noble.neil.brown.name>
 <YUHh2ddnJEDGI8YG@dhcp22.suse.cz>
 <163174534006.3992.15394603624652359629@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163174534006.3992.15394603624652359629@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=CuGUvM-gP3KvDOsnQb0A:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 08:35:40AM +1000, NeilBrown wrote:
> On Wed, 15 Sep 2021, Michal Hocko wrote:
> > On Wed 15-09-21 07:48:11, Neil Brown wrote:
> > > 
> > > Why does __GFP_NOFAIL access the reserves? Why not require that the
> > > relevant "Try harder" flag (__GFP_ATOMIC or __GFP_MEMALLOC) be included
> > > with __GFP_NOFAIL if that is justified?
> > 
> > Does 5020e285856c ("mm, oom: give __GFP_NOFAIL allocations access to
> > memory reserves") help?
> 
> Yes, that helps.  A bit.
> 
> I'm not fond of the clause "the allocation request might have come with some
> locks held".  What if it doesn't?  Does it still have to pay the price.
> 
> Should we not require that the caller indicate if any locks are held?
> That way callers which don't hold locks can use __GFP_NOFAIL without
> worrying about imposing on other code.
> 
> Or is it so rare that __GFP_NOFAIL would be used without holding a lock
> that it doesn't matter?
> 
> The other commit of interest is
> 
> Commit: 6c18ba7a1899 ("mm: help __GFP_NOFAIL allocations which do not trigger OOM killer")
> 
> I don't find the reasoning convincing.  It is a bit like "Robbing Peter
> to pay Paul".  It takes from the reserves to allow a __GFP_NOFAIL to
> proceed, with out any reason to think this particular allocation has any
> more 'right' to the reserves than anything else.
> 
> While I don't like the reasoning in either of these, they do make it
> clear (to me) that the use of reserves is entirely an internal policy
> decision.  They should *not* be seen as part of the API and callers
> should not have to be concerned about it when deciding whether to use
> __GFP_NOFAIL or not.

Agree totally with this - we just want to block until allocation
succeeds, and if the -filesystem- deadlocks because allocation never
succeeds then that's a problem that needs to be solved in the
filesystem with a different memory allocation strategy...

OTOH, setting up a single __GFP_NOFAIL call site with the ability to
take the entire system down seems somewhat misguided.

> The use of these reserves is, at most, a hypothetical problem.  If it
> ever looks like becoming a real practical problem, it needs to be fixed
> internally to the page allocator.  Maybe an extra water-mark which isn't
> quite as permissive as ALLOC_HIGH...
> 
> I'm inclined to drop all references to reserves from the documentation
> for __GFP_NOFAIL.  I think there are enough users already that adding a
> couple more isn't going to make problems substantially more likely.  And
> more will be added anyway that the mm/ team won't have the opportunity
> or bandwidth to review.

Yup, we've been replacing open coded loops like in kmem_alloc() with
explicit __GFP_NOFAIL usage for a while now:

$ ▶ git grep __GFP_NOFAIL fs/xfs |wc -l
33
$

ANd we've got another 100 or so call sites planned for conversion to
__GFP_NOFAIL. Hence the suggestion to remove the use of
reserves from __GFP_NOFAIL seems like a sensible plan because it has
never been necessary in the past for all the allocation sites we are
converting from open coded loops to __GFP_NOFAIL...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
