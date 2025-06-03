Return-Path: <linux-fsdevel+bounces-50510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66AACCD37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613F41748B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E3288CA0;
	Tue,  3 Jun 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHHll8Zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BA1E5B8A;
	Tue,  3 Jun 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976054; cv=none; b=qJmJYD96WKOgxQ++jHe/hczFDPlpbZ3KrEj4XYQrhGUS+tJObNweRHHWEsqklpuBGxbeVrg3cbPS0iw9FVQK6bkn5Mbko5r6iE2jTN/ckM03Jm0BUYfNkrcEnSoz1Ps/30338hs9YJln8W1AFBwhY2EWxPYd65pEv++pn6U8RLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976054; c=relaxed/simple;
	bh=xbDtn2fi3WAJ9480GbfunPJlIeXQH6U2IoiqNVQk5l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFAqr8qmNOGc6vngWG6KPZxAg2IHErHMN3yJFk6WiNG4S3Yww+tNzHCkSR2ph77Uw4Y5YMWDVhtgdIJHtVjRSEmBsklnnP8q4p8psrP84fuCnaYPZCas3L567Mg2ydEhbPsIZFZz5jgA9YdkJ7IpcL3RTxP1pUfE+V/koWplxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHHll8Zz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-745fe311741so6743809b3a.0;
        Tue, 03 Jun 2025 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748976052; x=1749580852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0c5kIgA/yHehlLlbKZmWK2XOT9lH9ivDjxdXwP91u8=;
        b=jHHll8ZzI4FjmfXdsVw21EmDX2A4pK7uHqL34rXEwhVV164oF234OX4kFbJjEc4kO/
         8hIFA5B/3ZW9fwDgmmhJz3k35wpWgnek0lSATurFWzkg146DHfrYt1i7luZI91f6t+ZX
         gOwcH9JCGxD0FrqiBAGY6DYIxDH24tqEcPxR6xeNiZIzpSSkb+66tTD3IGrQ8j0E1Wlx
         kQJT8GencvCpbKvxT03gDAOCt9qmViZU5k81RdewhipK+iAcj4ZxOA7pZnK6k8sRWYoY
         PwL0vvrx1+q/wA3iAfzHKFQddymPAO6n1BvVM8PLJD+BWqWkDqxGghbe4xw7qggWd6HO
         N3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976052; x=1749580852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0c5kIgA/yHehlLlbKZmWK2XOT9lH9ivDjxdXwP91u8=;
        b=wPtPSQGVnli2rTsnHlHeiBuCEiO1ZZKPFomElVTRkB3j9vbCq+tQCTsvAxGvkxdIEl
         QBubj2sGpmsK9QAuS1Y8eFaDWsnE42NgCpjh4dDM/ufrjIwrFzfnXjMSqL5i4Ph7BiY+
         X3XYR/L9DiFOxngK2dCAheEiQ8LpS+xbMBd1sa7YPLt51HyxENMQr49+FclWff3rl4qt
         +G3vlgeXBbeVpISpDCLcd7qnvMr9KXErM6R5snOEhR6KHwHjXj6ql7YUFog7LOD2Swss
         TKe2h/myKP+1i9f4rAhm3qvjRPW0a6T/nwXK2QSAjxSmMa1tEisujUtt95g/bhC3/Xnu
         L/4w==
X-Forwarded-Encrypted: i=1; AJvYcCU7ir5yz769hsfuzgMhPUrOYd7H4D4JL55ajM7l1UPGURsY8QF8rPahI7Kg2P9v0cywNn9HjMg5wZGUHQpD@vger.kernel.org, AJvYcCUBIJ/3S9Om6lZX+YV1Q/jbFLvCuByvMcsTiTlq6nstCYSpcwe5AJhKVstcF5EasNrFljN1DM6zHEx+qWBsX2wx/MXIMort@vger.kernel.org, AJvYcCVdjTxQns2ErAfxclN2VBn6yO7gbC7MLpWQtyfJD6WqM7OT/UlQX4FObplYyT03/jx275Ckorpu4bbGmXsP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VlW4kEN3laIm5zn0SIHIWMpz1C5b276UrGRpd0IKAWFijios
	pSY9hq062RizrH++BXvJT95hkDLx4IqZwtXPwik0RFcFU97e4mhqpeHAWktehBxMPY9+dPE1S84
	2KaYW/2S2dnx+KJNzYPYA6WZHDloUcNE=
