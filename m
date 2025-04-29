Return-Path: <linux-fsdevel+bounces-47603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7BAA0FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71EA920A73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858721C197;
	Tue, 29 Apr 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsxr6no2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29E21A42C;
	Tue, 29 Apr 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938406; cv=none; b=INP8ZVwo1Jaw6LiKbt0kAZwudVdoX/ygSObRjsTwAD3vjlbuTpAFhLDQMChP5tDMGdmDnCspWqNYC/0xd+CmMyV4F2lv8rPmFL6ydw8kbs2rEg5LPUB9/F00Vii4MFqKvIECKGVD/wTc6WdkIAOwVjE96BQG35Yzqw3LPkaP/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938406; c=relaxed/simple;
	bh=vubdbnsnHfKy+rIrOM3B9U3Uq8p9rxcHh2wPGFm5ZmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/86A4bHyjEj+C/C2KkMJCQHOGN8y3TcDixe/7H6+bJbu+S5IWBIkwpmDmlqrnv3IPWk5XamEOmTgrQpCV7+IVWNB0JRErPuVFH7fkqWpxJXn7+9jDj+0VP34mF2WWu+an2exQQAOTCoTCuREReRGcxu8SyCyka8lrfE7sMd7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsxr6no2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A8DC4CEE3;
	Tue, 29 Apr 2025 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938405;
	bh=vubdbnsnHfKy+rIrOM3B9U3Uq8p9rxcHh2wPGFm5ZmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tsxr6no2sqTig7DfKnBSZWaq1XBwKiz+sJmah/Z64xNs2Tq56YK1KROWuxvk/bL49
	 FgMKfP2HBFad1ql/hzUNqi43pVeXqTe+UbaSTSufCq289q0dfSKir5ZOwtmiJ8R2P5
	 UeUUWZ8TLwsWx9HKvqhTDR8D/hzV4vdfp6WtgbWaSmauaIG35WJ1RcmGvcZUVS0dvI
	 VA8murp+5LwoUyTNHQAhQHTLsic2ifDHk8mz1wXHg4T/E7KkO9fIc132VRb+pQXsGA
	 tioUtpiP0LHEfgtTwcTbIoOOmuy1zSR82LEJOs8YoPYCDJletRdEgLwGLwyJyhdV6C
	 ALA2ZO+ITTUog==
Date: Tue, 29 Apr 2025 07:53:25 -0700
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
Subject: Re: [PATCH 11/17] xfs: simplify xfs_buf_submit_bio
Message-ID: <20250429145325.GV25675@frogsfrogsfrogs>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422142628.1553523-12-hch@lst.de>

On Tue, Apr 22, 2025 at 04:26:12PM +0200, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
> to insulate xfs from the details of adding vmalloc memory to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That reads much more cleanly now :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 1a2b3f06fa71..042a738b7fda 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1339,37 +1339,26 @@ xfs_buf_submit_bio(
>  
>  	if (is_vmalloc_addr(bp->b_addr)) {
>  		unsigned int	size = BBTOB(bp->b_length);
> -		unsigned int	alloc_size = roundup(size, PAGE_SIZE);
>  		void		*data = bp->b_addr;
> +		unsigned int	added;
>  
> -		bio = bio_alloc(bp->b_target->bt_bdev, alloc_size >> PAGE_SHIFT,
> -				xfs_buf_bio_op(bp), GFP_NOIO);
> +		bio = bio_alloc(bp->b_target->bt_bdev,
> +				howmany(size, PAGE_SIZE), xfs_buf_bio_op(bp),
> +				GFP_NOIO);
>  
>  		do {
> -			unsigned int	len = min(size, PAGE_SIZE);
> -
> -			ASSERT(offset_in_page(data) == 0);
> -			__bio_add_page(bio, vmalloc_to_page(data), len, 0);
> -			data += len;
> -			size -= len;
> +			added = bio_add_vmalloc(bio, data, size);
> +			data += added;
> +			size -= added;
>  		} while (size);
> -
> -		flush_kernel_vmap_range(bp->b_addr, alloc_size);
>  	} else {
>  		/*
>  		 * Single folio or slab allocation.  Must be contiguous and thus
>  		 * only a single bvec is needed.
> -		 *
> -		 * This uses the page based bio add helper for now as that is
> -		 * the lowest common denominator between folios and slab
> -		 * allocations.  To be replaced with a better block layer
> -		 * helper soon (hopefully).
>  		 */
>  		bio = bio_alloc(bp->b_target->bt_bdev, 1, xfs_buf_bio_op(bp),
>  				GFP_NOIO);
> -		__bio_add_page(bio, virt_to_page(bp->b_addr),
> -				BBTOB(bp->b_length),
> -				offset_in_page(bp->b_addr));
> +		bio_add_virt_nofail(bio, bp->b_addr, BBTOB(bp->b_length));
>  	}
>  
>  	bio->bi_private = bp;
> -- 
> 2.47.2
> 
> 

