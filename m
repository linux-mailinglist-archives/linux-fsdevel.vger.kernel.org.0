Return-Path: <linux-fsdevel+bounces-63375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FDBB72B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBC4E87FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF29231A23;
	Fri,  3 Oct 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnzYszeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4721FF46
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501345; cv=none; b=M5+ccDzsHki6ROtg2suyB9/fNCcZVN1MJvyDjsQXkMYz8HjBgvoDx74kztiM5LFXTg0APy313cD626v1YjtEtzP9jGRP7kt4VT+sMt8cp5lezryDMw9gH/RLcKSzX5ZiRxFrr7xtzt/8+h+eOIb8gMZxQ7P/+oGY+qTQC3R76sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501345; c=relaxed/simple;
	bh=R4JEl3Yz3sgGJaybsU/3ezzC1jUA4JJK/jPAfDbETNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSK7aLXtTaZTX/im3DuR2hBcRHmVxzECK20Xni0UOzt1X/LFcIP3ufWX9/obuKm4tu3qZsJfidKOx9GGKMTSONH0VfR+rFvHi87ZRYVSsWsfN6ZGxGY/UCZbCB+IVEki8+fU+8oMTTAxGF+WXFIBSUv9KUd+3zBcFVZ6ScxJf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnzYszeB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso4375174a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501341; x=1760106141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4JEl3Yz3sgGJaybsU/3ezzC1jUA4JJK/jPAfDbETNc=;
        b=nnzYszeBQAq06r91RjvD1hhGTBA8jhWIEuM//5PUviuIppZavQFQcA1Ns8q+K4ohLy
         VLnKSMG6NriAbnP7q5iJkDp3sK73NpUg1v0+d1YTQvYzpOGH399Mme5UEJnCfsYb49rc
         n/y6jXa6075Saefh7ZccVNXQLpKiBM+a/bFzqJNm9NxAFoln8kTZfdXW6IMhQ/ZXzsbH
         MKwCktkLXWLWcXsOyBM9JkhhjUG6gphmsYdyRguwGgWZJ5UJF1ctvLVM67nuNj5AJT4W
         Nv9Y57XFEs29FfP7X76hP6cmu7vDdSF+5A3BqQ33zj0xdYk3ecqOg6MbCZJCA/D8zl2P
         2Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501341; x=1760106141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4JEl3Yz3sgGJaybsU/3ezzC1jUA4JJK/jPAfDbETNc=;
        b=XngVNz3GwQbz6UM9k9L0h58qFwEcW9/pSqMwTiRWBe/rsGtsm/tehlgvv/jphSBW0H
         2w2IHhYtX6iNAx/XWxxtx3uzCYN1wugnJhBWCGI3sDAMu16GSCGxOjGSfP8HUauKetQL
         91lDIK8NDjZvz3/9pKG4muusvsgRbYwqN2vD+ss0V0Jyb1dAH1tz2YyYt2dRYAFs6zoK
         GOCKs4wgYp1JyrZPesAdY72/lz9DvxRN0gSiuryUx8RJQ7u23kS/CPmOsdw5IAZ4gP2S
         OQuEvEyofogeSRCvC+2KXGzzb/H2v3nMRborFr9JwQkOm1zOC9f+U3VvlhYkkfSxGY5A
         mbOQ==
X-Gm-Message-State: AOJu0YwKmFpJ6uq4B795Fpz/rxWd7EOeV5gP2qROgBFAaG9hgTAogIKO
	IdgazVsj17s0g94OAbyTfmBU4+yh60d4eDZJkQ14q+MQZi6fJiwQOuyyDkLio8U8bcumQD99ZSJ
	neCO691f7Vu1MU10ViuJ46+w/uMuleKw=
X-Gm-Gg: ASbGnctLHmrkEQeh83I+af1HW9wLTn3kpP4pFzYaftrV0dIaXwl6u2x3uQSM6IPB9JI
	ZgReB2OkdV/01YcFtJPfssUI41FES2DneBLlSYfVdYgF534i0l01WZObThs3uiZ+jTbOa5z/A9k
	RCzIiMNhLs6YU7pZmq34eSf9RfFK8BCrwQMzyf9Deyzm8GSFLp1A7QO69IpKDVKVvDP3uL5lvF9
	Zk5nDKRPtLPzbmnQDnGDyV/LgU3Gty7BcDmfw+rqfV2tOZpr0UMuX5Hm4Zw8KFyLMdM7UtT0ClL
X-Google-Smtp-Source: AGHT+IFn8sPJ8JSNieXy4fnUbCpe6OVTc6TskeEWa+NZsh6bsZyEXQuHhZewBYBCNhcgdeIHG3JNoxb2lusuwU8NQv4=
X-Received: by 2002:a05:6402:40cc:b0:633:d65a:af0e with SMTP id
 4fb4d7f45d1cf-63939c2dfd9mr3064605a12.28.1759501340664; Fri, 03 Oct 2025
 07:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
