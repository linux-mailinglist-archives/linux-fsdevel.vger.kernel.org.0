Return-Path: <linux-fsdevel+bounces-30408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB498ACC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C980A282EA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3833199E8B;
	Mon, 30 Sep 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="pl7GyzWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DDB183CC5;
	Mon, 30 Sep 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724350; cv=none; b=NqdZ/ynnlTXGa677tX+ukkg7u6MoW2rBIE40dFWZetGNoOpXwmpf+Pto7TRrI1V73ssjXm95o7/6k5TFq3ErcDXwp7uKdG2cuC1ANp4EmmGGnc1SNYPgTdhYrw3gqCefFb66tb2Q/vZK9P95SEvToDwZZ0PCJ9+Z5+fgyD4HEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724350; c=relaxed/simple;
	bh=m2InjGm6QM5pyYnJxFHj7qzzzbLfudPdQ2oG3fwdpAI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lyXqwRjYsX2Sq14UxI1UpOgm3PymCuJd7BqVcdDB8sTASkLw0HwUR9QlstvL9qzGYsAlGMcxcpgj84GRcvfZiXCifVXC//VipkHrD0pFnxlfeFTMOJuBjmiLGbWma3zCUrJJI/EB9mwLWINLOWRBkdo9irYEheWWDrZSaNRfMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=pl7GyzWA; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727724344;
	bh=/oqYHO23CtlMs38L/l795oaos4aeK2PzyY47DMjMR0g=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=pl7GyzWA3rCcYvPx25TKfcekTSb/0hWU288mSYTsN0c4t6kbB4raN4nCg69qC6Q+K
	 FtYSNwSGnaBefcatTqxZdPQrmZoE9LdVprrzZ44yv9MipNZ7w5ULsiFRDzasOHmQn2
	 TpljjdeQIHBXsN8it8IH2fsPeiuUC3PRDpvpbPt8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
Date: Mon, 30 Sep 2024 21:25:22 +0200
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
Message-Id: <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io>
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
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>


> On 30. Sep 2024, at 20:46, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Mon, 30 Sept 2024 at 10:35, Christian Theune <ct@flyingcircus.io> =
wrote:
>>=20
>> Sep 27 00:51:20 <redactedhostname>13 kernel:  =
folio_wait_bit_common+0x13f/0x340
>> Sep 27 00:51:20 <redactedhostname>13 kernel:  =
folio_wait_writeback+0x2b/0x80
>=20
> Gaah. Every single case you point to is that folio_wait_writeback() =
case.
>=20
> And this might be an old old annoyance.

I=E2=80=99m being told that I=E2=80=99m somewhat of a truffle pig for =
dirty code =E2=80=A6 how long ago does =E2=80=9Cold old=E2=80=9D refer =
to, btw?

> [=E2=80=A6]
> IOW, this code is known-broken and might have extreme unfairness
> issues (although I had blissfully forgotten about it), because while
> the actual writeback *bit* itself is set and cleared atomically, the
> wakeup for the bit is asynchronous and can be delayed almost
> arbitrarily, so you can get basically spurious wakeups that were from
> a previous bit clear.

I wonder whether the extreme unfairness gets exacerbated when in a =
cgroup throttled context =E2=80=A6 It=E2=80=99s a limited number of =
workloads we=20
have seen this with, some of which are parallelized and others aren=E2=80=99=
t. (and I guess non-parallelized code shouldn=E2=80=99t suffer much from =
this?)

Maybe I can reproduce this more easily and  ...

> So the code here is questionable, and might cause some issues, but the
> starvation of folio_wait_writeback() can't explain _all_ the cases you
> see.

=E2=80=A6 also get you more data and dig for maybe more cases more =
systematically.
Anything particular you=E2=80=99d like me to look for? Any specific =
additional data
points that would help?

We=E2=80=99re going to keep with 6.11 in staging and avoid rolling it =
out to the production machines for now.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


