Return-Path: <linux-fsdevel+bounces-29224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D269F97741E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AE1C240E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21781C244A;
	Thu, 12 Sep 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="ZUhlgfLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C5192D89;
	Thu, 12 Sep 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179101; cv=none; b=pe1kOkubBLpS7sqtP96UZR4pKzbgE691tqdGw6yUElax+40n1PDAXceSBeclCusMEahrcV/UPXhRaIWseL9ZR58M+hLIDoNZ9CDk2iFbYG1v/FxgAf8idUkYMbppXcIn1HNrqgpUEfMw5RXCwg0wPKZGG5hrjpObQ4Tq4AqLFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179101; c=relaxed/simple;
	bh=C5b5MUBnTW6H84A4QG+IYJbRrb6slOh/4Ly8FZoKsBw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H/fpLiLRPFJ/9RRg/veQEDiPT40DNJlEaIAd9LAJdBtK29yPZeb8D413oLkfh4SRC8+Xu0lFLqPsjZdGwz5R0RgQe144pNkoYob8CGFCjURvekpewDA4Nz16A+rIbbx2zzs+c3UEMfLbLmN9qrD1v2Ku1zXM4Hl07duknXXrmnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=ZUhlgfLi; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1726179095;
	bh=tLufAUa9Md3zA7yO5hhrLcww1PKNnR1dzXzgw8FRsVc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=ZUhlgfLiJpi0EFJgc0SJooISs/ObkWUgF4bWjtliLY/eQwfcidnzLTtYC97UwswbH
	 gvwvbrgkLKqVaCRv7OPQp4NZa7qonpQOAsiWDmRdMa1ouRIDRTgDpI4z6LME7S7A1g
	 +kipp5bA686f6PsXwaQDfcGM2C1gwIACJeSzL/s4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <ZuNjNNmrDPVsVK03@casper.infradead.org>
Date: Fri, 13 Sep 2024 00:11:14 +0200
Cc: linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 axboe@kernel.dk,
 Daniel Dao <dqminh@cloudflare.com>,
 Dave Chinner <david@fromorbit.com>,
 clm@meta.com,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <969BEE75-323B-4331-8E09-60AA3E662EC6@flyingcircus.io>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>

Hi Matthew,

> On 12. Sep 2024, at 23:55, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Sep 12, 2024 at 11:18:34PM +0200, Christian Theune wrote:
>> This bug is very hard to reproduce but has been known to exist as a
>> =E2=80=9Cfluke=E2=80=9D for a while already. I have invested a number =
of days trying
>> to come up with workloads to trigger it quicker than that stochastic
>> =E2=80=9Conce every few weeks in a fleet of 1.5k machines", but it =
eludes
>> me so far. I know that this also affects Facebook/Meta as well as
>> Cloudflare who are both running newer kernels (at least 6.1, 6.6,
>> and 6.9) with the above mentioned patch reverted. I=E2=80=99m from a =
much
>> smaller company and seeing that those guys are running with this =
patch
>> reverted (that now makes their kernel basically an =
untested/unsupported
>> deviation from the mainline) smells like desparation. I=E2=80=99m =
with a
>> much smaller team and company and I=E2=80=99m wondering why this =
isn=E2=80=99t
>> tackled more urgently from more hands to make it shallow (hopefully).
>=20
> This passive-aggressive nonsense is deeply aggravating.  I've known
> about this bug for much longer, but like you I am utterly unable to
> reproduce it.  I've spent months looking for the bug, and I cannot.

I=E2=80=99m sorry. I=E2=80=99ve honestly tried my best to not make this =
message personally injuring to anybody involved while trying to also =
communicate the seriousness of this issue that we=E2=80=99re stuck with. =
Apparently I failed.=20

As I=E2=80=99m not a kernel developer I tried to stick to describing the =
issue and am not sure what strategies would typically need to be applied =
when individual efforts fail.=20

I=E2=80=99m not sure why it=E2=80=99s nonsense, though.

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


