Return-Path: <linux-fsdevel+bounces-23731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE4931ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9043A1F2209C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD8D2FA;
	Tue, 16 Jul 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sFYzLipJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FB3FF1;
	Tue, 16 Jul 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097012; cv=none; b=T3iWoqsr/3jTy4EuratlQ2QeYn56d+hdhos/AzSS+x4fbT5lxNU57qFI9fhBM4601C7gpv+c9stoI2eF3D3aCnMKe3Qi7OwAHkxS2cjcDucglGMao712YhpBpGxMSJZ7PZ3pmuDU9WM/W7km60UJBjWJDMVsr3V9QritHYXecNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097012; c=relaxed/simple;
	bh=zWPoxjIUescuLRN6EN/TYCrlS38Yi8wt1NDsC+Jgxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFMcWlujNdAIJWncfXVKMosASoSBCf5NYS5vYpMRqY6ycVLchHDmR16T4DQPXIp1Y542I7A2EMWJDTvzUJ+y/Jd2MmfMUpLo8mYK14NJ2b96y2o/Y9LdNViTE3Wd3MvYpx9twFN9K3uOIr3H6PRgnmZpLJl5ruQh972za5xrCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sFYzLipJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aw654SugnjJczSIIfOrslrpuf0osXoeKMVCrP53YdIY=; b=sFYzLipJsVRqF0elx7Ztu/ihFk
	wdhigaVoIO79xWApfxdOM948hevDWpVVYTVzB4Yg1x0cOtdiAQx7vuOH7xGFUYKB/8SLlXROBO3t4
	bO3aMCaKaxrkEjQ5C1X4kfyggUaealmhU1eave2sSCpcNUIuoU5ZGxIAcM/s5+OVadvRTX9g9Cimo
	lm3qURXoN6Jegof3aLZFVb5p807AxxbmuGBUFwihTi0VRhdK97BxjmHuihUUOfjmNnCB4zH9+VQJ1
	qM5/9LdCyW10EV1V4pFHmD9YCPX/yf6cVuIhBZQU96XWhqsP/xQS/B1MXBmQjiahpGUO5zay/qIFE
	zDNPlS5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTXx8-0000000Gcnb-2KEP;
	Tue, 16 Jul 2024 02:30:06 +0000
Date: Tue, 16 Jul 2024 03:30:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: fix error pointer dereference in filemap_fault()
Message-ID: <ZpXbLr0JeybnV6af@casper.infradead.org>
References: <20240716022518.430237-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716022518.430237-1-make24@iscas.ac.cn>

On Tue, Jul 16, 2024 at 10:25:18AM +0800, Ma Ke wrote:
> This code calls folio_put() on an error pointer which will lead to a
> crash.  Check for both error pointers and NULL pointers before calling
> folio_put().

Have you observed this, or do you just think this can happen?

If the former, please share the crash.
If the latter, please document the path which can lead to this
happening.

> Fixes: 38a55db9877c ("filemap: Handle error return from __filemap_get_folio()")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 657bcd887fdb..cd26617d8987 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3420,7 +3420,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * re-find the vma and come back and find our hopefully still populated
>  	 * page.
>  	 */
> -	if (!IS_ERR(folio))
> +	if (!IS_ERR_OR_NULL(folio))
>  		folio_put(folio);
>  	if (mapping_locked)
>  		filemap_invalidate_unlock_shared(mapping);
> -- 
> 2.25.1
> 

