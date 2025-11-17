Return-Path: <linux-fsdevel+bounces-68734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F332DC64756
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DB3F354754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061983328F3;
	Mon, 17 Nov 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jjh93+km"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6C31B82B;
	Mon, 17 Nov 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387004; cv=none; b=iDuyK3seuJcn3ZxxWgPV0tEpKr7TRVG2+EjJj9fqW7fmQ8dtLTvrwN5NK7oQ24ummno5p2mclIa6uf5gpmFw4mFGoWALktfkY/gbiqUdO7scg1MmiSkwjr7wixFu2/I/j1y7VI4Zo2VGTx02C2mngn7ZyYIWb4gueDx9p/l5cdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387004; c=relaxed/simple;
	bh=KnwUkpe7bz24RPLJCJ5lZs9XdB2oXkXKJIgzjZFUM1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRssK0vQ81ohUTdIDqnG/UqBIVqaNy2JXOXUmMi98vl8qaABjlu6jX13sgnFl8mHBWt9ZDVPib+xJUfWUQLeL7eCldHlZd4oWGnI5ahn7c6hzpz7A7U3lo5NHC/BhonnsM5h+KJ7buB2wyDBMJZehxOYh8dNCEIWqo8WvHlumaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jjh93+km; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9YVuu7zAULl0ixowM1tYF4wrONsB1jmbz+W8pAwYhcU=; b=Jjh93+kmr9SpMk/YF5lvhgC2u1
	ZlLsFwt+ATReBnLApmCMvDdJSY2oNVNipqTUPFWCQry6k8bU6FXiczgKhMtGrjOEm0kvGhrY+PTH5
	7aynII8OLBrKH8zYUJV1vdToERpFDa8P6bWYOHLmbH7JpYg29hoM3vHl0jll7oo+MHeVcxV21b3XJ
	S+kqdLRnmwBA75pDGLJDgsSWUY+NB3F2rS+32Suu8VkMT1mloxKDd1vZ8xc1rMCTp+DIYxKLls+fD
	oW0POF7znBkybXltQwPWEILV7jBbFvCKGZm952EKG3CmTi+AyRzaylIyPLpvyIbLFobnUvKx10mR9
	+7DS/e5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKzVY-0000000DtlN-38y7;
	Mon, 17 Nov 2025 13:43:04 +0000
Date: Mon, 17 Nov 2025 13:43:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, william.roche@oracle.com,
	tony.luck@intel.com, wangkefeng.wang@huawei.com,
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <aRsmaIfCAGy-DRcx@casper.infradead.org>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org>
 <aRqTLmJBuvBcLYMx@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRqTLmJBuvBcLYMx@hyeyoo>

On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> > But since we're only doing this on free, we won't need to do folio
> > allocations at all; we'll just be able to release the good pages to the
> > page allocator and sequester the hwpoison pages.
> 
> [+Cc PAGE ALLOCATOR folks]
> 
> So we need an interface to free only healthy portion of a hwpoison folio.
> 
> I think a proper approach to this should be to "free a hwpoison folio
> just like freeing a normal folio via folio_put() or free_frozen_pages(),
> then the page allocator will add only healthy pages to the freelist and
> isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
> which is too fragile.

Yes, I think it should be handled by the page allocator.  There may be
some complexity to this that I've missed, eg if hugetlb wants to retain
the good 2MB chunks of a 1GB allocation.  I'm not sure that's a useful
thing to do or not.

> In fact, that can be done by teaching free_pages_prepare() how to handle
> the case where one or more subpages of a folio are hwpoison pages.
> 
> How this should be implemented in the page allocator in memdescs world?
> Hmm, we'll want to do some kind of non-uniform split, without actually
> splitting the folio but allocating struct buddy?

Let me sketch that out, realising that it's subject to change.

A page in buddy state can't need a memdesc allocated.  Otherwise we're
allocating memory to free memory, and that way lies madness.  We can't
do the hack of "embed struct buddy in the page that we're freeing"
because HIGHMEM.  So we'll never shrink struct page smaller than struct
buddy (which is fine because I've laid out how to get to a 64 bit struct
buddy, and we're probably two years from getting there anyway).

My design for handling hwpoison is that we do allocate a struct hwpoison
for a page.  It looks like this (for now, in my head):

struct hwpoison {
	memdesc_t original;
	... other things ...
};

So we can replace the memdesc in a page with a hwpoison memdesc when we
encounter the error.  We still need a folio flag to indicate that "this
folio contains a page with hwpoison".  I haven't put much thought yet
into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other things"
includes an index of where the actually poisoned page is in the folio,
so it doesn't matter if the pages alias with each other as we can recover
the information when it becomes useful to do so.

> But... for now I think hiding this complexity inside the page allocator
> is good enough. For now this would just mean splitting a frozen page
> inside the page allocator (probably non-uniform?). We can later re-implement
> this to provide better support for memdescs.

Yes, I like this approach.  But then I'm not the page allocator
maintainer ;-)

