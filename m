Return-Path: <linux-fsdevel+bounces-47868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1207AA6462
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B311782A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299F238141;
	Thu,  1 May 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG+SV22Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71323505B;
	Thu,  1 May 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129085; cv=none; b=QP37u8b6sPzujV9jFHD5XIVRJQtkDGfWrgYzra4eMhM2bAGFTAZGh8USWFlCahpXBbHAdtRsCG2RCexCfJO9QPPUF+XyB+CV4Hmt1hiH/d/fdxv2pI+ZnZmOUh2wwybBHfR92lIrwZTVqCbdzq/xbHLqNQgtVwvuUJhHt++EE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129085; c=relaxed/simple;
	bh=uXZdawltUFI3L98MRsHlI+D6UP5JkMQj6KDtyElkPGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdKZIDEAnIn3Ve7zoGYLpgmcSPWlRCd0oZ3W9rgHhqZUhGiV8iBi6PrV6xzancUynMYR1l3DL/1l6xDMkh86g1uGat85UROxJJHtGLW4a33nXoysbUvnneqnrqu/Z6P9x3qY5HFzG9KQiOeHBfmEhl2+j4UAo9oz0B7B3dEJs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG+SV22Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED081C4CEE3;
	Thu,  1 May 2025 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129085;
	bh=uXZdawltUFI3L98MRsHlI+D6UP5JkMQj6KDtyElkPGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZG+SV22YQhXytkJC7WGUulKjKgWNnrU52/j20Vj7shpt0wKG718KK7ultw+7MPTIM
	 WlHojzei79WD7+9WlBYMHQ/oLEHj44GxuQ2b5vcZfAUdaf6rYunHVKd+Hl9XULmiNj
	 q0p/q8oy9TpwTLT/ejWvbuP+7ep8dDujNc0IulixkEYeMU7oZP8EjILAjPj3V54MgT
	 i4jaT/FXOr9noE6FkWj7LsItfZqvCBEivOoodNdl1aw484wbCUCts1zwv5zwAOi5S/
	 Ifbcb7NvDYl3GY14XgG9322gaNVRSVqUTBXrUzUlzgCXSx3zE8GR5m/d7wevUhEc0B
	 9wD3vpETr60Xw==
Date: Thu, 1 May 2025 12:51:24 -0700
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
Subject: Re: [PATCH 17/19] xfs: simplify building the bio in xlog_write_iclog
Message-ID: <20250501195124.GE25675@frogsfrogsfrogs>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-18-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-18-hch@lst.de>

On Wed, Apr 30, 2025 at 04:21:47PM -0500, Christoph Hellwig wrote:
> Use the bio_add_virt_nofail and bio_add_vmalloc helpers to abstract
> away the details of the memory allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_log.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 980aabc49512..793468b4d30d 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1607,27 +1607,6 @@ xlog_bio_end_io(
>  		   &iclog->ic_end_io_work);
>  }
>  
> -static int
> -xlog_map_iclog_data(
> -	struct bio		*bio,
> -	void			*data,
> -	size_t			count)
> -{
> -	do {
> -		struct page	*page = kmem_to_page(data);
> -		unsigned int	off = offset_in_page(data);
> -		size_t		len = min_t(size_t, count, PAGE_SIZE - off);
> -
> -		if (bio_add_page(bio, page, len, off) != len)
> -			return -EIO;
> -
> -		data += len;
> -		count -= len;
> -	} while (count);
> -
> -	return 0;
> -}
> -
>  STATIC void
>  xlog_write_iclog(
>  	struct xlog		*log,
> @@ -1693,11 +1672,12 @@ xlog_write_iclog(
>  
>  	iclog->ic_flags &= ~(XLOG_ICL_NEED_FLUSH | XLOG_ICL_NEED_FUA);
>  
> -	if (xlog_map_iclog_data(&iclog->ic_bio, iclog->ic_data, count))
> -		goto shutdown;
> -
> -	if (is_vmalloc_addr(iclog->ic_data))
> -		flush_kernel_vmap_range(iclog->ic_data, count);
> +	if (is_vmalloc_addr(iclog->ic_data)) {
> +		if (!bio_add_vmalloc(&iclog->ic_bio, iclog->ic_data, count))
> +			goto shutdown;
> +	} else {
> +		bio_add_virt_nofail(&iclog->ic_bio, iclog->ic_data, count);
> +	}
>  
>  	/*
>  	 * If this log buffer would straddle the end of the log we will have
> -- 
> 2.47.2
> 
> 

