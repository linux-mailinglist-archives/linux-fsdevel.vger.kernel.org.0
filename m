Return-Path: <linux-fsdevel+bounces-29703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADF97C7DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567D21C264C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2F19AA41;
	Thu, 19 Sep 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="MdW/JwzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EA33D8;
	Thu, 19 Sep 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741189; cv=none; b=XJh8qN+O6sRjICs5KJKSwnpcU1KGTpYKeMPwz7jCt5q11uh8u6PvaE1EkbaIdVbc2t6mA1zFY7hpHpTJ76sNcA14b3XiZv3WFnz72t6MEp30dvbd4vDfT68+3sIZc38FCed/uM1FYUVgmTFoIT6eW8UhQovfN3XnkuLLa2wSTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741189; c=relaxed/simple;
	bh=yPvEhilC8o+QAD2dAw0R/Y7FjbORjvrTTvmE1gFLzow=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Uvoky0nuP1qj7FSQzFoEB2uqcgzxWiIXuIBJh6iFekV2SBle+fZyXzdPhWp1SF9pyAK+9wPLB8uSLF8iTvPVg3ONkGZ6n9K261L3mIgigd+TahHdVNI6h5k/11ScfIPncxxwzAE9ssudWppXg0h1zCj+1eS3+iCP4vyCZ9a/IWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=MdW/JwzL; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726741181;
	bh=C8urjnOua0GCJAjrYNro+A9+djxFaRIrbs95gdqoxeU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=MdW/JwzLtG7jvM2lKNp19UNEGkA++Q85uQ+qZjR6Gwdt1C7rGaR7xP/GOO7e/Ff73
	 yCRvERCX/lQ8dqkMhIY+NBCdHUAnPm+OuxhsFXaaIWt08iCDrjc450JYCSLAU7m66F
	 Tj4x6f9YQRiT1AWs3G2qXIx+1o4QNalFGYcwxG2g=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
Date: Thu, 19 Sep 2024 12:19:19 +0200
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
Message-Id: <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
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
To: Linus Torvalds <torvalds@linux-foundation.org>



> On 19. Sep 2024, at 08:57, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> Yeah, right now Jens is still going to run some more testing, but I
> think the plan is to just backport
>=20
>  a4864671ca0b ("lib/xarray: introduce a new helper xas_get_order")
>  6758c1128ceb ("mm/filemap: optimize filemap folio adding")
>=20
> and I think we're at the point where you might as well start testing
> that if you have the cycles for it. Jens is mostly trying to confirm
> the root cause, but even without that, I think you running your load
> with those two changes back-ported is worth it.
>=20
> (Or even just try running it on plain 6.10 or 6.11, both of which
> already has those commits)

I=E2=80=99ve discussed this with my team and we=E2=80=99re preparing to =
switch all our=20
non-prod machines as well as those production machines that have shown
the error before.

This will require a bit of user communication and reboot scheduling.
Our release prep will be able to roll this out starting early next week
and the production machines in question around Sept 30.

We would run with 6.11 as our understanding so far is that running the
most current kernel would generate the most insight and is easier to
work with for you all?

(Generally we run the mostly vanilla LTS that has surpassed x.y.50+ so
we might later downgrade to 6.6 when this is fixed.)

> So considering how well the reproducer works for Jens and Chris, my
> main worry is whether your load might have some _additional_ issue.
>=20
> Unlikely, but still .. The two commits fix the repproducer, so I think
> the important thing to make sure is that it really fixes the original
> issue too.
>=20
> And yeah, I'd be surprised if it doesn't, but at the same time I would
> _not_ suggest you try to make your load look more like the case we
> already know gets fixed.
>=20
> So yes, it will be "weeks of not seeing crashes" until we'd be
> _really_ confident it's all the same thing, but I'd rather still have
> you test that, than test something else than what caused issues
> originally, if you see what I mean.

Agreed, I=E2=80=99m all onboard with that.

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


