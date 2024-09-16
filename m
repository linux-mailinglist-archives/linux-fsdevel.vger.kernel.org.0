Return-Path: <linux-fsdevel+bounces-29439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA8979BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F26B21277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19113C9A6;
	Mon, 16 Sep 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="E9epe5D3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8EA13BC0E;
	Mon, 16 Sep 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470922; cv=none; b=Cytw4EEw7cIC6JMGHZJd/qSI6jrGXLIo6UOQBLqBjKfoqYSvYX72zs6P1vUBoXWBXm2fc3Q+PepeEY5RxlnctuXY/M5kLBu8kKZ+Pj/mdzjxK5YsTGHqq9lcCIltbtMIrsk5ZyTveX0mBuUotDAOfq8mJPhFUsZgXx6ljocav3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470922; c=relaxed/simple;
	bh=RBngxJaZL4GTM0BgQCbsFFJ3NPAyFTCVteDqTkYdZFE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mfz63E4FtoZbDyEBGlBb3hulLLbcFa9B4zNzv/DJYRZryRgmDBVprRzeFmagyzHA10AJt9rS9IVGkpG9BBnZf8Lz7wotre9U4sR9B4zvoqEGqQAS+GO2Ngrj7CUYbBjNW3+14EbdfPW4KHo6u6xF/M0EElkoOD/HcU1/iKpIrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=E9epe5D3; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726470908;
	bh=t9TGglCebkVwz3Xfy8T8OgJ7gnTHiWWWEXfL6kuEj/E=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=E9epe5D3D1j+Q+sICOdAlUUKkZN6QetDxnUXPHefyIa63ZlqWP1lclUkb+7l8cWEf
	 rsaAiCHiWmruiNdTaYBVwekXCY0u0mcMUF5vAWHLDxbPL2nuIattrWFD2EJ6Z3IXw9
	 N9n65hNnyi+a/Ys2GeVYLfnN3+1xaQrrJtvsJpJg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <Zud1EhTnoWIRFPa/@dread.disaster.area>
Date: Mon, 16 Sep 2024 09:14:45 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 clm@meta.com,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <686D222E-3CA3-49BE-A9E5-E5E2F5AFD5DA@flyingcircus.io>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
To: Dave Chinner <david@fromorbit.com>


> On 16. Sep 2024, at 02:00, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Thu, Sep 12, 2024 at 03:25:50PM -0700, Linus Torvalds wrote:
>> On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
>> Honestly, the fact that it hasn't been reverted after apparently
>> people knowing about it for months is a bit shocking to me. =
Filesystem
>> people tend to take unknown corruption issues as a big deal. What
>> makes this so special? Is it because the XFS people don't consider it
>> an XFS issue, so...
>=20
> I don't think this is a data corruption/loss problem - it certainly
> hasn't ever appeared that way to me.  The "data loss" appeared to be
> in incomplete postgres dump files after the system was rebooted and
> this is exactly what would happen when you randomly crash the
> system. i.e. dirty data in memory is lost, and application data
> being written at the time is in an inconsistent state after the
> system recovers. IOWs, there was no clear evidence of actual data
> corruption occuring, and data loss is definitely expected when the
> page cache iteration hangs and the system is forcibly rebooted
> without being able to sync or unmount the filesystems=E2=80=A6
> All the hangs seem to be caused by folio lookup getting stuck
> on a rogue xarray entry in truncate or readahead. If we find an
> invalid entry or a folio from a different mapping or with a
> unexpected index, we skip it and try again.  Hence this does not
> appear to be a data corruption vector, either - it results in a
> livelock from endless retry because of the bad entry in the xarray.
> This endless retry livelock appears to be what is being reported.
>=20
> IOWs, there is no evidence of real runtime data corruption or loss
> from this pagecache livelock bug.  We also haven't heard of any
> random file data corruption events since we've enabled large folios
> on XFS. Hence there really is no evidence to indicate that there is
> a large folio xarray lookup bug that results in data corruption in
> the existing code, and therefore there is no obvious reason for
> turning off the functionality we are already building significant
> new functionality on top of.

Right, understood.=20

However, the timeline of one of the encounters with PostgreSQL (the =
first comment in Bugzilla) involved still makes me feel uneasy:
=20
T0                   : one postgresql process blocked with a different =
trace (not involving xas_load)
T+a few minutes      : another process stuck with the relevant =
xas_load/descend trace
T+a few more minutes : other processes blocked in xas_load (this time =
the systemd journal)
T+14m                : the journal gets coredumped, likely due to some =
watchdog=20

Things go back to normal.

T+14h                : another postgres process gets fully stuck on the =
xas_load/descend trace


I agree with your analysis if the process gets stuck in an infinite =
loop, but I=E2=80=99ve seen at least one instance where it appears to =
have left the loop at some point and IMHO that would be a condition that =
would allow data corruption.

> It's been 10 months since I asked Christain to help isolate a
> reproducer so we can track this down. Nothing came from that, so
> we're still at exactly where we were at back in november 2023 -
> waiting for information on a way to reproduce this issue more
> reliably.

Sorry for dropping the ball from my side as well - I=E2=80=99ve learned =
my lesson from trying to go through Bugzilla here. ;)

You mentioned above that this might involve read-ahead code and that=E2=80=
=99s something I noticed before: the machines that carry databases do =
run with a higher read-ahead setting (1MiB vs. 128k elsewhere).

Also, I=E2=80=99m still puzzled about the one variation that seems to =
involve page faults and not XFS. That=E2=80=99s something I haven=E2=80=99=
t seen a response to yet whether this IS in fact interesting or not.=20

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


