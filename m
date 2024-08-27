Return-Path: <linux-fsdevel+bounces-27410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF1961428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F113DB22971
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72F1CE6EF;
	Tue, 27 Aug 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFxQG7Pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92191803D;
	Tue, 27 Aug 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776574; cv=none; b=NfBVvuupdDmGTlILl0zEDvjs2Vv2lXUZUH2duudxJuH6PkLW/oFfpacp2qzaBorz1q+0o4reB3x3Lhd8s3tilg/FL+lth4W7JJLCOLg0pO3jLEC0tRCJEKXTAt1iNNJReVgWHN9dDCrX5V3SJaeAzZKsGTMDi8Poy0POmsODcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776574; c=relaxed/simple;
	bh=noqDWkc4SQ5aC0emJtLU7jbmMClFQPvBO7SjOhti25w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lhph4eL3wHMaW6OKfxaS9Z6AuKUYRujZDcRlFugdsrD3BRtNAsu58ZdweFzAFfu92QV/9q1OS0JPCxELpxvv4sTv3qqV+H5kglo8AU55T8AK0Wbg6ZUEZqSSU+ahtHTzBU/CeXPx0MvjAMkMZjLrtrCG1+gLH/0uDdH5LqutE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFxQG7Pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F69C4AF09;
	Tue, 27 Aug 2024 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776574;
	bh=noqDWkc4SQ5aC0emJtLU7jbmMClFQPvBO7SjOhti25w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFxQG7PmxdED/mJbywrpiHsDGOynobksIcGhzmI8kIXpb3O/0X530iGyoc1I+LGq5
	 6fZk9rVC0m6Jshn+nlXTLDrsiz1HD4ouHrRNk178MPixlhEIeeujmFaoRaKOPlw6dR
	 zplj94qXs4+Vx3zvfxfSIxF2FZ7wMvKr5KftDxNhxZC2My6CRrNhx85b0hAhBJiRRH
	 6FC/JIcbanejUjZTunSgLEsCOJQmhAM+iaV+q004O17jCZN8D0gz/ZxNt8HbQjQMLp
	 I/3u20n5PF4cgVfFeFWEXCakQUxBAwIRpOiJUwn08zZ5m9D40l6LbqlNbn3/omOXSe
	 FQ0Kvwxi5Wa9Q==
Date: Tue, 27 Aug 2024 09:36:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] iomap: remove the
 iomap_file_buffered_write_punch_delalloc return value
Message-ID: <20240827163613.GA865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-7-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:53AM +0200, Christoph Hellwig wrote:
> iomap_file_buffered_write_punch_delalloc can only return errors if either
> the ->punch callback returned an error, or if someone changed the API of
> mapping_seek_hole_data to return a negative error code that is not
> -ENXIO.
> 
> As the only instance of ->punch never returns an error, an such an error
> would be fatal anyway remove the entire error propagation and don't
> return an error code from iomap_file_buffered_write_punch_delalloc.

Not sure I like this one -- if the ->iomap_begin method returns some
weird error to iomap_seek_{data,hole}, then I think we'd at least want
to complain about that?

