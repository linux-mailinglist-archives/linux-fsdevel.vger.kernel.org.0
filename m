Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4919577BD7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjHNPyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHNPyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:54:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B010F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:54:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe2d889ad7so1661100e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1692028462; x=1692633262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSeRsjAG1gUJDN0RBZDzWcWuwyj5bdh0ZV+ehq5RVp0=;
        b=WcmZC3dMi3MwUwboImTRFykCfCdSCDkyIwJIRUwrYDFa0Ay3qpeSEArb9K/LlWhVla
         g+vVuDh3cEQDgfXSOi9Urz0Z+1u1fkbPJw4U7YTLjQ4QU92c5YP6NX4tls8iJ0Vvvz8a
         nmRXA8XRY2q/e1oLfssy2TEFlM6gPppuLpHyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028462; x=1692633262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSeRsjAG1gUJDN0RBZDzWcWuwyj5bdh0ZV+ehq5RVp0=;
        b=Z8/aNdttP+lhdyu5Sggxhpa7n5TjLgdhHaaI3YvVweOlaoP3RNtgyVclsSGlKnK4nZ
         LKATbkBpyYEztiioWHb7cnOoWKcCkeDkjRSXyf7cfgX3kqapqO9wrkXunvBqW8mI6wYg
         v5Yuh8Cg62zSz15zhqbDXXgSvWwdy/gE2GkYMc34kVA17+oXZvDK5GzLJSy3T0ckBSNy
         aTFk5SbeZYi9/dlZgUrQJPKy0ESexoX0rfMXbElzYol6YR1UY3lAIUFrqvQ3hvGda0b5
         32Ew7MKbzLsk9sIRg+RtTC0O/c562STICJuKZEg8Satf/osw8EQEj1HuTjLLh9leYdYS
         6rXA==
X-Gm-Message-State: AOJu0Yx5qLR+HqhgEGV6P7TzviTrGhFU+zYb2zvOVK+v2wJVBpxJJxW/
        vGDJZFaEOyn3qaFp2khNFztlFlyHPAgDdOh6cjXK6Q==
X-Google-Smtp-Source: AGHT+IEsp3HJ3ah+2NnwANdOCxHlnGMvnenj5vJL7oRMc/dHM6SsFFCRwfUQGIs0og9hXTriFzC+a97tOVwuBx9N2i0=
X-Received: by 2002:a19:ad04:0:b0:4fd:b27a:d319 with SMTP id
 t4-20020a19ad04000000b004fdb27ad319mr5348572lfc.0.1692028462321; Mon, 14 Aug
 2023 08:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de> <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
In-Reply-To: <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 14 Aug 2023 17:54:11 +0200
Message-ID: <CAJqdLrpwzbx1bGyPXTEot7t8XpWF4dJAr+8kxuCXjOaSNrfx+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
To:     =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de, stgraber@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 4:32=E2=80=AFPM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> which allows to set a cgroup device program to be a device guard.
> Later this may be used to guard actions on device nodes in
> non-initial userns. For this reason we provide the helper function
> cgroup_bpf_device_guard_enabled() to check if a task has a cgroups
> device program which is a device guard in its effective set of bpf
> programs.
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>

Hi Michael!

Thanks for working on this. It's also very useful for the LXC system
containers project.

> ---
>  include/linux/bpf-cgroup.h     |  7 +++++++
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  5 ++++-
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  6 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..112b6093f9fd 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -184,6 +184,8 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
>         return array !=3D &bpf_empty_prog_array.hdr;
>  }
>
> +bool cgroup_bpf_device_guard_enabled(struct task_struct *task);
> +
>  /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enab=
led. */
>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)                       =
     \
