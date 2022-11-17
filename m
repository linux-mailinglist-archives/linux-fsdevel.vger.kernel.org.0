Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4262E41F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 19:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiKQS2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 13:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiKQS2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:28:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710DF8223B;
        Thu, 17 Nov 2022 10:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 315D3B8218C;
        Thu, 17 Nov 2022 18:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1407C433C1;
        Thu, 17 Nov 2022 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668709700;
        bh=3r2Y3fuelDwewhDTO7+KzvS1wKqQ6ClHM0aInZ2FkA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJvIeKQ1fCpR14kiT4541ATleAtuG/X9pdkp+glLFsNRo4KMisbRP+YyuYAxzpt3A
         Y0EpgFFLAZRKNBDLNzvU1Rn+0xOYGDN3Lt7QmbFeHX1TbZ/v7sgaQl0P81XEsl1S/9
         FQCxBfuuNjiE3ZllrZJJl96SfwhLh5k+KJSRBvaXnK6I+kmy2o1iRQGPX/K5RBo4To
         6xr8KriY8UI7MC4R0+1fISOuGyyjQ+dF2NYAxSwwyKcOIibsu+i8RfHku2wdJuKtQq
         QGgtUBN4ZSa/L6fL/6G7gFz3HuWnBavAimZBekjgMg29qA8HZ6JQnBvLJWGRJ39phE
         tjxkGGSdnPOUw==
Date:   Thu, 17 Nov 2022 10:28:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/9] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y3Z9RGPvu04qwm9E@magnolia>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-6-david@fromorbit.com>
 <Y3TsPzd0XzXXIzQv@bfoster>
 <20221117004133.GD3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117004133.GD3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:41:33AM +1100, Dave Chinner wrote:
