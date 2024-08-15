Return-Path: <linux-fsdevel+bounces-26024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B50E95294A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBCCB22852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 06:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2191448C1;
	Thu, 15 Aug 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HA7HW6ET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9218D62D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702927; cv=none; b=F/sdOUFSey3zVICFT4A8t9ibJ7M2N+6KY8P4/bFeNbEHV4S9fKOei4mZPn92EQ2krL6qAzUxlLuOorNUQpV1WWoR5YB+e9TJWT5JF93dhTKpCWnb/bhtD3McMESUbp/spGMB2aCW6AY32/vTqdbKrKteKpiwwxYdJxrj6wSBEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702927; c=relaxed/simple;
	bh=CNl6RXzoIXKaQ4A70FVgh0b3cgXjOVyywGTVwsZ3e7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksV3I7s+St9bEcEZ0Blr/nZCZzHLchDSP5/NNT7jbF2w3fwFtoYP+rGeceV0fot8+5IKqUhQC2Jl1kDGFkFKSXDrWF8iK9L5IP+7qR6glXuumqk43Nyo8uKfNKhTNexLBLj508Y4QN8LB7J5flj0ZaL+QCvje3O/BkMdwa7ul8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HA7HW6ET; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428101fa30aso3580645e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723702923; x=1724307723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOgK6J8p2w/S1o1OKH/zY9ss8HubkQJlyV2xM6D/lbA=;
        b=HA7HW6ETCUyZ7Bfs7xhHnaEX5EqRPCYiXsrdVn4ydaBG0RzVWFtxW1LofoJyUleEYG
         06289tgI2CdbFiXF+WkNQPUid5KQps0qlW9kp6iLSG62xybbPbJ26q/ZKgryJSWrOo2u
         EhWj1GJ1s07CnCo6yowLwHWf3swBoGzGTUGr84C7hZDw3sVGZZ1aeky8TpOJzZVQUmWS
         b5m4xuByAb0Vaiz5RPIS3GomRnC4t5mRgTM0VYkb2XiEJ7KYLheyEzsfDI/ul69krOwp
         mHfHkerZOikk4EEkSzMTW+JjSWAuveO4FprL03FEPBTPiyDTROCY+vpqviQBq1QAl1mY
         bn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723702923; x=1724307723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOgK6J8p2w/S1o1OKH/zY9ss8HubkQJlyV2xM6D/lbA=;
        b=H+JUCTJtqEl1mH++3jfOacjCV7dSm6gBW+lYxUGNGiLS0tv7nIxvf+JmvlfB7CcFti
         8qe9b7fCvayGxS6n5PWA5gg6h1fFw83S8mPNEfFyagnSLKKOuVjNrijBlcvebGP8Rb2T
         Uc2bZmihiDgb0mzFbDsoZm+DDXtlosE7tllVa7hoAM4Ye9rf3p8IxUUdu8mQAVeq4pXH
         dhbi1eKcX43OqSvfKK+4CnAJXAIBnndoefSFCkASh8xEqyIRZKnJLCv6eTgrhD9YBoSR
         YALxiRXaO2mOl8QF6lzBc6rjBr5tlaHEQZvoPfKcXQHuFM+oja4dQX+Iwg9Wni07TK7e
         lhyg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdmeT6G61zCCRvUztD2PiRwgJBkaWJjOqhlCZToW7PX1tdcaNMdZ28zHpqr7tXhF4G159WGTlM0Ojq18C6uJ1e3Pwa4CdkXlyXRx0rA==
X-Gm-Message-State: AOJu0Yz5tn2p3AgsAB1Lxw87ngSIp2hmTCFXhRTkwfh7QoZiu+cJcmdm
	W4xfvWKEQWGmVkk5crAHAYOBO2w0mlY5J/f0ZQ3O1RN+W5VVMJWSFaeJ5AdJAfI=
