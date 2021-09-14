Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0640B52C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhINQq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 12:46:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhINQq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:46:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76C6520141;
        Tue, 14 Sep 2021 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631637907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozFdqBIwmwyJglrohMvn3NkJIfp+ikVZXcbLX7txgcw=;
        b=c+tWXz3iFiMt2fBT2y8zj5/DP3kTS+clAtQNQjW/Q0M6SxwQAy6krw8G8j0cJ8C2E/b09i
        awJaPyl97itLD9c6bLIbr1CN+kU50My+7nVpVgBukC5bx/DrxIAwFzjQQkm1Bg2V8RK7QV
        BDTYLlCiPqBuvc5JJPd+Ai4Uy25bW3s=
Received: from suse.com (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B15CCA3B94;
        Tue, 14 Sep 2021 16:45:06 +0000 (UTC)
Date:   Tue, 14 Sep 2021 17:45:04 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] XFS: remove congestion_wait() loop from
 xfs_buf_alloc_pages()
Message-ID: <20210914164504.GS3828@suse.com>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838440.13293.12568710689057349786.stgit@noble.brown>
 <20210914020837.GH2361455@dread.disaster.area>
 <163158695921.3992.9776900395549582360@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163158695921.3992.9776900395549582360@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 
> I had a look at the code and cannot see how it would fail to allocate at
> least one page.  Maybe Mel can help....
> 

If there are already at least one page an the array and the first attempt
at bulk allocation fails, it'll simply return. It's an odd corner case
that may never apply but it's possible.  That said, I'm of the opinion that
__GFP_NOFAIL should not be expanded and instead congestion_wait should be
deleted and replaced with something triggered by reclaim making progress.

-- 
Mel Gorman
SUSE Labs
