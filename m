Return-Path: <linux-fsdevel+bounces-35065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DC9D0A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C3BB233B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5414D2BD;
	Mon, 18 Nov 2024 07:08:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96973477;
	Mon, 18 Nov 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913693; cv=none; b=P1qqBr8m+R2hxPBfk4+vw10ewwNjTEUd9s013TOazHc4sjOuMgTHVxLGXf/foBWmGonEJWLq3N97d4i1y6SVWz5I4OgdbbGaDLcUA41kn5FwvuvcDrWCPHEqJgckJR1jNNH0s7eZBxLi+wTtDxN+KfIVc7Ad8H10L8VqNaXVK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913693; c=relaxed/simple;
	bh=2MjWzVhO3LoIoNwOPfZjNl8BYOQnIpzF/wwXC5X6mvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpPupvgKX/A3s2lZ9Zm4LM6WqPDyl9VEmZFEXzkeTJgZFg0wcb/gguy92xCMdVIAqBw8tQxB3AbM/EcpCD1yyETaargpsrJmn41jTFM8MDsn85qnlmrUyK8g3YuglOWUeVVb3QOvj+/EtuRwILBafk3A/RzvJ8BIE0gVVpVZ9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66A2F68B05; Mon, 18 Nov 2024 08:08:05 +0100 (CET)
Date: Mon, 18 Nov 2024 08:08:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: willy@infradead.org, hch@lst.de, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC 8/8] bdev: use bdev_io_min() for statx block size
Message-ID: <20241118070805.GA932@lst.de>
References: <20241113094727.1497722-1-mcgrof@kernel.org> <20241113094727.1497722-9-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113094727.1497722-9-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 13, 2024 at 01:47:27AM -0800, Luis Chamberlain wrote:
> The min-io is the minimum IO the block device prefers for optimal
> performance. In turn we map this to the block device block size.

It's not the block size, but (to quote the man page) 'the "preferred"
block size for efficient filesystem I/O'.  While the difference might
sound minor it actually is important.

> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3a5fd65f6c8e..4dcc501ed953 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1306,6 +1306,7 @@ void bdev_statx(struct path *path, struct kstat *stat,
>  			queue_atomic_write_unit_max_bytes(bd_queue));
>  	}
>  
> +	stat->blksize = (unsigned int) bdev_io_min(bdev);

No need for the cast.

>  	if (S_ISBLK(stat->mode))
> -		bdev_statx(path, stat, request_mask);
> +		bdev_statx(path, stat, request_mask | STATX_DIOALIGN);

And this is both unrelated and wrong.


