Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE85ED409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 06:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiI1Eyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 00:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiI1Eya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D525116C23;
        Tue, 27 Sep 2022 21:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE3CC61CE8;
        Wed, 28 Sep 2022 04:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE81C433C1;
        Wed, 28 Sep 2022 04:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664340868;
        bh=xUCdYlQrKiEK7yY8XCMc15Scd/RyXQk+HqhUGX+8y0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnehuv1y+lbDRcXzJTDlK6RYKjujsKG40nArT8FBx+cNEAtApbjcZ4u8izJb1zWGp
         ETuKw51osVtfs0WajbYumJEp8Fj6XT1TWV9fwRUR/EciPGSfTtjOgFzu80xO0IHvvD
         yK2/lXM0hk5wHllnAUCeMklBWuO0637ldb3dnARAzhOfZwBZIW0Pnbl3Ynh0iNvO9h
         Sz5d1GgIDAofc5vTxqPCa/7wddrq9u5XRtAerIp3xSXTH4ub3VkOxeU2X4glR7Mn+B
         jeYbZ2y5wXkj4BjEJpAjR/VyuwNIzoGOApBo9KY1maNNtmt95Efa3oy2PJHKhrVpdT
         U61yX+33e/Dow==
Date:   Tue, 27 Sep 2022 21:54:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <YzPTg8jrDiNBU1N/@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com>
 <YyvaAY6UT1gKRF9U@magnolia>
 <20220923000403.GW3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923000403.GW3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:04:03AM +1000, Dave Chinner wrote:
> On Wed, Sep 21, 2022 at 08:44:01PM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 21, 2022 at 06:29:59PM +1000, Dave Chinner wrote:
> > >  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > @@ -1160,13 +1181,20 @@ xfs_buffered_write_iomap_end(
> > >  
> > >  	/*
> > >  	 * Trim delalloc blocks if they were allocated by this write and we
> > > -	 * didn't manage to write the whole range.
> > > +	 * didn't manage to write the whole range. If the iomap was marked stale
> > > +	 * because it is no longer valid, we are going to remap this range
> > > +	 * immediately, so don't punch it out.
> > >  	 *
> > > -	 * We don't need to care about racing delalloc as we hold i_mutex
> > > +	 * XXX (dgc): This next comment and assumption is totally bogus because
> > > +	 * iomap_page_mkwrite() runs through here and it doesn't hold the
> > > +	 * i_rwsem. Hence this whole error handling path may be badly broken.
> > 
> > That probably needs fixing, though I'll break that out as a separate
> > reply to the cover letter.
> 
> I'll drop it for the moment - I wrote that note when I first noticed
> the problem as a "reminder to self" to mention it the problem in the
> cover letter because....
> 
> > 
> > > +	 *
> > > +	 * We don't need to care about racing delalloc as we hold i_rwsem
> > >  	 * across the reserve/allocate/unreserve calls. If there are delalloc
> > >  	 * blocks in the range, they are ours.
> > >  	 */
> > > -	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
> > > +	if (((iomap->flags & (IOMAP_F_NEW | IOMAP_F_STALE)) == IOMAP_F_NEW) &&
> > > +	    start_fsb < end_fsb) {
> > >  		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> > >  					 XFS_FSB_TO_B(mp, end_fsb) - 1);
> 
> .... I really don't like this "fix". If the next mapping (the
> revalidated range) doesn't exactly fill the remainder of the
> original delalloc mapping within EOF, we end up with delalloc blocks
> within EOF that have no data in the page cache over them. i.e. this
> relies on blind luck to avoid unflushable delalloc extents and is a
> serious landmine to be leaving behind.

I'd kinda wondered over the years why not just leave pages in place and
in whatever state they were before, but never really wanted to dig too
deep into that.  I suppose I will when the v2 patchset arrives.

> The fact we want buffered writes to move to shared i_rwsem operation
> also means that we have no guarantee that nobody else has added data
> into the page cache over this delalloc range. Hence punching out the
> page cache and then the delalloc blocks is exactly the wrong thing
> to be doing.
> 
> Further, racing mappings over this delalloc range mean that those
> other contexts will also be trying to zero ranges of partial pages
> because iomap_block_needs_zeroing() returns true for IOMAP_DELALLOC
> mappings regardless of IOMAP_F_NEW.
> 
> Indeed, XFS is only using IOMAP_F_NEW on the initial delalloc
> mapping to perform the above "do we need to punch out the unused
> range" detection in xfs_buffered_write_iomap_end(). i.e. it's a flag
> that says "we allocated this delalloc range", but it in no way
> indicates "we are the only context that has written data into this
> delalloc range".
> 
> Hence I suspect that the first thing we need to do here is get rid
> of this use of IOMAP_F_NEW and the punching out of delalloc range
> on write error. I think what we need to do here is walk the page
> cache over the range of the remaining delalloc region and for every
> hole that we find in the page cache, we punch only that range out.

That would make more sense; I bet we'd have tripped over this as soon as
we shifted buffered writes to IOLOCK_SHARED and failed a write().

> We probably need to do this holding the mapping->invalidate_lock
> exclusively to ensure the page cache contents do not change while
> we are doing this walk - this will at least cause other contexts
> that have the delalloc range mapped to block during page cache
> insertion. This will then cause the the ->iomap_valid() check they
> run once the folio is inserted and locked to detect that the iomap
> they hold is now invalid an needs remapping...

<nod>

> This would avoid the need for IOMAP_F_STALE and IOMAP_F_NEW to be
> propagated into the new contexts - only iomap_iter() would need to
> handle advancing STALE maps with 0 bytes processed specially....

Ooh nice.

> > > @@ -1182,9 +1210,26 @@ xfs_buffered_write_iomap_end(
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * Check that the iomap passed to us is still valid for the given offset and
> > > + * length.
> > > + */
> > > +static bool
> > > +xfs_buffered_write_iomap_valid(
> > > +	struct inode		*inode,
> > > +	const struct iomap	*iomap)
> > > +{
> > > +	int			seq = *((int *)&iomap->private);
> > > +
> > > +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> > > +		return false;
> > > +	return true;
> > > +}
> > 
> > Wheee, thanks for tackling this one. :)
> 
> I think this one might have a long way to run yet.... :/

It's gonna be a fun time backporting this all to 4.14. ;)

Btw, can you share the reproducer?

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
