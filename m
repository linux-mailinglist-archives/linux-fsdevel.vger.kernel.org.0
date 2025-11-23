Return-Path: <linux-fsdevel+bounces-69509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D7C7E0D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2858A4E3753
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875F13B7A3;
	Sun, 23 Nov 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fe7vA7jG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7472773C1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763899441; cv=none; b=kOIbYb6VMehBtyRej2w4zAI2K0cLyhRh0Xr+YXeBQjjfZB5g4LcBsKftc1xJtNuHXBU1W8dxvrA6FdjRPEvl3hABgrFcRxw+FHGb/ERIFUlmmiVK81XC+Ak3HDDrH1XOvRMUfhIy5QoC9yzOiOFy4iNvKa08aQ0xM6PxekEcfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763899441; c=relaxed/simple;
	bh=oYtIosH0dW5hqrHgNrJe5OOHl1tev8dHqkLMKGUb38c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKI59emmN06qVnH0uS6L4O5VDC+XHwIq2Mzf34IlfkB4dXFg0C+dFp+MqhMWLxMnFyHdd5HpfztUM930nuv8EAQZ0Ge0Cg8o3OUQAppyxXGVYnLvKeHI+70DXQMBAeZHDpHEy8fuIUgzIphPtwKx4iqi0TbckajaKbrFguIKwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fe7vA7jG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so4815199a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 04:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763899437; x=1764504237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ6437ATus0ug/QEfcQ75ODju9BI6cshDa1KKSODRwE=;
        b=fe7vA7jGu1Bc25+wXVAyjp5nzeAv/sLq4ifVUJ2FJ3nR1E57vusPwUPHFnys2WxIum
         EtfIpcZOqvC31IlDfmRqkdJ2dIXwvZne+tWUVKdfM7j4JQ+UxpsAjDp7X9aGfI9Qbvc+
         Yj1sX8yQEKmcII0jLOlMDgHiUUSGwlqzyTRSq7y/akS7dl5+ktR7O4FhHadXAspQDNCk
         uCRYBtl2ygcc7LiApA/whb5Ms2aS0UKSoVOzpzyVK7Z8Bltojw0Dkl1+Au2LZ4A8ft+b
         /RvwzKZJkqXQQXyGX3Y+yO1ukLU1KBD5qvRW1jJSmHAgmLzelsGWrRVVQi/PxbYLiwKo
         TbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763899437; x=1764504237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ6437ATus0ug/QEfcQ75ODju9BI6cshDa1KKSODRwE=;
        b=UrQZRnNg7udHmKWj2TR+Rd8dZxQlYbRfuS6O2AIQ0C9mHmK8qPP+WdkBXxzrtWpjmJ
         If54Pr87Uo7HTPx6aO2gyKC9+A8i9OPO7qfzg/9hdkVy7td1HQww2N/NWDhUthmOd/Kf
         lgibqdaFbL3vs0C8GcP2C3ojPRCMGsSNtFOW958+aVqtHCy7my6xYeMSrXmBYCTghEFq
         ik5TACORwfQ3TTvBpwLQKInrSTpAB41b8jO/AKGWFw2XeKUILn6zmS4NXZ3VFTgddO1v
         UJYOFecCRSJQ1WVzqhdM2m9CvwimgUNTUlG5rS63Ee6kePcP4hvq3EZ0/n7WKEZoQ38Q
         Xf4w==
X-Forwarded-Encrypted: i=1; AJvYcCULG6QwWa6kXb82Df1xVR1K/A+PKOQMHBzPdygPS5PZRUOOdblmtFuUXMDB0mzTfHBX6Da3IVwfgYPLY+Ji@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvsJTyas2ynI8eURZgZkEm2pai7IqvnDb1A4g+/usu6TXgGHr
	aB8jKy7Acv4ZChRrTzhUXS/OUgTu0svmIM9V1zOagy7XQNsKDTarDTQMvHUQG5bDyH6HJXLHDoj
	Vhdz+fkkcGcV5vjkC5s0YpJgbjPACxREceOsVfeyRPA==
X-Gm-Gg: ASbGnctyq8cjGEg2WseMsjRtJEhmvzEI4OL9nGBVjn9VOeGE5J/sfx4U1F+wZsFe1Uz
	UpGk8057/RL/jZD1Mw6c1taAa/dFBw1kgZ1Ty8cPxCoHS1QMttcKscDX5Fsg0T2VrracSd3Ul9w
	RwA3g/Bg8uEi02HD5OaT3y1wYPa3QB7fY4xUyoex0tnah6iczELVK25ujE8t8Ems+wMatz+Vziz
	pMkOmJAjhY7FhO+2fBMOvd/qw961WxexZocsRJsg01u7p4sGkuDuwzkCLSJeScBzvus
X-Google-Smtp-Source: AGHT+IHY4DpDIVQj3DszXOkjPRhgk1igiuds0AT/lVzEITdo2CXMJTFn5D87cQjW3K+5NSqSzXFewu7L010slYHUxPQ=
X-Received: by 2002:a05:6402:1ed2:b0:640:80cc:f08e with SMTP id
 4fb4d7f45d1cf-645546926damr7284637a12.26.1763899435959; Sun, 23 Nov 2025
 04:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com> <aSLvo0uXLOaE2JW6@kernel.org>
In-Reply-To: <aSLvo0uXLOaE2JW6@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 07:03:19 -0500
X-Gm-Features: AWmQ_blpSM5U1pU28FozBhcwrN7bmkenjnD3bgD84GHtMLQK1GWO_h-EYfP_LEg
Message-ID: <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>
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

