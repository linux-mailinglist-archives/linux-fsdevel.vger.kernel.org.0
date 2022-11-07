Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81F620402
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 00:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiKGXx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 18:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKGXxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:53:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FACEAB;
        Mon,  7 Nov 2022 15:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39EDFB80BE6;
        Mon,  7 Nov 2022 23:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE60C433D6;
        Mon,  7 Nov 2022 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667865200;
        bh=PoKJUsk1RiVp81mJ4qWEo0aXM7N5izKz64ndcBgmMSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk74hSFltYAQM7f9wfMrVZdlxff1Q3Qst3te9IsVryOmMaCvXJo5b3ZHk0VZi7/Za
         hYBDq6Sgh+CaKp7iPkhzynqvWWbfCqXhjbUOMMaAO4loD8GWtAikZbk+q5NoCRRjqy
         nkbcpWmOanWnwK7EFUYQIlEAHCzd14B8b8LIWC0Z8n3cV2UjPqzaSjQkU+r4muwJnP
         TPttE9T4xLv3sbkpkegWq9m7HEeYYytc4a6H/VOP1SX4UOrTPlgkT3NzC75mu7/Pu2
         A52g+ZwvEXVjqNg4/ph5lbqGbQ5Ju3EnwoHjAHos586/fvPUqXsBZTPKbfOjGkAHKM
         wwxLCEUl/AvkQ==
Date:   Mon, 7 Nov 2022 15:53:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] xfs: use byte ranges for write cleanup ranges
Message-ID: <Y2macHjWzrwaMQXG@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-4-david@fromorbit.com>
 <Y2KbtTf224DNsyEA@magnolia>
 <20221104054015.GL3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104054015.GL3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:40:15PM +1100, Dave Chinner wrote:
