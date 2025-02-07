Return-Path: <linux-fsdevel+bounces-41175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2BA2BFD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888D51694FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FF1DE2BC;
	Fri,  7 Feb 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yjhsg53q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE41DBB19;
	Fri,  7 Feb 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921567; cv=none; b=QyFSzAM9ffn7YczNvqjpA2Q2n5BP0bZ2jm4agZKJn2C1sB9Hnfzhcir0SIl3eG7QC79nJaYzxBg2mrqRIN6zL1LjB2tVnL4hR1JbBHhsi2IzhlSkjmHIBN+fWH2p4RjkQT1HY2bQt7BJLq8Nb9Vo3D1O40pin3hxRZHfyHuOlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921567; c=relaxed/simple;
	bh=rgg02ZsawL7QPiaKZkTqlRS6YDudufJcoKa76XW3SKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8G9oTKe6BUOVb3CTWPWl+AvDuwEexqBzG9X+ZZEtcE3eIiv22hMIXrkJS5brCvV0d9kSVdQ6Fuh8J0dNBBwrTYYwCG9rkxNaWlG3iMbeY+GvVMCVqtVF8Okm/0r9SAx6nVQeX1GXJgHiNpx2X2PPEYhBvwXwt+USxObJGrz1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yjhsg53q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IMzKB492f3nWbCNdqT84e/AtK9JJ78xXLx+5/ghonRs=; b=Yjhsg53qtEGP03S/LtUWfeEYZL
	4K2M3alVdqO5XliS2fbN82ppCK2ts+nUDwUZQiqjqljtyb+M6KA1Jh8U+gcafh9crVf94j36++YZs
	3+ViZ2RlBy/D5ZR+FANQOyyp/2GtDrmxEcgoYJI4K4AEyENW9GmO/EGLy5k698yF57sxhx/UigRAs
	kC5YeE7SnjxVP17hZwTlIHOzo8xNNr7Ihxw+JKoAxxvVEe5lQcyProzHhqsgJNu4tRY4IlogwtxyL
	piUs8b8BKrhrbu9cqLWMuDijviMlCgI7PNmhvvdh3YAuzKeOskSZKeB1Y1O9eb4bxxfIZQLM5HvPZ
	Nfithstw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgKvt-00000007aP6-19jp;
	Fri, 07 Feb 2025 09:45:57 +0000
Date: Fri, 7 Feb 2025 09:45:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Heusel <christian@heusel.eu>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
Message-ID: <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>

On Fri, Feb 07, 2025 at 10:34:52AM +0100, Miklos Szeredi wrote:
> Seems like page allocation gets an inconsistent page (mapcount != -1)
> in the report below.

I think you're misreading the report.  _mapcount is -1.  Which means
mapcount is 0.

> > Feb 06 08:54:47 archvm kernel: BUG: Bad page state in process rnote  pfn:67587
> > Feb 06 08:54:47 archvm kernel: page: refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67587
> > Feb 06 08:54:47 archvm kernel: flags: 0xfffffc8000020(lru|node=0|zone=1|lastcpupid=0x1fffff)
> > Feb 06 08:54:47 archvm kernel: raw: 000fffffc8000020 dead000000000100 dead000000000122 0000000000000000

flags lru.next lru.prev mapping

> > Feb 06 08:54:47 archvm kernel: raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000

index private mapcount:refcount memcg_data

> > Feb 06 08:54:47 archvm kernel: page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set

So the problem is the lru flag is set.

> > Feb 06 08:54:47 archvm kernel:  dump_stack_lvl+0x5d/0x80
> > Feb 06 08:54:47 archvm kernel:  bad_page.cold+0x7a/0x91
> > Feb 06 08:54:47 archvm kernel:  __rmqueue_pcplist+0x200/0xc50
> > Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
> > Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
> > Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
> > Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
> > Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
> > Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0

It's very weird, because PG_lru is also in PAGE_FLAGS_CHECK_AT_FREE.
So it should already have been checked and not be set.  I'm on holiday
until Monday, so I'm not going to dive into this any further.


