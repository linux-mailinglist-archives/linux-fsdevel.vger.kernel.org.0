Return-Path: <linux-fsdevel+bounces-21939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C657890F7C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 22:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766602851A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290D15A864;
	Wed, 19 Jun 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wT58H6dQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B715380B;
	Wed, 19 Jun 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830262; cv=none; b=oE4i2nBgiu0ya2/hkTPConoDF4XiiD/u0quxcVF5to8oQYsCi63YlS3vJ4iakkSl/ZhwvxUIT7yFnnf9p+z54Edm/sfw9KqcA4a4O4IrQmkYZ5X5LqCN1ZOJk8MUFAiqPN2K1Cok/CCIThyETp2Yv34mT+VQDng4DV0USwKDop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830262; c=relaxed/simple;
	bh=W+VFTLb1T/xMLrOR7y2rzSCXnH8AzNcfF/orG0wy+x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLXyW2eSql9CpRClSZ4ixhjV2VRFwrJl4bsu5fhgn/CO68gtebyCXq5uD3sEbSU1T/TxiM9QBW93YhKCPiqP2ZCAxzvQ0VCXD466KbgaI3s0sOlGj+dQZMCfIiOeM97uGONK2SVMGOha+0DJAOYLx+a07Yy/h75u5k7Q4bvy7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wT58H6dQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JVhz1a62kqtoXiejfra1jlcYhqz5Za77doGhPHVC/qc=; b=wT58H6dQzCmfKNJI4KlnRiarAg
	eYBT3aVnQ7KmpTtQp2B/WpqE4mBR2Qmk9pOkkpGo+HvNpB4/6CSidceGYVlYSQCaInVmvi0hB/y8J
	O0Aa4FhbSPP1jWjXfaNlSW4fkp9Fc3O/eTb1JJ/KxF7r8qsQzBxFbupoo5YitpM9tUaPwUxfXGblh
	v0Krn8lb6hqkvugtR0J2EAvUEbP9Np5Yu5z2VbCjmADu6HP5YJ/GK2frj2a95MqdTLVaf2lGXBWr2
	AIPO2Dwl+PP/Dw8m2kXmmgc6b/uU48xcIPPutdRKSa9zXBb/e4/3spXkl56fVQOjofkCXMuTdCV2s
	m+S7tUlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK2Gf-00000005Agw-1MlJ;
	Wed, 19 Jun 2024 20:50:57 +0000
Date: Wed, 19 Jun 2024 21:50:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Zhenyu Zhang <zhenyzha@redhat.com>,
	Linux XFS <linux-xfs@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
Message-ID: <ZnNEsVtshehiR0A4@casper.infradead.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me>
 <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
 <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
 <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
 <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>

On Wed, Jun 19, 2024 at 08:48:28AM -0700, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 07:31, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Actually, it's 11.  We can't split an order-12 folio because we'd have
> > to allocate two levels of radix tree, and I decided that was too much
> > work.  Also, I didn't know that ARM used order-13 PMD size at the time.
> >
> > I think this is the best fix (modulo s/12/11/).
> 
> Can we use some more descriptive thing than the magic constant 11 that
> is clearly very subtle.
> 
> Is it "XA_CHUNK_SHIFT * 2 - 1"
> 
> IOW, something like
> 
>    #define MAX_XAS_ORDER (XA_CHUNK_SHIFT * 2 - 1)
>    #define MAX_PAGECACHE_ORDER min(HPAGE_PMD_ORDER,12)
> 
> except for the non-TRANSPARENT_HUGEPAGE case where it currently does
> 
>   #define MAX_PAGECACHE_ORDER    8
> 
> and I assume that "8" is just "random round value, smaller than 11"?

It's actually documented:

/*
 * There are some parts of the kernel which assume that PMD entries
 * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
 * limit the maximum allocation order to PMD size.  I'm not aware of any
 * assumptions about maximum order if THP are disabled, but 8 seems like
 * a good order (that's 1MB if you're using 4kB pages)
 */
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
#define MAX_PAGECACHE_ORDER     HPAGE_PMD_ORDER
#else
#define MAX_PAGECACHE_ORDER     8
#endif

although I'm not even sure if we use it if CONFIG_TRANSPARENT_HUGEPAGE
is disabled.  All the machinery to split pages is gated by
CONFIG_TRANSPARENT_HUGEPAGE, so I think we end up completely ignoring
it.  I used to say "somebody should do the work to split out
CONFIG_LARGE_FOLIOS from CONFIG_TRANSPARENT_HUGEPAGE", but now I think
that nobody cares about the architectures that don't support it,
and it's not worth anybody's time pretending that we do.

