Return-Path: <linux-fsdevel+bounces-45670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C24A7A8CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054A37A6245
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B62517BE;
	Thu,  3 Apr 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nl/vq4hP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB92512D7;
	Thu,  3 Apr 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702266; cv=none; b=ZkgjLiUNXg17IRHZ7dhp2ICnB5aDISL5m78vFgDZ4hLLF41nTgcEwgZTgVqbMYkGIWDooepS2cEXpB2NTkZFYGArHiiX5W3M1ido2SDsnzUUxeYYQ6fdqfoqxTgASl99Y6GWKdxvbW+mzUdd62UKW6Ph0z6Cml/6ZY273wvRaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702266; c=relaxed/simple;
	bh=2k/M/IytbGPTT46+syVtjeXIilg4EhbveiCgLEZgIoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcfC9Eu+DOgcf/nh0wdBgYN3uoEc8UFSVEop4pTCAs4zeE/IK53ig3HpUjagom4MdLKkTNNoaxJPBzrlp9fk78bU6lA2awukM+/b3iHc6cqeckYnbXhaOJMBX68xjq3HTf69YRX3XVptEVgA8/MW/NPXe+uK2uP8C7EFWWw138w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nl/vq4hP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5bCE/e2+eVXHTwCCmYdkChzX3931MOPxX+eV7bSag/U=; b=nl/vq4hPPV2slo8lQS9KTGLAhW
	6HT134e/y+NZ35rY3CdmUXCSkbL80OApd2x+j6ZZdgRWFNVvK+Oo7UKFGHIA+Oa806RrDdDmAb3bV
	izWJCkr2/Of7CnP3qDjiTLx+h8IBMTVhDYyeVgJaVZ0jLmK6uf4URDQvcX+vym6kRYEFRgybeh0hQ
	w+XUonev7HTQeJOpUVPYihT/xxjQD60dOfBP/1tb3PmewCtnuRPQxfL+6KSruHCKZzAWT6wlrs60U
	SfvbpVqqbcmErdNuypbivLXijOP3Wsk6g9/2vCP/Op8cpATSj62osNgmmHqRyweRtPSMw6Eh9rTXq
	vJqZSuTg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Oc2-0000000DPFq-29E2;
	Thu, 03 Apr 2025 17:44:22 +0000
Date: Thu, 3 Apr 2025 18:44:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Proper way to copy de-compressed data into a bio, in folio style?
Message-ID: <Z-7I9hOcGzQMV3hq@casper.infradead.org>
References: <17517804-1c6b-4b96-a608-8c3d80e5f6dd@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17517804-1c6b-4b96-a608-8c3d80e5f6dd@gmx.com>

On Mon, Mar 31, 2025 at 06:45:10PM +1030, Qu Wenruo wrote:
> Hi,
> 
> The seemingly easy question has some very interesting extra requirements:
> 
> 1. The bio contains contig file map folios
>    The folios may be large.
>    So page_offset() on bv_page (using single-page bvec) is no longer
>    reliable, one has to call page_pgoff() instead.

page_offset() is on my hitlist.  It actually is correct now (commit
12851bd921d4) but it's on its way out.  Don't use bv_page.

> 2. The data may not cover the bio range
>    So we need some range comparison and skip if the data range doesn't
>    cover the bio range.

I have no idea what this means.

> 3. The bio may have been advanced
>    E.g. previous de-compressed range has been copied, but the remaining
>    part still needs to be fulfilled.
> 
>    And we need to use the bv_page's file offset to calculate the real
>    beginning of the range to copy.
> 
> The current btrfs code is doing single page bvec iteration, and handling
> point 2 and 3 well.
> (btrfs_decompress_buf2page() in fs/btrfs/compression.c)
> 
> Point 1 was not causing problem until the incoming large data folio
> support, and can be easily fixed with page_pgoff() convertion.
> 
> 
> But since we're here, I'm also wondering can we do it better with a
> folio or multi-page bvec way?
> 
> The current folio bio iteration helper can only start from the beginning
> of a bio (bio_for_each_folio_all() and bio_first_folio()), thus it's not
> a good fit for point 3.
> 
> On the other hand, I'm having some internal code to convert a bio_vec
> into a folio and offset inside the folio already.
> Thus I'm wondering can we provide something like bio_for_each_folio()?
> Or is it too niche that only certain fs can benefit from?

I don't understand your requirements. but doing something different that
fills in a folio_iter along the lines of bio_for_each_folio_all()
would make sense.

