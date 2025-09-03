Return-Path: <linux-fsdevel+bounces-60216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139C1B42BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C363B555A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84452EA721;
	Wed,  3 Sep 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4d4Kp4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B922E03FF;
	Wed,  3 Sep 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934275; cv=none; b=aJVQ0E5Nv6kpT2e8bHyWoEyb2Afm6pQrqbRofZ09pZeJu6+7W+2GzGqd9Lu4iInoP3ufKc0ad2WT1lbplqfzeDMj/6RhcNdODDLSYDl+R69T8m2XVQ1D6qNBCYl542CKBDfmHf+vaXpafjk8QhI5vGdfluxd38ilZUQtyj6+qNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934275; c=relaxed/simple;
	bh=y/N3XrQIE10U0i7dVi7Fh3kFudq3gY+5ARahl/tv8uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubq0F32IbCy1/4q7dGwnrOpjPczqCiHxVC0CN4tTIQHneiai4gSDc2yUVs9FY0v/VgDZMRsDyWm2QdlF/BA96FmV5TX8fT0v3Bl+YU/0tb5lQKasxUzJVdwZGamXd5JfbOjWsIMtUhBLBJTl9/U6wJY+rep7MqqSLOtBowv199A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4d4Kp4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A369C4CEE7;
	Wed,  3 Sep 2025 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934274;
	bh=y/N3XrQIE10U0i7dVi7Fh3kFudq3gY+5ARahl/tv8uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4d4Kp4opTy1fizSL6NSStwzaf6YvNPAyzuJLRO70YjZ5rqTL5S1L+tYyXJG1s0g4
	 ZB2mUM1+GV+qFAN2A8Pz5cTKzEkbT+FQfoMZ/bGfE101xFFUSnWjY74a5HDs/s1XPh
	 Ua8oDyLO2ghYape/1ldReRssnNySfyQvex6K66UlWhWLvWuV9Q5Zw9x4GKdXGu9VNK
	 OI3A+ZmbK+o9HvmVJR9fvwqjy21Ew/YjRz/OFZ7Mt17k754aMtcbL9jzQhP1C2i0HK
	 1BMhG0S/61PSi2xm8Ph8yBb8RHd+3z2iwqCZamTOtPc7CCy65T4yuBHEJlcnxePslr
	 KoNPm1U4vI07A==
