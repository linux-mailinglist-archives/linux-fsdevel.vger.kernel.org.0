Return-Path: <linux-fsdevel+bounces-55838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9DB0F58B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BE1174E98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E82F4317;
	Wed, 23 Jul 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EzZ3d4Sz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3451804A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281605; cv=none; b=PS4OH0PVylFP2xip85zJRaUZh8GhgQQpdFxBezF7O3csiwqzv2vUpxV2TWvl5ENZZPijM5g9Y3mgnSX25njY2wI6mY14mb6YGR7hya4us4cmNBsZl8Y8vtTsYm/RZgPYNiIEpLsXH/son74WWURhfMA8HfchE3KVBkX6miWwLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281605; c=relaxed/simple;
	bh=0z+SXJ5yfQB6L25otv7+RIp45kETMhhVSzDBfbQ+6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzhZYAItHwRfLDyXzoGZBweVAmj4zANVv7J+9AcAg0iclsoEVeDX2G1AMvtyTE29MRQFmRHSd8PwkuoiLA7nybxQWzfbHY2BM31QPqAS4dw39vxggp+5hK4p1oHYgj9wx+98lz6JJpDrdtDJ2nCd7OstD9Fbbwjy6vqqxzusACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EzZ3d4Sz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4abc006bcadso54741881cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753281602; x=1753886402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=EzZ3d4Sz/vwV3U5tX+CTieQkSi4yK/S1vksOJZ+mVHaWM45wXvxcHhJ8IMPPAZPR6M
         6BvdvOaOkbhd9PH36BRwNNA02wAkGgOAFdxuGL/rVlIUER1uOLkvjY/Pewe2+V0I/ikx
         5cmo4BgNBBw8c1K1n4eqlmsqlUOCgDz9di8rCDD01pAleJC3EFFTtcHDvqJJBlNLF7vw
         a+f3jKod1vnGB+d7iVGoiEUZhvdUbAzIZBwiqvna5n7P64TJc9ql2jNyQgVpGEjx9uKH
         3fo5S8WE/1N9bQQYYx+lCReYZ1UKsT4WB3iRNuk/PXXPz4AOatJY+Nf9tI/f00hza+uW
         5znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281602; x=1753886402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=Lj9ECs1Gu/EPG4DlocDIP2j6MkWjQEdPRJm95aQEOhUl56qKZAfITnxEetUfQj7Nty
         cCucJt9/DZq376gonF/UEBl5SqS4l53wn3CF1wwUGcDGItqct4oJBjh/F1tmZuxwear7
         xkywxW+PDBrVFc2KP6DiatX0/JE0hTm/xKsKYVpVnAVz8BOkvvkdCkG5ufwR5okarmOz
         KXQiZybzKrPPtgOD9L7Ov4dPLHrae75nfx8yth6KfcQF136DtM2XTsrslh15/pTOhv4v
         P2+ILO2eR/1YO+uty87/Bs2Gnr0DwwLbFBCF1FbXq+fQvjDRRXpgkxswSPYsIjCzau3C
         HyXg==
X-Forwarded-Encrypted: i=1; AJvYcCVpFUQirbVWEys1EKnT7n5GsyypU9gde472NNNhgWxW6lnEZm9pIkOwGZmHcTHRPDlvqr3GkiLo1DUTZScv@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6X9mO93p87w1gRg77sJFDQcxRNTalYjsFw6iWiFOmTGH7NB9
	NCdcCrXhtatmcOTWKZ/TAQsSmv0stQK5bveoLjw085oOicYeG2VtknownXYMztEgXwcHDaqcwTL
	UMLVZsSrg3mPDT43FUfctA+u1cDaliVnafLhtVFI63w==
X-Gm-Gg: ASbGnctM543qumKwc2nhk6fNyBfeZ7Ey7KR3wmlVUkOpR7NEdBEXxlSPu+NybX6d5Ls
	QfSH9SYe9x0LqXlcdV5+WoQZ83B9mUwQq3SHLxgv9tVkKUGObAGHzAV0Hvqi9xs/OupnEM8tZyW
	4Vrla11pxtko7SymbcBawVYEgWo5oJusmvIBrJ/0y3M+DWhP34y1M6+r1i19dAClUiVvhrSnMED
	3uW
X-Google-Smtp-Source: AGHT+IHFS+sl5UqmRZOH4YC8rrY1lTn2lhJNlt9MYCWZB3088lrRvjxl69LEe5to8g07iNSRAqNDE0qYJCcj4SAzgKY=
X-Received: by 2002:ac8:5d14:0:b0:4ab:41a7:852 with SMTP id
 d75a77b69052e-4ae6df7e0f7mr46630481cf.26.1753281602021; Wed, 23 Jul 2025
 07:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-4-pasha.tatashin@soleen.com> <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
In-Reply-To: <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 14:39:25 +0000
X-Gm-Features: Ac12FXw5a0SPc2DZ1qffEKM0_QNNJkpaMIdscCC70ESios9nqZeZ3FVsbikeuDw
Message-ID: <CA+CK2bCChNVmGXPN52La1zECBBSRf5SffHFEHwMcJCDaqA+YUQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/32] kho: warn if KHO is disabled due to an error
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:57=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:17 PM, Pasha Tatashin wrote:
> > During boot scratch area is allocated based on command line
> > parameters or auto calculated. However, scratch area may fail
> > to allocate, and in that case KHO is disabled. Currently,
> > no warning is printed that KHO is disabled, which makes it
> > confusing for the end user to figure out why KHO is not
> > available. Add the missing warning message.
>
> Are users even going to know what "KHO" means in the warning message?

Changed warning to: Failed to reserve scratch area, disabling kexec handove=
r

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_handover.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 1ff6b242f98c..069d5890841c 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
> >  err_free_scratch_desc:
> >       memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch)=
);
> >  err_disable_kho:
> > +     pr_warn("Failed to reserve scratch area, disabling KHO\n");
> >       kho_enable =3D false;
> >  }
> >
>
> --
> ~Randy
>

