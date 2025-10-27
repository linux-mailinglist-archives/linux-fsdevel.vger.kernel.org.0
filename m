Return-Path: <linux-fsdevel+bounces-65729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784DC0F345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F1F4F6C52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388B43019A3;
	Mon, 27 Oct 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFqLG/mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD230DEBF;
	Mon, 27 Oct 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581504; cv=none; b=fNvPcMKnvaHDbbGWFtlenIjmReoUfQVj1ZRxfCHPEabYOxC5tQPFqs15ZSMVouN7yw2o+tcv00tgsTDtMOqKXNvzu8pGdXMjr/Th4i3AtKYa1tD4P83J/u3/71mS2Dk/GJ1kEaeQGajYoNEt6MuUJV3JcMfcQU0h4FFYGS1M+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581504; c=relaxed/simple;
	bh=n/KA3TW2VOM4vmKlWkZg+acsfbMdLE+2guAVrupe1DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flcmgLoqVJRGUHsrgZP4WksDmMHma71y+Bpx4RNQdbkBLnE+IV62EuC8CQvFgwJpVlkNo2na6sd79xBBGZ4YT1x4CWr0y6F0G7oPzwC/XcBW3epZF0zouCPwRhUlrINdAbvc6nE/ufp3E31dqvQdEpPSN5YMB53Cex29Ev0IOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFqLG/mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C07C4CEF1;
	Mon, 27 Oct 2025 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581504;
	bh=n/KA3TW2VOM4vmKlWkZg+acsfbMdLE+2guAVrupe1DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFqLG/mcFg6diOCH8oP8d0s6FRBPEJLwAMJJZCuLuV1ZDwDfiEqFBGEQhFKTCgj6f
	 Hd+agCB/x+G/bfA2saTeaxBZpUAO35QZuwIbBI+uTYullZpoQ+zI3f+hdXEwxvfOkZ
	 g34Pzk1C990XJqnJP77kiNTVDMpTzvObP5gAfxgXWO4EqlCe+6q3RhM97/es7T0hzR
	 /OZNOxM09jjJt7SiRNW/1z5b0NTLl5YCwtyqIFJjqGhnLJNnl4iEY6ooRo6zNRZPfk
	 FyKJEAa06irTSyaVg0bOGlfNtp43KudgsdNq5FGewr04c79Bi2p09Pb+LM9CXYTsBp
	 f/ZOwPqk5SVBw==
Date: Mon, 27 Oct 2025 09:11:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] FIXUP: iomap: aligning to larger than fs block size
 doesn't make sense
Message-ID: <20251027161143.GT3356773@frogsfrogsfrogs>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135559.124072-3-hch@lst.de>

On Thu, Oct 23, 2025 at 03:55:43PM +0200, Christoph Hellwig wrote:
> All of the VFS and helpers assume that the file system block size must
> be larger or equal to the device block size.  So doing a max of both
> doesn't really make much sense.  Siplify the code in iomap_dio_bio_iter

                                   Simplify

> to do a simple if/else.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ce9cbd2bace0..8d094d6f5f3e 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -336,17 +336,19 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	int nr_pages, ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
> -	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
> +	unsigned int alignment;
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>  		return -EINVAL;
>  
>  	/*
> -	 * Align to the larger one of bdev and fs block size, to meet the
> -	 * alignment requirement of both layers.
> +	 * File systems that write out of place and always allocate new blocks
> +	 * need each bio to be block aligned as that's the unit of allocation.
>  	 */
>  	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> -		alignment = max(alignment, fs_block_size);
> +		alignment = fs_block_size;
> +	else
> +		alignment = bdev_logical_block_size(iomap->bdev);
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
> -- 
> 2.47.3
> 
> 

