Return-Path: <linux-fsdevel+bounces-60211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD83B42B59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DDD4865EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB082E62A8;
	Wed,  3 Sep 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqdZ3xUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48972292B44;
	Wed,  3 Sep 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932728; cv=none; b=fCs4gcaMpHDL7NFnMZ34nn6htrO4JPiL5G8+EIY3MfK05+CFVydXBBu69lxNn501Pip8DcPlCxBCCB3Os3cmYva36UN6fxc2w061qMNei2h5npcbS/n0sO5m4L9Zd1tZdolQ0Poe0NGO9KP36VW/l3dPktLjj9cNigDRPqaFpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932728; c=relaxed/simple;
	bh=DP//M2BLXXrXBMYVBnIZRhaR3X8LZdrzqfX/SV15PaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE+bwNEhyfX1JQSougQgXvG/Melv9fdlT7LPscg252G/gfysIbj89Qe+akg4vrcrMR7SYFYDMxexWbUg6PCwVtsa+hhoDahN7I2L168Q3VPXe0Us5bCOC0krC77SjGhlcPoj0dRhlYqQDTMm37ubiay6cPqwzNdBLy/5d1Imzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqdZ3xUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17FAC4CEE7;
	Wed,  3 Sep 2025 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932727;
	bh=DP//M2BLXXrXBMYVBnIZRhaR3X8LZdrzqfX/SV15PaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqdZ3xUSCgfotzpwBAckCVJHdTw0MFLSmNwQjc1xQa5DbVMjo0nihI+TKxEzshvCA
	 nQARCJtf3/wB6MhyqwOxIz7uQ13WtyLbbwTuL0Gjroyl4gnGDmeDN4QDfzgGOrdvTs
	 DwBmw7aeA8Y8VKXPiZ+iZIVltgB4W3LfPYW7mJyW0Ruysgib6x4y92nGwwVlllBU5R
	 vpemnD9hfLfZuIPvBWoWWaEoqcJxIJf1pSaVJNtKrOc7mv3m68n5gixYd59LgCBUcC
	 ddflzfF+0n8sJVKMFnHOUCMBP72vXpT7gIBVpn4FDQWBPF4QPKOEclY/8SWSHxN0kV
	 y/svqgDd+fAAg==
Date: Wed, 3 Sep 2025 13:52:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/16] iomap: add iomap_start_folio_read() helper
Message-ID: <20250903205207.GR1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-11-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:21PM -0700, Joanne Koong wrote:
> Move ifs read_bytes_pending addition logic into a separate helper,
> iomap_start_folio_read(), which will be needed later on by user-provided
> read callbacks (not yet added) for read/readahead.This is the
> counterpart to the already currently-existing iomap_finish_folio_read().

Looks ok but aren't your new fuse functions going to need
iomap_start_folio_read?  In which case, don't they need to be outside of
#ifdef CONFIG_BLOCK?  Why not put them there and avoid patch 11?

Eh whatever the end result is the same
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a3a9b6146c2f..6a9f9a9e591f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -324,6 +324,17 @@ struct iomap_readfolio_ctx {
>  };
>  
>  #ifdef CONFIG_BLOCK
> +static void iomap_start_folio_read(struct folio *folio, size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	if (ifs) {
> +		spin_lock_irq(&ifs->state_lock);
> +		ifs->read_bytes_pending += len;
> +		spin_unlock_irq(&ifs->state_lock);
> +	}
> +}
> +
>  static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  		size_t len, int error)
>  {
> @@ -361,18 +372,13 @@ static void iomap_read_folio_range_async(struct iomap_iter *iter,
>  {
>  	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> -	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	loff_t length = iomap_length(iter);
>  	struct bio *bio = iter->private;
>  	sector_t sector;
>  
>  	ctx->folio_unlocked = true;
> -	if (ifs) {
> -		spin_lock_irq(&ifs->state_lock);
> -		ifs->read_bytes_pending += plen;
> -		spin_unlock_irq(&ifs->state_lock);
> -	}
> +	iomap_start_folio_read(folio, plen);
>  
>  	sector = iomap_sector(iomap, pos);
>  	if (!bio || bio_end_sector(bio) != sector ||
> -- 
> 2.47.3
> 
> 

