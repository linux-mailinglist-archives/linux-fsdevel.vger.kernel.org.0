Return-Path: <linux-fsdevel+bounces-28964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5E972300
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 21:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA31F22117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75A189B9D;
	Mon,  9 Sep 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuXvGo4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0B18C31;
	Mon,  9 Sep 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911280; cv=none; b=Rplz/g6OiZc7rv0eDZkLZXP90zpObR5MnBHMCgGHmSsBaH5X4RBdjJwURVFOBIAwGKqJeSofGdRPfLQVhXdRSL347PKwITOZUWD25EKLNxnIWjATFGpw56awL8lpAPkvpla3Os8mu31hdWW74DQqJRalQDe6Za2UCcVXHlF4ryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911280; c=relaxed/simple;
	bh=Ag8+bsp76FrqC7tdlkP0qPVOT0eOJljFtbN5rRiMnr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5cvo3375XZMRgBo48xJMdqWXdfaT8Ol3/FcyIIDEGK08+m61+mDsfgz+LmMWuEShZQ3TFvmHkiyFTcA2W1JdLqtcFWB/+bPjCSqiLKGjzmodHt3AdMfe+5ijCRaAn9uggiLdjOgic3NnY/vQajhv6rHVIJva1TXgym7CTGIy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OuXvGo4G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0kV15Cqf3QYUwyAFRybcY7zV8gb4O0cZLiW/r9UUtg=; b=OuXvGo4GyRZTjIEKEXjmjgFl1J
	j6Nv3LC0t7FzOwLjeAt/656zhl+H7tAJk9w0NEbK/yCppP7KoqCbkw2e/vkl5hXookeOVoPmCCjgO
	7T3ePe62o76M0mH/HOXTBIaWxdEZhPZqH/VSculwCfl/M5rxndcKreDyCO0TKS/9S4MzL9qyidCKd
	RXlC7nrho9/qN+FU5Z7/dtJMKDHtU11nmvdF6yv4F0dh5ta0gBkDo00XDvlCVOWVe+De1oeZ762Fb
	CGXPW5+2I4xXtFnJSs4MVyhw/I5MPtH3+KXubAht4unTutmUaArMWYEvPyDjuEN1reYxD9F/yVYRH
	/4nxIUiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snkMU-0000000Ggop-1vYY;
	Mon, 09 Sep 2024 19:47:46 +0000
Date: Mon, 9 Sep 2024 20:47:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: chensong_2000@189.cn
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: introduce local helper for_each_folio
Message-ID: <Zt9Q4kegrxnulnR2@casper.infradead.org>
References: <20240909061735.152421-1-chensong_2000@189.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909061735.152421-1-chensong_2000@189.cn>

On Mon, Sep 09, 2024 at 02:17:35PM +0800, chensong_2000@189.cn wrote:
> From: Song Chen <chensong_2000@189.cn>
> 
> Introduce for_each_folio to iterate folios in xarray for code style
> compliance and better readability.

I'm not sure this is really worth it.

> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  mm/filemap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d62150418b91..5386348acacd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -62,6 +62,9 @@
>  
>  #include "swap.h"
>  
> +#define for_each_folio(folio, xas, max)	\
> +	for (folio = xas_load(&xas);	\
> +		 folio && xas.xa_index <= max; folio = xas_next(&xas))
>  /*
>   * Shared mappings implemented 30.11.1994. It's not fully working yet,
>   * though.
> @@ -2170,8 +2173,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  
>  	rcu_read_lock();
>  
> -	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
> -			folio = xas_next(&xas)) {
> +	for_each_folio(folio, xas, end) {
>  		if (xas_retry(&xas, folio))
>  			continue;
>  		/*
> @@ -2306,7 +2308,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
>  	struct folio *folio;
>  
>  	rcu_read_lock();
> -	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
> +	for_each_folio(folio, xas, ULONG_MAX) {
>  		if (xas_retry(&xas, folio))
>  			continue;
>  		if (xas.xa_index > max || xa_is_value(folio))
> -- 
> 2.34.1
> 
> 

