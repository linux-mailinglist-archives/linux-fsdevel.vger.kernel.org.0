Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93681619009
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 06:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKDFkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 01:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKDFkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:40:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06FB275CD
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 22:40:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p21so3950508plr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDTqexugXbU5kJXsOAAPQQpjmY8bDQkWRH+Y4a69nu4=;
        b=TQmlUuFnbTvVYovML524XqO7siz67eHOMV3uwdL7cdCZBTi/n8jt/jjwjWR3rOet4D
         j4Oe1yfKaVwd4hsIloCyfyRhPRPdlmSFAF6ppGXeFXz1i20Iqoxqbg20asJAWVyQspm2
         DqBt+YhoySKN6BDDEaNXozIMdVCrHf5axShG0EYh5RMBYKh0BoGrsnS/siha1kU7O9cA
         yIF7GC61c3A6hljY9KFN0TnqG931OmCyuorM+CFJlmsrdt9wU/em0tlTTAvi1asyh07/
         Hwnkn5n2IszBOtfe1KZekY45hkFwZ10qpNuGWaB1HKjOhtLKEUfQjb/dBYmvYgQJJMa6
         7laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDTqexugXbU5kJXsOAAPQQpjmY8bDQkWRH+Y4a69nu4=;
        b=ZuIO7N5icyhXQlZIJHvM2HEzbV6p0eQ/yKUz/pGvs6LiZQ0bBuvc4gMawG6oMwvDFg
         BP4GiU6+24Nm18ZpMTTx1dh6lPooO6GSoJylwqprGDrHjCOUgaLFGcm7mRLLTjSAuaXn
         mM58gJ3ojbfbpaz1KpDKcz9P+nLwqhsSDElOxCYxNKgQ1N6YD3coG/MebwSWpBILqsMz
         1BTcziG2m1EtpXnUymNuxfyZaCyTaSPkz2crxKQJ9jvW0805l8XE5W2oEdLcFttDUbQo
         /lcWwnU96PUF957RcwS0rcIr6VTRGE4moMOxIkebXOauLRab0W5zZWsBD29r7iLQimOO
         bmKQ==
X-Gm-Message-State: ACrzQf2lqs9I7V1bSMiVo0cUZ6l88bPBiNaOUeEKBAoyWn+xExyCUmO3
        NRcTCQC9J4llvu95SQLKzz+A8IUYG9FxQA==
X-Google-Smtp-Source: AMsMyM7RBYKI1F8noaszSFisFTJP1lvGQNrviR990dq5W1M38RDhyNLga4WSl3E8H3DtUOW5WyzU0g==
X-Received: by 2002:a17:902:f551:b0:186:be04:6670 with SMTP id h17-20020a170902f55100b00186be046670mr33328109plf.159.1667540420270;
        Thu, 03 Nov 2022 22:40:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00176acd80f69sm1677922plg.102.2022.11.03.22.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:40:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqpR9-00A3by-Mp; Fri, 04 Nov 2022 16:40:15 +1100
Date:   Fri, 4 Nov 2022 16:40:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] xfs: use byte ranges for write cleanup ranges
Message-ID: <20221104054015.GL3600936@dread.disaster.area>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-4-david@fromorbit.com>
 <Y2KbtTf224DNsyEA@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KbtTf224DNsyEA@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:32:53AM -0700, Darrick J. Wong wrote:
