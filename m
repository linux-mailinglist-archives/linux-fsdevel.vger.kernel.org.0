Return-Path: <linux-fsdevel+bounces-29532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47497A8E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 23:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6CB286B72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6F15FA72;
	Mon, 16 Sep 2024 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t8ZGdrsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FC158A2E;
	Mon, 16 Sep 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522941; cv=none; b=ul+IfF43u3cRJL2FXzt7Q7a9z89FjqGkcEhbPecYviK59FFt30VPJX+8jIg7a1p9yBcxCSaUbNyi6AGV84O9vCfW7+JIMhX+QKGy0utYP6n2W+dY2QPGVBSr1qqAAzxTsu9+l4gjJXcG+yoikxhxDv/A6pEY8az9oTqGFPSJyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522941; c=relaxed/simple;
	bh=pbJX01PUVH+2R5tPmmtSbYG6rmE+twOIrxl+1J6Wxoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7QoEZxSO8vlQa/alNtIFDH+10tDOhEXC965hqtG5XNejqPIufTzEEyWls8wjVSM2jm8RhcoxuX7hl/hKu9xK03OQZIPch08JJ9djiiZWb2/0DUdIjNTOwNSGPdOGeFYHtu0wX9cCJWC4Lt23o8OuC1QMEl+vGRCJixlLmV5JGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t8ZGdrsZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iWPVUjwXOy2FImjR05EIaFD8Hokx95ABL5Jg22WP/1Q=; b=t8ZGdrsZBw9vZG86m3yTJXqoB5
	GMWr0Vsq3lqtfFAm6pg2j63vipBSLt6Me37OZFKXgmi7von2QYUx9PBIIbwEH41sjO45eCDJMydlX
	hBtfHd/FcjcqDayDt22dU9PnVarf0xmlpCMW+ZRFIBA11JM0Az5wtJ0nek7XtLQFoCKLcPpyeBCwH
	OapTa9xyVPd1VjVPcMRKGvBPKF9ymip8wv3FuGwdfRRJ0Q3yxpYRY2sjm6lMIYxCfpPRLNsCUzuTa
	UaTjoryYB492d0saSphaC+pw9dDu9Pqp6Qc0JTthS8gEtGytCPs7eucTjwosI4h2AyLFAoV4qn5/f
	0W3Wc8/w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqJTy-00000002PR1-25HR;
	Mon, 16 Sep 2024 21:42:06 +0000
Date: Mon, 16 Sep 2024 22:42:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: pbonzini@redhat.com, corbet@lwn.net, akpm@linux-foundation.org,
	acme@redhat.com, namhyung@kernel.org, mpe@ellerman.id.au,
	isaku.yamahata@intel.com, joel@jms.id.au, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	shivansh.dhiman@amd.com, bharata@amd.com, nikunj@amd.com
Subject: Re: [PATCH RFC 2/3] mm: Add mempolicy support to the filemap layer
Message-ID: <ZuimLtrpv1dXczf5@casper.infradead.org>
References: <20240916165743.201087-1-shivankg@amd.com>
 <20240916165743.201087-3-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916165743.201087-3-shivankg@amd.com>

On Mon, Sep 16, 2024 at 04:57:42PM +0000, Shivank Garg wrote:
> @@ -652,6 +660,8 @@ static inline fgf_t fgf_set_order(size_t size)
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp);
> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
> +		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp);
>  
> @@ -710,6 +720,26 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
>  			mapping_gfp_mask(mapping));
>  }
>  
> +/**
> + * filemap_grab_folio_mpol - grab a folio from the page cache
> + * @mapping: The address space to search
> + * @index: The page index
> + * @mpol: The mempolicy to apply
> + *
> + * Same as filemap_grab_folio(), except that it allocates the folio using
> + * given memory policy.
> + *
> + * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
> + * and failed to create a folio.
> + */
> +static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
> +					pgoff_t index, struct mempolicy *mpol)
> +{
> +	return __filemap_get_folio_mpol(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +			mapping_gfp_mask(mapping), mpol);
> +}

This should be conditional on CONFIG_NUMA, just like 
filemap_alloc_folio_mpol_noprof() above.

> @@ -1947,7 +1959,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			err = -ENOMEM;
>  			if (order > 0)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order);
> +			folio = filemap_alloc_folio_mpol_noprof(alloc_gfp, order, mpol);

Why use the _noprof variant here?

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 9e9450433fcc..88da732cf2be 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2281,6 +2281,7 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
>  	return page_rmappable_folio(alloc_pages_mpol_noprof(gfp | __GFP_COMP,
>  							order, pol, ilx, nid));
>  }
> +EXPORT_SYMBOL(folio_alloc_mpol_noprof);

Why does this need to be exported?  What module will use it?

