Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432D5E7079
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIWAEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 20:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIWAEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:04:07 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C44E7C1B6;
        Thu, 22 Sep 2022 17:04:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0EEC78A9F31;
        Fri, 23 Sep 2022 10:04:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1obWAl-00AzAm-5B; Fri, 23 Sep 2022 10:04:03 +1000
Date:   Fri, 23 Sep 2022 10:04:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <20220923000403.GW3600936@dread.disaster.area>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com>
 <YyvaAY6UT1gKRF9U@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyvaAY6UT1gKRF9U@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=632cf7f5
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=AKX2DsGfbjy1rBEkcb8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:44:01PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 21, 2022 at 06:29:59PM +1000, Dave Chinner wrote:
> >  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > @@ -1160,13 +1181,20 @@ xfs_buffered_write_iomap_end(
> >  
> >  	/*
> >  	 * Trim delalloc blocks if they were allocated by this write and we
> > -	 * didn't manage to write the whole range.
> > +	 * didn't manage to write the whole range. If the iomap was marked stale
> > +	 * because it is no longer valid, we are going to remap this range
> > +	 * immediately, so don't punch it out.
> >  	 *
> > -	 * We don't need to care about racing delalloc as we hold i_mutex
> > +	 * XXX (dgc): This next comment and assumption is totally bogus because
> > +	 * iomap_page_mkwrite() runs through here and it doesn't hold the
> > +	 * i_rwsem. Hence this whole error handling path may be badly broken.
> 
> That probably needs fixing, though I'll break that out as a separate
> reply to the cover letter.

I'll drop it for the moment - I wrote that note when I first noticed
the problem as a "reminder to self" to mention it the problem in the
cover letter because....

> 
> > +	 *
> > +	 * We don't need to care about racing delalloc as we hold i_rwsem
> >  	 * across the reserve/allocate/unreserve calls. If there are delalloc
> >  	 * blocks in the range, they are ours.
> >  	 */
> > -	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
> > +	if (((iomap->flags & (IOMAP_F_NEW | IOMAP_F_STALE)) == IOMAP_F_NEW) &&
> > +	    start_fsb < end_fsb) {
> >  		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> >  					 XFS_FSB_TO_B(mp, end_fsb) - 1);

.... I really don't like this "fix". If the next mapping (the
revalidated range) doesn't exactly fill the remainder of the
original delalloc mapping within EOF, we end up with delalloc blocks
within EOF that have no data in the page cache over them. i.e. this
relies on blind luck to avoid unflushable delalloc extents and is a
serious landmine to be leaving behind.

The fact we want buffered writes to move to shared i_rwsem operation
also means that we have no guarantee that nobody else has added data
into the page cache over this delalloc range. Hence punching out the
page cache and then the delalloc blocks is exactly the wrong thing
to be doing.

Further, racing mappings over this delalloc range mean that those
other contexts will also be trying to zero ranges of partial pages
because iomap_block_needs_zeroing() returns true for IOMAP_DELALLOC
mappings regardless of IOMAP_F_NEW.

Indeed, XFS is only using IOMAP_F_NEW on the initial delalloc
mapping to perform the above "do we need to punch out the unused
range" detection in xfs_buffered_write_iomap_end(). i.e. it's a flag
that says "we allocated this delalloc range", but it in no way
indicates "we are the only context that has written data into this
delalloc range".

Hence I suspect that the first thing we need to do here is get rid
of this use of IOMAP_F_NEW and the punching out of delalloc range
on write error. I think what we need to do here is walk the page
cache over the range of the remaining delalloc region and for every
hole that we find in the page cache, we punch only that range out.

We probably need to do this holding the mapping->invalidate_lock
exclusively to ensure the page cache contents do not change while
we are doing this walk - this will at least cause other contexts
that have the delalloc range mapped to block during page cache
insertion. This will then cause the the ->iomap_valid() check they
run once the folio is inserted and locked to detect that the iomap
they hold is now invalid an needs remapping...

This would avoid the need for IOMAP_F_STALE and IOMAP_F_NEW to be
propagated into the new contexts - only iomap_iter() would need to
handle advancing STALE maps with 0 bytes processed specially....

> > @@ -1182,9 +1210,26 @@ xfs_buffered_write_iomap_end(
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Check that the iomap passed to us is still valid for the given offset and
> > + * length.
> > + */
> > +static bool
> > +xfs_buffered_write_iomap_valid(
> > +	struct inode		*inode,
> > +	const struct iomap	*iomap)
> > +{
> > +	int			seq = *((int *)&iomap->private);
> > +
> > +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> > +		return false;
> > +	return true;
> > +}
> 
> Wheee, thanks for tackling this one. :)

I think this one might have a long way to run yet.... :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com
