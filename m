Return-Path: <linux-fsdevel+bounces-26831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC195BE46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FC01C22521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C61D04AB;
	Thu, 22 Aug 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8Lt/CZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0011AC44D;
	Thu, 22 Aug 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351658; cv=none; b=cg594a4jDMQMmFbz1SjGm7Wa9lRBQo17Lq/IIwj77Q+/1hu99dVs5OlN9nXsd2GlLvEh7PH0yo0opHlrUbNPlqGNZ+m/TdLcSu6jhXpS5rMPQV6SMrvbA3LzPwGBWU/+2HM6rmef0JNcZltmTIPrxlbZAVyZLCmpWbygZp48u4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351658; c=relaxed/simple;
	bh=fvFjp59So8vRjIil8duIj2I677ToS6YRlnbXww0UPZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7PJiQYHUKJLMG6gR1x34RZvz+tbgoZaqQtlFgPGOSEubgFkuoqBoiZoeP8NJ7mvH2Fa/4PTOn+NyLpwLgUInjptoROZC2fEA9HgZkEGLTlJct/LXtZIbYZ3wFcIkSMT9ET2UdQyenJWeD9PTxaPnmXI97U0aIzWR/bxde99s7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8Lt/CZe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qn7vUOEA2rcYCABVNLNAa2eRTIExK6tDC0WoyGL66Oo=; b=s8Lt/CZeLmlPCHsWuymDEeLgFj
	fYIXLopOkHGhXcTutxG5zjMpudm0cEDvepNkedxkEIax47IgisUkU5q0i1wywF7uj7QbfNrvNOppH
	sJkthtAlR7lg6CITJF2/VcLly3rTg4GL4DiR4LqbMecrZd3wCphZwY6lZKO3Xjd2xSlnCuSo4XBGa
	+4+oATw0wSLMTBSklLT+1jr0Wp8Srs6TDwn70/eSRp3BkbB5LpO5SODZrs0Dgsb2Rhtxsd5TV1d32
	28eT0qLNrgVMbL+hoBr7pqCeVvhuI2dVUheQcqU1QkST1p9MJkTLlL42sOOyRmvnl8BTMT6TYO78j
	6a/PuM8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCdH-0000000AohJ-0Ae2;
	Thu, 22 Aug 2024 18:34:03 +0000
Date: Thu, 22 Aug 2024 19:34:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/10] mm: Remove PageActive
Message-ID: <ZseEmvNBqoOUfTX5@casper.infradead.org>
References: <20240821193445.2294269-2-willy@infradead.org>
 <202408222044.zZMToCKk-lkp@intel.com>
 <20240822112424.281245ba8874b4b39ce25c37@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822112424.281245ba8874b4b39ce25c37@linux-foundation.org>

On Thu, Aug 22, 2024 at 11:24:24AM -0700, Andrew Morton wrote:
> On Thu, 22 Aug 2024 21:22:43 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> >    arch/powerpc/mm/pgtable-frag.c: In function 'pte_free_defer':
> > >> arch/powerpc/mm/pgtable-frag.c:142:9: error: implicit declaration of function 'SetPageActive' [-Wimplicit-function-declaration]
> >      142 |         SetPageActive(page);
> >          |         ^~~~~~~~~~~~~
> 
> this, I assume?

It's a good quick fix.  I don't think this use of PG_active is
documented anywhere, so I'll send a patch to fix that too.

> --- a/arch/powerpc/mm/pgtable-frag.c~mm-remove-pageactive-fix
> +++ a/arch/powerpc/mm/pgtable-frag.c
> @@ -136,10 +136,10 @@ void pte_fragment_free(unsigned long *ta
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
> -	page = virt_to_page(pgtable);
> -	SetPageActive(page);
> +	folio = virt_to_folio(pgtable);
> +	folio_set_active(folio);
>  	pte_fragment_free((unsigned long *)pgtable, 0);
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> _
> 