X-Gm-Gg: ASbGncsyFl2wWNAQ551XzbvJK0vnhdqcnky392FnZljksTwQEdBqIpsRuVPlCiSJ+kA
	s4+zJsYQQ7uUI84s7Sh1O0PFtTy+Xp0Y6AW/X5699DSja0Yu3zajoGzlcURS5ulKvhDUfiOrCMq
	rcY6KqKwRGDpii+5M0HJPMz5BiCcHr0SO6cWVcJgJ6TwxZrkuhk4RtX9nPKto=
X-Google-Smtp-Source: AGHT+IGwXtJkXZadcITVM3MaJkEh7UElRf0oozLdPIVh/p58yS+6AcfPfaCnbPMtPOWqtgCV0oNF4lVpeFsoiKFlcXY=
X-Received: by 2002:a05:6a00:92a8:b0:746:25d1:b711 with SMTP id
 d2e1a72fcca58-7480b4204f4mr184627b3a.17.1748976051964; Tue, 03 Jun 2025
 11:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
In-Reply-To: <20250603065920.3404510-4-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Jun 2025 11:40:40 -0700
X-Gm-Features: AX0GCFuo51rtttA89KFpmjZLTa4QlZtMgelr7QNzWz69dtsj3Vk94eqK0oBk_L8
Message-ID: <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:59=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Introduce a path iterator, which reliably walk a struct path toward
> the root. This path iterator is based on path_walk_parent. A fixed
> zero'ed root is passed to path_walk_parent(). Therefore, unless the
> user terminates it earlier, the iterator will terminate at the real
> root.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/Makefile    |  1 +
>  kernel/bpf/helpers.c   |  3 +++
>  kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c  |  5 ++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 kernel/bpf/path_iter.c
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 3a335c50e6e3..454a650d934e 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
>  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
>  endif
> +obj-$(CONFIG_BPF_SYSCALL) +=3D path_iter.o
>
>  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b71e428ad936..b190c78e40f6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NE=
XT | KF_RET_NULL | KF_SLEEPAB
>  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPAB=
LE)
>  #endif
>  BTF_ID_FLAGS(func, __bpf_trap)
> +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_S=
LEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE=
)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
> new file mode 100644
> index 000000000000..0d972ec84beb
> --- /dev/null
> +++ b/kernel/bpf/path_iter.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bpf.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +
> +/* open-coded iterator */
> +struct bpf_iter_path {
> +       __u64 __opaque[3];
> +} __aligned(8);
> +
> +struct bpf_iter_path_kern {
> +       struct path path;
> +       __u64 flags;
> +} __aligned(8);
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
> +                                 struct path *start,
> +                                 __u64 flags)
> +{
> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> +       BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
> +
> +       if (flags) {
> +               memset(&kit->path, 0, sizeof(struct path));
> +               return -EINVAL;
> +       }
> +
> +       kit->path =3D *start;
> +       path_get(&kit->path);
> +       kit->flags =3D flags;
> +
> +       return 0;
> +}
> +
> +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
> +{
> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> +       struct path root =3D {};
> +
> +       if (!path_walk_parent(&kit->path, &root))
> +               return NULL;
> +       return &kit->path;
> +}
> +
> +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> +{
> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> +
> +       path_put(&kit->path);

note, destroy() will be called even if construction of iterator fails
or we exhausted iterator. So you need to make sure that you have
bpf_iter_path state where you can detect that there is no path present
and skip path_put().

> +}
> +
> +__bpf_kfunc_end_defs();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7d6e0c5928b..45b45cdfb223 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7036,6 +7036,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>         struct sock *sk;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path) {
> +       struct dentry *dentry;
> +};
> +
>  static bool type_is_rcu(struct bpf_verifier_env *env,
>                         struct bpf_reg_state *reg,
>                         const char *field_name, u32 btf_id)
> @@ -7076,6 +7080,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>                                     const char *field_name, u32 btf_id)
>  {
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct path));
>
>         return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id,
>                                           "__safe_trusted_or_null");
> --
> 2.47.1
>

