Return-Path: <linux-fsdevel+bounces-63673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C403FBCA52B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A777A4E2005
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540823B615;
	Thu,  9 Oct 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bNg0lRi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFC224AE0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029538; cv=none; b=SsJSwVIy7F5sjLTuSKGE0ufYRM/1IhuUrcyJLblmBZaflYvtGm8ZmwOWyhh5IfNDYLJNYIuAfpBAxzNlyJDBKpmjHMh6Tbo+q7kQd8IMiL7Gvh2bMlwWzpO1P2irfdAnjZDbvurecgNc4htJiN/f6qKNz+77cSiAzpW0Zdf5eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029538; c=relaxed/simple;
	bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpzm9r1toDURf6seehDFiXIySi9YxZmvZ//41VnsvTkpI7CsJcagHuiRsUAaD24s3hUw+RmR8SNt3I7zilKnJGv0xteU1ykz5V5/owW9IMtC/bV107W2s3TB5190IUohTt5HI6Nsj2+I/ONQvoBo+ZZNfu00b9Z4vXglMm32HS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bNg0lRi+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-85d5cd6fe9fso104120885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760029536; x=1760634336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=bNg0lRi++rFK10ae92hN4Q+tD9JKalVMgtXOuv5DxPVssEQDJepsowAy+hBIDI1Q3b
         d24YXKnoa9bgNi6emnzdPBZBOj1vfailzHg6agjIpzM3JJyndgZxPINWrJhnqbZ1vHoo
         gxyUdudesuVLETrCGKh8N7SQZnEDE9Fjqoqf5TwzYSV+jg5HRAv5OgbF1Vmfl2urNTiZ
         NAFBJeR7fREu/yildLKrb73j2o2cZA6vZamNc1MA1MdAC5A62yW3Ysh9wW1T9NzoUlK7
         S70a5Kwd5gImEZJvKQVKJgayqIJUTneVBJ9icQs2ulU1PZuMPH/eyMjPDjILTyKSI3TH
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029536; x=1760634336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=NzwWX5h2/2+gthCtEaI6Tgzl0/xlPUnmml7ClB9G6a3aKFL4hAxrTtGRQylc2qdlHf
         WBT6bzvrNiWLRk2Lm0mpRuFI6Q/yFDaEjXTPzviALakznlmwmt+beiWG3hiNZz620b0i
         FwutF1pHTels+1FmC3qSurRMVBDsKZgdQrV65EHmtTh5LwCgxGYPunPTUNmxtBia+n1Y
         3cfHFt9eX25gGHlecUoDSJttGpHDA9Y7CWj2h6CVnRo9McCPCzVGQoXtRhPZtPanPdYs
         D679/sXEe79ztIQLKvNG7okqUOe/QeT4jweSsQJxZ5OvCE4iE/EBkIwp2wFQumajiTVZ
         0/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU0n3GP89Lj5Ntv+j30qllidvgpRJV6i5yk5u+xQm6mUyZB3jNkD3cZkMofJBnsCiUFWYcCpv4oKdumUEC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3RK1s3nsra6BO+SYW9TWgcnu9kggSwjcQR2lfMDUqm1+hPLl
	OxqT+MMJqy5IqtJ4Q1/a8jXOaIyjPIXmy2Fm0enhd0nJ3th59AkcHrjww3MCu1Ke+vyZ32j1g0c
	MGSvn8Hzg70/fh5H8lWO9LUzoBmMNZ8Ciiajj6E+PRQ==
X-Gm-Gg: ASbGncu74AmSCefXeo2AGu5oLmteFbkM4Xt2cmRp1Ip4lptQXTsKeUDaNkskVm/jMqx
	U6h+jtXWkLnvo5OELFya/54YGA/bQoCkGbr0qpY0sHUqtsxlICKsBevegGgqAbXQTicn5rzhMtT
	bjxgsyiULETjkFSqr9gNBRTndcKVtTpnT06LcyFI6M04mc0Meecu9uiHEen5GTJAcCyXuUmbBfK
	KVFBEz7HBrYSPEr4Az9tzCAcfhG2VEHSomsL40=
X-Google-Smtp-Source: AGHT+IFE2sAReF4JI9gkbOEBI0GExAG6O+9H49nxZIOW3wiMfCJHnma5AW+apR4GDzx7KvuzWvZY/WusdxfEgE8+CuY=
X-Received: by 2002:a05:620a:2952:b0:870:ab:42f2 with SMTP id
 af79cd13be357-8835384546cmr1185682885a.24.1760029535702; Thu, 09 Oct 2025
 10:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org> <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
 <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
In-Reply-To: <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 13:04:57 -0400
X-Gm-Features: AS18NWB7Cr_VpUIKYZatXQYpiNUtQ7J6s9XvqZtMcyHaQrrY3c7p0E8zT1F9p7k
Message-ID: <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:35=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2025/10/9 5:01, Pasha Tatashin =E5=86=99=E9=81=93:
> >>> Because the window of kernel live update is short, it is difficult to=
 statistics
> >>> how many times the kernel is live updated.
> >>>
> >>> Is it possible to add a variable to statistics the times that the ker=
nel is live
> >>> updated?
> >> The kernel doesn't do the live update on its own. The process is drive=
n
> >> and sequenced by userspace. So if you want to keep statistics, you
> >> should do it from your userspace (luod maybe?). I don't see any need f=
or
> >> this in the kernel.
> >>
> > One use case I can think of is including information in kdump or the
> > backtrace warning/panic messages about how many times this machine has
> > been live-updated. In the past, I've seen bugs (related to memory
> > corruption) that occurred only after several kexecs, not on the first
> > one. With live updates, especially while the code is being stabilized,
> > I imagine we might have a similar situation. For that reason, it could
> > be useful to have a count in the dmesg logs showing how many times
> > this machine has been live-updated. While this information is also
> > available in userspace, it would be simpler for kernel developers
> > triaging these issues if everything were in one place.
> I=E2=80=99m considering this issue from a system security perspective. Af=
ter the
> kernel is automatically updated, user-space applications are usually
> unaware of the change. In one possible scenario, an attacker could
> replace the kernel with a compromised version, while user-space
> applications remain unaware of it =E2=80=94 which poses a potential secur=
ity risk.
>
> To mitigate this, it would be useful to expose the number of kernel
> updates through a sysfs interface, so that we can detect whether the
> kernel has been updated and then collect information about the new
> kernel to check for possible security issues.
>
> Of course, there are other ways to detect kernel updates =E2=80=94 for ex=
ample,
> by using ftrace to monitor functions involved in live kernel updates =E2=
=80=94
> but such approaches tend to have a higher performance overhead. In
> contrast, adding a simple update counter to track live kernel updates
> would provide similar monitoring capability with minimal overhead.

Would a print during boot, i.e. when we print that this kernel is live
updating, we could include the number, work for you? Otherwise, we
could export this number in a debugfs.

Pasha

