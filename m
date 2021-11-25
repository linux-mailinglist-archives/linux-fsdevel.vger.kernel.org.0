Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3345E28B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbhKYVfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 16:35:51 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:60220 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243150AbhKYVdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:33:50 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id DC29DAEF53;
        Fri, 26 Nov 2021 08:30:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mqMKA-00DDU4-2a; Fri, 26 Nov 2021 08:30:34 +1100
Date:   Fri, 26 Nov 2021 08:30:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Message-ID: <20211125213034.GQ418105@dread.disaster.area>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211124225526.GM418105@dread.disaster.area>
 <YZ9QNeHYt99mdfbZ@dhcp22.suse.cz>
 <YZ9XtLY4AEjVuiEI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ9XtLY4AEjVuiEI@dhcp22.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61a0007d
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=wFkKJAiL46mAdfXxsecA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:30:28AM +0100, Michal Hocko wrote:
> [Cc Sebastian and Vlastimil]
> 
> On Thu 25-11-21 09:58:31, Michal Hocko wrote:
> > On Thu 25-11-21 09:55:26, Dave Chinner wrote:
> > [...]
> > > Correct __GFP_NOLOCKDEP support is also needed. See:
> > > 
> > > https://lore.kernel.org/linux-mm/20211119225435.GZ449541@dread.disaster.area/
> > 
> > I will have a closer look. This will require changes on both vmalloc and
> > sl?b sides.
> 
> This should hopefully make the trick
> --- 
> From 0082d29c771d831e5d1b9bb4c0a61d39bac017f0 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 25 Nov 2021 10:20:16 +0100
> Subject: [PATCH] mm: make slab and vmalloc allocators __GFP_NOLOCKDEP aware
> 
> sl?b and vmalloc allocators reduce the given gfp mask for their internal
> needs. For that they use GFP_RECLAIM_MASK to preserve the reclaim
> behavior and constrains.
> 
> __GFP_NOLOCKDEP is not a part of that mask because it doesn't really
> control the reclaim behavior strictly speaking. On the other hand
> it tells the underlying page allocator to disable reclaim recursion
> detection so arguably it should be part of the mask.
> 
> Having __GFP_NOLOCKDEP in the mask will not alter the behavior in any
> form so this change is safe pretty much by definition. It also adds
> a support for this flag to SL?B and vmalloc allocators which will in
> turn allow its use to kvmalloc as well. A lack of the support has been
> noticed recently in http://lkml.kernel.org/r/20211119225435.GZ449541@dread.disaster.area
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 3b79a5c9427a..2ceea20b5b2a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -21,7 +21,7 @@
>  #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
>  			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
>  			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
> -			__GFP_ATOMIC)
> +			__GFP_ATOMIC|__GFP_NOLOCKDEP)
>  
>  /* The GFP flags allowed during early boot */
>  #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))

Looks reasonable to me.

Acked-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
