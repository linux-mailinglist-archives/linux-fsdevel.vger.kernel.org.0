Return-Path: <linux-fsdevel+bounces-40677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EDA2667F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB58D18856E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55020FAAC;
	Mon,  3 Feb 2025 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRNTge5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA601F92A;
	Mon,  3 Feb 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621341; cv=none; b=kdgDodpYo5QvDGkC68beJZ0vwcmroZx8tlniwWsdPrQFLVF9H52LiWQA7zQ0EFgy1y5Yy1bHp2U5A0X+vjiExj5Tymue62VpvtJOBT8rAQC5qzDFEQoxxN/ob/SFv+TZHEDSVnoAArJPzD4+o0r0wIXkm1ayG7LjSSVoAKYbmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621341; c=relaxed/simple;
	bh=cOIPZ00WnhVcRBQG8iFWSAK4WXyNXDCdkc4Z7k1C1xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2lblgH/46DCwxAfQPixbQ1kPF8YrzMG0xdDUWNi9LBSsX2Y8h4HtcPW3m7xYhdZSQwDl3zO3KaLkTDPifMPne8EG4p9fGvTXog/AG5mOO8LQt5k1nYQpXq5IGh3ahHhmA5wbJa+ZoL4QD525lYIZkcCCDmFEtZHcXyZXgdaNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRNTge5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D572CC4CED2;
	Mon,  3 Feb 2025 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621340;
	bh=cOIPZ00WnhVcRBQG8iFWSAK4WXyNXDCdkc4Z7k1C1xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRNTge5NfbaKC34O9THHtAgRuQGTt6lxVS+QFTMBoZoR8Mo+ZxS8ulSWaN0eXIoZk
	 zxqwkk9whELF/9PF/D+K0sknlWZUHMlo4lt4qO7IuK8ZPR+ezjXNi0ioIzBZ9t/SHs
	 zmtyzES2hUPXDagMXHWTS2gAxdyiSDWao9eTVH44s0oEpw9ttZBN62BlrqtUJSYG07
	 bmgc+iy30BvHMn3jefmADUnlBq0TjdvAFyDUhCM+4z5FqOL6GwQrmaj9sm10HucNy3
	 MU0Gp7jRIinMV+ZLPlfiukokwnlpppzj+X+g63QNPT992CjZhgRCDPbZKARks5Ebp+
	 pxLu/xc/H3v7Q==
Date: Mon, 3 Feb 2025 14:22:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/7] iomap: limit buffered I/O size to 128M
Message-ID: <20250203222220.GD134507@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-6-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:09AM +0100, Christoph Hellwig wrote:
> Currently iomap can build extremely large bios (I've seen sizes
> up to 480MB).  Limit this to a lower bound so that the soon to
> be added per-ioend integrity buffer doesn't go beyond what the
> page allocator can support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 06990e012884..71bb676d4998 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -456,6 +456,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	sector = iomap_sector(iomap, pos);
>  	if (!ctx->bio ||
>  	    bio_end_sector(ctx->bio) != sector ||
> +	    ctx->bio->bi_iter.bi_size > SZ_128M ||

I imagine this is one of the XXX parts, but we probably shouldn't limit
the bios for !pi filesystems that won't care.

--D

>  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
>  		if (ctx->bio)
>  			iomap_read_submit_bio(iter, ctx);
> @@ -1674,6 +1675,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>  		u16 ioend_flags)
>  {
> +	if (wpc->ioend->io_bio.bi_iter.bi_size > SZ_128M)
> +		return false;
>  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
>  	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> -- 
> 2.45.2
> 
> 

