Return-Path: <linux-fsdevel+bounces-50504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94166ACC9E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8D3A4CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46723C4E9;
	Tue,  3 Jun 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av3ICbmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85D223316;
	Tue,  3 Jun 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963613; cv=none; b=OYLqpEIKifmpQBgeLGNZPlGF5N4wWSL0sYk508qOt0WvgFr4d9vKUJmMSTJsHCVPsH5uky1LHUYQmTsJa2vw2NtfFhkEtrEfy663VXPdYqM2a85hdq5d+2auq1nOGF/6rYJH+lCEX0LxJwhhOQHR3L8lKQBpY1aijKzyulgtwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963613; c=relaxed/simple;
	bh=VKaT1KQZbq1h+bpWVaNBkbsVejOICIzA68th4hZbQu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXFG0uyb+mlzlExmkfjwI/LYNISVIszzJeWdkKkm6ZGo8Hm02OPYkfce2sl4/5LVuAC200uAqhw2JTl8OF4Pg2cFMBY1Sb7xGhp0YWx+90liUPswVWoLlm/UDQHdYAnhGvgIs97zZfGaxNXqBZ/hM0DfE0Rv+fJNUeAabb69RQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av3ICbmj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a367ec7840so3999956f8f.2;
        Tue, 03 Jun 2025 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748963610; x=1749568410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM7FqjbQ2HOQRdv25jJI92AI5FyCapZb+x0ggg0Oxqo=;
        b=Av3ICbmjdzI2VZWbRT2l4CJ0KuX4tN6o4CzJ01Xv0uVqHxWggNyembzlZIrwSTNf9f
         2unxipBJdx5A38UN7T1a5PlQLc9jpdIQ+pumRYYFb7JnSF+AlS/yoMYneyg50qIEspHQ
         3r2QSOMS5B+nVJTeYPwvv9a+zo7l7b/oKmJ6rLMnveyRX5rYVH4Ssmn6ivikLi1oRUvM
         q55QFer+5C31GWurcph6l67QMWUyxbi2y5Z0unbK9B/SW2NVYxANofR3eL+cMMNMXr59
         PyXTzngFQgPOsEq6SUxHeyXsRiDeCcul8brZQxHmtdHkl14HBgcChNA761QOlBU+jP40
         Hrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748963610; x=1749568410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM7FqjbQ2HOQRdv25jJI92AI5FyCapZb+x0ggg0Oxqo=;
        b=Bp5tiX0Ng9r5WK3aLPHPpCA8INdWl4LTYQPcTaBLH4XhrvcxN6Zy/XfjHjMAjAJN8x
         zuloKPs2a7tLNsBn+lQYtDKG4EgBCGVyJU+L2t+So6zjQrRvCsaJbHzA03vGVgKcMZY1
         HYFPULlk8/fR+lvhUtf+FkFf3UV+1VjyZWqhW0dLIStD+r6CElFGKnyOxifpQySM7zOi
         2QMaz54InfXBOD1/0SEJxGOqsP5xVs0tjhfzMQvfuIOf6Wz2FwIRgKsUKIwgYL7RNdd3
         XJ4giRyVweFhwcv4EoxwJSxmIUZe1nKJ51lIDmatdru8HjvptspnS4JzM/s7HuiSCLYK
         FOIw==
X-Forwarded-Encrypted: i=1; AJvYcCU/RduDu5eN+9IVqFeqfjK6IiTSo4S8S5XgL4y1xkICd6lNr5qvi2cwbkdh7CAoU8gPJ4pUVvdfXqqgnwzY@vger.kernel.org, AJvYcCUADAd42QuHImByGRhhavyIE4gieEq/KlPuISxqUXZ40cATs3BFn52f0q8HHLIvdTH6uWeB1REevhJQOtwP@vger.kernel.org, AJvYcCXmL/QJ32ajnLftY4jcH6v0ZZCHyZ0FKpDGlzQx/Xa4f86NwaSNynpEdJjTs2x0kQ3C4B0RfBGUsKN4d3nbFEaOsbNY40x5@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJksHT1Bof7ZTF4ahqfHUz+QhOYxUnoNqXSyEOIsESpYYMg2k
	HPh7MX2i3fCgVWBITjNuYgv25dDTJ5d4s59toNm//hOYCZWnoeFQ6AV3uQanhxiZw2bwl/O+DHB
	Fuu7ddqKiR2EuqE6M+WB5ZcV5kZ3N5qw=
X-Gm-Gg: ASbGnctQ9jic0BZZ+mEI6ykG2KxZ8ZFD/UOUzl7pWOv7tvg1pdq/D6ympE/a7YHvok/
	soB6dFTz+mZekex8HB1OdH8/fJtS6s02st1Zj0Yg3TNi92x1WXHlBPje7ZYQ8CK0weZ4ccFyQq4
	2fYqhC1tSt2/1WeGT+PU85A+I6YA2R+fam7bax7UQ/sNnSiEdOAcPJU6Vc2Ao=
X-Google-Smtp-Source: AGHT+IH59aVL70zjdlvFvrxqya3aA8HNcB8WHYJtYoL80K4X5T7xHH/6N7iBla+1X6FUqhCjz6qor/hWAe3HaZDHy+o=
X-Received: by 2002:a05:6000:230b:b0:3a4:e318:1aa9 with SMTP id
 ffacd0b85a97d-3a4f89ead67mr12808911f8f.59.1748963609616; Tue, 03 Jun 2025
 08:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-4-song@kernel.org>
In-Reply-To: <20250603065920.3404510-4-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Jun 2025 08:13:18 -0700
X-Gm-Features: AX0GCFu98PiOKI1wBddjoNp1jUp6L4dsekQR23Qi4Bu9qcDk7dk8CUSl-Pywa9o
Message-ID: <CAADnVQLjvJCFjTiWpsBmfbyH5i88oq7yxjvaf+Th7tQANouA_Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, m@maowtm.org
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

I think Christian's preference was to keep
everything in fs/bpf_fs_kfuncs.c

Don't add a new file. Just add this iter there.

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

Why? flags is unused. Don't waste space for it.

