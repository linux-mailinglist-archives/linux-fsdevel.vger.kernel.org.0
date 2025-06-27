Return-Path: <linux-fsdevel+bounces-53193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8AAEBB45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B4F641696
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B52E88A2;
	Fri, 27 Jun 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgERFPpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254462C325C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037036; cv=none; b=rIx6hVb8FBOlfbiLPCvDmq2uziT3ZqJrua1jOyjCssWaygWR3vrMsaUUuZQ4F5OUbKjGlezalexrYOOvIgqFnNoDa+XaeJVIrNi6uMBjOJRnB1z4+gZ2A36cmDKi3FiiPO5zVclFEIknZWOjgPV4tPO/+C46dIqRGncIwvglcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037036; c=relaxed/simple;
	bh=CS6JGYEZyu63cneXlrE0N6uApdvgM6+ruuUsoPwhzns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CphJuHBqVl573381+8D3aLWn4N8YD5N2YiSEKFxDVkdDlT3p6v50G6hQIloYLqT2JLJoGqSpGAMeMfYIv8lotaKcsiOb8hvQ6AfdRnsEAMuASrHUp9RPvLI8GwnbOmbqqFXPlH3UpBkrE34T25SEhRIlHIi2tGXS/mHgSgWTYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgERFPpL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751037033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cw+o2cykoBoeqb8Lc9NZW3TPVPhuIv17rPABGT6nJ9c=;
	b=PgERFPpLTPsElqAnMCEjXNralIF9emc8oC7V4QjnFR3LbN1K9IJ1Yfo5kTfcOo5RGRqFqL
	CuxwuJDIwZI6w8rTYnbDZxQptWI/AMAkqPtcuDXhbwKKw17LgUZbf+WPxJ5s/EEmyImtVA
	GEHPBQoUjZF8KeV7gCnTG6KiBRbd3BU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-WnwzXdEGOxeC6iE4Ae1vDw-1; Fri,
 27 Jun 2025 11:10:31 -0400
X-MC-Unique: WnwzXdEGOxeC6iE4Ae1vDw-1
X-Mimecast-MFC-AGG-ID: WnwzXdEGOxeC6iE4Ae1vDw_1751037030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190CB1801208;
	Fri, 27 Jun 2025 15:10:30 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D7AA18046C5;
	Fri, 27 Jun 2025 15:10:27 +0000 (UTC)
Date: Fri, 27 Jun 2025 11:14:05 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 03/12] iomap: refactor the writeback interface
Message-ID: <aF61PZEb5ndROI6z@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jun 27, 2025 at 09:02:36AM +0200, Christoph Hellwig wrote:
> Replace ->map_blocks with a new ->writeback_range, which differs in the
> following ways:
> 
>  - it must also queue up the I/O for writeback, that is called into the
>    slightly refactored and extended in scope iomap_add_to_ioend for
>    each region
>  - can handle only a part of the requested region, that is the retry
>    loop for partial mappings moves to the caller
>  - handles cleanup on failures as well, and thus also replaces the
>    discard_folio method only implemented by XFS.
> 
> This will allow to use the iomap writeback code also for file systems
> that are not block based like fuse.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  23 +---
>  block/fops.c                                  |  25 ++--
>  fs/gfs2/bmap.c                                |  26 ++--
>  fs/iomap/buffered-io.c                        |  93 ++++++-------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 128 +++++++++++-------
>  fs/zonefs/file.c                              |  28 ++--
>  include/linux/iomap.h                         |  20 ++-
>  8 files changed, 183 insertions(+), 162 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 52c2e23e0e76..3c7989ee84ff 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
...
> @@ -283,15 +283,14 @@ The ``ops`` structure must be specified and is as follows:
>  .. code-block:: c
>  
>   struct iomap_writeback_ops {
> -     int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
> -                       loff_t offset, unsigned len);
> -     int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> -     void (*discard_folio)(struct folio *folio, loff_t pos);
> +    int (*writeback_range)(struct iomap_writeback_ctx *wpc,
> +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);

Whitespace damage on the above line.

