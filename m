Return-Path: <linux-fsdevel+bounces-24265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36793C7DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739DFB20F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AF19DF70;
	Thu, 25 Jul 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B895Yo0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8B19D8AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930215; cv=none; b=KSCDP5/G1VCSXgVP0ooLfEIY977q7vaY9Dm6DSpZ9VJv+MogWSqCj4lAN2bLxY5Z/SXcLXUcjuZgae3N5DFN0wwgzrtebTGEOh34auEbhrBqkt+FYfmB7x5MrUquS0Faq0Q+ppa5VBI/6JOtgCjMofSjjwvAHJ9qbbTnYUJVC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930215; c=relaxed/simple;
	bh=ENxVREbF97xLFXxmSCZZNz+Q8CxPPW3SYyY1WoYyWsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmMKP/JInPtDXYfBfUxqtQzxJF6A8Zt2k3xlCNtMqLJo2qYFyPgU1aBVKJqJo8Q2zvvPuMYhvC9CYgQqknyvz4F/ouKDmh9QkxXIIFivGW+vDEAgJhpykiL4KtsAdt8R1umT4T+SLvPhHeFGiw/oOveJLrxF4m++VnkSdGBce5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B895Yo0L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44d5f487556so5541781cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721930213; x=1722535013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENxVREbF97xLFXxmSCZZNz+Q8CxPPW3SYyY1WoYyWsI=;
        b=B895Yo0L02s7fjV8xSdIf9+rfJ20wiACILwLrQ48F2TMrX7ozpDYyv7TGzyDnaMRTe
         CR+DModZcCmamf0nh+DMZQsauTZJKMpLHCvln8jjI5BzKlfbd+1ulHz3uTey6OYxC6PK
         gyR39hH62tt1KXBWOgb/u+Ch+cRxhhz3n6R5kZUdsaeMA4WR5pH+RinyBuwWsQdh37RG
         iZ5JpQUX7XwRYjVNkaK2ZzPqfOoQXWazAgeZIcZcvbOv+4xqYaMn3lRYkmhXJ0N5XqrR
         aAWErGqP9f4irnELiiWItt/Rtw8hEhaqvCMkN76zC4Em0Q9455JtbrD6XXvTd6yglmwL
         BwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930213; x=1722535013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENxVREbF97xLFXxmSCZZNz+Q8CxPPW3SYyY1WoYyWsI=;
        b=lUdobkqvMDGnADVLYsfME3csX9LE/XHxuqi1KfLOLsapqKaSwJdDpMF79OS6nJXAqs
         2wexv0jN2v9hsh0D/23q6NErk/XJY6FlrU5Uoe7Huu3jWBcMKVEnwJ9GWyG56skP4vNT
         Vs/Vxp84vCGM/LD8LhesvV6ewC8BMaCfpg1Le4FYlpEmS8XzpgNqCQz/yZeJTpAaV2o7
         8Fi2S5+9ihmDb5j1N9YlSHu91rzDdP4em6WoGdmtvA7WhMI2DIdr9BfLbF6iGTGM/+Lr
         TbSnJHlLaekz8qgH/LUu5zsOWDX4Y4BoLt6Oj9uDkwJ8hqF0s8vkbek8v7rL7QX/WZA1
         jOzA==
X-Forwarded-Encrypted: i=1; AJvYcCWWyVLMF+Xms9/nMWOgRBDQBdbxCA+JyPIo2shNe+j7kjjGAquWi3fU2AtHitf0FX/OwRh/A3QLam1Nmpeb4yzbj5OfmQJUrWretGmF9Q==
X-Gm-Message-State: AOJu0YwkFgaQqsInY224F+e1JIOfEAafU4Km4jMJQEsb1iEbDoYVKAI7
	Dnu0qVMzORILRKaUTQUpJMQlvxrN0NxKNkK/V7MaRmJh695oV9JNeG35tpzmj4YCCdVoQwHDv4w
	/40+rI+hPtU5eIp0m5x+9ChakoDE=
X-Google-Smtp-Source: AGHT+IFWt6ZVoC0ar8eCL1hkoe1dOgFlehJYtiEAtKW9M6Wk4klLbkQhTHPqZPHNOrPjs75FxWouVSl5wnLkhEpbuPU=
X-Received: by 2002:a05:622a:1b8e:b0:447:f361:e2d7 with SMTP id
 d75a77b69052e-44fe923f3f4mr32481241cf.47.1721930212823; Thu, 25 Jul 2024
 10:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724071156.97188-1-laoar.shao@gmail.com> <20240724071156.97188-3-laoar.shao@gmail.com>
 <CAJnrk1a7pb3XoDWCAXV5131gbf_EzULtCaXKn-4-jnGaCrKxKQ@mail.gmail.com> <CALOAHbCt1Hcu+9O0xB-+jeTT2kDRPdvWD1sE86nDDo-pV9Qqzw@mail.gmail.com>
In-Reply-To: <CALOAHbCt1Hcu+9O0xB-+jeTT2kDRPdvWD1sE86nDDo-pV9Qqzw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jul 2024 10:56:42 -0700
Message-ID: <CAJnrk1YNu=FiYpFLJxM7VS+gkzSfOCzNcUCEoLi2qTuiv_YXeg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fuse: Enhance each fuse connection with timeout support
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 7:07=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Jul 25, 2024 at 1:09=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Wed, Jul 24, 2024 at 12:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > In our experience with fuse.hdfs, we encountered a challenge where, i=
f the
> > > HDFS server encounters an issue, the fuse.hdfs daemon=E2=80=94respons=
ible for
> > > sending requests to the HDFS server=E2=80=94can get stuck indefinitel=
y.
> > > Consequently, access to the fuse.hdfs directory becomes unresponsive.
> > > The current workaround involves manually aborting the fuse connection=
,
> > > which is unreliable in automatically addressing the abnormal connecti=
on
> > > issue. To alleviate this pain point, we have implemented a timeout
> > > mechanism that automatically handles such abnormal cases, thereby
> > > streamlining the process and enhancing reliability.
> > >
> > > The timeout value is configurable by the user, allowing them to tailo=
r it
> > > according to their specific workload requirements.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > Hi Yafang,
> >
> > There was a similar thread/conversation about timeouts started in this
> > link from last week
> > https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelk=
oong@gmail.com/#t
> >
>
> I am not currently subscribed to linux-fsdevel, so I missed your patch.
> Thanks for your information. I will test your patch.
>
> > The core idea is the same but also handles cleanup for requests that
> > time out, to avoid memory leaks in cases where the server never
> > replies to the request. For v2, I am going to add timeouts for
> > background requests as well.
>
> Please CC me if you send new versions.

Will do. I'll make sure you are cc-ed.

Thanks,
Joanne
>
> --
> Regards
> Yafang

