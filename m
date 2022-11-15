Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF062AFD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 00:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKOX5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 18:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKOX50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:57:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046C286C7;
        Tue, 15 Nov 2022 15:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F447B81B7B;
        Tue, 15 Nov 2022 23:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DBFC433D6;
        Tue, 15 Nov 2022 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556643;
        bh=jzvuAVSjXyDys9MAIYamkBlIXXr/PQ6K+kdLHC9dlK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvWQIYZdFVPoDr7eXeLXUPj/FdJFTVtsyhsQtMocMr26W9vc3ZjzacySFHU+p92/7
         wcEIpnm/l7tEhGIBGPZCDXPZzukKFX210yAV6Zz4iXP75HIVlBstvck98lkhne1Scz
         q45/RNcy0cPlq+dMYErDC7vqKs8ZSkK0FjKJC++JMlIiDd5sazODwsoXlcQwkJJjkz
         a3uFretsr0TlYt4Sb65g2mcXDTgIqXvl+VczlbQBrWWj5T3pnOEWq/JDsKfc4I8RSb
         i0uE1y4fNCEHfofKHOl1p6QfN14pK+23dUCCwzZzJRYSrsGKP+lYx5RBFzzNvng+PN
         JHoA0qBpDlcbA==
Date:   Tue, 15 Nov 2022 15:57:22 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/9] xfs: use byte ranges for write cleanup ranges
Message-ID: <Y3QnYl+gUs0MwCFw@magnolia>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-5-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:38PM +1100, Dave Chinner wrote:
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

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> -		start_fsb = XFS_B_TO_FSB(mp, offset + written);
> -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> +		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
> +	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);
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
> +	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
>  	filemap_invalidate_unlock(inode->i_mapping);
>  	if (error && !xfs_is_shutdown(mp)) {
> -		xfs_alert(mp, "%s: unable to clean up ino %lld",
> -			__func__, ip->i_ino);
> +		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
> +			__func__, XFS_I(inode)->i_ino);
>  		return error;
>  	}
>  	return 0;
> -- 
> 2.37.2
> 
