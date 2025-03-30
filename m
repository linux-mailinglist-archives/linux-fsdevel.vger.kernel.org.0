Return-Path: <linux-fsdevel+bounces-45296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D7A759E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B7C188956E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A91C460A;
	Sun, 30 Mar 2025 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0GkGU+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277532BB04;
	Sun, 30 Mar 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336257; cv=none; b=b8hx3XdtnBiyJ6fUkSGar0Jo7L/ZYgn6qWf3Xl3EvUt1NDM8iRWM/0Pf8y5IsD/vJMZrEWRY4qGTzCoJi1xOGHCsyvg3kF8b8x8w4oCRvOiFNNg9+So0FmZDWAthG9/cV4ygAQ1X2JfG9nf4sgzNNoM5VoUw/OSIJXDmPefMxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336257; c=relaxed/simple;
	bh=j8I7Y4X262Zlf2k8C6vN5Flngo160/1EeL7FXB8cA3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQG+XCWLrsZj/rysOdxLnCARvubVWPJd5fhlXd7GH59GFj7BP8A3hP/OjnUOI7+Gd6IDdQ2dTB+uDGD2pm9+MFBBXTBf/ZqB8uePURq3yx/4zEWmz/oPifo2OfEwyNnJIFyVB++PWz10Ga//5HdK8QZpIR01EQd/yoz88BuFQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q0GkGU+6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=voDv8EMh3wDI8Ol9zgDNGOFRR3qzvAQIM67ZjI3SCz8=; b=q0GkGU+6GJ3rbA/gqQ0Af/LEyg
	b4UR04DsVRCaisDDpggnecveh2T2HG2hI3FYGxHsV1yK2jwXaHKw8+5hJeqAeB4TBDUiZJBV7sK5/
	e4ntTTvaW7srOCXgoxG6mHOKljPVQ2BnECSogx8ttaFZu3ZML+5CIYNQ2a7wgaCcuVvrBcPdVvUYW
	lbIbWtB2ftNtQf31ZMqCRR3mV8C2Pyrtf6kKqRPN4VOnuGrPyjUuCTvFG6iV5og6xRBvpgwMhFmma
	Yd1uPj0T2gQ+64/f6JemxhVYWoP36361IdpKdNI+arvw72ypRh9rXc64cLBtR3gNUANvGtPGC4Ot0
	4R2A6eUg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyrOU-00000004M53-2Dfn;
	Sun, 30 Mar 2025 12:04:02 +0000
Date: Sun, 30 Mar 2025 13:04:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, hannes@cmpxchg.org, oliver.sang@intel.com,
	dave@stgolabs.net, david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()
Message-ID: <Z-kzMlwJXG7V9lip@casper.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330064732.3781046-2-mcgrof@kernel.org>

On Sat, Mar 29, 2025 at 11:47:30PM -0700, Luis Chamberlain wrote:
> However tracing shows that folio_mc_copy() *isn't* being called
> as often as we'd expect from buffer_migrate_folio_norefs() path
> as we're likely bailing early now thanks to the check added by commit
> 060913999d7a ("mm: migrate: support poisoned recover from migrate
> folio").

Umm.  You're saying that most folios we try to migrate have extra refs?
That seems unexpected; does it indicate a bug in 060913999d7a?

> +++ b/mm/migrate.c
> @@ -751,6 +751,8 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>  {
>  	int rc, expected_count = folio_expected_refs(mapping, src);
>  
> +	might_sleep();

We deliberately don't sleep when the folio is only a single page.
So this needs to be:

	might_sleep_if(folio_test_large(folio));

>  	/* Check whether src does not have extra refs before we do more work */
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
> -- 
> 2.47.2
> 

