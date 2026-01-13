Return-Path: <linux-fsdevel+bounces-73381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6ED173F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDC9E30090DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EE37FF62;
	Tue, 13 Jan 2026 08:20:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340537C11D;
	Tue, 13 Jan 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292444; cv=none; b=dZEr9BPyFpw7Mt50nz4CGsvQdJYY4JzAXUe1xbwGJ253RYoZy/B0eULXBP2od/v99IFjwYCiqlpA8Rgo6mx2k2wPC9ljJVEimY0isxvDI3zf3gG8zpFvBBDCl1Rsze34rO9Li8Du23NqOk//glKHmagbWbY1B28r61Dn68d8Yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292444; c=relaxed/simple;
	bh=ItblKe1dpBNtiNh/o2vkCVVVDmYDKNW5eds1PrHJgOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/zWFbWHMHHxmZb9a5ugdIxt2bWQSIbzeIREyh9SDdgYY8GHMFVdRSmT9QLB+UBS/z4nzYX4zapR3GlMSGjiErL4wjtgHSpqxg6cgXAJ2LqmVlEgLW+pcb9pSMRup/IxUD+m2EI1H/VGs7EVep8YCRSzICNrAFQZADD/9j55BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DEA34227AA8; Tue, 13 Jan 2026 09:20:39 +0100 (CET)
Date: Tue, 13 Jan 2026 09:20:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de
Subject: Re: [PATCH v2 10/22] xfs: disable direct read path for fs-verity
 files
Message-ID: <20260113082039.GE30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <6rsqoybslyv6cguyk4usq5k2noetozrj3k67ygv5ko5fc57lvn@zv67vcnds7ts>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6rsqoybslyv6cguyk4usq5k2noetozrj3k67ygv5ko5fc57lvn@zv67vcnds7ts>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 03:51:03PM +0100, Andrey Albershteyn wrote:
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if ((iocb->ki_flags & IOCB_DIRECT) && !fsverity_active(inode))
>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {
> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared (see
> +		 * generic_file_read_iter())
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
>  		ret = xfs_file_buffered_read(iocb, to);
> +	}

I think this might actuall be easier as:

	if (fsverity_active(inode))
		iocb->ki_flags &= ~IOCB_DIRECT;

	...
	<existing if/else>


