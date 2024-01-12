Return-Path: <linux-fsdevel+bounces-7895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B882C7D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 00:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E4A1C218FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796918EB6;
	Fri, 12 Jan 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Av4Gp9de"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03C18EAB;
	Fri, 12 Jan 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sCXUOVTIXHWdxnQX+KXqJPZOClNl3Kvidy09Hlwr4fE=; b=Av4Gp9desBF+IfZ/bHXiMP5Ngl
	0v+1TddVS+l82jaBrLX2JGZ8Ew5BoTL1Yf0KJel+5RoVXsntIN3aLv0KKRt7TpjBf5lCaL555tAbA
	8RR/dwUlCHidTUs6L3KYrU29stvGsvHu/3isaTbOeMLvoFYyESoCBF6hgrIonJKlSH6yMbliK8WvG
	6Frf0Re1E3QFBe+99tQNKtSIfUggZwVBFoKBKUxi2sRrtC95Sdfz0L6cgUp9KD0EU46wr80d3VbvA
	GBGe8fbn2WBLCpJrizgdIJIHtx8xWDGC7c3zYz3zDGnJ2L9PkLnQeNJaWO+2pWeMfVQGu3+Om9oTa
	sDe/9P+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rOQZQ-0016mt-K9; Fri, 12 Jan 2024 23:04:12 +0000
Date: Fri, 12 Jan 2024 23:04:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1] mm/filemap: Allow arch to request folio size for
 exec memory
Message-ID: <ZaHFbJ2Osd/tpPqN@casper.infradead.org>
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
 <CAGsJ_4xPgmgt57sw2c5==bPN+YL23zn=hZweu8u2ceWei7+q4g@mail.gmail.com>
 <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com>
 <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
 <CAGsJ_4y8ovLPp51NcrhTXTAE0DZvSPYTJs8nu6-ny_ierLx-pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y8ovLPp51NcrhTXTAE0DZvSPYTJs8nu6-ny_ierLx-pw@mail.gmail.com>

On Sat, Jan 13, 2024 at 11:54:23AM +1300, Barry Song wrote:
> > > Perhaps an alternative would be to double ra->size and set ra->async_size to
> > > (ra->size / 2)? That would ensure we always have 64K aligned blocks but would
> > > give us an async portion so readahead can still happen.
> >
> > this might be worth to try as PMD is exactly doing this because async
> > can decrease
> > the latency of subsequent page faults.
> >
> > #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >         /* Use the readahead code, even if readahead is disabled */
> >         if (vm_flags & VM_HUGEPAGE) {
> >                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> >                 ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> >                 ra->size = HPAGE_PMD_NR;
> >                 /*
> >                  * Fetch two PMD folios, so we get the chance to actually
> >                  * readahead, unless we've been told not to.
> >                  */
> >                 if (!(vm_flags & VM_RAND_READ))
> >                         ra->size *= 2;
> >                 ra->async_size = HPAGE_PMD_NR;
> >                 page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> >                 return fpin;
> >         }
> > #endif
> >
> 
> BTW, rather than simply always reading backwards,  we did something very
> "ugly" to simulate "read-around" for CONT-PTE exec before[1]
> 
> if page faults happen in the first half of cont-pte, we read this 64KiB
> and its previous 64KiB. otherwise, we read it and its next 64KiB.

I don't think that makes sense.  The CPU executes instructions forwards,
not "around".  I honestly think we should treat text as "random access"
because function A calls function B and functions A and B might well be
very far apart from each other.  The only time I see you actually
getting "readahead" hits is if a function is split across two pages (for
whatever size of page), but that's a false hit!  The function is not,
generally, 64kB long, so doing readahead is no more likely to bring in
the next page of text that we want than reading any other random page.

Unless somebody finds the GNU Rope source code from 1998, or recreates it:
https://lwn.net/1998/1029/als/rope.html
Then we might actually have some locality.

Did you actually benchmark what you did?  Is there really some locality
between the code at offset 256-288kB in the file and then in the range
192kB-256kB?

