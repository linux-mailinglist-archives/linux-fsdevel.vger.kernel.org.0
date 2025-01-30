Return-Path: <linux-fsdevel+bounces-40355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F084A227AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 03:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED831886D65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 02:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B512C499;
	Thu, 30 Jan 2025 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhpl1QU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5D1D52B;
	Thu, 30 Jan 2025 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738204338; cv=none; b=Gi4/vEVX84ZPucjvHXuW3iFosZt1a5Utoj232l9TInX0SV13ys7axJYT7dK4uLUUYa8QrikhAob6VmVuJ+KzxN8uTXrT3QITRlFxxH67sTYu0nnyNX+n9QQgHBf2unpzM7zfj7WcNKP/SE5u2MWV3FPpt1WAS2YZMBBq1bIthlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738204338; c=relaxed/simple;
	bh=v0Pleq58QNnh7XauPGPset9KHyOkCN5P87RRWbzCFqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNdvkpnieHFtGvAXd4YHgfmT6/PJfhBsM/dXoBXd+mmq+/lfF66RruV9cimyENdLMzhwMy4qR4KBOoB3dfw5ORMQCr7FxkJxSSjhzz8Zckmh1xe4QYUknCzVmOiwnoXHo7zxQyaJLlIxGqvkh8YtAoBYoY0OP0JYnWYmr1QpgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhpl1QU8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1010724f8f.0;
        Wed, 29 Jan 2025 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738204334; x=1738809134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVOeKubTpots4CB4SvdanKa5SO+1C9gTy1lOl/7fozA=;
        b=Uhpl1QU8JpKc9I0o+wn6AYl3AhUbb+0MSQ5W/sS5rWzggruag+vunUfKQlQQWf/8G9
         Lr3FEpRitTXi7gUT6sIf50Am0lUbU3YCSRrDHlH0YhPh8IlPOlnBbZGSEH1fCpOLZvt7
         XUsNtoVrK4ZNjwtEzhdqoh/bY6Nc/SzfYZd9KGws9glwEpxffbQMqk1pnOLwPlNURg28
         m87VH2chqqnNlLxq7wIw7RrXQb+pW6zRD7m129pFuyKg9FwTyXX4kzQEKYrfbgxtQDCY
         eA3bmoLy9e/XfdR1TTVWiaMYJqGbAl2V8yUSjRY2879MjrlzZ5R0rhizw7IxU7R8zZM6
         Ivvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738204334; x=1738809134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVOeKubTpots4CB4SvdanKa5SO+1C9gTy1lOl/7fozA=;
        b=tKXn/VUFuWiGt/2jdOWp1EkK5Pe8h2C+oVD5A3dAZ3h+KiKGHhH2LDyrQ3HV0XuKOc
         K9FovXAhkHDnVnuFovPVeFYw9LUD3zblL59vQGPPUKqkgCnR72UV2EivfRpIh/P8LG2O
         loGbe4VQ0DlOHfuA/yqE+RwkhXI41GfGIy8XMxWQWtInyCSKEhYIwHt+oi46Jck+neHj
         O9c4e1tGZsib1PkkwgUDiyDOhkGZGTJsbpeT4ElEIaIH2RCkif4j+snZzUOXKXVCRRhP
         NT3UTps+JeFPKS/tCN9G7ipg25DUZywBIkFXL9isYnT/fJE50Ow1d36wFpKFs3lkdHlw
         JZGA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tzJWolRPmoD0x0IkFCw1s41kI0L5g2bZi2hmQ6qUX38KYTRM6GgMl5Vz1PBLHNsGbJ+X+uPG+OGIBqNEBivqrRNufmd/@vger.kernel.org, AJvYcCVFQbHhsERfuSDdpPrcOici+OoyB4XPqFzjtAwfYdxZi/oXnevAOdaQZrytkUcDflQ6sEud+XrOFurhvD9z@vger.kernel.org, AJvYcCXzsazsPovpebMW1eXS1wVapZzsPi9VOk1PpXXS2pbvabWP0s9JZuD5miQp7WtxvjYQ+u1d7GCU5UbKeviu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9zqNrh1eAhXchq7HsnNiXUFZfKbQeZeOadcv15xWAxePOSNT
	xq7eZfvhIp/Uw+aUuefJmUAL3+qEPj3bzOdIqL1Q+jWWiGFBzHL9D4bWzdilu4UAITJmXic6U/m
	u/W/Y8Kg1x43jUxRBaudh901Z9AM=
