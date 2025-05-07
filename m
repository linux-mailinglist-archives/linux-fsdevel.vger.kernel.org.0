Return-Path: <linux-fsdevel+bounces-48332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000EAAD9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F84E466C89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B009221540;
	Wed,  7 May 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFsk8/wO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537772610;
	Wed,  7 May 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605852; cv=none; b=F/UQlNHS3/ZQqcakvtQTZPXaHvtEQK2Kk+kDrzL7fLeo73SxcaPE4y/JT1r9F9hNmvyZ0WM0Im391NdVGCSY9fnNYQOEB7ehrAyl/6JcXfIBdD+IWwo8cz+WDIyLDcr+SYDR9FckgkixDKCzLPNt4deu9aSVRJi7IhZjk0kyGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605852; c=relaxed/simple;
	bh=D6cma0vL5Rh++cxTISOfBfgLFkFrX0+2TyTGVxq8doY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ+CWhpdV77upQ3Hbl88GpdgUIkPym0DK6g0l8A2oNUrK/xpldswTHynQU6HXiV1zygZ0QXRgj7Gb/i+kYg9imI5mYE68t7PioK4opa7y1/HXF31L6d3gGnw5YZIAQAyGYSu36q5OldQTDaVLLY8bC+gwhfvXDoaP9QP9lCI4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFsk8/wO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso382132966b.2;
        Wed, 07 May 2025 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746605849; x=1747210649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOcMtx4PKUVaz+M3wsOZw+iCH7Jjj2//niizegtMkcE=;
        b=gFsk8/wOcyPDH4lGf+KVwajItQ3HN5ZXDMDvBeimkCupnkVYe28+o0WCpJw8BW02bp
         shfsh8O1V0SJ4+KdAOR7b/xYs6BfIivne9u26ZUySL9pBFBuwcIWfn+Y5xbUMWi6XfVx
         7PUJZHuhw2wNlkMttFlX40l/knPKZ9+jKvupyCYC/9KIJMs5TeLX/XBcBcfIy+sUFkRJ
         fZv2/TH9gvzklUHYyPNUb037OnrUJ23FBagdAJ8J9Rpor/VgpiAYFLZFFqOCI0k4bNK4
         GJQij1xWyE6k4V27S8hBmf05k4iuzCIaGyK6Qbmud2qXS5Sy6IbIqH3KWMTlzrSnjeRs
         q7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746605849; x=1747210649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOcMtx4PKUVaz+M3wsOZw+iCH7Jjj2//niizegtMkcE=;
        b=BDP2civUgIXZpkETmcXIH4X1Rcgw2vJ16EjLJIpq8r3Wb43u5ZKG77B58lqJostpBr
         YveuR5WMswRw07FzeMdvWW5Su0h4mfwz6irg4cF0s6xMs5XLx4PbUjYY2hPnMA9h2lJ1
         IkRuaj+QHPjimsEkHo56ELXSaleKWE+yXDimvO2/RNon313LRN4dvfE4nPYIJXNTUZ2O
         5Keyqu/AyrTmUBdhPvYBuNZeTvbU1LGBGxMLQzxZJZVPuB1ebO2D5QJ1zfmviDOk9uQV
         xGnfw95DA1/oEuvtoMz8l3HPpdgIOH3I6QXKQ19PTRPTaXcmg+lh5B1NyhzLUEzINaVZ
         To3g==
X-Forwarded-Encrypted: i=1; AJvYcCUfsSDgdMYY62o2m5h7ixNzky7qLIGK1pyebczo6U0aQzBECecgIQuni6miguchDCaHkm5q85t/H+4=@vger.kernel.org, AJvYcCWWZ6s4aMO8jnZU+jtqnRwMFHP9ZcZ1D2RbJc2uQrxlab9EYg87ecOUj2lxjxEyksk2clHxBQ0bl5oTy5Osiw==@vger.kernel.org, AJvYcCWv8liTopLTboDdSfad9LCNx9YYTz/049BzGWE8LrRMer9eQMs4ARhxUGkelNEkg7UJLV2eO3W31OY4S4XQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJz89EHO5t8nsNUN7jK4kxDPX/ssw23MMd+nhI3UTkh4adryz
	AMiwAYPQvoD1dcKCDmjR1hIi3baHvHofwB6WyUIPZtSR19GH0Q1ywXa26G/4GOW/PtFADLpT1QK
	lbyfTLKRSBWfTl2iKiBdputsE2Ic=
