Return-Path: <linux-fsdevel+bounces-32139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255769A1309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF86D285A35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E28215F44;
	Wed, 16 Oct 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlDNvqfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023C2144D7;
	Wed, 16 Oct 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108710; cv=none; b=bySFosnbvFTHYwyezJUtNWyULFfaDEiPx5NDhCl0bXXBHZmNOS20VUnzDW7o1L4QOqZeAzvUoOTrTzRbil+lif8h3W4mpkbSeiBbmRP6ILkmvmuMfumIiXuz7wcqgMMaglK+mVse/OZR20dXSxDC5k+h1yidCCojvRJKAeU3LOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108710; c=relaxed/simple;
	bh=bMwpcs2SRczDweRPV4nmYc0jDe8Yc0sgkXksF6iRfmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4xN8DllK+OsXB7mI3XoVzhjJBpTVkq9y1caLNygGzxKKl5TkKFViVmmjoXBxmU9xq3Q2qmaB1vkC7u3faflknvTpftjwSQF2X5ORRiOKMwh7kN2pwlnDtR0zQD7+msg5934t5UC1vg+0hARx3TuSyw7bmHLD/PDa8iQsv3VcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlDNvqfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D99C4CEC5;
	Wed, 16 Oct 2024 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729108709;
	bh=bMwpcs2SRczDweRPV4nmYc0jDe8Yc0sgkXksF6iRfmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlDNvqfwcIfv7WzlnB4dL9mmJS2OyvJcF/upno04lJAgRo0P6Zb0XoWAz9yxpEmCV
	 PkkbuQLbHg3I/FSo1Fh1hWxjGyyFb14DsBEOE8I13i2Pv24O35dXNcsiPnf/M0UukN
	 p0hQKMEV6q7F5eUevSvNaMTqr269NtHfCz9UeWEL/nC9IXU7MiluzhsegcyvIZ8+zQ
	 K12BSgzybo3GNPlBh0/catcyq14L52f/BgF4PMg5VK1M9WU4DVWsiVdoa7GErUh4UU
	 IUAAZnm6rtN60dkK8Po2UiZ4zQiwsTPTXPk1TSRGqiMJeapXfOcxPLB5jeE+p9EQek
	 uiuYKIBlaCC2g==
Date: Wed, 16 Oct 2024 12:58:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 3/8] block: Add bdev atomic write limits helpers
Message-ID: <20241016195829.GO21853@frogsfrogsfrogs>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100325.3534494-4-john.g.garry@oracle.com>

On Wed, Oct 16, 2024 at 10:03:20AM +0000, John Garry wrote:
> Add helpers to get atomic write limits for a bdev, so that we don't access
> request_queue helpers outside the block layer.
> 
> We check if the bdev can actually atomic write in these helpers, so we
> can avoid users missing using this check.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/blkdev.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50c3b959da28..c2cc3c146d74 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1674,6 +1674,22 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
>  	return true;
>  }
>  
> +static inline unsigned int
> +bdev_atomic_write_unit_min_bytes(struct block_device *bdev)
> +{
> +	if (!bdev_can_atomic_write(bdev))
> +		return 0;
> +	return queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
> +}
> +
> +static inline unsigned int
> +bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
> +{
> +	if (!bdev_can_atomic_write(bdev))
> +		return 0;
> +	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
> +}
> +
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
>  #endif /* _LINUX_BLKDEV_H */
> -- 
> 2.31.1
> 
> 

