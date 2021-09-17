Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CBF40FA8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhIQOoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 10:44:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhIQOoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:44:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6DEE02028D;
        Fri, 17 Sep 2021 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631889756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Q9z58nJWZPYLSInI8nBVh8lTbi5/ptCY6EYwUNxRM4=;
        b=MUYuU0fOLsgnj8zbOAkl/3jMLDnS31vFMWaKPHkYgJw1tZkKnIOLzJy7WrbTXqjqEpHMcL
        ClB0fxX40hbcNJFuD00Rt8mCP7uEGLcZYn7LWcomJtLEJLljcA0Z26Y7EeL/pJwQuXZ5R/
        yKRTA4uf38taeV1zhjd6CARyC2keir4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631889756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Q9z58nJWZPYLSInI8nBVh8lTbi5/ptCY6EYwUNxRM4=;
        b=iQepc13dGR2A2g+ziflA00yEmJbebWNeoIDsac1mJMFizHHqfl7RS8h8Wtor/t/r2KaHLs
        t43wYd5JMlQXYmBQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21802A3BFF;
        Fri, 17 Sep 2021 14:42:35 +0000 (UTC)
Date:   Fri, 17 Sep 2021 15:42:33 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] MM: Support __GFP_NOFAIL in  alloc_pages_bulk_*()
 and improve doco
Message-ID: <20210917144233.GD3891@suse.de>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741776.29351.3565418361661850328.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163184741776.29351.3565418361661850328.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm top-posting to cc Jesper with full context of the patch. I don't
have a problem with this patch other than the Fixes: being a bit
marginal, I should have acked as Mel Gorman <mgorman@suse.de> and the
@gfp in the comment should have been @gfp_mask.

However, an assumption the API design made was that it should fail fast
if memory is not quickly available but have at least one page in the
array. I don't think the network use case cares about the situation where
the array is already populated but I'd like Jesper to have the opportunity
to think about it.  It's possible he would prefer it's explicit and the
check becomes
(!nr_populated || ((gfp_mask & __GFP_NOFAIL) && !nr_account)) to
state that __GFP_NOFAIL users are willing to take a potential latency
penalty if the array is already partially populated but !__GFP_NOFAIL
users would prefer fail-fast behaviour. I'm on the fence because while
I wrote the implementation, it was based on other peoples requirements.

On Fri, Sep 17, 2021 at 12:56:57PM +1000, NeilBrown wrote:
> When alloc_pages_bulk_array() is called on an array that is partially
> allocated, the level of effort to get a single page is less than when
> the array was completely unallocated.  This behaviour is inconsistent,
> but now fixed.  One effect if this is that __GFP_NOFAIL will not ensure
> at least one page is allocated.
> 
> Also clarify the expected success rate.  __alloc_pages_bulk() will
> allocated one page according to @gfp, and may allocate more if that can
> be done cheaply.  It is assumed that the caller values cheap allocation
> where possible and may decide to use what it has got, or to call again
> to get more.
> 
> Acked-by: Mel Gorman <mgorman@suse.com>
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/page_alloc.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..aa51016e49c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5191,6 +5191,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>   * is the maximum number of pages that will be stored in the array.
>   *
>   * Returns the number of pages on the list or array.
> + *
> + * At least one page will be allocated if that is possible while
> + * remaining consistent with @gfp.  Extra pages up to the requested
> + * total will be allocated opportunistically when doing so is
> + * significantly cheaper than having the caller repeat the request.
>   */
>  unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  			nodemask_t *nodemask, int nr_pages,
> @@ -5292,7 +5297,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  								pcp, pcp_list);
>  		if (unlikely(!page)) {
>  			/* Try and get at least one page */
> -			if (!nr_populated)
> +			if (!nr_account)
>  				goto failed_irq;
>  			break;
>  		}
> 
> 
