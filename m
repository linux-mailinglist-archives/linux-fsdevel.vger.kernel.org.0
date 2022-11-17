Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4262E466
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiKQSiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 13:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiKQSiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:38:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC286A52;
        Thu, 17 Nov 2022 10:37:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 717EAB82177;
        Thu, 17 Nov 2022 18:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD0BC433C1;
        Thu, 17 Nov 2022 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668710275;
        bh=DhuVqfGH+62X2Pke5/r1cTyORft8bLD/7dMH7Qu+wCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSExGzqjdO1ef6lPgCqNxCS72FPm+V+EF/zCcZiTkbrmjVff4zrwaRsDwXeidrd1C
         gOy6x2ub4uk289ZRC/QXod5MdvCwyyMRrdNsIxX2CcyYuAVloxkh17O2zuBZ+qYvoo
         1cXaHjWstjEgtNXDA9NoppRmurlKCS+6KTqNwvInBxyWD/5HhJ3NpJVOv2JI+cyyeZ
         U3iUIOjd/kvH9R4i8ISykkDZ/gVgE2HAXyS1XhLV/fAOpEudlOeQpskFyxO1M9SQRG
         NCVKFtOigwri9sxnCG1b5xVZeqfwfo2dmYj1yAZBpekwhHVF3Ez5Xq8F6JhBDD4UqR
         Pn/wesxaftrsA==
Date:   Thu, 17 Nov 2022 10:37:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a
 byte range
Message-ID: <Y3Z/gqw9BvAe5kjt@magnolia>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117055810.498014-7-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:58:07PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> All the callers of xfs_bmap_punch_delalloc_range() jump through
> hoops to convert a byte range to filesystem blocks before calling
> xfs_bmap_punch_delalloc_range(). Instead, pass the byte range to
> xfs_bmap_punch_delalloc_range() and have it do the conversion to
> filesystem blocks internally.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c      | 16 ++++++----------
>  fs/xfs/xfs_bmap_util.c | 10 ++++++----
>  fs/xfs/xfs_bmap_util.h |  2 +-
>  fs/xfs/xfs_iomap.c     |  8 ++------
>  4 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 5d1a995b15f8..6aadc5815068 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -114,9 +114,8 @@ xfs_end_ioend(
>  	if (unlikely(error)) {
>  		if (ioend->io_flags & IOMAP_F_SHARED) {
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
> -			xfs_bmap_punch_delalloc_range(ip,
> -						      XFS_B_TO_FSBT(mp, offset),
> -						      XFS_B_TO_FSB(mp, size));
> +			xfs_bmap_punch_delalloc_range(ip, offset,
> +					offset + size);
>  		}
>  		goto done;
>  	}
> @@ -455,12 +454,8 @@ xfs_discard_folio(
>  	struct folio		*folio,
>  	loff_t			pos)
>  {
> -	struct inode		*inode = folio->mapping->host;
> -	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	size_t			offset = offset_in_folio(folio, pos);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, pos);
> -	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, offset);
>  	int			error;
>  
>  	if (xfs_is_shutdown(mp))
> @@ -470,8 +465,9 @@ xfs_discard_folio(
>  		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
>  			folio, ip->i_ino, pos);
>  
> -	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			i_blocks_per_folio(inode, folio) - pageoff_fsb);
> +	error = xfs_bmap_punch_delalloc_range(ip, pos,
> +			round_up(pos, folio_size(folio)));
> +
>  	if (error && !xfs_is_shutdown(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  }
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 04d0c2bff67c..867645b74d88 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -590,11 +590,13 @@ xfs_getbmap(
>  int
>  xfs_bmap_punch_delalloc_range(
>  	struct xfs_inode	*ip,
> -	xfs_fileoff_t		start_fsb,
> -	xfs_fileoff_t		length)
> +	xfs_off_t		start_byte,
> +	xfs_off_t		end_byte)
>  {
> +	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_ifork	*ifp = &ip->i_df;
> -	xfs_fileoff_t		end_fsb = start_fsb + length;
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
>  	struct xfs_bmbt_irec	got, del;
>  	struct xfs_iext_cursor	icur;
>  	int			error = 0;
> @@ -607,7 +609,7 @@ xfs_bmap_punch_delalloc_range(
>  
>  	while (got.br_startoff + got.br_blockcount > start_fsb) {
>  		del = got;
> -		xfs_trim_extent(&del, start_fsb, length);
> +		xfs_trim_extent(&del, start_fsb, end_fsb - start_fsb);
>  
>  		/*
>  		 * A delete can push the cursor forward. Step back to the
> diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
> index 24b37d211f1d..6888078f5c31 100644
> --- a/fs/xfs/xfs_bmap_util.h
> +++ b/fs/xfs/xfs_bmap_util.h
> @@ -31,7 +31,7 @@ xfs_bmap_rtalloc(struct xfs_bmalloca *ap)
>  #endif /* CONFIG_XFS_RT */
>  
>  int	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip,
> -		xfs_fileoff_t start_fsb, xfs_fileoff_t length);
> +		xfs_off_t start_byte, xfs_off_t end_byte);
>  
>  struct kgetbmap {
>  	__s64		bmv_offset;	/* file offset of segment in blocks */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ea96e8a34868..09676ff6940e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1126,12 +1126,8 @@ xfs_buffered_write_delalloc_punch(
>  	loff_t			offset,
>  	loff_t			length)
>  {
> -	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + length);
> -
> -	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
> -				end_fsb - start_fsb);
> +	return xfs_bmap_punch_delalloc_range(XFS_I(inode), offset,
> +			offset + length);
>  }
>  
>  static int
> -- 
> 2.37.2
> 
