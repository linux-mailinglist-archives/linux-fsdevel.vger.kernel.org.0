Return-Path: <linux-fsdevel+bounces-29978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5398481C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1141F22568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7831AB50C;
	Tue, 24 Sep 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb2cLdSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760E224D7;
	Tue, 24 Sep 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189893; cv=none; b=ik+SkYdzUHEVHRwxxDYSLxdra5hyeKHB6cFNSn58sSOV1+6eN1OANOXwKt0+c3kYtOilAnTwC7+yDQeCC/e21EKvn4uIhxGx1ROn2l+b4yWZynK8sOwaOBk+zA2r1c2YtrGTdI6OZzbFqunWpqHbS0PhTKzKexkjGNfpIDsEQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189893; c=relaxed/simple;
	bh=MI25PDoNQNQAGuDXxp5ykf0CfZuXC7UlQqX80fhpPhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a77ArfXDDATFAV/eieLEjx8is6oujeBg88RPXIlf6TU1E9gPaXtcn5+yzXgME4g8BlBP2NSaADqXeE3Bn7xetk3xAmDGZmrpfosOZ3/PsJ6/+pl3qRHP6VJCjGyHQgJjv9dsBX3VLFBFJ4B+KV4e/TlIcO8AedXTIWNCpHloIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb2cLdSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656BC4CEC4;
	Tue, 24 Sep 2024 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727189892;
	bh=MI25PDoNQNQAGuDXxp5ykf0CfZuXC7UlQqX80fhpPhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hb2cLdSBnv578wEZWTTmHfDEbgqcRoos6cXnte/Cn2b6QP7cJRcrljZ9xWkJRqySW
	 0eRZH35ad2bnkzjjLwFf+yh1OXYfnOEW1o645q6KeWTlcuezZrX/y+w8ta9dFAHGOg
	 9kWIRjA4Ie3zCTj6IaSEuuDDIR6LZ1N53SaXE5qyu3UJPW2/hPsTBV9NnrCT/LrcNa
	 cZY/NNd60/M6k2lUFzvAgopeRCor3e85LEWRScAosY4GimcZefDs7d5b/m2WaI0+7e
	 TxWoMcLc83ETcmjU0dwSOKeBEuAemCGms79EVGd+gRGPBqfu8E886pXOuEIjY08Yis
	 zyT+fU5KRN0hQ==
Date: Tue, 24 Sep 2024 07:58:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: factor out a iomap_last_written_block helper
Message-ID: <20240924145811.GG21853@frogsfrogsfrogs>
References: <20240924074115.1797231-1-hch@lst.de>
 <20240924074115.1797231-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924074115.1797231-2-hch@lst.de>

On Tue, Sep 24, 2024 at 09:40:43AM +0200, Christoph Hellwig wrote:
> Split out a pice of logic from iomap_file_buffered_write_punch_delalloc
> that is useful for all iomap_end implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> index 4ad12a3c8bae22..62253739dedcbe 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -256,6 +256,20 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
>  	return &i->iomap;
>  }
>  
> +/*
> + * Return the file offset for the first unchanged block after a short write.
> + *
> + * If nothing was written, round @pos down to point at the first block in
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
> 

