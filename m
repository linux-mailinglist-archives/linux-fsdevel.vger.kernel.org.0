Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C344100DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 23:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhIQVq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 17:46:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49931 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231147AbhIQVq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:46:58 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 00F248826F6;
        Sat, 18 Sep 2021 07:45:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mRLfk-00Dfe5-9E; Sat, 18 Sep 2021 07:45:28 +1000
Date:   Sat, 18 Sep 2021 07:45:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
Message-ID: <20210917214528.GR2361455@dread.disaster.area>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741781.29351.4475236694432020436.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163184741781.29351.4475236694432020436.stgit@noble.brown>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=v5R2KkZAp00oN_xiK1YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:56:57PM +1000, NeilBrown wrote:
> Documentation commment in gfp.h discourages indefinite retry loops on
> ENOMEM and says of __GFP_NOFAIL that it
> 
>     is definitely preferable to use the flag rather than opencode
>     endless loop around allocator.
> 
> So remove the loop, instead specifying __GFP_NOFAIL if KM_MAYFAIL was
> not given.
> 
> As we no longer have the opportunity to report a warning after some
> failures, clear __GFP_NOWARN so that the default warning (rate-limited
> to 1 ever 10 seconds) will be reported instead.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/xfs/kmem.c |   19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> index 6f49bf39183c..575a58e61391 100644
> --- a/fs/xfs/kmem.c
> +++ b/fs/xfs/kmem.c
> @@ -11,21 +11,14 @@
>  void *
>  kmem_alloc(size_t size, xfs_km_flags_t flags)
>  {
> -	int	retries = 0;
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
> +	if (!(flags & KM_MAYFAIL)) {
> +		lflags |= __GFP_NOFAIL;
> +		lflags &= ~__GFP_NOWARN;
> +	}

This logic should really be in kmem_flags_convert() where the gfp
flags are set up. kmem_flags_convert() is only called by
kmem_alloc() now so you should just be able to hack that logic
to do exactly what is necessary.

FWIW, We've kinda not been caring about warts in this code because
the next step for kmem_alloc is to remove kmem_alloc/kmem_zalloc
completely and replace all the callers with kmalloc/kzalloc being
passed the correct gfp flags. There's about 30 kmem_alloc() callers
and 45 kmem_zalloc() calls left to be converted before kmem.[ch] can
go away completely....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
