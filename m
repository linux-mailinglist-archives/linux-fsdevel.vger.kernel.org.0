Return-Path: <linux-fsdevel+bounces-37417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B79F1C95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 05:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA5C188D8E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0278C91;
	Sat, 14 Dec 2024 04:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="maGOSbOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874518622;
	Sat, 14 Dec 2024 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734151604; cv=none; b=VBeQ5ZERye411SIwWyOT8Lb6dUibl/TVzak0BdsO0Rbr/6rVNIXBg/x4eYI4nU2Ab4i4yLeOebJV+RXiauf/pByzthcuJge9nW+cL/zlm1FzcdfQzxFEinHSfAJlBCvFcZPAmcSMi2jVWJrO/mXiBEgMYXgb1wJTAPhyztTohWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734151604; c=relaxed/simple;
	bh=MzzLpkmcDzRIAyM8rZexGDOLWhH6A5azUaK7zjHPwTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDXuUf59xoRUy4FwaivRvA1eScBOP/nuVtpOq3OST/5p0LJSpuR82Ksqsf+n11Bycq6VlX1XcncS0knYTf5XT0rVjp9qF+pE2i8ZmLr4ESjsgz9+hqlrUGmQucs9/+QjKhuoeqwFpX3zYIwFGQTfQe27/GN7XWmXFsK+oUPWsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=maGOSbOb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LBvcMzLgLUZ7yjxWvuyP5chLRa9Mf66kbV+gsgqNPrQ=; b=maGOSbOb/VQmndTbMTY6r5X+UG
	wY+IIgJHuU4sz7Yo3SS4Af/dDzJY7dKM9aQfJwz1p3nYdwvZHdMdYZNozYXv83bqKq2GR0czLwvPM
	aQ1ibVHgoB+PLP0AKXUozGXj3L1uOGOTxsAvUA25AN2YXubtnYDbqn7usWltXaDu7QuNzOAGCtgal
	GVOwov31E9M4v84wnCHupNStgKmKT5X8QqOOjDhL3OTzA9FVc3oqCKpgEliEyGmoJaolLTfBBR/sK
	dohYW5snlXhICQVWrtuSB5BRimCvlRJZHa0gtNaQgKAxn6ikr7v+VFcj5ipo+cGEKNVBDGfZxlcC5
	b/RxKN/w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMK2z-00000000MX5-1YvQ;
	Sat, 14 Dec 2024 04:46:33 +0000
Date: Sat, 14 Dec 2024 04:46:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 05/11] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z10NqQtIX5g7oi8c@casper.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-6-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214031050.1337920-6-mcgrof@kernel.org>

On Fri, Dec 13, 2024 at 07:10:43PM -0800, Luis Chamberlain wrote:

Something is wrong here ... I'm just not sure what (nor am I sure why
testing hasn't caught it).

> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;

OK, fine ...

> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;

So we've scaled up the right hand side of this, that's good.

> @@ -385,7 +385,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
>  {
>  	struct mpage_readpage_args args = {
>  		.folio = folio,
> -		.nr_pages = 1,
> +		.nr_pages = folio_nr_pages(folio),

Oh, but we've also scaled up the left hand side.  So instead of being,
say, 4 times larger, it's now 16 times larger.

Now, where do we use it?

                if (block_in_file < last_block) {
                        map_bh->b_size = (last_block-block_in_file) << blkbits;
                        if (args->get_block(inode, block_in_file, map_bh, 0))
                                goto confused;

so we're going to ask the filesystem for 4x as much data as we actually
need.  Guess it'll depend on the filesystem whether that's a bad thing
or not.

I guess I think the right solution here is to keep working in terms of
pages.  readahead_count() returns the number of pages, not the number of
folios (remember we can have a mix of different size folios in the same
readahead_batch).

But I can be argued with.