Though I guess we're punching delalloc mappings for a failed pagecache
write, so we've already got ourselves a juicy EIO to throw up to the
application so maybe it's fine not to bother with the error recovery
erroring out.  Right?

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 82 +++++++++++++++---------------------------
>  fs/xfs/xfs_iomap.c     | 17 ++-------
>  include/linux/iomap.h  |  4 +--
>  3 files changed, 33 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7950cbecb78c22..3d7e69a542518a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1045,7 +1045,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> -static int iomap_write_delalloc_ifs_punch(struct inode *inode,
> +static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  		struct folio *folio, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
> @@ -1053,7 +1053,6 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
>  	loff_t last_byte;
>  	u8 blkbits = inode->i_blkbits;
>  	struct iomap_folio_state *ifs;
> -	int ret = 0;
>  
>  	/*
>  	 * When we have per-block dirty tracking, there can be
> @@ -1063,47 +1062,35 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
>  	 */
>  	ifs = folio->private;
>  	if (!ifs)
> -		return ret;
> +		return;
>  
>  	last_byte = min_t(loff_t, end_byte - 1,
>  			folio_pos(folio) + folio_size(folio) - 1);
>  	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>  	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
>  	for (i = first_blk; i <= last_blk; i++) {
> -		if (!ifs_block_is_dirty(folio, ifs, i)) {
> -			ret = punch(inode, folio_pos(folio) + (i << blkbits),
> +		if (!ifs_block_is_dirty(folio, ifs, i))
> +			punch(inode, folio_pos(folio) + (i << blkbits),
>  				    1 << blkbits, iomap);
> -			if (ret)
> -				return ret;
> -		}
>  	}
> -
> -	return ret;
>  }
>  
> -
> -static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
> +static void iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
> -	int ret = 0;
> -
>  	if (!folio_test_dirty(folio))
> -		return ret;
> +		return;
>  
>  	/* if dirty, punch up to offset */
>  	if (start_byte > *punch_start_byte) {
> -		ret = punch(inode, *punch_start_byte,
> -				start_byte - *punch_start_byte, iomap);
> -		if (ret)
> -			return ret;
> +		punch(inode, *punch_start_byte, start_byte - *punch_start_byte,
> +				iomap);
>  	}
>  
>  	/* Punch non-dirty blocks within folio */
> -	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
> +	iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
>  			iomap, punch);
> -	if (ret)
> -		return ret;
>  
>  	/*
>  	 * Make sure the next punch start is correctly bound to
> @@ -1111,8 +1098,6 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  	 */
>  	*punch_start_byte = min_t(loff_t, end_byte,
>  				folio_pos(folio) + folio_size(folio));
> -
> -	return ret;
>  }
>  
>  /*
> @@ -1132,13 +1117,12 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>   * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
>   * simplify range iterations.
>   */
> -static int iomap_write_delalloc_scan(struct inode *inode,
> +static void iomap_write_delalloc_scan(struct inode *inode,
>  		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
>  	while (start_byte < end_byte) {
>  		struct folio	*folio;
> -		int ret;
>  
>  		/* grab locked page */
>  		folio = filemap_lock_folio(inode->i_mapping,
> @@ -1149,20 +1133,14 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  			continue;
>  		}
>  
> -		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
> +		iomap_write_delalloc_punch(inode, folio, punch_start_byte,
>  				start_byte, end_byte, iomap, punch);
> -		if (ret) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			return ret;
> -		}
>  
>  		/* move offset to start of next folio in range */
>  		start_byte = folio_next_index(folio) << PAGE_SHIFT;
>  		folio_unlock(folio);
>  		folio_put(folio);
>  	}
> -	return 0;
>  }
>  
>  /*
> @@ -1198,13 +1176,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>   * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
>   * the code to subtle off-by-one bugs....
>   */
> -static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> +static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		loff_t end_byte, unsigned flags, struct iomap *iomap,
>  		iomap_punch_t punch)
>  {
>  	loff_t punch_start_byte = start_byte;
>  	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
> -	int error = 0;
>  
>  	/*
>  	 * Lock the mapping to avoid races with page faults re-instantiating
> @@ -1226,13 +1203,15 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		/*
>  		 * If there is no more data to scan, all that is left is to
>  		 * punch out the remaining range.
> +		 *
> +		 * Note that mapping_seek_hole_data is only supposed to return
> +		 * either an offset or -ENXIO, so WARN on any other error as
> +		 * that would be an API change without updating the callers.
>  		 */
>  		if (start_byte == -ENXIO || start_byte == scan_end_byte)
>  			break;
> -		if (start_byte < 0) {
> -			error = start_byte;
> +		if (WARN_ON_ONCE(start_byte < 0))
>  			goto out_unlock;
> -		}
>  		WARN_ON_ONCE(start_byte < punch_start_byte);
>  		WARN_ON_ONCE(start_byte > scan_end_byte);
>  
> @@ -1242,10 +1221,8 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		 */
>  		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
>  				scan_end_byte, SEEK_HOLE);
> -		if (data_end < 0) {
> -			error = data_end;
> +		if (WARN_ON_ONCE(data_end < 0))
>  			goto out_unlock;
> -		}
>  
>  		/*
>  		 * If we race with post-direct I/O invalidation of the page cache,
> @@ -1257,22 +1234,19 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		WARN_ON_ONCE(data_end < start_byte);
>  		WARN_ON_ONCE(data_end > scan_end_byte);
>  
> -		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
> -				start_byte, data_end, iomap, punch);
> -		if (error)
> -			goto out_unlock;
> +		iomap_write_delalloc_scan(inode, &punch_start_byte, start_byte,
> +				data_end, iomap, punch);
>  
>  		/* The next data search starts at the end of this one. */
>  		start_byte = data_end;
>  	}
>  
>  	if (punch_start_byte < end_byte)
> -		error = punch(inode, punch_start_byte,
> -				end_byte - punch_start_byte, iomap);
> +		punch(inode, punch_start_byte, end_byte - punch_start_byte,
> +				iomap);
>  out_unlock:
>  	if (!(flags & IOMAP_ZERO))
>  		filemap_invalidate_unlock(inode->i_mapping);
> -	return error;
>  }
>  
>  /*
> @@ -1305,7 +1279,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>   *       ->punch
>   *         internal filesystem allocation lock
>   */
> -int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> +void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  		loff_t pos, loff_t length, ssize_t written, unsigned flags,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
> @@ -1314,11 +1288,11 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  	unsigned int		blocksize = i_blocksize(inode);
>  
>  	if (iomap->type != IOMAP_DELALLOC)
> -		return 0;
> +		return;
>  
>  	/* If we didn't reserve the blocks, we're not allowed to punch them. */
>  	if (!(iomap->flags & IOMAP_F_NEW))
> -		return 0;
> +		return;
>  
>  	/*
>  	 * start_byte refers to the first unused block after a short write. If
> @@ -1333,10 +1307,10 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  
>  	/* Nothing to do if we've written the entire delalloc extent */
>  	if (start_byte >= end_byte)
> -		return 0;
> +		return;
>  
> -	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
> -					iomap, punch);
> +	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
> +			punch);
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 695e5bee776f94..1e11f48814c0d0 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1208,7 +1208,7 @@ xfs_buffered_write_iomap_begin(
>  	return error;
>  }
>  
> -static int
> +static void
>  xfs_buffered_write_delalloc_punch(
>  	struct inode		*inode,
>  	loff_t			offset,
> @@ -1216,7 +1216,6 @@ xfs_buffered_write_delalloc_punch(
>  	struct iomap		*iomap)
>  {
>  	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
> -	return 0;
>  }
>  
>  static int
> @@ -1228,18 +1227,8 @@ xfs_buffered_write_iomap_end(
>  	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> -
> -	struct xfs_mount	*mp = XFS_M(inode->i_sb);
> -	int			error;
> -
> -	error = iomap_file_buffered_write_punch_delalloc(inode, offset, length,
> -			written, flags, iomap,
> -			&xfs_buffered_write_delalloc_punch);
> -	if (error && !xfs_is_shutdown(mp)) {
> -		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
> -			__func__, XFS_I(inode)->i_ino);
> -		return error;
> -	}
> +	iomap_file_buffered_write_punch_delalloc(inode, offset, length, written,
> +			flags, iomap, &xfs_buffered_write_delalloc_punch);
>  	return 0;
>  }
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index a931190f6d858b..78a48af4d2c0a1 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -274,9 +274,9 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  
> -typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
> +typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
>  		struct iomap *iomap);
> -int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
> +void iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
>  		loff_t length, ssize_t written, unsigned flag,
>  		struct iomap *iomap, iomap_punch_t punch);
>  
> -- 
> 2.43.0
> 
> 

