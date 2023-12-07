Return-Path: <linux-fsdevel+bounces-5285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA11809746
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 01:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F4FB209F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF316FA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqhWqtmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023E1720;
	Thu,  7 Dec 2023 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YO6MVl02oBiITEYrEywlC3LVDyTUqOlWipn5vN0fmhA=; b=gqhWqtmpvP9SALAF/Q1zmqoGHm
	HxMwUKrMpAPGfReElYZa/S3TvjzUkkyxt10c7razZ5wU/hSxDRc3RN+qkzI4JtEhv37wXZd9YSbbS
	jmePUN0WrspPoPUXkxLQOf7YyHxFy1OiHeXOzAdUxMBynWUHg342NjmGGP19/c1f9GAzvI+qJMQYw
	n4937Xk5nGkIBOJPaceqsLyaBJkOgp/i2Yeaa/1eCg4UW6P61UajreLPS91lO2endUQfeifDbnTti
	kRHruEUK3J0P+gpL56LlxdthWqnXJR3WCc6ztejMQz4wuBkPMZW5ovM7EQDeY0a9vMaw1w0ZXJUcU
	e9k8dAbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBOEp-004cCW-JH; Thu, 07 Dec 2023 23:57:03 +0000
Date: Thu, 7 Dec 2023 23:57:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZXJbz2F6xi/ZGnsP@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <ZXJCxbAm1_V7lPnF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJCxbAm1_V7lPnF@kbusch-mbp>

On Thu, Dec 07, 2023 at 03:10:13PM -0700, Keith Busch wrote:
> On Mon, Aug 14, 2023 at 03:41:00PM +0100, Matthew Wilcox (Oracle) wrote:
> >  void __bio_release_pages(struct bio *bio, bool mark_dirty)
> >  {
> > -	struct bvec_iter_all iter_all;
> > -	struct bio_vec *bvec;
> > +	struct folio_iter fi;
> > +
> > +	bio_for_each_folio_all(fi, bio) {
> > +		struct page *page;
> > +		size_t done = 0;
> >  
> > -	bio_for_each_segment_all(bvec, bio, iter_all) {
> > -		if (mark_dirty && !PageCompound(bvec->bv_page))
> > -			set_page_dirty_lock(bvec->bv_page);
> > -		bio_release_page(bio, bvec->bv_page);
> > +		if (mark_dirty) {
> > +			folio_lock(fi.folio);
> > +			folio_mark_dirty(fi.folio);
> > +			folio_unlock(fi.folio);
> > +		}
> > +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> > +		do {
> > +			bio_release_page(bio, page++);
> > +			done += PAGE_SIZE;
> > +		} while (done < fi.length);
> >  	}
> >  }
> 
> Is it okay to release same-folio pages while creating the bio instead of
> releasing all the pages at the completion? If so, the completion could
> provide just the final bio_release_page() instead looping. I'm more
> confirming if that's an appropriate way to use folios here.

For this patch, I'm just replicating the existing behaviour.  We can
probably do much better.  Honestly, the whole thing is kind of grotesque
and needs to be reformed ... but I think that's part of the physr project.

