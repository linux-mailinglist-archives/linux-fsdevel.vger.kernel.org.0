Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A32440A5F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 07:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhINFeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 01:34:25 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:51871 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237341AbhINFeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:34:24 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 39C52ECB28F;
        Tue, 14 Sep 2021 15:33:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQ140-00CGXq-43; Tue, 14 Sep 2021 15:33:00 +1000
Date:   Tue, 14 Sep 2021 15:33:00 +1000
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
Subject: Re: [PATCH 6/6] XFS: remove congestion_wait() loop from
 xfs_buf_alloc_pages()
Message-ID: <20210914053300.GI2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838440.13293.12568710689057349786.stgit@noble.brown>
 <20210914020837.GH2361455@dread.disaster.area>
 <163158695921.3992.9776900395549582360@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163158695921.3992.9776900395549582360@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=7-415B0cAAAA:8 a=yYcZo1LRrv0jFWDY_EMA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:35:59PM +1000, NeilBrown wrote:
> On Tue, 14 Sep 2021, Dave Chinner wrote:
> > On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > > Documentation commment in gfp.h discourages indefinite retry loops on
> > > ENOMEM and says of __GFP_NOFAIL that it
> > > 
> > >     is definitely preferable to use the flag rather than opencode
> > >     endless loop around allocator.
> > > 
> > > congestion_wait() is indistinguishable from
> > > schedule_timeout_uninterruptible() in practice and it is not a good way
> > > to wait for memory to become available.
> > > 
> > > So instead of waiting, allocate a single page using __GFP_NOFAIL, then
> > > loop around and try to get any more pages that might be needed with a
> > > bulk allocation.  This single-page allocation will wait in the most
> > > appropriate way.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/xfs/xfs_buf.c |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > > index 5fa6cd947dd4..1ae3768f6504 100644
> > > --- a/fs/xfs/xfs_buf.c
> > > +++ b/fs/xfs/xfs_buf.c
> > > @@ -372,8 +372,8 @@ xfs_buf_alloc_pages(
> > >  
> > >  	/*
> > >  	 * Bulk filling of pages can take multiple calls. Not filling the entire
> > > -	 * array is not an allocation failure, so don't back off if we get at
> > > -	 * least one extra page.
> > > +	 * array is not an allocation failure, so don't fail or fall back on
> > > +	 * __GFP_NOFAIL if we get at least one extra page.
> > >  	 */
> > >  	for (;;) {
> > >  		long	last = filled;
> > > @@ -394,7 +394,7 @@ xfs_buf_alloc_pages(
> > >  		}
> > >  
> > >  		XFS_STATS_INC(bp->b_mount, xb_page_retries);
> > > -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
> > > +		bp->b_pages[filled++] = alloc_page(gfp_mask | __GFP_NOFAIL);
> > 
> > This smells wrong - the whole point of using the bulk page allocator
> > in this loop is to avoid the costly individual calls to
> > alloc_page().
> > 
> > What we are implementing here fail-fast semantics for readahead and
> > fail-never for everything else.  If the bulk allocator fails to get
> > a page from the fast path free lists, it already falls back to
> > __alloc_pages(gfp, 0, ...) to allocate a single page. So AFAICT
> > there's no need to add another call to alloc_page() because we can
> > just do this instead:
> > 
> > 	if (flags & XBF_READ_AHEAD)
> > 		gfp_mask |= __GFP_NORETRY;
> > 	else
> > -		gfp_mask |= GFP_NOFS;
> > +		gfp_mask |= GFP_NOFS | __GFP_NOFAIL;
> > 
> > Which should make the __alloc_pages() call in
> > alloc_pages_bulk_array() do a __GFP_NOFAIL allocation and hence
> > provide the necessary never-fail guarantee that is needed here.
> 
> That is a nice simplification.
> Mel Gorman told me
>   https://lore.kernel.org/linux-nfs/20210907153116.GJ3828@suse.com/
> that alloc_pages_bulk ignores GFP_NOFAIL.  I added that to the
> documentation comment in an earlier patch.

Well, that's a surprise to me - I can't see where it masked out
NOFAIL, and it seems quite arbitrary to just say "different code
needs different fallbacks, so you can't have NOFAIL" despite NOFAIL
being the exact behavioural semantics one of only three users of the
bulk allocator really needs...

> I had a look at the code and cannot see how it would fail to allocate at
> least one page.  Maybe Mel can help....

Yup, clarification is definitely needed here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
