Return-Path: <linux-fsdevel+bounces-62182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED9B873F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955FE1C26A4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A92FD7CE;
	Thu, 18 Sep 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJu9gb5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0508BEE;
	Thu, 18 Sep 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234928; cv=none; b=fbOOppPMsgvO6OmIhuwOt1sSZ047ZA5WZpKT0I0jIdXDSBS0uspgaLAJ5wEL55QOSv/3v5EMKArixHZhWlY4YnCYfS3JepaHUpAo3tafZpMytzvg0q/VUFybLZt3F008QjGeA5Jg4I9I+UxeEN/mFC3unxE6al1Pty4qcZNeT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234928; c=relaxed/simple;
	bh=PlPs1lDuVx67ivoo3IHnsqEmi59UWnhp3+kumesH8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQg4rkXT1mDWfLIvLbKcXf9H2+o0/6ff077Sa3JzZ5TCWbBns49ThURflOTWWThm3VWj3i5ImE6VHDDKTiafLyMWKUtheckHx6rUpVfJgjr7rNATP06vBlh5r1cw3gRQQyBPVS9OFiPKLvH9Y0x4WoqMCljhxOCx7O7oE0xKRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJu9gb5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC9C4CEE7;
	Thu, 18 Sep 2025 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758234927;
	bh=PlPs1lDuVx67ivoo3IHnsqEmi59UWnhp3+kumesH8I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJu9gb5IBCt2dyAcUkrndJN7iQKNYe4x5w4j1hF9CHNhPJwWkPHJeSgHiOhQIksP+
	 vSNtPez03gCCZDj5DONE8DSFvPmlpoUWu+/O+wa+rH8NHg6yCJmkzSz1MVM88+qsyy
	 YPynaRhTWenZuhT0z75CdkvLmHIEyvgbr58JcaXFTnrEppxuL1SoH1duaRB9q5m2An
	 QCvt6X/HcOVFs6LK4X3ySrEKqsCEqsPcaDSnoprej2utbo9i1qwkib7sq2rC/St+BA
	 3TbVB38GgNJnw944QUxPLtgemFOECgZyrcW05qhzEqJrS6J9uhhAFihy5FSHqEj+bz
	 VWZcmVGUdgl1w==
