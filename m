Return-Path: <linux-fsdevel+bounces-47614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3BAA1234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A483A9A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1625247DF9;
	Tue, 29 Apr 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="t2AmHvQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616A246326
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945343; cv=none; b=OjI2ZbJ1+DbMhR48lIZuAaAh6Wt89oMfareiapsB8ER5yGWV2hL77MttlngupVC9K5duGg+7nsfdw/TsNlEBSaB2gCU+MyM357bTcyRFVwmn7vf0yWAkqKcrGp5iHtJKxvmE5uvBgQOe/8Vny/sgridS14QaDCMTmpE7+RV4QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945343; c=relaxed/simple;
	bh=9H0LsjNRrY5PWe85DqM1hJ/9El74OMvJBsmQ6l8DTN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2RZoQuwpW/NFyMJ8RZl81u0PKM+268U7rOZ0MW8ZROiSOrub6ySFroPBNK1uFnivGKF9NucCHVSDUCjVKEbtj/PbSjdP8bNfXsLvxdMnJHtCIH5h9kdZb+fY89oEHrcJU/3bdqIqnB4BiIdLgr0tZ9x2KGqifBm0I9JGfCsdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=t2AmHvQu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so4394046a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1745945341; x=1746550141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H0LsjNRrY5PWe85DqM1hJ/9El74OMvJBsmQ6l8DTN4=;
        b=t2AmHvQuuMrx3aDM4aIZrZJGcJw7Jxy6KQCSYM0NdYgomnF3qi93KY8m8OB7p6sRwd
         S1H/x+4eierDFsAmYB2NddB6zKLr8zgVcNCHFIePiAt1f89X/uauAZqg3rNsFewrvvFs
         /qXGQXd58OE84N83j9j9ZzG4wf+tNzEL/r8im1kfBs5DpTMa0VG51mvDfA/hztPz/jIX
         zD/Vkfk1D9V9i8lozqyrAgFgcsVXIUfYEeZ0Orgyi8j9JhZEOB753uZsSEK0WxQulhH6
         hYqm0MUGDLZm1yF/RPT34dWvxf14Bz+b7LIzG/9kALKMIW3If8cHvJqAbTBCRwYgDFSk
         BInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745945341; x=1746550141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H0LsjNRrY5PWe85DqM1hJ/9El74OMvJBsmQ6l8DTN4=;
        b=lhDnfiLOkuYXziluynq09D4awCwDnRyUK4GnKq6+s6xOEM/DLAvFpR7w/UIQnGxzhS
         ucAt6pNwWfa0Lf5OraZ7lDThYsma6BeA4jXxHqms+BsDR58hYMytbS/rYOXq+gZyIWQp
         xqtvqfRUW7KLmyVpDW5Raap9inEZgyh7nRimjrDiLiPAo2MsmreplruI2OVTEGBMUh4N
         wsQVvFAkG+349ZxIrN5tJeSNvJerbi/EelHjAaw99q2asIgKRFYtlu4sF2vypqNLvwVG
         pyixqgdS85r46WknewyVDmGjgIHi3SmvyZVFSaSfwhnrOlztRm/BRhMdD3kgK57jBHi3
         f3ug==
X-Forwarded-Encrypted: i=1; AJvYcCWCpCsFDdLUb2rTqHtK25QhG0vD2BgCK9MzPcKKQJgQKU/J59idRwhY5fVPFJoFvh5fC6s5CwHENr9pXgLb@vger.kernel.org
X-Gm-Message-State: AOJu0YwFohmkAKdpd6HxPPmm5nshKyYWFBvHJWIXFbfLFbhRHgxjZ5z4
	OO8Zu+XqSKLhLohMyQebLGTh2BPslB2XrZwGpy1m2sT/y81PvNn5luPqTyLs+Y24OUhyyXhIgxS
	yuHiMpff7tloRvqsR+Gk4CTF4cdGxga/iWotL
X-Gm-Gg: ASbGnct5CK4Hn+uKxMc7/k8AFeRpJ1/lleXoHaeKwpPcPBEXscxwcLeZw59EUo8rv10
	49ePL+3YV3WWgwjzJfAd27vTu9tHnhxCayD5UvkmH8OpTTv+V34C0fqdqPy541D75hA7mWHDXAC
	nuGz+wGp0uuUFPoDEJqtapBA==
