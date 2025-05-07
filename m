Return-Path: <linux-fsdevel+bounces-48337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49AAADB1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F9F1C20429
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460D23370A;
	Wed,  7 May 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AawHkf1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199122309B2;
	Wed,  7 May 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608927; cv=none; b=evWOE1aU9aSfulwcnAZs9p2OW7dwxX9Osw6SI9c3cH+LTjTlS8Uw/UVZdpMOqMzPUfGh6BR0OEyEI5nVWI4IB8AG9LZ+bdNhsQpBnyaTFAgJunjycdXjWy7/bxHpoC77NnI6b0kFMqa5J7TELcsFDoG/8DB0RoUHCntOuk7xOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608927; c=relaxed/simple;
	bh=bcDiPz4rwZOGkdYGrLrevc3ngISFokcqcUlpEvXZJME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsAlj49gmRXJ5PD5QX3aCvepcaluo36kvK920dfFIj8ZBzX2KlhoMnR1KzGUSPCX/rdD3RTWzUdKAI5RbclviemLdQxf9TQgAvyuwp59TXwDZm+xbtwgM3nNbfk8r5WRZYYF5ll6sOdlSJja1/b1uUI6crBtulbm/NcD/JaLmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AawHkf1W; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so616418566b.0;
        Wed, 07 May 2025 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746608923; x=1747213723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDNlseJp/i5QCLgbJ7HKyZOKWGPy8tHwHzU0G67jD/4=;
        b=AawHkf1WyXFBUAV81EVXpJtLMnGQq47BnEEtK9tDCIlVfNJf62P4guq3tDHsSOxw+e
         5IiUIKS4HbOlTc9LQTHP0CSh4zMaaiZuCP1/owuvgGzVgvzHEvsbu4/CqudhIX0NcBlQ
         80H06DdMcGuTudtruTSrjedsksr7krFmLiulEI9jtV0X/6FbGBaCxtmcNOgJ8R6DUVB5
         heiHtR35x94WSD3/WUJBW1uGoitHZpmhQ260eKVjaonT1zK3/TjAwX8GCXNdE9phVMH3
         kZ3IjYKz+/xfQcyljGa1lMKjNX9UzD3b4r/OZaKAaix3q8qypeiuKTDpus27vllFuIYG
         aWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746608923; x=1747213723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDNlseJp/i5QCLgbJ7HKyZOKWGPy8tHwHzU0G67jD/4=;
        b=jbxrMWrpcJwzxiUxWXdMqKQz3kOdJSYwqxhPvZapzifwropTIyA+mOnFTfROnCI+wH
         Zutkhx9i0OmJJtejBmDI6TSxY0i/l5/ZfDSRaYqeA/mKUxpNp6kmgB2F7cUGRQkjXVGd
         fS0vYBMY5uVhV5H91J41BoCCUEM6uvLLFWW5JXndxv6CWR+hY0pZePrAhtOgY03IO+RC
         SLShOwA/gt/91+kgumWO2hU3Jvp/aPyzHKd/hzUJmhvaMF+kCAebtxyw65k0+wuQBTWf
         SVFwzLiwmBkKlp2qcIFtu2gUnSVgFkyOMkTae8YYyEaNRAxL3H5Y9AZ3mCAaZM3yyWDB
         Ksvw==
X-Forwarded-Encrypted: i=1; AJvYcCWb4czx3sAapQnORv/8pNQ9a02K+yrw/o5ERubIcEpwxhwON7a02kpS0qujEwhA1vjPIIov6geTJQOcf2SbQw==@vger.kernel.org, AJvYcCXH66SiSpFDgM5lztXwmSMtG1LbzFL5DfSWv4G9n/Y908bdrJoZ1xwMn7AKQMgWnNbN9kLtHxx7FHQzbHw5@vger.kernel.org, AJvYcCXVmq08Vf/bFDsJ1P4n9CJENZ66GP2Jc0PFFVnAstUd3bBFMOhaNXhFW6Hlki0UtzNQ3+8mynlECgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYzA+h98S7XwrOwDR1mlcSwIgUIq+TYs/Y1paYbgBoIP4l8Me
	oEeAU06kbOLXgdm4/DXqNhcyl19fxOVWrrr7c4vHIoY/BuRqxKZAk1GJLYN/mWiO1LmQ9SXmPxk
	TW77Chb18dPoPyyoMM3pgcVM87jiOsK01HgY=
X-Gm-Gg: ASbGncs41HJcwaNd4DfXpvKCwltCwPzOdLvwE79quX54QC/eKpsHbLkJ3zWJNjhh733
	CBAXcQkZcoLKtx7Yvlptra98Yw6Rh/D1FDMr2XH1H0ODy4C3CUIL1bVGIzKuRmA6Vzvi6C21vcT
	1aM1Bd8AtKsxMsIu9L//G2QA==
