Return-Path: <linux-fsdevel+bounces-45574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE882A7985D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48555189609E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CB1F5847;
	Wed,  2 Apr 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BoZLqXQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330C1F4CBF
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633510; cv=none; b=fMjN/eLfzubxKXk5Udk6ULXOYgxB9JvZ1nhu1Sn0iZcbL0sVEme2+vo1wpcbQBOaC8/pS1NgCYNfLkmuGMMLF5MMuHdQcO2lX7mJPQbhkBRDdmvd5VPjdmRHo5ZB71O1qzXU1NFO2LUYJbmVNxJbOgyn+Oszn4wrMnxvEF/VPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633510; c=relaxed/simple;
	bh=XSwdBsp6WR8VMjqtDxobffY07V803r+VR9losvlVtcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkA0+XXwlHgtFXKYvIWZBttmzfuD70UhgCVW05a2MiA0gDwK/k9UzW5ntWjZ5AS6vUSmybnBYLbMYqQvye73dXYPOMoftmG3Lj7Z/D9z53FRcGvJvbLUNGbQPSo9gBc+tF+nRJCHwmQj4F5HCQzQXKx0UZq/o21L4b+Vosd3+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BoZLqXQo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so198828b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743633507; x=1744238307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynaTDnoWmvbCj4VrGm5vrQOyko6HmMR33HNBCVOjMXI=;
        b=BoZLqXQotOyPeMeWc8T8h4/iSt2Xc23nn9qXiAkqwshJMNJzzAqCjFIJMTB35uCY1y
         Aj+7i7I3XRByZriOuf807A7dhQLjR3CO+3jEqhgr9kH6okGqfmQyiV8Hp+mNparfsYJy
         wNxy61baKZldp8Mn27/n+dxmJXCD5pop9VQj+y0ZEdZXkGLWs3S4ymSbjgdMTWGloT8+
         FuKg8Q2jB2KbKgxaRA49jsVe4aHwDj6uk3XWlgFtbU6rgusqfePUntYelniAYKSY7//E
         Y9lv0cXzawSCc6NOjawYVg6xdCnu8BmrXsZiOg2P3xXswFt7rKSWBwid9r2FyHRpc8WE
         X3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743633507; x=1744238307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynaTDnoWmvbCj4VrGm5vrQOyko6HmMR33HNBCVOjMXI=;
        b=qOAQdBXwDfueT7wp6ceC+/O4bhTULYPPWMwA9HmY8nIn8Tl6RWoffDAUl3/IcUgoAG
         7ADpwOCxPjgGgF2tFN8wK1vNdXBpheDEy56gH1waB9SESQLKl1x5EHS1iXOSe3qMqsO5
         0kxFEMzRgj4o6tWFAw4Rw8eii5WSr94qSXpv4VbL8JrUP7EZrlH9Mhf6w7yW7bTnVQKl
         Y7wps/5ogDKcgaOfjrrgZWL3EKxL11evaTDigIJep+7qKIvp2A1Sdk4k+kyoqU3Ggrof
         GMn62bpLN1FSxEfxaaDlIppMgEC6SESJi4pdAnWsPmcQEnQVDnGrbRvXj0HEkoF6NzXD
         FxWw==
X-Forwarded-Encrypted: i=1; AJvYcCVcFBH9VSGuE9CvNiPUj12BvgHK9tEOVgA18yxYFUDms4+dkRvtzMw/JVxA/0WfIZbGWoIkVhVIQgyHGmnT@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/YzS8+IzRWf5j5PCAyyNJys5QiK45wzq1uIpD0xkGCKXfpzi
	s2oArv6yh3yJIs2WsD8SPCVTZNJ1F7C0my02dSzPQFaJ/3hYgeswdeUqZabL0ko=
X-Gm-Gg: ASbGnctk3MZE4TSpwkNxbIiaW0NX3iS80pTjhwRx+eiPUHd/NnJ+JWWNqikhVVAJz5l
	6UUtaj2ZBgcXFXoxdRU6SRNZHyuSuO/BDIqKcM3+DwE8t+vQHI2cjMLyzYJHDsrOnPn1Mncg5Kt
	11zL0vR3/STNxbJ5ykDR0C5sVCH/T1KPFE2alqhpZPHBSAHMo/naE7fvgsYCHk1tV0DTCrtdl5U
	uvpw8L20z9frEVJhimvE5sVcYv06W1fKWawlha7HRxC4/y+g38Dj6p7vHv+Lf9A034ThsAtAv/b
	hZDr+O05xQllaxCiUHdZTWhGk5epOmsC+aUZhgqQ1qPrQ3axyiSQAU+ybCxSA7Vg6sxaoP1bjR7
	bsNasmOE1BY0LaDn8IA==
