Return-Path: <linux-fsdevel+bounces-50518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C156ACCEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA953A5964
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92692253EA;
	Tue,  3 Jun 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOyl7ZXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804C213237;
	Tue,  3 Jun 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985025; cv=none; b=B4gVTA3oMxfliONA8RevWZqHsNc+KNsXhhc5Y38OHwSpcevPIXZ3Ozz4aE/hTAmDe2sgNN+B7UZENwDcoqnbLlxD+iSAGePMz7DwNPWmZRAyt0MlfzC/OhU1ebHHBAcJ51JVxntB9yguiaToaCNnYmc2OVwSkgQ+QGWwugKbu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985025; c=relaxed/simple;
	bh=h3cLuoEUE/50Te7YWq29TTae1E9++w3W5acEVIN3myM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyAirw89tj2uyQ3gu/80595f5Vq2E6q8r6NI8DHM+Az9HY4mgyS1dLsLQRJ9U4WfJ0272dexJ3XIMdeRWpK5kYF6UD6HCAldsbFN2LgbFKhzIAp85f52sk6bEAML6ZhO9x8XPeHr1RTMSgMeIYXeKT74Gkx3J4eFtcX9DCqQi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOyl7ZXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25C2C4CEF7;
	Tue,  3 Jun 2025 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985024;
	bh=h3cLuoEUE/50Te7YWq29TTae1E9++w3W5acEVIN3myM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOyl7ZXaStbHPEZDd/Yi0y1gznEJwQlhPSJPB20fSbT5ukqZy8D6nInyNGGXu3obs
	 IHt1MIZSqCb5omRkViky88mEl8GzDwsQkK+65SuaFdjRBLlkCijLNVawiop92uwyuq
	 ZzgJqYotkJr1quBCMbjHSrU5NzNhVDAd3huh5Nq3XMB01wIqx7sPylMk+pNF8PmU3s
	 xKHrlXDUNbnG4DZ49lniwAyMp0YgUwAkZ8CpS3ZFWpldc5S3QtIQftyFFkmbpVyI5/
	 sk7Kp1zc5/h+OExDij2jO4pC+SSktihnV/j4hBC0eyLXo+E6MOO0Da4HcMlwD9Gm9q
	 mtx7dpgxsGu1w==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fac7147cb8so120403266d6.1;
        Tue, 03 Jun 2025 14:10:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqLUPRsLN93QWvxDL0BwYHuJ+nXBraGCfZ6OJOJHAHJ8g/NOh4k/b0jB8czZ1vqRpB7OPRNDsQK8jQRSfDm3pKAmuggJcV@vger.kernel.org, AJvYcCVD9K8qhlN2i0bsU7RZWhVhqazIfIikG2Csmbec+pbM1+Fzj5ESzrLd2F/B/KAPTPNbqVKNf2Tyv3gyLomnNQ==@vger.kernel.org, AJvYcCVozB8Dza3br/AM7d4uewrA1uOFaEoPZDC6OY7wZyapScTHN5Nj7v5TeXrPUt7m5DVUH4+pl0kZfWz30SQS@vger.kernel.org, AJvYcCWP0uNwW7RBEFRfhN2dz0EA/QT9d9tT06qXr8rZ55Ur5DgVwfuRhCK1TSFZF7MBq6gf+kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztp/W2KSMwylp4dNxrY1xLHiiRgrQ9dVHlWRSV+PjzVyuO7cEk
	oxLaGmNckl9qfCSVPWcbd8j13alKhdV7IWLM24talrUFThJnxbhe6eCU5eZ32TRpjjAoS/NQSGT
	W9HlDOWDORls8TJeQCnFYc/0kDMvaUhk=
X-Google-Smtp-Source: AGHT+IHDFIMs4lgEgDBnBmdvP8vxeRYYAbWlPwSRwDiLT24Tw0T9unW3nE6fwnkvsPCrU9dlUaWuNS35Ygi2bxvBNck=
X-Received: by 2002:ad4:4ee9:0:b0:6fa:c41e:ccee with SMTP id
 6a1803df08f44-6faf7007ae8mr4967716d6.19.1748985023786; Tue, 03 Jun 2025
 14:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <CAEf4BzasOmqHDnuKd7LCT_FEBVMuJxmVNgvs52y5=qLd1bB=rg@mail.gmail.com> <4c60e0e4-0bb8-4ae4-b7c3-f29af926f6a0@linux.dev>
