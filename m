Return-Path: <linux-fsdevel+bounces-29687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C597C45B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 08:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99924283B58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823F18D65E;
	Thu, 19 Sep 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="ffStb6s8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B57345B;
	Thu, 19 Sep 2024 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727712; cv=none; b=c9SmXwEZ+sbJhinDIUfUFnShtYFRUJlAox215m6G+1Jv4NVZ9TVqyvOseHBgLN36j8kyvUTWmMIxYmyJrlbQbXNYIeB9rByAgEii9zNS1MWpQfOnVkZds/mNA/+lucN7B+rLlzBJ0j8runT4ufWy2thQFyfSB0axW/s4155s3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727712; c=relaxed/simple;
	bh=VRmJB0TDLwZhilpn0qW35CwpUJuZSIY3BltKr4ca9cU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V1eFxi9v7/+kXP+gxI77UVMDbtIuub3Pv23Jr0nzzP279x7k2ObcXzFi7IWJB5Y2dZ09RuXiCtTdRVuQ4LELv16blzXXLlOrSwPO2VM3J8LwUKwMI0HSYEDc5sDDWeQ+UHROvVI2lu2VR+2ux0lTRwHEKCDevR+mmFqLhn1tYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=ffStb6s8; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726727698;
	bh=VRmJB0TDLwZhilpn0qW35CwpUJuZSIY3BltKr4ca9cU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=ffStb6s8HBuWmwvQNys8HfkponNZskM8Va7mK4b5PD+RrjW/eX0uaZKkWUvFVvEPv
	 JBdPaenuRjtZzTY8rHH4hzds6EBghd/8neuhuBb9/7fboUmtwNBWT4R0Tov1iDZCnZ
	 9dLt/GxPJ2WN2iScG890VJaEkwzZo8/UgmT9/o4A=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Date: Thu, 19 Sep 2024 08:34:37 +0200
Cc: Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@meta.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>


> On 19. Sep 2024, at 05:12, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>=20
>> I think we should just do the simple one-liner of adding a
>> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
>> xas_split_alloc()).
>=20
> .. and obviously that should be actually *verified* to fix the issue
> not just with the test-case that Chris and Jens have been using, but
> on Christian's real PostgreSQL load.
>=20
> Christian?

Happy to! I see there=E2=80=99s still some back and forth on the =
specific patches. Let me know which kernel version and which patches I =
should start trying out. I=E2=80=99m loosing track while following the =
discussion.=20

In preparation: I=E2=80=99m wondering whether the known reproducer gives =
insight how I might force my load to trigger it more easily? Would =
running the reproducer above and combining that with a running =
PostgreSQL benchmark make sense?=20

Otherwise we=E2=80=99d likely only be getting insight after weeks of not =
seeing crashes =E2=80=A6=20

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


