Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9040A396
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhINCh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 22:37:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhINChX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:37:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4EDB21DDB;
        Tue, 14 Sep 2021 02:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631586965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Np1b24Y1jsf4JFXb99vT1VoKvE/1uNudORwJZ2vKFkc=;
        b=LSFcqfcpRgFTnxIQwkZmmJe5i8WfcEz6ATENYq3zy8Mt9igIghRP4XJgl57iMpRTwu3VL7
        QcwyCrixojHmBVyyzyEijkfq4TtdGURNfAaQ4If3S8HH2xdNWzlKTywqXRWrg2cLUYIC02
        aI6hRzXjQLSphhYMWQUymmWazx8Sw4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631586965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Np1b24Y1jsf4JFXb99vT1VoKvE/1uNudORwJZ2vKFkc=;
        b=c7rLL2e4zLbiZ4/9hj+D7oO6Patx1a8luivPZ/+WDAuEi5ggAe+X5Ft+bUuKnDRjfBorV7
        FDrEY8jjzyqeB7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33AB513B56;
        Tue, 14 Sep 2021 02:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S0spOJEKQGHWFgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 02:36:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] XFS: remove congestion_wait() loop from xfs_buf_alloc_pages()
In-reply-to: <20210914020837.GH2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838440.13293.12568710689057349786.stgit@noble.brown>,
 <20210914020837.GH2361455@dread.disaster.area>
Date:   Tue, 14 Sep 2021 12:35:59 +1000
Message-id: <163158695921.3992.9776900395549582360@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Sep 2021, Dave Chinner wrote:
> On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > Documentation commment in gfp.h discourages indefinite retry loops on
> > ENOMEM and says of __GFP_NOFAIL that it
> > 
> >     is definitely preferable to use the flag rather than opencode
> >     endless loop around allocator.
> > 
> > congestion_wait() is indistinguishable from
> > schedule_timeout_uninterruptible() in practice and it is not a good way
> > to wait for memory to become available.
> > 
> > So instead of waiting, allocate a single page using __GFP_NOFAIL, then
> > loop around and try to get any more pages that might be needed with a
> > bulk allocation.  This single-page allocation will wait in the most
> > appropriate way.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/xfs/xfs_buf.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 5fa6cd947dd4..1ae3768f6504 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -372,8 +372,8 @@ xfs_buf_alloc_pages(
> >  
> >  	/*
> >  	 * Bulk filling of pages can take multiple calls. Not filling the entire
> > -	 * array is not an allocation failure, so don't back off if we get at
> > -	 * least one extra page.
> > +	 * array is not an allocation failure, so don't fail or fall back on
> > +	 * __GFP_NOFAIL if we get at least one extra page.
> >  	 */
> >  	for (;;) {
> >  		long	last = filled;
> > @@ -394,7 +394,7 @@ xfs_buf_alloc_pages(
> >  		}
> >  
> >  		XFS_STATS_INC(bp->b_mount, xb_page_retries);
> > -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
> > +		bp->b_pages[filled++] = alloc_page(gfp_mask | __GFP_NOFAIL);
> 
> This smells wrong - the whole point of using the bulk page allocator
> in this loop is to avoid the costly individual calls to
> alloc_page().
> 
> What we are implementing here fail-fast semantics for readahead and
> fail-never for everything else.  If the bulk allocator fails to get
> a page from the fast path free lists, it already falls back to
> __alloc_pages(gfp, 0, ...) to allocate a single page. So AFAICT
> there's no need to add another call to alloc_page() because we can
> just do this instead:
> 
> 	if (flags & XBF_READ_AHEAD)
> 		gfp_mask |= __GFP_NORETRY;
> 	else
> -		gfp_mask |= GFP_NOFS;
> +		gfp_mask |= GFP_NOFS | __GFP_NOFAIL;
> 
> Which should make the __alloc_pages() call in
> alloc_pages_bulk_array() do a __GFP_NOFAIL allocation and hence
> provide the necessary never-fail guarantee that is needed here.

That is a nice simplification.
Mel Gorman told me
  https://lore.kernel.org/linux-nfs/20210907153116.GJ3828@suse.com/
that alloc_pages_bulk ignores GFP_NOFAIL.  I added that to the
documentation comment in an earlier patch.

I had a look at the code and cannot see how it would fail to allocate at
least one page.  Maybe Mel can help....

NeilBrown
 


> 
> At which point, the bulk allocation loop can be simplified because
> we can only fail bulk allocation for readahead, so something like:
> 
> 		if (filled == bp->b_page_count) {
> 			XFS_STATS_INC(bp->b_mount, xb_page_found);
> 			break;
> 		}
> 
> -		if (filled != last)
> +		if (filled == last) {
> -			continue;
> -
> -		if (flags & XBF_READ_AHEAD) {
> 			ASSERT(flags & XBF_READ_AHEAD);
> 			xfs_buf_free_pages(bp);
> 			return -ENOMEM;
> 		}
> 
> 		XFS_STATS_INC(bp->b_mount, xb_page_retries);
> -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
> 	}
> 	return 0;
> }
> 
> would do the right thing and still record that we are doing
> blocking allocations (via the xb_page_retries stat) in this loop.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
