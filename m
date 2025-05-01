Return-Path: <linux-fsdevel+bounces-47809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E15AA5A68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B5A3BA81F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01423182D;
	Thu,  1 May 2025 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L9wt7WDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A624A3C;
	Thu,  1 May 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746075118; cv=none; b=BLHQNUYPQeq/4R03dZMh71kpyEATIajqnzCyyfOc437Y+Spc11Q717vP3sH6IGiDHE61aTdndaYr5xZDw9TLFySZ3m0tJxDaVC+5l1EwcIkj/XmuWLMGF4FVJx6PaZJcRQrSq+Cl5c2CmRypPZ9KMT+fNQvVGNA9/afdgimLKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746075118; c=relaxed/simple;
	bh=716ukKB5M5rS+p/pdm3qtUxpHkVGWowLi7wobQnuVEg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TlzUFvIAxUcpCOphvfLRClPGZk72VlHMBvom8ymqC4Jzjh3H28GAe1lNdQ8ts9l8begYlr3DCk3ai6Vkt8auiiwJ/fcX4KoBzwDUo8j5i6wkBwkvQ45BnjGGpzs2Hp/21qAUOih12KET9RNyU4rrCPzJ3k+/Vh/Bpjo5A+NxKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=L9wt7WDk reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5414plu31230948
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Apr 2025 21:51:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5414plu31230948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746075108;
	bh=gsD4ysvzga/lVrqP4m3K9wqrBkKkMcJz5LBHqTbst5w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=L9wt7WDkb4do8JzuGpigt4bvka29pgARFSF0wLiOSkPOURXG6n3Gupfnif8Y6KWIX
	 W5n4wM9srHTLLerDmaSggYBYUnvuPgsthiflC1tmr86Wdmx5VY27zWSs+g0/5ko0Td
	 cJtUyPzaPEmIdoWFxq+fFTPT964dQiQXTNeuvFdJqThoIVPOQmwEfInNFz8Q37vLdW
	 ATY4z4yW9bu3Lg7VToen51qgBzyJOx8ZYXGNI2Vw4o2NRGes28SYOKHooGd6hdOR1o
	 Sp63PeKT3xBzXbU6zZ+inIiJMxNkyVYEpWXGrTl+LI9LlJMXLcFFh+r50kFps+OZo8
	 dki/TH0/7SRaQ==
Date: Wed, 30 Apr 2025 21:51:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "Theodore Ts'o" <tytso@mit.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgwuu5Yp0Y-t_U6MoeKmDbJ-Y+0e+MoQi7pkGw2Eu9BzQ@mail.gmail.com>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip> <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com> <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp> <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com> <20250425195910.GA1018738@mit.edu> <d87f7b76-8a53-4023-81e2-5d257c90acc2@zytor.com> <CAHk-=wgwuu5Yp0Y-t_U6MoeKmDbJ-Y+0e+MoQi7pkGw2Eu9BzQ@mail.gmail.com>
Message-ID: <D8CDCA7B-BF0B-4095-BA69-AEEA4C56B7CC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 30, 2025 8:12:20 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Wed, 30 Apr 2025 at 19:48, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> It is worth noting that Microsoft has basically declared their
>> "recommended" case folding (upcase) table to be permanently frozen (for
>> new filesystem instances in the case where they use an on-disk
>> translation table created at format time=2E)  As far as I know they hav=
e
>> never supported anything other than 1:1 conversion of BMP code points,
>> nor normalization=2E
>
>So no crazy '=C3=9F' matches 'ss' kind of thing? (And yes, afaik that's
>technically wrong even in German, but afaik at least sorts the same in
>some locales)=2E
>
>Because yes, if MS basically does a 1:1 unicode translation with a
>fixed table, that is not only "simpler", I think it's what we should
>strive for=2E
>
>Because I think the *only* valid reason for case insensitive
>filesystems is "backwards compatibility", and given that, it's
>_particularly_ stupid to then do anything more complicated and broken
>than the thing you're trying to be compatible with=2E
>
>I hope to everything holy that nobody ever wants to be compatible with
>the absolute garbage that is the OSX HFS model=2E
>
>Because the whole "let's actively corrupt names into something that is
>almost, but not exactly, NFD" stuff is just some next-level evil
>stuff=2E
>
>            Linus
>

Yeah, collation order is highly localized, and had never made the assumpti=
on of being expected to be used as a unique lookup key=2E

It's also completely inconsistent, even between neighboring locales, like =
how in Swedish and Finnish =C3=85 sorts before =C3=84/=C3=86 and =C3=96/=C3=
=98 whereas as Danish and Norwegian sort =C3=85 after; even though everyone=
 agrees =C3=84/=C3=86 and =C3=96/=C3=98 are the same letter and are to be s=
orted the same=2E Icelandic doesn't have =C3=85 but sorts it as Danish afte=
r =C3=84 and =C3=98(!) but stuffs =C3=9E after Z instead of with or after T=
=2E Swedish, and I believe the other Nordic languages, sort =C3=9C as Y, bu=
t in German =C3=84, =C3=96, and =C3=9C are sorted as A, O and U=2E



