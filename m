Return-Path: <linux-fsdevel+bounces-31137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D19921AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071D91F214B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894218B486;
	Sun,  6 Oct 2024 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/FPXZi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BE168483;
	Sun,  6 Oct 2024 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250305; cv=none; b=jvXNmrNesGa0P2b8ptkCEtk9EwSk6nsVaWJN0rtBkBu9rh54jwAQ9YaC6XnFh5zv3wjwHe4HYPnyCMQJNMMf6wYynomadQdWYwLinN32LNTEKClRgOCHu8elmnPvUwmTooqMq1IXIEYdCYmM44uLVJSfi2BYxiPwHQBomwb3yfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250305; c=relaxed/simple;
	bh=Rpuvcdpqyit1qeF+IfTUewlKIA/7iBINf4p+PTsfqCw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ARsFOsRUl5kMeI6ScG8nnB/ckRFsRaVWis2HNQFI7rhZJl1ZeIDAhaoT/Y6l3NdeTLQA3VllSyECP3BpIl1QfuQNJiH292Hgt0lXAe1invMFheLxQ4kcH5LXVlx5AmVW4WhpjrJghPzglqTbcrbFl2nxCmS1hbwH/7v2o5cdmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/FPXZi5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b6458ee37so43146235ad.1;
        Sun, 06 Oct 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728250303; x=1728855103; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAA3zctoT11UzwI+pwT8qqyHunGBTDbTeer6DRDCYm4=;
        b=e/FPXZi59W8NR3HQd6f12S7v30t6azNqDvnwEHD/fKiyVu21Nx1+V9RGuCQ0ktWj+x
         yDDPIN2vFYtZvp0w8nEi92F+bPJAt8gjtCx+La8sSxBSVtIIsSnuCVj/zWFvpIGIWIo2
         cPCsOYZhqZXu/Hjou+EgIGf4TsIMeVkQKVZgT/4pSIe084A/idBwFbYMna81fmmxCFRy
         FrNROuXsMjU+Jo/KcrwdlwT17g8ay45upS25acJcMG4NTwyetvQ5n1YWRwV36MGb6rOm
         Pab0cg91bXGIXrk3c4LJETRHfbdykHKU9dwjW2yJOIgVoteeaq27rsl/2E5kNsf3HjTc
         Uz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728250303; x=1728855103;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAA3zctoT11UzwI+pwT8qqyHunGBTDbTeer6DRDCYm4=;
        b=pH/h5UBWMCqLFUPcvsxJZRm/dERRT6XmeXNEHa5yAHlNZmxfCStcA1E1h94P4eTO2Z
         0riFJpeXVgG6j5+P4ThscBL3wHsc78nqIiGf3sEdo+WscEJDJeLUbROY/vuSpiB64Ebu
         N2r688tptkE8fXWsOYMzSk9eba5KJHfw+84GHvnNHTJj5JtmtqM6QFa2Nydy9bZJYNok
         YRQUhYgr+wlehWl7KcoIWzTzYQsvwMUFnUHmI5D7CvTtTc5eTfnoWIfYNuJM1tZVuCpq
         8hXZRgF+r04R9+Rl+onp4fJsAyUbyoXFrNKqajFA33BLQBLMLIihT356DESPzh2kBlTU
         tpqw==
X-Forwarded-Encrypted: i=1; AJvYcCUXLGtZ2lwB2f8f4mU+oYlozK4gQwXRbyh4IBrY+OlW3NdaiO700lSqhbncRdCG3a1DJCfiwavQT53IQcsXKQ==@vger.kernel.org, AJvYcCVFNW+MtEWrAWz3HRxBmT3alp75VTf56iAEAPyBopbA6b1xbNa8FE+zklcZuNRcSuhFDQGpVRScAdMlMbcK@vger.kernel.org, AJvYcCVlWKoRuQ8VmfnYsiMmkJcR3ziJjpa+Buj8P+WvkBDdhruhZdU7WZoxRfuwxE8EvUXqULB9lvKT4W0RHqOp+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCm1FymSpb10SqbzUbVa1SpuqCu/uXXy3+xcl9iGrTeGh/aj0T
	x237bjtnPRS+wX0QML1ea5iMnv8td8McUho72nQvPpjBOchAJLAJ