X-Gm-Gg: ASbGncv60O7mk+Fcecx/dRfHr643W3SHN4Fd2D1B4oQgeMCu41KFC6LujjpsIS8spq6
	Jjj0ZKZ2gFfIxI/TXCySycF8SKFwnw5o+eK9ZePtbneAGfAheltL+T7We81KucEsdCtg87YVZ1b
	1+Bnh7SQAjsR+l3+J9Hz2MhRjmqsB2
X-Google-Smtp-Source: AGHT+IGVldXlUyrAW4PfnbO2DYAtquJ700zbZin57AbxNYkHbXeYShFDnczIS3xHpFxjygPmEtxT5HdPyLbk/LCaQJg=
X-Received: by 2002:a05:6000:1a89:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38c5a9e8018mr1272334f8f.20.1738204333716; Wed, 29 Jan 2025
 18:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129205957.2457655-1-song@kernel.org> <20250129205957.2457655-6-song@kernel.org>
In-Reply-To: <20250129205957.2457655-6-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 18:32:02 -0800
X-Gm-Features: AWEUYZnLJm5ClxjX2wB7choGp3nDXn_DjJuD5Zr2sHSL_AT1tWpIjeV8i15S41E
Message-ID: <CAADnVQ+1Woq_mh_9iz+Dhdhw1TuXZgVrx38+aHn-bGZBVa5_uw@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, liamwisehart@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 1:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> btf_kfunc_id_set.remap can pick proper version of a kfunc for the calling
> context. Use this logic to select bpf_dynptr_from_skb or
> bpf_dynptr_from_skb_rdonly. This will make the verifier simpler.
>
> Unfortunately, btf_kfunc_id_set.remap cannot cover the DYNPTR_TYPE_SKB
> logic in check_kfunc_args(). This can be addressed later.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/verifier.c | 25 ++++++----------------
>  net/core/filter.c     | 49 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 51 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2188b6674266..55e710e318e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11750,6 +11750,7 @@ enum special_kfunc_type {
>         KF_bpf_rbtree_add_impl,
>         KF_bpf_rbtree_first,
>         KF_bpf_dynptr_from_skb,
> +       KF_bpf_dynptr_from_skb_rdonly,
>         KF_bpf_dynptr_from_xdp,
>         KF_bpf_dynptr_slice,
>         KF_bpf_dynptr_slice_rdwr,
> @@ -11785,6 +11786,7 @@ BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
>  #ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
>  BTF_ID(func, bpf_dynptr_from_xdp)
>  #endif
>  BTF_ID(func, bpf_dynptr_slice)
> @@ -11816,10 +11818,12 @@ BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
>  #ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
>  BTF_ID(func, bpf_dynptr_from_xdp)
>  #else
>  BTF_ID_UNUSED
>  BTF_ID_UNUSED
> +BTF_ID_UNUSED
>  #endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
> @@ -12741,7 +12745,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         if (is_kfunc_arg_uninit(btf, &args[i]))
>                                 dynptr_arg_type |=3D MEM_UNINIT;
>
> -                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb] ||
> +                           meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb_rdonly]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_xdp]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
> @@ -20898,9 +20903,7 @@ static void specialize_kfunc(struct bpf_verifier_=
env *env,
>                              u32 func_id, u16 offset, unsigned long *addr=
)
>  {
>         struct bpf_prog *prog =3D env->prog;
> -       bool seen_direct_write;
>         void *xdp_kfunc;
> -       bool is_rdonly;
>
>         if (bpf_dev_bound_kfunc_id(func_id)) {
>                 xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(prog, func_id);
> @@ -20910,22 +20913,6 @@ static void specialize_kfunc(struct bpf_verifier=
_env *env,
>                 }
>                 /* fallback to default kfunc when not supported by netdev=
 */
>         }
> -
> -       if (offset)
> -               return;
> -
> -       if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> -               seen_direct_write =3D env->seen_direct_write;
> -               is_rdonly =3D !may_access_direct_pkt_data(env, NULL, BPF_=
WRITE);
> -
> -               if (is_rdonly)
> -                       *addr =3D (unsigned long)bpf_dynptr_from_skb_rdon=
ly;
> -
> -               /* restore env->seen_direct_write to its original value, =
since
> -                * may_access_direct_pkt_data mutates it
> -                */
> -               env->seen_direct_write =3D seen_direct_write;
> -       }
>  }
>
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..6416689e3976 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12062,10 +12062,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct _=
_sk_buff *s, struct sock *sk,
>  #endif
>  }
>
> -__bpf_kfunc_end_defs();
> -
> -int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> -                              struct bpf_dynptr *ptr__uninit)
> +__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 fl=
ags,
> +                                          struct bpf_dynptr *ptr__uninit=
)
>  {
>         struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)ptr__un=
init;
>         int err;
> @@ -12079,10 +12077,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff=
 *skb, u64 flags,
