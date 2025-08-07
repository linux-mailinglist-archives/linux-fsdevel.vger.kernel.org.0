Return-Path: <linux-fsdevel+bounces-56985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6032B1D83B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD801AA41DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA3254AF5;
	Thu,  7 Aug 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="lT3lpeDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5ED125D6;
	Thu,  7 Aug 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570927; cv=none; b=NyQEBpazRmGAtLZa7w6klWCIlme7n5SVGSApwhzXF/UGpkfoe6nUHaCmfMrSB4xGF2xnPRpoI8yq6K2WIflWOZQXgtV3U2IoWpMsmLCAW0z2LUrarBk8QFAYR2NkvC5o6DGVi0bVGd29ukG8yeTryhusXV4Z7hu15wAF92U6jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570927; c=relaxed/simple;
	bh=U8KEEURk5qfhc86MD9bRvMHAHEupAimMFaWGHIvzC+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnqeBVIg/CQh+xpA0ReXdOfADPTvUZP1PcDp2PpMkKSffNzMrOVWCCf7/K+PqoPbhc3JOlqx0Se5zUPJlpC+T10EiIGs8mEcqef7US+kR6iBIKaKAJSIIoFNDZVqcNYjYoekIcO5/MhjTNrY7eWNUX2JLqMJKQ4QTVaG2IRL8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=lT3lpeDZ; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localnet (host-46-241-65-133.bbcustomer.zsttk.net [46.241.65.133])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id B0706708CC;
	Thu,  7 Aug 2025 15:42:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1754570561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8KEEURk5qfhc86MD9bRvMHAHEupAimMFaWGHIvzC+U=;
	b=lT3lpeDZqQeC9m4cj3n0axS4HCvp7Xv9NpPXsVzKSbfYxxiw5XA0J6cq/FwGzlMn86dKZx
	glLCIIrQiAjFYkt5sw1IIMrU+SNmeSU6HzGNRiFgNcxpM8Pzdt2g3rUCB1KYmy5MmdUuXg
	kxGceG35K4MkTRIQYyNjxa1XbYMZJ/e4CoohKwJNvpuWJKhHJyM3QB2iMEVVXuSs52UCNp
	3EiQSIqxbbgloV8cHsS3ihIj8VnOz5VAnsEPPg/Oo7zTprP+Cu9wqaVtHP9vFem07RZd3h
	DtXdd8xkX7jmOe1LyAdEmfw2fxotmwtZfW3YEtxOPlYLNMvXhYWRIIDokH+VjA==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From: Aquinas Admin <admin@aquinas.su>
To: Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Thu, 07 Aug 2025 19:42:38 +0700
Message-ID: <5909824.DvuYhMxLoT@woolf>
In-Reply-To: <1869778184.298.1754433695609@mail.carlthompson.net>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Generally, this drama is more like a kindergarten. I honestly don't underst=
and=20
why there's such a reaction. It's a management issue, solely a management=20
issue. The fact is that there are plenty of administrative possibilities to=
=20
resolve this situation.

Assign a specific person to handle issues with Kent, if Linus is unable to =
do=20
so.
Simply freeze the patch acceptance for a certain period, explaining the=20
situation, and ignoring it if the problem is really there. Then resume work=
=2E=20
This has already been done and it was reasonable.
Explain to the person who is wrong in the discussion, draw conclusions, and=
=20
possibly make some exceptions or changes in the process.
The main task of management is to work with engineers, who are often not=20
politically correct or have their own view of the world. If you throw out a=
=20
successful development that has proven its viability into the cold, I have=
=20
questions about your actions. Anyway, I have plenty of questions about the=
=20
Linux Foundation in general. The point is that many remember how the projec=
t=20
was born and how it developed.

So, tell me, you release a product. You have a well-organized development=20
cycle. You find a problem that prevents your product from being used as=20
advertised. You already have an RC. The only way to fix the problem is to a=
dd=20
new functionality to one of the product's subsystems. Will you release a=20
product with known issues and later issue an errata, or will you make the=20
necessary changes, provided no one is standing behind you with an axe=20
threatening to cut your head off for a delay in the release? What's so terr=
ible=20
about that?

