Return-Path: <linux-fsdevel+bounces-53178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0050AEBB18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F946188F300
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C942E888A;
	Fri, 27 Jun 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvC9oiCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE42D9EFC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036933; cv=none; b=C9nUlFZ5uEYxht62V06fxP/zA9A9PYxoewC3D0Cc3Hrj78yUIeRSWTi/zX9RTGpVZOwXLTqaQuWDmZ15sfqthTbz89XBBgawfN/v4WxumCeiMbw/aPtzIGMvsqa8P9tvgIsaH+p9lav9eeJAsZ9o8clVp0Uo++XfVxi+HVk9QXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036933; c=relaxed/simple;
	bh=79iv5yaZLNSjAoxK6ELnKxVx56HmCuEUS4b7rhAmk40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n73Ckqg8Ep9RbR3oJXQV9DFDIhBWc+fkHvxI3sNQGHriiUXQvQ/4ooPt6TJWkhRBALX0kKwmGWVYRECPErbOO8SoiArWk3RF6zSfjRGc0JKNvPvpjYgZfYZoBbLBVBa8MzPET7Sv0Pa6RdhTSKa860ZoHpothh2qsyV79WwjXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvC9oiCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751036930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HS1Ta5p8sMGCB20NF+KYNyxDzXmvtwJAEuj/yDaE770=;
	b=cvC9oiCBnG1BnnZGmSCuMWRevxMtFRCeIMN+ATGjZNp9b1pzKcMBSErssgXpg733vCdt3a
	8Dcyz/uHxh55MVprRM7ixLdFphf/w8T+ppqJXQy2qdqapq3VURce1p7I9PnEkhmw+3NAGz
	kOp2itqWOjb0gzOezs703Wp12xIuypI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-GMRcyWwuOCCNiXz0c6u5jA-1; Fri,
 27 Jun 2025 11:08:46 -0400
X-MC-Unique: GMRcyWwuOCCNiXz0c6u5jA-1
X-Mimecast-MFC-AGG-ID: GMRcyWwuOCCNiXz0c6u5jA_1751036924
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FAC41800289;
	Fri, 27 Jun 2025 15:08:44 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837561944CE7;
	Fri, 27 Jun 2025 15:08:42 +0000 (UTC)
Date: Fri, 27 Jun 2025 11:12:20 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
Message-ID: <aF601H1HVkw-g_Gk@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jun 27, 2025 at 09:02:34AM +0200, Christoph Hellwig wrote:
> Add inode and wpc fields to pass the inode and writeback context that
> are needed in the entire writeback call chain, and let the callers
> initialize all fields in the writeback context before calling
> iomap_writepages to simplify the argument passing.
> 
> Rename iomap_writepage_ctx to iomap_writeback_ctx given that the
> writepage method has been removed we're touching most users of the
> structure here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  .../filesystems/iomap/operations.rst          |  4 +-
>  block/fops.c                                  | 10 ++-
>  fs/gfs2/aops.c                                |  8 ++-
>  fs/gfs2/bmap.c                                |  2 +-
>  fs/iomap/buffered-io.c                        | 64 +++++++++----------
>  fs/xfs/xfs_aops.c                             | 42 +++++++-----
>  fs/zonefs/file.c                              | 10 ++-
>  include/linux/iomap.h                         | 14 ++--
>  8 files changed, 85 insertions(+), 69 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 3b628e370d88..52c2e23e0e76 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -283,9 +283,9 @@ The ``ops`` structure must be specified and is as follows:
>  .. code-block:: c
>  
>   struct iomap_writeback_ops {
> -     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +     int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
>                         loff_t offset, unsigned len);
> -     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> +     int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);