X-Google-Smtp-Source: AGHT+IHElRaGzJn3jeSjMAmLa+FqMepTIDa3ktAEq2CX3EhC5svkEFhHOJlrSpohJQkGwU/YloXXbBvwiAHdrABu+u0=
X-Received: by 2002:a17:907:6d29:b0:aca:e1ea:c5fc with SMTP id
 a640c23a62f3a-ad1e8c90d98mr251829266b.26.1746608922867; Wed, 07 May 2025
 02:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com> <20250507-fuse-passthrough-doc-v2-2-ae7c0dd8bba6@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v2-2-ae7c0dd8bba6@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 11:08:30 +0200
X-Gm-Features: ATxdqUGYbdTUdaZjQmW-DPcCa4rq11m0Ukjid7lXU4zoa9mjpZ9HxwNDAair8qg
Message-ID: <CAOQ4uxjCSO0Fu4myX9MgDfdR-zEkcsFr7PyUJAU2mEbdksY16Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: filesystems: add fuse-passthrough.rst
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:42=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> Add a documentation about FUSE passthrough.
>
> It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.
>
> Some related discussions:
>
> Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fa=
stmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53=
WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
>

For future reference, those links are usually part of the tail part
(without newline)
but don't worry about it - this can be fixed when applying the patch.

Thanks,
Amir.

> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bernd.schubert@fastmail.fm>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  Documentation/filesystems/fuse-passthrough.rst | 133 +++++++++++++++++++=
++++++
>  Documentation/filesystems/index.rst            |   1 +
>  2 files changed, 134 insertions(+)
>
> diff --git a/Documentation/filesystems/fuse-passthrough.rst b/Documentati=
on/filesystems/fuse-passthrough.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..2b0e7c2da54acde4d48fd91ec=
ece27256c4e04fd
> --- /dev/null
> +++ b/Documentation/filesystems/fuse-passthrough.rst
> @@ -0,0 +1,133 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FUSE Passthrough
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +FUSE (Filesystem in Userspace) passthrough is a feature designed to impr=
ove the
> +performance of FUSE filesystems for I/O operations. Typically, FUSE oper=
ations
> +involve communication between the kernel and a userspace FUSE daemon, wh=
ich can
> +incur overhead. Passthrough allows certain operations on a FUSE file to =
bypass
> +the userspace daemon and be executed directly by the kernel on an underl=
ying
> +"backing file".
> +
> +This is achieved by the FUSE daemon registering a file descriptor (point=
ing to
> +the backing file on a lower filesystem) with the FUSE kernel module. The=
 kernel
> +then receives an identifier (``backing_id``) for this registered backing=
 file.
> +When a FUSE file is subsequently opened, the FUSE daemon can, in its res=
ponse to
> +the ``OPEN`` request, include this ``backing_id`` and set the
> +``FOPEN_PASSTHROUGH`` flag. This establishes a direct link for specific
> +operations.
> +
> +Currently, passthrough is supported for operations like ``read(2)``/``wr=
ite(2)``
> +(via ``read_iter``/``write_iter``), ``splice(2)``, and ``mmap(2)``.
> +
> +Enabling Passthrough
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To use FUSE passthrough:
> +
> +  1. The FUSE filesystem must be compiled with ``CONFIG_FUSE_PASSTHROUGH=
``
> +     enabled.
> +  2. The FUSE daemon, during the ``FUSE_INIT`` handshake, must negotiate=
 the
> +     ``FUSE_PASSTHROUGH`` capability and specify its desired
> +     ``max_stack_depth``.
> +  3. The (privileged) FUSE daemon uses the ``FUSE_DEV_IOC_BACKING_OPEN``=
 ioctl
> +     on its connection file descriptor (e.g., ``/dev/fuse``) to register=
 a
> +     backing file descriptor and obtain a ``backing_id``.
> +  4. When handling an ``OPEN`` or ``CREATE`` request for a FUSE file, th=
e daemon
> +     replies with the ``FOPEN_PASSTHROUGH`` flag set in
> +     ``fuse_open_out::open_flags`` and provides the corresponding ``back=
ing_id``
> +     in ``fuse_open_out::backing_id``.
> +  5. The FUSE daemon should eventually call ``FUSE_DEV_IOC_BACKING_CLOSE=
`` with
> +     the ``backing_id`` to release the kernel's reference to the backing=
 file
