Return-Path: <linux-fsdevel+bounces-70146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974EC927AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0443A8515
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0927F16C;
	Fri, 28 Nov 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeMJqQZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B222652D;
	Fri, 28 Nov 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345143; cv=none; b=qeuh3tsCmuueO6EqYxrXD+XXjp8544I3kRL/rijc/ILoWBktRJ+3Yn3KjIYLcrpbfBDvfz900l1EOs9lNjh7ByC2MDV0PxHBlfSrpRSFNviPH/XvvA0epR2wCN3wOmQAimJKu9WYHvTdwigok9XTHF3SQZpHYvbkCH+0EFsczuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345143; c=relaxed/simple;
	bh=wJzdCrLgCFc/PZk8XNyibTPZPe/BiCeG4qVVfXwqIM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLY5KfOq2jvTqj0yXRnN1equ1CnnXWIBiOD96KuEtsdOo7Ss9q2so4EqcrrcCzL2xJYWTHYma3RulGz9W5u+Snj47WHupr3A4Sqng1vHfQL4JKm5Un9lsEifHf4b6ssY09Re2AwdjOTZvx9Kah7eTWvHp1w8Elrpzh8/1nKApW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeMJqQZ/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AwIfzuOMPHq6x0Po0VRTjIWxG7bx5EXE+Jc0r5XKfzo=; b=ZeMJqQZ/VV1LbFDf2VICimbXD9
	ifBgs4nlsqh+ACjxEzEBFxWHJhgPC7NwOj5+eivXO1rdA6tTyUhVIM/Fah9CWG7v52OGmfbfH3J6x
	FfX1x4eOWLYsN+skpfPqYdBonvAcmn1bSVtT7bhFMANfB+FPvEojTM3yKC6n4dKY1z3xHsVHzRbDR
	zimoxfjQXang4gXfzzTA2YvryoMgrH7KXWTe7kTgVlgWxM2OMDUuZGH2HOAOB3zQJ1xjuyR+pS5pi
	XjEzlGdO0wIzpUtltaa2nvmeKhwncRvk451mTJaMB7OlDMD/tP9k/DiSQihAZDSyDxkKX0HO3PVJ6
	cxhMe7hg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP0ld-0000000DObj-0oco;
	Fri, 28 Nov 2025 15:52:17 +0000
Date: Fri, 28 Nov 2025 15:52:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Sokolowski, Jan" <jan.sokolowski@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aSnFME6-LqQXKazB@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
 <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
 <aShb9lLyR537WDNq@casper.infradead.org>
 <aShmW2gMTyRwyC6m@casper.infradead.org>
 <IA4PR11MB9251BBCF39B18A557BF08C0799DCA@IA4PR11MB9251.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA4PR11MB9251BBCF39B18A557BF08C0799DCA@IA4PR11MB9251.namprd11.prod.outlook.com>

On Fri, Nov 28, 2025 at 09:03:08AM +0000, Sokolowski, Jan wrote:
> So, shall I send a V2 of that patch and add you as co-developer there?

No.  You didn't co-develop anything.  You reported the bug, badly.

What I'm trying to do right now is figure out what the syzbot report
actually was.  In all the DRM specialness, you've lost the original
information, so I can't add the original syzbot links.  All I can find
is https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6449
which doesn't link to a syzbot report, so that's a dead end.

> Regards
> Jan
> 
> > -----Original Message-----
> > From: Matthew Wilcox <willy@infradead.org>
> > Sent: Thursday, November 27, 2025 3:55 PM
> > To: Christian König <christian.koenig@amd.com>
> > Cc: Sokolowski, Jan <jan.sokolowski@intel.com>; linux-
> > kernel@vger.kernel.org; Andrew Morton <akpm@linux-foundation.org>;
> > linux-fsdevel@vger.kernel.org; linux-mm@kvack.org
> > Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be outside
> > given range
> > 
> > On Thu, Nov 27, 2025 at 02:11:02PM +0000, Matthew Wilcox wrote:
> > > Hm.  That's not what it does for me.  It gives me id == 1, which isn't
> > > correct!  I'll look into that, but it'd be helpful to know what
> > > combination of inputs gives us 2.
> > 
> > Oh, never mind, I see what's happening.
> > 
> > int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
> > 
> >         ret = idr_alloc_u32(idr, ptr, &id, end > 0 ? end - 1 : INT_MAX, gfp);
> > so it's passing 0 as 'max' to idr_alloc_u32() which does:
> > 
> >         slot = idr_get_free(&idr->idr_rt, &iter, gfp, max - base);
> > 
> > and max - base becomes -1 or rather ULONG_MAX, and so we'll literally
> > allocate any number.  If the first slot is full, we'll get back 1
> > and then add 'base' to it, giving 2.
> > 
> > Here's the new test-case:
> > 
> > +void idr_alloc2_test(void)
> > +{
> > +       int id;
> > +       struct idr idr = IDR_INIT_BASE(idr, 1);
> > +
> > +       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> > +       assert(id == -ENOSPC);
> > +
> > +       id = idr_alloc(&idr, idr_alloc2_test, 1, 2, GFP_KERNEL);
> > +       assert(id == 1);
> > +
> > +       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> > +       assert(id == -ENOSPC);
> > +
> > +       id = idr_alloc(&idr, idr_alloc2_test, 0, 2, GFP_KERNEL);
> > +       assert(id == -ENOSPC);
> > +
> > +       idr_destroy(&idr);
> > +}
> > 
> > and with this patch, it passes:
> > 
> > +++ b/lib/idr.c
> > @@ -40,6 +40,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
> > 
> >         if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
> >                 idr->idr_rt.xa_flags |= IDR_RT_MARKER;
> > +       if (max < base)
> > +               return -ENOSPC;
> > 
> >         id = (id < base) ? 0 : id - base;
> >         radix_tree_iter_init(&iter, id);
> 

