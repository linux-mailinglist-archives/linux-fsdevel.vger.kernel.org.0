Return-Path: <linux-fsdevel+bounces-31222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56662993452
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A381C2276C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D981DC045;
	Mon,  7 Oct 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dojKfxVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A135338D;
	Mon,  7 Oct 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320537; cv=none; b=Hf6TdDScqRgkDuZitR15O0MzSZr/ZFVjFGw/DhcDaKaGp2sN7bOLLhW0zfIZJtRzUQlbkpEM1t+QGB5VsxqQDaJ2/ZaOw5fnp5nQWqx/bsFd1DyBYaYH46rWJmdh2KiP2VXpyRGrXwYB3VNC9D6OSYWz5BxFdRbcrV5fkdob6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320537; c=relaxed/simple;
	bh=wAcQZUYR2X+U9mQnYI6Nw7qul/vVksbDqUcIiTCow7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJYCuJZ7U/0IDP6AtHNTFPBqdPjNgYQLfl6EHHyAqO68Tc32Aeo3ctlw1ThSxLHMf1BS4grnMqVbiN/iVLa+PfNovygHCxuG/l2mj/XqGqJ57LEkKpuHK8+VU5JGwueAX5dFefkwVl5HnVLTkY7YAXG5v1paNBuwPZObp67Zw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dojKfxVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A34C4CEC6;
	Mon,  7 Oct 2024 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320537;
	bh=wAcQZUYR2X+U9mQnYI6Nw7qul/vVksbDqUcIiTCow7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dojKfxVDeQKLrEqv1GEKYDiZmXATDi3sJWsFxNiZDIypv2fGdTTJrFxJuwt0hI55R
	 Kh0myqpGe3iAZksI4c8RJXhJH+dIeU1cMzc29FqeYeWzT7hq8HB5amaHHQxT/R0lEa
	 AyACcOuwMEqo45+fXho8zaWD/BRuovdRhCPduEKU6FT14jcQr78vKE0dJaATWSrI8J
	 /oSHAGRutKEe7rv7s6MKLZcsBzAWJecisT3WNvKr+3MA9cH6vxWbmKV2Qix8CHE63/
	 /1CaTpYVgATc/o5r3F0Cved9rB9jW3n+nKCyH0iiVvafDwX58G5Vxq+QMx9iScQDDn
	 +hjkWQNijoY9Q==
Date: Mon, 7 Oct 2024 10:02:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/12] iomap: include iomap_read_end_io() in header
Message-ID: <20241007170217.GD21836@frogsfrogsfrogs>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b608329aef0841544f380acede9252caf10a48c6.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b608329aef0841544f380acede9252caf10a48c6.1728071257.git.rgoldwyn@suse.com>

On Fri, Oct 04, 2024 at 04:04:31PM -0400, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap_read_end_io() will be used BTRFS after it has completed the reads
> to handle control back to iomap to finish reads on all folios.

That probably needs EXPORT_SYMBOL_GPL if btrfs is going to use it,
right?

--D

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  include/linux/iomap.h  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d007b4a8307c..0e682ff84e4a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -326,7 +326,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  		folio_end_read(folio, uptodate);
>  }
>  
> -static void iomap_read_end_io(struct bio *bio)
> +void iomap_read_end_io(struct bio *bio)
>  {
>  	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f876d16353c6..7b757bea8455 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -280,6 +280,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
>  		const struct iomap_read_folio_ops *);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
>  		const struct iomap_read_folio_ops *);
> +void iomap_read_end_io(struct bio *bio);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> -- 
> 2.46.1
> 
> 

