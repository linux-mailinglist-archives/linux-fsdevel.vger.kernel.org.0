Return-Path: <linux-fsdevel+bounces-68069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3AC53386
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C54541EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413033E346;
	Wed, 12 Nov 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N9XadKC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283D33D6F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959548; cv=none; b=UiuEI2e3YcZbWuGjvjXTeOuvA6hmwGjngXEi1OLmJNamXEbQZyVjBpZ5X/zJiUXK54ky37jnLdIoidr4VRChukpbxgAvMnPgfxG8shIdWtMELzQOLagkSuNDYgYSG9Pq0ptWvVkAt9uxNykE78dQHepKDZcwnUJs2HpGLXMdqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959548; c=relaxed/simple;
	bh=IhGmnjkrIabfR44gd9BIvr7pcokhjZi5UFhbngjXwvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhH6+FVtbez8AyKLo6zSXNgq6aWOCwiqTwV7c+l9j3Xocb10O/1bGOHIkM+DKA7KaThMaN10QGKnPOky0wKCSrlHHtNdmL3z+lqc1ptw4DwxDdvnq09BXK3fHXFSyFaQ85DGnnzYJtcNkn8jC+nXTS4lVDlZ9uQwgb6XDajR9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=N9XadKC0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1480038a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762959545; x=1763564345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MTLQ2+KzlbyAQxckoGWY8C9+me/+LObO2aCT3fFijI=;
        b=N9XadKC0UVxFLkY9jzvuAikB7Hg0mTYRuXtJs27Uw4FgaIFVemvrjszSN4H1dk5vYN
         KQz09WkCXp2gVgk6yu24Fy+ebuaHwYlnjOukIeAWckKRF6M4WkwEldin3m/4t6aC+Wyi
         v0lW/V8SjFq7pKaDTPNpRZEeM2au0g1pTRXI/0Yq1mYC5vK2bcVQlWp9xME1Ye4Cu6Cc
         XO9WJo2hL6vaKBioq/V04Hev39SCnbJxedzYvN0dnC8/p81E/eJWtQtTPRPS5QmrxICh
         YwiYM/3WwUWX7yTfVYp+x0cT+TPse+XD5MXReIB7NxL4HZoltVE5xfchaBNCBwax4uYD
         7jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959545; x=1763564345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MTLQ2+KzlbyAQxckoGWY8C9+me/+LObO2aCT3fFijI=;
        b=IL1VxnIWYEOKkP61i+wSRl8Po45Yp/k2+zU0ejOaNb6benZPZYqA+/mN4hUj2+Lqm0
         /AmyHe5uC9+kpOK24NxSNOma+x041O5vBsEh8gg3ustCvCHCJES4abHmsDqphx8iiLrn
         TAzoKzdm6MpsmpCVkMk841PJ8xI5aK3axibW5afRombZQAqU3pvH7SDLgTR6oFA57k8x
         JJRuMqO1xoeyedDamoqe3OZMj51m1G5JK04pud/1K26sVK8eI1VzcxpXqZ4j1r5p6DZl
         y4u0kEbh4SZVGkHeAiSVG7wUjEdxMA3VG0p8stdmLpeYCJNC7QYGLd/5bsNgwC8yVTy+
         nWYA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZjaWr1jvGa0oIrqrHZNdNKTEZPDmdwWCy1PcQuZlHJuHZ9oYnX35MOfqQ9I5yiKZgvRiPTajzwC1O5/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LmH4FD6/Q6KzYIuaZDsjvY6fU13slIQQAxEQ6MusuO+FOidb
	xHMgrHaW9Axe4P9tflvsPaeUy/XPLZwTuQ3AdzvkBaBB+ioINK+OA1Gjj0KNcXjWe3laPVlhwM+
	eCM6dJ1rWxJHiReCBdfrozKNILXJjJ2GmuNdm5ifAmQ==
X-Gm-Gg: ASbGnctrmgnhtG/D86DYmG9Tt4i0O+i3CkGD+PY8mtuCBKUr8QUnMwiYEE6Rjtfm9Se
	vvNrFUoBckss6RplQtibq/U3K8PCGPVejx2CNCyeCMVQQRXNog1GpopSGreElTHajw5/2mIN55Q
	heAiB5jMJ0UuSqXEToi3XV/qLsfat0jEHeKkvuIMgeCh7G9kMOIi6uSsJdHHGIlqJiwsd/WoO6o
	1yaCLYImbhAx5o3WJVObab2CafFlw2kSqNE0AFWa2AIpsuXhktvqzX35w==
X-Google-Smtp-Source: AGHT+IEdmxSCUrDpzYYdeQ7xGZMZCFuRazVHOEq301lv0Np/o4OtNdmIj/Fd7MlLr72XZf02Ov5bYrL1l7CAevQmQsg=
X-Received: by 2002:a05:6402:20d5:20b0:640:6650:9173 with SMTP id
 4fb4d7f45d1cf-6431a5906c4mr2199942a12.33.1762959544759; Wed, 12 Nov 2025
 06:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
 <aROZi043lxtegqWE@kernel.org> <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
 <aRSKrxfAb_GG_2Mw@kernel.org>
