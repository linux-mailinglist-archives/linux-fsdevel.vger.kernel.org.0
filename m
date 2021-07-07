Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5233BE03E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 02:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGGA3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 20:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGA3M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07C2161CAC;
        Wed,  7 Jul 2021 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625617593;
        bh=WpTjUkzNrDuxkxbkTdGNf5TrdsK1ERehgHZsQ/4zXOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZb4ZeR0rsjwi1O9kqlGX/5vWWqMdUk3MZ7DqDn8yv72jFuMNpuT2poB34YTGNO50
         HnPeLVb7A+V5EsIc0zKmstxjGMdNXiRwO3/YVVb2FMbcOTQmVvVlCugAtag+9E0kfT
         VQgibNFjXAdQQeVj+V8ceSdSf/J+3ZX7YLHzurI14RCPy1hfmf1fl8xBgCuVt8s/QY
         iCIisnybDm0FVtPcq8S1aoBkAEfCeybiYXhytMVuUzVdQFfFR8DXH2Oe2FG7SR2nZi
         DMSx+AvYZwU0Sz1flb6S+ROTIGE4A1Sj1owRx1m9bEfcNO5BiMWm53snmmv/0XHW/J
         3jB+NdajChRLQ==
Date:   Tue, 6 Jul 2021 17:26:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Leizhen <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/2] iomap: remove the length variable in iomap_seek_hole
Message-ID: <20210707002632.GH11588@locust>
References: <20210706050541.1974618-1-hch@lst.de>
 <20210706050541.1974618-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706050541.1974618-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 06, 2021 at 07:05:41AM +0200, Christoph Hellwig wrote:
> The length variable is rather pointless given that it can be trivially
> deduced from offset and size.  Also the initial calculation can lead
> to KASAN warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>

Wooot!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/seek.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index 50b8f1418f2668..ce6fb810854fec 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -35,23 +35,20 @@ loff_t
>  iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
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
> -				  &offset, iomap_seek_hole_actor);
> +	while (offset < size) {
> +		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
> +				  ops, &offset, iomap_seek_hole_actor);
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
>  			break;
> -
>  		offset += ret;
> -		length -= ret;
>  	}
>  
>  	return offset;
> -- 
> 2.30.2
> 
