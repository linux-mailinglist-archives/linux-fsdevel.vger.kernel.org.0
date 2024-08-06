Return-Path: <linux-fsdevel+bounces-25146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67994967B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ABF1C22D68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69853482E2;
	Tue,  6 Aug 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7LCt/pK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192582A1D3;
	Tue,  6 Aug 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964592; cv=none; b=QyYuUKDmgMlhzxcuIeJ7j7/WzzOxNNM0ucdMMyZTdzntNunUTax4nWfU/e4rlgxW5zYQK+H5czYCDCsaAi4+iRjyO6wTPP0f0RvTMXWTrIMy6rwuG+rBj7ajokY07Zi8mifJ7Cw2eRqlNTicpgCPuyCEoe32eAJ3iqZGC+wUoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964592; c=relaxed/simple;
	bh=PEETIci6hUduaM8hNub+xJEHnlXgc5vOZkcX5XlaWd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhuII7LClDa5v52pm7ZjD7BigDQnfnk1BYqdGUVnrkCXV+5DsqGS9LY7OusUmyuGG9TrRsyOA0nqS1ZXUpADgqXJvvx1k3q+piM8bSc0C2Qi5fQ9Ao64A7+4I0TGKk4wlAavtPbuZHbWKs1yQDOlF9nfGvnQgmlCA/6JRti8dWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7LCt/pK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f16767830dso10026931fa.0;
        Tue, 06 Aug 2024 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964589; x=1723569389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sCtlrfFx1xhGzgLdvWohx3gPpnZHRqBbQohEVU2h6E=;
        b=K7LCt/pKms+r3eB8BR8h7DZiMWLgqd8ig2libB3kmy/9F6Dld9ltovETCxh6f5s//U
         vUsf9aHfGqqRetNUtWQwXFiOASsS9pmZiW2chRmyUry6xfhOIw2hXg9MTtxNKizC5icG
         humsXT55lqJZuasCV+FpyHMUXymG0s/t8ITSOU+JdcvNoFSQWfa5rlD6RQIt7ynh5N8x
         9j58d3hrdgzOXqYpC43dXj53m1dOfevFS29U/H81huHcBfL8/wxZFFtKdyfHtwyEVQ1a
         vbzo5qqhkv8XtR1UCE6Y576rJ05rvKU3AKAmb2IAdtpoh/ZDevr80OAtmpcLIyKLQ1My
         tk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964589; x=1723569389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sCtlrfFx1xhGzgLdvWohx3gPpnZHRqBbQohEVU2h6E=;
        b=kB7ruV6iKKA3dnA4otVLRgq1ZIMQnS1fKOA0D+JWFrgWkVHrcW+mwAaWwDA75rt6w7
         9lYqzOojw58cs+gNxHl52brtvI4hHimcgRKDkpbNx/CP1x4DT3Rk1fp2eP2uJWdY0ZaE
         7N157s9QaSQhgTPM7NxUXPg532Ux5PnzA6OVQrWFphZrW5dFPNC0ln/nzPM/3YmkJ/98
         Inew0/c3ol2BcM+JAvotM9bAQnbFtL5IIXIWOfDB1QEJKmpMr65ot8oyVY0TWoqTDA6F
         rauPTTswQsOcYAMCLxzbv3HNVvfK9ztxqDieedR8sqsCy6eOzAjbOCa8450V4396fhGM
         NzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsRJQtg56DdSgPWqAaRz6TSZuamuhvSSSPqUlhvBjfxHqeubn5UjA4dTrsQkYzEEPh7iRgopu6MSo2C3ZCReJE8TOry525x7zzcO1a/bGE6rWCY0TlU26pQ2T9z/LvpAxXQwFGALoHpZqvQQ==
X-Gm-Message-State: AOJu0Yz2X6k24cGOAmzLlX1WbeLX+PsqXY23wpPdrzxx7Vt2F7SDeV1N
	HTeQ+BlPzgmzD0Suot/dF+VL8JdYPxQ8JODB1DJHEGFxiKIblA8nQPYNe9rZoTzGwYBDOyyOG6d
	SGqO/eCJs5vozKQ9Knet681lH71cA4KM8
