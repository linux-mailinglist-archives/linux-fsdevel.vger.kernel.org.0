Return-Path: <linux-fsdevel+bounces-63672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4ABCA3B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A84F34FCCBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AF23817E;
	Thu,  9 Oct 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGb46r6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED322CBC0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028392; cv=none; b=R/K1Gsx4sOm+CEJ87gfrGnEUq07uyUDmd3j7vKdhNPSJ7Jkw85ze7BXUURikbwyekhC9tNfr37JRRUdSLXncXghlxLfcGbmktArvtFqO058BGhjumWy9s44ldLxjw8n9X7M12Ef6LdAmzSekzuOcASDVNJSllghz93QmH++18z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028392; c=relaxed/simple;
	bh=0YzEi/FKr4gAZLlOWGsCp0p08GtODGPitU0V9xWloho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7xgP8yaGFozLRrN1nuL1X0ljlw8lNPrFqhzXOzW8gvBU1uGeNO/jElws8F4OQ4kN6YsvdlnGLiZ4c9iPuNxl0qXpirLgyYWQ7pYcLRwVMHUPp94eQ0tK+QniNLgRiHDKMVjN04eDzqBpM9Rnkgjg2HxIxwcqqt16qYKztOLS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGb46r6h; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e6ec0d1683so6671cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760028389; x=1760633189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzlluHwkUBhNfLLuHc1HKW2H+S+ipbeYuCHoUWYJ/AU=;
        b=FGb46r6hSI4mLnolXEJ/yTaoR+b6l70oW2PLOJIjoLyS7rAQl7r7B7Se4F9saXsMFQ
         Lqn/2eMDtw6Fpt13lXNjiuM7qPDcZ1DWmV3tFWHaZWmWxiQGucflA2Yczq5vPZJIJHPF
         4GcBbbghvT56IRB0R6qn9ckTHcjJ7EDaqtl2LDonMZGVvoNdAI6+TuSsAApkEuEvyQfH
         aBRIOEnwVAa6i4YUTEcUoM25KUNTe9pvZmvbck/f3mkSfschYpwvb3LI41+7oOEuJ2ww
         VboX6unb3BkpfbTrpBT/LKQ2w2QSidadL869KKVyEDr3ic8ng7r6iQvx+VfDKSU2mjpB
         YgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028389; x=1760633189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzlluHwkUBhNfLLuHc1HKW2H+S+ipbeYuCHoUWYJ/AU=;
        b=ENoVJtkXAm1kFjj3N9qaGpipZz3NaOjrNlXv5VYtxD8ywaE9h+7lJWMiIwzkDF45MX
         1cgpGi5p9Fmb/obRSVgStAUQilk1343Mx1m5+UbfKQF5giyW9NAx7XrbwNfIy3xVFfqI
         GauPPtTbjYe4ITYZ+RErHvXja1uij5+qGhqGqHAEc6k7JCyqQqaITZSFd5Hg+3cGxFJR
         R/d3Je38KD/MQCPvm4Rt8Vyw5CePy3Z82rCmHQ+9O5JD+nYJpJBj436sVr9y0ZcE+5MP
         CRz5HT1yXqRmw8DpSobSxwTL4OjpGmIw9QC4+UDERxpx1cpRIz1j53/GmDwPH7F/kjZe
         prUw==
X-Forwarded-Encrypted: i=1; AJvYcCUliIZLasLm3hPT96Fk8yTr92D216XVURXVql1iDqSoonxSpj8mHmBbVlI5hoG7/Xqs5QxsTCeAXL0UYLF0@vger.kernel.org
X-Gm-Message-State: AOJu0YxbelTlPyhc0qMK8Et9/OBCLbkp0ODenJmKITBFefv48TEVHqql
	CuOgG9SaP0kq2oy0FVNKXvMoRt9Sk5tICYIVkcWvFeeTbvQeGdqfYJrnAuU/K9doGkS7jHkplSu
	kWgNXYhLq4YdCAZzQ4qoWpTFMwjt4tp/eFHeVN4v3
X-Gm-Gg: ASbGncsfziM5hpVAfKTMUbHSQihteKDTl5iY/efz5Tm7wMlVf9FtMspmcFqsb+0fY2k
	WdTrfWD2TXPMhptEmzmytIxyfhE/y3vdigHHeo86ZKWaTdYLixuuze06JI6KhD3Kc6IHACMYiwx
	sofJnyjTnkR0uEnR1mdVv0c/WNpqO4XYOdzufNaimUyLfH2R7YH59BpbdSUjeduWPpyPU8cuE3g
	DuFabZqsE+R2jdZOgXSmCABMjoP89G9z3NYSvTiBBS1gvjjz2HluUo7/RfJWJ13iadNWHE=