X-Google-Smtp-Source: AGHT+IH4sQrqFjAznFSRnjLbAId9X2L98DtewLKQ2JpwY8wc33BQwNeSahwx/nG4PdH+FEoxz6fpnA==
X-Received: by 2002:a05:600c:1551:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-429dd22f39bmr38404145e9.7.1723702922723;
        Wed, 14 Aug 2024 23:22:02 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c46fsm9842485e9.39.2024.08.14.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 23:22:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:22:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zr2eiFOT--CV5YsR@tiehlicka>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>

On Thu 15-08-24 11:26:09, Yafang Shao wrote:
> On Wed, Aug 14, 2024 at 8:43 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > If that's the case, I believe we should at least consider adding the
> > > following code change to the kernel:
> >
> > We already do have that
> >                 /*
> >                  * All existing users of the __GFP_NOFAIL are blockable, so warn
> >                  * of any new users that actually require GFP_NOWAIT
> >                  */
> >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> >                         goto fail;
> 
> I don't see a reason to place the `goto fail;` above the
> `__alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);`
> line. Since we've already woken up kswapd, it should be acceptable to
> allocate memory from ALLOC_MIN_RESERVE temporarily. Why not consider
> implementing the following changes instead?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9ecf99190ea2..598d4df829cd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4386,13 +4386,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
> int order,
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
> -               /*
> -                * All existing users of the __GFP_NOFAIL are blockable, so warn
> -                * of any new users that actually require GFP_NOWAIT
> -                */
> -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> -                       goto fail;
> -
>                 /*
>                  * PF_MEMALLOC request from this context is rather bizarre
>                  * because we cannot reclaim anything and only can loop waiting
> @@ -4419,6 +4412,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
> int order,
>                 if (page)
>                         goto got_pg;
> 
> +               /*
> +                * All existing users of the __GFP_NOFAIL are blockable, so warn
> +                * of any new users that actually require GFP_NOWAIT
> +                */
> +               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)) {
> +                       goto fail;
> +               }
> +
>                 cond_resched();
>                 goto retry;
>         }

How does this solve anything. It will still eventually fail the NOFAIL
allocation. It might happen slightly later but that doesn't change the
fact it will _fail_. I have referenced a discussion why that is not
really desireable and why Barry wants that addressed. We have added that
WARN_ON_ONCE because we have assumed that people do understand that
NOFAIL without reclaim is just too much to ask. We were wrong there was
one user in the kernel. That one was not too hard to find out because
you can _grep_ for those flags. Scoped APIs make that impossible!

> > But Barry has patches to turn that into BUG because failing NOFAIL
> > allocations is not cool and cause unexpected failures. Have a look at
> > https://lore.kernel.org/all/20240731000155.109583-1-21cnbao@gmail.com/
> >
> > > > I am really
> > > > surprised that we even have PF_MEMALLOC_NORECLAIM in the first place!
> > >
> > > There's use cases for it.
> >
> > Right but there are certain constrains that we need to worry about to
> > have a maintainable code. Scope allocation contrains are really a good
> > feature when that has a well defined semantic. E.g. NOFS, NOIO or
> > NOMEMALLOC (although this is more self inflicted injury exactly because
> > PF_MEMALLOC had a "use case"). NOWAIT scope semantic might seem a good
> > feature but it falls appart on nested NOFAIL allocations! So the flag is
> > usable _only_ if you fully control the whole scoped context. Good luck
> > with that long term! This is fragile, hard to review and even harder to
> > keep working properly. The flag would have been Nacked on that ground.
> > But nobody asked...
> 
> It's already implemented, and complaints won't resolve the issue. How
> about making the following change to provide a warning when this new
> flag is used incorrectly?

How does this solve anything at all? It will warn you that your code is
incorrect and what next? Are you going to remove GFP_NOFAIL from the
nested allocation side? NOFAIL is a strong requirement and it is not
used nilly willy. There must have been a very good reason to use it. Are
you going to drop the scope?

Let me repeat, nested NOFAIL allocations will BUG_ON on failure. Your
warning might catch those users slightly earlier when allocation succeed
but that doesn't make those crashes impossible. PF_MEMALLOC_NORECLAIM
might be already merged but this concept is inherently fragile and
should be reverted rather than finding impossible ways around it. And it
should be done before this spreads outside of bcachefs.
-- 
Michal Hocko
SUSE Labs

