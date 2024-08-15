Return-Path: <linux-fsdevel+bounces-26025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6308952967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6468E1F236AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A14176FD3;
	Thu, 15 Aug 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/4cpIaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77516BE20
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703571; cv=none; b=QBnwPDJqqnLP/xroNjTBTU0uIXiZshcrZIV0O+S2F9mc82cFM1J+IGjLgjA0SH7h8Dj614nKDAy2ndJKqSNEfoEnX0H+jbNc46p2z9F54OP3ujkHSUoP8nU2g9pW1QvvSy9GHFB1JjcVw4aVX1b4rC1Gd6I/uOkTT4gXRdngbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703571; c=relaxed/simple;
	bh=PM/4elxAsnsB/jOr8OYsEyMzsDEKJJImJESn5QjJC7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlVHreZZtYtUMguhjILn+keXpDzEYu6G6GPUpRDYTpM8Jasg5uAUo7MZhZQr/RVxJDRTqqg4vXzMw0sR0Z643Onzib9uiI6PquRcrRoNob25NLIFaSOPAwjnjj01QzH3R82HroADqDOuueWIrU+Yw2k7a/jcytUliW8RThMYpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/4cpIaj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bbbd25d216so14981216d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723703569; x=1724308369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDCk+gru4KSJH6QS6nIVyyOpJVWF4oWZoIwgJGoUB1g=;
        b=Y/4cpIaj3sQHFqCrkcrGN3CSJbmq8yUyP70cBE1OkC5gWYKcdw1GLKwJ6xua8hxZ4P
         YieU0RCmBUoG9mJkO+GFGDMyB3mw2Nv9c1QvnciZfi+O5DErQMTQe1R5i3I3cQrRGYpl
         qhc9/jZnTugLdfoHgsszpNnyhC3tE2v1kfi48psQScee02D1u2azDbKpkicKD564InVF
         gZRo6TURw51RGdZPbAmV32Lm0IxHZthDC7tHQOcfadYBghhL029V3vdQggz4VUFF26Gm
         5sHw5RdxSadJnPRDsMcZN7omzAETMRyh9453rsDslPMTJr8iRsvrUtG1vSbZ8QXUdcor
         HOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723703569; x=1724308369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDCk+gru4KSJH6QS6nIVyyOpJVWF4oWZoIwgJGoUB1g=;
        b=ibkP+pdzFPvVq/yuEi2893e/Bbr/RiWBaFL6hmStMq6l2qAFRVFcAy3EYDeYxhIpYP
         5IPXCpbbRXfuu1nqYdtnD2zj4ucOuTDmXMWSX0lKg8p3O9kOF9ia5QMAQxrQuR9beF+n
         BtBLnJRJ7TRETECBAym4LbSZKQ5AB8v+YPjNiKMVxZ5nTB2aCzVc5TDcquFIJg1YUfce
         /aAuyC1DhFw11bo6UGaVmUlV7NgdyeVSIAAiEvEPccA6V9zuQ5FrjIReYWXPYJKaoYX5
         h4nYYFcf2q0El/Y+UPnwWWyYRcS1/vT1v6P2ilYpaLTB2kCLYPhVR78MpQljvMzslgM6
         RoJg==
X-Forwarded-Encrypted: i=1; AJvYcCUe3hu4W6Ru6qlCLiRXPCUAGY6dLr5yFt2NHo1d8tA1XW8KHBszREpaXKAiFbl5p+U1KWa3OLxD5JCnOBP1w/fXZ/ws4y6M8DF7glbkOQ==
X-Gm-Message-State: AOJu0YyQWJMeQXW3s/6nnrquHHBCu4XQZaPvYq6l/yER76hyUUt43ujp
	PXrYe3+z6hcB6aLUCEljGYmsoKq8b0Doa9IHNqzAX5uaaKRKD5ssExwzPFiZEQzz4Hog8M6TwMj
	+Bz74I4PYpbH2rs1ZhPnFReAoAfA=
X-Google-Smtp-Source: AGHT+IEQcBFgy7LbM+8f2LOP/+hr772Z+43eFxXcya7lMo920Fe5pGHv57wT8aS953jRlIIrHPt3Nw8WhejBhNupnvk=
X-Received: by 2002:ad4:5be6:0:b0:6bb:8b7b:c2df with SMTP id
 6a1803df08f44-6bf6de80febmr36762516d6.25.1723703568468; Wed, 14 Aug 2024
 23:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org> <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka> <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka> <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