> +     when it's no longer needed for passthrough setups.
> +
> +Privilege Requirements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Setting up passthrough functionality currently requires the FUSE daemon =
to
> +possess the ``CAP_SYS_ADMIN`` capability. This requirement stems from se=
veral
> +security and resource management considerations that are actively being
> +discussed and worked on. The primary reasons for this restriction are de=
tailed
> +below.
> +
> +Resource Accounting and Visibility
> +----------------------------------
> +
> +The core mechanism for passthrough involves the FUSE daemon opening a fi=
le
> +descriptor to a backing file and registering it with the FUSE kernel mod=
ule via
> +the ``FUSE_DEV_IOC_BACKING_OPEN`` ioctl. This ioctl returns a ``backing_=
id``
> +associated with a kernel-internal ``struct fuse_backing`` object, which =
holds a
> +reference to the backing ``struct file``.
> +
> +A significant concern arises because the FUSE daemon can close its own f=
ile
> +descriptor to the backing file after registration. The kernel, however, =
will
> +still hold a reference to the ``struct file`` via the ``struct fuse_back=
ing``
> +object as long as it's associated with a ``backing_id`` (or subsequently=
, with
> +an open FUSE file in passthrough mode).
> +
> +This behavior leads to two main issues for unprivileged FUSE daemons:
> +
> +  1. **Invisibility to lsof and other inspection tools**: Once the FUSE
> +     daemon closes its file descriptor, the open backing file held by th=
e kernel
> +     becomes "hidden." Standard tools like ``lsof``, which typically ins=
pect
> +     process file descriptor tables, would not be able to identify that =
this
> +     file is still open by the system on behalf of the FUSE filesystem. =
This
> +     makes it difficult for system administrators to track resource usag=
e or
> +     debug issues related to open files (e.g., preventing unmounts).
> +
> +  2. **Bypassing RLIMIT_NOFILE**: The FUSE daemon process is subject to
> +     resource limits, including the maximum number of open file descript=
ors
> +     (``RLIMIT_NOFILE``). If an unprivileged daemon could register backi=
ng files
> +     and then close its own FDs, it could potentially cause the kernel t=
o hold
> +     an unlimited number of open ``struct file`` references without thes=
e being
> +     accounted against the daemon's ``RLIMIT_NOFILE``. This could lead t=
o a
> +     denial-of-service (DoS) by exhausting system-wide file resources.
> +
> +The ``CAP_SYS_ADMIN`` requirement acts as a safeguard against these issu=
es,
> +restricting this powerful capability to trusted processes.
> +
> +**NOTE**: ``io_uring`` solves this similar issue by exposing its "fixed =
files",
> +which are visible via ``fdinfo`` and accounted under the registering use=
r's
> +``RLIMIT_NOFILE``.
> +
> +Filesystem Stacking and Shutdown Loops
> +--------------------------------------
> +
> +Another concern relates to the potential for creating complex and proble=
matic
> +filesystem stacking scenarios if unprivileged users could set up passthr=
ough.
> +A FUSE passthrough filesystem might use a backing file that resides:
> +
> +  * On the *same* FUSE filesystem.
> +  * On another filesystem (like OverlayFS) which itself might have an up=
per or
> +    lower layer that is a FUSE filesystem.
> +
> +These configurations could create dependency loops, particularly during
> +filesystem shutdown or unmount sequences, leading to deadlocks or system
> +instability. This is conceptually similar to the risks associated with t=
he
> +``LOOP_SET_FD`` ioctl, which also requires ``CAP_SYS_ADMIN``.
> +
> +To mitigate this, FUSE passthrough already incorporates checks based on
> +filesystem stacking depth (``sb->s_stack_depth`` and ``fc->max_stack_dep=
th``).
> +For example, during the ``FUSE_INIT`` handshake, the FUSE daemon can neg=
otiate
> +the ``max_stack_depth`` it supports. When a backing file is registered v=
ia
> +``FUSE_DEV_IOC_BACKING_OPEN``, the kernel checks if the backing file's
> +filesystem stack depth is within the allowed limit.
> +
> +The ``CAP_SYS_ADMIN`` requirement provides an additional layer of securi=
ty,
> +ensuring that only privileged users can create these potentially complex
> +stacking arrangements.
> +
> +General Security Posture
> +------------------------
> +
> +As a general principle for new kernel features that allow userspace to i=
nstruct
> +the kernel to perform direct operations on its behalf based on user-prov=
ided
> +file descriptors, starting with a higher privilege requirement (like
> +``CAP_SYS_ADMIN``) is a conservative and common security practice. This =
allows
> +the feature to be used and tested while further security implications ar=
e
> +evaluated and addressed.
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyst=
ems/index.rst
> index a9cf8e950b15ad68a021d5f214b07f58d752f4e3..2913f4f2e00ccc466563aba56=
92e2f95699cb674 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -99,6 +99,7 @@ Documentation for filesystem implementations.
>     fuse
>     fuse-io
>     fuse-io-uring
> +   fuse-passthrough
>     inotify
>     isofs
>     nilfs2
>
> --
> 2.43.0
>
>