> +    int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
>   };
>  
>  The fields are as follows:
>  
> -  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
> +  - ``writeback_range``: Sets ``wpc->iomap`` to the space mapping of the file
>      range (in bytes) given by ``offset`` and ``len``.
>      iomap calls this function for each dirty fs block in each dirty folio,
>      though it will `reuse mappings
...
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ec2f70c6ec33..a54b14817cd0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
...
> @@ -1748,63 +1764,34 @@ static int iomap_add_to_ioend(struct iomap_writeback_ctx *wpc,
...
>  
> -static int iomap_writepage_map_blocks(struct iomap_writeback_ctx *wpc,
> -		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
> +static int iomap_writeback_range(struct iomap_writeback_ctx *wpc,
> +		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
>  		bool *wb_pending)
>  {
> -	int error;
> -
>  	do {
> -		unsigned map_len;
> -
> -		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
> -		if (error)
> -			break;
> -		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
> -				&wpc->iomap);
> -
> -		map_len = min_t(u64, dirty_len,
> -			wpc->iomap.offset + wpc->iomap.length - pos);
> -		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +		ssize_t ret;
>  
> -		switch (wpc->iomap.type) {
> -		case IOMAP_INLINE:
> -			WARN_ON_ONCE(1);
> -			error = -EIO;
> -			break;
> -		case IOMAP_HOLE:
> -			break;
> -		default:
> -			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
> -					map_len);
> -			if (!error)
> -				*wb_pending = true;
> -			break;
> -		}
> -		dirty_len -= map_len;
> -		pos += map_len;
> -	} while (dirty_len && !error);
> +		ret = wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
> +		if (WARN_ON_ONCE(ret == 0 || ret > rlen))
> +			return -EIO;
> +		if (ret < 0)
> +			return ret;
> +		rlen -= ret;
> +		pos += ret;
> +		if (wpc->iomap.type != IOMAP_HOLE)
> +			*wb_pending = true;

I don't really love the implied logic here, but nothing better comes to
mind atm. I suppose a one-liner comment to connect this to the
add_to_ioend() call wouldn't hurt. Otherwise the rest looks reasonable
to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> +	} while (rlen);
>  
> -	/*
> -	 * We cannot cancel the ioend directly here on error.  We may have
> -	 * already set other pages under writeback and hence we have to run I/O
> -	 * completion to mark the error state of the pages under writeback
> -	 * appropriately.
> -	 *
> -	 * Just let the file system know what portion of the folio failed to
> -	 * map.
> -	 */
> -	if (error && wpc->ops->discard_folio)
> -		wpc->ops->discard_folio(folio, pos);
> -	return error;
> +	return 0;
>  }
>  
>  /*
> @@ -1916,8 +1903,8 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
>  	 */
>  	end_aligned = round_up(end_pos, i_blocksize(inode));
>  	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
> -		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
> -				rlen, &wb_pending);
> +		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
> +				&wb_pending);
>  		if (error)
>  			break;
>  		pos += rlen;
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 455cc6f90be0..aaea02c9560a 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -169,7 +169,7 @@ DEFINE_EVENT(iomap_class, name,	\
>  DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
>  DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
>  
> -TRACE_EVENT(iomap_writepage_map,
> +TRACE_EVENT(iomap_add_to_ioend,
>  	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
>  		 struct iomap *iomap),
>  	TP_ARGS(inode, pos, dirty_len, iomap),
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 81040b57a844..ce4ed03db21d 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -233,6 +233,47 @@ xfs_end_bio(
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  }
>  
> +/*
> + * We cannot cancel the ioend directly on error.  We may have already set other
> + * pages under writeback and hence we have to run I/O completion to mark the
> + * error state of the pages under writeback appropriately.
> + *
> + * If the folio has delalloc blocks on it, the caller is asking us to punch them
> + * out. If we don't, we can leave a stale delalloc mapping covered by a clean
> + * page that needs to be dirtied again before the delalloc mapping can be
> + * converted. This stale delalloc mapping can trip up a later direct I/O read
> + * operation on the same region.
> + *
> + * We prevent this by truncating away the delalloc regions on the folio. Because
> + * they are delalloc, we can do this without needing a transaction. Indeed - if
> + * we get ENOSPC errors, we have to be able to do this truncation without a
> + * transaction as there is no space left for block reservation (typically why
> + * we see a ENOSPC in writeback).
> + */
> +static void
> +xfs_discard_folio(
> +	struct folio		*folio,
> +	loff_t			pos)
> +{
> +	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (xfs_is_shutdown(mp))
> +		return;
> +
> +	xfs_alert_ratelimited(mp,
> +		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> +			folio, ip->i_ino, pos);
> +
> +	/*
> +	 * The end of the punch range is always the offset of the first
> +	 * byte of the next folio. Hence the end offset is only dependent on the
> +	 * folio itself and not the start offset that is passed in.
> +	 */
> +	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
> +				folio_pos(folio) + folio_size(folio), NULL);
> +}
> +
>  /*
>   * Fast revalidation of the cached writeback mapping. Return true if the current
>   * mapping is valid, false otherwise.
> @@ -278,13 +319,12 @@ xfs_imap_valid(
>  static int
>  xfs_map_blocks(
>  	struct iomap_writeback_ctx *wpc,
> -	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_inode	*ip = XFS_I(wpc->inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	ssize_t			count = i_blocksize(inode);
> +	ssize_t			count = i_blocksize(wpc->inode);
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  	xfs_fileoff_t		cow_fsb;
> @@ -436,6 +476,24 @@ xfs_map_blocks(
>  	return 0;
>  }
>  
> +static ssize_t
> +xfs_writeback_range(
> +	struct iomap_writeback_ctx *wpc,
> +	struct folio		*folio,
> +	u64			offset,
> +	unsigned int		len,
> +	u64			end_pos)
> +{
> +	ssize_t			ret;
> +
> +	ret = xfs_map_blocks(wpc, offset, len);
> +	if (!ret)
> +		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +	if (ret < 0)
> +		xfs_discard_folio(folio, offset);
> +	return ret;
> +}
> +
>  static bool
>  xfs_ioend_needs_wq_completion(
>  	struct iomap_ioend	*ioend)
> @@ -488,47 +546,9 @@ xfs_submit_ioend(
>  	return 0;
>  }
>  
> -/*
> - * If the folio has delalloc blocks on it, the caller is asking us to punch them
> - * out. If we don't, we can leave a stale delalloc mapping covered by a clean
> - * page that needs to be dirtied again before the delalloc mapping can be
> - * converted. This stale delalloc mapping can trip up a later direct I/O read
> - * operation on the same region.
> - *
> - * We prevent this by truncating away the delalloc regions on the folio. Because
> - * they are delalloc, we can do this without needing a transaction. Indeed - if
> - * we get ENOSPC errors, we have to be able to do this truncation without a
> - * transaction as there is no space left for block reservation (typically why
> - * we see a ENOSPC in writeback).
> - */
> -static void
> -xfs_discard_folio(
> -	struct folio		*folio,
> -	loff_t			pos)
> -{
> -	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
> -	struct xfs_mount	*mp = ip->i_mount;
> -
> -	if (xfs_is_shutdown(mp))
> -		return;
> -
> -	xfs_alert_ratelimited(mp,
> -		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> -			folio, ip->i_ino, pos);
> -
> -	/*
> -	 * The end of the punch range is always the offset of the first
> -	 * byte of the next folio. Hence the end offset is only dependent on the
> -	 * folio itself and not the start offset that is passed in.
> -	 */
> -	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
> -				folio_pos(folio) + folio_size(folio), NULL);
> -}
> -
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
> -	.map_blocks		= xfs_map_blocks,
> +	.writeback_range	= xfs_writeback_range,
>  	.submit_ioend		= xfs_submit_ioend,
> -	.discard_folio		= xfs_discard_folio,
>  };
>  
>  struct xfs_zoned_writepage_ctx {
> @@ -545,11 +565,10 @@ XFS_ZWPC(struct iomap_writeback_ctx *ctx)
>  static int
>  xfs_zoned_map_blocks(
>  	struct iomap_writeback_ctx *wpc,
> -	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_inode	*ip = XFS_I(wpc->inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + len);
> @@ -608,6 +627,24 @@ xfs_zoned_map_blocks(
>  	return 0;
>  }
>  
> +static ssize_t
> +xfs_zoned_writeback_range(
> +	struct iomap_writeback_ctx *wpc,
> +	struct folio		*folio,
> +	u64			offset,
> +	unsigned int		len,
> +	u64			end_pos)
> +{
> +	ssize_t			ret;
> +
> +	ret = xfs_zoned_map_blocks(wpc, offset, len);
> +	if (!ret)
> +		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +	if (ret < 0)
> +		xfs_discard_folio(folio, offset);
> +	return ret;
> +}
> +
>  static int
>  xfs_zoned_submit_ioend(
>  	struct iomap_writeback_ctx *wpc,
> @@ -621,9 +658,8 @@ xfs_zoned_submit_ioend(
>  }
>  
>  static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
> -	.map_blocks		= xfs_zoned_map_blocks,
> +	.writeback_range	= xfs_zoned_writeback_range,
>  	.submit_ioend		= xfs_zoned_submit_ioend,
> -	.discard_folio		= xfs_discard_folio,
>  };
>  
>  STATIC int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 5a4b9f2711a9..cb3d380c4651 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -124,29 +124,33 @@ static void zonefs_readahead(struct readahead_control *rac)
>   * Map blocks for page writeback. This is used only on conventional zone files,
>   * which implies that the page range can only be within the fixed inode size.
>   */
> -static int zonefs_write_map_blocks(struct iomap_writeback_ctx *wpc,
> -				   struct inode *inode, loff_t offset,
> -				   unsigned int len)
> +static ssize_t zonefs_writeback_range(struct iomap_writeback_ctx *wpc,
> +		struct folio *folio, u64 offset, unsigned len, u64 end_pos)
>  {
> -	struct zonefs_zone *z = zonefs_inode_zone(inode);
> +	struct zonefs_zone *z = zonefs_inode_zone(wpc->inode);
>  
>  	if (WARN_ON_ONCE(zonefs_zone_is_seq(z)))
>  		return -EIO;
> -	if (WARN_ON_ONCE(offset >= i_size_read(inode)))
> +	if (WARN_ON_ONCE(offset >= i_size_read(wpc->inode)))
>  		return -EIO;
>  
>  	/* If the mapping is already OK, nothing needs to be done */
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> -		return 0;
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length) {
> +		int error;
> +
> +		error = zonefs_write_iomap_begin(wpc->inode, offset,
> +				z->z_capacity - offset, IOMAP_WRITE,
> +				&wpc->iomap, NULL);
> +		if (error)
> +			return error;
> +	}
>  
> -	return zonefs_write_iomap_begin(inode, offset,
> -					z->z_capacity - offset,
> -					IOMAP_WRITE, &wpc->iomap, NULL);
> +	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>  
>  static const struct iomap_writeback_ops zonefs_writeback_ops = {
> -	.map_blocks		= zonefs_write_map_blocks,
> +	.writeback_range	= zonefs_writeback_range,
>  };
>  
>  static int zonefs_writepages(struct address_space *mapping,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 778d99f45ef1..e346475a023d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -416,18 +416,20 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
>  
>  struct iomap_writeback_ops {
>  	/*
> -	 * Required, maps the blocks so that writeback can be performed on
> -	 * the range starting at offset.
> +	 * Required, performs writeback on the passed in range
>  	 *
> -	 * Can return arbitrarily large regions, but we need to call into it at
> +	 * Can map arbitrarily large regions, but we need to call into it at
>  	 * least once per folio to allow the file systems to synchronize with
>  	 * the write path that could be invalidating mappings.
>  	 *
>  	 * An existing mapping from a previous call to this method can be reused
>  	 * by the file system if it is still valid.
> +	 *
> +	 * Returns the number of bytes processed or a negative errno.
>  	 */
> -	int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
> -			  loff_t offset, unsigned len);
> +	ssize_t (*writeback_range)(struct iomap_writeback_ctx *wpc,
> +			struct folio *folio, u64 pos, unsigned int len,
> +			u64 end_pos);
>  
>  	/*
>  	 * Optional, allows the file systems to hook into bio submission,
> @@ -438,12 +440,6 @@ struct iomap_writeback_ops {
>  	 * the bio could not be submitted.
>  	 */
>  	int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> -
> -	/*
> -	 * Optional, allows the file system to discard state on a page where
> -	 * we failed to submit any I/O.
> -	 */
> -	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
>  struct iomap_writeback_ctx {
> @@ -463,6 +459,8 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
> +ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
> +		loff_t pos, loff_t end_pos, unsigned int dirty_len);
>  int iomap_writepages(struct iomap_writeback_ctx *wpc);
>  
>  /*
> -- 
> 2.47.2
> 
> 


