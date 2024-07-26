Return-Path: <linux-fsdevel+bounces-24350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639C93DB2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98941C231E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5EB14EC62;
	Fri, 26 Jul 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWEveQjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6117BDC;
	Fri, 26 Jul 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037127; cv=none; b=fPB/Fc8FxoTpx6ALVbYdWaCgKFjH4PhWjuGq81FC8ZzyJ3nDCx+nrHiR6/+6bjXejfNpcIBfW7BeFqeJJXLkgqtikCvX4dJFSkm1FPyxT2o2dVYFUlvoN57vNMMe9XWgpNpGehFcbmiEkvxcEUZjoJgHQRjaz+XwJgTaDO/a+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037127; c=relaxed/simple;
	bh=t/yIZ6GSPlMUNQDpTzVaLIsFxByjilsUe+vf1/dX/2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqke6Nl+TVjCjf0kxdfBRAljO4/UiMMtFLjmh2VeOcJY1nENkFOr/m1O+iqfwb+rc4waJpoQD7ytRvCx8VSQk+p+mXnEe12s50jXOqTzKaZXgnd98dgH0kRAEo5R+tcgQG96q4NBIXvlimJGB7/uwxxKviAjLdomFosygZHetxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWEveQjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3886DC32782;
	Fri, 26 Jul 2024 23:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722037126;
	bh=t/yIZ6GSPlMUNQDpTzVaLIsFxByjilsUe+vf1/dX/2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MWEveQjGr5piIvpzT4nrQZUheh6p/8vlJI8QSTGBKcgJgfMsK/dKn6ZogaRW+mhpM
	 fepGRTiZkzk7+Sn88D+GkrmpLV4OtXLhTSZy+XiOLogFo5pGrZ2QzJqC5eIAXzokL8
	 ePV61JvSrpXMwaHh8vA0Sqpm54dO0lYijuaSU6QLxyQ+JDcgEDGeSv4lUFB/n27lUN
	 SdnnuzD9N+NJlQcYbMCV9e+imYQ/XvSf5lViQ9XSYbNZj0PsmDfzYrq5m9a2Ymf91n
	 h1/EJuNjGlyvR2mIbYj1ezqJVY+vF/j0n6o2CSMLXBdImOV924oRWP3lkggYyGtgky
	 PWKy5yFPtKJaQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so24581431fa.1;
        Fri, 26 Jul 2024 16:38:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmTIYEJr4QpqKQqmv1eThLxl3LdonGc1Y4qvfnypXIJ9wcMKw3+JCX+touzj3HsuuYr96empAgxsPja8wG3xz5UjYexJXdBOMzzQXdNw==
X-Gm-Message-State: AOJu0YyrR+j6zWwgSfun6yrLIR5SvDSvWB5BigYqnMVhlLsmHpnxi2/o
	yLil4/Jdd1judiG0GlFUC/D7axuPvzlg8b0rvm7UXVQAWpJmaZoSYTIzuAZJrOmmFtRPQFjjG1e
	f4jYjUokCRhxb9GeSlO8kQa7s05E=
X-Google-Smtp-Source: AGHT+IGGUP71p98R3WQBbhOpMHrbBswEoTbDYTRBR3LXr3GxOCtozio6IKP8yEunfwtA1QYfATMEpC1UVxc7DpZawVw=
X-Received: by 2002:a19:690b:0:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-5309b2a9f7dmr881650e87.36.1722037124556; Fri, 26 Jul 2024
 16:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726085604.2369469-3-mattbobrowski@google.com>
In-Reply-To: <20240726085604.2369469-3-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Jul 2024 16:38:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Ty7rkjdwCPBWDfkhWY2+5uofnjm5yM=EypTKVSzyePw@mail.gmail.com>
Message-ID: <CAPhsuW4Ty7rkjdwCPBWDfkhWY2+5uofnjm5yM=EypTKVSzyePw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] selftests/bpf: add negative tests for new
 VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, 
	jannh@google.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:56=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Add a bunch of negative selftests responsible for asserting that the
> BPF verifier successfully rejects a BPF program load when the
> underlying BPF program misuses one of the newly introduced VFS based
> BPF kfuncs.

Negative tests are great. Thanks for adding them.