>         return 0;
>  }
>
> +__bpf_kfunc_end_defs();
> +
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
>
> +BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
> +
>  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
> @@ -12095,9 +12099,46 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
>  BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>
> +BTF_ID_LIST(bpf_dynptr_from_skb_list)
> +BTF_ID(func, bpf_dynptr_from_skb)
> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
> +
> +static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfun=
c_id)
> +{
> +       if (kfunc_id !=3D bpf_dynptr_from_skb_list[0])
> +               return 0;
> +
> +       switch (resolve_prog_type(prog)) {
> +       /* Program types only with direct read access go here! */
> +       case BPF_PROG_TYPE_LWT_IN:
> +       case BPF_PROG_TYPE_LWT_OUT:
> +       case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> +       case BPF_PROG_TYPE_SK_REUSEPORT:
> +       case BPF_PROG_TYPE_FLOW_DISSECTOR:
> +       case BPF_PROG_TYPE_CGROUP_SKB:

This copy pastes the logic from may_access_direct_pkt_data(),
so any future change to that helper would need to update
this one as well.

> +               return bpf_dynptr_from_skb_list[1];

The [0] and [1] stuff is quite error prone.

> +
> +       /* Program types with direct read + write access go here! */
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +       case BPF_PROG_TYPE_SCHED_ACT:
> +       case BPF_PROG_TYPE_XDP:
> +       case BPF_PROG_TYPE_LWT_XMIT:
> +       case BPF_PROG_TYPE_SK_SKB:
> +       case BPF_PROG_TYPE_SK_MSG:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +               return kfunc_id;
> +
> +       default:
> +               break;
> +       }
> +       return bpf_dynptr_from_skb_list[1];
> +}
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>         .owner =3D THIS_MODULE,
>         .set =3D &bpf_kfunc_check_set_skb,
> +       .hidden_set =3D &bpf_kfunc_check_hidden_set_skb,

If I'm reading it correctly the hidden_set serves no additional purpose.
It splits the set into two, but patch 4 just adds them together.

> +       .remap =3D &bpf_kfunc_set_skb_remap,

I'm not a fan of callbacks in general.
The makes everything harder to follow.

For all these reasons I don't like this approach.
This "generality" doesn't make it cleaner or easier to extend.
For the patch 6... just repeat what specialize_kfunc()
currently does for dynptr ?


pw-bot: cr

