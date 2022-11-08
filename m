Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6B620467
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 01:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKHABo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 19:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiKHABY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716BDE8E;
        Mon,  7 Nov 2022 16:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C6D6131A;
        Tue,  8 Nov 2022 00:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5992C433D6;
        Tue,  8 Nov 2022 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667865656;
        bh=kAUzFb+ihSsKfRTKM+oF951tYbVcMSn84lMYaRF/5FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuCuRklicnm3qJUxELy5b6ChROb+xfKLZlztbTKcU37JFKqUxkj6wpNBtvkiGGvep
         ZaVekzvx/ZvQrqIIId2y9Moi03Be9XV7Q3xpgAUZ4gMMy+2hb5Yfpro0ixKOwqcpPM
         nTTUzTGO6LRboUoUpvvO3p4Ct3QQRxcJ0YDcEcILPNV2Ov9PrQETprdyqwofg1Z70H
         R8F6b/1gfrWpCYzspdJz3YbSk3m4tK/VKc7PZ68ZQHUWIVkD2hBFxtn4Yc8vc9D6oP
         pyAmbxEBES7fbyo9SPFj3tX+SMkfRiwg3i4p3SS1V5tqrqFuWAuiU9o4G22316eCWg
         PDJuiQPCUnD7Q==
Date:   Mon, 7 Nov 2022 16:00:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y2mcOCpKiDb4nf1X@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-7-david@fromorbit.com>
 <Y2KmpcD5ioig6n/O@magnolia>
 <20221102223605.GC3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102223605.GC3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:36:05AM +1100, Dave Chinner wrote:
> On Wed, Nov 02, 2022 at 10:19:33AM -0700, Darrick J. Wong wrote:
> > On Tue, Nov 01, 2022 at 11:34:11AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Now that iomap supports a mechanism to validate cached iomaps for
> > > buffered write operations, hook it up to the XFS buffered write ops
> > > so that we can avoid data corruptions that result from stale cached
> > > iomaps. See:
> > > 
> > > https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> > > 
> > > or the ->iomap_valid() introduction commit for exact details of the
> > > corruption vector.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_bmap.c |  4 +--
> > >  fs/xfs/xfs_aops.c        |  2 +-
> > >  fs/xfs/xfs_iomap.c       | 69 ++++++++++++++++++++++++++++++----------
> > >  fs/xfs/xfs_iomap.h       |  4 +--
> > >  fs/xfs/xfs_pnfs.c        |  5 +--
> > >  5 files changed, 61 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 49d0d4ea63fc..db225130618c 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -4551,8 +4551,8 @@ xfs_bmapi_convert_delalloc(
> > >  	 * the extent.  Just return the real extent at this offset.
> > >  	 */
> > >  	if (!isnullstartblock(bma.got.br_startblock)) {
> > > -		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
> > >  		*seq = READ_ONCE(ifp->if_seq);
> > > +		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
> > >  		goto out_trans_cancel;
> > >  	}
> > >  
> > > @@ -4599,8 +4599,8 @@ xfs_bmapi_convert_delalloc(
> > >  	XFS_STATS_INC(mp, xs_xstrat_quick);
> > >  
> > >  	ASSERT(!isnullstartblock(bma.got.br_startblock));
> > > -	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
> > >  	*seq = READ_ONCE(ifp->if_seq);
> > > +	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
> > >  
> > >  	if (whichfork == XFS_COW_FORK)
> > 
> > Hmm.  @ifp here could be the cow fork, which means *seq will be from the
> > cow fork.  This I think is going to cause problems in
> > xfs_buffered_write_iomap_valid...
> 
> We can't get here from the buffered write path. This can only be
> reached by the writeback path via:
> 
> iomap_do_writepage
>   iomap_writepage_map
>     xfs_map_blocks
>       xfs_convert_blocks
>         xfs_bmapi_convert_delalloc
> 
> Hence the sequence numbers stored in iomap->private here are
> completely ignored by the writeback code. They still get stored
> in the struct xfs_writepage_ctx and checked by xfs_imap_valid(), so
> the changes here were really just making sure all the
> xfs_bmbt_to_iomap() callers stored the sequence number consistently.
> 
> > > @@ -839,24 +848,25 @@ xfs_direct_write_iomap_begin(
> > >  	xfs_iunlock(ip, lockmode);
> > >  
> > >  	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> > > -			flags, &imap);
> > > +			flags, &imap, &seq);
> > >  	if (error)
> > >  		return error;
> > >  
> > >  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
> > >  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> > > -				 iomap_flags | IOMAP_F_NEW);
> > > +				 iomap_flags | IOMAP_F_NEW, seq);
> > >  
> > >  out_found_cow:
> > > +	seq = READ_ONCE(ip->i_df.if_seq);
> > >  	xfs_iunlock(ip, lockmode);
> > >  	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> > >  	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
> > >  	if (imap.br_startblock != HOLESTARTBLOCK) {
> > > -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
> > > +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
> > >  		if (error)
> > >  			return error;
> > >  	}
> > > -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
> > > +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
> > 
> > Here we've found a mapping from the COW fork and we're encoding it into
> > the struct iomap.  Why is the sequence number from the *data* fork and
> > not the COW fork?
> 
> Because my brain isn't big enough to hold all this code straight in
> my head.  I found it all too easy to get confused by what iomap is
> passed where and how to tell them apart and I could not tell if
> there was an easy way to tell if the iomap passed to
> xfs_iomap_valid() needed to check against the data or cow fork.
> 
> Hence I set it up such that the xfs_iomap_valid() callback only
> checks the data fork sequence so the only correct thing to set in
> the iomap is the data fork sequence and moved on to the next part of
> the problem...
> 
> But, again, this information probably should be encoded into the
> sequence cookie we store. Which begs the question - if we are doing
> a COW operation, we have to check that neither the data fork (the
> srcmap) nor the COW fork (the iter->iomap) have changed, right? This
> is what the writeback code does (i.e. checks both data and COW fork
> sequence numbers), so perhaps that's also what we should be doing
> here?
> 
> i.e. either the cookie for COW operations needs to contain both
> data+cow sequence numbers, and both need to match to proceed, or we
> have to validate both the srcmap and the iter->iomap with separate
> callouts once the folio is locked.
> 
> Thoughts?

