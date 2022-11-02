Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD96A61694A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiKBQin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKBQiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:38:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C8F31ED9;
        Wed,  2 Nov 2022 09:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3155CB80DA8;
        Wed,  2 Nov 2022 16:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0558C433D6;
        Wed,  2 Nov 2022 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667406773;
        bh=Xq8FcJj3Psrsb8ssBV4fkBxbUO2PtkTuaK/Eok9H2xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV7eWlxn0FltdMlhSD11ANoUOXAYmZanny/LTAN0fR5vFkM6pfJ9nxWHEALnjNn0l
         zN/EoaSQXGbXgG0wOKIa8BiGewNcQmtO17gqpWoE/xRC3KajP9ov1iogbEkYd0oxjR
         rGTDvADp4oMO9/OrKIPdMwJ7Lznwu5PL2vtagLe+gFS7ky60N4wDecpLtbX48pffZa
         l1hIuDyvsnfMYWw0o0xi9b+v/4zFdOO9FUNHxKUub+kCPYIYxhnPU2gk0TmYVBt1h4
         FTeSEYJ34rt2YYwFRQtd1BWjs7Icvd/wmLyNzMc8bwq5pld+f0xwNtwVF5MMWVYGTF
         CttRWLCB2g6dA==
Date:   Wed, 2 Nov 2022 09:32:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] xfs: use byte ranges for write cleanup ranges
Message-ID: <Y2KbtTf224DNsyEA@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-4-david@fromorbit.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:34:08AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs_buffered_write_iomap_end() currently converts the byte ranges
> passed to it to filesystem blocks to pass them to the bmap code to
> punch out delalloc blocks, but then has to convert filesytem
> blocks back to byte ranges for page cache truncate.
> 
> We're about to make the page cache truncate go away and replace it
> with a page cache walk, so having to convert everything to/from/to
> filesystem blocks is messy and error-prone. It is much easier to
> pass around byte ranges and convert to page indexes and/or
> filesystem blocks only where those units are needed.
> 
> In preparation for the page cache walk being added, add a helper
> that converts byte ranges to filesystem blocks and calls
> xfs_bmap_punch_delalloc_range() and convert
> xfs_buffered_write_iomap_end() to calculate limits in byte ranges.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index a2e45ea1b0cb..7bb55dbc19d3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1120,6 +1120,20 @@ xfs_buffered_write_iomap_begin(
>  	return error;
>  }
>  
> +static int
> +xfs_buffered_write_delalloc_punch(
> +	struct inode		*inode,
> +	loff_t			start_byte,
> +	loff_t			end_byte)
> +{
> +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
> +
> +	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
> +				end_fsb - start_fsb);
> +}

/me echoes hch's comment that the other callers of
xfs_bmap_punch_delalloc_range do this byte->block conversion too.

> +
>  static int
>  xfs_buffered_write_iomap_end(
>  	struct inode		*inode,
> @@ -1129,10 +1143,9 @@ xfs_buffered_write_iomap_end(
>  	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> -	struct xfs_mount	*mp = ip->i_mount;
> -	xfs_fileoff_t		start_fsb;
> -	xfs_fileoff_t		end_fsb;
> +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> +	loff_t			start_byte;
> +	loff_t			end_byte;
>  	int			error = 0;
>  
>  	if (iomap->type != IOMAP_DELALLOC)
> @@ -1157,13 +1170,13 @@ xfs_buffered_write_iomap_end(
>  	 * the range.
>  	 */
>  	if (unlikely(!written))
> -		start_fsb = XFS_B_TO_FSBT(mp, offset);
> +		start_byte = round_down(offset, mp->m_sb.sb_blocksize);
>  	else
 -		start_fsb = XFS_B_TO_FSB(mp, offset + written);
> -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> +		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
> +	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);

Technically this is the byte where we should *stop* processing, right?

If we are told to write 1000 bytes at pos 0 and the whole thing fails,
the end pos of the range is 1023 and we must stop at pos 1024.  Right?

(The only reason I ask is that Linus ranted about XFS naming these
variables incorrectly in the iomap code and the (at the time only) user
of it.)

"stop" itself isn't a great name either since one could say "stop after
pos 1023" so I guess that's why I've been naming these things "next_fsb"
and "next_pos"...

>  
>  	/* Nothing to do if we've written the entire delalloc extent */
> -	if (start_fsb >= end_fsb)
> +	if (start_byte >= end_byte)
>  		return 0;
>  
>  	/*
> @@ -1173,15 +1186,12 @@ xfs_buffered_write_iomap_end(
>  	 * leave dirty pages with no space reservation in the cache.
>  	 */
>  	filemap_invalidate_lock(inode->i_mapping);
> -	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> -				 XFS_FSB_TO_B(mp, end_fsb) - 1);
> -
> -	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -				       end_fsb - start_fsb);
> +	truncate_pagecache_range(inode, start_byte, end_byte - 1);

...because the expression "end_byte - 1" looks a little funny when it's
used to compute the "lend" argument to truncate_pagecache_range.

> +	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
>  	filemap_invalidate_unlock(inode->i_mapping);
>  	if (error && !xfs_is_shutdown(mp)) {
> -		xfs_alert(mp, "%s: unable to clean up ino %lld",
> -			__func__, ip->i_ino);
> +		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
> +			__func__, XFS_I(inode)->i_ino);

Oh, you did fix the ino 0x%llx format thing.  Previous comment
withdrawn.

With s/end_byte/next_byte/ and the delalloc punch thing sorted out,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  		return error;
>  	}
>  	return 0;
> -- 
> 2.37.2
> 
