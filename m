Return-Path: <linux-fsdevel+bounces-55035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5AB06832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858063B8F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A12BE628;
	Tue, 15 Jul 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkHysuOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B825BEF3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613067; cv=none; b=WDVsRdW2eqgd0OHJfMhK51GnOkJNq+4AEQadObrU7TtiOs9O7eu1Py90fJw9D+19R+whb6kmb5L2LzPreSj+fhrgY3rxH+b/LuYPGKYU3+dSeyp58pJnXumvdkM1qM7O0FpuF7N2KJXGb37xW/HYDVtuB4yWuyWMLsZ6cbGW1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613067; c=relaxed/simple;
	bh=ifT0TvWMYHaC54UVborjMLUyQd4zxYzP7O2hi64JWR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf6NilfXP+va7Q2poIa+XCUzO7YiVd7obVRQN5RJBGMsgcHxZoQy+ahb5ZiZmztdRJZR+lzPXuwN34/z4wqumdtUJELWv18a5frr/CFQuKSvVYqmsYVI7GuUhPPKXXtNqZQ3kdvMEGQoyljs0qJC8g5vQPPGj51kP+lo3hthQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkHysuOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243BBC4CEE3;
	Tue, 15 Jul 2025 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752613067;
	bh=ifT0TvWMYHaC54UVborjMLUyQd4zxYzP7O2hi64JWR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkHysuOQEKhRCFmLPnYNFYExQb05DuGBFppddDPY6e8jQbVPYNHJUFyRGwp3TWYJh
	 319OmsrMIcCBAFkyQpxwMhOf3QPCbDdV7CREJuPwcSizpIKL0tHLFRNV0V6RnoovzD
	 ucKAofyLUUMiKNfjRm9AEyYcMXricYA/xBcgzlw0wfAV/orHpLitj6QDfr36AyCp+D
	 edQlA2whZMe14HFmahIx5mEsExOXv3NwbeYN/QzUFyizlx1nQ/5tlEOE7G866OL4Uv
	 tRJJoxAAjSLSZvbdwKgf6TmEbhXS86tWEbcnQ6OqJOXkBgKRJ6HjFtxCkFYqkj24Ik
	 NEUUtFQ1RLxbQ==
Date: Tue, 15 Jul 2025 13:57:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, kernel-team@meta.com
Subject: Re: [PATCH v5 2/5] fuse: use iomap for writeback
Message-ID: <20250715205746.GM2672070@frogsfrogsfrogs>
References: <20250715202122.2282532-1-joannelkoong@gmail.com>
 <20250715202122.2282532-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715202122.2282532-3-joannelkoong@gmail.com>