X-Google-Smtp-Source: AGHT+IHFC/02W1kURg0zlEcUfgJpNFo4QrnFKr3uSf5mJblnnhDhydBTX6Gdd2Afp4LI3QDNESHivQ==
X-Received: by 2002:a17:902:fc85:b0:207:6fb:b04f with SMTP id d9443c01a7336-20bfdf7c57bmr148968425ad.17.1728250302965;
        Sun, 06 Oct 2024 14:31:42 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af935sm28630755ad.54.2024.10.06.14.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2024 14:31:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
Date: Mon, 7 Oct 2024 05:31:27 +0800
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Theodore Ts'o <tytso@mit.edu>,
 linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D370F79F-8D33-4156-8675-8C00A2CD2DF3@gmail.com>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
 <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3776.700.51)

On Oct 7, 2024, at 03:29, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> On Sun, Oct 06, 2024 at 12:04:45PM GMT, Linus Torvalds wrote:
>> On Sat, 5 Oct 2024 at 21:33, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>>>=20
>>> On Sun, Oct 06, 2024 at 12:30:02AM GMT, Theodore Ts'o wrote:
>>>>=20
>>>> You may believe that yours is better than anyone else's, but with
>>>> respect, I disagree, at least for my own workflow and use case.  =
And
>>>> if you look at the number of contributors in both Luis and my =
xfstests
>>>> runners[2][3], I suspect you'll find that we have far more
>>>> contributors in our git repo than your solo effort....
>>>=20
>>> Correct me if I'm wrong, but your system isn't available to the
>>> community, and I haven't seen a CI or dashboard for kdevops?
>>>=20
>>> Believe me, I would love to not be sinking time into this as well, =
but
>>> we need to standardize on something everyone can use.
>>=20
>> I really don't think we necessarily need to standardize. Certainly =
not
>> across completely different subsystems.
>>=20
>> Maybe filesystem people have something in common, but honestly, even
>> that is rather questionable. Different filesystems have enough
>> different features that you will have different testing needs.
>>=20
>> And a filesystem tree and an architecture tree (or the networking
>> tree, or whatever) have basically almost _zero_ overlap in testing -
>> apart from the obvious side of just basic build and boot testing.
>>=20
>> And don't even get me started on drivers, which have a whole =
different
>> thing and can generally not be tested in some random VM at all.
>=20
> Drivers are obviously a whole different ballgame, but what I'm after =
is
> more
> - tooling the community can use
> - some level of common infrastructure, so we're not all rolling our =
own.
>=20
> "Test infrastructure the community can use" is a big one, because
> enabling the community and making it easier for people to participate
> and do real development is where our pipeline of new engineers comes
> from.

Yeah, the CI is really helpful, at least for those who want to get =
involved in
the development of bcachefs. As a new comer, I=E2=80=99m not at all =
interested in setting up
a separate testing environment at the very beginning, which might be =
time-consuming
and costly.

>=20
> Over the past 15 years, I've seen the filesystem community get smaller
> and older, and that's not a good thing. I've had some good success =
with
> giving ktest access to people in the community, who then start using =
it
> actively and contributing (small, so far) patches (and interesting, a
> lot of the new activity is from China) - this means they can do
> development at a reasonable pace and I don't have to look at their =
code
> until it's actually passing all the tests, which is _huge_.
>=20
> And filesystem tests take overnight to run on a single machine, so
> having something that gets them results back in 20 minutes is also =
huge.

Exactly, I can verify some ideas very quickly with the help of the CI.

So, a big thank you for all the effort you've put into it!

