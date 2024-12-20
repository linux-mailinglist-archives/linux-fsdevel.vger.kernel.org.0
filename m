Return-Path: <linux-fsdevel+bounces-37936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C29F9496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FC9166CE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BAF1C4A05;
	Fri, 20 Dec 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHlHJ01A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D11F9F5D;
	Fri, 20 Dec 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705494; cv=none; b=F6ArePK1yzcsKUqx3Mac/rwxM9PXpWkiJ9ntb2gHwvEjyHnnoaHue+n+BDUyvvd96zwj+fVQkJIR+ICrlX73+41LhDvkXlg3Umj3PVKt7SEm/sCV8hW4tFMTItLPM6RtP/p0PHKWWHkw5Ot87F2LS/HJEc+CTyJCj3g/ukX2L2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705494; c=relaxed/simple;
	bh=cGY77eiczGU1Rg+Vf8forh4NbVK3Xow3FkmOxlJ3mvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzKKljFyRIB6oVppwgijXtZ0JUcIinMVG2kkylphGsij80LO9CRDauw79cVkpqzfrzSaUJ7s/eU0F60A1VbU6Wgujbi+5I7qqudEY+rp3dOBFpvTm7SJjmFi5bPvVy4W9Vx1bVDJJK0vhmWyibAnyOi0hGYudJYF41P6wT1kiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GHlHJ01A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gnUDRwXu5Oc0MjSPV/TNquo8RX99rNYEuhTQmuOlvNQ=; b=GHlHJ01AHRmRKTBcEp3F+m0Cwc
	OaZFXHbkQ8Sb0qYr0vG6mKmPQ0yho3lMkGfPHdqKQO4/PrwAsQga2iTHfnK1sFxXFjKqcmuDp3Lgh
	5zyCMbVXbWsDVuZ29vWe5XW45C6e3oXsxEQ9VdlwTfjzWPbsUKwF4ahu9nRjRnwRU14nzXGmESkE6
	Kc4aN+1LbwQ6jPtM1Mf67bV4aE6nQp97y23JRWdvHFZzVNoFv9jFyGCgD95tfqdSwIwzfAtnX/+VY
	poQ2Re5U3u6sC8c5k8UhhXkdiTNB5EysxZ23xXpSUHrMBk0A2wFY5UdnVtadkC99dDSH8Q+BHvzKt
	sRYQkeaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOe8n-000000013C3-29L3;
	Fri, 20 Dec 2024 14:38:09 +0000
Date: Fri, 20 Dec 2024 14:38:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, bfoster@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
Message-ID: <Z2WBUX2OKLinNuFZ@casper.infradead.org>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>

On Fri, Dec 20, 2024 at 01:08:39PM +0200, Kirill A. Shutemov wrote:
> On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
> > Add a folio flag that file IO can use to indicate that the cached IO
> > being done should be dropped from the page cache upon completion.
> > 
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> + David, Vlastimil.
> 
> I think we should consider converting existing folio_set_reclaim() /
> SetPageReclaim() users to the new flag. From a quick scan, all of them
> would benefit from dropping the page after writeback is complete instead
> of leaving the folio on the LRU.

Ooh, that would be nice.  Removes the overloading of PG_reclaim with
PG_readahead, right?