In-Reply-To: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Oct 2025 16:22:08 +0200
X-Gm-Features: AS18NWCVgwPKyhs-LS4E175xFcKBUFfD3JL74hVrpJm6CZZh3W4AFuzWzLCNcYY
Message-ID: <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
To: Francesco Mazzoli <f@mazzo.li>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:15=E2=80=AFPM Francesco Mazzoli <f@mazzo.li> wrote=
:
>

Hi Francesco,

> My workplace (XTX Markets) has open sourced a distributed
> filesystem which has been used internally for a few years, TernFS:
> <https://github.com/XTXMarkets/ternfs>. The repository includes both the =
server
> code for the filesystem but also several clients. The main client we use
> is a kernel module which allows you to mount TernFS from Linux systems. T=
he
> current codebase would not be ready for upstreaming, but I wanted to gaug=
e
> if eventual upstreaming would be even possible in this case, and if yes,
> what the process would be.

First of all, the project looks very impressive!

The first thing to do to understand the prospect of upstreaming is exactly
what you did - send this email :)
It is very detailed and the linked design doc is very thorough.

Unfortunately, there is no official checklist for when or whether a
new filesystem
could be upstreamed, but we have a lot of Do's and Don'ts that we have
learned the
hard way, so I will try to list some of them.

>
> Obviously TernFS currently has only one user, although we run on more tha=
n
> 100 thousand machines, spanning relatively diverse hardware and running
> fairly diverse software. And this might change if other organizations ado=
pt
> TernFS now that it is open source, naturally.
>

Very good observation.

A codebase code with only one major user is a red flag.
I am sure that you and your colleagues are very talented,
but if your employer decides to cut down on upstreaming budget,
the kernel maintainers would be left with an effectively orphaned filesyste=
m.

This is especially true when the client is used in house, most likely
not on a distro running the latest upstream kernel.

So yeh, it's a bit of a chicken and egg problem,
but if you get community adoption for the server code,
it will make a big difference on the prospect of upstreaming the client cod=
e.

> The kernel module has been fairly stable, although we need to properly ad=
apt
> it to the folio world. However it would be much easier to maintain it if
> it was mainlined, and I wanted to describe the peculiarities of TernFS to
> see if it would be even possible to do so. For those interested we also
> have a blog post going in a lot more detail about the design of TernFS
> (<https://www.xtxmarkets.com/tech/2025-ternfs/>), but hopefully this emai=
l
> would be enough for the purposes of this discusion.

I am very interested in this part, because that is IMO a question that
we need to ask every new filesystem upstream attempt:
"Can it be implemented in FUSE?"

Design doc says that:
:For this reason, we opted to work with Linux directly, rather than using F=
USE.
:Working directly with the Linux kernel not only gave us the
confidence that we could
:achieve our performance requirements but also allowed us to bend the POSIX=
 API
:to our needs, something that would have been more difficult if we had used=
 FUSE

And later on continue to explain that you managed to work around the POSIX =
API
issue, so all that remains is the performance requirements.

More specifically the README says that you have a FUSE client and that it i=
s
:slower than the kmod although still performant,
:requires a BPF program to correctly detect file closes

So my question is:
Why is the FUSE client slower?
Did you analyse the bottlenecks?
Do these bottlenecks exist when using the FUSE-iouring channel?
Mind you that FUSE-iouring was developed by DDN developers specifically
for the use case of very fast distributed filesystems in userspace.

There is another interesting project of FUSE-iomap [1], which is probably
less relevant for distributed network filesystems, but it goes to show,
if FUSE is not performant enough for your use case, you need to ask
yourself: Can I improve FUSE? (for the benefit of everyone)

It's not only because upstreaming kernel filesystems need to pass muster
with a bunch of picky kernel developers.

If you manage to write a good (enough) FUSE client, it will make your
development and deployments so much easier and both you and your
users will benefit from it.

Maybe the issue that you solved with an eBPF program could be
improved in upstream FUSE?...

[1] https://lore.kernel.org/linux-fsdevel/20250821003720.GA4194186@frogsfro=
gsfrogs/

>
> TernFS files are immutable, they're written once and then can't be modifi=
ed.
> Moreover, when files are created they're not actually linked into the
> directory structure until they're closed. One way to think about it is th=
at
> in TernFS every file follows the semantics you'd have if you opened the f=
ile
> with `O_TMPFILE` and then linked them with `linkat`. This is the most "od=
d"
> part of the kernel module since it goes counter pretty baked in assumptio=
ns
> of how the file lifecycle works.
>
> TernFS also does not support many things, for example hardlinks, permissi=
ons,
> any sort of extended attribute, and so on. This is I would imagine less
> unpleasant though since it's just a matter of getting ENOTSUP out of a bu=
nch
> of syscalls.

I mean it sounds very cool from an engineering POV that you managed to
remove unneeded constraints (a.k.a POSIX standard) and make a better
product due to the simplifications, but that's exactly what userspace
filesystems
are for - for doing whatever you want ;)

>
> Apart from that I wouldn't expect TernFS to be that different from Ceph o=
r
> other networked storage codebases inside the kernel.
>

Except for the wide adoption of the open source ceph server ;)

Cheers,
Amir.