In-Reply-To: <4c60e0e4-0bb8-4ae4-b7c3-f29af926f6a0@linux.dev>
From: Song Liu <song@kernel.org>
Date: Tue, 3 Jun 2025 14:10:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5QVDST2xr56BnffqELh2WEBG_BVtXbzAfro3dK9DSDzQ@mail.gmail.com>
X-Gm-Features: AX0GCFs_vq_fD1nD7Nw313IhvEwydQmcKGRWy-PS7EzuprNqQJSP3Kd3DRdDuOQ
Message-ID: <CAPhsuW5QVDST2xr56BnffqELh2WEBG_BVtXbzAfro3dK9DSDzQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 1:50=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 6/3/25 11:40 AM, Andrii Nakryiko wrote:
> > On Mon, Jun 2, 2025 at 11:59=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >> Introduce a path iterator, which reliably walk a struct path toward
> >> the root. This path iterator is based on path_walk_parent. A fixed
> >> zero'ed root is passed to path_walk_parent(). Therefore, unless the
> >> user terminates it earlier, the iterator will terminate at the real
> >> root.
> >>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >>   kernel/bpf/Makefile    |  1 +
> >>   kernel/bpf/helpers.c   |  3 +++
> >>   kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++=
++
> >>   kernel/bpf/verifier.c  |  5 ++++
> >>   4 files changed, 67 insertions(+)
> >>   create mode 100644 kernel/bpf/path_iter.c
> >>
> >> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> >> index 3a335c50e6e3..454a650d934e 100644
> >> --- a/kernel/bpf/Makefile
> >> +++ b/kernel/bpf/Makefile
> >> @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> >>   ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> >>   obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> >>   endif
> >> +obj-$(CONFIG_BPF_SYSCALL) +=3D path_iter.o
> >>
> >>   CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >>   CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index b71e428ad936..b190c78e40f6 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER=
_NEXT | KF_RET_NULL | KF_SLEEPAB
> >>   BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
> >>   #endif
> >>   BTF_ID_FLAGS(func, __bpf_trap)
> >> +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | K=
F_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPA=
BLE)
> >>   BTF_KFUNCS_END(common_btf_ids)
> >>
> >>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
> >> new file mode 100644
> >> index 000000000000..0d972ec84beb
> >> --- /dev/null
> >> +++ b/kernel/bpf/path_iter.c
> >> @@ -0,0 +1,58 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> >> +#include <linux/bpf.h>
> >> +#include <linux/bpf_mem_alloc.h>
> >> +#include <linux/namei.h>
> >> +#include <linux/path.h>
> >> +
> >> +/* open-coded iterator */
> >> +struct bpf_iter_path {
> >> +       __u64 __opaque[3];
> >> +} __aligned(8);
> >> +
> >> +struct bpf_iter_path_kern {
> >> +       struct path path;
> >> +       __u64 flags;
> >> +} __aligned(8);
> >> +
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
> >> +                                 struct path *start,
> >> +                                 __u64 flags)
> >> +{
> >> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> >> +       BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
> >> +
> >> +       if (flags) {
> >> +               memset(&kit->path, 0, sizeof(struct path));
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       kit->path =3D *start;
> >> +       path_get(&kit->path);
> >> +       kit->flags =3D flags;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +__bpf_kfunc struct path *bpf_iter_path_next(struct bpf_iter_path *it)
> >> +{
> >> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> >> +       struct path root =3D {};
> >> +
> >> +       if (!path_walk_parent(&kit->path, &root))
> >> +               return NULL;
> >> +       return &kit->path;
> >> +}
> >> +
> >> +__bpf_kfunc void bpf_iter_path_destroy(struct bpf_iter_path *it)
> >> +{
> >> +       struct bpf_iter_path_kern *kit =3D (void *)it;
> >> +
> >> +       path_put(&kit->path);
> > note, destroy() will be called even if construction of iterator fails
> > or we exhausted iterator. So you need to make sure that you have
> > bpf_iter_path state where you can detect that there is no path present
> > and skip path_put().
>
> In rare cases, it is possible &kit->path address could be destroyed
> and reused, right? Maybe we need more state in kit to detect the change?

kit->path is always referenced, so this should not happen.

Thanks,
Song

