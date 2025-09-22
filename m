Return-Path: <linux-fsdevel+bounces-62413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CDB91D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232333B5114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DCA2DC794;
	Mon, 22 Sep 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BN15DxHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC082D6E7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553257; cv=none; b=FAvWBm+Jdgf6Rp8JVF/WY690rzvvGdLNA844t/Z4I7NSuCXPqLNmx9f3RLxOTP4p0+r735dbDJV4lwEnAjfOHaoyCGG95mDr0Hu/oR5J8gFxbG34gipJSTgXrbik7itEhIYZJHesYAlFLXw9v9ow62D8eCoQqGyXWLpd0yUGc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553257; c=relaxed/simple;
	bh=kh9XvYd3EybefvfxgcE5HYVIHxtLjRtv+CBZJd9A8sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVM1Hmit82T/8hm15JkhM4GVe8HOKzIlwn8lYJIVB5g48lkpOxYgHQuFYbdYin7tKAdqYg9pdelaXqOkrsbE0CcDGyviDP7l42BgRiEfFoGDC7/7I2NONozcC02IR5AidQSUB6q7GEhp2gACP0EkbJVOuEnAIoKq2hdgzfHFKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BN15DxHz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b5f7fe502dso24250711cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758553255; x=1759158055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f6Q5jc1vTYxMw5O1/g4HFLF7Ms2PoeIAA4LcbVkCRg=;
        b=BN15DxHzbcgH3jO2lx3ZL1eCb8snynPgNtQx8dzHAO+PLekKUG+Q9KEOCCMnFiDQYh
         N5mwqMCoE62l0XZqEqyjVLe3ngKNivgB84tVGyp4fxKVCEiTww47ujjzS2q6VxJWbVZJ
         YrC0HYW87Gc+GIuUIh7xPkARpETh08/IWzeEse4gI+r+x4561Q8TcRsF4srRMnZz6F4F
         PsBvAJCv1mhNof7LM0wRErHT10VivDHJRtkdioWQGQenI0/dZnuUqBU9G+6AQveQhhvN
         7sM0g4g+36M2useltsF9iAE8CD5yA/1jojShv84pTeMnD6qW1cjt5pG1a2fzFUNnoePT
         +b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553255; x=1759158055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f6Q5jc1vTYxMw5O1/g4HFLF7Ms2PoeIAA4LcbVkCRg=;
        b=pA+pv3wXUG2LOb6iLx35pIbXMjysOmOFZpJPsT/tQv3GH3GXTUfEEd8A4ptptDjd0z
         G4hYKTrYY3UqCcazUZjVr38Yx6yKJ1K0trxIegpd6CFP9qdSOSRlErLkOLqCMUIvOdOO
         SWkpVH625ec9w2O3SIq8NsKgwawTgVLZP0g5D+NgJI5xoxBittbCpShEI+VvWju/7dM9
         4POgTB+k6gPtYHD5PkB+w6RS1SQKX4nwDcObRooef7xwVIVZ9In67S9/lam8hR3gP7U/
         TprfRSe1aGd+Xt/S6nmaq2T/ETabYUKTz0Sxx7GgHfdH/FHxSqgwLfrWgVS43E6EusSw
         GnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvkxCygYzC7WLroQx4q/M39WaU3HuPju79UbpneHtlCK9930xDRoAFR8sOLebrqPC4UPxUfHg6qgM7MGkE@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEmtM5CQD2KEQEWg/xSg1VOc3EVo9KtJA6lX8IDNB8ZEgOdiy
	uQLjrFBHaj1DeIO8PUdc3yTU9a2K5CO2gsxdXKFqGNP1AdGOj3Fq4U2Wh27LYYTTyHgqkJN9VYc
	CRvd4Si+h5CjweTR8jKGlREtPVXYFDwSxpHMlGK02Gg==
X-Gm-Gg: ASbGncsks1eHM1saU6NLO+RdXLxKuW1GW1ssQCALECtgrCBzkZQ3PBWSIhg982ls83x
	5uycjRfS64smQyIGNkQk5IxfPEgpF/NvJb9YXPxe28/fJRRSOFXGFz6CApwUisg8E74Skhig3SP
	Edf72DffSHiKnaHtjplwR6BE5Yh6v27NVXDvjm4ntfnc3rSSESyGXNMtDL2d3JXET+oyFiDULh5
	Slwg0MO/g65zEc=
X-Google-Smtp-Source: AGHT+IFODvetLMEI4TglsorFs5/g17pXRnsZ1YySfP9UyB8TJrkLIBj/0y5AS2xiVpb0YAgRS6Chp+Ecl7/RH4sOKKQ=
X-Received: by 2002:a05:622a:19a7:b0:4b5:781c:8831 with SMTP id
 d75a77b69052e-4c07482541fmr145941741cf.71.1758553254248; Mon, 22 Sep 2025
 08:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-11-pasha.tatashin@soleen.com> <20250814133151.GD802098@nvidia.com>
In-Reply-To: <20250814133151.GD802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 11:00:17 -0400
X-Gm-Features: AS18NWDWvCmwoZ0UUnsayOxFgu1ddJVOr-n1U4qHAgmRCSllAUpUXvWhJbPgaAE
Message-ID: <CA+CK2bALMGy8eYpYdsQSJXsCWrusKA0UJfBfv1fbfW-=tYds7g@mail.gmail.com>
Subject: Re: [PATCH v3 10/30] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:32=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:16AM +0000, Pasha Tatashin wrote:
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -383,6 +383,8 @@ Code  Seq#    Include File                         =
                    Comments
> >  0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                               =
 Marvell CN10K DPI driver
> >  0xB8  all    uapi/linux/mshv.h                                        =
 Microsoft Hyper-V /dev/mshv driver
> >                                                                        =
 <mailto:linux-hyperv@vger.kernel.org>
> > +0xBA  all    uapi/linux/liveupdate.h                                  =
 Pasha Tatashin
> > +                                                                      =
 <mailto:pasha.tatashin@soleen.com>
>
> Let's not be greedy ;) Just take 00-0F for the moment

Done.

Pasha

>
> Jason

