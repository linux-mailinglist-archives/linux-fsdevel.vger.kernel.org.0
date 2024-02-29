Return-Path: <linux-fsdevel+bounces-13212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED386D3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F64286FA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692613F459;
	Thu, 29 Feb 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZk0KDwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306D13442F;
	Thu, 29 Feb 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236419; cv=none; b=V6S+Wx0de1LEKgrGTpWMteX/HP70LWPNJQHT7hvPS0JZR3JCwzbYDOT38TwgyBraKkA02KA4YSrhqIsTBB80A6V2Wil28An3FeWyHe6FleUaxXETQ+jr1U/3JOns5OV1QUDt+eJNifQUZNTTqUXS4Q9TV43PUsCRzs9cLdLtgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236419; c=relaxed/simple;
	bh=R1BZ2B3YZgTUGmT4mMT7KfnkAaZyyAG23JCeCS4OagM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgFcxL5qZsP7WcCYtswefl4Y3HRrSHjB9yrssorWoPJ8gwB4a1gJKctVBxGPPRTq0IM2BqNc+uuAoESo+SkaeKgO5MrZGcYunlLAdFN6XDTsbtdXJHxWeRuu+HCO2UzeHHQIkWf2f+QgwokGaczs3n9B+G/K2sw/4i6R3/zZjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kZk0KDwg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bb0wm2nkTd/whNJaK5PnfQ4qYt8CNWiFcGX/Paukpmw=; b=kZk0KDwgDkN4bmFPAagPUbZC2G
	sBTzbBpYG7E0r2P/i9p0uGtviBLPYrIcMiftyKU78jeLhFaPGFyMv8zxJrE+Z6YzMT4kj04Un7Zgj
	h7ITshosnFYQ1n/W8eV2VYO0pVID6ghAUizomEF2pT2sxACIvx+oTbzoIwnaOZgslvwgIIJ4x6pCP
	IJRnYitWHvGJEx/rWTVdtMWgiKwfrIwksn87VbFzuq/fCjeuGcjImN5eyrceaBjmObYg/u20wuSAL
	LfbYtxmtm58zHi3o/k6B3DRdOurGOSgw4FimgiB/Z0kum0N5jbn0aFyYxXFZ9VMK+Kwzl42ZusQYy
	g9Ks4m5A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfmTC-00000008t28-06bC;
	Thu, 29 Feb 2024 19:53:30 +0000
Date: Thu, 29 Feb 2024 19:53:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Message-ID: <ZeDguZujxets0KtD@casper.infradead.org>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>

On Thu, Feb 29, 2024 at 01:08:09PM -0500, Tony Battersby wrote:
> Fix an incorrect number of pages being released for buffers that do not
> start at the beginning of a page.

Oh, I see what I did.  Wouldn't a simpler fix be to just set "done" to
offset_in_page(fi.offset)?

> @@ -1152,7 +1152,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct page *page;
> -		size_t done = 0;
> +		size_t nr_pages;
>  
>  		if (mark_dirty) {
>  			folio_lock(fi.folio);
> @@ -1160,10 +1160,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  			folio_unlock(fi.folio);
>  		}
>  		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> +		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> +			   fi.offset / PAGE_SIZE + 1;
>  		do {
>  			bio_release_page(bio, page++);
> -			done += PAGE_SIZE;
> -		} while (done < fi.length);
> +		} while (--nr_pages != 0);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__bio_release_pages);

The long-term path here, I think, is to replace this bio_release_page()
with a bio_release_folio(folio, offset, length) which calls into
a new unpin_user_folio(folio, nr) which calls gup_put_folio().

