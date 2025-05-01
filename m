Return-Path: <linux-fsdevel+bounces-47867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84204AA6461
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA05E3AC126
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4ED23770D;
	Thu,  1 May 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llys9i9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB62144C9;
	Thu,  1 May 2025 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129064; cv=none; b=ZNcGwwj9CItk70Olj+2j/qoV3CHi4AR9nzAjxzpWJGpKfQyoJLhbQYqeKmLkcLMYzuZ1jdN24HoPTWzOiwA/e3HSA/M2E/ymiQzV+dk/0BZ736hepBydJi6dm/AwT4XGhOykfOwgs+xsfqhaEmPrtPMsCLo0/V8K4cGIZ71Di40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129064; c=relaxed/simple;
	bh=2TRZHURBJeTYr0ZgIhVGXPTqVaFa+GK5URzfaOJaUhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZiwNcDHoo+QQmzl1hTgmmNlGWMM8eJ7i3x23hdejmrPcVgC/Yz7ptv72tnKYG2DKaLlXonrm1jMb+woWunXL+rWXCJmrtUKfOa/ebs1XaOslMy3tZGh6gS7tT+wHomzEmEyNcalsGLY5Rc+Dkuh4Dd5DrIH8yqcMcxMfvBRg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llys9i9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02E3C4CEE3;
	Thu,  1 May 2025 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129063;
	bh=2TRZHURBJeTYr0ZgIhVGXPTqVaFa+GK5URzfaOJaUhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llys9i9FxQiQ3K+yejzzO5QU04hHAI1hSy40XuklJtjWPsSQpQpXh/YF+zY6RaWnK
	 BC3AUIyn+Vqyid/kjSmZbJtt/SARYP1b9qbW9AS2QRja9BmUaQrBkycI7VPN130CY3
	 20lg8yw8IPxmW0nkIe8mR/maye58XtQq7VRtN8bPBdJ4juG+7vjKZ5MY1jMXFCA5a4
	 44AENXaaRBt2NNdM8Mrb/1EeHNxqImlraFFQDQqAWr892fNjFusnSCHxhz/xFBZ4Lz
	 a9ramlG4s1qSgaz6OXfWN3RXM6B/E7aCyn9wpRbxjl1QYTQv3bRijN99dIN3mx1pfz
	 uozYg6My1k6zg==
Date: Thu, 1 May 2025 12:51:03 -0700
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
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/19] xfs: simplify xfs_buf_submit_bio
Message-ID: <20250501195103.GD25675@frogsfrogsfrogs>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-16-hch@lst.de>

On Wed, Apr 30, 2025 at 04:21:45PM -0500, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
> to insulate xfs from the details of adding vmalloc memory to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_buf.c | 43 ++++++++-----------------------------------
>  1 file changed, 8 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 1a2b3f06fa71..f2d00774a84f 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1333,45 +1333,18 @@ static void
>  xfs_buf_submit_bio(
>  	struct xfs_buf		*bp)
>  {
> +	unsigned int		len = BBTOB(bp->b_length);
> +	unsigned int		nr_vecs = bio_add_max_vecs(bp->b_addr, len);
>  	unsigned int		map = 0;
>  	struct blk_plug		plug;
>  	struct bio		*bio;
>  
> -	if (is_vmalloc_addr(bp->b_addr)) {
> -		unsigned int	size = BBTOB(bp->b_length);
> -		unsigned int	alloc_size = roundup(size, PAGE_SIZE);
> -		void		*data = bp->b_addr;
> -
> -		bio = bio_alloc(bp->b_target->bt_bdev, alloc_size >> PAGE_SHIFT,
> -				xfs_buf_bio_op(bp), GFP_NOIO);
> -
> -		do {
> -			unsigned int	len = min(size, PAGE_SIZE);
> -
> -			ASSERT(offset_in_page(data) == 0);
> -			__bio_add_page(bio, vmalloc_to_page(data), len, 0);
> -			data += len;
> -			size -= len;
> -		} while (size);
> -
> -		flush_kernel_vmap_range(bp->b_addr, alloc_size);
> -	} else {
> -		/*
> -		 * Single folio or slab allocation.  Must be contiguous and thus
> -		 * only a single bvec is needed.
> -		 *
> -		 * This uses the page based bio add helper for now as that is
> -		 * the lowest common denominator between folios and slab
> -		 * allocations.  To be replaced with a better block layer
> -		 * helper soon (hopefully).
> -		 */
> -		bio = bio_alloc(bp->b_target->bt_bdev, 1, xfs_buf_bio_op(bp),
> -				GFP_NOIO);
> -		__bio_add_page(bio, virt_to_page(bp->b_addr),
> -				BBTOB(bp->b_length),
> -				offset_in_page(bp->b_addr));
> -	}
> -
> +	bio = bio_alloc(bp->b_target->bt_bdev, nr_vecs, xfs_buf_bio_op(bp),
> +			GFP_NOIO);
> +	if (is_vmalloc_addr(bp->b_addr))
> +		bio_add_vmalloc(bio, bp->b_addr, len);

I wonder, do we need a debug assertion on the return value?  AFAICT,
bio_add_max_vecs should result in a bio that's big enough to handle the
vmalloc area, but those could be famous last words. :P

Other than that, the code is much cleaner than before. :)

--D

> +	else
> +		bio_add_virt_nofail(bio, bp->b_addr, len);
>  	bio->bi_private = bp;
>  	bio->bi_end_io = xfs_buf_bio_end_io;
>  
> -- 
> 2.47.2
> 
> 

