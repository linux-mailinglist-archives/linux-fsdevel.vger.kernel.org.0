Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62CF62E39D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiKQR5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKQR5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:57:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6E30549;
        Thu, 17 Nov 2022 09:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD44F621E5;
        Thu, 17 Nov 2022 17:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093ECC433C1;
        Thu, 17 Nov 2022 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668707834;
        bh=f49iYpv1ZrS4T1zQ1J1GUCBCHEyO8t+xn09daOT+Fu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9279QwAviSsaj+2XDBV/dWJFjJgH1yZsa5BgscxWatN9A/GnNB/HS3gLCku7RG7E
         yaed9p6DyFEsAC4rP7JKf1lpaEwQdTGfK4ybG4p1bgW5v7U90DHDoRzi6zwIlpX6Q/
         pYlVDNW41Ql4IZLSh9nx8neSFnGmknv/ONz7mpAOw3IQnEotZB3OlQlFkdE1ARfy1y
         zAKefmePF6SXig8EaUCWddheFkLg5Hjf11o+D19fujkQwBvEq4b3qrefgRkE8McdGx
         UARhhZ6HndXEMhgy5NUwq6FCk4CbM5juz6PFfDWafJeFuzhBHwfHlaVrcAHYqcXIP/
         DebW+eMcrFDxg==
Date:   Thu, 17 Nov 2022 09:57:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] xfs,iomap: move delalloc punching to iomap
Message-ID: <Y3Z1+aDVRZFwDUvL@magnolia>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117055810.498014-5-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:58:05PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because that's what Christoph wants for this error handling path
> only XFS uses.
> 
> It requires a new iomap export for handling errors over delalloc
> ranges. This is basically the XFS code as is stands, but even though
> Christoph wants this as iomap funcitonality, we still have
> to call it from the filesystem specific ->iomap_end callback, and
> call into the iomap code with yet another filesystem specific
> callback to punch the delalloc extent within the defined ranges.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 60 ++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iomap.c     | 47 ++++++---------------------------
>  include/linux/iomap.h  |  6 +++++
>  3 files changed, 74 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 91ee0b308e13..77f391fd90ca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -832,6 +832,66 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> +/*
> + * When a short write occurs, the filesystem may need to remove reserved space
> + * that was allocated in ->iomap_begin from it's ->iomap_end method. For
> + * filesystems that use delayed allocation, we need to punch out delalloc
> + * extents from the range that are not dirty in the page cache. As the write can
> + * race with page faults, there can be dirty pages over the delalloc extent
> + * outside the range of a short write but still within the delalloc extent
> + * allocated for this iomap.
> + *
> + * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
> + * simplify range iterations, but converts them back to {offset,len} tuples for
> + * the punch callback.
> + */
> +int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> +		struct iomap *iomap, loff_t offset, loff_t length,

Nit: loff_t pos, not 'offset', to (try to) be consistent with the rest
of the codebase.

I'll fix this on commit if you don't beat me to the punch, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +		ssize_t written,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	loff_t			start_byte;
> +	loff_t			end_byte;
> +	int			blocksize = 1 << inode->i_blkbits;
> +	int			error = 0;
> +
> +	if (iomap->type != IOMAP_DELALLOC)
> +		return 0;
> +
> +	/* If we didn't reserve the blocks, we're not allowed to punch them. */
> +	if (!(iomap->flags & IOMAP_F_NEW))
> +		return 0;
> +
> +	/*
> +	 * start_byte refers to the first unused block after a short write. If
> +	 * nothing was written, round offset down to point at the first block in
> +	 * the range.
> +	 */
> +	if (unlikely(!written))
> +		start_byte = round_down(offset, blocksize);
> +	else
> +		start_byte = round_up(offset + written, blocksize);
> +	end_byte = round_up(offset + length, blocksize);
> +
> +	/* Nothing to do if we've written the entire delalloc extent */
> +	if (start_byte >= end_byte)
> +		return 0;
> +
> +	/*
> +	 * Lock the mapping to avoid races with page faults re-instantiating
> +	 * folios and dirtying them via ->page_mkwrite between the page cache
> +	 * truncation and the delalloc extent removal. Failing to do this can
> +	 * leave dirty pages with no space reservation in the cache.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> +	error = punch(inode, start_byte, end_byte - start_byte);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
> +
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7bb55dbc19d3..ea96e8a34868 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1123,12 +1123,12 @@ xfs_buffered_write_iomap_begin(
>  static int
>  xfs_buffered_write_delalloc_punch(
>  	struct inode		*inode,
> -	loff_t			start_byte,
> -	loff_t			end_byte)
> +	loff_t			offset,
> +	loff_t			length)
>  {
>  	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
> -	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + length);
>  
>  	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
>  				end_fsb - start_fsb);
> @@ -1143,13 +1143,9 @@ xfs_buffered_write_iomap_end(
>  	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> -	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> -	loff_t			start_byte;
> -	loff_t			end_byte;
> -	int			error = 0;
>  
> -	if (iomap->type != IOMAP_DELALLOC)
> -		return 0;
> +	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> +	int			error;
>  
>  	/*
>  	 * Behave as if the write failed if drop writes is enabled. Set the NEW
> @@ -1160,35 +1156,8 @@ xfs_buffered_write_iomap_end(
>  		written = 0;
>  	}
>  
> -	/* If we didn't reserve the blocks, we're not allowed to punch them. */
> -	if (!(iomap->flags & IOMAP_F_NEW))
> -		return 0;
> -
> -	/*
> -	 * start_fsb refers to the first unused block after a short write. If
> -	 * nothing was written, round offset down to point at the first block in
> -	 * the range.
> -	 */
> -	if (unlikely(!written))
> -		start_byte = round_down(offset, mp->m_sb.sb_blocksize);
> -	else
> -		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
> -	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);
> -
> -	/* Nothing to do if we've written the entire delalloc extent */
> -	if (start_byte >= end_byte)
> -		return 0;
> -
> -	/*
> -	 * Lock the mapping to avoid races with page faults re-instantiating
> -	 * folios and dirtying them via ->page_mkwrite between the page cache
> -	 * truncation and the delalloc extent removal. Failing to do this can
> -	 * leave dirty pages with no space reservation in the cache.
> -	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> -	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> -	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	error = iomap_file_buffered_write_punch_delalloc(inode, iomap, offset,
> +			length, written, &xfs_buffered_write_delalloc_punch);
>  	if (error && !xfs_is_shutdown(mp)) {
>  		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
>  			__func__, XFS_I(inode)->i_ino);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17..6bbed915c83a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -226,6 +226,12 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
>  
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
> +int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> +		struct iomap *iomap, loff_t offset, loff_t length,
> +		ssize_t written,
> +		int (*punch)(struct inode *inode,
> +				loff_t offset, loff_t length));
> +
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
> -- 
> 2.37.2
> 
