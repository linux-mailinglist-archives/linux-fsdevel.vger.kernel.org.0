Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B494075182A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 07:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjGMFdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 01:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGMFde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DB119;
        Wed, 12 Jul 2023 22:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9399618CF;
        Thu, 13 Jul 2023 05:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BE0C433C8;
        Thu, 13 Jul 2023 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689226412;
        bh=vZkKGHhN3ishnu+kL0CphEC71YWo5yf7cD7CL+0u7hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1aPzS1NgbJC35nkRYRSvRDxg5APTYtuAwjU6/XIzegY3o2digYJt5thwQZHGoAkz
         +vdlBVBpVhhc3juzjbmV6JsoXoZoRniarQH8aNXLGkKdo2jcFJ3dnfLjNektsD3AOx
         tzNsV2eVpMZQNAPDVHu2uiti/5jLG1DByzurD1u8OYpiOIFwFsFEoN54rbxDK/ErDR
         /cUI0L97F7sczbNAmqDaQzL6x/yCTQrfU7rUeG12ooQ8Yqy2QuSRbqAiOq1fAje/l0
         x2ow0uhJ3YitMG6zXs2Al/mveVxqX9xB4uXzPA0/vCqBlHSxbXis+Kdjcd25IdzNmM
         221GRv21w9ipA==
Date:   Wed, 12 Jul 2023 22:33:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 5/9] iomap: Remove unnecessary test from
 iomap_release_folio()
Message-ID: <20230713053331.GG11476@frogsfrogsfrogs>
References: <20230713044558.GJ108251@frogsfrogsfrogs>
 <87351s8jsv.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87351s8jsv.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:55:20AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > [add ritesh]
> >
> > On Mon, Jul 10, 2023 at 02:02:49PM +0100, Matthew Wilcox (Oracle) wrote:
> >> The check for the folio being under writeback is unnecessary; the caller
> >> has checked this and the folio is locked, so the folio cannot be under
> >> writeback at this point.
> >> 
> >> The comment is somewhat misleading in that it talks about one specific
> >> situation in which we can see a dirty folio.  There are others, so change
> >> the comment to explain why we can't release the iomap_page.
> >> 
> >> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>  fs/iomap/buffered-io.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 1cb905140528..7aa3009f907f 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -483,12 +483,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
> >>  			folio_size(folio));
> >>  
> >>  	/*
> >> -	 * mm accommodates an old ext3 case where clean folios might
> >> -	 * not have had the dirty bit cleared.  Thus, it can send actual
> >> -	 * dirty folios to ->release_folio() via shrink_active_list();
> >> -	 * skip those here.
> >> +	 * If the folio is dirty, we refuse to release our metadata because
> >> +	 * it may be partially dirty.  Once we track per-block dirty state,
> >> +	 * we can release the metadata if every block is dirty.
> >
> > Ritesh: I'm assuming that implementing this will be part of your v12 series?
> 
> No, if it's any optimization, then I think we can take it up later too,

<nod>

> not in v12 please (I have been doing some extensive testing of current series).
> Also let me understand it a bit more.
> 
> @willy,
> Is this what you are suggesting? So this is mainly to free up some
> memory for iomap_folio_state structure then right?

I think it's also to break up compound folios to free base pages or
other reasons.

https://lore.kernel.org/linux-xfs/20230713044326.GI108251@frogsfrogsfrogs/T/#mc83fe929d57e9aa3c1834232389cad0d62b66e7b

> But then whenever we are doing a writeback, we anyway would be
> allocating iomap_folio_state() and marking all the bits dirty. Isn't it
> sub-optimal then?  
> 
> @@ -489,8 +489,11 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>          * it may be partially dirty.  Once we track per-block dirty state,
>          * we can release the metadata if every block is dirty.
>          */
> -       if (folio_test_dirty(folio))
> +       if (folio_test_dirty(folio)) {
> +               if (ifs_is_fully_dirty(folio, ifs))
> +                       iomap_page_release(folio);
>                 return false;
> +       }

I think it's more that we *dont* break up partially dirty folios:

	/*
	 * Folio is partially dirty, do not throw away the state or
	 * split the folio.
	 */
	if (folio_test_dirty(folio) && !ifs_is_fully_dirty(folio, ifs))
		return false;

	/* No more private state tracking, ok to split folio. */
	iomap_page_release(folio);
	return true;

But breaking up fully dirty folios is now possible, since the mm can
mark all the basepages dirty.

--D

>         iomap_page_release(folio);
>         return true;
>  }
> 
> (Ignore the old and new apis naming in above. It is just to get an idea)
> 
> -ritesh
> 
> >
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> >
> > --D
> >
> >>  	 */
> >> -	if (folio_test_dirty(folio) || folio_test_writeback(folio))
> >> +	if (folio_test_dirty(folio))
> >>  		return false;
> >>  	iomap_page_release(folio);
> >>  	return true;
> >> -- 
> >> 2.39.2
> >> 
