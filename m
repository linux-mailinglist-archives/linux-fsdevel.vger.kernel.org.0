Return-Path: <linux-fsdevel+bounces-31133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA599208B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 21:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBA1F20419
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC818A931;
	Sun,  6 Oct 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OIadaYup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB6189B99
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241507; cv=none; b=ddKhOfkYp5XQl5DzbaFNON/JHRVs00rR3Nyyrj10NC7Ny3fGZPsM71YytosMLDPMuID8bege+PqG9TtEI+RbSp6whcE9+KYEBPyPEYD4Yj64J8hrnQ4gPP/QAxAduFrsZxpTWYJz8dpqIK5XDHtTrNr33F6zMfFbFE+hVvu0Rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241507; c=relaxed/simple;
	bh=lBUg1G5w0xbiORJkJOiJgn1ZBETpknqPHoI9s+ukgpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBxS39sEq/vtvb+GsAoWcMpm+RUCTCMZiseoti0gJEQX3hFd9QOJS7zwUILuXRmXZN7KRwRVGvyS2T5bb+TvLGGASnJJEIspXXVVKCpvU4LW4DI7eH0JMAIJnUr/TJOCFb9Cnr9tE9dnOBqv5i5eoEQt9Cj9euN+2IXPxastn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OIadaYup; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so5268728a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728241504; x=1728846304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/pTi4WP+DUWGLMsn6tW08xKN8735zsCNYj+R00ve1A=;
        b=OIadaYupnpoT5nXmcNCvkX+Kp2uo+phSbSISfVRvuULWqnGAfyw8bevqa30mAcN84Q
         zBUb+go1TPXCcgtTe25MqPq9Pr49gOnBflrFa501amWUPIEzNlZRazWyxewlEtp4DLJg
         LH1UQpLaR4F+laUAnyx3iFXub0PX+OA/xeyMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728241504; x=1728846304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/pTi4WP+DUWGLMsn6tW08xKN8735zsCNYj+R00ve1A=;
        b=O8DUwYNqc5iX/oXTbRRTwSnDNopo047NwsmF4maAzh26DMJDaS8SiIbe0ZBHDzdLmE
         IuiVOE3ADS44oNkpkLtB8pdnoYEE9Z+FJbQ1g6Ek/vRrkwQ3YU7HOSHN3qER990H5Gzi
         PDB6ESW88BK6hRnK/nW8x+12L9cHYqhQc84PY3eCieN8bIdZSN97ODJfzQrafXPsR9vs
         VF/unLG1/NYD/+su0Y+6b0DOTLRidJD1t3p3CO/5+5htpZFX22iuAfmWxJ780IjlJlGA
         Y+L8EsFNKTd615jVCG/PPViszP5rUgju+CDVqQVa6mt6x0YU/FwBQ/LUaihb+OrfnqgD
         Z5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX+tYM36G6TTLd/tBS5vIkp05ALHyLngv81myEh4BZJSQIKIKqLIb8d53x/5hEhCi5p2MrxfVQu0EKiEeVA@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+FMJZd3UANDtS39HGk6aZW22OIHO+d1YdRu76/nUArdPB4fM
	4F8Vc91Sujj0jyvTyPZmaJUNa4AKvrAlTYTR/0vTnxv/7T38JFVvcsY5xE2jX67tbIOAnNUjsMV
	RGSU=
X-Google-Smtp-Source: AGHT+IHVHfia3Ih+7G8PES4dTHsyGyN0q4QeSLCW5WsbTxmW975ckRIjbsohr9s9wHKR6FAvxUOrMw==
X-Received: by 2002:a17:907:ea0:b0:a80:7193:bd93 with SMTP id a640c23a62f3a-a991bd40f79mr1036180466b.25.1728241503814;
        Sun, 06 Oct 2024 12:05:03 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05be8d2sm2337646a12.53.2024.10.06.12.05.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 12:05:02 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so5115778a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 12:05:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtqnwgo19aRfmy/aJhEEOwSLg5fkpPE4AEp9EKsp8mfmnVTNIBMbv3oKr/fxzfrnSWMTUEr/AvFSeqlPUB@vger.kernel.org
