Return-Path: <linux-fsdevel+bounces-47796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8214AA59FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314F34A446A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDA22FF22;
	Thu,  1 May 2025 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Cq5CnQfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81314C80;
	Thu,  1 May 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070342; cv=none; b=oUgdpqxUH3w8/Bvp04HZqB2vOWCexAr2mgiH73CXkMu9nwIMQZkuQT2HR0/Qq8rV4mFq4s7ZQfKO9SVDIXWn+0L9v0H0GKY/KvHx9o8n3syRAQeM1bwqfIPLjJ1i5if7OfGU+kYY0lo2r2CaW2dz9YyT3eNoCiOAx3SgxTQSE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070342; c=relaxed/simple;
	bh=fRMZdEm7fOJ8v4QMbXUj8vea++1ipKTKHFyioNAwYaw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g6MQ8LVDfaOgm/TSzMNveFKiDlVwGiuQJwcDZwc0NLeS3AAWTA4PNHdOGFlvi+Dsp4jivWgzB3K9+5TTZ3oFfhOetDX89hP7Tv2cfQholjVdcc2TnPavjnqWRMHyXlzAgOF6txjZ0rzOqmxElVXv1Od5PBLaWPXuMiI2ZtQA8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Cq5CnQfu reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5413W3Ga1206913
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 30 Apr 2025 20:32:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5413W3Ga1206913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1746070325;
	bh=wZ8hCQkM3wsEnq2HUgkkQULMcmqkfBTaRw1XvFt2KG4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Cq5CnQfumMQgV/QuJlPOpMFFl3/hdCSTtri7CsWNwhcJ78uojh9NbSgAJPCeA5CCi
	 kzL0HT7n4URyLjbruVPu/4HLsSkEsmpdiSg9gg7H+CQ+Fz8ghHX3WcINt3y3/SnoLz
	 gzIQZrq/S1ru3Wb+nQMlHk8ynljGXBi2xcchb4uv+UryTVux1VIoziPxS9g/iYt/TS
	 pxjT+Z7UZeyEWMj84CTHl1ABDIie/2+IGzJFs7topZwUZiCZNzJhqPouYyEfNs65wl
	 KwqjRGbO6xjeHrbYaTnyLdx7Hl1FdLip3zqj1BSeNJ/koUkur53dJFz6YBdofU2VOD
	 esZ+xdGZIuyjQ==
Date: Wed, 30 Apr 2025 20:32:03 -0700
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
Message-ID: <114E260B-7AC4-4F5D-BBC4-60036CC7188F@zytor.com>
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

I suspect the NFD bit in HFS comes from the use of decomposed characters i=
n the 8-bit character systems of MacOS Classic=2E

