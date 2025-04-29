Return-Path: <linux-fsdevel+bounces-47604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137D5AA0FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D121662D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CEA21ADB4;
	Tue, 29 Apr 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHrYG0LS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A48218EAB;
	Tue, 29 Apr 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938431; cv=none; b=bI9JJ7y3oNEPtJCJ8ZfC7hUawfvjm+etilBL10whtHQaoGw4jxGprtbuOlkc/Bb9dtvevbSQPgyA9/ZOqwPInrUjiYpv5HWdnTSqHJ9YgPdcn9hBaYGVlQ9wpPdO9FtS3TrV2zDDF+EVZXOZjjLkzASg3cw6VHvQ8+JEdpRxnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938431; c=relaxed/simple;
	bh=80oIUsHpv+Tf57N6ZwfsoIQUoCwZ9ddJyskhAtcRR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXXAjLjMJ/Pt/bgoptRUrKmojTyOpeXxmtnjlKhVh8mSKhgmatyeHI8K/ozWfjI3hC6MUZQItOb5lqrJXazINeVWPkUb+q2VgdIkG+kUNs6DkdNeDYZultuZ1UeKVS/9DxeKppq7PdjZQ6TKAgTnCBSdEYnqMo3dO1bj4Y1dtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHrYG0LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A55C4CEE3;
	Tue, 29 Apr 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938430;
	bh=80oIUsHpv+Tf57N6ZwfsoIQUoCwZ9ddJyskhAtcRR5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHrYG0LSGsB/fuoyy6PpxGgxDr1vXVUS7IBmNAwJN0px/6XFMrBwK3kvugCVmDmV1
	 BTVoj/U+pKr1lc0ZnX/fehwYyK6Ag03yivcM33Madc+jd+25LOnl5xRGl5yw/qYPVB
	 gqJDP83J/6oeK1UCvV0Gw88FLB42SvxFUqvNZSGZQ7wpZSLOJfMyByRKdVJesAYkwN
	 xbdpq2btXh4NKtvEDRi2TwV/xn1/98a4ooVZo+GDtET4Tg0+lxeu426fyXGUAEIwh7
	 wDMU6/+5/tOgl2qwiwJYYSfcHOPYbnRzRymuO90DawKK0qHmEV93Ie3xWUK6AsdOJB
	 W+IWNJ8s6wlYQ==
Date: Tue, 29 Apr 2025 07:53:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 12/17] xfs: simplify xfs_rw_bdev
Message-ID: <20250429145350.GW25675@frogsfrogsfrogs>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422142628.1553523-13-hch@lst.de>

On Tue, Apr 22, 2025 at 04:26:13PM +0200, Christoph Hellwig wrote:
> Delegate to bdev_rw_virt when operating on non-vmalloc memory and use
> bio_add_vmalloc to insulate xfs from the details of adding vmalloc memory
> to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bio_io.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
> index fe21c76f75b8..98ad42b0271e 100644
> --- a/fs/xfs/xfs_bio_io.c
> +++ b/fs/xfs/xfs_bio_io.c
> @@ -18,42 +18,36 @@ xfs_rw_bdev(
>  	enum req_op		op)
>  
>  {
> -	unsigned int		is_vmalloc = is_vmalloc_addr(data);
> -	unsigned int		left = count;
> +	unsigned int		done = 0, added;
>  	int			error;
>  	struct bio		*bio;
>  
> -	if (is_vmalloc && op == REQ_OP_WRITE)
> -		flush_kernel_vmap_range(data, count);
> +	op |= REQ_META | REQ_SYNC;
> +	if (!is_vmalloc_addr(data))
> +		return bdev_rw_virt(bdev, sector, data, count, op);
>  
> -	bio = bio_alloc(bdev, bio_max_vecs(left), op | REQ_META | REQ_SYNC,
> -			GFP_KERNEL);
> +	bio = bio_alloc(bdev, bio_max_vecs(count), op, GFP_KERNEL);
>  	bio->bi_iter.bi_sector = sector;
>  
>  	do {
> -		struct page	*page = kmem_to_page(data);
> -		unsigned int	off = offset_in_page(data);
> -		unsigned int	len = min_t(unsigned, left, PAGE_SIZE - off);
> -
> -		while (bio_add_page(bio, page, len, off) != len) {
> +		added = bio_add_vmalloc(bio, data + done, count - done);
> +		if (!added) {
>  			struct bio	*prev = bio;
>  
> -			bio = bio_alloc(prev->bi_bdev, bio_max_vecs(left),
> +			bio = bio_alloc(prev->bi_bdev,
> +					bio_max_vecs(count - done),
>  					prev->bi_opf, GFP_KERNEL);
>  			bio->bi_iter.bi_sector = bio_end_sector(prev);
>  			bio_chain(prev, bio);
> -
>  			submit_bio(prev);
>  		}
> -
> -		data += len;
> -		left -= len;
> -	} while (left > 0);
> +		done += added;
> +	} while (done < count);
>  
>  	error = submit_bio_wait(bio);
>  	bio_put(bio);
>  
> -	if (is_vmalloc && op == REQ_OP_READ)
> +	if (op == REQ_OP_READ)
>  		invalidate_kernel_vmap_range(data, count);
>  	return error;
>  }
> -- 
> 2.47.2
> 
> 

