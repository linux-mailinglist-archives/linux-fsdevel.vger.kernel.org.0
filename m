Return-Path: <linux-fsdevel+bounces-9872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5884593B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3121BB24FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01BE5D496;
	Thu,  1 Feb 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTZ1f+NB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB453389;
	Thu,  1 Feb 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795235; cv=none; b=b7+JC38wI4UZTknPbC/H/V0FLhnIkz+1eTOlz/Tk4o+dxHWKACJUnxSq+N0igbnnpeKQWGXVJpmXi33y/q2F7OnM+8FvBRcFis/lUEmkdWBqAqbGIzCc6j0yaCahzDEWsdxsUn+mkKpLxT4Fkg3wGv6sSzc+rGkoy+HKYLi/zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795235; c=relaxed/simple;
	bh=MicJ7RF+w26oTpS4mXGfMglg4DfFvf7LKePLvO1pSV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM5NnNM2dOpTCyYPsUToxffCxjMcICQVPgZ/YJ5wDhC70KO2cKyJV9GD+dqBqFran1ItvDIgX4leYfBn4AnfOcrRWITsvP9B5ZeXYfIv+N9M2ATks0wPzuXScB2HMKxMWv25TZic6c6zRyykyIqxrRhGb76l8zVGABjH7MPTYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZTZ1f+NB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tYvzDfQFwKusRhTebIY0H6L6hobYf0zaXRaAkQ0RHv0=; b=ZTZ1f+NBXyhYPNqdhJlWo2ZOEI
	R/PgLoYl3Eee9mq1bkdGmYgdsofoHdCGIMIHplMCeFEMN14Ee/o8MDdHGxDOo97AGNQ4KWkeOhSz8
	Mc1liETjGH0RSzqfoTUWc18nQjpe8Eb/RA0YCjPwu09qbdoYEz90KpimVadd+QhkAXlZya91W96Sg
	P9G1m2TeVnCaobr8RXj5qAXdU5idsx33NPYyaYEJDHXZil8IiYak8DSKGLSwabiXHpLsDj05/0KbJ
	NjB9SMjRnQNle5b1DGFPL2d8rrRpyEfnetRXjcgalgNuhGyu8HR+hH4OpEiooAYv0AbUIKemBmACr
	v31qxLJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVXPD-0000000FwiQ-2CYU;
	Thu, 01 Feb 2024 13:47:03 +0000
Date: Thu, 1 Feb 2024 13:47:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/readahead: stop readahead loop if memcg charge
 fails
Message-ID: <Zbug14NoOHFmfLst@casper.infradead.org>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-2-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201100835.1626685-2-liushixin2@huawei.com>

On Thu, Feb 01, 2024 at 06:08:34PM +0800, Liu Shixin wrote:
> @@ -247,9 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  		folio = filemap_alloc_folio(gfp_mask, 0);
>  		if (!folio)
>  			break;
> -		if (filemap_add_folio(mapping, folio, index + i,
> -					gfp_mask) < 0) {
> +
> +		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
> +		if (ret < 0) {
>  			folio_put(folio);
> +			if (ret == -ENOMEM)
> +				break;

No, that's too early.  You've still got a batch of pages which were
successfully added; you have to read them.  You were only off by one
line though ;-)

>  			read_pages(ractl);
>  			ractl->_index++;
>  			i = ractl->_index + ractl->_nr_pages - index - 1;
> -- 
> 2.25.1
> 
> 

