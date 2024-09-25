Return-Path: <linux-fsdevel+bounces-30116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DF98650B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834561F26793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C85588E;
	Wed, 25 Sep 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="ERP++1tb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24749482EB;
	Wed, 25 Sep 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282549; cv=none; b=uCWB5xKiZr7G5XbKncAToCHHRnU563qlfQ2QIMT7xO/yuu946n+rJgOP//TCQgBJ92zD208fiGuVRF8egZes3LLg+NY9kPTeIMgCzEolwNFRNVWX4kFN4jMERRm4ivP3K2COm3lnNdT+3a10X8gn58RQKC8KYYcrA5B5/z1OqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282549; c=relaxed/simple;
	bh=oA161oXEIQ4guVGXQDc4q7uLp2UFDyKiyr/RvZCjPAM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hm7O/w0ZG/UBTU44epbVdWBfHmETLlvZe+QBz2sYEeeArY455SsCk1QTcw896Njxh4RCHJAqPyJ//bLYDnPKvIPbjAMoMPFPh6b0PMqtUXYGZiQg/2mQJofD7M+Kf0ph1sR9nG85KO4qJUVidmFNgYN8eW1W8fCC8Dw9O2EMU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=ERP++1tb; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727282543;
	bh=oA161oXEIQ4guVGXQDc4q7uLp2UFDyKiyr/RvZCjPAM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=ERP++1tbL0DSo1ZnTsIBOqd81AXzG64+ZA7CjnMOerFjy0zEOHxOG3HdxnuFmgwH+
	 zSDSqT74x3V1Lopz/+5kApJ8SMQG8tVFEb7sgbkqpy3CBQ5Ma3PrGUxnxJM/+9rkxz
	 jyIB5+RIEex4DFEi3qs1ajYKWWkAIMKftfH7dnN0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
Date: Wed, 25 Sep 2024 18:42:00 +0200
Cc: Sam James <sam@gentoo.org>,
 stable@kernel.org,
 clm@meta.com,
 Matthew Wilcox <willy@infradead.org>,
 axboe@kernel.dk,
 Dave Chinner <david@fromorbit.com>,
 dqminh@cloudflare.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 regressions@leemhuis.info,
 regressions@lists.linux.dev,
 torvalds@linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EC5C349-325C-4EF6-AFF8-0952B7A3D364@flyingcircus.io>
References: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
 <87plotvuo1.fsf@gentoo.org>
 <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>



> On 25. Sep 2024, at 18:06, Kairui Song <ryncsn@gmail.com> wrote:
>=20
> On Wed, Sep 25, 2024 at 1:16=E2=80=AFAM Sam James <sam@gentoo.org> =
wrote:
>>=20
>> Kairui, could you send them to the stable ML to be queued if Willy is
>> fine with it?
>>=20
>=20
> Hi Sam,
>=20
> Thanks for adding me to the discussion.
>=20
> Yes I'd like to, just not sure if people are still testing and
> checking the commits.

As the one who raised the issue recently: we=E2=80=99re rolling out 6.11 =
for testing on a couple hundred machines right now. I=E2=80=99ve =
scheduled this internally to run 8-12 weeks due to the fleeting nature =
and will report back if it pops up again or after that time has elapsed.

AFAICT this is a fix in any case even if we should find more issues in =
my fleet later.

Cheers,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


