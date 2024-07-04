Return-Path: <linux-fsdevel+bounces-23141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F349279E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89FF1F2588F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B271B14F8;
	Thu,  4 Jul 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUt/QK6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A131B0122;
	Thu,  4 Jul 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106438; cv=none; b=R14qL7qQIZiICA92+s380FKaw1o4ppwrLoqGB/8NrTmyggEIR91E3PM74ZtlAmztCNVG4Kd1ZfHYQVy2mbvQ49KhULYcNzr8Tgs8dhwL8DoWC+heV0+GcDyESiMfzI2zeYLzDgoqD7QG3WNXbR3Kni84FVllTTOEmBlRvnicv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106438; c=relaxed/simple;
	bh=uLrqDxpb+tvF7mkqkCnn0LFKeFwLUAS1XvCZnPc3+hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDYplMEcYZz0COENriFvP7U3AaVURNeaYDwp4gSlM7PeVIHFvPC+YPhwPH1q7g96l9jO0lH9a2VA90gyzWiCvwsCOhMa0vY3JQbe1UnAfgHUVSL1ERY2coI3/C2outVWdSupjwUoJwzmIUM6KXPt/g5UkcfPc+qEvD9TgZr4M/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hUt/QK6Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T1W+cwrYdEZzgH6Ohx8queoWljwDE94ghf7And0NMPQ=; b=hUt/QK6QIkaT0GDYXczMay3Z5A
	pmDxONmeAqHPE6Ljy1yY/Vm91+/doA5NrrDK0Qwhwytnxn7Ylg0sFitz55Gm0ZLgPkMCwAvCfjr6n
	3a1HI8Dn9MsAoLjYVdcTyGWA2WIn8fmctH4PCnIbpZ3hX41eDAdm8bUziFfCU6z7OCmo3Mn1mzZaI
	vnSZj65ciww3h03aGnLAS30sfEl1Bm5eCEC/HSZZ6Hy3FFxu/3HcekPS0lfRLoUwNGfuYjqu26tCL
	/myW50CvKTFe+tNi0TCOWfObPVA4DuLa2NhuatSohg5GHb39arRD1HzbIvryZZcBQOMCd3LMo4T5u
	1Gt5maMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPOFp-00000002yac-1247;
	Thu, 04 Jul 2024 15:20:13 +0000
Date: Thu, 4 Jul 2024 16:20:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <Zoa9rQbEUam467-q@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>

On Thu, Jul 04, 2024 at 01:23:20PM +0100, Ryan Roberts wrote:
> > -	AS_LARGE_FOLIO_SUPPORT = 6,
> 
> nit: this removed enum is still referenced in a comment further down the file.

Thanks.  Pankaj, let me know if you want me to send you a patch or if
you'll do it directly.

> > +	/* Bits 16-25 are used for FOLIO_ORDER */
> > +	AS_FOLIO_ORDER_BITS = 5,
> > +	AS_FOLIO_ORDER_MIN = 16,
> > +	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
> 
> nit: These 3 new enums seem a bit odd.

Yes, this is "too many helpful suggestions" syndrome.  It made a lot
more sense originally.

https://lore.kernel.org/linux-fsdevel/ZlUQcEaP3FDXpCge@dread.disaster.area/

> > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > +						 unsigned int min,
> > +						 unsigned int max)
> > +{
> > +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return;
> > +
> > +	if (min > MAX_PAGECACHE_ORDER)
> > +		min = MAX_PAGECACHE_ORDER;
> > +	if (max > MAX_PAGECACHE_ORDER)
> > +		max = MAX_PAGECACHE_ORDER;
> > +	if (max < min)
> > +		max = min;
> 
> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> whatever values are passed in are a hard requirement? So wouldn't want them to
> be silently reduced. (Especially given the recent change to reduce the size of
> MAX_PAGECACHE_ORDER to less then PMD size in some cases).

Hm, yes.  We should probably make this return an errno.  Including
returning an errno for !IS_ENABLED() and min > 0.

> > -	if (new_order < MAX_PAGECACHE_ORDER) {
> > +	if (new_order < mapping_max_folio_order(mapping)) {
> >  		new_order += 2;
> > -		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> > +		new_order = min(mapping_max_folio_order(mapping), new_order);
> >  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> 
> I wonder if its possible that ra->size could ever be less than
> mapping_min_folio_order()? Do you need to handle that?

I think we take care of that in later patches?  This patch is mostly
about honouring the max properly and putting in the infrastructure for
the min, but not doing all the necessary work for min.