X-Gm-Gg: ASbGncvNzWZgJH2LIiZkES2ZxB0ylkprEyZgddysrr12lUqv0QH7sux6Siufq2ko9dS
	AsfTw9SRqkdOz3mlv1TXLHTVeeI2gvzLyjMHZTQ2c3wd6PMfv7zOYREiY2ORdEjnhoVQsZYFQFG
	j3UK75fPyyoNLUn4B+2tOIyQ==
X-Google-Smtp-Source: AGHT+IEfs45lPNRVqQHY2iwgcFacb4wwkFr/FyO7PqYkYoFsuhzG2N8Ws7XweyERkxOoE/M8hr02Okqc+a42TOIBIdI=
X-Received: by 2002:a17:907:2ce6:b0:ac7:b8d0:86c0 with SMTP id
 a640c23a62f3a-ad1e8b936c7mr243471066b.9.1746605848173; Wed, 07 May 2025
 01:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com> <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 10:17:16 +0200
X-Gm-Features: ATxdqUEQ2Or9YyhH4VDoUQ9y0QC0t57LMgOREmqSDmj948giV1S36Qp1iLWvIUw
Message-ID: <CAOQ4uxiMh+3JqzqMbK+HpFt-hWaM6A2nW3UHNK9nNntDRkRBeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: filesystems: add fuse-passthrough.rst
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:17=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> Add a documentation about FUSE passthrough.
>
> It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.
>

Hi Chen,

Thank you for this contribution!

Very good summary.
with minor nits below fix you may add to both patches:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bernd.schubert@fastmail.fm>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  Documentation/filesystems/fuse-passthrough.rst | 139 +++++++++++++++++++=
++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/Documentation/filesystems/fuse-passthrough.rst b/Documentati=
on/filesystems/fuse-passthrough.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..f7c3b3ac08c255906ed7c9092=
29107ff15cdb223
> --- /dev/null
> +++ b/Documentation/filesystems/fuse-passthrough.rst
> @@ -0,0 +1,139 @@
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
> +introduce overhead. Passthrough allows certain operations on a FUSE file=
 to
> +bypass the userspace daemon and be executed directly by the kernel on an
> +underlying "backing file".
> +
> +This is achieved by the FUSE daemon registering a file descriptor (point=
ing to
> +the backing file on a lower filesystem) with the FUSE kernel module. The=
 kernel
> +then receives an identifier (`backing_id`) for this registered backing f=
ile.
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

> As noted in the
> +kernel code (``fs/fuse/passthrough.c`` in ``fuse_backing_open()``):

As Bagas commented, I don't see the need to reference comments in the code
here.

> +
> +Discussions suggest that exposing information about these backing files,=
 perhaps
> +through a dedicated interface under ``/sys/fs/fuse/connections/``, could=
 be a
> +step towards relaxing this capability. This would be analogous to how

I am not sure this is helpful to have this "maybe this is how we will solve=
 it"
documented here.
the idea was to document the concerns and the reasons for CAP_SYS_ADMIN.
Now that you documented them, you can work on the solution and document
the solution here.

> +``io_uring`` exposes its "fixed files", which are also visible via ``fdi=
nfo``
> +and accounted under the registering user's ``RLIMIT_NOFILE``.

If you want, you can leave this as a NOTE about how io_uring solves a
similar issue.

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

> As Amir Goldstein mentioned in one of the discussions,
> +there was "no proof that this is the only potential security risk" when =
the
> +initial privilege checks were put in place.
> +

I don't think that referencing those discussions is useful.
They are too messy. The idea of the doc is clarity.
It's fine to have Link: in the commit message tail for git history sake.

You could instead write that a documented security model
is needed before CAP_SYS_ADMIN can be relaxed.
or add nothing at all, because you already documented the concerns.

Thanks,
Amir.

