Return-Path: <linux-fsdevel+bounces-63667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BCBC9AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4B4F3537CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675592EC0A6;
	Thu,  9 Oct 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FNZJ5ue0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B02ECD11
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022265; cv=none; b=nNVxziiEHjPb58O7OD9V7jvG2WpYco3RWMIOFWOSua81OkQJik4x4p7KMk5LH+krmLLmIeoBrSD6qohZhigwIq6TDmL6/9iI5PcHvWX8pV2xETaUoX2mUWKd4Kk7dBkcB4dodrGmJ+trAPjsdxNizepMM0vxiJW8baVpFEDIY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022265; c=relaxed/simple;
	bh=nMCMKtDDnWMJHsk342fi+88ua8K8gM4/fZkYqcY0hoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqT+gB9frMdIjg2jy6hFPKjn6MxmD07jn0oEY6/55n+PpnveksW8KfP5VLDt0QsVZNo/+rEWnAjWRSJSYYmDJQnl1l2jfKTIiT1IiFE4xepe9OULaGBQG4FKRoy4rxc/EW8UTMO3x6g+XCNU87H6ohhdfRe9Zz4F8nvsO5CVfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FNZJ5ue0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4db385e046dso9816691cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760022263; x=1760627063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiXnUieO2xScql0ch1/VZCkQk9SwXWpJ1Ui0K7fqWkw=;
        b=FNZJ5ue0A+Ik7aARuS/f7dSCCDasQ3VBEz8IRjTpqfW5sLf0BqnbFgrxroFGGDqqet
         aWl842KLjychOdCxzlUKZRmh/58cMrAPy7jT4uC/y0IA7BDTZeZUa86M4yTmkWwKescZ
         qsHlLfvUcrFfKArISc9kHjAG8tXG5vroHYwx+34wVW7fuO0IxYUJhxd/mq1xdW6rRWrj
         UcAx9N1xibBIuhLWROf0HKBIi4pAAnSCXtfQxe+yt3RRwPe9rs9r58oj9gqOVBmuXYtr
         KZmEEUnIF7C0aP3ezNfar7Mi+dyrQwc1CdlJFVZJqDWyYZmw5L63/2DuModWVD9t3pmv
         gGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022263; x=1760627063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiXnUieO2xScql0ch1/VZCkQk9SwXWpJ1Ui0K7fqWkw=;
        b=XoS0VEmuE3gtTXrTt4xkNswRgP8w2SqtZFSXP65eUd/E2qS4PP2vQYcZ9udTzJROIy
         MiAVC31aEk9hbhMAiqYtsSaHle6YrX7AwpvqDQONrqzGcWK4ACywbmaWbJcu9NtRNaGa
         EzN1JNXn96agBynDdJZFzpqRZ7+19PA9lTlVo0weBqBwtnw5XBHlfTAesDHhmeuHR4F7
         EaLpO/UQpyu6iSiw4O7D8kMxHLUhm6lhPSAtedcNaofh/LnI4zYWqszZG5Ju44U192YW
         i2Bvk36GdT7YdMik5Tlq3UgdtZzkqsV7vB6lvFBBcNj7ZnDj67ZipgBGkKtxiLhICSs+
         +HGA==
X-Forwarded-Encrypted: i=1; AJvYcCUKd8BtqxupOgDDxxlztknG33rOBSC11K7NAZfMsu6ez1zvJUDRMZ4XV2C3AxlR5ikuJmZ4Lo1PQg3MkPKm@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsgr/tSa+2jw1qc2F5yHUGkycU7lnsVYwA9JjGp8g8gXgEClJ
	EuFZUg7eYh371ZU/5AIcHdtZb1+YeolWE9nVpcIG0sfikIugcu6fxWujfBuVcZLh+HoEW5cS+a/
	dLtEA/1VE0f7NzAtFgbHzofpK50SL34OH4u5SLV4PID042wB0X43o
X-Gm-Gg: ASbGncvnXDVHuK1JBR8no7F2yS4h8kaSAGFRaNvhzlltAZ5ag4uvArHV9QwnrNVvCzp
	L11WquaAz97XoET/5XGGGIheUsPIiruShFvQHxPGd1xwNR6QumTbUuMBZQYOD8eNV7CJk6F/HpH
	NrdG2T+2U8PH8VleSwzwpk/EqQu710Ma7Gv1RSijLHahyBruUjr0G/i1OzhNr2PMoaOaezYtB/D
	h0avkB9f0JgBuTW5gfgLbJAtVTtv3kU6TOf7hk=
X-Google-Smtp-Source: AGHT+IGHSYnwEnvnqmKsabQEceJc2q2+TNir49AdC6M2J+VmuPk/pcH5aGDEMoZErKTqhORDi+KuefUOCQVA2OYIhzI=
X-Received: by 2002:a05:622a:5:b0:4de:73b2:afc7 with SMTP id
 d75a77b69052e-4e6eaced976mr96420711cf.31.1760022262645; Thu, 09 Oct 2025
 08:04:22 -0700 (PDT)
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
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 11:03:45 -0400
X-Gm-Features: AS18NWCvIxwxMrUeEufsjS7vH40gfGK_CglDZxzAQyGFJbNRzJDPR8YX8_lwq6A
Message-ID: <CA+CK2bBs9FA-nVag-9QJ8zgocxhY9JOgkgOhFix1xScGyF3tKA@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
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

On Thu, Oct 9, 2025 at 11:01=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
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

There is a second reason: by the time we enter userspace, and are
ready to retrieve FDs, we know that all file handlers that are to be
registered have registered, if we do that during boot with-in kernel,
then we can get into the problem, where we are trying to retrieve data
of a file-handler that has not yet registered.

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
>
> We cannot do that, the user should have already preserved that file
> and provided us with a token to use, if that file was not preserved by
> the user it is a bug. With this proposal, we would have to generate a
> token, and it was argued that the kernel should not do that.
>
> > file =3D liveupdate_retrieve_file(session, my_preserve_blob.file_token)=
;
> >
> > And these can run in any order, and be called multiple times.
> >
> > Jason

