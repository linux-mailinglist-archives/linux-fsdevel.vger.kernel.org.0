Return-Path: <linux-fsdevel+bounces-34082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF79C24CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBAD1F2224C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93EE194A49;
	Fri,  8 Nov 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrbFCdKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D6233D60;
	Fri,  8 Nov 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090075; cv=none; b=edcPgccBmrtpRH+MPUnKURj8AdBPmOra2ljTqWBpO7UyrUlgl+c3sO+b5eiwqWEGGCIT9snIuulrXhoC8fSgfZkRxlX6dOhdpEkntdRFU3f02PacHwYTj4BWKOwlXLH0n8LtM13lEwrmVPEZXX4wCxk1fxvnfzB0A1fneOxWFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090075; c=relaxed/simple;
	bh=rddQlP09K6zZFd8wvtzXIIhlBspDLF2lrJioG4qRmjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzr/6zAOj/21Bj8LKLmr/GYzAafBSeankByn2iYcNBLzdzwugM+BwNmBO4U0OLKQ2MXvvyjFCTkVN0IraWKDkiuumDuoIJhmxbBd1q6VL317exxHWeGL3VCZ/cScDfJMmenBhrbAn4bN633Lo8KspmqMj3BLPdLQOuKEpEAS7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TrbFCdKU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qxYJJL9dEeR02JTSTOG4LkzvZWHrplSeeTctfqCEs4w=; b=TrbFCdKUxOYPxUvJcON7wLb/E4
	2d7e7bE7FKrNVQDQd4sUdynyemW3KMe0F7cZFTIK/B7dAZnkd7Nts7NNhuhK5SHkO0uCj59/eWa+a
	Nm3kWmRho06zCAv934LSglP7vDbXiNEsDfHL3S9LUpVfsXUXD0jBd5tonkchmqjeGFfXNpymBZaX/
	E/PKuhUENNIETKhWQMN21YHW8YIDbw/1Nf2q0exNbq55AiP+bny/ni75cVQr6OpjLyFqfmb3tOwEL
	tdx7/hzojSxwH5d0pqiaA64xb0tlsSpdX/jxk9Q5zT1JAXxXi7BWfbqPlyZrDfOxY/RvS6d/mo22Q
	pMs/D2Ww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Tbb-00000009AVT-1mFZ;
	Fri, 08 Nov 2024 18:21:11 +0000
Date: Fri, 8 Nov 2024 18:21:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] mm/readahead: add readahead_control->uncached
 member
Message-ID: <Zy5Wl84aHADMe8MQ@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-5-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:27AM -0700, Jens Axboe wrote:
> +++ b/mm/readahead.c
> @@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
>  static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>  				       gfp_t gfp_mask, unsigned int order)
>  {
> -	return filemap_alloc_folio(gfp_mask, order);
> +	struct folio *folio;
> +
> +	folio = filemap_alloc_folio(gfp_mask, order);
> +	if (folio && ractl->uncached)
> +		folio_set_uncached(folio);

If we've just allocated it, it should be safe to use
__folio_set_uncached() here, no?

Not that I'm keen on using a folio flag here, but I'm reserving judgement
on that unti I've got further through this series and see how it's used.
I can see that it might be necessary.