X-Google-Smtp-Source: AGHT+IEvxyZSV4gjW+quadnAWEaceKmDex5jTEGIVB8xOUn0w7lDLW/hziyx7YfhBI0zuINgXMnqTQ==
X-Received: by 2002:a05:6a20:6f04:b0:1fd:e9c8:cf3b with SMTP id adf61e73a8af0-200e4cc69c1mr6790332637.30.1743633507527;
        Wed, 02 Apr 2025 15:38:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea154dsm35796b3a.112.2025.04.02.15.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 15:38:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u06j2-00000003idM-0JrZ;
	Thu, 03 Apr 2025 09:38:24 +1100
Date: Thu, 3 Apr 2025 09:38:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-28YCNy08rwJZhR@dread.disaster.area>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-1yui_QgubgRAmL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-1yui_QgubgRAmL@casper.infradead.org>

On Wed, Apr 02, 2025 at 06:24:10PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > > >+    /*
> > > > > > >+     * Use vmalloc if the count is too large to avoid costly high-order page
> > > > > > >+     * allocations.
> > > > > > >+     */
> > > > > > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > > > > > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
> > > > > >
> > > > > > Why not move this check into kvmalloc family?
> > > > >
> > > > > Hmm should this check really be in kvmalloc family?
> > > > 
> > > > Modifying the existing kvmalloc functions risks performance regressions.
> > > > Could we instead introduce a new variant like vkmalloc() (favoring
> > > > vmalloc over kmalloc) or kvmalloc_costless()?
> > > 
> > > We should fix kvmalloc() instead of continuing to force
> > > subsystems to work around the limitations of kvmalloc().
> > 
> > Agreed!
> > 
> > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > fast-fail, no retry high order kmalloc before it falls back to
> > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > Hence if the there isn't a high-order page on the free lists ready
> > > to allocate, it falls back to vmalloc() immediately.
> 
> ... but if vmalloc fails, it goes around again!  This is exactly why
> we don't want filesystems implementing workarounds for MM problems.
> What a mess.

That's because we need __GFP_NOFAIL semantics for the overall
operation, and we can't pass that to kvmalloc() because it doesn't
support __GFP_NOFAIL. And when this code was written, vmalloc didn't
support __GFP_NOFAIL, either. We *had* to open code nofail
semantics, because the mm infrastructure did not provide it.

Yes, we can fix this now that __vmalloc(__GFP_NOFAIL) is a thing.
We still need to open code the kmalloc() side of the operation right
now because....

> >  	if (size > PAGE_SIZE) {
> >  		flags |= __GFP_NOWARN;
> >  
> >  		if (!(flags & __GFP_RETRY_MAYFAIL))
> >  			flags |= __GFP_NORETRY;

.... this is a built-in catch-22.

If we use kvmalloc(__GFP_NOFAIL), this code results in kmalloc
with __GFP_NORETRY | __GFP_NOFAIL flags set. i.e. we are telling
the allocation that it must not retry but it also must retry until
it succeeds.

To work around this, the caller then has to use __GFP_RETRY_MAYFAIL
| __GFP_NOFAIL, which is telling the allocation that it is allowed
to fail but it also must not fail. Again, this makes no sense at
all, and on top of that it doesn't give us fast-fail semantics
we want from the kmalloc side of kvmalloc.

i.e. high order page allocation from kmalloc() is an optimisation,
not a requirement for kvmalloc(). If high order page allocation is
frequently more expensive than simply falling back to vmalloc(),
then we've made the wrong optimisation choices for the kvmalloc()
implementation...

> I think it might be better to do this:
> 
> 		flags |= __GFP_NOWARN;
> 
> 		if (!(flags & __GFP_RETRY_MAYFAIL))
> 			flags |= __GFP_NORETRY;
> +		else if (size > (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> +			flags &= ~__GFP_DIRECT_RECLAIM;
> 
> I think it's entirely appropriate for a call to kvmalloc() to do
> direct reclaim if it's asking for, say, 16KiB and we don't have any of
> those available.

I disagree - we have background compaction to address the lack of
high order folios in the allocator reserves. Let that do the work of
resolving the internal resource shortage instead of slowing down
allocations that *do not require high order pages to be allocated*.

> Better than exacerbating the fragmentation problem by
> allocating 4x4KiB pages, each from different groupings.

We have no evidence that this allocation behaviour in XFS causes or
exacerbates memory fragmentation. We have been running it in
production systems for a few years now....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

