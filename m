Return-Path: <linux-fsdevel+bounces-30436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BAA98B63A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533551F225D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766211BDAA1;
	Tue,  1 Oct 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="KVDfHOGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D21E4AF;
	Tue,  1 Oct 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769325; cv=none; b=tCbCKnpTBCvPsgBo8TJAf5q6Q1jA0xmLQEn/rVK9LTtEnoNzRJ22MVTuLWTfw6erh8IuvQSJtCjttFk4KL7CmN1KqwjO2Iex0mo+8PD3f46XNJ9vtZre4vAawX+utP7fs8GyyefSkuE5m7aagtMow9pr9DpaVJoZMEWV0QF+G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769325; c=relaxed/simple;
	bh=rdV7eBrtXZUsM0nhn5XQrAKDU6Ms4Eqz8tSiuqdk/Fk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZzZ51WLOh551d2YHUp4dheT4nHloWQLRDrSf7feulolKmKjTZfLexVt/rOBIse7hhh4hBK2u+v+9rRTLQWL4eGns5Dbm7NIvDqgF+c2VGVcisehLckXLMO7XruTdeOC5i7Mza3NiuoPVgw2sCep3Fe9ehBzZiJCSsgQfvbGyhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=KVDfHOGU; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727769320;
	bh=bwcCQFGehdFd44jFd9rXyQb/ofjdQMa0V8EahWXsa/E=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=KVDfHOGUlMTiKO4m3NQk4GcaLwiXyGEFrg49fYDCXSzMLzlvRHXYvCbd/fRU0nqXt
	 4KLLx3Af0ukILjy1rob9w5KTh+ShXRxxUDcxgrAYVxSula9crMDzjv1myQ9bgKkv9j
	 U2SPLFZdRD4ZGmC127pIYdA+3vWkA57kcambOVXo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
Date: Tue, 1 Oct 2024 09:54:56 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7E02C14-B037-41CB-B814-5C404731DAA2@flyingcircus.io>
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
 <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
To: Chris Mason <clm@meta.com>


> On 1. Oct 2024, at 02:56, Chris Mason <clm@meta.com> wrote:
>=20
> I've attached a minimal version of a script we use here to show all =
the
> D state processes, it might help explain things.  The only problem is
> you have to actually ssh to the box and run it when you're stuck.

Thanks, I=E2=80=99ll dig into this next week when I=E2=80=99m back from =
vacation.

I can set up alerts when this happens and hope that I=E2=80=99ll be fast =
enough as the situation does seem to resolve itselve at some point. =
It=E2=80=99s happened quite a bit in the fleet so I guess I should be =
able to catch it.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


