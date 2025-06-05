Return-Path: <linux-fsdevel+bounces-50786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6727ACF92B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BAD165B44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88427EC80;
	Thu,  5 Jun 2025 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJarFV92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B920330;
	Thu,  5 Jun 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749158070; cv=none; b=AVFmAkfddadLp26bJdr0aBdth3LqX3hncPHTvBcLBIYK6IHJ1mhxUxikO5lXjgUGr9WHhp7dgSw9Z06GaCT8EOZ+5LmyxfEONGQ1+viMZYRXZ9fuY3lRr6od2ghdXvkdeWNUTHYhMkETc8GbjJy8kdvObu6isjowFiu4FN4WepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749158070; c=relaxed/simple;
	bh=WOJbNMIIzp8UshuzXv5C+5t+iCkp7fkLH50ic3CZMa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcl5NMyEjPFfskFbT3LhqF0j5+ECswluWGKYXE7Wp5bHd/YHquEpxMYYfNckkgjJPTWfHZQrlAqVTz0vIWNROcQPDdwUOn2cmbDZkCxsmlE5gk4BjRp/baxUXgy1ZJpW1Uvvw9NjvPP35xpDuK7beHRiT32v6BRserwDfKuRJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJarFV92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2A2C4CEF1;
	Thu,  5 Jun 2025 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749158069;
	bh=WOJbNMIIzp8UshuzXv5C+5t+iCkp7fkLH50ic3CZMa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZJarFV92B75b2Xn1R4g5YTO8yPR1Q0duTLZzJdwYJcEDNjIJcbUpWOAbCTWT1c9ML
	 vVj10rSxlxcIMzbeyrKjKojPiFtUYSw7Dlj/fvfb82w/Xtc0u9gTedrLJB86DLQrdC
	 V0qixMtJpFxhCvT8ouBn1wU4P1A7FmLD88ZlQnNmV7oL2X/XfeHTjHHI5YXlfI7/Bz
	 wJM1GIeWZNAychWSV4Qp0APRJGlMYVali7AXnL1lh9Wqh0Z+PtyZ5BNJRh6S7m0C1B
	 hN0eqqRiby8cW9FfE9aqsIQ0TNfqzFqHpMs8YL/+zBI/N6sM/9hGslyl6Ge1MkoVty
	 EqEHMP9dh+OMw==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-48d71b77cc0so16938121cf.1;
        Thu, 05 Jun 2025 14:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeccKlg4CHustzXeJH8hkbfSXm7HVE9j9Ytf1soeL5olGsBHMyf5xe3oPse+S7u74H9xBAIJU2rXSSwSrbYQjRw+5bMNLd@vger.kernel.org, AJvYcCW+n4bB10MBPpdTLj33O9kh99oFLJCluN4IWigk3e9cL8JPLIP1fumMDUciL1DPaDlQB+WWw3Mb9q9L68X6@vger.kernel.org, AJvYcCWkQ+L2pIc9osMNPBH2eaUzcNBEbAxskjmXr8IjGgT3e3k4Lp87ftUd6DjfPlvM7Dws4umCBqf28eioIiLn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10QRK+9yx3eSOYVKeb4Gb3n4RFVtG1L/s7d3iCg9Eg63sva1i
	chg7bfHQY33SxfMsF9Yu906HRsDdzwweANnnDlc+sOUQ0XewGzBr0nIbDhT1WYKLk/NFYfITVFY
	z+MsenSjj2WOUNecejqZNz/Td47oTJt8=
X-Google-Smtp-Source: AGHT+IGTLw/U5w416/3Eu9jpNdm9/30Kn8C7cz3OadHd3JEnr2/2eVp0goFHQwxJZAyKrVuUxH+5KKnk38pxNlKc5Ow=
X-Received: by 2002:a05:622a:5c17:b0:4a4:30e7:77a with SMTP id
 d75a77b69052e-4a5b9e20149mr17600321cf.15.1749158069080; Thu, 05 Jun 2025
 14:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
 <aEHvkQ1C7Ne1dB4n@google.com>
In-Reply-To: <aEHvkQ1C7Ne1dB4n@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 5 Jun 2025 14:14:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW46grJgJrXovKuksGXM0HfYg-hmmfroUUkBJTsPL4bSxQ@mail.gmail.com>
X-Gm-Features: AX0GCFubNgDo50rcw47zJs5bVbZAszS-OTfDxJ-hTGtP_5ndfdQs8RXPRlrMeqY
Message-ID: <CAPhsuW46grJgJrXovKuksGXM0HfYg-hmmfroUUkBJTsPL4bSxQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:27=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Mon, Jun 02, 2025 at 11:59:19PM -0700, Song Liu wrote:
> > Introduce a path iterator, which reliably walk a struct path toward
> > the root. This path iterator is based on path_walk_parent. A fixed
> > zero'ed root is passed to path_walk_parent(). Therefore, unless the
> > user terminates it earlier, the iterator will terminate at the real
> > root.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/bpf/Makefile    |  1 +
> >  kernel/bpf/helpers.c   |  3 +++
> >  kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c  |  5 ++++
> >  4 files changed, 67 insertions(+)
> >  create mode 100644 kernel/bpf/path_iter.c
> >
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 3a335c50e6e3..454a650d934e 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> >  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> >  endif
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D path_iter.o
> >
> >  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b71e428ad936..b190c78e40f6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_=
NEXT | KF_RET_NULL | KF_SLEEPAB
> >  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEP=
ABLE)
> >  #endif
> >  BTF_ID_FLAGS(func, __bpf_trap)
> > +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
>
> Hm, I'd expect KF_TRUSTED_ARGS to be enforced onto
> bpf_iter_path_new(), no? Shouldn't this only be operating on a stable
> struct path reference?

Good catch! Added KF_TRUSTED_ARGS. also added a test with
untrusted pointer.

>
> > +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF=
_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPAB=
LE)
>
> At this point, the claim is that such are only to be used from the
> context of the BPF LSM. If true, I'd expect these BPF kfuncs to be
> part of bpf_fs_kfunc_set_ids once moved into fs/bpf_fs_kfuncs.c.

I moved this to fs/bpf_fs_kfuncs.c in the next version.

>
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
> > new file mode 100644
> > index 000000000000..0d972ec84beb
> > --- /dev/null
> > +++ b/kernel/bpf/path_iter.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <linux/bpf.h>
> > +#include <linux/bpf_mem_alloc.h>
> > +#include <linux/namei.h>
> > +#include <linux/path.h>
> > +
> > +/* open-coded iterator */
> > +struct bpf_iter_path {
> > +     __u64 __opaque[3];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_path_kern {
> > +     struct path path;
> > +     __u64 flags;
> > +} __aligned(8);
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_iter_path_new(struct bpf_iter_path *it,
> > +                               struct path *start,
> > +                               __u64 flags)
> > +{
> > +     struct bpf_iter_path_kern *kit =3D (void *)it;
> > +
> > +     BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> > +     BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
> > +
> > +     if (flags) {
> > +             memset(&kit->path, 0, sizeof(struct path));
>
> This warrants a comment for sure. Also why not just zero it out
> entirely?

Added some comments in v3. Also "flags" is removed in v3.

Thanks,
Song

[...]

