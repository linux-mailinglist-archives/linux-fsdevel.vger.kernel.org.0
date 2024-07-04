Return-Path: <linux-fsdevel+bounces-23134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9292785E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CCC1F2433C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F31B011C;
	Thu,  4 Jul 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vm8Ngrou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABB1AE0AB;
	Thu,  4 Jul 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103401; cv=none; b=T9YjfrTBEquS5MWTQlu1wUh7USduLV6dHJX0TNS1+HjgykJNFMPoOJg5O0gtcLbGCqAxQL6BDjmArJ13PdtsccRZ2Cb8AqT4qFRzXrdPiBqtgQUagqMBMysOa8Mwq+A+QG3c7tL5Sg93zYXn2Effg+LKEpJjnCCZOZ0/LfQBods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103401; c=relaxed/simple;
	bh=eSy8SYdM2M3cyMC6FwpAcsaHVc53RoA/LXllcgBPfIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtaWYQ+6teJ3fwCaLoUICmfhyZQ9+EdviKDmMeSEVC3i0y/R9Sv8WynnEv27rcdRXC2acKPhgl99pKOJ+k6NigWY+xCWvw77GYNd+L7x+DKZg5q5zFvXfOdJ62eQoHfsXXb3rvcuubgSGcOE9d6w2A2e4r5EC0O/6UqFDT7DR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vm8Ngrou; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Enu1N6gk1voQoov0gxRGHrtuHCfIvfGXa28Px1K5WpM=; b=vm8Ngrou02qz4Ib5mffZwNGQZl
	IyaFQ3g17dLdwT8o+mc8kq8K1iuGCFU6/DwMXKkWeDCu+ln7bMJyl/jMqN6i1dynQImA/pHHP4pvY
	2Ktm0BxsEy5JnNZGDr7GViK1/fQrzlJzPW5+ildcGB1eGQKdtvUd4Ga1R635z9bSN9RlbUIE6njyq
	KSoyUFoDFIobHWvVBF1jV1SgwqI2ys7PU8eNZbofKaLcAt0kx3PfCXT+eXVyDcBImMt1IHXGRcP+K
	lYYl5L6DjuSSj7LtgWvc2YAonwrhpJRSseSgkJ+jNHELCIY2TsAIP5L99YQX66FYVBsUB8O2TKGhQ
	+9vF92DQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPNSZ-00000002vlv-41mX;
	Thu, 04 Jul 2024 14:29:20 +0000
Date: Thu, 4 Jul 2024 15:29:19 +0100
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
Subject: Re: [PATCH v8 03/10] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <Zoaxv23qdu4T84Sm@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-4-kernel@pankajraghav.com>
 <98790338-0f86-4658-8dec-95e94b6d5c18@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98790338-0f86-4658-8dec-95e94b6d5c18@arm.com>

On Thu, Jul 04, 2024 at 03:24:10PM +0100, Ryan Roberts wrote:
> > @@ -240,12 +257,13 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			 * not worth getting one just for that.
> >  			 */
> 
> For the case that the folio is already in the xarray, perhaps its worth
> asserting that the folio is at least min_nrpages?

We'd have to get a reference on the folio to be able to do that safely.
Not worth it.