> On Tue, Nov 01, 2022 at 11:34:08AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > xfs_buffered_write_iomap_end() currently converts the byte ranges
> > passed to it to filesystem blocks to pass them to the bmap code to
> > punch out delalloc blocks, but then has to convert filesytem
> > blocks back to byte ranges for page cache truncate.
> > 
> > We're about to make the page cache truncate go away and replace it
> > with a page cache walk, so having to convert everything to/from/to
> > filesystem blocks is messy and error-prone. It is much easier to
> > pass around byte ranges and convert to page indexes and/or
> > filesystem blocks only where those units are needed.
> > 
> > In preparation for the page cache walk being added, add a helper
> > that converts byte ranges to filesystem blocks and calls
> > xfs_bmap_punch_delalloc_range() and convert
> > xfs_buffered_write_iomap_end() to calculate limits in byte ranges.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_iomap.c | 40 +++++++++++++++++++++++++---------------
> >  1 file changed, 25 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index a2e45ea1b0cb..7bb55dbc19d3 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1120,6 +1120,20 @@ xfs_buffered_write_iomap_begin(
> >  	return error;
> >  }
> >  
> > +static int
> > +xfs_buffered_write_delalloc_punch(
> > +	struct inode		*inode,
> > +	loff_t			start_byte,
> > +	loff_t			end_byte)
> > +{
> > +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> > +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> > +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
> > +
> > +	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
> > +				end_fsb - start_fsb);
> > +}
> 
> /me echoes hch's comment that the other callers of
> xfs_bmap_punch_delalloc_range do this byte->block conversion too.
> 
> > +
> >  static int
> >  xfs_buffered_write_iomap_end(
> >  	struct inode		*inode,
> > @@ -1129,10 +1143,9 @@ xfs_buffered_write_iomap_end(
> >  	unsigned		flags,
> >  	struct iomap		*iomap)
> >  {
> > -	struct xfs_inode	*ip = XFS_I(inode);
> > -	struct xfs_mount	*mp = ip->i_mount;
> > -	xfs_fileoff_t		start_fsb;
> > -	xfs_fileoff_t		end_fsb;
> > +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> > +	loff_t			start_byte;
> > +	loff_t			end_byte;
> >  	int			error = 0;
> >  
> >  	if (iomap->type != IOMAP_DELALLOC)
> > @@ -1157,13 +1170,13 @@ xfs_buffered_write_iomap_end(
> >  	 * the range.
> >  	 */
> >  	if (unlikely(!written))
> > -		start_fsb = XFS_B_TO_FSBT(mp, offset);
> > +		start_byte = round_down(offset, mp->m_sb.sb_blocksize);
> >  	else
>  -		start_fsb = XFS_B_TO_FSB(mp, offset + written);
> > -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> > +		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
> > +	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);
> 
> Technically this is the byte where we should *stop* processing, right?
> 
> If we are told to write 1000 bytes at pos 0 and the whole thing fails,
> the end pos of the range is 1023 and we must stop at pos 1024.  Right?

Yes, the interval definition being used here is open-ended i.e.
[start_byte, end_byte) because it makes iterative interval
operations really easy as the value for the start of the next
interval is the same as the value for the end of the current
interval.

That's the way we've traditionally encoded ranges in XFS
because there's a much lower risk of off-by-one errors in
calculations as we iterate through extents. i.e. finding the
start and end of ranges is as simple as round_down/round_up, there's
no magic "+ 1" or "- 1" arithmetic needed anywhere to move from one
interval to the next, etc.

> (The only reason I ask is that Linus ranted about XFS naming these
> variables incorrectly in the iomap code and the (at the time only) user
> of it.)

I don't find that a convincing argument.  What some random dude that
has never touched the XFS or iomap code thinks about how we define
intervals or the notations we use that makes the code _easier for
us to understand_ is just not relevant.

> >  	/* Nothing to do if we've written the entire delalloc extent */
> > -	if (start_fsb >= end_fsb)
> > +	if (start_byte >= end_byte)
> >  		return 0;
> >  
> >  	/*
> > @@ -1173,15 +1186,12 @@ xfs_buffered_write_iomap_end(
> >  	 * leave dirty pages with no space reservation in the cache.
> >  	 */
> >  	filemap_invalidate_lock(inode->i_mapping);
> > -	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> > -				 XFS_FSB_TO_B(mp, end_fsb) - 1);
> > -
> > -	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> > -				       end_fsb - start_fsb);
> > +	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> 
> ...because the expression "end_byte - 1" looks a little funny when it's
> used to compute the "lend" argument to truncate_pagecache_range.

Yup, truncate_pagecache_range() uses a [] (closed) interval to
define the range, so we need a "- 1" when passing that open-ended
interval into a closed interval API.

But that truncate_pagecache_range() call is going away in the next
patch, so this whole issue is moot, yes?

> > +	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
> >  	filemap_invalidate_unlock(inode->i_mapping);
> >  	if (error && !xfs_is_shutdown(mp)) {
> > -		xfs_alert(mp, "%s: unable to clean up ino %lld",
> > -			__func__, ip->i_ino);
> > +		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
> > +			__func__, XFS_I(inode)->i_ino);
> 
> Oh, you did fix the ino 0x%llx format thing.  Previous comment
> withdrawn.
> 
> With s/end_byte/next_byte/ and the delalloc punch thing sorted out,

I don't know what you want me to do here, because I don't think this
code is wrong and changing it to closed intervals and next/stop as
variable names makes little sense in the context of the code....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
