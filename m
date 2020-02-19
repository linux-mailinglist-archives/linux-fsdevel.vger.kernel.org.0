Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE6163B80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSDn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:43:28 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45778 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgBSDn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:43:28 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 880BB3A1C09;
        Wed, 19 Feb 2020 14:43:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4GGi-0005Z3-WB; Wed, 19 Feb 2020 14:43:25 +1100
Date:   Wed, 19 Feb 2020 14:43:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v6 19/19] mm: Use memalloc_nofs_save in readahead path
Message-ID: <20200219034324.GG10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-33-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
        a=EUu7BJ-CshYY2WUz2RUA:9 a=Ins956pMss7IOATM:21 a=TqZTP-Om_uFHSJHF:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:46:13AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Ensure that memory allocations in the readahead path do not attempt to
> reclaim file-backed pages, which could lead to a deadlock.  It is
> possible, though unlikely this is the root cause of a problem observed
> by Cong Wang.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/readahead.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 94d499cfb657..8f9c0dba24e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/blk-cgroup.h>
>  #include <linux/fadvise.h>
> +#include <linux/sched/mm.h>
>  
>  #include "internal.h"
>  
> @@ -174,6 +175,18 @@ void page_cache_readahead_limit(struct address_space *mapping,
>  		._nr_pages = 0,
>  	};
>  
> +	/*
> +	 * Partway through the readahead operation, we will have added
> +	 * locked pages to the page cache, but will not yet have submitted
> +	 * them for I/O.  Adding another page may need to allocate memory,
> +	 * which can trigger memory reclaim.  Telling the VM we're in
> +	 * the middle of a filesystem operation will cause it to not
> +	 * touch file-backed pages, preventing a deadlock.  Most (all?)
> +	 * filesystems already specify __GFP_NOFS in their mapping's
> +	 * gfp_mask, but let's be explicit here.
> +	 */
> +	unsigned int nofs = memalloc_nofs_save();
> +

So doesn't this largely remove the need for all the gfp flag futzing
in the readahead path? i.e. almost all readahead allocations are now
going to be GFP_NOFS | GFP_NORETRY | GFP_NOWARN ?

If so, shouldn't we just strip all the gfp flags and masking out of
the readahead path altogether?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
