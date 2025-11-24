Return-Path: <linux-fsdevel+bounces-69721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E771C82CC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 00:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D087734225C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976F272801;
	Mon, 24 Nov 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fh8NOK3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DA13B7A3;
	Mon, 24 Nov 2025 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764026218; cv=none; b=jX5RnoYQ8QmquE4AauPPk7qzsNDaRqasVEa0d8HOjGh7pLCNfb8kSWpzSi7vukYQdKpAMXu1VgXas/T9ZaQiD6ynjZaAmSbnajibrHtP8t0VoVnnGi/nxqhRI1ruQMoO+ukKpmMiKdfI5ng4cv2guu5IAUt6xDdOtlBnO2aq/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764026218; c=relaxed/simple;
	bh=WuUqt3dEXDvPu5KmwxQgVbX7UgipeeEuKuf0wfU8+Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZF2k2YbbYbgrwGkpOUOgytDIaXmjffMe6s3FwLfFPQ/gxubvOc0J5TAyQ8OqmtdTVslNm65DX/zws3x74aj4ryWKhlAK/izlzKJI+UrCc6W6ElMZsxx+gh308EFLjjdpnXLoe8bJ63VLDtS7VXHziJWFnuC2u4nHc99ePk1J34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fh8NOK3+; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764026208; x=1764631008; i=quwenruo.btrfs@gmx.com;
	bh=abKC7okpozjDR38O1FwEAuXCjGH5Emc/e8tZoLKfbKQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fh8NOK3+/J1ucBrftfI2hB5WYM0SHTjnpprqsN9zLsnY3IGNp5tPQNONC8WMPEAc
	 GoR2MjKvXVEpu9PpMUsUNWVPdznLTMKJsSXejgGS9vjNTXkbUMfaUl5r8D56pvbUe
	 xP5+xaZ4ZAld7iBNqEisx3T+uaS2xzCpu3Qmtus21piY8FxLh+bZGlbx6x+6v+/IV
	 gITdT2l8FZ4T//DobUEZW3+Qab4oJBXOApyBoVn+C/8ORdXx1N/VOebbZlHIZrR1Y
	 9OhesvmTWbrliGVVO97JtEFzL228Fc71PxZXpsMyFIJA5UfTM8zYk1OH3T6S+GZSM
	 L7ECMv6Ag5uHuYECQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1vWuuY0gRm-00XJqs; Tue, 25
 Nov 2025 00:16:48 +0100
Message-ID: <61e75b68-8f09-4496-9bb9-b8d34c5872e8@gmx.com>
Date: Tue, 25 Nov 2025 09:46:44 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: dsterba@suse.cz
Cc: Daniel Vacek <neelx@suse.com>, Filipe Manana <fdmanana@kernel.org>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <20251121153850.GP13846@twin.jikos.cz>
 <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
 <CAPjX3FdrTZwzuObrERxP=pLmSMjYt6Drqfxn4S5ENmL_JQhkzw@mail.gmail.com>
 <58e0b0e5-c72c-43de-a1ec-b9d85a71bbdf@gmx.com>
 <20251124222506.GS13846@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251124222506.GS13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L/htMCw8Gr3bUUDnWxojBZkitND/GrhlVbqU5j2UMKMmZ8J/nMf
 Y4n+NvlVVziya7bm91l6/EGDRlgEkLbsK3RxEbi6X5cHuhH2e4+z8D8g1AErrSiKU+4qCR2
 C+4qfQ970UGUrIktu0+iJ4UrrhrwZY5BnXk57xPO5IiNOtiZaWJK1mgAe1+KYxWNlQeYMOa
 8chf/jPv4hwcmo3CJgCcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rHll/f0GYIM=;0cy4g7DTGRCbwtEe5woxxI2leZ9
 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
 4V2p9ErPPsyt1qOyRWcVLDpwhcTMD2zixsjR+Y



