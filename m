Return-Path: <linux-fsdevel+bounces-43009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7EA4CEA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCB16FB61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4623816E;
	Mon,  3 Mar 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abkEn8sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E5217F29
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041840; cv=none; b=cMJ9vE7rztSicyKZgbZ9OADhkGJikSLLI7CqmfliMZT49gj81MS9IXVa3AwWo4/2rSHT2yMwEr5yQgk8KEFMchumF3EXmSRLDknjYZYHtFBe5RAhZ++8eqhf1DOY9jfJyP6sMAhXABXwhOV/KxFBZwT4OGSYm7s4PyPcAHQe0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041840; c=relaxed/simple;
	bh=cl1dM8kVDtiWOD8XJq+j2ArSIn//Ln/QcLEBW9sGHYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8TtnTXKWznPgwG08jCVoTk2v5mEnkZeLtUJPpLoP76r3V66mr0Ec8sln9uinMp8XM+/SJNMclWkWQyNDPF3Vbs7ifFoUVoQoEli/hsB2eViksUi70Dck9b+dwZaeQAXOOQyIexMtvWN3F/F5gAw0VPiVXGc2zYRMX8Ws5PuxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abkEn8sp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47201625705so58096121cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741041838; x=1741646638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl1dM8kVDtiWOD8XJq+j2ArSIn//Ln/QcLEBW9sGHYA=;
        b=abkEn8spamvGfr8nG/CvEO6hwdTpICrFfoMV0Gzkgu1Nmm2Zf0kTCkUaHzcgzWWBdY
         6AXwjlVsNNzXNshy5EboYVWO+fdfC7gpkGDqsn4/TOsh/wmT9qmm9IPc6aL550kF5SpG
         g/kiLs8WhROK4SEgkgoMZSbPN71wQs2Rt4JkwAZEUqNQt460JKwCKyt4mgZ3PN9b2lN3
         CgOkl0TZavadvQjoSSmz7FuIiYbmBql3ZGnUQuh4GjzqyoRei/1WQgFw9xc+Lfqub6L4
         CxJ9JOrr38VvFx/mE64meTAsjEHOc58QbpNY/r7HRk8h5gtM8++vmzCKSuAVlCv8WiXV
         UCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041838; x=1741646638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl1dM8kVDtiWOD8XJq+j2ArSIn//Ln/QcLEBW9sGHYA=;
        b=jS+xdKYijbwGssgeH4JSej6eD07jffc2Rquex4ECB8y7ZS7zCTQI55ZPPXxgb5eBPf
         XFXmGQbGrtkAnFJbp0gesGE2BCTkKPyoz4d+DU4BLsCzF5lsXbroTStSmrcQvSVof0RK
         I6h18Tlxp6U185Y+5vPk254RX6L8T+akvPD8bhSH0Wv0ji9RWF+jASQp/wPbLKImG6ih
         0aQgqzzYQJ7gjV30l+7dM9bJzwtX0D0bRVvl/uSWac8SSfZ2dL0NKadv6DucxRyVPsuU
         nAD4Y4WSESeGzFJrFetoV7Z5etNObYu1UfN8KjJrj5P7RBFNSkYTpjVDvonlASAUzNXV
         72Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXoNvXp2gN8ml3wZQiWj5ms7rWR7G7Czzf9ywuvtJXgdp5ojWgXBhy3wXseLRL1L11f6XKAI+MoTR0Zs0e8@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr3u7W0B2P1vFgdExOJHq4KehOvvdfZmyOQQiCRtH3tFqXEeT
	wsKftIGGcDreVH01fw3BQnFngvmekI9C9LQFbyRvJd06j6vJDgDbdip7+3LTWhfN33RAA+MXO3H
	dWM4KMmOtftoI15p8YNZ1wYLd/+4=
X-Gm-Gg: ASbGncv0FjnEYbkW+ug1Rz/mp6Nh+TXOVsTYH0+JCGTTR3eQ3RIlfLcvY5bG92w4PXB
	nrXhgfNHPLmvmyrLnJnIMf/QjglZ+4a6VxLHZVHGUiy1N4TbY1SnD4VrULNz1ZZ+Rtu/BDgSAdj
	as6X+mMDDQVlQLZi4aJF5/nu6wSJE=
X-Google-Smtp-Source: AGHT+IFrjDNbdoj9UBQDR95rV/iIFxTQ42imdcTYOv7lPCfYwIjHEoTbsGD/zzp1JpullP1m6EIBmCJM5n3dQicTEV4=
X-Received: by 2002:a05:622a:24f:b0:474:fa6b:c402 with SMTP id
 d75a77b69052e-474fbd3debemr15189051cf.18.1741041838177; Mon, 03 Mar 2025
 14:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s>
 <CAJnrk1YnKH2Dh2eSHXd7G64h++Z0PnHW0GFb=C60qN8N1=k+aQ@mail.gmail.com> <CAJfpegsKpHgyKMMjuzm=sQ0sAj+Fg1ZLvvqMTuVWWVvKEOXiFQ@mail.gmail.com>
In-Reply-To: <CAJfpegsKpHgyKMMjuzm=sQ0sAj+Fg1ZLvvqMTuVWWVvKEOXiFQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Mar 2025 14:43:47 -0800
X-Gm-Features: AQ5f1JqIFhS6c0vuV2fj6f-4uOmzqUa4QE_0OAnovt9vvJXiKeTUHqHqs14WHn4
Message-ID: <CAJnrk1YoA2QcuxvTdW=2P3ZRHGhWOYMOfXC=+i5fOY-71mBO6g@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 3:39=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 25 Feb 2025 at 18:35, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > but I no longer see these commits in his tree anymore.
> >
> > Miklos, why were these patches taken out?
>
> Sorry, forgot to re-apply with the io-uring interaction fixed.
>
> Done now.

Hi Miklos,

Will the 2nd patch ("fuse: add default_request_timeout and
max_request_timeout sysctls") also be re-applied? I'm only seeing the
1st patch (" fuse: add kernel-enforced timeout option for requests")
in the for-next tree right now.

Thanks,
Joanne

>
> Thanks,
> Miklos