As we sorta discussed last week on IRC, I guess you could start by
encoding both values (as needed) in something fugly like this in struct
iomap:

union {
	void *private;
	u64 cookie;
};

But the longer term solution is (I suspect) to make a new struct that
XFS can envelop:

struct iomap_pagecache_ctx {
	struct iomap_iter	iter;	/* do not touch */
	struct iomap_page_ops	*ops;	/* callers can attach here */
};

struct xfs_pagecache_ctx {
	struct iomap_pagecache_ctx	xpctx;
	u32		data_seq;
	u32		cow_seq;
};

and pass that into the iomap functions:

	struct xfs_pagecache_ctx	ctx = { };

	ret = iomap_file_buffered_write(iocb, from, &ctx,
			&xfs_buffered_write_iomap_ops);

so that xfs_iomap_revalidate can do the usual struct unwrapping:

	struct xfs_pagecache_ctx	*xpctx;

	xpctx = container_of(ipctx, struct xfs_pagecache_ctx, ipctx);
	if (xpctx->data_seq != ip->i_df.df_seq)
		return NOPE;

But that's a pretty aggressive refactoring, not suitable for a bugfix,
do it afterwards while you're waiting for the rest of us to check over
part 1, etc.

--D

> > > @@ -1328,9 +1342,26 @@ xfs_buffered_write_iomap_end(
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
> > 
> > Why is it ok to sample the data fork's sequence number even if the
> > mapping came from the COW fork?  That doesn't make sense to me,
> > conceptually.  I definitely think it's buggy that the revalidation
> > might not sample from the same sequence counter as the original
> > measurement.
> 
> Yup, see above.
> 
> > >  const struct iomap_ops xfs_read_iomap_ops = {
> > > @@ -1438,7 +1471,7 @@ xfs_seek_iomap_begin(
> > >  			end_fsb = min(end_fsb, data_fsb);
> > >  		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
> > >  		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> > > -					  IOMAP_F_SHARED);
> > > +				IOMAP_F_SHARED, READ_ONCE(ip->i_cowfp->if_seq));
> > 
> > Here we explicitly sample from the cow fork but the comparison is done
> > against the data fork.  That /probably/ doesn't matter for reads since
> > you're not proposing that we revalidate on those.  Should we?
> 
> As I said elsewhere, I haven't even looked at the read path. The
> iomap code is now complex enough that I have trouble following it
> and keeping all the corner cases in my head. This is the down side
> of having people smarter than you write the code you need to debug
> when shit inevitably goes wrong.
> 
> > What
> > happens if userspace hands us a large read() from an unwritten extent
> > and the same dirty/writeback/reclaim sequence happens to the last folio
> > in that read() range before read_iter actually gets there?
> 
> No idea - shit may well go wrong there in the same way, but I've had
> my hands full just fixing the write path. I'm *really* tired of
> fighting with the iomap code right now...
> 
> > > @@ -189,7 +190,7 @@ xfs_fs_map_blocks(
> > >  		xfs_iunlock(ip, lock_flags);
> > >  
> > >  		error = xfs_iomap_write_direct(ip, offset_fsb,
> > > -				end_fsb - offset_fsb, 0, &imap);
> > > +				end_fsb - offset_fsb, 0, &imap, &seq);
> > 
> > I got a compiler warning about seq not being set in the case where we
> > don't call xfs_iomap_write_direct.
> 
> Yup, gcc 11.2 doesn't warn about it. Now to find out why my build
> system is using gcc 11.2 when I upgraded it months ago to use
> gcc-12 because of exactly these sorts of issues.... :(

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
