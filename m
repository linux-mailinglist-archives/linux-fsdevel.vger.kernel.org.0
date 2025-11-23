Return-Path: <linux-fsdevel+bounces-69572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D414BC7E574
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 19:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A954345A06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C092D9EC7;
	Sun, 23 Nov 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NsJT3s1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5C2D94B0
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763922271; cv=none; b=BcananpDmhUAwPN5V/1YTumSjw78Um+UM3ZmSU15qvc1sURI9qBmlDKOSRBr58w5S/+s0STRk1TU1B9mTluQAi1Z2Ozq+HhMGeoUaZr2qTPzHxOVpaJLG5AbjHRp/abRJC3+aD2sdpVYcfE+AHGQRd5wi0Lpu/+RlSDLlNGZ6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763922271; c=relaxed/simple;
	bh=zWrmp4jm1uS219v4VOV7zl6kilkCV46yS5P9NSn4tps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFewe9b0sfzwsnA2G/37pt7w0z7oJHDjOq26uVTr1uQiNqlmPtFc5cUHgKfQ7R+5tAy9vDSp55ZNDG9CEM3BuaCUNkAyj0VEbC/1zT6HNcQv4ODZ3nVrkXOun2ESTBDyHuRfpdoSG1jiPuiAneTzSu8LrhTcYh1zf/BWTAWltdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=NsJT3s1w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so5480524a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763922268; x=1764527068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFe56QyFLZ7C1O66/b75IN12Xd7/FCpS86VjcSFE1yk=;
        b=NsJT3s1wO1dTIojVGEIrqi3FRP9sl0k5hZOPspqSFJBDzQ+zafFLheO1FjzY3nWuiw
         m1I4FbWsxXNnk3UwWjsZn6DxvnoQHbg6Qk/VrhIVe+t65kB/MvyNaWw0tpiMf1qQPLEO
         6gIz6ARcslWBcS4UJcA1f/DM1vYANveeEPBVfDoQ8OuR339j0kWdiROrvW9oPMWb9xx8
         kjb1rIjELyeNtrjlEm6bguZM3Qgmcge0t1tyCV39oLqsFw0bxTc5WcGbrGyqyqizLFz3
         AJ3oC29jiaiQdOQQ4ZnKJXPyI3XfNbGq+oqAlU0H7Z+l033p1rJuEEafAezmbm2FiHSS
         03MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763922268; x=1764527068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFe56QyFLZ7C1O66/b75IN12Xd7/FCpS86VjcSFE1yk=;
        b=sCMZn7hOkKes8oxVo7QwzczGXTrmLg4mIEVL4LSHBTRTd73D+KgcTIpOP4E+rdJzhl
         idbCGKX3B4YWmgTK4FHZ6QQ2Gm5XlA3vq/zl8IyVs/4y08t/GxGXGVplF1I2XgH5O1yN
         HM1alGN2fJUmBwAWDZV6kWZK3jM8szMouq/AAc4ZHxbBxjHboqpuKjTHOLiDL5p7cRM8
         IIJTM4GorriLst7GwsZSaYlFI7sVddeDhVN6evHVBsFlnDqywCYPcBgLrljYyUiiERBK
         n73vBPS8wPaSYJV9ZpqUSKP8jjEEPb9NFa9t6mr9y4J8Yom2QkmOT3jDfhJXKwymRDR4
         B1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqVbaOkpDEH/XikdDoEnRidbVhvKl/ji7M1PRmsbvomiDDA6rGe6SSa2p1p9GkGMleKCBRuuOicTwizsR@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxD8+J1WjYsPg9//hKG/6KEy6FTFW8nwJtVlL5KKdzh+XfvTW
	+aN+sUQZehLByevZtwIh1vFsTDxIXV40lYm8omDd0RBSetSZtoVprgKccfMxeiPyLS9WCjIZQQs
	CzqYgWT1+JzsB+CSeZIxoQ2gvUB0nCPX9sVJ86DZHMw==
X-Gm-Gg: ASbGncuZDdq+9EMkGeONTjCAzV62V1lsHlBghqHTiZTUPSWti920kg8UCdXWSFFcFPU
	sCeGpMvqQL7UYBr0EUypeNmQmRt2ZaS/5b/hMaIaRXta5xUpwDh8HEp2QKNrzQ9/YTOt2zkyg20
	lJTJTcrJNE/DDUdgBqlJ+HDmv3rw8pZm9CL7RvYasEs9GWkXkiswYu+oBrQbSZhh0ebY3FLaH04
	bXF4RNZnxHooDVFdLCzwl8g1Oe8u5kWYyHIhRHP2yhDcEzCevps8aEE65YTKEgbD2xE
X-Google-Smtp-Source: AGHT+IF8Y2WxTfuU5MKgGu/HRLPR42VugdjCMxiGE2PPrS+V8RKZs1QDvf+5KSflk2e8n9lkLkfU7mQyoaO5u4Z1Zt0=
X-Received: by 2002:a05:6402:4146:b0:645:cdc7:ed91 with SMTP id
 4fb4d7f45d1cf-645cdc7f149mr424897a12.32.1763922267598; Sun, 23 Nov 2025
 10:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <aSLvo0uXLOaE2JW6@kernel.org>
 <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com> <aSMXUKMhroThYrlU@kernel.org>
