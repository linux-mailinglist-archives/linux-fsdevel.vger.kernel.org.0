Return-Path: <linux-fsdevel+bounces-31212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0E9930D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100CE287240
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CF1D54DC;
	Mon,  7 Oct 2024 15:13:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC81E520;
	Mon,  7 Oct 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313996; cv=none; b=GDr2bOiHHoebYDrWm3kQIZFFadG0EaI6OW32vofunvYrL3mULcRfXWxh/p5PTHvu9D8d6eoZ0mFVg0IccCB4b8yDheoovPHaloyoJ1yX508YxjygcAm2jRWD1j2PPU+4QR756TzQ0Czl1VoAs7R22KDQAuwhsGm/LpEda/8LCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313996; c=relaxed/simple;
	bh=oaaLkpOG0AT8mgOnXKIXzciDAGxaG0My0xFLbu4xLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+ssRBN5WY9qH88RDPuGJ+edOa6UXc2vU3/jGap9bRAClYPmIanWi0AukDx5QwdXIJeDQoOlxonnrNBUr/qsOgpHiC/+/HND8mr4Cns7AvPPdmx0fNyIOlU7TrbaRUdulV5/mOQG/8/acumkV/Dy5qk3W5nJOlL+LItur2sKxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id B325674980;
	Mon, 07 Oct 2024 15:13:03 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Date: Mon, 07 Oct 2024 17:13:03 +0200
Message-ID: <6091333.lOV4Wx5bFT@lichtvoll.de>
In-Reply-To: <v2k6atl7hlaxw4ktu4e2j7mj67sbz63vzrqk6pnxmntrkuzwut@3k4knhrlnqeb>
References:
 <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <5987583.MhkbZ0Pkbq@lichtvoll.de>
 <v2k6atl7hlaxw4ktu4e2j7mj67sbz63vzrqk6pnxmntrkuzwut@3k4knhrlnqeb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Kent Overstreet - 06.10.24, 19:18:00 MESZ:
> > I still do have a BCacheFS on my laptop for testing, but meanwhile I
> > wonder whether some of the crazy kernel regressions I have seen with
> > the last few kernels where exactly related to having mounted that
> > BCacheFS test filesystem. I am tempted to replace the BCacheFS with a
> > BTRFS just to find out.
>=20
> I think you should be looking elsewhere - there have been zero reports
> of random crashes or anything like what you're describing. Even in
> syzbot testing we've been pretty free from the kind of memory safety
> issues that would cause random crashes

Okay.

=46rom what I saw of the backtrace I am not sure it is a memory safety bug.=
=20
It could be a deadlock thing with work queues. Anyway=E2=80=A6 as you can r=
ead=20
below it is not BCacheFS related. But I understand too little about all of=
=20
this to say for sure.

> The closest bugs to what you're describing would be the
> __wait_on_freeing_inode() deadlock in 6.12-rc1, and the LZ4HC crash that
> I've yet to triage - but you specifically have to be using lz4:15
> compression to hit that path.

Well a crash on reboot happened again, without BCacheFS. I wrote that I=20
report back, either case.

I think I will wait whether this goes away with a newer kernel as some of=20
the other regressions I saw before. It was not in all of the 6.11 series=20
of Debian kernels but just in the most recent one. In case it doesn't I=20
may open a kernel bug report with Debian directly.

=46or extra safety I did a memory test with memtest86+ 7.00. Zero errors.

As for one of the other regressions I cannot tell yet, whether they have=20
gone away. So far they did not occur again.

But so far it looks that replacing BCacheFS with BTRFS does not make a=20
difference. And I wanted to report that back.

Best,
=2D-=20
Martin