In-Reply-To: <aRSKrxfAb_GG_2Mw@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 09:58:27 -0500
X-Gm-Features: AWmQ_bnbzArXLN8aoATNdiGHp809pzMOSngeRCNP27w6LsiaaRY3i_BJDeNIl5I
Message-ID: <CA+CK2bAq-0Vz4jSRWnb_ut9AqG3RcH67JQj76GhoH0BaspWs2A@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:25=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Pasha,
>
> On Tue, Nov 11, 2025 at 03:57:39PM -0500, Pasha Tatashin wrote:
> > Hi Mike,
> >
> > Thank you for review, my comments below:
> >
> > > > This is why this call is placed first in reboot(), before any
> > > > irreversible reboot notifiers or shutdown callbacks are performed. =
If
> > > > an allocation problem occurs in KHO, the error is simply reported b=
ack
> > > > to userspace, and the live update update is safely aborted.
>
> The call to liveupdate_reboot() is just before kernel_kexec(). Why we don=
't
> move it there?

Yes, I can move that call into kernel_kexec().

> And all the liveupdate_reboot() does if kho_finalize() fails it's massagi=
ng
> the error value before returning it to userspace. Why kernel_kexec() can'=
t
> do the same?

We could do that. It would look something like this:

if (liveupdate_enabled())
   kho_finalize();

Because we want to do kho_finalize() from kernel_kexec only when we do
live update.

> > > This is fine. But what I don't like is that we can't use kho without
> > > liveupdate. We are making debugfs optional, we have a way to call

This is exactly the fix I proposed:

1. When live-update is enabled, always disable "finalize" debugfs API.
2. When live-update is disabled, always enable "finalize" debugfs API.

Once KHO is stateless the "finalize" debugfs API is going to be
removed, and KHO debugfs itself can be optional.

> > Yes you can: you can disable liveupdate (i.e. not supply liveupdate=3D1
> > via kernel parameter) and use KHO the old way: drive it from the
> > userspace. However, if liveupdate is enabled, liveupdate becomes the
> > driver of KHO as unfortunately KHO has these weird states at the
> > moment.
>
> The "weird state" is the point where KHO builds its FDT. Replacing the
> current memory tracker with one that does not require serialization won't
> change it. We still need a way to tell KHO that "there won't be new nodes
> in FDT, pack it".
>

see my answer below

> > > kho_finalize() on the reboot path and it does not seem an issue to do=
 it
> > > even without liveupdate. But then we force kho_finalize() into
> > > liveupdate_reboot() allowing weird configurations where kho is there =
but
> > > it's unusable.
> >
> > What do you mean KHO is there but unusable, we should not have such a s=
tate...
>
> If you compile a kernel with KEXEC_HANDOVER=3Dy, KEXEC_HANDOVER_DEBUGFS=
=3Dn and
> LIVEUPDATE=3Dn and boot with kho=3D1 there is nothing to trigger
> kho_finalize().
>
> > > What I'd like to see is that we can finalize KHO on kexec reboot path=
 even
> > > when liveupdate is not compiled and until then the patch that makes K=
HO
> > > debugfs optional should not go further IMO.
> > >
> > > Another thing I didn't check in this series yet is how finalization d=
riven
> > > from debugfs interacts with liveupdate internal handling?
> >
> > I think what we can do is the following:
> > - Remove "Kconfig: make debugfs optional" from this series, and
> > instead make that change as part of stateless KHO work.
> > - This will ensure that when liveupdate=3D0 always KHO finalize is full=
y
> > support the old way.
> > - When liveupdate=3D1 always disable KHO debugfs "finalize" API, and
> > allow liveupdate to drive it automatically. It would add another
> > liveupdate_enable() check to KHO, and is going to be removed as part
> > of stateless KHO work.
>
> KHO should not call into liveupdate. That's layering violation.
> And "stateless KHO" does not really make it stateless, it only removes th=
e
> memory serialization from kho_finalize(), but it's still required to pack
> the FDT.

This touches on a point I've raised in the KHO sync meetings: to be
effective, the "stateless KHO" work must also make subtree add/remove
stateless. There should not be a separate "finalize" state just to
finish the FDT. The KHO FDT is tiny (only one page), and there are
only a handful of subtrees. Adding and removing subtrees is cheap; we
should be able to open FDT, modify it, and finish FDT on every
operation. There's no need for a special finalization state at kexec
time. KHO should be totally stateless.

> I think we should allow kho finalization in some form from kernel_kexec()=
.

If we achieve that, we wouldn't need a kho_finalize() call from
kernel_kexec() at all. All KHO operations should be allowed at any
time once KHO is initialized, and they shouldn't depend on the machine
state. So, even late in shutdown or early in boot, it should be
possible to preserve KHO memory or a subtree. I'm not saying it's a
good idea to do that late in shutdown (as preservation may fail), but
that should be the caller's problem.

Thanks,
Pasha

