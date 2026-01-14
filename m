Return-Path: <linux-fsdevel+bounces-73643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F2D1D525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0B40307E6C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDC3803C1;
	Wed, 14 Jan 2026 08:58:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1318194AD7;
	Wed, 14 Jan 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381117; cv=none; b=pxS5S+qrJDc8Vlb+lNJT3lPS+SDOcWHuih+WW63qffPr4W2x7jxFsXRR7ivLat/vpOBkH+/zC+bbfK+jBrj645/mD8Kz34PD93g6MQPt4TISsp/kATP/w4qbEclcMdq07Jzp0SYRZD17m1HO+iMzIeN5/ohnnCsCOzsC00jEmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381117; c=relaxed/simple;
	bh=n6GOFMrndcTCYHv9NVk1Fnmc+p05mBnVXmgbVDedAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzkS7IMq/pIOJRMQtYy85e+VpHk1Qc82y0jn7XLccw1GCOqMsoG8MTko1eT3GAkwYKwJVEeZnEKCMehyXT2cV4+E0OVnx4V1cjUTirigRJIG4pQ9uHCrYrUzQXfLQXbOf5oEYpYPNoIm1ZyrvjzwBxJvlhNEDDL3jdr8zevAFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 38F83E0267;
	Wed, 14 Jan 2026 09:58:23 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 14 Jan 2026 09:58:22 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ak: fuse: fix premature writetrhough request for large
 folio
Message-ID: <aWdYxTEO29S91qp-@fedora.fritz.box>
References: <20260114055615.17903-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114055615.17903-1-jefflexu@linux.alibaba.com>


Hi Jingbo,

On Wed, Jan 14, 2026 at 01:56:15PM +0800, Jingbo Xu wrote:
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
> 
> Fix this by eliminating page offset entirely and use folio offset
> instead.
> 
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/file.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 625d236b881b..6aafb32338b6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  {
>  	struct fuse_args_pages *ap = &ia->ap;
>  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
> -	unsigned offset = pos & (PAGE_SIZE - 1);
>  	size_t count = 0;
>  	unsigned int num;
>  	int err = 0;
> @@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		folio_offset = offset_in_folio(folio, pos);
>  		bytes = min(folio_size(folio) - folio_offset, num);
>  
>  		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
> @@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		count += tmp;
>  		pos += tmp;
>  		num -= tmp;
> -		offset += tmp;
> -		if (offset == folio_size(folio))
> -			offset = 0;
>  
>  		/* If we copied full folio, mark it uptodate */
>  		if (tmp == folio_size(folio))
> @@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  			ia->write.folio_locked = true;
>  			break;
>  		}
> -		if (!fc->big_writes || offset != 0)
> +		if (!fc->big_writes)
> +			break;
> +		if (folio_offset + tmp != folio_size(folio))
>  			break;
>  	}
>  
> -- 
> 2.19.1.6.gb485710b
> 
> 


I think this might have been an oversight when moving from pages to folios.

Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>


