Return-Path: <linux-fsdevel+bounces-33967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684309C101C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C448284CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95E21832F;
	Thu,  7 Nov 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cr6DtKJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F4322E;
	Thu,  7 Nov 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012777; cv=none; b=CUi8o4mFr/ZGjXOSoOWB7tZHNsXynT190UiGUWa7tvpNAW3Zy00SnWxd0jlkG7XEbjjH6nO2hAusQyCGCzRmVvMgpeS6On1/QxXTK2OIJptebbiwb19sCKNU02MKZlfp9JJJMylVGHnYtg2ebOOH4yUCTbL0FSDDP6KLVcawqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012777; c=relaxed/simple;
	bh=usptPoertbPSR+oleLXAHaIeE16gQoLLH+fSptWK5ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APTShylcMPfY3DSzAAUBnmotJhFdYlxeT7MG2IQSX9D1URQdf9rvCIS2cfqx1451WsXNnkWymx/kzSD6+4e5Lfibj84fwWRPYdfsXtrdaqoWHvUYyONNOvTMtToFOGaxsJ6GfOZAKGB4trKTVfPS9pDG8eLJBFotic2tNjm9DiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cr6DtKJg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yl+OOEXvHsPnP3J48r75DDPeER85xSNgZKhr4gd7Cm0=; b=Cr6DtKJgjYQEyswyIdkAroIYcg
	S7S3EuFJZAKezkZPFb8wXYhElk3wSVijoY+UpH8S3IdsaCceoEu+C+DHJHevrKbZ/9v0FOwekuYCx
	oyHQz21JO7AsDw0U1cgnC/2ne3Wx0s1e/Ts0upk6Opwvv36gSdYLvGL/9PYlT45X0a2cOshaGN1Ai
	SpyuOtvT+FoT86Q67vuqEy5ZNJVGde4IMU6pyTqU7l2iFd2PQyEyDiEt9jpwoZT2lyMF4Z+HIB5PJ
	1r53njx9wd8lEDAvlAzuSJ1ewANYeESfrBp37WqBPF9z/y5uD8oVVgyQBeYNowo9JT98ecPS07fFO
	QoHEhKRA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t99Uk-00000007NpN-1y8X;
	Thu, 07 Nov 2024 20:52:46 +0000
Date: Thu, 7 Nov 2024 20:52:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Asahi Lina <lina@asahilina.net>, Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <Zy0onj9R_VJnk17p@casper.infradead.org>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZylHyD7Z+ApaiS5g@dread.disaster.area>

On Tue, Nov 05, 2024 at 09:16:40AM +1100, Dave Chinner wrote:
> The DAX infrastructure needs the same changes for fsb > page size
> support. We have a limited number bits we can use for DAX entry
> state:
> 
> /*
>  * DAX pagecache entries use XArray value entries so they can't be mistaken
>  * for pages.  We use one bit for locking, one bit for the entry size (PMD)
>  * and two more to tell us if the entry is a zero page or an empty entry that
>  * is just used for locking.  In total four special bits.
>  *
>  * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
>  * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
>  * block allocation.
>  */
> #define DAX_SHIFT       (4)
> #define DAX_LOCKED      (1UL << 0)
> #define DAX_PMD         (1UL << 1)
> #define DAX_ZERO_PAGE   (1UL << 2)
> #define DAX_EMPTY       (1UL << 3)
> 
> I *think* that we have at most PAGE_SHIFT worth of bits we can
> use because we only store the pfn part of the pfn_t in the dax
> entry. There are PAGE_SHIFT high bits in the pfn_t that hold
> pfn state that we mask out.

We're a lot more constrained than that on 32-bit.  We support up to 40
bits of physical address on arm32 (well, the hardware supports it ...
Linux is not very good with that amount of physical space).  Assuming a
PAGE_SHIFT of 12, we've got 3 bits (yes, the current DAX doesn't support
the 40th bit on arm32).  Fortunately, we don't need more than that.

There are a set of encodings which don't seem to have a name (perhaps
I should name it after myself) that can encode any power-of-two that is
naturally aligned by using just one extra bit.  I've documented it here:

https://kernelnewbies.org/MatthewWilcox/NaturallyAlignedOrder

So we can just recycle the DAX_PMD bit as bit 0 of the encoding.
We can also reclaim DAX_EMPTY by using the "No object" encoding as
DAX_EMPTY.  So that gives us a bit back.

ie the functions I'd actually have in dax.c would be:

#define DAX_LOCKED	1
#define DAX_ZERO_PAGE	2

unsigned int dax_entry_order(void *entry)
{
	return ffsl(xa_to_value(entry) >> 2) - 1;
}

unsigned long dax_to_pfn(void *entry)
{
	unsigned long v = xa_to_value(entry) >> 2;
	return (v & (v - 1)) / 2;
}

void *dax_make_entry(pfn_t pfn, unsigned int order, unsigned long flags)
{
	VM_BUG_ON(pfn_t_to_pfn(pfn) & ((1UL << order) - 1) != 0);
	flags |= (4UL << order) | (pfn_t_to_pfn(pfn) * 8);
	return xa_mk_value(flags);
}

bool dax_is_empty_entry(void *entry)
{
	return (xa_to_value(entry) >> 2) == 0;
}