In-Reply-To: <aSMXUKMhroThYrlU@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 13:23:51 -0500
X-Gm-Features: AWmQ_bmZE4Rym1x6vlKRuOiWr1iby3GXQ6wajNbHf1G86dfGYpyZynlDRpPIzZY
Message-ID: <CA+CK2bABbDYfu8r4xG3n30HY4cKFe74_RJP5nYJeOtAOOj+OUQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 9:17=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sun, Nov 23, 2025 at 07:03:19AM -0500, Pasha Tatashin wrote:
> > On Sun, Nov 23, 2025 at 6:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Sat, Nov 22, 2025 at 05:23:29PM -0500, Pasha Tatashin wrote:
> > > > Integrate the LUO with the KHO framework to enable passing LUO stat=
e
> > > > across a kexec reboot.
> > > >
> > > > This patch implements the lifecycle integration with KHO:
> > > >
> > > > 1. Incoming State: During early boot (`early_initcall`), LUO checks=
 if
> > > >    KHO is active. If so, it retrieves the "LUO" subtree, verifies t=
he
> > > >    "luo-v1" compatibility string, and reads the `liveupdate-number`=
 to
> > > >    track the update count.
> > > >
> > > > 2. Outgoing State: During late initialization (`late_initcall`), LU=
O
> > > >    allocates a new FDT for the next kernel, populates it with the b=
asic
> > > >    header (compatible string and incremented update number), and
> > > >    registers it with KHO (`kho_add_subtree`).
> > > >
> > > > 3. Finalization: The `liveupdate_reboot()` notifier is updated to i=
nvoke
> > > >    `kho_finalize()`. This ensures that all memory segments marked f=
or
> > > >    preservation are properly serialized before the kexec jump.
> > > >
> > > > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
> > > >
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  include/linux/kho/abi/luo.h      |  54 +++++++++++
> > > >  kernel/liveupdate/luo_core.c     | 154 +++++++++++++++++++++++++++=
+++-
> > > >  kernel/liveupdate/luo_internal.h |  22 +++++
> > > >  3 files changed, 229 insertions(+), 1 deletion(-)
> > > >  create mode 100644 include/linux/kho/abi/luo.h
> > > >  create mode 100644 kernel/liveupdate/luo_internal.h
> > > >
> > > > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/lu=
o.h
> > > > new file mode 100644
> > > > index 000000000000..8523b3ff82d1
> > > > --- /dev/null
> > > > +++ b/include/linux/kho/abi/luo.h
> > > > @@ -0,0 +1,54 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +/*
> > > > + * Copyright (c) 2025, Google LLC.
> > > > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > + */
> > > > +
> > > > +/**
> > > > + * DOC: Live Update Orchestrator ABI
> > > > + *
> > > > + * This header defines the stable Application Binary Interface use=
d by the
> > > > + * Live Update Orchestrator to pass state from a pre-update kernel=
 to a
> > > > + * post-update kernel. The ABI is built upon the Kexec HandOver fr=
amework
> > > > + * and uses a Flattened Device Tree to describe the preserved data=
.
> > > > + *
> > > > + * This interface is a contract. Any modification to the FDT struc=
ture, node
> > > > + * properties, compatible strings, or the layout of the `__packed`=
 serialization
> > > > + * structures defined here constitutes a breaking change. Such cha=
nges require
> > > > + * incrementing the version number in the relevant `_COMPATIBLE` s=
tring to
> > > > + * prevent a new kernel from misinterpreting data from an old kern=
el.
> > >
> > > From v6 thread:
> > >
> > > > > I'd add a sentence that stresses that ABI changes are possible as=
 long they
> > > > > include changes to the FDT version.
> > > > > This is indeed implied by the last paragraph, but I think it's wo=
rth
> > > > > spelling it explicitly.
> > > > >
> > > > > Another thing that I think this should mention is that compatibil=
ity is
> > > > > only guaranteed for the kernels that use the same ABI version.
> > > >
> > > > Sure, I will add both.
> > >
> > > Looks like it fell between the cracks :/
> >
> > Hm, when I was updating the patches, I included the first part, and
> > then re-read the content, and I think it covers all points:
> >
> > 1. Changes are possible
> > This interface is a contract. Any modification to the FDT structure, no=
de
> >  * properties, compatible strings, or the layout of the `__packed` seri=
alization
> >  * structures defined here constitutes a breaking change. Such changes =
require
> >  * incrementing the version number in the relevant `_COMPATIBLE` string
> >
> > So, change as long as you update versioning number
> >
> > 2. Breaking if version is different:
> > to prevent a new kernel from misinterpreting data from an old kernel.
> >
> > So, the next kernel can interpret only if the version is the same.
> >
> > Which point do you think is not covered?
>
> As I said, it's covered, but it's implied. I'd prefer these stated
> explicitly.

Added, thanks.

>
> > > > +static int __init liveupdate_early_init(void)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     err =3D luo_early_startup();
> > > > +     if (err) {
> > > > +             luo_global.enabled =3D false;
> > > > +             luo_restore_fail("The incoming tree failed to initial=
ize properly [%pe], disabling live update\n",
> > > > +                              ERR_PTR(err));
> > >
> > > What's wrong with a plain panic()?
> >
> > Jason suggested using the luo_restore_fail() function instead of
> > inserting panic() right in code somewhere in LUOv3 or earlier. It
> > helps avoid sprinkling panics in different places, and also in case if
> > we add the maintenance mode that we have discussed in LUOv6, we could
> > update this function as a place where that mode would be switched on.
>
> I'd agree if we were to have a bunch of panic()s sprinkled in the code.
> With a single one it's easier to parse panic() than lookup what
> luo_restore_fail() means.

The issue is that removing luo_restore_fail() removes the only
dependency on luo_internal.h in this patch. This would require me to
move the introduction of that header file to a later patch in the
series, which is difficult to handle via a simple fix-up.

Additionally, I still believe the abstraction is cleaner for future
extensibility (like the maintenance mode), even if it currently wraps
a single panic (which is actually a good thing, I have cleaned-up
things substantially to have  a single point  of panic since v2).
Therefore, it is my preference to keep it as is, unless a full series
is needed to be re-sent.

Pasha