> On Wed, Nov 16, 2022 at 08:57:19AM -0500, Brian Foster wrote:
> > On Tue, Nov 15, 2022 at 12:30:39PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > ...
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 151 ++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 141 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index 7bb55dbc19d3..2d48fcc7bd6f 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1134,6 +1134,146 @@ xfs_buffered_write_delalloc_punch(
> > >  				end_fsb - start_fsb);
> > >  }
> > >  
> > ...
> > > +/*
> > > + * Punch out all the delalloc blocks in the range given except for those that
> > > + * have dirty data still pending in the page cache - those are going to be
> > > + * written and so must still retain the delalloc backing for writeback.
> > > + *
> > > + * As we are scanning the page cache for data, we don't need to reimplement the
> > > + * wheel - mapping_seek_hole_data() does exactly what we need to identify the
> > > + * start and end of data ranges correctly even for sub-folio block sizes. This
> > > + * byte range based iteration is especially convenient because it means we don't
> > > + * have to care about variable size folios, nor where the start or end of the
> > > + * data range lies within a folio, if they lie within the same folio or even if
> > > + * there are multiple discontiguous data ranges within the folio.
> > > + */
> > > +static int
> > > +xfs_buffered_write_delalloc_release(
> > > +	struct inode		*inode,
> > > +	loff_t			start_byte,
> > > +	loff_t			end_byte)
> > > +{
> > > +	loff_t			punch_start_byte = start_byte;
> > > +	int			error = 0;
> > > +
> > > +	/*
> > > +	 * Lock the mapping to avoid races with page faults re-instantiating
> > > +	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> > > +	 * cache and perform delalloc extent removal. Failing to do this can
> > > +	 * leave dirty pages with no space reservation in the cache.
> > > +	 */
> > > +	filemap_invalidate_lock(inode->i_mapping);
> > > +	while (start_byte < end_byte) {
> > > +		loff_t		data_end;
> > > +
> > > +		start_byte = mapping_seek_hole_data(inode->i_mapping,
> > > +				start_byte, end_byte, SEEK_DATA);
> > 
> > FWIW, the fact that mapping seek data is based on uptodate status means
> > that seek behavior can change based on prior reads.
> 
> Yup. It should be obvious that any page cache scan based algorithm
> will change based on changing page cache residency.
> 
> > For example, see how
> > seek hole/data presents reads of unwritten ranges as data [1]. The same
> > thing isn't observable for holes because iomap doesn't check the mapping
> > in that case, but underlying iop state is the same and that is what this
> > code is looking at.
> 
> Well, yes.  That's the fundamental, underlying issue that this
> patchset is addressing for the write() operation: that the page
> cache contents and the underlying filesystem extent map are not
> guaranteed to be coherent and can be changed independently of each
> other.
> 
> The whole problem with looking exclusively at filesystem level
> extent state (and hence FIEMAP) is that the extent state doesn't
> tell us whether the is uncommitted data over the range of the extent
> in the page cache.  The filesystem extent state and page cache data
> *can't be coherent* in a writeback caching environment. This is the
> fundamental difference between what the filesystem extent map tells
> us (FIEMAP) and what querying the page cache tells us
> (SEEK_DATA/SEEK_HOLE).
> 
> This is also the underlying problem with iomap_truncate_page() - it
> fails to query the page cache for data over unwritten extents, so
> fails to zero the post-EOF part of dirty folios over unwritten
> extents and so it all goes wrong...
> 
> > The filtering being done here means we essentially only care about dirty
> > pages backed by delalloc blocks. That means if you get here with a dirty
> > page and the portion of the page affected by this failed write is
> > uptodate, this won't punch an underlying delalloc block even though
> > nothing else may have written to it in the meantime.
> 
> Hmmm. IOMAP_F_NEW implies that the newly allocated delalloc iomap
> will not span ranges that have pre-existing *dirty* data in the
> page cache. Those *must* already have (del)allocated extents, hence
> the iomap for the newly allocated delalloc extent will always end
> before pre-existing dirty data in the page cache starts.
> 
> Hence the seek scan range over an IOMAP_F_NEW IOMAP_DELALLOC map
> precludes stepping into ranges that have pre-existing cached dirty
> data.
> 
> We also can't get a racing write() to the same range right now
> because this is all under IOLOCK_EXCL, hence we only ever see dirty
> folios as a result of race with page faults. page faults zero the
> entire folio they insert into the page cache and
> iomap_folio_mkwrite_iter() asserts that the entire folio is marked
> up to date. Hence if we find a dirty folio outside the range the
> write() dirtied, we are guaranteed that the entire dirty folio is up
> to date....
> 
> Yes, there can be pre-existing *clean* folios (and clean partially
> up to date folios) in the page cache, but we won't have dirty
> partially up to date pages in the middle of the range we are
> scanning. Hence we only need to care about the edge cases (folios
> that overlap start and ends). We skip the partially written start
> block, and we always punch up to the end block if it is different
> from the last block we punched up to. If the end of the data spans
> into a dirty folio, we know that dirty range is up to date because
> the seek scan only returns ranges that are up to date. Hence we
> don't punch those partial blocks out....
> 
> Regardless, let's assume we have a racing write that has partially
> updated and dirtied a folio (because we've moved to
> XFS_IOLOCK_SHARED locking for writes). This case is already handled
> by the mapping_seek_hole_data() based iteration.
> 
> That is, the mapping_seek_hole_data() loop provides us with
> *discrete ranges of up to date data* that are independent of folio
> size, up-to-date range granularity, dirty range tracking, filesystem
> block size, etc.
> 
> Hence if the next discrete range we discover is in the same dirty
> folio as the previous discrete range of up to date data, we know we
> have a sub-folio sized hole in the data that is not up to date.
> Because there is no data over this range, we have to punch out the
> underlying delalloc extent over that range. 
> 
> IOWs, the dirty state of the folio and/or the granularity of the
> dirty range tracking is irrelevant here - we know there was no data
> in the cache (dlean or dirty) over this range because it is
> discontiguous with the previous range of data returned.
> 
> IOWs, if we have this "up to date" map on a dirty folio like this:
> 
> Data		+-------+UUUUUUU+-------+UUUUUUU+-------+
> Extent map	+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> 
> Then the unrolled iteration and punching we do would look like this:
> 
> First iteration of the range:
> 
> punch_start:
> 		V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> 
> SEEK_DATA:		V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_HOLE:			^
> Data range:		+UUUUUUU+
> Punch range:	+-------+
> Extent map:	+-------+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> 
> Second iteration:
> 
> punch_start			V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_DATA:				V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_HOLE:					^
> Data range:				+UUUUUUU+
> Punch range:			+-------+
> Extent map:	+-------+DDDDDDD+-------+DDDDDDD+DDDDDDD+
> 
> Third iteration:
> 
> punch_start					V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_DATA: - moves into next folio in cache
> ....
> Punch range:					+-------+ ......
> Extent map:	+-------+DDDDDDD+-------+DDDDDDD+-------+ ......
> 			(to end of scan range or start of next data)
> 
> As you can see, this scan does not care about folio size, sub-folio
> range granularity or filesystem block sizes.  It also matches
> exactly how writeback handles dirty, partially up to date folios, so
> there's no stray delalloc blocks left around to be tripped over
> after failed or short writes occur.

I had been wondering about the particular case of dealing with partially
uptodate folios, so it was really helpful to watch this all in
ASCIIVision(tm).

> Indeed, if we move to sub-folio dirty range tracking, we can simply
> add a mapping_seek_hole_data() variant that walks dirty ranges in
> the page cache rather than up to date ranges. Then we can remove the
> inner loop from this code that looks up folios to determine dirty
> state. The above algorithm does not change - we just walk from
> discrete range to discrete range punching the gaps between them....
> 
> IOWs, the algorithm is largely future proof - the only thing that
> needs to change if we change iomap to track sub-folio dirty ranges
> is how we check the data range for being dirty. That should be no
> surprise, really, the surprise should be that we can make some
> simple mods to page cache seek to remove the need for checking dirty
> state in this code altogether....
> 
> > That sort of state
> > can be created by a prior read of the range on a sub-page block size fs,
> > or perhaps a racing async readahead (via read fault of a lower
> > offset..?), etc.
> 
> Yup, generic/346 exercises this racing unaligned, sub-folio mmap
> write vs write() case. This test, specifically, was the reason I
> moved to using mapping_seek_hole_data() - g/346 found an endless
> stream of bugs in the sub-multi-page-folio range iteration code I
> kept trying to write....
> 
> > I suspect this is not a serious error because the page is dirty
> > and writeback will thus convert the block. The only exception to
> > that I can see is if the block is beyond EOF (consider a mapped
> > read to a page that straddles EOF, followed by a post-eof write
> > that fails), writeback won't actually map the block directly.
> 
> I don't think that can happen. iomap_write_failed() calls
> truncate_pagecache_range() to remove any newly instantiated cached
> data beyond the original EOF. Hence the delalloc punch will remove
> everything beyond the original EOF that was allocated for the failed
> write. Hence when we get to writeback we're not going to find any
> up-to-date data beyond the EOF block in the page cache, nor any
> stray delalloc blocks way beyond EOF....
> 
> > It may convert if contiguous with delalloc blocks inside EOF (and
> > sufficiently sized physical extents exist), or even if not, should
> > still otherwise be cleaned up by the various other means we
> > already have to manage post-eof blocks.
> >
> > So IOW there's a tradeoff being made here for possible spurious
> > allocation and I/O and a subtle dependency on writeback that
> > should probably be documented somewhere.
> 
> As per above, I don't think there is any spurious/stale allocation
> left behind by the punch code, nor is there any dependency on
> writeback to ignore it such issues.
> 
> > The larger concern is that if
> > writeback eventually changes based on dirty range tracking in a way that
> > breaks this dependency, that introduces yet another stale delalloc block
> > landmine associated with this error handling code (regardless of whether
> > you want to call that a bug in this code, seek data, whatever), and
> > those problems are difficult enough to root cause as it is.
> 
> If iomap changes how it tracks dirty ranges, this punch code only
> needs small changes to work with that correctly. There aren't any
> unknown landmines here - if we change dirty tracking, we know that
> we have to update the code that depends on the existing dirty
> tracking mechanisms to work correctly with the new infrastructure...

I hope that anyone trying to change the iomap dirty tracking code will
find it easier to do with the iteration code in buffered-io.c.  Thanks
for taking the time to rework that part for v3.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