I find it slightly annoying that the struct name now implies 'wbc,'
which is obviously used by the writeback_control inside it. It would be
nice to eventually rename wpc to something more useful, but that's for
another patch:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>       void (*discard_folio)(struct folio *folio, loff_t pos);
>   };
>  
> diff --git a/block/fops.c b/block/fops.c
> index 1309861d4c2c..00af678aaa3a 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -537,7 +537,7 @@ static void blkdev_readahead(struct readahead_control *rac)
>  	iomap_readahead(rac, &blkdev_iomap_ops);
>  }
>  
> -static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
> +static int blkdev_map_blocks(struct iomap_writeback_ctx *wpc,
>  		struct inode *inode, loff_t offset, unsigned int len)
>  {
>  	loff_t isize = i_size_read(inode);
> @@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_writeback_ops = {
>  static int blkdev_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
> -	struct iomap_writepage_ctx wpc = { };
> +	struct iomap_writeback_ctx wpc = {
> +		.inode		= mapping->host,
> +		.wbc		= wbc,
> +		.ops		= &blkdev_writeback_ops
> +	};
>  
> -	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
> +	return iomap_writepages(&wpc);
>  }
>  
>  const struct address_space_operations def_blk_aops = {
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 14f204cd5a82..9340418a2be4 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -159,7 +159,11 @@ static int gfs2_writepages(struct address_space *mapping,
>  			   struct writeback_control *wbc)
>  {
>  	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
> -	struct iomap_writepage_ctx wpc = { };
> +	struct iomap_writeback_ctx wpc = {
> +		.inode		= mapping->host,
> +		.wbc		= wbc,
> +		.ops		= &gfs2_writeback_ops,
> +	};
>  	int ret;
>  
>  	/*
> @@ -168,7 +172,7 @@ static int gfs2_writepages(struct address_space *mapping,
>  	 * want balance_dirty_pages() to loop indefinitely trying to write out
>  	 * pages held in the ail that it can't find.
>  	 */
> -	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
> +	ret = iomap_writepages(&wpc);
>  	if (ret == 0 && wbc->nr_to_write > 0)
>  		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
>  	return ret;
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 7703d0471139..77a505e7a017 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2469,7 +2469,7 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	return error;
>  }
>  
> -static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +static int gfs2_map_blocks(struct iomap_writeback_ctx *wpc, struct inode *inode,
>  		loff_t offset, unsigned int len)
>  {
>  	int ret;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..b5162e0323d0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1596,7 +1596,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
>   * with the error status here to run the normal I/O completion handler to clear
>   * the writeback bit and let the file system proess the errors.
>   */
> -static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
> +static int iomap_submit_ioend(struct iomap_writeback_ctx *wpc, int error)
>  {
>  	if (!wpc->ioend)
>  		return error;
> @@ -1625,24 +1625,23 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  	return error;
>  }
>  
> -static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct inode *inode, loff_t pos,
> -		u16 ioend_flags)
> +static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
> +		loff_t pos, u16 ioend_flags)
>  {
>  	struct bio *bio;
>  
>  	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> -			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
> +			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
>  			       GFP_NOFS, &iomap_ioend_bioset);
>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>  	bio->bi_end_io = iomap_writepage_end_bio;
> -	bio->bi_write_hint = inode->i_write_hint;
> -	wbc_init_bio(wbc, bio);
> +	bio->bi_write_hint = wpc->inode->i_write_hint;
> +	wbc_init_bio(wpc->wbc, bio);
>  	wpc->nr_folios = 0;
> -	return iomap_init_ioend(inode, bio, pos, ioend_flags);
> +	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
>  }
>  
> -static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> +static bool iomap_can_add_to_ioend(struct iomap_writeback_ctx *wpc, loff_t pos,
>  		u16 ioend_flags)
>  {
>  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
> @@ -1677,10 +1676,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>   * At the end of a writeback pass, there will be a cached ioend remaining on the
>   * writepage context that the caller will need to submit.
>   */
> -static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, loff_t pos, loff_t end_pos,
> -		unsigned len)
> +static int iomap_add_to_ioend(struct iomap_writeback_ctx *wpc,
> +		struct folio *folio, loff_t pos, loff_t end_pos, unsigned len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
> @@ -1701,8 +1698,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		error = iomap_submit_ioend(wpc, 0);
>  		if (error)
>  			return error;
> -		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
> -				ioend_flags);
> +		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
>  	}
>  
>  	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> @@ -1756,24 +1752,24 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
>  		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
>  
> -	wbc_account_cgroup_owner(wbc, folio, len);
> +	wbc_account_cgroup_owner(wpc->wbc, folio, len);
>  	return 0;
>  }
>  
> -static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, u64 pos, u64 end_pos,
> -		unsigned dirty_len, unsigned *count)
> +static int iomap_writepage_map_blocks(struct iomap_writeback_ctx *wpc,
> +		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
> +		unsigned *count)
>  {
>  	int error;
>  
>  	do {
>  		unsigned map_len;
>  
> -		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
> +		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
>  		if (error)
>  			break;
> -		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
> +		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
> +				&wpc->iomap);
>  
>  		map_len = min_t(u64, dirty_len,
>  			wpc->iomap.offset + wpc->iomap.length - pos);
> @@ -1787,8 +1783,8 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		case IOMAP_HOLE:
>  			break;
>  		default:
> -			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
> -					end_pos, map_len);
> +			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
> +					map_len);
>  			if (!error)
>  				(*count)++;
>  			break;
> @@ -1869,11 +1865,11 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct folio *folio)
> +static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
> +		struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> -	struct inode *inode = folio->mapping->host;
> +	struct inode *inode = wpc->inode;
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	u64 end_aligned = 0;
> @@ -1920,8 +1916,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 */
>  	end_aligned = round_up(end_pos, i_blocksize(inode));
>  	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
> -		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
> -				pos, end_pos, rlen, &count);
> +		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
> +				rlen, &count);
>  		if (error)
>  			break;
>  		pos += rlen;
> @@ -1957,10 +1953,9 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  }
>  
>  int
> -iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> -		struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops)
> +iomap_writepages(struct iomap_writeback_ctx *wpc)
>  {
> +	struct address_space *mapping = wpc->inode->i_mapping;
>  	struct folio *folio = NULL;
>  	int error;
>  
> @@ -1972,9 +1967,8 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  			PF_MEMALLOC))
>  		return -EIO;
>  
> -	wpc->ops = ops;
> -	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> -		error = iomap_writepage_map(wpc, wbc, folio);
> +	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
> +		error = iomap_writepage_map(wpc, folio);
>  	return iomap_submit_ioend(wpc, error);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 63151feb9c3f..81040b57a844 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -24,13 +24,13 @@
>  #include "xfs_rtgroup.h"
>  
>  struct xfs_writepage_ctx {
> -	struct iomap_writepage_ctx ctx;
> +	struct iomap_writeback_ctx ctx;
>  	unsigned int		data_seq;
>  	unsigned int		cow_seq;
>  };
>  
>  static inline struct xfs_writepage_ctx *
> -XFS_WPC(struct iomap_writepage_ctx *ctx)
> +XFS_WPC(struct iomap_writeback_ctx *ctx)
>  {
>  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
>  }
> @@ -239,7 +239,7 @@ xfs_end_bio(
>   */
>  static bool
>  xfs_imap_valid(
> -	struct iomap_writepage_ctx	*wpc,
> +	struct iomap_writeback_ctx	*wpc,
>  	struct xfs_inode		*ip,
>  	loff_t				offset)
>  {
> @@ -277,7 +277,7 @@ xfs_imap_valid(
>  
>  static int
>  xfs_map_blocks(
> -	struct iomap_writepage_ctx *wpc,
> +	struct iomap_writeback_ctx *wpc,
>  	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
> @@ -457,7 +457,7 @@ xfs_ioend_needs_wq_completion(
>  
>  static int
>  xfs_submit_ioend(
> -	struct iomap_writepage_ctx *wpc,
> +	struct iomap_writeback_ctx *wpc,
>  	int			status)
>  {
>  	struct iomap_ioend	*ioend = wpc->ioend;
> @@ -532,19 +532,19 @@ static const struct iomap_writeback_ops xfs_writeback_ops = {
>  };
>  
>  struct xfs_zoned_writepage_ctx {
> -	struct iomap_writepage_ctx	ctx;
> +	struct iomap_writeback_ctx	ctx;
>  	struct xfs_open_zone		*open_zone;
>  };
>  
>  static inline struct xfs_zoned_writepage_ctx *
> -XFS_ZWPC(struct iomap_writepage_ctx *ctx)
> +XFS_ZWPC(struct iomap_writeback_ctx *ctx)
>  {
>  	return container_of(ctx, struct xfs_zoned_writepage_ctx, ctx);
>  }
>  
>  static int
>  xfs_zoned_map_blocks(
> -	struct iomap_writepage_ctx *wpc,
> +	struct iomap_writeback_ctx *wpc,
>  	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
> @@ -610,7 +610,7 @@ xfs_zoned_map_blocks(
>  
>  static int
>  xfs_zoned_submit_ioend(
> -	struct iomap_writepage_ctx *wpc,
> +	struct iomap_writeback_ctx *wpc,
>  	int			status)
>  {
>  	wpc->ioend->io_bio.bi_end_io = xfs_end_bio;
> @@ -636,19 +636,29 @@ xfs_vm_writepages(
>  	xfs_iflags_clear(ip, XFS_ITRUNCATED);
>  
>  	if (xfs_is_zoned_inode(ip)) {
> -		struct xfs_zoned_writepage_ctx	xc = { };
> +		struct xfs_zoned_writepage_ctx	xc = {
> +			.ctx = {
> +				.inode	= mapping->host,
> +				.wbc	= wbc,
> +				.ops	= &xfs_zoned_writeback_ops
> +			},
> +		};
>  		int				error;
>  
> -		error = iomap_writepages(mapping, wbc, &xc.ctx,
> -					 &xfs_zoned_writeback_ops);
> +		error = iomap_writepages(&xc.ctx);
>  		if (xc.open_zone)
>  			xfs_open_zone_put(xc.open_zone);
>  		return error;
>  	} else {
> -		struct xfs_writepage_ctx	wpc = { };
> -
> -		return iomap_writepages(mapping, wbc, &wpc.ctx,
> -				&xfs_writeback_ops);
> +		struct xfs_writepage_ctx	wpc = {
> +			.ctx = {
> +				.inode	= mapping->host,
> +				.wbc	= wbc,
> +				.ops	= &xfs_writeback_ops
> +			},
> +		};
> +
> +		return iomap_writepages(&wpc.ctx);
>  	}
>  }
>  
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 42e2c0065bb3..5a4b9f2711a9 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -124,7 +124,7 @@ static void zonefs_readahead(struct readahead_control *rac)
>   * Map blocks for page writeback. This is used only on conventional zone files,
>   * which implies that the page range can only be within the fixed inode size.
>   */
> -static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
> +static int zonefs_write_map_blocks(struct iomap_writeback_ctx *wpc,
>  				   struct inode *inode, loff_t offset,
>  				   unsigned int len)
>  {
> @@ -152,9 +152,13 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
>  static int zonefs_writepages(struct address_space *mapping,
>  			     struct writeback_control *wbc)
>  {
> -	struct iomap_writepage_ctx wpc = { };
> +	struct iomap_writeback_ctx wpc = {
> +		.inode		= mapping->host,
> +		.wbc		= wbc,
> +		.ops		= &zonefs_writeback_ops,
> +	};
>  
> -	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
> +	return iomap_writepages(&wpc);
>  }
>  
>  static int zonefs_swap_activate(struct swap_info_struct *sis,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 522644d62f30..778d99f45ef1 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -15,7 +15,7 @@ struct fiemap_extent_info;
>  struct inode;
>  struct iomap_iter;
>  struct iomap_dio;
> -struct iomap_writepage_ctx;
> +struct iomap_writeback_ctx;
>  struct iov_iter;
>  struct kiocb;
>  struct page;
> @@ -426,7 +426,7 @@ struct iomap_writeback_ops {
>  	 * An existing mapping from a previous call to this method can be reused
>  	 * by the file system if it is still valid.
>  	 */
> -	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +	int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
>  			  loff_t offset, unsigned len);
>  
>  	/*
> @@ -437,7 +437,7 @@ struct iomap_writeback_ops {
>  	 * error code if status was non-zero or another error happened and
>  	 * the bio could not be submitted.
>  	 */
> -	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> +	int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
>  
>  	/*
>  	 * Optional, allows the file system to discard state on a page where
> @@ -446,8 +446,10 @@ struct iomap_writeback_ops {
>  	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
> -struct iomap_writepage_ctx {
> +struct iomap_writeback_ctx {
>  	struct iomap		iomap;
> +	struct inode		*inode;
> +	struct writeback_control *wbc;
>  	struct iomap_ioend	*ioend;
>  	const struct iomap_writeback_ops *ops;
>  	u32			nr_folios;	/* folios added to the ioend */
> @@ -461,9 +463,7 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
> -int iomap_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops);
> +int iomap_writepages(struct iomap_writeback_ctx *wpc);
>  
>  /*
>   * Flags for direct I/O ->end_io:
> -- 
> 2.47.2
> 
> 