Date: Wed, 3 Sep 2025 14:17:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 15/16] fuse: use iomap for readahead
Message-ID: <20250903211754.GW1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-16-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-16-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:26PM -0700, Joanne Koong wrote:
> Do readahead in fuse using iomap. This gives us granular uptodate
> tracking for large folios, which optimizes how much data needs to be
> read in. If some portions of the folio are already uptodate (eg through
> a prior write), we only need to read in the non-uptodate portions.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 214 +++++++++++++++++++++++++++----------------------
>  1 file changed, 118 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bdfb13cdee4b..1659603f4cb6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -844,8 +844,73 @@ static const struct iomap_ops fuse_iomap_ops = {
>  
>  struct fuse_fill_read_data {
>  	struct file *file;
> +	/*
> +	 * We need to track this because non-readahead requests can't be sent
> +	 * asynchronously.
> +	 */
> +	bool readahead : 1;
> +
> +	/*
> +	 * Fields below are used if sending the read request
> +	 * asynchronously.
> +	 */
> +	struct fuse_conn *fc;
> +	struct readahead_control *rac;
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
> +				 struct fuse_fill_read_data *data, loff_t pos,
> +				 size_t len)
> +{
> +	struct fuse_io_args *ia = data->ia;
> +	size_t off = offset_in_folio(folio, pos);
> +	struct fuse_conn *fc = data->fc;
> +	struct fuse_args_pages *ap;
> +
> +	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
> +					false)) {
> +		fuse_send_readpages(ia, data->file, data->nr_bytes,
> +				    fc->async_read);
> +		data->nr_bytes = 0;
> +		ia = NULL;
> +	}
> +	if (!ia) {
> +		struct readahead_control *rac = data->rac;
> +		unsigned nr_pages = min(fc->max_pages, readahead_count(rac));
> +
> +		if (fc->num_background >= fc->congestion_threshold &&
> +		    rac->ra->async_size >= readahead_count(rac))
> +			/*
> +			 * Congested and only async pages left, so skip the
> +			 * rest.
> +			 */
> +			return -EAGAIN;
> +
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
>  					     struct folio *folio, loff_t pos,
>  					     size_t len)
> @@ -855,13 +920,24 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  	size_t off = offset_in_folio(folio, pos);
>  	int ret;
>  
> -	/*
> -	 *  for non-readahead read requests, do reads synchronously since
> -	 *  it's not guaranteed that the server can handle out-of-order reads
> -	 */
>  	iomap_start_folio_read(folio, len);
> -	ret = fuse_do_readfolio(file, folio, off, len);
> -	iomap_finish_folio_read(folio, off, len, ret);
> +	if (data->readahead) {
> +		ret = fuse_handle_readahead(folio, data, pos, len);
> +		/*
> +		 * If fuse_handle_readahead was successful, fuse_readpages_end
> +		 * will do the iomap_finish_folio_read, else we need to call it
> +		 * here
> +		 */
> +		if (ret)
> +			iomap_finish_folio_read(folio, off, len, ret);
> +	} else {
> +		/*
> +		 *  for non-readahead read requests, do reads synchronously since
> +		 *  it's not guaranteed that the server can handle out-of-order reads
> +		 */
> +		ret = fuse_do_readfolio(file, folio, off, len);
> +		iomap_finish_folio_read(folio, off, len, ret);
> +	}
>  	return ret;
>  }
>  
> @@ -923,7 +999,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  	}
>  
>  	for (i = 0; i < ap->num_folios; i++) {
> -		folio_end_read(ap->folios[i], !err);
> +		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
> +					ap->descs[i].length, err);
>  		folio_put(ap->folios[i]);
>  	}
>  	if (ia->ff)
> @@ -933,7 +1010,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  }
>  
>  static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> -				unsigned int count)
> +				unsigned int count, bool async)
>  {
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
> @@ -955,7 +1032,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
>  
>  	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
>  	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
> -	if (fm->fc->async_read) {
> +	if (async) {
>  		ia->ff = fuse_file_get(ff);
>  		ap->args.end = fuse_readpages_end;
>  		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
> @@ -972,81 +1049,20 @@ static void fuse_readahead(struct readahead_control *rac)
>  {
>  	struct inode *inode = rac->mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	unsigned int max_pages, nr_pages;
> -	struct folio *folio = NULL;
> +	struct fuse_fill_read_data data = {
> +		.file = rac->file,
> +		.readahead = true,
> +		.fc = fc,
> +		.rac = rac,
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
> +	iomap_readahead(rac, &fuse_iomap_ops, &fuse_iomap_read_ops, &data);
> +	if (data.ia)
> +		fuse_send_readpages(data.ia, data.file, data.nr_bytes,
> +				    fc->async_read);
>  }
>  
>  static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> @@ -2077,7 +2093,7 @@ struct fuse_fill_wb_data {
>  	struct fuse_file *ff;
>  	unsigned int max_folios;
>  	/*
> -	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
> +	 * nr_bytes won't overflow since fuse_folios_need_send() caps
>  	 * wb requests to never exceed fc->max_pages (which has an upper bound
>  	 * of U16_MAX).
>  	 */
> @@ -2122,14 +2138,15 @@ static void fuse_writepages_send(struct inode *inode,
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
> @@ -2137,8 +2154,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
>  	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
>  		return true;
>  
> -	/* Reached max write bytes */
> -	if (bytes > fc->max_write)
> +	if (bytes > max_bytes)
>  		return true;
>  
>  	/* Discontinuity */
> @@ -2148,11 +2164,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
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
> @@ -2176,10 +2187,21 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  			return -EIO;
>  	}
>  
> -	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
> -		fuse_writepages_send(inode, data);
> -		data->wpa = NULL;
> -		data->nr_bytes = 0;
> +	if (wpa) {
> +		bool send = fuse_folios_need_send(fc, pos, len, ap, data->nr_bytes,
> +						  true);
> +
> +		if (!send) {
> +			/* Need to grow the pages array?  If so, did the expansion fail? */
> +			send = (ap->num_folios == data->max_folios) &&
> +				!fuse_pages_realloc(data, fc->max_pages);
> +		}

What purpose this code relocation serve?  I gather the idea here is that
writes need to reallocate the pages array, whereas readahead can simply
constrain to whatever's already allocated?

--D

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

