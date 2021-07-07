Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBD3BE043
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGGAbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 20:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGAbH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C14761CAC;
        Wed,  7 Jul 2021 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625617708;
        bh=lH95/na/HZ5OGpE3O9cwJoBo9Xs9qxACoJL0KKv+lH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTiaeRAeIRQP7wvzvJj+DB6GNBBWQE+1ob3ORlrBvxXQkn129HxbcVJ4chxtC1gDX
         ZcHDjsGruiDoj5LGB4olFGVnYLpzYIC+aj4sh/bOzISEfoPYlj2GopwJRz0wEr+o/s
         kSzUBr/0lZOl6Sirh1Ysq4i5x76f+okM2X1ZiLVtz8hP5Ru2ZeU4hFBvLk8HO9E5A5
         aqTz2+c44C9JCgPnmbBv1nEJQcH8l4yTHmnU3WKMcJ/4/P36lmhXJm9WMh+HlifA4O
         zwXkt6RlVi+ULtDF81ycNIOKdPoLgV5UAXcCrlIt8VEtX8NU2LWD2e4EwTeKesG7Uj
         Lzfqwml01jlmQ==
Date:   Tue, 6 Jul 2021 17:28:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Leizhen <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] iomap: remove the length variable in iomap_seek_data
Message-ID: <20210707002827.GI11588@locust>
References: <20210706050541.1974618-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706050541.1974618-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 06, 2021 at 07:05:40AM +0200, Christoph Hellwig wrote:
> The length variable is rather pointless given that it can be trivially
> deduced from offset and size.  Also the initial calculation can lead
> to KASAN warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/seek.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index dab1b02eba5b7f..50b8f1418f2668 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -83,27 +83,23 @@ loff_t
>  iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
>  {
>  	loff_t size = i_size_read(inode);
> -	loff_t length = size - offset;
>  	loff_t ret;
>  
>  	/* Nothing to be found before or beyond the end of the file. */
>  	if (offset < 0 || offset >= size)
>  		return -ENXIO;
>  
> -	while (length > 0) {
> -		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
 -				  &offset, iomap_seek_data_actor);
> +	while (offset < size) {
> +		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
> +				  ops, &offset, iomap_seek_data_actor);
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
> -			break;
> -
> +			return offset;
>  		offset += ret;
> -		length -= ret;
>  	}
>  
> -	if (length <= 0)
> -		return -ENXIO;
> -	return offset;
> +	/* We've reached the end of the file without finding data */
> +	return -ENXIO;
>  }
>  EXPORT_SYMBOL_GPL(iomap_seek_data);
> -- 
> 2.30.2
> 
