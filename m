Return-Path: <linux-fsdevel+bounces-53801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4800AF762C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C2E4A04C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6422E7631;
	Thu,  3 Jul 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVuByjLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AB17332C;
	Thu,  3 Jul 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550769; cv=none; b=rx4j8rBoRAAtaM4DiwAv+jCSCBxMfLrSU1ZuRnNF4cFBPJzqW7H00n1OmUUWeRS1tx2cfGHholBIQ/xrNrLsAgy/qBpkedD11xDZdNH95yo1XlZ8GBkMch/W1ysP/cQSiaXEcWE+OCMVElNhSBte7J4ghs/etgD0nhWy+SdML5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550769; c=relaxed/simple;
	bh=33qRgg1e0mQ5mosYkkIKlnqZlLmvu7IPY5YeHzf6CJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo4/T54fmZ0lw3VE+gEuF0JX0nQNqr/GEsQUixbO/XXuZH0HhKO7SxXkKkRJw78v5J+PiZ6r3Wo/ZXRxVLRxy80EANf8wEVh8ftp1L6bxwCm5WIw2mxOl+cRY+M9nd8gQLOU0zh5hSdBnCMJhDEyMGGumREGe6Lt4VdGHbq9VXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NVuByjLG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uce3SwGRj1PM1jnKvZzMFY4bzlcSVJEXs+lkeyaTxDI=; b=NVuByjLGPcFFrErcrLRZT0g6w7
	wjNc+N/oGDv0dj+MSdPtCjBqWn2DgUHrFZld/JjUxcQ2GJdZ5QjEs1RiFMsKXtzyPRDJ5zUIPe69m
	9cmWc0ApCz20z/ClhALD5Uag2Zg+QX+3Zba8Wbna9G0mDSov4yc8Z1qpEVDNwjcDo98TJ262Qksba
	EBnNLcpYt6jyb3b0WVU1HwU2ENbPMzsnrYMpLv+6aFL9C3U/GSgzpbo21AcGl8nKRSXnwtYs77Eas
	OyUiCziuMjeBe8WDWcHzpBZmrVan09lPzh5quOzhLBPSW60hBXb1HXrQy5LtT3auHUfJThPKPxqQN
	OmXnXtZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKMm-0000000BYPP-0Nco;
	Thu, 03 Jul 2025 13:52:44 +0000
Date: Thu, 3 Jul 2025 06:52:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>, linux-mm@kvack.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <aGaLLHq3pRjGlO2W@infradead.org>
References: <20250701144847.12752-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701144847.12752-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 01, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> In the buffer write path, iomap_set_range_uptodate() is called every
> time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> know that all blocks in this folio are already in the uptodate state, so
> there is no need to go deep into the critical section of state_lock to
> execute bitmap_set().
> 
> Although state_lock may not have significant lock contention due to
> folio lock, this patch at least reduces the number of instructions.

That means the uptodate bitmap is stale in that case.  That would
only matter if we could clear the folio uptodate bit and still
expect the page content to survive.  Which sounds dubious and I could
not find anything relevant grepping the tree, but I'm adding the
linux-mm list just in case.

> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..fb4519158f3a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  	unsigned long flags;
>  	bool uptodate = true;
>  
> +	if (folio_test_uptodate(folio))
> +		return;
> +
>  	if (ifs) {
>  		spin_lock_irqsave(&ifs->state_lock, flags);
>  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> -- 
> 2.49.0
> 
> 
---end quoted text---