>  ({                                                                      =
     \
> @@ -476,6 +478,11 @@ static inline int bpf_percpu_cgroup_storage_update(s=
truct bpf_map *map,
>         return 0;
>  }
>
> +static bool cgroup_bpf_device_guard_enabled(struct task_struct *task)
> +{
> +       return false;
> +}
> +
>  #define cgroup_bpf_enabled(atype) (0)
>  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
>  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..313cce8aee05 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1384,6 +1384,7 @@ struct bpf_prog_aux {
>         bool sleepable;
>         bool tail_call_reachable;
>         bool xdp_has_frags;
> +       bool cgroup_device_guard;
>         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>         const struct btf_type *attach_func_proto;
>         /* function name for valid attach_btf_id */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeab..3be57f7957b1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1165,6 +1165,11 @@ enum bpf_link_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>
> +/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the lo=
aded
> + * program will be allowed to guard device access inside user namespaces=
.
> + */
> +#define BPF_F_CGROUP_DEVICE_GUARD      (1U << 7)
> +
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..230693ca4cdb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2505,6 +2505,36 @@ const struct bpf_verifier_ops cg_sockopt_verifier_=
ops =3D {
>  const struct bpf_prog_ops cg_sockopt_prog_ops =3D {
>  };
>
> +bool
> +cgroup_bpf_device_guard_enabled(struct task_struct *task)
> +{
> +       bool ret;
> +       const struct bpf_prog_array *array;
> +       const struct bpf_prog_array_item *item;
> +       const struct bpf_prog *prog;
> +       struct cgroup *cgrp =3D task_dfl_cgroup(task);
> +
> +       ret =3D false;
> +
> +       array =3D rcu_access_pointer(cgrp->bpf.effective[CGROUP_DEVICE]);
> +       if (array =3D=3D &bpf_empty_prog_array.hdr)
> +               return ret;
> +
> +       mutex_lock(&cgroup_mutex);

-> cgroup_lock();

> +       array =3D rcu_dereference_protected(cgrp->bpf.effective[CGROUP_DE=
VICE],
> +                                             lockdep_is_held(&cgroup_mut=
ex));
> +       item =3D &array->items[0];
> +       while ((prog =3D READ_ONCE(item->prog))) {
> +               if (prog->aux->cgroup_device_guard) {
> +                       ret =3D true;
> +                       break;
> +               }
> +               item++;
> +       }
> +       mutex_unlock(&cgroup_mutex);

Don't we want to make this function specific to "current" task? This
allows to make locking lighter like in
__cgroup_bpf_check_dev_permission
https://github.com/torvalds/linux/blob/2ccdd1b13c591d306f0401d98dedc4bdcd02=
b421/kernel/bpf/cgroup.c#L1531
Here we have only RCU read lock.

AFAIK, cgroup_mutex is a heavily-contended lock.

Kind regards,
Alex

> +       return ret;
> +}
> +
>  /* Common helpers for cgroup hooks. */
>  const struct bpf_func_proto *
>  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2aef900519c..33ea67c702c1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2564,7 +2564,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>                                  BPF_F_SLEEPABLE |
>                                  BPF_F_TEST_RND_HI32 |
>                                  BPF_F_XDP_HAS_FRAGS |
> -                                BPF_F_XDP_DEV_BOUND_ONLY))
> +                                BPF_F_XDP_DEV_BOUND_ONLY |
> +                                BPF_F_CGROUP_DEVICE_GUARD))
>                 return -EINVAL;
>
>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> @@ -2651,6 +2652,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>         prog->aux->dev_bound =3D !!attr->prog_ifindex;
>         prog->aux->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;
>         prog->aux->xdp_has_frags =3D attr->prog_flags & BPF_F_XDP_HAS_FRA=
GS;
> +       prog->aux->cgroup_device_guard =3D
> +               attr->prog_flags & BPF_F_CGROUP_DEVICE_GUARD;
>
>         err =3D security_bpf_prog_alloc(prog->aux);
>         if (err)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 60a9d59beeab..3be57f7957b1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1165,6 +1165,11 @@ enum bpf_link_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>
> +/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the lo=
aded
> + * program will be allowed to guard device access inside user namespaces=
.
> + */
> +#define BPF_F_CGROUP_DEVICE_GUARD      (1U << 7)
> +
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
>
> --
> 2.30.2
>
