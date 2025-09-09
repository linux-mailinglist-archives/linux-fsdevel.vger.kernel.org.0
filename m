Return-Path: <linux-fsdevel+bounces-60693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFAB501A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B625E4E0691
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7817A316;
	Tue,  9 Sep 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DtShKGGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5D13774D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432459; cv=none; b=rhNmQiaTYO+/L4SXoHJIS23n2tF/dEXjwXhMAovw5/RexKd25ClbeR+Rp7A4noE2Y0bzKteSSI0IkpQZNBpXAG4RNSiqCmvYEnovHYHpxfp1Jp91KY/U/XQZioZGsNbbxwmmAMtSdUuzDr6npYS8xT0QjMUuTotxDTBQ2dXwvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432459; c=relaxed/simple;
	bh=NRWX0gy62EFsM5r2pNvxcPyoBc+pc5A2tLFR+LFtsLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CorHpo8qgaWPWCDoO12aydzBOKZlOt97u1mGgrZzYteGOUGdcdPSELuwnK4ZAmmFlDKb99eQ1vQgmPGOm8fMyS8ytjew39DTkWOCHHXfY6D2XUeU1q7jNNFM+xwziLdB9jtizk0SShp7qM20ZlCQKQ1ruP6xiwhRWPSbSelMAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DtShKGGn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5fb2f7295so29619311cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1757432456; x=1758037256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRWX0gy62EFsM5r2pNvxcPyoBc+pc5A2tLFR+LFtsLM=;
        b=DtShKGGni6SXsHlPTbhu3MgCPC2po9WCxrPewGsVU1eP35FcyDpBxu2d5t/qFQmvYX
         OPInbDxEuIQmHa74j5yxZYzXgyQHupC792gQSCJmGF0kyzPRflOSjLLiaAuv2XmeQonL
         2tScxw32eNWXV6dqHcfx5lg1ifMvgmrJCvLMlakS0adfxhuTXumANei8R20jow6P8flm
         Hy8meQwVRJ6CZnng7egGZLIVYq8wPUaSD/4rtKazWY7VPFxunjg7sazXYfXA0xTwO3qw
         quC7q0vjLFFXFjjUd2c0uqYXPcmmgS5F08JYMTg2ESJZLCG1msrc0j2rvnSK++JNt4hT
         jaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432456; x=1758037256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRWX0gy62EFsM5r2pNvxcPyoBc+pc5A2tLFR+LFtsLM=;
        b=nDUGvKkJn6JDx6U3ufjtI4pwJZbJDUcdBlYnKhyzvLIVMvZ6HkepKgmYyIvZrfY2qP
         A6sPT7MdryoK2yQ8Ob8Zy4HFYu9Z3xylH9/mGBQrfxmeYEQwuDCOEZNVyIfQhMU3LKpX
         oyoAzruBduvfmDNuT+faiws31up1riGWXPAlwQmsrRccu6rBOzpDi4sXUANqQyywO9db
         hbWj/DIXeEB7xFZSOliwfedlJ8djVwENAS1mj8Dikz+hnJc5eE7MSZFMGalALrFdRUhF
         b8jbL4nRnO2LX3jvhuBbuAiQigvHYuHXcJewOu2uzk9vvb4rFWuwyj02vt5hU4h40wAD
         XZSA==
X-Forwarded-Encrypted: i=1; AJvYcCVKHVDWe/00dlbUe9l4TRKdqcnz8emmuFb0AAn18nZiVcNvHc3zYA5m8Cicujnf6IIT+59ssjoblBHj3ljl@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJn0ME6GJAKcfFLdYMAynfeq9iOoiP658dUl55yHEn/VWRnpZ
	9r5Eova6hUEm2tzUX5DT88EMkT0FReIK3RmxDHds1/yRAfTfnR4OK/2nMm9ughgDERIvlJb8whp
	j51mZR7PNaYRzwpT1l/V9wY7JimwjP9Qn8xOR9kxUyw==
X-Gm-Gg: ASbGncvvydlcLkcAbtgkK9PQcY/+H+tg9ICIWzp5FhckGfROW7GNv7iArknppJBE5cg
	GKm3Rmyj/VVsPpIuUWnfLtttWf0bIlwteX4FZrRxHf1TguuIZymLQ4/int2K5rAOYK3HvUpht90
	1SE0h+DbM/yg6S3QQEaSvJXyjZvODYqDp95B2EVP2VEbukyO4loUOo8RYxE2wPIql3QjAEAwQh0
	odZScNai2SH988=
