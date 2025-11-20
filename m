Return-Path: <linux-fsdevel+bounces-69254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C715C7586C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A82D356EFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065D36C589;
	Thu, 20 Nov 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kx1m9Bcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5533D6D2;
	Thu, 20 Nov 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658021; cv=none; b=SuLAQYm+VDdjGK7IuI3nW1iEfkTU07ZlLt3ZThADvU4J1+E7e5tqEtUS8htzH//1BHd+ZlQCG58A1Ta0wPA8cri2NitnnhTsSpU1zBiBEoor9cQv6YA7ILEuCsoidV3CIeBOzaJnzZG3afDW8hQv4tprrKB1f3aEFEOTJJ0r2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658021; c=relaxed/simple;
	bh=BTd+vQXQPl+C76Tq/JUAHFOL3Ruw9RqkWlJyEAZrfck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJsQ7wyCQlqxyjRHTdBc84SoicTLWnY6qkOEx8gL7qlWDLkEaCPwlqzNgMEQpD+2mrm8iCiLzkC/7b40Y7Nl50EHHRX2+hnqb9o5muYrQGWJ82v3Vp1HdrvXh5mHZZCbSM1YrYl24ohlYIF/hNbXfDdoAXXGD0DwznlwshcnX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kx1m9Bcg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=re2tiGZL7IZwaCp1/yGWEfyF4epuwIDXTzQ2HA1ACdI=; b=Kx1m9BcgcI0haXR+zGeSAWaIw9
	G0fPgYE3/vT6S94x5gDbWpNv9di7Oz6fLCKbHPUhUTEN5662TE8kzwSE2A+aRpkEXCFXXMHDKKbo3
	6WIsXxeKbgIwvJN93YZ6yV+NLX2cc+altMh+dmz5ZbvOEjHuDYYTKwPyvKQ/0Nocd1d02SjYt6P5L
	xpk0W8fKlUvLFB71q2xjiqXTxBbfAdGflCcv7A5adjSBE6PFDnYNRQg6SCBBdRnBdfmDyMm4nTt9B
	+q2Itwb7APatwg0U1FBtKNAZg36UO1tqyLl1oQlhYpmUd3T+rFRLfHDMcAMaTh81uI/s349eJi9jn
	PPccvL1g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM80l-00000001Vsl-0MTK;
	Thu, 20 Nov 2025 16:59:59 +0000
Date: Thu, 20 Nov 2025 16:59:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>, Chris Mason <clm@meta.com>
Subject: Re: [PATCH] mm/filemap: Fix logic around SIGBUS in
 filemap_map_pages()
Message-ID: <aR9JDud3PS-A_hcg@casper.infradead.org>
References: <20251120161411.859078-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120161411.859078-1-kirill@shutemov.name>

On Thu, Nov 20, 2025 at 04:14:11PM +0000, Kiryl Shutsemau wrote:
> Chris noticed that filemap_map_pages() calculates can_map_large only
> once for the first page in the fault around range. The value is not
> valid for the following pages in the range and must be recalculated.
> 
> Instead of recalculating can_map_large on each iteration, pass down
> file_end to filemap_map_folio_range() and let it make the decision on
> what can be mapped.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: 74207de2ba10 ("mm/memory: do not populate page table entries beyond i_size")h

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

