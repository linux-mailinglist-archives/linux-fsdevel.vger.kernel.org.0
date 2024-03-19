Return-Path: <linux-fsdevel+bounces-14839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DB88068E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713101F22977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B042A81;
	Tue, 19 Mar 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9V208Bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51340848;
	Tue, 19 Mar 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882530; cv=none; b=jB3Ch49lOKVqf4V0hBGIgsHjMce8EGDMoEnDjByKA++5aOjAM9D3so2qqIBaaFm0VZgW4NGzwk24yKfuKO3ACeBKPPHP4J3/wdrldMp5S9lQE28n2aXyDPXHD+1S9w5U6gjyK8VXm18/AGhEVBVDyAt2+SF6YhMGadlEnLyNdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882530; c=relaxed/simple;
	bh=KHWCCVBCSz3OsrVItaSDJ3IohJcPE3aaz3WKW/4aJp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/LlEqAefLXJ61qLcJWc2NvYdaB2GK2UNjhprhYVFSh7Km12yfkBcOGlxXeVo89uV+SXD3teW270ycKTLBp+aRgB2hC4910GNp/UyE1n/MwzRfuNgdwbV9WFPvJI/8eXbS0fHr2271NyUTAWAsDb/cWBmnubKo4hD5CfJ48m4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9V208Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC2CC433C7;
	Tue, 19 Mar 2024 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882529;
	bh=KHWCCVBCSz3OsrVItaSDJ3IohJcPE3aaz3WKW/4aJp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9V208BqBNStOLy6e8gC1pFtC8KqT758A93xDnbzGtPv+PHsiZ8iIsbi+T5oOAxZP
	 vEcKZNXeaTX+f7yMIfZh2XGqSsTdK900idwPLl9xSrjm34SygTG74uR2EU2PuLRC3B
	 ym/K43YkTR8hVhH4wkZndhrm6xfYWbJktDzn2/hLcj5xToe7dAD4p59Fmn1hI8Geyc
	 x+lv2OUh3pIwJhyPdde/HWgENgmwqH7yQSxzTc0XIy5cEygu4GfS2mFGv/hB75VbjZ
	 2t8hsYtrS0Z6OS1YLG6eG5WjukKYbAbM2OgdpdsXVY/+/aMuGMpuVcL7HCU1EsAypO
	 dgUuywfedgwbw==
Date: Tue, 19 Mar 2024 14:08:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 9/9] iomap: do some small logical cleanup in buffered
 write
Message-ID: <20240319210849.GN1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-10-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:11:02AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since iomap_write_end() can never return a partial write length, the
> comperation between written, copied and bytes becomes useless, just

  comparison

> merge them with the unwritten branch.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

With the spelling error fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 004673ea8bc1..f2fb89056259 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -937,11 +937,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  		if (old_size < pos)
>  			pagecache_isize_extended(iter->inode, old_size, pos);
> -		if (written < bytes)
> -			iomap_write_failed(iter->inode, pos + written,
> -					   bytes - written);
> -		if (unlikely(copied != written))
> -			iov_iter_revert(i, copied - written);
>  
>  		cond_resched();
>  		if (unlikely(written == 0)) {
> @@ -951,6 +946,9 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> +			iomap_write_failed(iter->inode, pos, bytes);
> +			iov_iter_revert(i, copied);
> +
>  			if (chunk > PAGE_SIZE)
>  				chunk /= 2;
>  			if (copied) {
> -- 
> 2.39.2
> 
> 

