Return-Path: <linux-fsdevel+bounces-41703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0BEA35682
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B3A3ABD34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49937189F5C;
	Fri, 14 Feb 2025 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ4v0Hiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52772753E8;
	Fri, 14 Feb 2025 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512041; cv=none; b=uXKysY5AFOLg8BD/Rw53X0WdR8gS31vEl9FuGmsNpCxPVEYt5gJ06I11nxoHOrkFBSKaRsKw30KPZqeC7J9vyg0Gj3Z99+7WISpV1TMaF+wK46rwMojlY5wY3cd3WMSaJzpAT/tN5swiAIt3a2zdjJdJVDAS5J9coX50iYf4ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512041; c=relaxed/simple;
	bh=cbLJRPAe4FdB5zSYAAPI2ZPCnC8vpVyAmNNQXNv+Cvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EP+4MO3sckI/DIHp+GvbEwSDYggzlNbDvCHFog+JawBQ+pFUuPG5oBOImggCU5Ydro8eRjwPhXpFdySAbwW9vJN3kIKHEPknUxRNZJhT1mQTg3tgUByyo/86BkS22PnvgQ4IBTh2pbYQI7ZBRspeUApf9GV06K3k8wtT/j+pofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ4v0Hiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E80DC4CEE7;
	Fri, 14 Feb 2025 05:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739512041;
	bh=cbLJRPAe4FdB5zSYAAPI2ZPCnC8vpVyAmNNQXNv+Cvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQ4v0Hiyv0Mpbt0YtL9v26nqfFa667WYkJ19hhTepnSpVVDb3FwLGIAoGN3mx5Nrj
	 A6UvOVb4dkpT3jMQ7v9FZo5WJRS39LL5nfojx6KusU31NlFaFCCS/bAQ7CZpPA61Kf
	 fhUCqFH74Yv15y4atuz12+QwEfOTrgvGeoOBjI60iTXoqIF/C6b4uOmaxoCWOiFcFQ
	 sCu6d9lb4VY5bj2XM7p0Vrota+KAJzI9w0dCRBicBy+47/Fm3WR9mc+K6eRBlPhQXL
	 r5JZH/QK1QeFnDsAIekBKKMA2kP8bZJJI8SckQNsZzeyR6vdI9vLThzxe/Hkgzjkrq
	 cT63c+XLaKVgA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bc607b392dso383056fac.1;
        Thu, 13 Feb 2025 21:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUK7nelLAZEC/BrTh7g7Ubdqo6PxtzT7SE0TQUjDzG5ona7/8nBqWwt+3o388+VxxTRwXNUBwv2308UOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCligQRa72WhDEPYQSznAU/yYn7wXFHfYTEfME2JG2khCiL28Y
	YUBFWXb7qehua/6AeJK1pvTkwGxYuVfKIfZUjwmYpp3iGMHccgRRF0PmwV7CYyszBdafJGzBrGl
	bZkox2SYCANbsPcQSpu4OGpfxL5A=
X-Google-Smtp-Source: AGHT+IFKtHl12gRyRy8GEfNzWvLPuYkAxv9JLwwND3g0cljwilOKO0hWHpBhFj/caMPidrnKD+ZXi8K1eQbEkkAEwZY=
X-Received: by 2002:a05:6870:d111:b0:29e:7d35:2319 with SMTP id
 586e51a60fabf-2b8d646fb53mr6119392fac.4.1739512040419; Thu, 13 Feb 2025
 21:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn> <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn> <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn> <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
 <CBA1218B-888D-4FB1-A5CF-7B0541B37AA0@m.fudan.edu.cn>
In-Reply-To: <CBA1218B-888D-4FB1-A5CF-7B0541B37AA0@m.fudan.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 14 Feb 2025 14:47:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8iNRT+Ff817QTrP-5BERiORx5DcwVzW8wJGbtupcxzKQ@mail.gmail.com>
X-Gm-Features: AWEUYZniF1xHrqwFj4JZP8HVIMupcrH7Y2r7JE6py5cxUCUr6UbXPY-37E5vqE4
Message-ID: <CAKYAXd8iNRT+Ff817QTrP-5BERiORx5DcwVzW8wJGbtupcxzKQ@mail.gmail.com>
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
To: Kun Hu <huk23@m.fudan.edu.cn>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 11:05=E2=80=AFAM Kun Hu <huk23@m.fudan.edu.cn> wrot=
e:
>
>
> > Can you check an attached patch ?
> >
> >
> Hi Namjae,
>
> I wanted to follow up as I haven=E2=80=99t yet seen the fix you provided,=
 titled =E2=80=9C0001-exfat-fix-infinite-loop.patch,=E2=80=9D in the kernel=
 tree. Could you kindly confirm if this resolves the issue we=E2=80=99ve be=
en discussing? Additionally, I would greatly appreciate it if you could sha=
re any updates regarding the resolution of this matter.
The patch for this issue is in the exFAT dev queue. Additionally, I am
waiting for a performance improvement patch from Yuezhang. I plan to
send a PR along with that patch.

Thanks.
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94
> Thanks=EF=BC=8C
> Kun Hu

