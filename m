Return-Path: <linux-fsdevel+bounces-68886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63521C679DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0346C4E4940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033B2D6E72;
	Tue, 18 Nov 2025 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZlbCffLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C728D84F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445065; cv=none; b=J69Yh+fmPLIiobsnSJR1ihjWywIpAjvwr3p6iQ+GOKQFiBe1tsftrMV8Lo57eRFFc18CyLT4vQFafd9lttB4znmMzvu5MPJE/zsxzKeyfwtPyrSR9Q8ryIx93vAKssnMhVsxKIduEgdR7YqCNrvrgSCeOTWf2X0x+E2BtMWP2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445065; c=relaxed/simple;
	bh=39yKZN7zb/2V7bvL+LoJ1It5el6OC50ihqtQDhy1Mws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6T1yGDeEp1NeHjaJCuwg+Oeagmu2ecExXtWzqsa6z/lVWYxlssoNxqNKLEf/FMaS3LPxj8K5RPSK2Bk7i7GjcwVEIXz7MwldPMMxdhp9kyRx18kbWsHUqXjjjHaNV4c1bGr3iJzu2wiJ9kGQIEAvBWu+qpforfwXueGMl8Gcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZlbCffLi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P0N1dbBDbRfrnziSNKZKvq2742D1NvePTphqs5cf1vQ=; b=ZlbCffLiA9Li3QAemOroVSTec+
	geRe6BO9Uxlgglx0DzDRZRNrjC0ovRW8MX3TtF43OqXfULfEA22Z3wZvEt6HpjH9VAzPfm+BDdyNz
	njGmGdvndlDvtcS4/zHWExxcI4mNYoKAuj6kj7E/zvDdSnIrUSu/jFl35DpPQYZik/Xk4S+bBKnpX
	elYXeNEAGQehgNkawv36kzhSVbwL36jkF6UjiwK00bBYEe2syYalh2EwBFkFAyOIJvRRWInIW6gwx
	N3Ikpo0FktwU7mwEEBRxejhduJbXLYzauEQQ/8YPhWGE2s2TRcQRgQrOLRKovDVpzMRBytgcerc28
	QhG+nFxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEcI-0000000HRxX-37iJ;
	Tue, 18 Nov 2025 05:51:02 +0000
Date: Mon, 17 Nov 2025 21:51:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] iomap: fix iomap_read_end() for already uptodate folios
Message-ID: <aRwJRnGDrp9oruta@infradead.org>
References: <20251118004421.3500340-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118004421.3500340-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 17, 2025 at 04:44:21PM -0800, Joanne Koong wrote:
> There are some cases where when iomap_read_end() is called, the folio
> may already have been marked uptodate. For example, if the iomap block
> needed zeroing, then the folio may have been marked uptodate after the
> zeroing.
> 
> iomap_read_end() should unlock the folio instead of calling
> folio_end_read(), which is how these cases were handled prior to commit
> f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for
> reads"). Calling folio_end_read() on an uptodate folio leads to buggy
> behavior where marking an already uptodate folio as uptodate will XOR it
> to be marked nonuptodate.
> 
> Fixes: f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for reads")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> ---
> This is a fix for commit f8eaf79406fe in the 'vfs-6.19.iomap' branch. It
> would be great if this could get folded up into that original commit, if it's
> not too late to do so.
> 
> Thanks,
> Joanne
> ---
>  fs/iomap/buffered-io.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0475d949e5a0..a5d6e838b801 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -455,29 +455,30 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>  
>  	if (ifs) {
>  		bool end_read, uptodate;
> +		size_t bytes_not_submitted;
>  
>  		spin_lock_irq(&ifs->state_lock);
>  		if (!ifs->read_bytes_pending) {
>  			WARN_ON_ONCE(bytes_submitted);
> +			spin_unlock_irq(&ifs->state_lock);
> +			folio_unlock(folio);
> +			return;
>  		}
> +
> +		/*
> +		 * Subtract any bytes that were initially accounted to
> +		 * read_bytes_pending but skipped for IO. The +1 accounts for
> +		 * the bias we added in iomap_read_init().
> +		 */
> +		bytes_not_submitted = folio_size(folio) + 1 - bytes_submitted;
> +		ifs->read_bytes_pending -= bytes_not_submitted;
> +		/*

Very nitpicky comment:  I'd do away with the bytes_not_submitted
variable:

		ifs->read_bytes_pending -=
			(folio_size(folio) + 1 - bytes_submitted);

and keep an empty line before the start of the next block comment after
this.

Otherwise looks good;

Reviewed-by: Christoph Hellwig <hch@lst.de>


