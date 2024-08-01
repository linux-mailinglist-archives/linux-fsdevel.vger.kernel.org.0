Return-Path: <linux-fsdevel+bounces-24722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA47943FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAE01F22005
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A1153503;
	Thu,  1 Aug 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLq4OmCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F513A275;
	Thu,  1 Aug 2024 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475017; cv=none; b=HvOFNRz9Vcx7RVrdkaKSJu0UQ5BNOkJJkxGNPDMvXZUe3U0JCM8E72Yo54dsU4Rnb7CB12yIdyc7SRVT+HdWgQ2jpGeSeEtkNtkNZMVJOZuxBZ3O+X0a0YVzrrsuTFLm3QLhTrAPUQ+RshupX5BjlT8wjImuuyWwXQzdIIRB4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475017; c=relaxed/simple;
	bh=kHy1i78mdI3vws4u3HQphn8pZpSnvPpB3XrEVPiePaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AddcRBJ9wi7GnVPKQOy1XxPpDIhIaEjHzMR5th1iZir5RMYfmX5z6xIShpxmk6a2c2i6yokDqsVjbzDeFM68VJ651ME2OOybuIgHmCb1sAfoMvizskXTDLrVbwOpbAYQUy5gNVF6wqE5x6uxIU7x3mLhooBnWUGQIXl03UFiFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLq4OmCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EFBC4AF0F;
	Thu,  1 Aug 2024 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475016;
	bh=kHy1i78mdI3vws4u3HQphn8pZpSnvPpB3XrEVPiePaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MLq4OmCpyy1aIFB6f4CJE18C04zccGqtbQSii4pnbATNB9Q8UALA+AhZ/xRQhNjAk
	 0odnJfMv2OFYrxxxKN3fV39cKVqTTy1JClh7VYiHMAezpj5jN+U2Gd8BkswB4QrXDV
	 j5EXL25eTIm//xshNmViftVEYtgac9HvX75tyPEr7zG0/1HHY7WtdrjR+P4KjQZqC8
	 XSSp2Uk6x3dcEnMF7DRTcN2y+kVI1+oymPOQjcf7iz869qrlic006jShJDlsys4TSD
	 EFuAWheO1/CVVfLZ0DIj3cmnK0gNGwmJKUQHT5ze+zLpc+Qgv/UPVpJfM+s8kTAaL4
	 xwduJmFgCNYCw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efef496ccso1563422e87.1;
        Wed, 31 Jul 2024 18:16:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjq5RMwhTfhpT+ccZCWPGgmYYpzeWRmn+toJG38nYhpUa+ifvIN5OmoUj8NK7Re9qe4GOa7wn75ljgJxrk5zrA+PYtTPGua20LAK+rLg==
X-Gm-Message-State: AOJu0YzbcGSlEWBY8GKARlZ/y7wA7NfrL+9OqovKQQPxwOqRCG7uhMYG
	hUqc5ZcKLDw2/gCr4h4UuGMl6SurprFngFMvayNcJ9xJRTp1NklX+bpEskDBxUqzeO/UWS78J/n
	iueSkS7zYmlMpM5SRTiF+HCNpyy8=
X-Google-Smtp-Source: AGHT+IEZ0yorHzcGRLCxIg5m4JwdNAfDf+fdzJ8QbxM7N78krt4wkpey6mor7aiYatRoyxMmM4/sacvizoURof7W9uQ=
X-Received: by 2002:a05:6512:32d0:b0:52e:8161:4ce6 with SMTP id
 2adb3069b0e04-530b5f2e727mr216353e87.25.1722475014958; Wed, 31 Jul 2024
 18:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731110833.1834742-1-mattbobrowski@google.com> <20240731110833.1834742-2-mattbobrowski@google.com>
In-Reply-To: <20240731110833.1834742-2-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 31 Jul 2024 18:16:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW69Y2+UmieROek+dP0cjYEL2x0XBVYp06yCwZtQNHS4xA@mail.gmail.com>
Message-ID: <CAPhsuW69Y2+UmieROek+dP0cjYEL2x0XBVYp06yCwZtQNHS4xA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, 
	jannh@google.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:09=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
> the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
> its arguments.
>
> This new d_path() based BPF kfunc variant is intended to address the
> legacy bpf_d_path() BPF helper's susceptability to memory corruption
> issues [0, 1, 2] by ensuring to only operate on supplied arguments
> which are deemed trusted by the BPF verifier. Typically, this means
> that only pointers to a struct path which have been referenced counted
> may be supplied.
>
> In addition to the new bpf_path_d_path() BPF kfunc, we also add a
> KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
> counterpart BPF kfunc bpf_put_file(). This is so that the new
> bpf_path_d_path() BPF kfunc can be used more flexibily from within the
> context of a BPF LSM program. It's rather common to ascertain the
> backing executable file for the calling process by performing the
> following walk current->mm->exe_file while instrumenting a given
> operation from the context of the BPF LSM program. However, walking
> current->mm->exe_file directly is never deemed to be OK, and doing so
> from both inside and outside of BPF LSM program context should be
> considered as a bug. Using bpf_get_task_exe_file() and in turn
> bpf_put_file() will allow BPF LSM programs to reliably get and put
> references to current->mm->exe_file.
>
> As of now, all the newly introduced BPF kfuncs within this patch are
> limited to BPF LSM program types. These can be either sleepable or
> non-sleepable variants of BPF LSM program types.
>
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=3DQxU-jtCUfb5xQb3mLr=3D5Fcw=
ddF_VKfEBPs_Dg@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com=
/
>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Song Liu <song@kernel.org>

with one nitpic below

> ---
>  fs/Makefile        |   1 +
>  fs/bpf_fs_kfuncs.c | 127 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 fs/bpf_fs_kfuncs.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 6ecc9b0a53f2..61679fd587b7 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)             +=3D efivarfs/
>  obj-$(CONFIG_EROFS_FS)         +=3D erofs/
>  obj-$(CONFIG_VBOXSF_FS)                +=3D vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)                +=3D zonefs/
> +obj-$(CONFIG_BPF_LSM)          +=3D bpf_fs_kfuncs.o
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> new file mode 100644
> index 000000000000..2a66331d8921
> --- /dev/null
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dcache.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/path.h>
> +#include <linux/sched.h>

It appears we don't need to include all these headers. With my
daily config, #include <linux/bpf.h> alone is sufficient.

Thanks,
Song