X-Google-Smtp-Source: AGHT+IF70ucIJMpJA0vPDQgicdHZr5JjOzPiEUk9y5SQTUUUNRoZE52nw8qSw3T5aRdmC55lZrWVgbTQ4VOEIK5o6D4=
X-Received: by 2002:a05:622a:344:b0:4b7:9b7a:1cfc with SMTP id
 d75a77b69052e-4e6eabce6d2mr16470351cf.10.1760028388319; Thu, 09 Oct 2025
 09:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
 <20251008193551.GA3839422@nvidia.com> <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
 <20251009144822.GD3839422@nvidia.com> <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
In-Reply-To: <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 9 Oct 2025 09:46:16 -0700
X-Gm-Features: AS18NWBgKgmWhR1-EKut7z0eede2LXIJaTXH-__gJayThOTTr-r8gXegH0ezPFY
Message-ID: <CAAywjhSU7ibji=Z50U+OcX7eemhid2sB7OK_fsgzds3vGTZOjw@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, pratyush@kernel.org, jasonmiu@google.com, 
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:02=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Thu, Oct 9, 2025 at 10:48=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Wed, Oct 08, 2025 at 04:26:39PM -0400, Pasha Tatashin wrote:
> > > On Wed, Oct 8, 2025 at 3:36=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > > >
> > > > On Wed, Oct 08, 2025 at 12:40:34PM -0400, Pasha Tatashin wrote:
> > > > > 1. Ordered Un-preservation
> > > > > The un-preservation of file descriptors must also be ordered and =
must
> > > > > occur in the reverse order of preservation. For example, if a use=
r
> > > > > preserves a memfd first and then an iommufd that depends on it, t=
he
> > > > > iommufd must be un-preserved before the memfd when the session is
> > > > > closed or the FDs are explicitly un-preserved.
> > > >
> > > > Why?
> > > >
> > > > I imagined the first to unpreserve would restore the struct file * =
-
> > > > that would satisfy the order.
> > >
> > > In my description, "un-preserve" refers to the action of canceling a
> > > preservation request in the outgoing kernel, before kexec ever
> > > happens. It's the pre-reboot counterpart to the PRESERVE_FD ioctl,
> > > used when a user decides not to go through with the live update for a
> > > specific FD.
> > >
> > > The terminology I am using:
> > > preserve: Put FD into LUO in the outgoing kernel
> > > unpreserve: Remove FD from LUO from the outgoing kernel
> > > retrieve: Restore FD and return it to user in the next kernel
> >
> > Ok
> >
> > > For the retrieval part, we are going to be using FIFO order, the same
> > > as preserve.
> >
> > This won't work. retrieval is driven by early boot discovery ordering
> > and then by userspace. It will be in whatever order it wants. We need
> > to be able to do things like make the struct file * at the moment
> > something requests it..
>
> I thought we wanted only the user to do "struct file" creation when
> the user retrieves FD back. In this case we can enforce strict
> ordering during retrieval. If "struct file" can be retrieved by
> anything within the kernel, then that could be any kernel process
> during boot, meaning that charging is not going to be properly applied
> when kernel allocations are performed.
>
> We specifically decided that while "struct file"s are going to be
> created only by the user, the other subsystems can have early access
> to the preserved file data, if they know how to parse it.
>
> > > > This doesn't seem right, the API should be more like 'luo get
> > > > serialization handle for this file *'
> > >
> > > How about:
> > >
> > > int liveupdate_find_token(struct liveupdate_session *session,
> > >                           struct file *file, u64 *token);
> >
> > This sort of thing should not be used on the preserve side..
> >
> > > And if needed:
> > > int liveupdate_find_file(struct liveupdate_session *session,
> > >                          u64 token, struct file **file);
> > >
> > > Return: 0 on success, or -ENOENT if the file is not preserved.
> >
> > I would argue it should always cause a preservation...
> >
> > But this is still backwards, what we need is something like
> >
> > liveupdate_preserve_file(session, file, &token);
> > my_preserve_blob.file_token =3D token

Please clarify if you still consider that the user does register the
dependencies FDs explicitly, but this API just triggers the
"prepare()" or "preserve()" callback so the preservation order is
enforced/synchronized?
>
> We cannot do that, the user should have already preserved that file
> and provided us with a token to use, if that file was not preserved by
> the user it is a bug. With this proposal, we would have to generate a
> token, and it was argued that the kernel should not do that.

Agreed. Another thing that I was wondering about is how does the user
space know that its FD was preserved as dependency?

>
> > file =3D liveupdate_retrieve_file(session, my_preserve_blob.file_token)=
;
> >
> > And these can run in any order, and be called multiple times.
> >
> > Jason