What's so terrible about fixing a bug in a subsystem marked as experimental=
,=20
which some of your customers use? Especially since it will only affect thos=
e=20
customers who use this subsystem, as others won't include it in their build=
=20
processes.

This "We don't start adding new features just because you found other bugs"=
=20
sounds absurd. So, if we find bugs, they can't be fixed if we need to exten=
d the=20
functionality before the release? Excuse me, what? I clearly understand the=
=20
absurdity of this requirement. Because it effectively means that if we noti=
ce=20
that ext4 is corrupting data only in RC simply because some code was forgot=
ten=20
to be added to a subsystem during the release window, we can't accept the f=
ix=20
because it requires adding new functionality and we will release the versio=
n=20
with the problem. I clearly understand that this is not the exact situation=
,=20
but it was done as a solution to an existing user's problem. Moreover, the=
=20
amount of changes is not that significant. Especially since it's not really=
 a=20
fix but a workaround, a useful one that can actually help some real users i=
n=20
certain situations.

new USB serial driver device ids 6.12-rc7 is this new functionality or not?
ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx 6.11-rc7 - new=20
functionality?
ALSA: hda/realtek: Enable Mute Led for HP Victus 15-fb1xxx - 6.11-rc7
Octeontx2-pf: ethtool: support multi advertise mode - 6.15-rc5
drm/i915/flipq: Implement Wa_18034343758
drm/i915/display: Add drm_panic support
Is this different? Or are the rules somehow not for everyone?

But no, instead, this is what happened.

Yes, the file system is marked as experimental. However, everyone knows tha=
t=20
there are users who use this file system in a production environment. It's =
just=20
how it has historically been. Usually, it's SOHO, but that doesn't change=20
much. Everyone knows that the file system has a very interesting design and=
=20
some features that make it the most optimal solution. At least now, it is=20
already successfully used as a replacement for LVM-Cache, DM-Cache, Bcachef=
s,=20
etc. No existing file system today offers this functionality. Btrfs does no=
t=20
offer this functionality on various types of devices. Let's not consider ZF=
S,=20
since it's an Out-Of-Tree project and has a number of problems and=20
limitations, and even though such functionality could be implemented, it's =
not=20
SOHO.

Therefore, instead of development, we are getting nonsense in the form of=20
freezing the project or, worse, throwing the codebase away entirely. Why?=20
Maybe we should switch from development to degradation?

As for the "trust issue," we've seen many examples of malicious code being=
=20
included in the kernel. That's also a trust issue, isn't it? From this=20
perspective, you can't use Linux at all. There's no way. You know, You can'=
t=20
have it both ways. Either that or nothing at all. Why these half-measures?

I somehow feel that we should start with management, not throwing the proje=
ct=20
into the cold.
> If we're giving our personal opinions I lean the other way.
>=20
> I make no statement about the quality of Mr. Overstreet's code or whether=
 it
> is (or isn't) stabilizing. But for me as someone who's made a career out =
of
> Linux it's not just about code it's about *trust*. For me personally I've
> made the decision to remove bcachefs entirely from my personal workstatio=
ns
> and lab where I'd been testing and using it extensively for years. It's
> harsh to say it but I simply do not trust Kent's decision making process
> nor do I trust him as a *person* enough for me to be comfortable running
> bcachefs. I base this not on what other's may have said or written about
> him but on my own interactions with him and reading his own words.
>=20
> This can (and hopefully will) change. People can grow... particularly
> through adversity. I'm hopeful that if it's decided that bcachefs will be
> removed or its in-kernel development paused Kent may reevaluate what's
> important and how he deals with people. I look forward to being able to
> trust bcachefs again but that's not right now.
>=20
> Just my 2=C2=A2.
>=20
> > On 2025-08-05 2:19 PM PDT Malte Schr=C3=B6der <malte.schroeder@tnxip.de=
> wrote:
> >=20
> > On 28.07.25 17:14, Kent Overstreet wrote:
>> <Overquoting deleted>.





