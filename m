Return-Path: <linux-fsdevel+bounces-64343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC55BE1AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4CC4F25CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D92517AC;
	Thu, 16 Oct 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWhToT3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C87216E1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595345; cv=none; b=iQnQoawjIApHpotNp3aOhmViHAhNQFfbNZUoduyOsKLvZ6fCvC1PGcRS/cTqAAFGlkcOHKf+PuMhv5W5hloPJeB+w+ze1tvA7vo78PQv4LWBkqpI5g69AZzq360gzv0csE4ifV4cfxdG4wjm4xNLcGrNZJ38wstf6h7Ihcrg1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595345; c=relaxed/simple;
	bh=qvHKsu2Wn9QaegWJlaBTol4VzJlrpKP0CKxhIuatfZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBqPPz743eVB0WjSv1nIQ1DsdKf6RIGOeoqu4gONnAGf9S4HlcpyELLU+FOkTXEoW1fB785VPDcs03f2WdVnMfrWLpv2/8619pL+mctCOElYlL0vz7n0K5JF/gmh24fq9vPjX5ASFAkGopjLXqEmXHgGtvqvH815VRY5hjMfdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWhToT3u; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e9d633b78so80418266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760595342; x=1761200142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fypkWTO5Lz4C51u/Yk4/3klrUflGikVlCQkqBAFvj0=;
        b=cWhToT3uHCVick4Mk+c7oz+04IbsnWUczVI2cxpWdcuRBqQDjYV6Q+IcGCgces6Fj4
         IKp10aRNIjpg65niBWhvC8BTSw0V52Ucae0vSwjkiEmhDwnM0YsYiwp9O/2tvS3ocgbi
         0b992LoSgdv2iqg11khuDpWx+mzk2qVZkwxTiur74jvg7NBNwL66tM6fHMfitgXwdHIV
         cG8a5NyXcKGdr/055GvVmsODhxLpoDU17zS3+Id2dBc/AoLMGlMgNlbNXUAyz4E4YyXQ
         inAfDEi9+Hg01FZ+bfojb939uRQ5pNNBk3X08+X9S/Ng6bhnWbGNCSCsdNDdYanAhAqP
         AgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595342; x=1761200142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fypkWTO5Lz4C51u/Yk4/3klrUflGikVlCQkqBAFvj0=;
        b=rzCpEhUFzCnEZux8ZUvDlPQfAe2+ddGRh6CCy35TJyEa5VvUqxea+S4IwPieO7c8hQ
         9beCilAOsSICf57j/5xtvkZvoEiAmC1Jyy7rbCtM1d7OoxhvOMI+WWq3xp1hPn93h/Yl
         L2opyhQ7v37ZF7Y1LHeBUXgYIHdkAGjgT+IOK5Ytu6YbtG0aWSqH0FsvNT6lBMk2WDt0
         1xG2DZvHmEFuuf/gK86T+5uM57UwyYuyB9VEjtQZfJ8XLwAhIBQwGqLf/uzOATEIWc6Q
         LTMxfK5BULO4Aj7xzd4SlpJ6xMuJvk7kC40psYzxXB3JT7p7Et9lfv2/gB0ZXsLIgekR
         wYWw==
X-Forwarded-Encrypted: i=1; AJvYcCVgjCJHqXdnVOm6mpbLCZwBfVLZX8h6QyTpDRyclx7nVEtAcGymjeZs75fDg58d8LmmoPuKNibGuGCVIJW1@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8iC6xKP0rpqjx5z4dIaeXkXwY23ZWeLWyljN/2hKHUPOZG5y
	VkTPFJ7tKP2x559PsiGwHPzh/VKtN5JeuTtk2Vn3TJ6thy4AlvzNZijbLS4Eh3FNSsTJZ4AmK7f
	hxjtplTvNMAnC15xQxrpGT0U7mT2Z67g=
X-Gm-Gg: ASbGncukme3Q8xHBmz3ltUdscR+AfLw28gNiZVbFM8tBQyr7rLT2UUdA6UhWzT9QO4x
	Evdbte1YZuzfRLQqdWOQKjYkncMvrkXwmJ1cOOti3JyUmdM6kVZvXZmMBSdghUDQN9JiRTJpZWm
	o73cmeWXJlU/hHFKcPuJ3Aw3C1mdxEiGgBNAv0/AHcrr26BZUto0o2NEnjjABBuMOzy5kgbwApL
	vDG3qoOt4inPWVzptxsI85BC30qau4Y+WyVASymjoXIHQj899iG7r0zRA==
X-Google-Smtp-Source: AGHT+IH+F+c/ge8EFdOH7qBvt5fP3ZDqPZS5PKiXqqo+Ifez3It8e/Q6IYv1tvUsKhgci1L4dFo5Aa+88kjDwLI8Xl8=
X-Received: by 2002:a17:907:9613:b0:b46:7e8c:c0e3 with SMTP id
 a640c23a62f3a-b605342c475mr314121366b.20.1760595342425; Wed, 15 Oct 2025
 23:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <CAGmFzSdgfjfdAGNrzb224+t5+UPvUWz3t7iCuW7CvSxd199KdA@mail.gmail.com> <598fbf05-884f-4901-89b8-41e2e6f00154@ddn.com>
In-Reply-To: <598fbf05-884f-4901-89b8-41e2e6f00154@ddn.com>
From: Gang He <dchg2000@gmail.com>
Date: Thu, 16 Oct 2025 14:15:30 +0800
X-Gm-Features: AS18NWCfdzEma-zouwspwV-cRQqBbKxGP_Plrwf7a-cIPV1k0_H_O7bwzDdNoRc
Message-ID: <CAGmFzScCdpvgDNKq4BZ_YsBnFjGYvuSmm0XMUD-FY-oQ93qW9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

The test case is as below,
First, I created a null file system, e.g.
cd libfuse/build/example/
./null -o io_uring -o io_uring_q_depth=3D32 /mnt/singfile

Then, run fio commands with the different iodepth value.
the fio commands are as below,
fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D4
--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
-name=3Dtest_fuse2
(the patches can help this case)
fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D1
--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
-name=3Dtest_fuse1
(but the patches will have a regression problem for this case,
maybe we cannot handle both cases with the same code)

Thanks
Gang

Bernd Schubert <bschubert@ddn.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/14/25 10:43, Gang He wrote:
> > [You don't often get email from dchg2000@gmail.com. Learn why this is i=
mportant at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Bernd,
> >
> > Thank for your optimization patches.
> > I applied these patches, for asynchronous IO(iodepth > 1), it looks
> > the patches can improve the performance as expected.
> > But, for synchronous IO(iodepth =3D1), it looks there is  a regression
> > problem here(performance drop).
> > Did you check the above regression issue?
>
> Hi Gang,
>
> please see patch 6/6, it has numbers with iodepth=3D1 - I don't see a
> regression. Also, I don't think '--ioengine=3Dio_uring --iodepth=3D4'
> results in synchronous IO, but for synchronous IOs you need
> '--ioengine=3Dpsync'.
>
> For truly synchronous IOs you need
> https://lore.kernel.org/all/20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.=
com/
>
>
> Could you please provide the exact fio command you are using, so that I
> can give it a quick test?
>
> Thanks,
> Bernd