X-Google-Smtp-Source: AGHT+IFIyhmzGWFTrUx5qTZBLu9qAAH3OqD11kjv9JWMaCvsLsEFvRfp7eNadU4BDO41Wf/Ch0HESERQxsGjvKdRSzY=
X-Received: by 2002:ac8:5d4b:0:b0:4b5:ebe7:ac16 with SMTP id
 d75a77b69052e-4b5f85694b2mr112159801cf.58.1757432456172; Tue, 09 Sep 2025
 08:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org> <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org> <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org> <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org> <20250904144240.GO470103@nvidia.com> <mafs0cy7zllsn.fsf@yadavpratyush.com>
In-Reply-To: <mafs0cy7zllsn.fsf@yadavpratyush.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 9 Sep 2025 11:40:18 -0400
X-Gm-Features: Ac12FXxeog2W-sndMgfE-Kiuw70lrrt6PwppqWI5s8CYKqzXaWa3HgK79sNYiwg
Message-ID: <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:53=E2=80=AFAM Pratyush Yadav <me@yadavpratyush.co=
m> wrote:
>
> On Thu, Sep 04 2025, Jason Gunthorpe wrote:
>
> > On Thu, Sep 04, 2025 at 02:57:35PM +0200, Pratyush Yadav wrote:
> >
> >> I don't think it matters if they are preserved or not. The serializati=
on
> >> and deserialization is independent of that. You can very well create a
> >> KHO array that you don't KHO-preserve. On next boot, you can still use
> >> it, you just have to be careful of doing it while scratch-only. Same a=
s
> >> we do now.
> >
> > The KHO array machinery itself can't preserve its own memory
> > either.
>
> It can. Maybe it couldn't in the version I showed you, but now it can.
> See kho_array_preserve() in
> https://lore.kernel.org/linux-mm/20250909144426.33274-2-pratyush@kernel.o=
rg/
>
> >
> >> For the _hypervisor_ live update case, sure. Though even there, I have=
 a
> >> feeling we will start seeing userspace components on the hypervisor us=
e
> >> memfd for stashing some of their state.
> >
> > Sure, but don't make excessively sparse memfds for kexec use, why
> > should that be hard?
>
> Sure, I don't think they should be excessively sparse. But _some_ level
> of sparseness can be there.

This is right; loosely sparse memfd support is needed. However, an
excessively sparse preservation will be inefficient for LU, unless we
change the backing to be from a separate pool of physical pages that
is always preserved. If we do that, it would probably make sense only
for guestmemfd and only if we ever decide to support overcommitted
VMs. I suspect it is not something that we currently need to worry
about.

> >> applications. Think big storage nodes with memory in order of TiB. Tho=
se
> >> can use a memfd to back their caches so on a kernel upgrade the caches
> >> don't have to be re-fetched. Sparseness is to be expected for such use
> >> cases.
> >
> > Oh? I'm surpised you'd have sparseness there. sparseness seems like
> > such a weird feature to want to rely on :\
> >
> >> But perhaps it might be a better idea to come up with a mechanism for
> >> the kernel to discover which formats the "next" kernel speaks so it ca=
n
> >> for one decide whether it can do the live update at all, and for anoth=
er
> >> which formats it should use. Maybe we give a way for luod to choose
> >> formats, and give it the responsibility for doing these checks?
> >
> > I have felt that we should catalog the formats&versions the kernel can
> > read/write in some way during kbuild.
> >
> > Maybe this turns into a sysfs directory of all the data with an
> > 'enable_write' flag that luod could set to 0 to optimize.
> >
> > And maybe this could be a kbuild report that luod could parse to do
> > this optimization.
>
> Or maybe we put that information in a ELF section in the kernel image?
> Not sure how feasible it would be for tooling to read but I think that
> would very closely associate the versions info with the kernel. The
> other option might be to put it somewhere with modules I guess.

To me, all this sounds like hardening, which, while important, can be
added later. The pre-kexec check for compatibility can be defined and
implemented once we have all live update components ready
(KHO/LUO/PCI/IOMMU/VFIO/MEMFD), once we stabilize the versioning
story, and once we start discussing update stability.

Currently, we've agreed that there are no stability guarantees.
Sometime in the future, we may guarantee minor-to-minor stability, and
later, stable-to-stable. Once we start working on minor-to-minor
stability, it would be a good idea to also add hardening where a
pre-live update would check for compatibility.

In reality, this is not something that is high priority for cloud
providers, because these kinds of incompatibilities would be found
during qualification; the kernel will fail to update by detecting a
version mismatch during boot instead of during shutdown.

> > And maybe distro/csps use this information mechanically to check if
> > version pairs are kexec compatible.
> >
> > Which re-enforces my feeling that the formats/version should be first
> > class concepts, every version should be registered and luo should
> > sequence calling the code for the right version at the right time.
> >
> > Jason
>
> --
> Regards,
> Pratyush Yadav