On Sun, Nov 23, 2025 at 6:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:29PM -0500, Pasha Tatashin wrote:
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > This patch implements the lifecycle integration with KHO:
> >
> > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> >    track the update count.
> >
> > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> >    allocates a new FDT for the next kernel, populates it with the basic
> >    header (compatible string and incremented update number), and
> >    registers it with KHO (`kho_add_subtree`).
> >
> > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invok=
e
> >    `kho_finalize()`. This ensures that all memory segments marked for
> >    preservation are properly serialized before the kexec jump.
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h      |  54 +++++++++++
> >  kernel/liveupdate/luo_core.c     | 154 ++++++++++++++++++++++++++++++-
> >  kernel/liveupdate/luo_internal.h |  22 +++++
> >  3 files changed, 229 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/kho/abi/luo.h
> >  create mode 100644 kernel/liveupdate/luo_internal.h
> >
> > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> > new file mode 100644
> > index 000000000000..8523b3ff82d1
> > --- /dev/null
> > +++ b/include/linux/kho/abi/luo.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +/**
> > + * DOC: Live Update Orchestrator ABI
> > + *
> > + * This header defines the stable Application Binary Interface used by=
 the
> > + * Live Update Orchestrator to pass state from a pre-update kernel to =
a
> > + * post-update kernel. The ABI is built upon the Kexec HandOver framew=
ork
> > + * and uses a Flattened Device Tree to describe the preserved data.
> > + *
> > + * This interface is a contract. Any modification to the FDT structure=
, node
> > + * properties, compatible strings, or the layout of the `__packed` ser=
ialization
> > + * structures defined here constitutes a breaking change. Such changes=
 require
> > + * incrementing the version number in the relevant `_COMPATIBLE` strin=
g to
> > + * prevent a new kernel from misinterpreting data from an old kernel.
>
> From v6 thread:
>
> > > I'd add a sentence that stresses that ABI changes are possible as lon=
g they
> > > include changes to the FDT version.
> > > This is indeed implied by the last paragraph, but I think it's worth
> > > spelling it explicitly.
> > >
> > > Another thing that I think this should mention is that compatibility =
is
> > > only guaranteed for the kernels that use the same ABI version.
> >
> > Sure, I will add both.
>
> Looks like it fell between the cracks :/

Hm, when I was updating the patches, I included the first part, and
then re-read the content, and I think it covers all points:

1. Changes are possible
This interface is a contract. Any modification to the FDT structure, node
 * properties, compatible strings, or the layout of the `__packed` serializ=
ation
 * structures defined here constitutes a breaking change. Such changes requ=
ire
 * incrementing the version number in the relevant `_COMPATIBLE` string

So, change as long as you update versioning number

2. Breaking if version is different:
to prevent a new kernel from misinterpreting data from an old kernel.

So, the next kernel can interpret only if the version is the same.

Which point do you think is not covered?

>
> > +static int __init liveupdate_early_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D luo_early_startup();
> > +     if (err) {
> > +             luo_global.enabled =3D false;
> > +             luo_restore_fail("The incoming tree failed to initialize =
properly [%pe], disabling live update\n",
> > +                              ERR_PTR(err));
>
> What's wrong with a plain panic()?

Jason suggested using the luo_restore_fail() function instead of
inserting panic() right in code somewhere in LUOv3 or earlier. It
helps avoid sprinkling panics in different places, and also in case if
we add the maintenance mode that we have discussed in LUOv6, we could
update this function as a place where that mode would be switched on.

> > +     }
> > +
> > +     return err;
> > +}
> > +early_initcall(liveupdate_early_init);
> > +
>
> ...
>
> >  int liveupdate_reboot(void)
> >  {
> > -     return 0;
> > +     int err;
> > +
> > +     if (!liveupdate_enabled())
> > +             return 0;
> > +
> > +     err =3D kho_finalize();
> > +     if (err) {
> > +             pr_err("kho_finalize failed %d\n", err);
>
> Nit: why not %pe?

I believe, before my last clean-up of KHO it could return FDT error in
addition to standard errno; but anyways, this code is going to be
removed soon with stateless KHO, keeping err instead of %pe is fine (I
can change this if I update this patch).

> > +             /*
> > +              * kho_finalize() may return libfdt errors, to aboid pass=
ing to
> > +              * userspace unknown errors, change this to EAGAIN.
> > +              */
> > +             err =3D -EAGAIN;
> > +     }
> > +
> > +     return err;
> >  }
> >
> >  /**
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > new file mode 100644
> > index 000000000000..8612687b2000
> > --- /dev/null
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +#ifndef _LINUX_LUO_INTERNAL_H
> > +#define _LINUX_LUO_INTERNAL_H
> > +
> > +#include <linux/liveupdate.h>
> > +
> > +/*
> > + * Handles a deserialization failure: devices and memory is in unpredi=
ctable
> > + * state.
> > + *
> > + * Continuing the boot process after a failure is dangerous because it=
 could
> > + * lead to leaks of private data.
> > + */
> > +#define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
>
> Let's add this when we have more than a single callsite.
> Just use panic() in liveupdate_early_init() and add the comment there.

https://lore.kernel.org/all/CA+CK2bBEX6C6v63DrK-Fx2sE7fvLTZM=3DHX0y_j4aVDYc=
frCXOg@mail.gmail.com/

This is the reason I added this function. I like the current approach.

Pasha

