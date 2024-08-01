Return-Path: <linux-fsdevel+bounces-24736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B79442EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267481F22893
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CB157464;
	Thu,  1 Aug 2024 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5z42Y9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDC1EB490;
	Thu,  1 Aug 2024 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491682; cv=none; b=by+4GtgC1PC/dozRDJqN4sDfsppJG6184k/uWHn+ex7j7tGyzbQHS1yOCfATzM5Mmb7GYkzQ7tuPHEknrehxuFbyVvf0KgAPKfNml3YLTRD+DFc1nGBq1z72KCa2933oRDQEdPfxMQlKBEXpB+3tOMciP4aaNc3zaXkr/KIlC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491682; c=relaxed/simple;
	bh=igymYzHUQVm5MbWwgMoMzd4vz1YDx9DV1QIU5SLGkJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggal7yKxXcImril8dXNtGlt0sCaCP/yEDN16FQa5H/UWLiWge2SZxJTb6+dT9F6rDG6XoA0qeiRL2xrupTvxmaRf5ZoEsh7URhKTHOR11TBQVJydOa+riG5fTTxZveYT6+XdvUGYBgUSIDb5/Ppu5gwQsQApwTPvbau+VEPJ7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5z42Y9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC23C4AF09;
	Thu,  1 Aug 2024 05:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722491682;
	bh=igymYzHUQVm5MbWwgMoMzd4vz1YDx9DV1QIU5SLGkJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P5z42Y9xbWP7BJbqpdSTiTuYRq5xwUFjAnkq1Ti78s1UoFsBRwQusHnOEh3OmnRI2
	 Xjqi7bSfmI2gXfBcqlOtZEbdpwsdKCLHKPLrQdLrTxIawG+LviQDq15PZjmawRs9T1
	 EYgP7LW05f2IGpVxp82M2O7uE3v2sJ+tRprwafpnd0wRHgT+NrzEkMImjANjcHe8ww
	 3iL6H/kaBhoolddt9qr8CUh9vB+IYzC1lO+JNceHaq2UN+LXDi2ll97K08A3jcAEsZ
	 mQQazdQpPprllr9f0CtA1+A97DeyUlb1rVoj8ycSE/8ULVULO5RpQAWYlH24IUlOpp
	 qDmo2K51iuZYQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5b986a806so914086eaf.1;
        Wed, 31 Jul 2024 22:54:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtqJrlPREGLp/MaKQDDJB1Eaj8wTJkOuL2Yzsh/pUTmXBf4EPZYXpDttEyozt4si9u5BEUknQ1s2LdVwHnRq/eM0pEpuvOUwIL4/pM8sjWLHdCsCDkNSNRtTleVRKalSJSNMlwH/O2htYUaQ==
X-Gm-Message-State: AOJu0YzA9yDIxUpHJjPHHxENIdZ48THijUfixpTRxYNVl96vv9qoAySF
	vFSQw8PAblxl/EVIACI6drNB6NuO+ezwGzUx0+uAzlMT2s5ZU/DYtp0h0iNsccWBYZGUHQu6HRF
	mrnPIU/0cJIW6gH67dcEIRkUCrw4=
X-Google-Smtp-Source: AGHT+IGo7u8EirNjcXThh2hv9rEeu18P6HFYrA+WThuwbS5/ca5Rw01VzcktSLNAJM4/CF91axOCKDNE0ynQ5xSoUF0=
X-Received: by 2002:a05:6870:eca7:b0:25e:fca:e689 with SMTP id
 586e51a60fabf-268877a6b76mr93988fac.10.1722491681767; Wed, 31 Jul 2024
 22:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d0405eea668458d9507aa36e223f503@BJMBX02.spreadtrum.com>
In-Reply-To: <8d0405eea668458d9507aa36e223f503@BJMBX02.spreadtrum.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 1 Aug 2024 14:54:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8y7-XzBeGLRKgEabcZEabmfn2ZTHXgb9jPXwTN5fb3NA@mail.gmail.com>
Message-ID: <CAKYAXd8y7-XzBeGLRKgEabcZEabmfn2ZTHXgb9jPXwTN5fb3NA@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: check disk status during buffer write
To: =?UTF-8?B?5bSU5Lic5LquIChEb25nbGlhbmcgQ3VpKQ==?= <Dongliang.Cui@unisoc.com>
Cc: Christoph Hellwig <hch@infradead.org>, "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>, =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>, 
	=?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>, 
	=?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>, 
	"cuidongliang390@gmail.com" <cuidongliang390@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 8=EC=9B=94 1=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 2:30, =
=E5=B4=94=E4=B8=9C=E4=BA=AE (Dongliang Cui) <Dongliang.Cui@unisoc.com>=EB=
=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Besides the additional checks for the shutdown flag already mentioned the=
 subject is now incorrect I think, it should talk about implementing shutdo=
wn handling.
>
> In case you haven't done so yet, please also see if exfat now passes the =
various testcases in xfstests that exercise the shutdown path.
>
> Otherwise this looks reasonable to me, thanks for the work!
>
> Hi Christoph,
>
> Thank you for your suggestion. I think the current patch is primarily aim=
ed at addressing the issue of hotplug and ensuring writers are notified whe=
n a device has been ejected.
>
> Previously, exfat didn't have a shutdown process inherently, and hotplug =
didn't pose any significant issues, except for the one we're discussing in =
this email.
>
> Therefore, regarding what specific actions should be taken during shutdow=
n, I would appreciate your input or any suggestions from Sungjong and Namja=
e.
>
> Additionally, can the shutdown handling be supplemented with another patc=
h if there is indeed a need to implement some exfat shutdown processes?
>
> HI Sungjong and Namjae.
>
> Based on the above, what do you think, or do you have any suggestions?
There is no reason to split it into two and I would prefer to apply it
as one patch.
I would appreciate it if you could send the list an updated v4 patch
including what Christoph and I pointed out.

