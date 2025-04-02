Return-Path: <linux-fsdevel+bounces-45540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B4A793CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C430F16EC2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5801A238F;
	Wed,  2 Apr 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4+dWA8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAF19F419;
	Wed,  2 Apr 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614657; cv=none; b=SdSyzMSsCv9d2ibvfotxGxKoP7Sx4KRuwKY9WnXKdBYfwPC01MFx+WLu/lF6IQ4KaSDaiNcBGfjJCvAiVd2gO0EEN8hRyxy2CHSxLLlMl3Lu+FfNWqIFa8Tcqf4gwqgPtfML33/n0zKqDRua5JUiCeWJVhBILNPJzdGW8BPcpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614657; c=relaxed/simple;
	bh=Wwzzjx9epldMBp9XWXPdhD+aKU1In1RhITbbBIQz4+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+wtMpoNIXsyOCwb5mv1MFQd8/CkQ2RwEB8A9ijq1R4BgI3XJOXtsOdUsWN+DFRw8KZCY8BOnXDNuEcrI10t8PJEeY2b28/HeEDzzgXZF1ENBnTBkD1tTcxGmSLgFss09puM3qOgFvWkqDEMhqmamvkJgwvvrKtAeLSz6ztsqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F4+dWA8Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MMVZTZdsjCij0P4cHkp+t6GHi08BvbXKpnaZVEfTiDY=; b=F4+dWA8Y9u3OT/Z0M5fTeYt317
	imvas6j05UwKhvcab0A+nPC9h0MjmxyQxoc7oktwY790F9QGaOU9OkRGvjVzE0iGlV5ZxdDgOKRxe
	S6T1g8faxTnJD7XGQbf3VC+iGa/yyAFxlRP/KYHS+C+eAL4cEkyds7Yi+vSfgsrTY7fh/4wP2sZkU
	KRycofvp84d86PsjLXxSIdIZ78+K0tDOzfppE2ZhuuzBCzjO9b06j2pDL5S4xc2D+GdxTF12tky6V
	ajLja1r04gHDAWR3ozhNo0M1kM3BaJ4Z5wH8gb9ajmEjL5c+S0n1VcKVyH3Unjl958HGvz15hVI32
	sJ4oV7Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u01ow-00000009uU1-2mMM;
	Wed, 02 Apr 2025 17:24:10 +0000
Date: Wed, 2 Apr 2025 18:24:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-1yui_QgubgRAmL@casper.infradead.org>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0sjd8SEtldbxB1@tiehlicka>

On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > >+    /*
> > > > > >+     * Use vmalloc if the count is too large to avoid costly high-order page
> > > > > >+     * allocations.
> > > > > >+     */
> > > > > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > > > > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
> > > > >
> > > > > Why not move this check into kvmalloc family?
> > > >
> > > > Hmm should this check really be in kvmalloc family?
> > > 
> > > Modifying the existing kvmalloc functions risks performance regressions.
> > > Could we instead introduce a new variant like vkmalloc() (favoring
> > > vmalloc over kmalloc) or kvmalloc_costless()?
> > 
> > We should fix kvmalloc() instead of continuing to force
> > subsystems to work around the limitations of kvmalloc().
> 
> Agreed!
> 
> > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > fast-fail, no retry high order kmalloc before it falls back to
> > vmalloc by turning off direct reclaim for the kmalloc() call.
> > Hence if the there isn't a high-order page on the free lists ready
> > to allocate, it falls back to vmalloc() immediately.

... but if vmalloc fails, it goes around again!  This is exactly why
we don't want filesystems implementing workarounds for MM problems.
What a mess.

>  	if (size > PAGE_SIZE) {
>  		flags |= __GFP_NOWARN;
>  
>  		if (!(flags & __GFP_RETRY_MAYFAIL))
>  			flags |= __GFP_NORETRY;
> +		else
> +			flags &= ~__GFP_DIRECT_RECLAIM;

I think it might be better to do this:

		flags |= __GFP_NOWARN;

		if (!(flags & __GFP_RETRY_MAYFAIL))
			flags |= __GFP_NORETRY;
+		else if (size > (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+			flags &= ~__GFP_DIRECT_RECLAIM;

I think it's entirely appropriate for a call to kvmalloc() to do
direct reclaim if it's asking for, say, 16KiB and we don't have any of
those available.  Better than exacerbating the fragmentation problem by
allocating 4x4KiB pages, each from different groupings.