X-Received: by 2002:a17:907:2681:b0:a8a:91d1:5262 with SMTP id
 a640c23a62f3a-a991bd71ddcmr1143956566b.28.1728241502270; Sun, 06 Oct 2024
 12:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu> <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
In-Reply-To: <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Oct 2024 12:04:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
Message-ID: <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 21:33, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Sun, Oct 06, 2024 at 12:30:02AM GMT, Theodore Ts'o wrote:
> >
> > You may believe that yours is better than anyone else's, but with
> > respect, I disagree, at least for my own workflow and use case.  And
> > if you look at the number of contributors in both Luis and my xfstests
> > runners[2][3], I suspect you'll find that we have far more
> > contributors in our git repo than your solo effort....
>
> Correct me if I'm wrong, but your system isn't available to the
> community, and I haven't seen a CI or dashboard for kdevops?
>
> Believe me, I would love to not be sinking time into this as well, but
> we need to standardize on something everyone can use.

I really don't think we necessarily need to standardize. Certainly not
across completely different subsystems.

Maybe filesystem people have something in common, but honestly, even
that is rather questionable. Different filesystems have enough
different features that you will have different testing needs.

And a filesystem tree and an architecture tree (or the networking
tree, or whatever) have basically almost _zero_ overlap in testing -
apart from the obvious side of just basic build and boot testing.

And don't even get me started on drivers, which have a whole different
thing and can generally not be tested in some random VM at all.

So no. People should *not* try to standardize on something everyone can use.

But _everybody_ should participate in the basic build testing (and the
basic boot testing we have, even if it probably doesn't exercise much
of most subsystems).  That covers a *lot* of stuff that various
domain-specific testing does not (and generally should not).

For example, when you do filesystem-specific testing, you very seldom
have much issues with different compilers or architectures. Sure,
there can be compiler version issues that affect behavior, but let's
be honest: it's very very rare. And yes, there are big-endian machines
and the whole 32-bit vs 64-bit thing, and that can certainly affect
your filesystem testing, but I would expect it to be a fairly rare and
secondary thing for you to worry about when you try to stress your
filesystem for correctness.

But build and boot testing? All those random configs, all those odd
architectures, and all those odd compilers *do* affect build testing.
So you as a filesystem maintainer should *not* generally strive to do
your own basic build test, but very much participate in the generic
build test that is being done by various bots (not just on linux-next,
but things like the 0day bot on various patch series posted to the
list etc).

End result: one size does not fit all. But I get unhappy when I see
some subsystem that doesn't seem to participate in what I consider the
absolute bare minimum.

Btw, there are other ways to make me less unhappy. For example, a
couple of years ago, we had a string of issues with the networking
tree. Not because there was any particular maintenance issue, but
because the networking tree is basically one of the biggest subsystems
there are, and so bugs just happen more for that simple reason. Random
driver issues that got found resolved quickly, but that kept happening
in rc releases (or even final releases).

And that was *despite* the networking fixes generally having been in linux-next.

Now, the reason I mention the networking tree is that the one simple
thing that made it a lot less stressful was that I asked whether the
networking fixes pulls could just come in on Thursday instead of late
on Friday or Saturday. That meant that any silly things that the bots
picked up on (or good testers picked up on quickly) now had an extra
day or two to get resolved.

Now, it may be that the string of unfortunate networking issues that
caused this policy were entirely just bad luck, and we just haven't
had that. But the networking pull still comes in on Thursdays, and
we've been doing it that way for four years, and it seems to have
worked out well for both sides. I certainly feel a lot better about
being able to do the (sometimes fairly sizeable) pull on a Thursday,
knowing that if there is some last-minute issue, we can still fix just
*that* before the rc or final release.

And hey, that's literally just a "this was how we dealt with one
particular situation". Not everybody needs to have the same rules,
because the exact details will be different. I like doing releases on
Sundays, because that way the people who do a fairly normal Mon-Fri
week come in to a fresh release (whether rc or not). And people tend
to like sending in their "work of the week" to me on Fridays, so I get
a lot of pull requests on Friday, and most of the time that works just
fine.

So the networking tree timing policy ended up working quite well for
that, but there's no reason it should be "The Rule" and that everybody
should do it. But maybe it would lessen the stress on both sides for
bcachefs too if we aimed for that kind of thing?

             Linus

