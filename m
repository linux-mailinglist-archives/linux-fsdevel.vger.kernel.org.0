Return-Path: <linux-fsdevel+bounces-36022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985EF9DAB61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 17:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35103B21456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302C200B82;
	Wed, 27 Nov 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUDaLtjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833D200132;
	Wed, 27 Nov 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723667; cv=none; b=VlT5Q8ZPWzc1m6zx6fNJNoMF4rgFdDAfnGtxcoGhD/wGnN1qHu1lPSMGDAO29/Gx623c6VJNcERpTdyybvxP0VOSdD2ZK5yteX0BneF5a1BEz4OPVv9NuUvoO0MwGjD2JF8T21C1WcmyLHFKpcCtiVkPYMVPZFkacrdLZcwOC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723667; c=relaxed/simple;
	bh=Nv9pIQoDfi7Kpe1iWmf4XvwI/LWj9yjmfxoToGMgadc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzUXYk/yDCr5s1eVKt1hWv7OaTWtzhJZ05MVKEWw+AJlaY2q1zMZopsRszaNvKXQMdiMeUrgMl5yfQB/l61+NRrHK5XdFBFoCwsslcXLZWb3Yr9BI0XYgonwuN4An8SVsOdjJZMWCyo2LgUnw/OfDYHnmHHYWiwJ1siBEUMGJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUDaLtjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD312C4CECC;
	Wed, 27 Nov 2024 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732723666;
	bh=Nv9pIQoDfi7Kpe1iWmf4XvwI/LWj9yjmfxoToGMgadc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUDaLtjjBCYzhP8Gm7SCsOjVqjERQP/T/4WMy1iIFa86sER5iqLLwGzm7c3rX7aDw
	 3Rq/h/6OfDmKfK8JMZmLz7Ii7N8WBcee+FRQ6OXvErFxaY81Fw6DIa47X9c0lg6xPY
	 pdKzKTGqMt+E9IRlQAmZg73ZmYm/EiUVFi/6ltLY2YnLzAjilBdMGctVV1n/zWbMDR
	 odZ8+LgFMMV/RUSRGjW0J65vKstOOKbh8h4CiAyYHXMsTB5PFFHpVapDEemvHe56v+
	 pmkd6KZDSvR99r/Lf5q2UFrfTFMMMHfMFHoCpcit4XILohCfffsgRru+aPxgXhUQa7
	 8GetImWv1Pfrg==
Date: Wed, 27 Nov 2024 08:07:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 2/2] xfs: clean up xfs_end_ioend() to reuse local
 variables
Message-ID: <20241127160746.GX1926309@frogsfrogsfrogs>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <20241127063503.2200005-2-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127063503.2200005-2-leo.lilong@huawei.com>

On Wed, Nov 27, 2024 at 02:35:03PM +0800, Long Li wrote:
> Use already initialized local variables 'offset' and 'size' instead
> of accessing ioend members directly in xfs_setfilesize() call.
> 
> This is just a code cleanup with no functional changes.
> 
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Pretty straightforward cleanup there,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v4->v5: No changes
>  fs/xfs/xfs_aops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 559a3a577097..67877c36ed11 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -131,7 +131,7 @@ xfs_end_ioend(
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
>  
>  	if (!error && xfs_ioend_is_append(ioend))
> -		error = xfs_setfilesize(ip, ioend->io_offset, ioend->io_size);
> +		error = xfs_setfilesize(ip, offset, size);
>  done:
>  	iomap_finish_ioends(ioend, error);
>  	memalloc_nofs_restore(nofs_flag);
> -- 
> 2.39.2
> 

