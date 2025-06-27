Return-Path: <linux-fsdevel+bounces-53155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54AAEB11A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0949E16D45F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567723A9B3;
	Fri, 27 Jun 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Ucl8wNjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2F22A4E5;
	Fri, 27 Jun 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012394; cv=none; b=uRru/oqSXoQYLX+nXimq1BwfvHUuum0IfhafOgHv3+vA/V/j4pje4PDK3VyCSGX7/oA3kP4JluFfj1BPmJWbDQ5xUPAxdUN0XLca8jcIytoP3e9crqjuw81OqJYjV0yGaI/OCqM+gOLQgMEgqkDR/Ex1SxrXx7UrUqZ437JHmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012394; c=relaxed/simple;
	bh=4beAEC+PdvGn8CoJoq0DioHaeqHFZ4gvl3Dqyq4zRWE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nG7cY4MuBZBcCfzSUmO0M0yIsUQ/BOVq+Mk3boPTTBnEnxbtsymA2g6x6Ca3AVIt/oTP4nVYEdl3QhQ7xGFoJ/hjgB4KijZi8ZZzawT3d5y3PXA+sRgcT+55ekiDcSZSHt4rIhpIKy/bOZa7giUJ6QlsTCUmotHH+Duv90+kJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Ucl8wNjh; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1751012388;
	bh=4beAEC+PdvGn8CoJoq0DioHaeqHFZ4gvl3Dqyq4zRWE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=Ucl8wNjhmiXld55MdSlJ/V2tB2hQ5iHUjmZeaHIl7zTcVoMJpq+1wyPpvmemnZKNg
	 iBvv3HcKwEdkMbJC8pFYj5Y51vSErP7Qg6ugLW1VyZunLExxOpVY+DyYYfIgmqPsV9
	 hqgQJIl/J/7YseEWzCUx/RletOZVOgSLM8MJoCwI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <aF49vp50BkfjJOTG@codewreck.org>
Date: Fri, 27 Jun 2025 10:19:34 +0200
Cc: David Howells <dhowells@redhat.com>,
 Ryan Lahfa <ryan@lahfa.xyz>,
 Antony Antony <antony.antony@secunet.com>,
 Antony Antony <antony@phenome.org>,
 Christian Brauner <brauner@kernel.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Sedat Dilek <sedat.dilek@gmail.com>,
 Maximilian Bosch <maximilian@mbosch.me>,
 regressions@lists.linux.dev,
 v9fs@lists.linux.dev,
 netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6CB6E77-082D-442A-A3C9-F2D955E1D285@flyingcircus.io>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
 <ZxlQv5OXjJUbkLah@moon.secunet.de>
 <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <C7DAFD20-65D2-4B61-A612-A25FCC0C9573@flyingcircus.io>
 <aF49vp50BkfjJOTG@codewreck.org>
To: Dominique Martinet <asmadeus@codewreck.org>

Hi,

> On 27. Jun 2025, at 08:44, Dominique Martinet <asmadeus@codewreck.org> =
wrote:
>=20
> Hi all,
>=20
> sorry for the slow reply; I wasn't in Cc of most of the mails back in
> October so this is a pain to navigate... Let me recap a bit:
> - stuff started failing in 6.12-rc1

yes, to my knowledge and interpretation of this thread.

> - David first posted "9p: Don't revert the I/O iterator after
> reading"[1], which fixed the bug, but then found a "better" fix as
> "iov_iter: Fix iov_iter_get_pages*() for folio_queue" [2] which was
> merged instead (so the first patch was not merged)
>=20
> But it turns out the second patch is not enough (or causes another
> issue?), and the reverting it + applying first one works, is that
> correct?
> What happens if you keep [2] and just apply [1], does that still bug?

I tried that and the test that so far under all the variations reliably
crashed (or not) is not crashing in this case.

> (I've tried reading through the thread now and I don't even see what =
was
> the "bad" patch in the first place, although I assume it's =
ee4cdf7ba857
> ("netfs: Speed up buffered reading") -- was that confirmed?)

I was late to the party, to, so I=E2=80=99ll defer to the others.

> David, as you worked on this at the time it'd be great if you could =
have
> another look, I have no idea what made you try [1] in the first place
> but unless you think 9p is doing something wrong like double-reverting
> on error or something like that I'd like to understand a bit more what
> happens... Although given 6.12 is getting used more now it could make
> sense to just apply [1] first until we understand, and have a proper =
fix
> come second -- if someone can confirm we don't need to revert [2].

I guess I confirmed this. However, I=E2=80=99m just barely better than a =
monkey
here so I can=E2=80=99t tell whether this makes sense from the internal =
logic of
things.

To repeat, for safety: my test case worked with the situation you =
described and suggested:
[1] applied on top of 6.12.34 and *not* having [2] reverted.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


