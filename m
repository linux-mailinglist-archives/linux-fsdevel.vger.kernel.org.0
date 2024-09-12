Return-Path: <linux-fsdevel+bounces-29221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EC977394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31470B22F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0CE1C2449;
	Thu, 12 Sep 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Mpmiq3co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BB18BB80;
	Thu, 12 Sep 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176488; cv=none; b=KZ6ch7XRX5iy/Xv/d65gM5cRZeroZOP0h8WR1dddw8gf93H6WcrsjUN6+Yz2rwWDniDOdZJcEbT1rXxklYapym4Tp9BGy2GnLMGYwyVXLrY7xB9U8Rnzc3zNu6H2slsc+7o6zCRiFvo2QTE2/iWfQlPWODSZFTnCoy7C4tZCVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176488; c=relaxed/simple;
	bh=RTKdlsvETPxqXxjU7Rd93X4kyI4i83Yt+XK3zkX09p8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=mnDRJEwJYgwSugi6l/nLRZZAZwkdx2eRvV4g3ZkKGYBVWxuHoyC3U4sfHdOE0PPWX67vR5nnKf5IW7HN3eezafKWqeS/eM7xuAPOWEAVtBN4sk6ppKsWqE0zNFoNueKP7E7ZllKaPQ1hLB0cI4zHhxusvjhDGXmiELnANUC0ZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Mpmiq3co; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
From: Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726175937;
	bh=RTKdlsvETPxqXxjU7Rd93X4kyI4i83Yt+XK3zkX09p8=;
	h=From:Subject:Date:Cc:To;
	b=Mpmiq3cofaB5rbLbLbuVBsRAlNFsqRTeXxL4W1BX8XPw/xWWQ5UDy3y47Te6V9Epu
	 2zDs/cQdphkBs69kuP8ASTUB23zi+3SsQen8Z/a5oQmOtJK7F4EzIc4Sm9rmFM33Z+
	 ZL1soSGZ9MBkX7BUV+Y4k0WmaPIc70TYE6M4Tb3s=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Known and unfixed active data loss bug in MM + XFS with large folios
 since Dec 2021 (any kernel from 6.1 upwards)
Message-Id: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
Date: Thu, 12 Sep 2024 23:18:34 +0200
Cc: torvalds@linux-foundation.org,
 axboe@kernel.dk,
 Daniel Dao <dqminh@cloudflare.com>,
 Dave Chinner <david@fromorbit.com>,
 willy@infradead.org,
 clm@meta.com,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
To: linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello everyone,

I=E2=80=99d like to raise awareness about a bug causing data loss =
somewhere in MM interacting with XFS that seems to have been around =
since Dec 2021 =
(https://github.com/torvalds/linux/commit/6795801366da0cd3d99e27c37f020a8f=
16714886).

We started encountering this bug when upgrading to 6.1 around June 2023 =
and we have had at least 16 instances with data loss in a fleet of 1.5k =
VMs.

This bug is very hard to reproduce but has been known to exist as a =
=E2=80=9Cfluke=E2=80=9D for a while already. I have invested a number of =
days trying to come up with workloads to trigger it quicker than that =
stochastic =E2=80=9Conce every few weeks in a fleet of 1.5k machines", =
but it eludes me so far. I know that this also affects Facebook/Meta as =
well as Cloudflare who are both running newer kernels (at least 6.1, =
6.6, and 6.9) with the above mentioned patch reverted. I=E2=80=99m from =
a much smaller company and seeing that those guys are running with this =
patch reverted (that now makes their kernel basically an =
untested/unsupported deviation from the mainline) smells like =
desparation. I=E2=80=99m with a much smaller team and company and I=E2=80=99=
m wondering why this isn=E2=80=99t tackled more urgently from more hands =
to make it shallow (hopefully).

The issue appears to happen mostly on nodes that are running some kind =
of database or specifically storage-oriented load. In our case we see =
this happening with PostgreSQL and MySQL. Cloudflare IIRC saw this with =
RocksDB load and Meta is talking about nfsd load.

I suspect low memory (but not OOM low) / pressure and maybe swap =
conditions seem to increase the chance of triggering it - but I might be =
completely wrong on that suspicion.

There is a bug report I started here back then: =
https://bugzilla.kernel.org/show_bug.cgi?id=3D217572 and there have been =
discussions on the XFS list: =
https://lore.kernel.org/lkml/CA+wXwBS7YTHUmxGP3JrhcKMnYQJcd6=3D7HE+E1v-guk=
01L2K3Zw@mail.gmail.com/T/ but ultimately this didn=E2=80=99t receive =
sufficient interested to keep it moving forward and I ran out of steam. =
Unfortunately we can=E2=80=99t be stuck on 5.15 forever and other kernel =
developers correctly keep pointing out that we should be updating, but =
that isn=E2=80=99t an option as long as this time bomb still exists.

Jens pointed out that Meta's findings and their notes on the revert =
included "When testing nfsd on top of v5.19, we hit lockups in =
filemap_read(). These ended up being because the xarray for the files =
being read had pages from other files mixed in."

XFS is known to me and admired for the very high standards they =
represent regarding testing and avoiding data loss but ultimately that =
doesn=E2=80=99t matter if we=E2=80=99re going to be stuck with this bug =
forever.

I=E2=80=99m able to help funding efforts, help creating a reproducer, =
generally donate my time (not a kernel developer myself) and even =
provide access to machines that did see the crash (but don=E2=80=99t =
carry customer data), but I=E2=80=99m not making any progress or getting =
any traction here.

Jens encouraged me to raise the visibility in this way - so that=E2=80=99s=
 what I=E2=80=99m trying here.

Please help.

In appreciation of all the hard work everyone is putting in and with =
hugs and love,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


