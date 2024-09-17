Return-Path: <linux-fsdevel+bounces-29573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74397AE85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000931C21CCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11904166F0C;
	Tue, 17 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="EzeXgYQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF15E5DC;
	Tue, 17 Sep 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567933; cv=none; b=R1pRJ/Ylga3sqF4oUYFX3mrlSPQRyEQ2gKKCpcUW9uBEQx14uWXZj4WCTkEFoPg383S4wM2jjOgLgvvsy714k7oJonkpBptwhr490SSl46EWlBel4m3JhONsh78ZfOxPyGkh0nGjeX7GWLhDws/6p7L8QfuQ3iXSxJuu3YNEKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567933; c=relaxed/simple;
	bh=+Fxan0ei7X39eyTJEb/0r6Ru5Bzasua4yPtNhr9nADI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=phQ89ClRHfJbDG/S+MtyrFOdB041T5fHyAEhtUJ3VVj99bRMx0aZ7XNo3Sqae91b/TLZZRXkH7ZyWzsRe+NgOPYQGpI+b8N9450YwH+nl/ZDgebATru/KKwBx4Q8LTYObXRRm0PoF9w1wcUpv9jZuYBPxy2MOfpE6XbvbPgsOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=EzeXgYQi; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726567919;
	bh=cP8/Fn6tBfIOd+vH1Y/PmiZPk7CDO2/GsMaiS3P7iDk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=EzeXgYQigjspo6b8ojyblK2LXyNnz6q359oHf3RoineE9bK9E7Wudt8oPLOJ+BLhc
	 2Z1DbBLSGQTsMKgscBSomb4WKaRw1SehOFcdLjOQLDsAfiEMi1tLOJyGsqjvvm3Gis
	 SeFqs+atjmb2LoyAVoaPcUDKy1XgNJ/vYnmko5ns=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <ZulMlPFKiiRe3iFd@casper.infradead.org>
Date: Tue, 17 Sep 2024 12:11:37 +0200
Cc: Chris Mason <clm@meta.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <9256DE36-5885-41F3-B5C7-ED6BA286E063@flyingcircus.io>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>



> On 17. Sep 2024, at 11:32, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
>> I've got a bunch of assertions around incorrect folio->mapping and =
I'm
>> trying to bash on the ENOMEM for readahead case.  There's a =
GFP_NOWARN
>> on those, and our systems do run pretty short on ram, so it feels =
right
>> at least.  We'll see.
>=20
> I've been running with some variant of this patch the whole way across
> the Atlantic, and not hit any problems.  But maybe with the right
> workload ...?

I can start running my non-prod machines that were affected previously. =
I=E2=80=99d run this on top of 6.11?

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


