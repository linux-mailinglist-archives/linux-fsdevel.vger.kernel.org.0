Return-Path: <linux-fsdevel+bounces-68981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D64C6A882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E6DC32C71E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1336A017;
	Tue, 18 Nov 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g2K9G2tg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406B30E84D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482320; cv=none; b=XhrZDdXWbi/k3h61gY1P0e1xzp5g5GvSpvjPuZ0Ej0fhMlXseXBtHUqi6gbBU/og6rpvbzXPcX0cQc2LVhGKoDfG42G8d1+V0EHVZ78Bh3uGMl9Zq3CEpjs7ZDhhwxSGuhaCN5AO+5AvvsEAMFfSJIsay/SNh1qHBqx684sHk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482320; c=relaxed/simple;
	bh=yIeOJnxlLJq6unMitN9z5K1Cj1/iT1QGU36BvuUqR8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5Py73vJV0BGJUcbG09D4qN/Xd/WYCaLcDx/GvzNv5nvd1k7CHAlDimrUg8YuMnGQHgmMAGT0c63n9mPoh7R/25zYYTMmqvGD3FJW9Xr2kkZqarxtBeG1nKIVnauh8CzHLGy88QwlKuEjPU6Ki97kYU+vh/fDLOrjIh/GcrrNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=g2K9G2tg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso10260919a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763482317; x=1764087117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIeOJnxlLJq6unMitN9z5K1Cj1/iT1QGU36BvuUqR8U=;
        b=g2K9G2tgsZ/Fi8LhB+pKDqUs1MlxUDwRX+lvznjbzOzosDKJyaIoGLTJdQo31uLMa3
         K+nhCuJJJtTeAVwddzB51s3T/Ea4ihrMxEHoCnSfxGTzhqv4ZXPoNAM9o+F8Y46OXNAR
         BqLSIKFTwpP79ecdBceKeOJysZGlKo0K3kwBpCYWgcJPizsak31pgeMpJDw4P9oHQPaA
         zlOdPpP5fU20AVPBPfrL70BmidfDOWXJxyL0iRBafSFmd70YRp7wSnBwZuue6J/OOJO5
         P2ubMRKlWea5r1wRreLjOfPM/fN4OsqaUOscTIahafXB4nArLFlo7zVfqkb90QfemrCd
         w8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482317; x=1764087117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yIeOJnxlLJq6unMitN9z5K1Cj1/iT1QGU36BvuUqR8U=;
        b=UTIMc0YgxR59tKCRaSxe72Wy5po/alfxlgSpCASdHY/xyq9F/3RfPC0LArWjPy4+D5
         6o5Ee3j6gLjz2arLdLGd3Gt1QZwkQ33AALSVNrkSNR6fS4LPos/bUwopvPWw2mthjsMs
         DRqhy18trQUzOvNXzltZ56tLdlkDmjPMR49f6sJe5g1BdrCCCVC5hlye47EAFHbZQPmr
         Qiz8sTEhnZhQ1prloLWqDwlsl29r7pEzpW2pVG/ykxDRqhKMSTHhskIIe2Y4vnDAis9R
         c+jBG5CqblPseD0G4FWMVPLf5verc92hXHuU9ZOwUYjVH+vqQ3G9coJTN6UFSBrkvkKV
         XN2w==
X-Forwarded-Encrypted: i=1; AJvYcCVqGGt2JaKTm19jEy2nkNS6TXP8B6L9NMu97IGYsJTYS6UJViD1cqNxD8vBV7Vg0cTVgD62H7tPfxS32lGd@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrkGP/oKaXk6HmDle48zGlNlCISlskI51rR9GL8CdxzYWEHRH
	IJ0AzBkXKiM6cOjc/rEpTS3uVO7FU3O2sztHbYr44YhkuSCaV+pAxYTlSqYL6kmvynXcPnZSUez
	uTX/IDeDSHdpdvzfrtQjSdIXfP4hd6pHZBOG9+wnrbg==
X-Gm-Gg: ASbGncvoMDZtYtwAn5oVR+X7tqYKs9Y9XA8VwbuWCmmKTo1BproKtL0OQ6OW7ThDOfT
	JVAPWjFa4gAI7jQfrui3wRARRUZXnhioyrKUgrnqqKihV7jjeJ8pLpt1ts23m1wXlD6dmNick8J
	EEdHbZTgIueKIT5ypT+4wrGxowh2wT/vgt9Y53PqtcEJHldHQI8L2K62MAd2O4xXka7IFef4E9w
	5cDKBw1ZBXeaWFMspiskbuXPVsR+hzRe7R147Y4icsW9YznjFuXxK8n96q1EpPSdzmM
