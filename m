Return-Path: <linux-fsdevel+bounces-29627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80E97B963
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 10:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2653D1F21812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE81547E6;
	Wed, 18 Sep 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Rd5vvMao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58A1509AB;
	Wed, 18 Sep 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648298; cv=none; b=ZICOavf9tTZTibQpHfuuDS2WJxzSZlFAmWTfrLBhIuhk682+15VAB+l9syFrVeONw0/OUUXw3FDS+H9yyOTBbQkSvKUSM031Ke28z6NxmCIl80sTZuoJq9lWYntV2LAiS+Q+5shuFOEE6F0rbFCw9i+YeO6oRXPvGpUwKlBzML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648298; c=relaxed/simple;
	bh=Fzn1aEdw/yxhbLMFY9G3xd1Gy61G7ncfaBdVHUMisvY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CHx3ziIlmoX3a1vU8eSeNrCIC5PyBDCXVqhGUjiEeB7jH1Cm+dy4yKtV59uLRGtrr0dZ7TkQr+SxJKANYYukzYF34WK76smwdL3ud6iAdF1BIf64XwQ4YoS+VKSbQbeduZ7hzck4CJ+P6zFpCj50Hos7XGMDAQYL9tg6Axe1VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Rd5vvMao; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726648291;
	bh=me6yhkQ1Qf7Nz+9dw5lt1yO15V7nP5XWT/aS4UjahWA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=Rd5vvMaolEmrl1l2z1ggs+5be2/6j4K964x7uMBLhVcPO2gEU/eYonbL1WLMHsp2+
	 QT8qbQk0uFrMQew4heoH4gNpduUY/4ziQ8d6f9V2MVqoQat69ad6Vx9Eghq6wD66pw
	 LS293864SUaoed/IsnRGnQ8RKO7SFKGBlbrR9QzE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <686D222E-3CA3-49BE-A9E5-E5E2F5AFD5DA@flyingcircus.io>
Date: Wed, 18 Sep 2024 10:31:09 +0200
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
Message-Id: <0C392D79-DAB1-4730-B2AB-B2B8CF100F11@flyingcircus.io>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <686D222E-3CA3-49BE-A9E5-E5E2F5AFD5DA@flyingcircus.io>
To: Dave Chinner <david@fromorbit.com>



> On 16. Sep 2024, at 09:14, Christian Theune <ct@flyingcircus.io> =
wrote:
>=20
>>=20
>> On 16. Sep 2024, at 02:00, Dave Chinner <david@fromorbit.com> wrote:
>>=20
>> I don't think this is a data corruption/loss problem - it certainly
>> hasn't ever appeared that way to me.  The "data loss" appeared to be
>> in incomplete postgres dump files after the system was rebooted and
>> this is exactly what would happen when you randomly crash the
>> system. i.e. dirty data in memory is lost, and application data
>> being written at the time is in an inconsistent state after the
>> system recovers. IOWs, there was no clear evidence of actual data
>> corruption occuring, and data loss is definitely expected when the
>> page cache iteration hangs and the system is forcibly rebooted
>> without being able to sync or unmount the filesystems=E2=80=A6
>> All the hangs seem to be caused by folio lookup getting stuck
>> on a rogue xarray entry in truncate or readahead. If we find an
>> invalid entry or a folio from a different mapping or with a
>> unexpected index, we skip it and try again.  Hence this does not
>> appear to be a data corruption vector, either - it results in a
>> livelock from endless retry because of the bad entry in the xarray.
>> This endless retry livelock appears to be what is being reported.
>>=20
>> IOWs, there is no evidence of real runtime data corruption or loss
>> from this pagecache livelock bug.  We also haven't heard of any
>> random file data corruption events since we've enabled large folios
>> on XFS. Hence there really is no evidence to indicate that there is
>> a large folio xarray lookup bug that results in data corruption in
>> the existing code, and therefore there is no obvious reason for
>> turning off the functionality we are already building significant
>> new functionality on top of.

I=E2=80=99ve been chewing more on this and reviewed the tickets I have. =
We did see a PostgreSQL database ending up reporting "ERROR: invalid =
page in block 30896 of relation base/16389/103292=E2=80=9D.=20

My understanding of the argument that this bug does not corrupt data is =
that the error would only lead to a crash-consistent state. So =
applications that can properly recover from a crash-consistent state =
would only experience data loss to the point of the crash (which is fine =
and expected) but should not end up in a further corrupted state.

PostgreSQL reporting this error indicates - to my knowledge - that it =
did not see a crash consistent state of the file system.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