>=20
> The other thing I'd really like is to take the best of what we've got
> for testrunner/CI dashboard (and opinions will vary, but of course I
> like ktest the best) and make it available to other subsystems (mm,
> block, kselftests) because not everyone has time to roll their own.
>=20
> That takes a lot of facetime - getting to know people's workflows,
> porting tests - so it hasn't happened as much as I'd like, but it's
> still an active interest of mine.
>=20
>> So no. People should *not* try to standardize on something everyone =
can use.
>>=20
>> But _everybody_ should participate in the basic build testing (and =
the
>> basic boot testing we have, even if it probably doesn't exercise much
>> of most subsystems).  That covers a *lot* of stuff that various
>> domain-specific testing does not (and generally should not).
>>=20
>> For example, when you do filesystem-specific testing, you very seldom
>> have much issues with different compilers or architectures. Sure,
>> there can be compiler version issues that affect behavior, but let's
>> be honest: it's very very rare. And yes, there are big-endian =
machines
>> and the whole 32-bit vs 64-bit thing, and that can certainly affect
>> your filesystem testing, but I would expect it to be a fairly rare =
and
>> secondary thing for you to worry about when you try to stress your
>> filesystem for correctness.
>=20
> But - a big gap right now is endian /portability/, and that one is a
> pain to cover with automated tests because you either need access to
> both big and little endian hardware (at a minumm for creating test
> images), or you need to run qemu in full-emulation mode, which is =
pretty
> unbearably slow.
>=20
>> But build and boot testing? All those random configs, all those odd
>> architectures, and all those odd compilers *do* affect build testing.
>> So you as a filesystem maintainer should *not* generally strive to do
>> your own basic build test, but very much participate in the generic
>> build test that is being done by various bots (not just on =
linux-next,
>> but things like the 0day bot on various patch series posted to the
>> list etc).
>>=20
>> End result: one size does not fit all. But I get unhappy when I see
>> some subsystem that doesn't seem to participate in what I consider =
the
>> absolute bare minimum.
>=20
> So the big issue for me has been that with the -next/0day pipeline, I
> have no visibility into when it finishes; which means it has to go =
onto
> my mental stack of things to watch for and becomes yet another thing =
to
> pipeline, and the more I have to pipeline the more I lose track of
> things.
>=20
> (Seriously: when I am constantly tracking 5 different bug reports and
> talking to 5 different users, every additional bit of mental state I
> have to remember is death by a thousand cuts).
>=20
> Which would all be solved with a dashboard - which is why adding the
> bulid testing to ktest (or ideally, stealing _all_ the 0day tests for
> ktest) is becoming a bigger and bigger priority.
>=20
>> Btw, there are other ways to make me less unhappy. For example, a
>> couple of years ago, we had a string of issues with the networking
>> tree. Not because there was any particular maintenance issue, but
>> because the networking tree is basically one of the biggest =
subsystems
>> there are, and so bugs just happen more for that simple reason. =
Random
>> driver issues that got found resolved quickly, but that kept =
happening
>> in rc releases (or even final releases).
>>=20
>> And that was *despite* the networking fixes generally having been in =
linux-next.
>=20
> Yeah, same thing has been going on in filesystem land, which is why =
now
> have fs-next that we're supposed to be targeting our testing =
automation
> at.
>=20
> That one will likely come slower for me, because I need to clear out a
> bunch of CI failing tests before I'll want to look at that, but it's =
on
> my radar.
>=20
>> Now, the reason I mention the networking tree is that the one simple
>> thing that made it a lot less stressful was that I asked whether the
>> networking fixes pulls could just come in on Thursday instead of late
>> on Friday or Saturday. That meant that any silly things that the bots
>> picked up on (or good testers picked up on quickly) now had an extra
>> day or two to get resolved.
>=20
> Ok, if fixes coming in on Saturday is an issue for you that's =
something
> I can absolutely change. The only _critical_ one for rc2 was the
> __wait_for_freeing_inode() fix (which did come in late), the rest
> could've waited until Monday.
>=20
>> Now, it may be that the string of unfortunate networking issues that
>> caused this policy were entirely just bad luck, and we just haven't
>> had that. But the networking pull still comes in on Thursdays, and
>> we've been doing it that way for four years, and it seems to have
>> worked out well for both sides. I certainly feel a lot better about
>> being able to do the (sometimes fairly sizeable) pull on a Thursday,
>> knowing that if there is some last-minute issue, we can still fix =
just
>> *that* before the rc or final release.
>>=20
>> And hey, that's literally just a "this was how we dealt with one
>> particular situation". Not everybody needs to have the same rules,
>> because the exact details will be different. I like doing releases on
>> Sundays, because that way the people who do a fairly normal Mon-Fri
>> week come in to a fresh release (whether rc or not). And people tend
>> to like sending in their "work of the week" to me on Fridays, so I =
get
>> a lot of pull requests on Friday, and most of the time that works =
just
>> fine.
>>=20
>> So the networking tree timing policy ended up working quite well for
>> that, but there's no reason it should be "The Rule" and that =
everybody
>> should do it. But maybe it would lessen the stress on both sides for
>> bcachefs too if we aimed for that kind of thing?
>=20
> Yeah, that sounds like the plan then.



