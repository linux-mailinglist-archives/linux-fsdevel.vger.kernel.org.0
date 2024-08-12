Return-Path: <linux-fsdevel+bounces-25701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9D94F541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C05B24A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9A188007;
	Mon, 12 Aug 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOXNhpXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D24187563;
	Mon, 12 Aug 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481353; cv=none; b=OYJLbPW8Y6iAdbtKl19YqomLqLpyXuKzhWJL7Geotrg8kHsrECOFQ9Cdyv/x+JwqZ//GbC6KN8KqolQPXRtDB1yoFu/SKaef5iA10aN3v1HHCnv4bX/zSbOpsRqGcvGu938t6j7MQ3tOW4nWhnL6HQrB1DFmUcaPyR8tpaPp780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481353; c=relaxed/simple;
	bh=RUNPCTPFaivJGckmyZWk/14TRobhI75SaZumaJuft/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/6uekaCizp22gCus86XBmwOg/ZRbCN+YWAFDvKw/E7YdnB8ycxPsb6eOVCjcSAtEQ8PRCKhTCuoFRbqDyAaKfrxW0ZlKJJZPKWmDo7GwvqTYSxdzZWTt4k6pOz8OyazwDaS5NyEmVQFw5YEYYnDYu42b4+fZe5FPtNDQm4JZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOXNhpXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9556FC4AF0C;
	Mon, 12 Aug 2024 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481352;
	bh=RUNPCTPFaivJGckmyZWk/14TRobhI75SaZumaJuft/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOXNhpXa3EgHPFde5FXP3a5z8AA+a7NAt6iZ3kltJ6zxMDu25lNeCFYE0km7bupOg
	 VBcUKy0FE+U0PrCkKT/CrkNXxZirVEKCmje+vmsb/GnIaXo3n73KKck/Xa2U8HGasp
	 5kbvs+P3U0vlMqKcCvMy+uAHvpR6+rtlfKhcq2OVq4sNbpigxtVh4ghcGULxdvHo7R
	 iqPJtua9fhk62kxJwLRHUhHpcWBFCAesXYxnqF4w80T0p/txZScKuoSwHMQCDswcKc
	 KedC5Ymq57TiKXpb3+wqfgcIJBCkvI9bQppSRIUjZUwXvrR9h42EZZhInbSGTF3YWf
	 kcwNP/Be2jWWg==
Date: Mon, 12 Aug 2024 09:49:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/6] iomap: don't mark blocks uptodate after partial
 zeroing
Message-ID: <20240812164912.GF6043@frogsfrogsfrogs>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-6-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:58PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In __iomap_write_begin(), if we unaligned buffered write data to a hole
> of a regular file, we only zero out the place where aligned to block
> size that we don't want to write, but mark the whole range uptodate if
> block size < folio size. This is wrong since the not zeroed part will
> contains stale data and can be accessed by a concurrent buffered read
> easily (on the filesystem may not hold inode->i_rwsem) once we mark the
> range uptodate. Fix this by drop iomap_set_range_uptodate() in the
> zeroing out branch.
> 
> Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Closes: https://lore.kernel.org/all/ZqsN5ouQTEc1KAzV@casper.infradead.org/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ac762de9a27f..96600405dbb5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -744,8 +744,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  					poff, plen, srcmap);
>  			if (status)
>  				return status;
> +			iomap_set_range_uptodate(folio, poff, plen);
>  		}
> -		iomap_set_range_uptodate(folio, poff, plen);

Don't we need to iomap_set_range_uptodate for the bytes that we zeroed
with folio_zero_segments?

--D

>  	} while ((block_start += plen) < block_end);
>  
>  	return 0;
> -- 
> 2.39.2
> 
> 