On Tue, Jul 15, 2025 at 01:21:19PM -0700, Joanne Koong wrote:
> Use iomap for dirty folio writeback in ->writepages().
> This allows for granular dirty writeback of large folios.
> 
> Only the dirty portions of the large folio will be written instead of
> having to write out the entire folio. For example if there is a 1 MB
> large folio and only 2 bytes in it are dirty, only the page for those
> dirty bytes will be written out.
> 
> .dirty_folio needs to be set to iomap_dirty_folio so that the bitmap
> iomap uses for dirty tracking correctly reflects dirty regions that need
> to be written back.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Thanks for adding the comment about nr_max_bytes and whatnot!

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 133 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 82 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index cadad61ef7df..93a96cdf56e1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1832,7 +1832,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>  		 * scope of the fi->lock alleviates xarray lock
>  		 * contention and noticeably improves performance.
>  		 */
> -		folio_end_writeback(ap->folios[i]);
> +		iomap_finish_folio_write(inode, ap->folios[i], 1);
>  		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
>  		wb_writeout_inc(&bdi->wb);
>  	}
> @@ -2019,19 +2019,20 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
>  }
>  
>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> -					  uint32_t folio_index)
> +					  uint32_t folio_index, loff_t offset, unsigned len)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  
>  	ap->folios[folio_index] = folio;
> -	ap->descs[folio_index].offset = 0;
> -	ap->descs[folio_index].length = folio_size(folio);
> +	ap->descs[folio_index].offset = offset;
> +	ap->descs[folio_index].length = len;
>  
>  	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
>  }
>  
>  static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
> +							     size_t offset,
>  							     struct fuse_file *ff)
>  {
>  	struct inode *inode = folio->mapping->host;
> @@ -2044,7 +2045,7 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
>  		return NULL;
>  
>  	fuse_writepage_add_to_bucket(fc, wpa);
> -	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
> +	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
>  	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
>  	wpa->inode = inode;
>  	wpa->ia.ff = ff;
> @@ -2070,7 +2071,7 @@ static int fuse_writepage_locked(struct folio *folio)
>  	if (!ff)
>  		goto err;
>  
> -	wpa = fuse_writepage_args_setup(folio, ff);
> +	wpa = fuse_writepage_args_setup(folio, 0, ff);
>  	error = -ENOMEM;
>  	if (!wpa)
>  		goto err_writepage_args;
> @@ -2079,7 +2080,7 @@ static int fuse_writepage_locked(struct folio *folio)
>  	ap->num_folios = 1;
>  
>  	folio_start_writeback(folio);
> -	fuse_writepage_args_page_fill(wpa, folio, 0);
> +	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
>  
>  	spin_lock(&fi->lock);
>  	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> @@ -2100,7 +2101,12 @@ struct fuse_fill_wb_data {
>  	struct fuse_file *ff;
>  	struct inode *inode;
>  	unsigned int max_folios;
> -	unsigned int nr_pages;
> +	/*
> +	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
> +	 * wb requests to never exceed fc->max_pages (which has an upper bound
> +	 * of U16_MAX).
> +	 */
> +	unsigned int nr_bytes;
>  };
>  
>  static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
> @@ -2141,22 +2147,30 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
>  	spin_unlock(&fi->lock);
>  }
>  
> -static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
> -				     struct fuse_args_pages *ap,
> +static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
> +				     unsigned len, struct fuse_args_pages *ap,
>  				     struct fuse_fill_wb_data *data)
>  {
> +	struct folio *prev_folio;
> +	struct fuse_folio_desc prev_desc;
> +	unsigned bytes = data->nr_bytes + len;
> +	loff_t prev_pos;
> +
>  	WARN_ON(!ap->num_folios);
>  
>  	/* Reached max pages */
> -	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
> +	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
>  		return true;
>  
>  	/* Reached max write bytes */
> -	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
> +	if (bytes > fc->max_write)
>  		return true;
>  
>  	/* Discontinuity */
> -	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio->index)
> +	prev_folio = ap->folios[ap->num_folios - 1];
> +	prev_desc = ap->descs[ap->num_folios - 1];
> +	prev_pos = folio_pos(prev_folio) + prev_desc.offset + prev_desc.length;
> +	if (prev_pos != pos)
>  		return true;
>  
>  	/* Need to grow the pages array?  If so, did the expansion fail? */
> @@ -2166,85 +2180,102 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
>  	return false;
>  }
>  
> -static int fuse_writepages_fill(struct folio *folio,
> -		struct writeback_control *wbc, void *_data)
> +static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> +					  struct folio *folio, u64 pos,
> +					  unsigned len, u64 end_pos)
>  {
> -	struct fuse_fill_wb_data *data = _data;
> +	struct fuse_fill_wb_data *data = wpc->wb_ctx;
>  	struct fuse_writepage_args *wpa = data->wpa;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  	struct inode *inode = data->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	int err;
> +	loff_t offset = offset_in_folio(folio, pos);
> +
> +	WARN_ON_ONCE(!data);
> +	/* len will always be page aligned */
> +	WARN_ON_ONCE(len & (PAGE_SIZE - 1));
>  
>  	if (!data->ff) {
> -		err = -EIO;
>  		data->ff = fuse_write_file_get(fi);
>  		if (!data->ff)
> -			goto out_unlock;
> +			return -EIO;
>  	}
>  
> -	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
> +	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
>  		fuse_writepages_send(data);
>  		data->wpa = NULL;
> -		data->nr_pages = 0;
> +		data->nr_bytes = 0;
>  	}
>  
>  	if (data->wpa == NULL) {
> -		err = -ENOMEM;
> -		wpa = fuse_writepage_args_setup(folio, data->ff);
> +		wpa = fuse_writepage_args_setup(folio, offset, data->ff);
>  		if (!wpa)
> -			goto out_unlock;
> +			return -ENOMEM;
>  		fuse_file_get(wpa->ia.ff);
>  		data->max_folios = 1;
>  		ap = &wpa->ia.ap;
>  	}
> -	folio_start_writeback(folio);
>  
> -	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
> -	data->nr_pages += folio_nr_pages(folio);
> +	iomap_start_folio_write(inode, folio, 1);
> +	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
> +				      offset, len);
> +	data->nr_bytes += len;
>  
> -	err = 0;
>  	ap->num_folios++;
>  	if (!data->wpa)
>  		data->wpa = wpa;
> -out_unlock:
> -	folio_unlock(folio);
>  
> -	return err;
> +	return len;
> +}
> +
> +static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
> +				       int error)
> +{
> +	struct fuse_fill_wb_data *data = wpc->wb_ctx;
> +
> +	WARN_ON_ONCE(!data);
> +
> +	if (data->wpa) {
> +		WARN_ON(!data->wpa->ia.ap.num_folios);
> +		fuse_writepages_send(data);
> +	}
> +
> +	if (data->ff)
> +		fuse_file_put(data->ff, false);
> +
> +	return error;
>  }
>  
> +static const struct iomap_writeback_ops fuse_writeback_ops = {
> +	.writeback_range	= fuse_iomap_writeback_range,
> +	.writeback_submit	= fuse_iomap_writeback_submit,
> +};
> +
>  static int fuse_writepages(struct address_space *mapping,
>  			   struct writeback_control *wbc)
>  {
>  	struct inode *inode = mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	struct fuse_fill_wb_data data;
> -	int err;
> +	struct fuse_fill_wb_data data = {
> +		.inode = inode,
> +	};
> +	struct iomap_writepage_ctx wpc = {
> +		.inode = inode,
> +		.iomap.type = IOMAP_MAPPED,
> +		.wbc = wbc,
> +		.ops = &fuse_writeback_ops,
> +		.wb_ctx	= &data,
> +	};
>  
> -	err = -EIO;
>  	if (fuse_is_bad(inode))
> -		goto out;
> +		return -EIO;
>  
>  	if (wbc->sync_mode == WB_SYNC_NONE &&
>  	    fc->num_background >= fc->congestion_threshold)
>  		return 0;
>  
> -	data.inode = inode;
> -	data.wpa = NULL;
> -	data.ff = NULL;
> -	data.nr_pages = 0;
> -
> -	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
> -	if (data.wpa) {
> -		WARN_ON(!data.wpa->ia.ap.num_folios);
> -		fuse_writepages_send(&data);
> -	}
> -	if (data.ff)
> -		fuse_file_put(data.ff, false);
> -
> -out:
> -	return err;
> +	return iomap_writepages(&wpc);
>  }
>  
>  static int fuse_launder_folio(struct folio *folio)
> @@ -3104,7 +3135,7 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.readahead	= fuse_readahead,
>  	.writepages	= fuse_writepages,
>  	.launder_folio	= fuse_launder_folio,
> -	.dirty_folio	= filemap_dirty_folio,
> +	.dirty_folio	= iomap_dirty_folio,
>  	.release_folio	= iomap_release_folio,
>  	.migrate_folio	= filemap_migrate_folio,
>  	.bmap		= fuse_bmap,
> -- 
> 2.47.1
> 

