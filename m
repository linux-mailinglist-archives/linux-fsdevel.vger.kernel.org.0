Return-Path: <linux-fsdevel+bounces-29872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27397EE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060B71C21725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF319C56A;
	Mon, 23 Sep 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6roe/Ey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B1197A9B;
	Mon, 23 Sep 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106800; cv=none; b=m9rf1FKGyv2ctOGfyvzV/OfaAH+kvyWl6sFEbRoqQwF3YG61DgwnG3hYx5RJgQwqol7g4ediggzcjeVF01XhHRFQtWHsCpnL/j17h0QEL8FDSq4P5uSLSwhUXjU7nwcxB8UwucaI37ziDaJzutzFa8mpbLHTHypZerHfKKwFT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106800; c=relaxed/simple;
	bh=QNgb9hMdvEcyozNtaS81ANiyuzRgkFkGC8w6qUB9R8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYIFkacEfTVmF08B8EsCT3oHNFQK9GXmJINe+5hJbGUkPJjfFhxlxaYHZcEWyD0joJQYAMjDI5tFK4WGwfI5PN7QbLAEUI+VEPiT+4JnvHA/t6Q4BaIneEDv00QOS9s2udr7dSO7se9HOraeJA2awM7Mhqje9Rgix/y3k4Bv7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6roe/Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A13C4CED1;
	Mon, 23 Sep 2024 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106800;
	bh=QNgb9hMdvEcyozNtaS81ANiyuzRgkFkGC8w6qUB9R8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6roe/EyAEQpGIIzY82nSmDss6TVt62/qnlh4yG8BOhKuHKpWyDc0mUXhgEWOrcV9
	 7IY4ZkcH0ne/YpUxwUYkczFSQ0wkVrazP86W3o1jNfn/6qZzeaJ+Rvyi7WDBsv6CFE
	 7AhjCLNQEDQS85BNAVwABCiMAWXx2YeBlUJh7PLRHz/psC9RxqzAjfYeEYNN1kq9XJ
	 aWJtc/htvTS+aybuTVnO+1/guivprwzLTc4fIcVQQfRLYPv2F0p8FqHHnt64E8jbSf
	 LHxP/3SBND8MoDEJ2YQc/aJLBB2+zRaAJkBgqYgZHiSx6yhoiPIEyuyMp60xicuzXi
	 EgOls3CE1JW1w==
Date: Mon, 23 Sep 2024 08:53:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: factor out a iomap_last_written_block helper
Message-ID: <20240923155319.GC21877@frogsfrogsfrogs>
References: <20240923152904.1747117-1-hch@lst.de>
 <20240923152904.1747117-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923152904.1747117-2-hch@lst.de>

On Mon, Sep 23, 2024 at 05:28:15PM +0200, Christoph Hellwig wrote:
> Split out a pice of logic from iomap_file_buffered_write_punch_delalloc
> that is useful for all iomap_end implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 13 ++-----------
>  include/linux/iomap.h  | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 11ea747228aeec..884891ac7a226c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1280,7 +1280,6 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  {
>  	loff_t			start_byte;
>  	loff_t			end_byte;
> -	unsigned int		blocksize = i_blocksize(inode);
>  
>  	if (iomap->type != IOMAP_DELALLOC)
>  		return;
> @@ -1289,16 +1288,8 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  	if (!(iomap->flags & IOMAP_F_NEW))
>  		return;
>  
> -	/*
> -	 * start_byte refers to the first unused block after a short write. If
> -	 * nothing was written, round offset down to point at the first block in
> -	 * the range.
> -	 */
> -	if (unlikely(!written))
> -		start_byte = round_down(pos, blocksize);
> -	else
> -		start_byte = round_up(pos + written, blocksize);
> -	end_byte = round_up(pos + length, blocksize);
> +	start_byte = iomap_last_written_block(inode, pos, written);
> +	end_byte = round_up(pos + length, i_blocksize(inode));
>  
>  	/* Nothing to do if we've written the entire delalloc extent */
>  	if (start_byte >= end_byte)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4ad12a3c8bae22..e62df5d93f04de 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -256,6 +256,20 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
>  	return &i->iomap;
>  }
>  
> +/*
> + * Return the file offset for the first unused block after a short write.

the first *unchanged* block after a short write?

> + *
> + * If nothing was written, round offset down to point at the first block in

Might as well make explicit which variable we're operating on:
"...round @pos down..."

--D

> + * the range, else round up to include the partially written block.
> + */
> +static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
> +		ssize_t written)
> +{
> +	if (unlikely(!written))
> +		return round_down(pos, i_blocksize(inode));
> +	return round_up(pos + written, i_blocksize(inode));
> +}
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> -- 
> 2.45.2
> 