X-Google-Smtp-Source: AGHT+IHtr+C20+PJjskNV4xHqS1/kkkgmJu5MYIN14r+C/ilL+cKyXGQMxKVuKfBSiLXv0qQfEbvZSJwHE3m4+dY7LE=
X-Received: by 2002:a2e:984d:0:b0:2ef:2c2d:a603 with SMTP id
 38308e7fff4ca-2f15aaa70cbmr103338871fa.21.1722964588567; Tue, 06 Aug 2024
 10:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730230805.42205-1-song@kernel.org> <20240730230805.42205-3-song@kernel.org>
In-Reply-To: <20240730230805.42205-3-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Aug 2024 10:16:17 -0700
Message-ID: <CAADnVQJJcJsBk9nR5_gTWNmgQGjNi1BJWCex4XZVB=w9ybsOzA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for bpf_get_dentry_xattr
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	liamwisehart@meta.com, lltang@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:08=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add test for bpf_get_dentry_xattr on hook security_inode_getxattr.
> Verify that the kfunc can read the xattr. Also test failing getxattr
> from user space by returning non-zero from the LSM bpf program.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++++-
>  .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++++++++++---
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> index 37056ba73847..5a0b51157451 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> @@ -16,6 +16,7 @@ static void test_xattr(void)
>  {
>         struct test_get_xattr *skel =3D NULL;
>         int fd =3D -1, err;
> +       int v[32];
>
>         fd =3D open(testfile, O_CREAT | O_RDONLY, 0644);
>         if (!ASSERT_GE(fd, 0, "create_file"))
> @@ -50,7 +51,13 @@ static void test_xattr(void)
>         if (!ASSERT_GE(fd, 0, "open_file"))
>                 goto out;
>
> -       ASSERT_EQ(skel->bss->found_xattr, 1, "found_xattr");
> +       ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_=
file");
> +
> +       /* Trigger security_inode_getxattr */
> +       err =3D getxattr(testfile, "user.kfuncs", v, sizeof(v));
> +       ASSERT_EQ(err, -1, "getxattr_return");
> +       ASSERT_EQ(errno, EINVAL, "getxattr_errno");
> +       ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_fro=
m_dentry");
>
>  out:
>         close(fd);
> diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/t=
esting/selftests/bpf/progs/test_get_xattr.c
> index 7eb2a4e5a3e5..66e737720f7c 100644
> --- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>
>  #include "vmlinux.h"
> +#include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_kfuncs.h"
> @@ -9,10 +10,12 @@
>  char _license[] SEC("license") =3D "GPL";
>
>  __u32 monitored_pid;
> -__u32 found_xattr;
> +__u32 found_xattr_from_file;
> +__u32 found_xattr_from_dentry;
>
>  static const char expected_value[] =3D "hello";
> -char value[32];
> +char value1[32];
> +char value2[32];
>
>  SEC("lsm.s/file_open")
>  int BPF_PROG(test_file_open, struct file *f)
> @@ -25,13 +28,37 @@ int BPF_PROG(test_file_open, struct file *f)
>         if (pid !=3D monitored_pid)
>                 return 0;
>
> -       bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> +       bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
>
>         ret =3D bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
>         if (ret !=3D sizeof(expected_value))
>                 return 0;
> -       if (bpf_strncmp(value, ret, expected_value))
> +       if (bpf_strncmp(value1, ret, expected_value))
>                 return 0;
> -       found_xattr =3D 1;
> +       found_xattr_from_file =3D 1;
>         return 0;
>  }
> +
> +SEC("lsm.s/inode_getxattr")
> +int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
> +{
> +       struct bpf_dynptr value_ptr;
> +       __u32 pid;
> +       int ret;
> +
> +       pid =3D bpf_get_current_pid_tgid() >> 32;
> +       if (pid !=3D monitored_pid)
> +               return 0;
> +
> +       bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
> +
> +       ret =3D bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);

Song,

See CI failure on s390.
I think you need to update bpf_kfuncs.h, since s390 doesn't emit
kfuncs into vmlinux.h

Also pls add a patch to move these kfuncs to fs/bpf_fs_kfuncs.c

pw-bot: cr

