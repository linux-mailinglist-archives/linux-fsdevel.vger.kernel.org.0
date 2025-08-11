Return-Path: <linux-fsdevel+bounces-57393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E879B21165
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E943B11D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD4311C23;
	Mon, 11 Aug 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="Obxusw6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01D311C0A;
	Mon, 11 Aug 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928161; cv=none; b=p1fzjobx2m6gaFCTxMPY+cfRS+th1/6KVOQQ1ezAUXPnRYiDMEcPOX0y7JeFiOxMepkFTJdRvLlfK0/i8zpKIxaWi1ZqsGZNgtryqna6SdTf2GxH8tFOUn7FMI2vPR27f0dUis5d7TjaOIFhZEufgAHFWz1ZV6wBPpgEUVX/85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928161; c=relaxed/simple;
	bh=gVKmCoAyy9x30EQWroVVZLSZOdXVdA6INBp7hov+ynI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGm5+uV0jM7l8h3Lgrrz408Qq4FPo0p7OoA49ZahVWLv5zHpcEZTFNdl4NNvNznLoT6/F7gRLafBOER9Shp0a5fye3js50uW2z7R5eJZZ5K/PUqtDCkc2UuRNt5eiyn8ZKtLMon0Ewy2DaFVr+5w4hoW7sVvlJTs12ivb1CuR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=Obxusw6B; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localnet (host-46-241-65-133.bbcustomer.zsttk.net [46.241.65.133])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id 9FBD2649E0;
	Mon, 11 Aug 2025 19:02:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1754928147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVKmCoAyy9x30EQWroVVZLSZOdXVdA6INBp7hov+ynI=;
	b=Obxusw6BJYizYhPcNz4kfwVntrOX2OQ4eZoQOQACE/5NnXko3cFjs2lrj6SEWW+D+ab9k4
	DBBWW6RiCH8u+zM9XqynNXfnC5bXUBAHsZy5ytf0+WQjJ0kMxO5GRweWRxAkSGQc2ZYcCW
	J0CX1icyLc26dFzy+I6bdgFqa5VIhvGgK3vLT11gxqQ+7Mw1tlzUKbQrFAxKQqsU9W2O7V
	HgrehzcScOCVr5rF3h/jMD9srEd7HQgZ8iRHNv5w4GGj75GIcGr0JAuQAMdQjMgStADvUj
	16rQLfzsUkUyYNMdFLFEK1TVaBdwlRuETKckG+hismSGE6D8yXoJVzySca9oeQ==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From: Aquinas Admin <admin@aquinas.su>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>
Cc: Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Mon, 11 Aug 2025 23:02:24 +0700
Message-ID: <5030625.31r3eYUQgx@woolf>
In-Reply-To: <20250809192156.GA1411279@fedora>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> Exactly. Which is why the Meta infrastructure is built completely on btrfs
> and its features. We have saved billions of dollars in infrastructure cos=
ts
> with the features and robustness of btrfs.
>=20
> Btrfs doesn't need me or anybody else wandering around screaming about how
> everybody else sucks to gain users. The proof is in the pudding. If you r=
ead
> anything that I've wrote in my commentary about other file systems you wi=
ll
> find nothing but praise and respect, because this is hard and we all make
> our tradeoffs.
>=20
Sure, of course. The problem is that Meta doesn't need a general-purpose fi=
le=20
system. And yes, and in general, Meta is not the kind of company that makes=
=20
technically sound decisions. Tell me, does Meta still store user passwords =
in=20
plain text? At least in March 2019, Meta was fined for that. Should we ment=
ion=20
that the btrfs used at Meta differs from the btrfs in the kernel? Has "btrf=
s=20
check" stopped completely destroying the file system? Has the problem with=
=20
RAID5/6 (write hole) been solved in more than 20 years of development? Btrf=
s=20
is not the file system that users want to see as a general-purpose file sys=
tem.=20
It works, of course, in certain scenarios. But if you run out of space, you=
=20
even can't delete a file from it. That's the design=E2=80=94bravo! I'm surp=
rised that a=20
technically knowledgeable person would use "god-level" arguments. What file=
=20
system have they saved money on compared to? How does a specific use case a=
lign=20
with general-purpose scenarios? Why did you switch to discussing personal=20
attacks in response to technical criticism?
>=20
> Thanks,
>=20
> Josef




