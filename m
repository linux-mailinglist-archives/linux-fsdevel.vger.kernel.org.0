Return-Path: <linux-fsdevel+bounces-21561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1309905B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6571C229CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69F57CAB;
	Wed, 12 Jun 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UN40XRk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5D4CDF9;
	Wed, 12 Jun 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218262; cv=none; b=SOViR8y0p6bkcZe1OqVTYa8eA8Bj45SuYd+HgePN/SYCahtjOCqtxLU4S6EyT69k2a6BOFhDbkNK4JsDluZX0zMfR7vAAsZa/on2j82K2idetV1a0TzW5dUrfdeCVHtm/Al+s3Q/jSctJdKaJleS2e+x+VOU8J9TmFKz1uy0u0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218262; c=relaxed/simple;
	bh=Zf7s9WeVnkvmuXPzjsfTL8ksWv08gNLaGXu8WKfdazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmZ00bzUQQfvBVmBWQju3u3P3BN8MTxfGeu3Xr/f53089f9tkZj0l6iEHEP0ySCuEvFWI9pKbjAdd3CjPINBrNzyeZgLWtZxHqMn+d6yYQvyjFZEFAOL6eDR5/UP08nyu6HE5M6gqZVwiF6ZZsCCdqP8j/OUM3jVGfXEIbS+xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UN40XRk9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SnTD+YzDcFdeMAvSsaXVlZcl9N1crAVDMcpCBvbsy4M=; b=UN40XRk98RsgoJc9yo1fssXg4B
	rhAiDU4piBR+yp7MAQSmFafqrEBApb5mYlwjE9CykOkoWUBWGqMhKGrMqUoLS2TO7EVdzFDEmZfMY
	gr2/B6BPuy6EjyIothSFx4I2t0byuYkB772tm/NlqmDkm24/i1888acz6GDNgWbjgGNJKQRbPkuAN
	q2tsfM8iX4s+cOyTSytKQtrDOO8tvCWxya3zpclY4sBqq6LWeTY4iJg8A189S9xb3oPARsa421sAY
	FOvNO0J/v+GC7qJRf9g3xvGtqGWhkTXdioqI/qORq91Fe43olNz3Va+hORnhpcPi0qDEKOS8hlym8
	nxcCddog==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHT3Z-0000000EzSY-0Y2E;
	Wed, 12 Jun 2024 18:50:49 +0000
Date: Wed, 12 Jun 2024 19:50:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ZmnuCQriFLdHKHkK@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-5-kernel@pankajraghav.com>

On Fri, Jun 07, 2024 at 02:58:55PM +0000, Pankaj Raghav (Samsung) wrote:
> @@ -230,7 +247,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
>  		int ret;
>  
> +

Spurious newline

>  		if (folio && !xa_is_value(folio)) {
> +			long nr_pages = folio_nr_pages(folio);

Hm, but we don't have a reference on this folio.  So this isn't safe.

> @@ -240,12 +259,24 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl);
> -			ractl->_index += folio_nr_pages(folio);
> +
> +			/*
> +			 * Move the ractl->_index by at least min_pages
> +			 * if the folio got truncated to respect the
> +			 * alignment constraint in the page cache.
> +			 *
> +			 */
> +			if (mapping != folio->mapping)
> +				nr_pages = min_nrpages;
> +
> +			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> +			ractl->_index += nr_pages;

Why not just:
			ractl->_index += min_nrpages;

like you do below?