In-Reply-To: <Zr2eiFOT--CV5YsR@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 15 Aug 2024 14:32:10 +0800
Message-ID: <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:22=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 15-08-24 11:26:09, Yafang Shao wrote:
> > On Wed, Aug 14, 2024 at 8:43=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> [...]
> > > > If that's the case, I believe we should at least consider adding th=
e
> > > > following code change to the kernel:
> > >
> > > We already do have that
> > >                 /*
> > >                  * All existing users of the __GFP_NOFAIL are blockab=
le, so warn
> > >                  * of any new users that actually require GFP_NOWAIT
> > >                  */
> > >                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > >                         goto fail;
> >
> > I don't see a reason to place the `goto fail;` above the
> > `__alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);=
`
> > line. Since we've already woken up kswapd, it should be acceptable to
> > allocate memory from ALLOC_MIN_RESERVE temporarily. Why not consider
> > implementing the following changes instead?
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 9ecf99190ea2..598d4df829cd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4386,13 +4386,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
> > int order,
> >          * we always retry
> >          */
> >         if (gfp_mask & __GFP_NOFAIL) {
> > -               /*
> > -                * All existing users of the __GFP_NOFAIL are blockable=
, so warn
> > -                * of any new users that actually require GFP_NOWAIT
> > -                */
> > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > -                       goto fail;
> > -
> >                 /*
> >                  * PF_MEMALLOC request from this context is rather biza=
rre
> >                  * because we cannot reclaim anything and only can loop=
 waiting
> > @@ -4419,6 +4412,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned
> > int order,
> >                 if (page)
> >                         goto got_pg;
> >
> > +               /*
> > +                * All existing users of the __GFP_NOFAIL are blockable=
, so warn
> > +                * of any new users that actually require GFP_NOWAIT
> > +                */
> > +               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)) {
> > +                       goto fail;
> > +               }
> > +
> >                 cond_resched();
> >                 goto retry;
> >         }
>
> How does this solve anything. It will still eventually fail the NOFAIL
> allocation. It might happen slightly later but that doesn't change the
> fact it will _fail_. I have referenced a discussion why that is not
> really desireable and why Barry wants that addressed. We have added that
> WARN_ON_ONCE because we have assumed that people do understand that
> NOFAIL without reclaim is just too much to ask. We were wrong there was
> one user in the kernel. That one was not too hard to find out because
> you can _grep_ for those flags. Scoped APIs make that impossible!
>
> > > But Barry has patches to turn that into BUG because failing NOFAIL
> > > allocations is not cool and cause unexpected failures. Have a look at
> > > https://lore.kernel.org/all/20240731000155.109583-1-21cnbao@gmail.com=
/
> > >
> > > > > I am really
> > > > > surprised that we even have PF_MEMALLOC_NORECLAIM in the first pl=
ace!
> > > >
> > > > There's use cases for it.
> > >
> > > Right but there are certain constrains that we need to worry about to
> > > have a maintainable code. Scope allocation contrains are really a goo=
d
> > > feature when that has a well defined semantic. E.g. NOFS, NOIO or
> > > NOMEMALLOC (although this is more self inflicted injury exactly becau=
se
> > > PF_MEMALLOC had a "use case"). NOWAIT scope semantic might seem a goo=
d
> > > feature but it falls appart on nested NOFAIL allocations! So the flag=
 is
> > > usable _only_ if you fully control the whole scoped context. Good luc=
k
> > > with that long term! This is fragile, hard to review and even harder =
to
> > > keep working properly. The flag would have been Nacked on that ground=
.
> > > But nobody asked...
> >
> > It's already implemented, and complaints won't resolve the issue. How
> > about making the following change to provide a warning when this new
> > flag is used incorrectly?
>
> How does this solve anything at all? It will warn you that your code is
> incorrect and what next? Are you going to remove GFP_NOFAIL from the
> nested allocation side? NOFAIL is a strong requirement and it is not
> used nilly willy. There must have been a very good reason to use it. Are
> you going to drop the scope?
>
> Let me repeat, nested NOFAIL allocations will BUG_ON on failure.

The key question is whether it actually fails after we've already
woken up kswapd. Have we encountered real issues, or is this just
based on code review? Instead of allowing it to fail, why not allocate
from the reserve memory to prevent this from happening?


> Your
> warning might catch those users slightly earlier when allocation succeed
> but that doesn't make those crashes impossible. PF_MEMALLOC_NORECLAIM
> might be already merged but this concept is inherently fragile and
> should be reverted rather than finding impossible ways around it. And it
> should be done before this spreads outside of bcachefs.
> --
> Michal Hocko
> SUSE Labs



--
Regards
Yafang