=E5=9C=A8 2025/11/25 08:55, David Sterba =E5=86=99=E9=81=93:
> On Sat, Nov 22, 2025 at 07:16:06AM +1030, Qu Wenruo wrote:
[...]
>> Then check fs/*.c.
>>
>> There are guard(rcu) and rcu_read_lock() usage mixed in different files=
.
>>
>> E.g. in fs/namespace.c it's using guard(rcu) and scoped_guard(rcu),
>> meanwhile still having regular rcu_read_lock().
>>
>> There are more counter-examples than you know.
>> We're not the first subsystem to face the new RAII styles, and I hope w=
e
>> will not be the last either.
>=20
> We take inspiration from other subsystems but that some coding style is
> done in another subsystem does not mean we have to do that too. If
> fs/*.c people decide to use it everywhere then so be it.
>=20
> I was hesitant to introduce the auto cleaning for btrfs_path or kfree
> but so far I found it working. The locking guards are quite different to
> that and I don't seem to get any liking in it

They are all RAII, I didn't see much difference between them.

Although the path auto-freeing is hiding quite some bad designs.

The path should only be allocated when first utilized (normally by=20
btrfs_search_slot()).
But our btrfs_search_slot() design also needs to reuse pre-allocated=20
paths for certain call sites, thus we have to treat path auto-freeing=20
just like auto-freeing a pointer. It is just a compromise.

So you're just saying, "I'm fine with a compromise, but not the properly=
=20
deisnged usage".


I won't argue that guard() may be a little tricky to read and expand in=20
the future, but I see the readability cost is still way better than=20
potential missing unlocks.

Not to mention we have scoped_guard(), which is making the critical=20
section much easier to expose, and still easy to expand.

[...]
>> We're just a regular subsystem in the kernel, not some god-chosen
>> special one, we do not live in a bubble.
>=20
> Honestly, this is a weird argument to make. There are local coding
> styles that are their own bubbles, look at net/* with their own special
> commenting style and mandatory reverse xmass tree sort of variables (I
> think that one has been adopted by other subsystems too). Contributing t=
o
> those subsystems means following their style. If you want an example
> of a filesystem with unique code formatting style then go no further
> than XFS.

This is not coding style, but whether to adapt an existing=20
practices/interfaces utilized by several programming languages and=20
subsystems.

A lot of core synchronization code is already supporting RAII, and VFS=20
is also trying pushing new RAII based APIs for filesystems, e.g:

https://lore.kernel.org/linux-btrfs/20251104-work-guards-v1-0-5108ac78a171=
@kernel.org/

You can go whatever code style you like, but in the end we're still=20
depending on the infrastructures from VFS/MM/Block layers, you can not=20
resist the change from them, or go the path to a deprecated fs in the=20
future.

>=20
> I think we've been doing fine in btrfs with the style consistency and
> incremental updates of old code when possible. This means we have fewer
> choices for personal "creative expression" how the code is written but
> in the long run it makes the code look better.

Then there is no conflicts with RAII, it's all about to write better and=
=20
more correct code.

And RAII even provides less "creative way" on how to release a resource.
No creative tag names or whatever.

There may be some cases like holding different locks for a critical=20
section, thus we may want to choose between things like scoped_guard()=20
{guard()} or { guard(); guard(); }, but that's way less creative than=20
manual GC with tags.

>=20
> The problem with the guards is that there's no one good way for their
> general use, i.e. the problem of mixing with explicit lock/unlock,

Yes, I see some bugs during the above VFS RFC patch.

But that's the common thing of development. Code changes will bring=20
bugs, but in the long run I believe RAII is way safer than manual GC,=20
and encourages us to do better design of variable lifespan.

> trylock,

There are already "*_try" guards defines, although I only find very few=20
users though.

E.g. drivers/input/keyboard/maple_keyb.c:

	scoped_guard(mutex_try, &maple_keyb_mutex) {


> unlock/lock order,

Isn't that the advantage of RAII? Compilers ensure the reserve order of=20
releasing when exiting the scope.

Other than human-error-prone manual GC.


> etc. Allowing both styles will lead to
> inconsistent style based on personal preferences again.

You're asking for a huge code change on a large code base.

You should know it's not going to be done in a sudden, mixed RAII and=20
manual GC will stay for a while.

I'm not encourage mixing, but that's just unavoidable.

I'd suggest not to mix any RAII and manual GC inside the same function.

>=20
> As said on slack, we'll get to a conclusion.

At least I hope it's a future-proof conclusion.

Thanks,
Qu