A few nitpicks below.

[...]

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 828556cdc2f0..8a1ed62b4ed1 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -195,6 +195,32 @@ extern void bpf_iter_task_vma_destroy(struct bpf_ite=
r_task_vma *it) __ksym;
>   */
>  extern void bpf_throw(u64 cookie) __ksym;
>
> +/* Description
> + *     Acquire a reference on the exe_file member field belonging to the
> + *     mm_struct that is nested within the supplied task_struct. The sup=
plied
> + *     task_struct must be trusted/referenced.
> + * Returns
> + *     A referenced file pointer pointing to the exe_file member field o=
f the
> + *     mm_struct nested in the supplied task_struct, or NULL.
> + */
> +extern struct file *bpf_get_task_exe_file(struct task_struct *task) __ks=
ym;
> +
> +/* Description
> + *     Release a reference on the supplied file. The supplied file must =
be
> + *     trusted/referenced.

Probably replace "trusted/referenced" with "acquired".

> + */
> +extern void bpf_put_file(struct file *file) __ksym;
> +
> +/* Description
> + *     Resolve a pathname for the supplied path and store it in the supp=
lied
> + *     buffer. The supplied path must be trusted/referenced.
> + * Returns
> + *     A positive integer corresponding to the length of the resolved pa=
thname,
> + *     including the NULL termination character, stored in the supplied
> + *     buffer. On error, a negative integer is returned.
> + */
> +extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)=
 __ksym;
> +

In my environment, we already have these declarations in vmlinux.h.
So maybe we don't need to add them manually?


>  /* This macro must be used to mark the exception callback corresponding =
to the
>   * main program. For example:
>   *
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 67a49d12472c..14d74ba2188e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -85,6 +85,7 @@
>  #include "verifier_value_or_null.skel.h"
>  #include "verifier_value_ptr_arith.skel.h"
>  #include "verifier_var_off.skel.h"
> +#include "verifier_vfs_reject.skel.h"
>  #include "verifier_xadd.skel.h"
>  #include "verifier_xdp.skel.h"
>  #include "verifier_xdp_direct_packet_access.skel.h"
> @@ -205,6 +206,7 @@ void test_verifier_value(void)                { RUN(v=
erifier_value); }
>  void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illeg=
al_alu); }
>  void test_verifier_value_or_null(void)        { RUN(verifier_value_or_nu=
ll); }
>  void test_verifier_var_off(void)              { RUN(verifier_var_off); }
> +void test_verifier_vfs_reject(void)          { RUN(verifier_vfs_reject);=
 }
>  void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
>  void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
>  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_dir=
ect_packet_access); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/to=
ols/testing/selftests/bpf/progs/verifier_vfs_reject.c
> new file mode 100644
> index 000000000000..27666a8ef78a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <linux/limits.h>
> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +static char buf[PATH_MAX];
> +
> +SEC("lsm.s/file_open")
> +__failure __msg("Possibly NULL pointer passed to trusted arg0")
> +int BPF_PROG(get_task_exe_file_kfunc_null)
> +{
> +       struct file *acquired;
> +
> +       /* Can't pass a NULL pointer to bpf_get_task_exe_file(). */
> +       acquired =3D bpf_get_task_exe_file(NULL);
> +       if (!acquired)
> +               return 0;
> +
> +       bpf_put_file(acquired);
> +       return 0;
> +}
> +
> +SEC("lsm.s/inode_getxattr")
> +__failure __msg("arg#0 pointer type STRUCT task_struct must point to sca=
lar, or struct with scalar")
> +int BPF_PROG(get_task_exe_file_kfunc_fp)
> +{
> +       u64 x;
> +       struct file *acquired;
> +       struct task_struct *fp;

"fp" is a weird name for a task_struct pointer.

Other than these:

Acked-by: Song Liu <song@kernel.org>

> +
> +       fp =3D (struct task_struct *)&x;
> +       /* Can't pass random frame pointer to bpf_get_task_exe_file(). */
> +       acquired =3D bpf_get_task_exe_file(fp);
> +       if (!acquired)
> +               return 0;
> +
> +       bpf_put_file(acquired);
> +       return 0;
> +}
> +
[...]

