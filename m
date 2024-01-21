Return-Path: <linux-fsdevel+bounces-8381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2008358D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 00:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B21C21D98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E339850;
	Sun, 21 Jan 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KlrlxiuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337E1EB52;
	Sun, 21 Jan 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881264; cv=none; b=AEqxCwTBCy3h6D/z6IRmWiAJVi8bgBaMALv6MeYmGPr3oemaM5w+R9k6zQa4JnLJW/pGsWf7l7o/jyRNggvOFitDcWBw4nk576h3pYsNX3DLFH206oX2agcFQfHtx51BkDIy/3jTGLoqWkry46APhLHaa/5m6s6sBxz1yN8kO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881264; c=relaxed/simple;
	bh=pG6uMYr51K4P9YCqHE7LZxc/PWTc8Wad4/Rm3LaGIXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXJPRIZkuCflwxglsU2bpxYBmLPCG2QCj3KMQ5uzBcSLnn8n5KDIUTexr3LKk/dutaW1wubuU4wzKev456TLYDuweX0lqsyx+gttqVN0mLmt+4XUYQ9w2f41GFkD3IgRHLn662O1uWc+dNU4lFu1NfZH+3J+9EKxVAuLQyzDQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KlrlxiuD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jA3IbLFtzAloHVLQrh6taOQq0+ILF1OF3dZLSLc3Sz8=; b=KlrlxiuDarLqJ8jOpV7msSXun3
	trX9vXalyMaMMqKa2fQXZnVPNXv71jjxs1wuHC3UyXAstE5rS6j9lhGOwaPnqcMuiMVrkVLFuWb8x
	6g6muDT0XpImvGHL7zZGiqTe5JfZMV8xl75Brz48rpGm2DO4tmo9qPflaSBNvzUXhpx98HiizJYIV
	hBUV3a1cKFLUQjS/WjUBCJR+eZpUrkUbAafe86MAWfizAkSphOagTE2mlabwZLUv+FJRURa8him/p
	j4A4YZwwVoBHvs8KVL8oHzwbqBPsUhfqk5dYNf+rYss+SPQ0dlxN46jdTQyFzjy0kPRuBI0M5DK/c
	XQlxijgw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRhdr-0000000ENNn-2P5G;
	Sun, 21 Jan 2024 23:54:19 +0000
Date: Sun, 21 Jan 2024 23:54:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Rientjes <rientjes@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Sourav Panda <souravpanda@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Za2uq2L7_IU8RQWU@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
 <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>

On Sun, Jan 21, 2024 at 06:31:48PM -0500, Pasha Tatashin wrote:
> On Sun, Jan 21, 2024 at 6:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I can add a proposal for a topic on both the PCP and Buddy allocators
> > (I have a series of Thoughts on how the PCP allocator works in a memdesc
> > world that I haven't written down & sent out yet).
> 
> Interesting, given that pcp are mostly allocated by kmalloc and use
> vmalloc for large allocations, how memdesc can be different for them
> compared to regular kmalloc allocations given that they are sub-page?

Oh!  I don't mean the mm/percpu.c allocator.  I mean the pcp allocator
in mm/page_alloc.c.

I don't have any Thoughts on mm/percpu.c at this time.  I'm vaguely
aware that it exists ;-)

> > Thee's so much work to be done!  And it's mostly parallelisable and almost
> > trivial.  It's just largely on the filesystem-page cache interaction, so
> > it's not terribly interesting.  See, for example, the ext2, ext4, gfs2,
> > nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> > I have about half of an ntfs3 patchset ready to send.
> 
> > There's a bunch of work to be done in DRM to switch from pages to folios
> > due to their use of shmem.  You can also grep for 'page->mapping' (because
> > fortunately we aren't too imaginative when it comes to naming variables)
> > and find 270 places that need to be changed.  Some are comments, but
> > those still need to be updated!
> >
> > Anything using lock_page(), get_page(), set_page_dirty(), using
> > &folio->page, any of the functions in mm/folio-compat.c needs auditing.
> > We can make the first three of those work, but they're good indicators
> > that the code needs to be looked at.
> >
> > There is some interesting work to be done, and one of the things I'm
> > thinking hard about right now is how we're doing folio conversions
> > that make sense with today's code, and stop making sense when we get
> > to memdescs.  That doesn't apply to anything interacting with the page
> > cache (because those are folios now and in the future), but it does apply
> > to one spot in ext4 where it allocates memory from slab and attaches a
> > buffer_head to it ...
> 
> There are many more drivers that would need the conversion. For
> example, IOMMU page tables can occupy gigabytes of space, have
> different implementations for AMD, X86, and several ARMs. Conversion
> to memdesc and unifying the IO page table management implementation
> for these platforms would be beneficial.

Understood; there's a lot of code that can benefit from larger
allocations.  I was listing the impediments to shrinking struct page
rather than the places which would most benefit from switching to larger
allocations.  They're complementary to a large extent; you can switch
to compound allocations today and get the benefit later.  And unifying
implementations is always a worthy project.

