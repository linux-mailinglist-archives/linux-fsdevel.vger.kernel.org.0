Return-Path: <linux-fsdevel+bounces-33637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807D9BC09C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 23:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6BC1F22A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7D1FDF85;
	Mon,  4 Nov 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSLckBCh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF01AAE27
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758130; cv=none; b=e2+TbsGTHLCJkTgJkazkwy6NOUf0G2qhd/zYx8x6nA7yG+pvGTnm1qn2CEA/9jzVIa5tmslYW/o9/IYk6M73dmR9lVDz5ZnRxTE73IcWxYolIdbeloueuTxB6401NI/HnLcfBAdGfsQTLA18rFUK7nIZ0W9AUUrhdR0VMxtp70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758130; c=relaxed/simple;
	bh=9yjeDW7FoGcBbhm0devgQq4gJaurLSzw3WjNMqN4Dig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBKm2h8Rb3SWAe4ZI0KyuysqQQgqxpLi64AkFSnlHMcQUp+coXlaWckrDv4jbwLeteTNpDbPWQiujoHO6QRMHDVQjSlYMefEq3y/HperFjhYs80spLj4tXaIePjvLqfxBapYmJ0iq9zHlMwNfJBSZw5aiHMk2HAl+QWTVohOwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSLckBCh; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2381840eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730758127; x=1731362927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZeJLhuGWwBpR2tgn/q1fig0IFTgvv0Juwu0EbDl2cM=;
        b=uSLckBChR4CZ8NkFOf1nqPO2CHNER3OOygaKDRVqNGI/tJY4BKAa0mSQFMk8wxDWSB
         dwyv4NE/cnoJXExoJGNyMn+NJGdgl5ybRDbMR6KTWbVqTl/IyZVm4V5k7gkzhqRr2rRf
         xUceynD4sniCFgI1dThsELe9pb4QHfGBZ9s+AbZxOWDvbDqfatPrE2y04NZMuD1xesG7
         nlbhfm5zm/evzmaZNTVY0QilLB76DoxcRKGLTVsokzz/1bRLG3SzoTmxIF1pvtGbLkPk
         Jt6VaDAJajmmnEe870TxtCoRryRic9MDfZi+YAfBy/guqVZ12Ktb36DLrwmWdFpl6vbj
         9oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758127; x=1731362927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZeJLhuGWwBpR2tgn/q1fig0IFTgvv0Juwu0EbDl2cM=;
        b=uFWJogKb5MdQFO1caHNpOY0q/TNe2MHWZ8fCfoXUNRgxqoE8Gn+i9bw+wwXjZaieXV
         C9maXWfXl9DXIU9MkoEN+cJsFlyqboRbGQBEPx90n7zk5Q/ZEY4rEOiOZd9tnZrjCZnH
         +vGDL0hnMBieKouSAB05Fc+Lq75V3B3W8gi90mH4MAnHB0bVwWnZmzqv2XZR/VGpqpl2
         eVVoJwpS5NRXW2R1xq4n2g20kpIVh/vxcXDJrtfk8vrN2E5KJn9ViShlT5tJUfYFaQxp
         XkQpi7wQXSE3aRjFYWUrbNi/ODIzHHnrkT7Jf0gYdHG2lchoPDij9DBfQox4OrCfkSZ1
         lAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV27cvwUdvAyi+iy5RS2my6plOf0hZlIrnkLmR2OACITYNl/auCpFF5xIkzI3S8pYRmNfVAKBRcOiT99plX@vger.kernel.org
X-Gm-Message-State: AOJu0YzksvCLATzIJl9jEBLayxqKbofl+thurxRttcwNfRbv8UTf+f0k
	VGvZv/Rr5XRnz9BW5rfajCihv1vmi58+TMeHShH2tfmwY+JRxehpg6+M67gNuGzOd8bHAr+vhYZ
	6GcfkDc1bIvhqANwB95pm4Oc4t+vuualN2mdF
X-Google-Smtp-Source: AGHT+IFln5ARziviEZ5W8gZPhQEpbPGFJcy1tmyEkI9GsLY6a3qE2HayVDbKUpLBXHlxdIKA1VRIzX1NSAfBlC47kKc=
X-Received: by 2002:a05:6358:7254:b0:1ad:10eb:cd39 with SMTP id
 e5c5f4694b2df-1c3f9f7979amr1643843155d.26.1730758126978; Mon, 04 Nov 2024
 14:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com> <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
 <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
In-Reply-To: <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 4 Nov 2024 15:08:09 -0700
Message-ID: <CAOUHufZ=SMN=GWMjvpDxiXxyMAvDDc4eEzYvAWP4=7atT7SX7g@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 3:04=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Nov 4, 2024 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > > On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > > While updating the generation of the folios, MGLRU requires tha=
t the
> > > > > > folio's memcg association remains stable. With the charge migra=
tion
> > > > > > deprecated, there is no need for MGLRU to acquire locks to keep=
 the
> > > > > > folio and memcg association stable.
> > > > > >
> > > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > >
> > > > > Andrew, can you please apply the following fix to this patch afte=
r your
> > > > > unused fixup?
> > > >
> > > > Thanks!
> > >
> > > syzbot caught the following:
> > >
> > >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/=
0x250 mm/vmscan.c:3140
> > >   ...
> > >
> > > Andrew, can you please fix this in place?
> >
> > OK, but...
> >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio=
, int gen)
> > >       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> > >
> > >       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > > -     VM_WARN_ON_ONCE(!rcu_read_lock_held());
> > >
> > >       do {
> > >               /* lru_gen_del_folio() has isolated this page? */
> >
> > it would be good to know why this assertion is considered incorrect?
>
> The assertion was caused by the patch in this thread. It used to
> assert that a folio must be protected from charge migration. Charge
> migration is removed by this series, and as part of the effort, this
> patch removes the RCU lock.
>
> > And a link to the sysbot report?
>
> https://syzkaller.appspot.com/bug?extid=3D24f45b8beab9788e467e

Or this link would work better:

https://lore.kernel.org/lkml/67294349.050a0220.701a.0010.GAE@google.com/

