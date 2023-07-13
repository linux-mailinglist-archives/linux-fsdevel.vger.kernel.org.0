Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C07751794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMEiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMEiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3039E69;
        Wed, 12 Jul 2023 21:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF6F619B0;
        Thu, 13 Jul 2023 04:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4A3C433C7;
        Thu, 13 Jul 2023 04:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689223084;
        bh=wke16a/EnSnVp+bFevxTgFeJfHXzevgvFiWdBS6vTq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2xGk3OcvS5PZSDBwS8LqaKyqDr8qbu+YDbJPABsh0mRiCCtU6KJ7+DtkdmrubZHR
         Lg0pC6Pg5zVjHiTYfMdx3wiQqbogHKOKxXeAANVhQguy6OHyxLrKiZAarW6L5tIYXh
         2B09RhjZmGLd1dwsOO5NqoFd+PPQcTvkQM5StH/l/4qh5HkHXYxjs9ESLXLh6uzk/S
         FD5qCNqoJr5IWpqe4rCQFL7+fnsRRC8Ylt/YyukGrAR6UcbzGAnV2DqV/P/nvI3sAQ
         NVyhITfaZlaeQbJSNtOlIMXdO7hRj+VFOigzpHfvLqeZv1V0TAXn/T9gjd0MfZLqiV
         tdCqldZHyI2uQ==
Date:   Wed, 12 Jul 2023 21:38:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Aravinda Herle <araherle@in.ibm.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv11 8/8] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <20230713043804.GG108251@frogsfrogsfrogs>
References: <ZKdUN7ALMSCKPBV/@casper.infradead.org>
 <87cz0z4okc.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz0z4okc.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:49:15PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> Sorry for the delayed response. I am currently on travel.
> 
> > On Fri, Jul 07, 2023 at 08:16:17AM +1000, Dave Chinner wrote:
> >> On Thu, Jul 06, 2023 at 06:42:36PM +0100, Matthew Wilcox wrote:
> >> > On Thu, Jul 06, 2023 at 08:16:05PM +0530, Ritesh Harjani wrote:
> >> > > > @@ -1645,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >> > > >  	int error = 0, count = 0, i;
> >> > > >  	LIST_HEAD(submit_list);
> >> > > >  
> >> > > > +	if (!ifs && nblocks > 1) {
> >> > > > +		ifs = ifs_alloc(inode, folio, 0);
> >> > > > +		iomap_set_range_dirty(folio, 0, folio_size(folio));
> >> > > > +	}
> >> > > > +
> >> > > >  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
> >> > > >  
> >> > > >  	/*
> >> > > > @@ -1653,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >> > > >  	 * invalid, grab a new one.
> >> > > >  	 */
> >> > > >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> >> > > > -		if (ifs && !ifs_block_is_uptodate(ifs, i))
> >> > > > +		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
> >> > > >  			continue;
> >> > > >  
> >> > > >  		error = wpc->ops->map_blocks(wpc, inode, pos);
> >> > > > @@ -1697,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >> > > >  		}
> >> > > >  	}
> >> > > >  
> >> > > > +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
> >> > > >  	folio_start_writeback(folio);
> >> > > >  	folio_unlock(folio);
> >> > > >  
> >> > > 
> >> > > I think we should fold below change with this patch. 
> >> > > end_pos is calculated in iomap_do_writepage() such that it is either
> >> > > folio_pos(folio) + folio_size(folio), or if this value becomes more then
> >> > > isize, than end_pos is made isize.
> >> > > 
> >> > > The current patch does not have a functional problem I guess. But in
> >> > > some cases where truncate races with writeback, it will end up marking
> >> > > more bits & later doesn't clear those. Hence I think we should correct
> >> > > it using below diff.
> >> > 
> >> > I don't think this is the only place where we'll set dirty bits beyond
> >> > EOF.  For example, if we mmap the last partial folio in a file,
> >> > page_mkwrite will dirty the entire folio, but we won't write back
> >> > blocks past EOF.  I think we'd be better off clearing all the dirty
> >> > bits in the folio, even the ones past EOF.  What do you think?
> 
> Yup. I agree, it's better that way to clear all dirty bits in the folio.
> Thanks for the suggestion & nice catch!! 
> 
> >> 
> >> Clear the dirty bits beyond EOF where we zero the data range beyond
> >> EOF in iomap_do_writepage() via folio_zero_segment()?
> >
> > That would work, but I think it's simpler to change:
> >
> > -	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
> > +	iomap_clear_range_dirty(folio, 0, folio_size(folio));
> 
> Right. 
> 
> @Darrick,
> IMO, we should fold below change with Patch-8. If you like I can send a v12
> with this change. I re-tested 1k-blocksize fstests on x86 with
> below changes included and didn't find any surprise. Also v11 series
> including the below folded change is cleanly applicable on your
> iomap-for-next branch.

Yes, please fold this into v12.  I think Matthew might want to get these
iomap folio changes out to for-next even sooner than -rc4.  If there's
time during this week's ext4 call, let's talk about that.

--D

> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b6280e053d68..de212b6fe467 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1766,9 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>         int error = 0, count = 0, i;
>         LIST_HEAD(submit_list);
> 
> +       WARN_ON_ONCE(end_pos <= pos);
> +
>         if (!ifs && nblocks > 1) {
>                 ifs = ifs_alloc(inode, folio, 0);
> -               iomap_set_range_dirty(folio, 0, folio_size(folio));
> +               iomap_set_range_dirty(folio, 0, end_pos - pos);
>         }
> 
>         WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
> @@ -1823,7 +1825,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>                 }
>         }
> 
> -       iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
> +       /*
> +        * We can have dirty bits set past end of file in page_mkwrite path
> +        * while mapping the last partial folio. Hence it's better to clear
> +        * all the dirty bits in the folio here.
> +        */
> +       iomap_clear_range_dirty(folio, 0, folio_size(folio));
>         folio_start_writeback(folio);
>         folio_unlock(folio);
> 
> --
> 2.30.2
> 
> 
> -ritesh
