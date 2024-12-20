Return-Path: <linux-fsdevel+bounces-37951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A49F95BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26307189833B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC721A421;
	Fri, 20 Dec 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYVeaMKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5634218AA8;
	Fri, 20 Dec 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709546; cv=none; b=isyJAmHyJwOemeFg5YuoTOZrxgU66tajDoxsOgPYufHatpyGs/HNzlOzLUnCxm02m3GOimKz3iCc/3jHYttZPxRdQnfKj13dF7u4VAuJyEuXfUWpA0Prd7M8Ny7BIoKAyoa4fuQDvwMHw7Og8y2qQgPGKkDc4Kc+8w6Sf0N9K3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709546; c=relaxed/simple;
	bh=FnqPppNVT79YvtI/scQUXiurWf/idbYep2fCSTIEyow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Rt+KhadO6cnU4+t0zpKVffw8WVj/DNLJ+5oERr9SGLkwFv6aRxvhPrpO5CVkTXf1hnmp5QcHz38FcIU8lZWs2xJegMaEzpm/BSDfu9kmctmMtDvkSLFMab50QDwlWHYDeqU4e636+1Lz8+t85qasuOCkX5+Lqwfd21QdAUKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FYVeaMKf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ADkoGMO2JxzHiYj+/89UIFiOn06ntnkkir9AS5SdDQ=; b=FYVeaMKfhyK5aDN6y0lsuPUiCu
	XLbnXnhewNSfQ4MFzQRRsnqcmqnH0mTvyi4pO+BdmBxUlx8virgOeGX8uDl/UHehIHBEyF8TJnM+N
	7avexNpb9QHmugeC77ayMi8tqP1o8aD3cJxg9IUJ/hJNfpoSQHA3QZwMFccFoWTOUJqp2u0jf6kz1
	dXRhHhGE6QAO4GFF58GIon9/nb1vwIdcL+AboDhvXzLCfgx3VgA8/M+LbDmcuBMejhVpBlyA/lwHG
	rS9VBesRtghASXGg892ID8CEqTiFnslTQPatYFbBzwTn0Ekb9GdewEU+fJUafnXmoBNxgO8Drf9Df
	djbMyhhw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOfC9-00000001S0Q-3YiA;
	Fri, 20 Dec 2024 15:45:41 +0000
Date: Fri, 20 Dec 2024 15:45:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, bfoster@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
Message-ID: <Z2WRJdKnTD5eSfBS@casper.infradead.org>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
 <Z2WBUX2OKLinNuFZ@casper.infradead.org>
 <hyxlz2qomigaffzblpkcn6ds4ocnm6gi53lnxoy2d76j4nnlep@3gptla54rdou>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hyxlz2qomigaffzblpkcn6ds4ocnm6gi53lnxoy2d76j4nnlep@3gptla54rdou>

On Fri, Dec 20, 2024 at 05:11:52PM +0200, Kirill A. Shutemov wrote:
> On Fri, Dec 20, 2024 at 02:38:09PM +0000, Matthew Wilcox wrote:
> > On Fri, Dec 20, 2024 at 01:08:39PM +0200, Kirill A. Shutemov wrote:
> > > On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
> > > > Add a folio flag that file IO can use to indicate that the cached IO
> > > > being done should be dropped from the page cache upon completion.
> > > > 
> > > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > 
> > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > 
> > > + David, Vlastimil.
> > > 
> > > I think we should consider converting existing folio_set_reclaim() /
> > > SetPageReclaim() users to the new flag. From a quick scan, all of them
> > > would benefit from dropping the page after writeback is complete instead
> > > of leaving the folio on the LRU.
> > 
> > Ooh, that would be nice.  Removes the overloading of PG_reclaim with
> > PG_readahead, right?
> 
> Yep.

Then ... maybe this series should just coopt the PG_reclaim flag for its
purposes?

Going through the users:

lru_deactivate_file()
---------------------

Called due to mapping_try_invalidate() failing to invalidate.
Absolutely, get rid of this folio as quickly as possible.

pageout()
---------

Again, we're trying to get rid of this folio.  This time due to memory
pressure / reaching the end of the LRU list.  Yup, we want it gone.

shrink_folio_list()
-------------------

Again, end of the LRU (both cases in this function)

zswap_writeback_entry()
-----------------------

This is exactly the same case that Jens is adding.  The swapcache is
being used as a staging location, and we want the folio gone as soon as
writeback completes.


