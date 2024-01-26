Return-Path: <linux-fsdevel+bounces-9045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6383D655
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCC1B2A106
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5012DDBE;
	Fri, 26 Jan 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I50x5DUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C7249F8;
	Fri, 26 Jan 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259351; cv=none; b=aCXOpSNhJJrzV48o/TtUKvUZsp+WSR7VW5bEnE1SkPSYmyJNI68cqCeJOvrJky2dP8JVGSJO3vF/crWeA2RUyQI7PFlz8yhoINIiqSiq4U0g+Jr0xLUAXV4VOCxxuActCdtLB0H1xqWf5KKhNjfIgtAVinrLltuGzRQYoyRkxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259351; c=relaxed/simple;
	bh=VZxsGAjSNiP+osBUIVz0o4fYISM24dYHuupYK5rxxXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaOEFWz2HPBCTxrCsC5GPEPxwOrFc4TiJHJfe0WONMO/81tfc/Zs+2EVcOWup+vPEvoS1fBakQwsCmldmUE6loO7+/dBuU3rXRJZrPglNqgc3wrYxoJ1mhvrcSGqQf+/lPwxj4ITPnBCC+Gle0zV7WzP7MNIurNVITZe3qjfDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I50x5DUB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w+WMrLX5s3l3LT1bHKgCUnIIP0Rpbnm0jHmPYs4Fo3Q=; b=I50x5DUB0iXrrBxqdgS8P0PHwi
	s74eVAhOimTyTvGGWDNpVo2N9YkJBqwBDCz5RIAWU9pPr2hAs6DJHwQqu4jnTOIpYcyeen5qbI4WJ
	jbKOmxbKoaLGS4iXcdf1Y3/asNY3wfc3FLgOk8YBxQsdabvJMKo+6qnBG3NaM/yN2nE8wHKPD7FNR
	nuiOzGP0mYvr/Jn+Czdn7WyS9RqzX2IPY2B5ONEhHAT/vFBf6mdfqF96R1j+erGYbaWcUioDyA4eA
	v/RKELBLqemXTmbhLPK5Zt4Zgrhr56p2X5WWmtjv9iBH7z2aLk/ZPX4mm8mFXvpvk509gr5K4tXdN
	9kfhfLTA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHzs-0000000D5AA-0t0T;
	Fri, 26 Jan 2024 08:55:36 +0000
Date: Fri, 26 Jan 2024 08:55:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
Message-ID: <ZbNziLeet7TbDKEl@casper.infradead.org>
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com>

On Fri, Jan 26, 2024 at 03:59:48PM +0800, Zhaoyang Huang wrote:
> loop more mm and fs guys for more comments

I agree with everything Damien said.  But also ...

> > +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> > +               size_t off)

You don't add any users of these functions.  It's hard to assess whether
this is the right API when there are no example users.

> > +       activity += (bio->bi_vcnt + 1 <= IOPRIO_NR_ACTIVITY &&
> > +                       PageWorkingset(&folio->page)) ? 1 : 0;

folio_test_workingset().

> > +       return bio_add_page(bio, &folio->page, len, off) > 0;

bio_add_folio().

> > +int BIO_ADD_PAGE(struct bio *bio, struct page *page,
> > +               unsigned int len, unsigned int offset)
> > +{
> > +       int class, level, hint, activity;
> > +
> > +       if (bio_add_page(bio, page, len, offset) > 0) {
> > +               class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +               level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +               hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +               activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > +               activity += (bio->bi_vcnt <= IOPRIO_NR_ACTIVITY && PageWorkingset(page)) ? 1 : 0;
> > +               bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);
> > +       }

why are BIO_ADD_PAGE and BIO_ADD_FOLIO so very different from each
other?

> >  static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
> > -                                         int priohint)
> > +               int priohint)

why did you change this whitespace?

> >  {
> >         if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> > -           IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > -           IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> > +                       IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > +                       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))

ditto

> >                 return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> >
> >         return (prioclass << IOPRIO_CLASS_SHIFT) |
> >                 (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> >  }
> > -

more gratuitous whitespace change


