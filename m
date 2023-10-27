Return-Path: <linux-fsdevel+bounces-1459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702547DA3E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590A01C21234
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED933FE56;
	Fri, 27 Oct 2023 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lYDpW1SK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA038BAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:59:40 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E68E1;
	Fri, 27 Oct 2023 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/b31X85rDY3RIAtoyt6o3DXcSD7ZeMjynMbPhM+cnGQ=; b=lYDpW1SKj5uC6mVUeaKjMvd7l+
	O2uDbXCwWRBFgef8yRgN23C+/gEhziodyFziOJ6oaP51KwkdopCYKxrCZIXhMJSef6YiZa+WL4m66
	7we11LFnmiy4hYC1YBJr/r/zhDDqoclfIlH9iKO63rMkCMYx/jt0XX5KOXV0suYvrR+x5OfWpX4Hx
	7mVGhxCdKqX81DnpH961r/KgbJayguHM8ujAfDCcGlZblSz9KyQXbgSW6uRnGNyJdxQVIAsG6/Esr
	BFZE/10Ys6gbPX84wBBluD7UHF2EAKI7gGHyut7f0wEeDRL8GlvlrGhCuBzbuJaRtREwiX5z70qJf
	MlpZxUpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qwVnd-0061oB-Bk; Fri, 27 Oct 2023 22:59:29 +0000
Date: Fri, 27 Oct 2023 23:59:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <kernel@pankajraghav.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, mcgrof@kernel.org, da.gomez@samsung.com,
	gost.dev@samsung.com, david@fromorbit.com
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Message-ID: <ZTxA0TRYivu/vSsA@casper.infradead.org>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
 <CGME20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669@eucas1p2.samsung.com>
 <20231027051847.GA7885@lst.de>
 <1e7e9810-9b06-48c4-aec8-d4817cca9d17@samsung.com>
 <ZTuVVSD1FnQ7qPG5@casper.infradead.org>
 <3d65652f-04c7-4240-9969-ba2d3869dbbf@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d65652f-04c7-4240-9969-ba2d3869dbbf@samsung.com>

On Fri, Oct 27, 2023 at 05:41:10PM +0200, Pankaj Raghav wrote:
> On 27/10/2023 12:47, Matthew Wilcox wrote:
> > On Fri, Oct 27, 2023 at 10:03:15AM +0200, Pankaj Raghav wrote:
> >> I also noticed this pattern in fscrypt_zeroout_range_inline_crypt().
> >> Probably there are more places which could use a ZERO_FOLIO directly
> >> instead of iterating with ZERO_PAGE.
> >>
> >> Chinner also had a similar comment. It would be nice if we can reserve
> >> a zero huge page that is the size of MAX_PAGECACHE_ORDER and add it as
> >> one folio to the bio.
> > 
> > i'm on holiday atm.  start looking at mm_get_huge_zero_page()
> 
> Thanks for the pointer. I made a rough version of how it might
> look like if I use that API:

useful thing to do.  i think this shows we need a new folio api wrapping
it.  happy to do that when i'm back, or you can have a crack at it.

your point about it possibly failing is correct.  so i think we need an
api which definitely returns a folio, but it might be of arbitrary
order.

>         bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>         bio->bi_private = dio;
>         bio->bi_end_io = iomap_dio_bio_end_io;
> 
> -       __bio_add_page(bio, page, len, 0);
> +       if (!fallback) {
> +               bio_add_folio_nofail(bio, page_folio(page), len, 0);
> +       } else {
> +               while (len) {
> +                       unsigned int io_len =
> +                               min_t(unsigned int, len, PAGE_SIZE);
> +
> +                       __bio_add_page(bio, page, io_len, 0);
> +                       len -= io_len;
> +               }
> +       }
> +
>         iomap_dio_submit_bio(iter, dio, bio, pos);

then this can look something like:

	while (len) {
		size_t size = min(len, folio_size(folio));

		__bio_add_folio(bio, folio, size, 0);
		len -= size;
	}

> PS: Enjoy your holidays :)

cheers ;-)

