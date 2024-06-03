Return-Path: <linux-fsdevel+bounces-20815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B58D820F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088EE1C2205B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D212C477;
	Mon,  3 Jun 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ry9W5eVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E912AADD;
	Mon,  3 Jun 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417136; cv=none; b=lIP+WXKEugb3XxEYX0b91t19LLvknw1x6RmW01TRJL2hk5dTCPUJzTP0Eyzuijdn5cGPKQRBRW0yIKdOckZkZJMOiWxsLY6BZJPkI0lFy0o4ZwXrhB8T74sgEh0pGfzWArLqYd9RkP5711qZw9Y+i5bSPxUOwv/1jl27qk/Kjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417136; c=relaxed/simple;
	bh=jDGW5R5UtzbmJ3VGAKqw58LCkqb0dw9w9Jb61rkJ3qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOapz9sOvB0xDiyqCEHkt3xzx2sbzR9ff0hysDu4IUBPZkp2u/DhV3OOmQjZO2O56UxoDx5CFnSaxnhQNQR/Q9CJ4bCrsT2K5pRrGiB/KXfFIVccQFz3L/+tU163pVPLhMh033ok+1mCH7E6B2MhWjGIdZzP1xsS6xQqJoFX5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ry9W5eVA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mrfTYsS95Bd6Q8FrjNuVkMUgYtvqhZBTbPKZbn4NM34=; b=Ry9W5eVAbnuZbmAmEuVatNnp7E
	avF4x+DHl4hmbrVAwR0JkcjbUZ9HuSfEhT3zuP1STtRBWQMcunmG1tvrNmrdZCnk7P1l/Ly207nqV
	SD+e1kKqPT87SvKDGwQPMViwPW2QjQSiSY3cfSZjxsrdRb9Dm80IiLAJoALooeDiXwANgDog07QMf
	ZpY3EVbPqj/Tcc7dvDOTAicfFngN06h1XcM4FYumQm8ALEzkLxRh+yoRK1v/PYkK12PcVN8w4wrY3
	vId7mCgf2xWpMh/1r6WFg/+ez3HcqBiGmAzKE4u7rTi+Gm1yGWnJva5TuxqSAz7HBv1xfLiMSX2tI
	F/17n6fg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE6eD-0000000E5Yz-1yAV;
	Mon, 03 Jun 2024 12:18:45 +0000
Date: Mon, 3 Jun 2024 13:18:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, akpm@linux-foundation.org,
	brauner@kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org,
	hare@suse.de, john.g.garry@oracle.com, gost.dev@samsung.com,
	yang@os.amperecomputing.com, p.raghav@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	mcgrof@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <Zl20pc-YlIWCSy6Z@casper.infradead.org>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529134509.120826-4-kernel@pankajraghav.com>

On Wed, May 29, 2024 at 03:45:01PM +0200, Pankaj Raghav (Samsung) wrote:
> @@ -1919,8 +1921,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int min_order = mapping_min_folio_order(mapping);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;
> +		index = mapping_align_start_index(mapping, index);
>  
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
> @@ -1958,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  				break;
>  			folio_put(folio);
>  			folio = NULL;
> -		} while (order-- > 0);
> +		} while (order-- > min_order);

I'd argue you also need to change:

-                       if (order > 0)
+			if (order > min_order)
                                alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;

since that is the last point at which we can fall back.  If we can't
immediately allocate a min_order folio, we want to retry, and we
want to warn if we can't get it.


