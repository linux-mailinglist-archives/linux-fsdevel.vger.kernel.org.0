Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C940A285
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 03:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhINBcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 21:32:41 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:47857 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhINBci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:32:38 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id D566A1093D9;
        Tue, 14 Sep 2021 11:31:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mPxI5-00CCbG-9U; Tue, 14 Sep 2021 11:31:17 +1000
Date:   Tue, 14 Sep 2021 11:31:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
Message-ID: <20210914013117.GG2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838439.13293.5032214643474179966.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163157838439.13293.5032214643474179966.stgit@noble.brown>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=-upqpVM4ziubeLwI_h0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> Documentation commment in gfp.h discourages indefinite retry loops on
> ENOMEM and says of __GFP_NOFAIL that it
> 
>     is definitely preferable to use the flag rather than opencode
>     endless loop around allocator.
> 
> So remove the loop, instead specifying __GFP_NOFAIL if KM_MAYFAIL was
> not given.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/xfs/kmem.c |   16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> index 6f49bf39183c..f545f3633f88 100644
> --- a/fs/xfs/kmem.c
> +++ b/fs/xfs/kmem.c
> @@ -13,19 +13,11 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
>  {
>  	int	retries = 0;
>  	gfp_t	lflags = kmem_flags_convert(flags);
> -	void	*ptr;
>  
>  	trace_kmem_alloc(size, flags, _RET_IP_);
>  
> -	do {
> -		ptr = kmalloc(size, lflags);
> -		if (ptr || (flags & KM_MAYFAIL))
> -			return ptr;
> -		if (!(++retries % 100))
> -			xfs_err(NULL,
> -	"%s(%u) possible memory allocation deadlock size %u in %s (mode:0x%x)",
> -				current->comm, current->pid,
> -				(unsigned int)size, __func__, lflags);
> -		congestion_wait(BLK_RW_ASYNC, HZ/50);
> -	} while (1);
> +	if (!(flags & KM_MAYFAIL))
> +		lflags |= __GFP_NOFAIL;
> +
> +	return kmalloc(size, lflags);
>  }

Which means we no longer get warnings about memory allocation
failing - kmem_flags_convert() sets __GFP_NOWARN for all allocations
in this loop. Hence we'll now get silent deadlocks through this code
instead of getting warnings that memory allocation is failing
repeatedly.

I also wonder about changing the backoff behaviour here (it's a 20ms
wait right now because there are not early wakeups) will affect the
behaviour, as __GFP_NOFAIL won't wait for that extra time between
allocation attempts....

And, of course, how did you test this? Sometimes we see
unpredicted behaviours as a result of "simple" changes like this
under low memory conditions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
