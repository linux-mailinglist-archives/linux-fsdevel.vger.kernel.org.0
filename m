Return-Path: <linux-fsdevel+bounces-60215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B1B42B99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B2F3BA7FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5AD2EA729;
	Wed,  3 Sep 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkECYp13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA612C235A;
	Wed,  3 Sep 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934008; cv=none; b=gWJ7ahrlHveAPrXuFIltX7HFFxF/kzVZUi16Ph59EB1wjFYwusiLGqYgv7kWGTT7cTOWRiM2CiogrVbBqBDsAvBPHSi5B5smVovjRIQyG3zTWSekGtn+a2VQuDjOLDRVaZAn/wrAcaHo7HzyxmG+0ZuyVa5JQ1YsJ59t++O0PCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934008; c=relaxed/simple;
	bh=3nZX1epVbBwJA8air7vdfGVs3x6433+ak+7GOZwYmMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9rG0vW4g/24ViyypJwY1OLGbB8Hu0bASPvQ41JqwZjzI9EukX8Z09s7tDTO9+5+pXP0bia96Tv/DnDFxcuxBkbvu2MOs/+KfjQJRtjFBx+HtCysm+62lAlHr1P4Dk+07N2Ri/9EQYK1U5iAPEXk5xhSXwzpmTWlYb4FYzFDhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkECYp13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97659C4CEE7;
	Wed,  3 Sep 2025 21:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934007;
	bh=3nZX1epVbBwJA8air7vdfGVs3x6433+ak+7GOZwYmMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkECYp13wcCASVJtJN/GM0vUhmb3yAPZBKUIoESt8az7ieSXGwH2M4rzwFbXLJM91
	 rd2ix+hsCe9KWTrNHXYro30Ll+NYgla97h3kEaO8yJNVoATyHsZmOSDHmuHOAQybvL
	 6Pt4aJxBaZ6zyAW4dVCDT0zinnUEb2YGZRLwNxZsqibmVUXk7YShRRQP7WD4CXDnY1
	 1D54Rr32XW30uJlaCPUnS5U3NJs+CudDG+YNC9gEoR6mjXAYZiM0VsD5JZNRTP5wlM
	 LHLloY30tg/3IvMDCw1ZmNqLVJ7EC4YdnUW4KNcUq/sB1sHrzeibStIb6J5WUsLWNJ
	 ODBEVzkfECjIA==
Date: Wed, 3 Sep 2025 14:13:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 14/16] fuse: use iomap for read_folio
Message-ID: <20250903211327.GV1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-15-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-15-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:25PM -0700, Joanne Koong wrote:
> Read folio data into the page cache using iomap. This gives us granular
> uptodate tracking for large folios, which optimizes how much data needs
> to be read in. If some portions of the folio are already uptodate (eg
> through a prior write), we only need to read in the non-uptodate
> portions.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 72 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5525a4520b0f..bdfb13cdee4b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -828,22 +828,62 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
>  	return 0;
>  }
>  
> +static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			    unsigned int flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
> +{
> +	iomap->type = IOMAP_MAPPED;
> +	iomap->length = length;
> +	iomap->offset = offset;
> +	return 0;
> +}
> +
> +static const struct iomap_ops fuse_iomap_ops = {
> +	.iomap_begin	= fuse_iomap_begin,
> +};
> +
> +struct fuse_fill_read_data {
> +	struct file *file;
> +};
> +
> +static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
> +					     struct folio *folio, loff_t pos,
> +					     size_t len)
> +{
> +	struct fuse_fill_read_data *data = iter->private;
> +	struct file *file = data->file;
> +	size_t off = offset_in_folio(folio, pos);
> +	int ret;
> +
> +	/*
> +	 *  for non-readahead read requests, do reads synchronously since
> +	 *  it's not guaranteed that the server can handle out-of-order reads
> +	 */
> +	iomap_start_folio_read(folio, len);
> +	ret = fuse_do_readfolio(file, folio, off, len);
> +	iomap_finish_folio_read(folio, off, len, ret);
> +	return ret;
> +}
> +
> +static const struct iomap_read_ops fuse_iomap_read_ops = {
> +	.read_folio_range = fuse_iomap_read_folio_range_async,
> +};
> +
>  static int fuse_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct inode *inode = folio->mapping->host;
> +	struct fuse_fill_read_data data = {
> +		.file = file,
> +	};
>  	int err;
>  
> -	err = -EIO;
> -	if (fuse_is_bad(inode))
> -		goto out;
> -
> -	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> -	if (!err)
> -		folio_mark_uptodate(folio);
> +	if (fuse_is_bad(inode)) {
> +		folio_unlock(folio);
> +		return -EIO;
> +	}
>  
> +	err = iomap_read_folio(folio, &fuse_iomap_ops, &fuse_iomap_read_ops, &data);
>  	fuse_invalidate_atime(inode);
> - out:
> -	folio_unlock(folio);
>  	return err;
>  }
>  
> @@ -1394,20 +1434,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
>  	.read_folio_range = fuse_iomap_read_folio_range,
>  };
>  
> -static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> -			    unsigned int flags, struct iomap *iomap,
> -			    struct iomap *srcmap)
> -{
> -	iomap->type = IOMAP_MAPPED;
> -	iomap->length = length;
> -	iomap->offset = offset;
> -	return 0;
> -}
> -
> -static const struct iomap_ops fuse_iomap_ops = {
> -	.iomap_begin	= fuse_iomap_begin,
> -};
> -
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
> -- 
> 2.47.3
> 
> 

