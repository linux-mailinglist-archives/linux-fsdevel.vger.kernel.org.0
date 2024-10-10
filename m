Return-Path: <linux-fsdevel+bounces-31514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48062997D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD21C230D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8D1AFB35;
	Thu, 10 Oct 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="GKMXlb1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3519DF95;
	Thu, 10 Oct 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542386; cv=none; b=hL0XG0X/Y/Xdv29kmB8e19z+nSNfE5yHZhFJJk2xbmxscmraKhPtEF/v8eku/+JihAcv+zbXc+dI76p+89Fq+plYfV1uP6D90SiXhS3LdFk4Ppz2zr9M9P7nF/01IcjqDJq7WvwFkz21ATEEevLErWm6phgNhXQJUX+Epl/5vMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542386; c=relaxed/simple;
	bh=A9aoV4pLUkmqg5hExqZjkeGcYEq4lkw5kEjIYiFUbCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n8X7xhj4EJD6k8K/VdEGAOSltnaIO/y1/eUlBhdWH/44TJx1na2FnheJN01rYfYTVwWoAGG39k5WDSC8qvsTymBXix1Q5NqlVBIviUiclUo7K6tplb67nq1ZDiOWYL0Nd3elN/a3xLJ8LHaelEUeusD9tKtVXmC8C8AmmNb2Jao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=GKMXlb1b; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1728541781;
	bh=vOuCUK01oxy5k7JbXkIGuKuHjfVwEEjE3/abMmPSBdE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=GKMXlb1b3NZjYTYbzmtz//XxClHYQHHhFh2EOhA8sM7KjLDSs/PVVrRoPZlK8PkVP
	 g4WI2ufab656vcuQZ+2RXKLZKLs6T9PhaIlZ8SUVz5f27XBfim2UtKqvfgTaM4fApr
	 mAIY80OovTFfuWA+9SYacshCY8KUljhCIdESO5Fc=
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
Date: Thu, 10 Oct 2024 08:29:14 +0200
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
Message-Id: <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
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
> Not disagreeing with Linus at all, but given that you've got IO
> throttling too, we might really just be waiting.  It's hard to tell
> because the hung task timeouts only give you information about one =
process.
>=20
> I've attached a minimal version of a script we use here to show all =
the
> D state processes, it might help explain things.  The only problem is
> you have to actually ssh to the box and run it when you're stuck.
>=20
> The idea is to print the stack trace of every D state process, and =
then
> also print out how often each unique stack trace shows up.  When we're
> deadlocked on something, there are normally a bunch of the same stack
> (say waiting on writeback) and then one jerk sitting around in a
> different stack who is causing all the trouble.

I think I should be able to trigger this. I=E2=80=99ve seen around a 100 =
of those issues over the last week and the chance of it happening =
correlates with a certain workload that should be easy to trigger. Also, =
the condition remains for at around 5 minutes, so I should be able to =
trace it when I see the alert in an interactive session.

I=E2=80=99ve verified I can run your script and I=E2=80=99ll get back to =
you in the next days.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