X-Google-Smtp-Source: AGHT+IFmYhxgBqdFTyeB6jtUKwq0NpwSO3n2aDEpxC1AlEnOModK21uopLYnylQAayMGSQAHm9dJ3k3XwfqUgH38qhw=
X-Received: by 2002:a17:90b:4ec3:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-30a21fed8f3mr6814613a91.0.1745945340592; Tue, 29 Apr 2025
 09:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
 <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
 <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
 <CACh33FqQ_Ge6y0i0nRhGppftWdfMY=SpGsN0EFoy9B8VMgY-_Q@mail.gmail.com> <pkpzm6okfqchet42lhcebwaiuwrwil6wp76flnk3p3mgijtg2e@us7jkctbpsgc>
In-Reply-To: <pkpzm6okfqchet42lhcebwaiuwrwil6wp76flnk3p3mgijtg2e@us7jkctbpsgc>
From: Patrick Donnelly <batrick@batbytes.com>
Date: Tue, 29 Apr 2025 12:48:49 -0400
X-Gm-Features: ATxdqUGI6li0I9MiWlxbRa6mKpi0pyjVX_tYXFxi6p1GvM0SiC4YBXP4kZNxD8o
Message-ID: <CACh33Fr4-53wOgciKSUTwsCwyb-L7A9fscQmLvbHynYX2j2brg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:21=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Apr 29, 2025 at 11:36:44AM -0400, Patrick Donnelly wrote:
> > I would not consider myself a kernel developer but I assume this
> > terminology (dentry aliases) refers to multiple dentries in the dcache
> > referring to the same physical dentry on the backing file system?
>
> This issue turned out to be my own pebcak; I'd missed the
> dentry_operations that do normalized lookups (to be fair, they were
> rather hidden) and I'd just pulled a 14 hour day so was a tad bitchy
> about it on the list.
>
> > If so, I can't convince myself that's a real problem. Wouldn't this be
> > beneficial because each application/process may utilize a different
> > name for the backing file system dentry? This keeps the cache hot with
> > relevant names without any need to do transformations on the dentry
> > names. Happy to learn otherwise because I expected this situation to
> > occur in practice with ceph-fuse. I just tested and the dcache entries
> > (/proc/sys/fs/dentry-state) increases as expected when performing case
> > permutations on a case-insensitive file name. I didn't observe any
> > cache inconsistencies when editing/removing these dentries. The danger
> > perhaps is cache pollution and some kind of DoS? That should be a
> > solvable problem but perhaps I misunderstand some complexity.
>
> Dentry aliases are fine when they're intended, they're properly
> supported by the dcache.
>
> The issue with caching an alias for the un-normalized lookup name is
> (as you note) that by permuting the different combinations of upper and
> lower case characters in a filename, userspace would be able to create
> an unbounded (technically, exponential bound in the length of the
> filename) number of aliases, and that's not what we want.
>
> (e.g. d_prune_aliases processes the whole list of aliases for an inode
> under a spinlock, so it's an easy way to produce unbounded latencies).

Well, if aliases are "supported" by the dcache, that seems like a bug to me=
.

> So it sounds like you probably didn't find the dentry_operations for
> normalized lookups, same as me.

I didn't look to begin with. :)

> Have a look at generic_set_sb_d_ops().
>
> > > Also, originally this was all in the same core dcache lookup path. So
> > > the whole "we have to check if the filesystem has its own hash
> > > function" ended up slowing down the normal case. It's obviously been
> > > massively modified since 1997 ("No, really?"), and now the code is
> > > very much set up so that the straight-line normal case is all the
> > > non-CI cases, and then case idnependence ends up out-of-line with its
> > > own dcache hash lookup loops so that it doesn't affect the normal goo=
d
> > > case.
> >
> > It's seems to me this is a good argument for keeping case-sensitivity
> > awareness out of the dcache. Let the fs do the namespace mapping and
> > accept that you may have dentry aliases.
> >
> > FWIW, I also wish we didn't have to deal with case-sensitivity but we
> > have users/protocols to support (as usual).
>
> The next issue I'm looking at is that the "keep d_ops out of the
> fastpath" only works if case sensitivity isn't enabled on the filesystem
> as a whole - i.e. if case sensitivity is enabled on even a single
> directory, we'll be flagging all the dentries to hit the d_ops methods.
>
> dcache.c doesn't check IS_CASEFOLD(inode) - d_init can probably be used
> for this, but we need to be careful when flipping casefolding on and off
> on an (empty) directory, there might still be cached negative dentries.
>
> ext4 has a filesystem wide flag for "case sensitive directories are
> allowed", so that enables/disables that optimization. But bcachefs
> doesn't have that kind of filesystem level flag, and I'm not going to
> add one - that sort of "you have to enable this option to have access to
> this other option" is a pita for end users.

In CephFS it's as simple as setting an extended attribute on a
directory, by admins.

--=20
Patrick Donnelly