Date: Thu, 18 Sep 2025 15:35:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 14/15] fuse: use iomap for readahead
Message-ID: <20250918223526.GA1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-15-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-15-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:24PM -0700, Joanne Koong wrote:
> Do readahead in fuse using iomap. This gives us granular uptodate
> tracking for large folios, which optimizes how much data needs to be
> read in. If some portions of the folio are already uptodate (eg through
> a prior write), we only need to read in the non-uptodate portions.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks generally ok to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 220 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 124 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 4f27a3b0c20a..db0b1f20fee4 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -844,8 +844,65 @@ static const struct iomap_ops fuse_iomap_ops = {
>  
>  struct fuse_fill_read_data {
>  	struct file *file;
> +
> +	/* Fields below are used if sending the read request asynchronously */
> +	struct fuse_conn *fc;
> +	struct fuse_io_args *ia;
> +	unsigned int nr_bytes;
>  };
>  
> +/* forward declarations */
> +static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
> +				  unsigned len, struct fuse_args_pages *ap,
> +				  unsigned cur_bytes, bool write);
> +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> +				unsigned int count, bool async);
> +
> +static int fuse_handle_readahead(struct folio *folio,
> +				 struct readahead_control *rac,
> +				 struct fuse_fill_read_data *data, loff_t pos,
> +				 size_t len)
> +{
> +	struct fuse_io_args *ia = data->ia;
> +	size_t off = offset_in_folio(folio, pos);
> +	struct fuse_conn *fc = data->fc;
> +	struct fuse_args_pages *ap;
> +	unsigned int nr_pages;
> +
> +	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
> +					false)) {
> +		fuse_send_readpages(ia, data->file, data->nr_bytes,
> +				    fc->async_read);
> +		data->nr_bytes = 0;
> +		data->ia = NULL;
> +		ia = NULL;
> +	}
> +	if (!ia) {
> +		if (fc->num_background >= fc->congestion_threshold &&
> +		    rac->ra->async_size >= readahead_count(rac))
> +			/*
> +			 * Congested and only async pages left, so skip the
> +			 * rest.
> +			 */
> +			return -EAGAIN;
> +
> +		nr_pages = min(fc->max_pages, readahead_count(rac));
> +		data->ia = fuse_io_alloc(NULL, nr_pages);
> +		if (!data->ia)
> +			return -ENOMEM;
> +		ia = data->ia;
> +	}
> +	folio_get(folio);
> +	ap = &ia->ap;
> +	ap->folios[ap->num_folios] = folio;
> +	ap->descs[ap->num_folios].offset = off;
> +	ap->descs[ap->num_folios].length = len;
> +	data->nr_bytes += len;
> +	ap->num_folios++;
> +
> +	return 0;
> +}
> +
>  static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  					     struct iomap_read_folio_ctx *ctx,
>  					     size_t len)
> @@ -857,18 +914,40 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  	struct file *file = data->file;
>  	int ret;
>  
> -	/*
> -	 *  for non-readahead read requests, do reads synchronously since
> -	 *  it's not guaranteed that the server can handle out-of-order reads
> -	 */
>  	iomap_start_folio_read(folio, len);
> -	ret = fuse_do_readfolio(file, folio, off, len);
> -	iomap_finish_folio_read(folio, off, len, ret);
> +	if (ctx->rac) {
> +		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
> +		/*
> +		 * If fuse_handle_readahead was successful, fuse_readpages_end
> +		 * will do the iomap_finish_folio_read, else we need to call it
> +		 * here
> +		 */
> +		if (ret)
> +			iomap_finish_folio_read(folio, off, len, ret);
> +	} else {
> +		/*
> +		 *  for non-readahead read requests, do reads synchronously
> +		 *  since it's not guaranteed that the server can handle
> +		 *  out-of-order reads
> +		 */
> +		ret = fuse_do_readfolio(file, folio, off, len);
> +		iomap_finish_folio_read(folio, off, len, ret);
> +	}
>  	return ret;
>  }
>  
> +static void fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
> +{
> +	struct fuse_fill_read_data *data = ctx->read_ctx;
> +
> +	if (data->ia)
> +		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
> +				    data->fc->async_read);
> +}
> +
>  static const struct iomap_read_ops fuse_iomap_read_ops = {
>  	.read_folio_range = fuse_iomap_read_folio_range_async,
> +	.submit_read = fuse_iomap_read_submit,
>  };
>  
>  static int fuse_read_folio(struct file *file, struct folio *folio)
> @@ -930,7 +1009,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  	}
>  
>  	for (i = 0; i < ap->num_folios; i++) {
> -		folio_end_read(ap->folios[i], !err);
> +		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
> +					ap->descs[i].length, err);
>  		folio_put(ap->folios[i]);
>  	}
>  	if (ia->ff)
> @@ -940,7 +1020,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  }
>  
>  static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> -				unsigned int count)
> +				unsigned int count, bool async)
>  {
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
> @@ -962,7 +1042,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
>  
>  	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
>  	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
> -	if (fm->fc->async_read) {
> +	if (async) {
>  		ia->ff = fuse_file_get(ff);
>  		ap->args.end = fuse_readpages_end;
>  		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
> @@ -979,81 +1059,20 @@ static void fuse_readahead(struct readahead_control *rac)
>  {
>  	struct inode *inode = rac->mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	unsigned int max_pages, nr_pages;
> -	struct folio *folio = NULL;
> +	struct fuse_fill_read_data data = {
> +		.file = rac->file,
> +		.fc = fc,
> +	};
> +	struct iomap_read_folio_ctx ctx = {
> +		.ops = &fuse_iomap_read_ops,
> +		.rac = rac,
> +		.read_ctx = &data
> +	};
>  
>  	if (fuse_is_bad(inode))
>  		return;
>  
> -	max_pages = min_t(unsigned int, fc->max_pages,
> -			fc->max_read / PAGE_SIZE);
> -
> -	/*
> -	 * This is only accurate the first time through, since readahead_folio()
> -	 * doesn't update readahead_count() from the previous folio until the
> -	 * next call.  Grab nr_pages here so we know how many pages we're going
> -	 * to have to process.  This means that we will exit here with
> -	 * readahead_count() == folio_nr_pages(last_folio), but we will have
> -	 * consumed all of the folios, and read_pages() will call
> -	 * readahead_folio() again which will clean up the rac.
> -	 */
> -	nr_pages = readahead_count(rac);
> -
> -	while (nr_pages) {
> -		struct fuse_io_args *ia;
> -		struct fuse_args_pages *ap;
> -		unsigned cur_pages = min(max_pages, nr_pages);
> -		unsigned int pages = 0;
> -
> -		if (fc->num_background >= fc->congestion_threshold &&
> -		    rac->ra->async_size >= readahead_count(rac))
> -			/*
> -			 * Congested and only async pages left, so skip the
> -			 * rest.
> -			 */
> -			break;
> -
> -		ia = fuse_io_alloc(NULL, cur_pages);
> -		if (!ia)
> -			break;
> -		ap = &ia->ap;
> -
> -		while (pages < cur_pages) {
> -			unsigned int folio_pages;
> -
> -			/*
> -			 * This returns a folio with a ref held on it.
> -			 * The ref needs to be held until the request is
> -			 * completed, since the splice case (see
> -			 * fuse_try_move_page()) drops the ref after it's
> -			 * replaced in the page cache.
> -			 */
> -			if (!folio)
> -				folio =  __readahead_folio(rac);
> -
> -			folio_pages = folio_nr_pages(folio);
> -			if (folio_pages > cur_pages - pages) {
> -				/*
> -				 * Large folios belonging to fuse will never
> -				 * have more pages than max_pages.
> -				 */
> -				WARN_ON(!pages);
> -				break;
> -			}
> -
> -			ap->folios[ap->num_folios] = folio;
> -			ap->descs[ap->num_folios].length = folio_size(folio);
> -			ap->num_folios++;
> -			pages += folio_pages;
> -			folio = NULL;
> -		}
> -		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
> -		nr_pages -= pages;
> -	}
> -	if (folio) {
> -		folio_end_read(folio, false);
> -		folio_put(folio);
> -	}
> +	iomap_readahead(&fuse_iomap_ops, &ctx);
>  }
>  
>  static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> @@ -2084,7 +2103,7 @@ struct fuse_fill_wb_data {
>  	struct fuse_file *ff;
>  	unsigned int max_folios;
>  	/*
> -	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
> +	 * nr_bytes won't overflow since fuse_folios_need_send() caps
>  	 * wb requests to never exceed fc->max_pages (which has an upper bound
>  	 * of U16_MAX).
>  	 */
> @@ -2129,14 +2148,15 @@ static void fuse_writepages_send(struct inode *inode,
>  	spin_unlock(&fi->lock);
>  }
>  
> -static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
> -				     unsigned len, struct fuse_args_pages *ap,
> -				     struct fuse_fill_wb_data *data)
> +static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
> +				  unsigned len, struct fuse_args_pages *ap,
> +				  unsigned cur_bytes, bool write)
>  {
>  	struct folio *prev_folio;
>  	struct fuse_folio_desc prev_desc;
> -	unsigned bytes = data->nr_bytes + len;
> +	unsigned bytes = cur_bytes + len;
>  	loff_t prev_pos;
> +	size_t max_bytes = write ? fc->max_write : fc->max_read;
>  
>  	WARN_ON(!ap->num_folios);
>  
> @@ -2144,8 +2164,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
>  	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
>  		return true;
>  
> -	/* Reached max write bytes */
> -	if (bytes > fc->max_write)
> +	if (bytes > max_bytes)
>  		return true;
>  
>  	/* Discontinuity */
> @@ -2155,11 +2174,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
>  	if (prev_pos != pos)
>  		return true;
>  
> -	/* Need to grow the pages array?  If so, did the expansion fail? */
> -	if (ap->num_folios == data->max_folios &&
> -	    !fuse_pages_realloc(data, fc->max_pages))
> -		return true;
> -
>  	return false;
>  }
>  
> @@ -2183,10 +2197,24 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  			return -EIO;
>  	}
>  
> -	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
> -		fuse_writepages_send(inode, data);
> -		data->wpa = NULL;
> -		data->nr_bytes = 0;
> +	if (wpa) {
> +		bool send = fuse_folios_need_send(fc, pos, len, ap,
> +						  data->nr_bytes, true);
> +
> +		if (!send) {
> +			/*
> +			 * Need to grow the pages array?  If so, did the
> +			 * expansion fail?
> +			 */
> +			send = (ap->num_folios == data->max_folios) &&
> +				!fuse_pages_realloc(data, fc->max_pages);
> +		}
> +
> +		if (send) {
> +			fuse_writepages_send(inode, data);
> +			data->wpa = NULL;
> +			data->nr_bytes = 0;
> +		}
>  	}
>  
>  	if (data->wpa == NULL) {
> -- 
> 2.47.3
> 
> 