> On Wed, Nov 02, 2022 at 09:32:53AM -0700, Darrick J. Wong wrote:
> > On Tue, Nov 01, 2022 at 11:34:08AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > xfs_buffered_write_iomap_end() currently converts the byte ranges
> > > passed to it to filesystem blocks to pass them to the bmap code to
> > > punch out delalloc blocks, but then has to convert filesytem
> > > blocks back to byte ranges for page cache truncate.
> > > 
> > > We're about to make the page cache truncate go away and replace it
> > > with a page cache walk, so having to convert everything to/from/to
> > > filesystem blocks is messy and error-prone. It is much easier to
> > > pass around byte ranges and convert to page indexes and/or
> > > filesystem blocks only where those units are needed.
> > > 
> > > In preparation for the page cache walk being added, add a helper
> > > that converts byte ranges to filesystem blocks and calls
> > > xfs_bmap_punch_delalloc_range() and convert
> > > xfs_buffered_write_iomap_end() to calculate limits in byte ranges.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 40 +++++++++++++++++++++++++---------------
> > >  1 file changed, 25 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index a2e45ea1b0cb..7bb55dbc19d3 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1120,6 +1120,20 @@ xfs_buffered_write_iomap_begin(
> > >  	return error;
> > >  }
> > >  
> > > +static int
> > > +xfs_buffered_write_delalloc_punch(
> > > +	struct inode		*inode,
> > > +	loff_t			start_byte,
> > > +	loff_t			end_byte)
> > > +{
> > > +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> > > +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> > > +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
> > > +
> > > +	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
> > > +				end_fsb - start_fsb);
> > > +}
> > 
> > /me echoes hch's comment that the other callers of
> > xfs_bmap_punch_delalloc_range do this byte->block conversion too.
> > 
> > > +
> > >  static int
> > >  xfs_buffered_write_iomap_end(
> > >  	struct inode		*inode,
> > > @@ -1129,10 +1143,9 @@ xfs_buffered_write_iomap_end(
> > >  	unsigned		flags,
> > >  	struct iomap		*iomap)
> > >  {
> > > -	struct xfs_inode	*ip = XFS_I(inode);
> > > -	struct xfs_mount	*mp = ip->i_mount;
> > > -	xfs_fileoff_t		start_fsb;
> > > -	xfs_fileoff_t		end_fsb;
> > > +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> > > +	loff_t			start_byte;
> > > +	loff_t			end_byte;
> > >  	int			error = 0;
> > >  
> > >  	if (iomap->type != IOMAP_DELALLOC)
> > > @@ -1157,13 +1170,13 @@ xfs_buffered_write_iomap_end(
> > >  	 * the range.
> > >  	 */
> > >  	if (unlikely(!written))
> > > -		start_fsb = XFS_B_TO_FSBT(mp, offset);
> > > +		start_byte = round_down(offset, mp->m_sb.sb_blocksize);
> > >  	else
> >  -		start_fsb = XFS_B_TO_FSB(mp, offset + written);
> > > -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> > > +		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
> > > +	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);
> > 
> > Technically this is the byte where we should *stop* processing, right?
> > 
> > If we are told to write 1000 bytes at pos 0 and the whole thing fails,
> > the end pos of the range is 1023 and we must stop at pos 1024.  Right?
> 
> Yes, the interval definition being used here is open-ended i.e.
> [start_byte, end_byte) because it makes iterative interval
> operations really easy as the value for the start of the next
> interval is the same as the value for the end of the current
> interval.

(I was never good at remembering which symbol included the number and
which one excluded it.]

> That's the way we've traditionally encoded ranges in XFS
> because there's a much lower risk of off-by-one errors in
> calculations as we iterate through extents. i.e. finding the
> start and end of ranges is as simple as round_down/round_up, there's
> no magic "+ 1" or "- 1" arithmetic needed anywhere to move from one
> interval to the next, etc.

<nod> I've been slowly moving my brain towards "next_pos/block/etc",
more because 'end' is ambiguous enough in my head that my own code
confuses me. :P

(That said I often just look at the variable definition.  As long as the
variable defining the loop invariant doesn't change, it doesn't cause me
any recognition problems.)

> > (The only reason I ask is that Linus ranted about XFS naming these
> > variables incorrectly in the iomap code and the (at the time only) user
> > of it.)
> 
> I don't find that a convincing argument.  What some random dude that
> has never touched the XFS or iomap code thinks about how we define
> intervals or the notations we use that makes the code _easier for
> us to understand_ is just not relevant.

Wellp I woke up to this story[1] this morning.  At this point I say fmeh
and withdraw the question.

[1] https://lore.kernel.org/lkml/20221105222012.4226-1-Jason@zx2c4.com/

> > >  	/* Nothing to do if we've written the entire delalloc extent */
> > > -	if (start_fsb >= end_fsb)
> > > +	if (start_byte >= end_byte)
> > >  		return 0;
> > >  
> > >  	/*
> > > @@ -1173,15 +1186,12 @@ xfs_buffered_write_iomap_end(
> > >  	 * leave dirty pages with no space reservation in the cache.
> > >  	 */
> > >  	filemap_invalidate_lock(inode->i_mapping);
> > > -	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> > > -				 XFS_FSB_TO_B(mp, end_fsb) - 1);
> > > -
> > > -	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> > > -				       end_fsb - start_fsb);
> > > +	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> > 
> > ...because the expression "end_byte - 1" looks a little funny when it's
> > used to compute the "lend" argument to truncate_pagecache_range.
> 
> Yup, truncate_pagecache_range() uses a [] (closed) interval to
> define the range, so we need a "- 1" when passing that open-ended
> interval into a closed interval API.
> 
> But that truncate_pagecache_range() call is going away in the next
> patch, so this whole issue is moot, yes?

Oh, it does.  Heh.  Never mind then.

> > > +	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
> > >  	filemap_invalidate_unlock(inode->i_mapping);
> > >  	if (error && !xfs_is_shutdown(mp)) {
> > > -		xfs_alert(mp, "%s: unable to clean up ino %lld",
> > > -			__func__, ip->i_ino);
> > > +		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
> > > +			__func__, XFS_I(inode)->i_ino);
> > 
> > Oh, you did fix the ino 0x%llx format thing.  Previous comment
> > withdrawn.
> > 
> > With s/end_byte/next_byte/ and the delalloc punch thing sorted out,
> 
> I don't know what you want me to do here, because I don't think this
> code is wrong and changing it to closed intervals and next/stop as
> variable names makes little sense in the context of the code....

Comment withdrawn, per above.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