X-Google-Smtp-Source: AGHT+IFHXvld5bm2qlzNd0Y2ybfozdwR8s6ttYI14x44odTpSeo2AgXFTy6L97nlTwnrr84Th1Itshlxng9A7gKWAlE=
X-Received: by 2002:a17:907:7e8d:b0:b73:1b97:5ddd with SMTP id
 a640c23a62f3a-b7634736285mr4050866b.8.1763482315319; Tue, 18 Nov 2025
 08:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-2-pasha.tatashin@soleen.com> <mafs0ecpv4a4q.fsf@kernel.org>
In-Reply-To: <mafs0ecpv4a4q.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 11:11:18 -0500
X-Gm-Features: AWmQ_bnCG4YfqGfoAbQTxY2D5ZCM-y47-VoI150hvneRrqrf0ng4Jg42xOKdVlg
Message-ID: <CA+CK2bDfxMhNQKjZD1uRSrg+wJYcFamji_oBvGBn+bnsb4Bbog@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:46=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Sat, Nov 15 2025, Pasha Tatashin wrote:
>
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec). The primary use case is updating hypervisors with minimal
> > disruption to running virtual machines. For userspace side of hyperviso=
r
> > update we have copyless migration. LUO is for updating the kernel.
> >
> > This initial patch lays the groundwork for the LUO subsystem.
> >
> > Further functionality, including the implementation of state transition
> > logic, integration with KHO, and hooks for subsystems and file
> > descriptors, will be added in subsequent patches.
> >
> > Create a character device at /dev/liveupdate.
> >
> > A new uAPI header, <uapi/linux/liveupdate.h>, will define the necessary
> > structures. The magic number for IOCTL is registered in
> > Documentation/userspace-api/ioctl/ioctl-number.rst.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.=
c
> > new file mode 100644
> > index 000000000000..0e1ab19fa1cd
> > --- /dev/null
> > +++ b/kernel/liveupdate/luo_core.c
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +/**
> > + * DOC: Live Update Orchestrator (LUO)
> > + *
> > + * Live Update is a specialized, kexec-based reboot process that allow=
s a
> > + * running kernel to be updated from one version to another while pres=
erving
> > + * the state of selected resources and keeping designated hardware dev=
ices
> > + * operational. For these devices, DMA activity may continue throughou=
t the
> > + * kernel transition.
> > + *
> > + * While the primary use case driving this work is supporting live upd=
ates of
> > + * the Linux kernel when it is used as a hypervisor in cloud environme=
nts, the
> > + * LUO framework itself is designed to be workload-agnostic. Much like=
 Kernel
> > + * Live Patching, which applies security fixes regardless of the workl=
oad,
> > + * Live Update facilitates a full kernel version upgrade for any type =
of system.
>
> Nit: I think live update is very different from live patching. It has
> very different limitations and advantages. In fact, I view live patching
> and live update on two opposite ends of the "applying security patches"
> spectrum. I think this line is going to mislead or confuse people.
>
> I think it would better to either spend more lines explaining the
> difference between the two, or just drop it from here.

I removed mentioning live-patching.

>
> > + *
> > + * For example, a non-hypervisor system running an in-memory cache lik=
e
> > + * memcached with many gigabytes of data can use LUO. The userspace se=
rvice
> > + * can place its cache into a memfd, have its state preserved by LUO, =
and
> > + * restore it immediately after the kernel kexec.
> > + *
> > + * Whether the system is running virtual machines, containers, a
> > + * high-performance database, or networking services, LUO's primary go=
al is to
> > + * enable a full kernel update by preserving critical userspace state =
and
> > + * keeping essential devices operational.
> > + *
> > + * The core of LUO is a mechanism that tracks the progress of a live u=
pdate,
> > + * along with a callback API that allows other kernel subsystems to pa=
rticipate
> > + * in the process. Example subsystems that can hook into LUO include: =
kvm,
> > + * iommu, interrupts, vfio, participating filesystems, and memory mana=
gement.
> > + *
> > + * LUO uses Kexec Handover to transfer memory state from the current k=
ernel to
> > + * the next kernel. For more details see
> > + * Documentation/core-api/kho/concepts.rst.
> > + */
> > +
> [...]
> > diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioct=
l.c
> > new file mode 100644
> > index 000000000000..44d365185f7c
> > --- /dev/null
> > +++ b/kernel/liveupdate/luo_ioctl.c
> [...]
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Pasha Tatashin");
> > +MODULE_DESCRIPTION("Live Update Orchestrator");
> > +MODULE_VERSION("0.1");
>
> Nit: do we really need the module version? I don't think LUO can even be
> used as a module. What does this number mean then?

Removed the above and also removed liveupdate_exit(). Also changed:
module_init(liveupdate_ioctl_init); to late_initcall(liveupdate_ioctl_init)=
;

> Other than these two nitpicks,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you!

Pasha

