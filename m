Return-Path: <linux-fsdevel+bounces-30995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C27990547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C081F22C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641832139DD;
	Fri,  4 Oct 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="azN1IfGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE51212EF7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050736; cv=none; b=himTNYxySYBFpl5fzDPQSEG+FVMelZpjXNPnnkYejLCU8P/ykxMFSyq9kYRQKjLDgcvbcR10Z6GgcN//qe17l74kbqSvF3dK+0m+bEmY63zFtKAotsddRrlfl+ax0Xu75A2cqmbw9RCuHISd7GJrWBt5t3Fg/nEjK1jl5n2PH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050736; c=relaxed/simple;
	bh=gRqRTWmg+rWkHl62ec5Ha2rtKjOwiMVK2MEXoSt+C5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN3z4y8V8uOPvhKCsXvwaWAJlphC8IioT47M+ykPtxuZ6tSpI0aqTzalr24TN2MNSAaIPSU9n0Lap/JbdtNVy/lphPCUvKkRAtI2+0hlFzJdYnzgVgJ4yA029Xs/aJ/pr+kHqUwxQRnmwSraLZEZc3e0hHvrlnnbzm2ihqRLnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=azN1IfGa; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbc5db8a31so17255207b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728050734; x=1728655534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJytvBuB/Bsj41TS+0yXamimG68++P3s2DCi3Nn0Lro=;
        b=azN1IfGaYoM9ltQwwfwBs7yural4ByjSEkvSHBd7hWmRqx0tsukmzWnlh7tqyqIW2p
         VRPd/Hg2Xb2Yfx4HUClXuSY0BKO9WuQy6RX0qflguNSPBMJl19Enu3kETr2UPYfkogzT
         DtINIQeFXEMctauhHl/JtgIPMYAYMTnoSJOjuAeTfLMIeUAfGyFnHQVKeRtzkalqhxkp
         DBVoZvZY7AknOHdqgLF/vol83pjUZepoY9Bc8CQ8MmRvDdW5NRVzR7m25CaIgaJmmVVX
         BWQ38Zi0aPy5EsC/vTXdAXw7n64yK2lvF5NpsymNSAKIh+PeVBjAC+5ZIySNRIT8LehI
         fvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050734; x=1728655534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJytvBuB/Bsj41TS+0yXamimG68++P3s2DCi3Nn0Lro=;
        b=MaOSd+OacYvLTCH8jt6aMqkTptJiynFnelDP8xzMmreWD16cWwhsem54S/soJ4vqcw
         Mq0wWKvvjNg8TLG2YdJqxoAvROEoChdqBh/OLcAZd2dbfuX1cTO2wxH0rNRBn9zZw4Hf
         Wgwmb4kdm9mWZUxcaqKoVq3ZgX90Q7HzwzSiD8pT3K40iXIGFtuyHU9OhwgQKgwTtzsx
         QLTYjrrpJwJiT0Vj4wTn9Sg+7302TBOIA/AlKw6sV7VV7lfrOQ+ZjkWBBBAP6SEuOp3A
         wbAByTPHzb9wlooRuq2d0aHappEfje9i44HVf2T63s7Nysll7C7BUoCEQGegHc9uPdeG
         cZxg==
X-Forwarded-Encrypted: i=1; AJvYcCVxjNLLwXFZKLa+GX8a3YiFjY1bGnQul3A91DCDxPbkh0kI8S5+1BUbtv4Lh5+XtArA+ZKnFJ0ZouytB3tE@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxrxOR+9IxB4tqFf+VNrtN8jPMd3Ds3blmRO3bA2uboyGmWO9
	FHpw8aKWFkzVl07o/+K4z0fAtGXBDUPOJ5QN05QI4f7y0N1BXkyykyJiL1sslWtv4XP8HOvV839
	FdhBI73m96svk5WISMucIcESmATh+h7D6LZmF
X-Google-Smtp-Source: AGHT+IFawfBRfIvYMmrmR6dbUrMgAbTY0IrMAlq+YHUoQVcHDUJpjj2XE/pJaQnFFpXbKi6Xl9jZYPoFoutTfyVTz4M=
X-Received: by 2002:a05:690c:6382:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6e2c7c3d563mr19656677b3.13.1728050734071; Fri, 04 Oct 2024
 07:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com> <20241004-signal-erfolg-c76d6fdeee1c@brauner>
In-Reply-To: <20241004-signal-erfolg-c76d6fdeee1c@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 10:05:23 -0400
Message-ID: <CAHC9VhRaS2Hjx1ao7x3BEURGk1Tb1z5_OHFnpHYa-y=62HuvLg@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: luca.boccassi@gmail.com, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:29=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Wed, Oct 02, 2024 at 03:24:33PM GMT, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >
> > A common pattern when using pid fds is having to get information
> > about the process, which currently requires /proc being mounted,
> > resolving the fd to a pid, and then do manual string parsing of
> > /proc/N/status and friends. This needs to be reimplemented over
> > and over in all userspace projects (e.g.: I have reimplemented
> > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > requires additional care in checking that the fd is still valid
> > after having parsed the data, to avoid races.
> >
> > Having a programmatic API that can be used directly removes all
> > these requirements, including having /proc mounted.

...

> > +             const struct cred *c =3D get_task_cred(task);
> > +             if (!c)
> > +                     return -ESRCH;
> > +
> > +             info.uid =3D from_kuid_munged(current_user_ns(), c->uid);
> > +             info.gid =3D from_kgid_munged(current_user_ns(), c->gid);
> > +     }
> > +
> > +     if (uinfo.request_mask & PIDFD_INFO_CGROUPID) {
> > +             struct cgroup *cgrp =3D task_css_check(task, pids_cgrp_id=
, 1)->cgroup;
> > +             if (!cgrp)
> > +                     return -ENODEV;
> > +
> > +             info.cgroupid =3D cgroup_id(cgrp);
> > +     }
> > +
> > +     if (uinfo.request_mask & PIDFD_INFO_SECURITY_CONTEXT) {
>
> It would make sense for security information to get a separate ioctl so
> that struct pidfd_info just return simple and fast information and the
> security stuff can include things such as seccomp, caps etc pp.

I'm okay with moving the security related info to a separate ioctl,
but I'd like to strongly request that it be merged at the same time as
the process ID related info.  It can be a separate patch as part of a
single patchset if you want to make the ID patch backport friendly for
distros, but I think we should treat the security related info with
the same importance as the ID info.

> > +struct pidfd_info {
> > +        __u64 request_mask;
> > +        __u32 size;
> > +        uint pid;
>
> The size is unnecessary because it is directly encoded into the ioctl
> command.
>
> > +        uint uid;
> > +        uint gid;
> > +        __u64 cgroupid;
> > +        char security_context[NAME_MAX];
> > +} __packed;
>
> The packed attribute should be unnecessary. The structure should simply
> be correctly padded and should use explicitly sized types:
>
> struct pidfd_info {
>         /* Let userspace request expensive stuff explictly. */
>         __u64 request_mask;
>         /* And let the kernel indicate whether it knows about it. */
>         __u64 result_mask;
>         __u32 pid;
>         __u32 uid;
>         __u32 gid;
>         __u64 cgroup_id;
>         __u32 spare0[1];
> };
>
> I'm not sure what LSM info to be put in there and we can just do it as
> an extension.

See my original response to Luca on October 2nd, you were on the To/CC line=
.

--=20
paul-moore.com

