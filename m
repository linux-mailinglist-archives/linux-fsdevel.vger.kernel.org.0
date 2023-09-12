Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7C79DB12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjILVmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:42:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900D10CC;
        Tue, 12 Sep 2023 14:42:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31dca134c83so6223100f8f.3;
        Tue, 12 Sep 2023 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694554958; x=1695159758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFaOTmDPotpKYMAcf5yM0TcQqzxe8ODUt6hexnT/A0c=;
        b=TjQ2ykqctLgzK7UjJcyHABJFHi/TSC7lNcyFlhU5jggpdWfaaFSKCbEpagdbSUq/Rg
         U7864mKIPqw8W1JZN8DyW42Bc8QYNt+neRFDjbC3ga/nQc4EFYuSzicUDmbj5xayOSKC
         QGBi2c8+02flsZr6+nvfs7WPj5xEk6KHZ3rv+Qd2mwMzxuvPSiBqbpUwnIy+x20KKy58
         mI/DkO+R1WF6J/sNEw9oouh7E0Nwm66IAUjm1V1l7ZKNK5hDmwPXHFh338vq5bawRHnT
         TNTMMCq0jo17B54bbhM1hJYk0qSMo41CStgi9OJYrOMpKVnS6kiYBMbpp7yS66IHYswQ
         ZgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694554958; x=1695159758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFaOTmDPotpKYMAcf5yM0TcQqzxe8ODUt6hexnT/A0c=;
        b=Ll455L4hqgYY7/sgDWGry7pHMY6AQUbIsN2E6eP3AhhDCoDhUwtvHYlnpD9KmsOLBw
         9p4+wCdxnxJUw0ktvAg6meMI9DvKm6Vfn6CKwUmxX7x9MssUEWkLj4krGoXXSZrrqIe6
         WS3k/Bc8vz6OlBtzQNN/TPwm1rnTyTLnSGlnET8QnO/Bwnpkmm8i8d+ZLDjgxUTCro/3
         fXpQLqpPQxjIGXsn+1vrooHSKb3sPmxlco8iIDEL7jnGq7ITIte8LKkew7uMKXGFQ6Wo
         HMi6qp5G/79vl45zovFsX5oq7koi92zm5FvmVAknl6MjcpGZZZjlHHQ4AjFqz0Mnp/rQ
         Coow==
X-Gm-Message-State: AOJu0YxwzTVjPKrWD7feuewTClWxsIE10pD83olLQ90/twfU9kEBELqO
        WZ90UxmqM5IbuEHvJaGz6JpPQkfI56tJJT7Xqag=
X-Google-Smtp-Source: AGHT+IEhRRG514ufB436LVfvzZzc6rfX+gY/FmR3l3MHxREzX2mGs4J/uEWee+nkCy6tB3h40S+ubYQL2Fe/XibJ46E=
X-Received: by 2002:adf:ed86:0:b0:31c:887f:82f3 with SMTP id
 c6-20020adfed86000000b0031c887f82f3mr596126wro.40.1694554957893; Tue, 12 Sep
 2023 14:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-1-andrii@kernel.org> <20230912212906.3975866-9-andrii@kernel.org>
In-Reply-To: <20230912212906.3975866-9-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Sep 2023 14:42:26 -0700
Message-ID: <CAEf4BzZZSQ5m8mqMM=YVQ7kHOKuyxDu4qajWqLnGCX4x+bL=HA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/12] libbpf: add bpf_token_create() API
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 2:30=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 29 +++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 49 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b0f1913763a3..593ff9ea120d 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1271,3 +1271,22 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>         ret =3D sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
> +
> +int bpf_token_create(int bpffs_path_fd, const char *bpffs_pathname,
> +                    struct bpf_token_create_opts *opts)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, token_create=
);
> +       union bpf_attr attr;
> +       int fd;
> +
> +       if (!OPTS_VALID(opts, bpf_token_create_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.token_create.bpffs_path_fd =3D bpffs_path_fd;
> +       attr.token_create.bpffs_pathname =3D ptr_to_u64(bpffs_pathname);
> +       attr.token_create.flags =3D OPTS_GET(opts, flags, 0);
> +
> +       fd =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
> +       return libbpf_err_errno(fd);
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 74c2887cfd24..16d5c257066c 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -635,6 +635,35 @@ struct bpf_test_run_opts {
>  LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
>                                       struct bpf_test_run_opts *opts);
>
> +struct bpf_token_create_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +       __u32 flags;
> +       size_t :0;
> +};
> +#define bpf_token_create_opts__last_field flags
> +
> +/**
> + * @brief **bpf_token_create()** creates a new instance of BPF token, pi=
nning
> + * it at the specified location in BPF FS.
> + *
> + * BPF token created and pinned with this API can be subsequently opened=
 using
> + * bpf_obj_get() API to obtain FD that can be passed to bpf() syscall fo=
r
> + * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
> + *
> + * @param pin_path_fd O_PATH FD (see man 2 openat() for semantics) speci=
fying,
> + * in combination with *pin_pathname*, target location in BPF FS at whic=
h to
> + * create and pin BPF token.
> + * @param pin_pathname absolute or relative path specifying, in combinat=
ion
> + * with *pin_path_fd*, specifying in combination with *pin_path_fd*, tar=
get
> + * location in BPF FS at which to create and pin BPF token.
> + * @param opts optional BPF token creation options, can be NULL
> + *

this description is obviously outdated (there is no pinning involved
anymore) and I just realized after sending patches out, I'll fix it
for next revision


> + * @return 0, on success; negative error code, otherwise (errno is also =
set to
> + * the error code)
> + */
> +LIBBPF_API int bpf_token_create(int bpffs_path_fd, const char *bpffs_pat=
hname,
> +                               struct bpf_token_create_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 57712321490f..c45c28a5e14c 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
>                 bpf_program__attach_netfilter;
>                 bpf_program__attach_tcx;
>                 bpf_program__attach_uprobe_multi;
> +               bpf_token_create;
>  } LIBBPF_1.2.0;
> --
> 2.34.1
>
>
