Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D06AFC14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCHBTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 20:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCHBTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:19:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5046A6758;
        Tue,  7 Mar 2023 17:19:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so59894094eda.1;
        Tue, 07 Mar 2023 17:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678238352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLH4A9cIITiWgvTROt/796Hn74B0vtkSJjpGSyylmcs=;
        b=CH4tLeaHYarBvXDOPbS6HHToCNDS2n9U2X1f5Sa9il8btMfRfIIm4s5yckdyl3bjR8
         e3aTlEasvW4CQyhpLvjJ2hENvdKKgfYsF2fwK6Y8MCFFmE1p/ulnzwEzYq8JSy+djDcx
         gGOZC72PsiEEosBCnxNYwBBmjmFFdixtjxBVNYKx9wiyFNcDqb79YGRM6Qn/iiAPAZLy
         bEpFY1Hl6vKFokdOmrgfxuEm9U565KA+IgMpc4fcA5g0gqY8HjZP8Lq44mGWssVyAuYh
         o4Br5oES0/YawB0aREI8VlnW8vvX8xHvwPr21y9s8gdhKhgX4g8WOPszlhmbr7mPkyIO
         YGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLH4A9cIITiWgvTROt/796Hn74B0vtkSJjpGSyylmcs=;
        b=Lo/A3G0pi/f5TwDmx1L/kfzl4/Q3GyhhBXBsbMxTkHPjQ7T4JQwRt40PKyjoiTUDZF
         MT3NvXWvqpNAvcEAjtrnT+lG89yLxqnmzAd2KN1u8hCR12YTydCHNVoSCTEncyDS+LZK
         HqcrBkxYiicHtG226bJyDcQaurBu9CGI3AWh2JcT4esKJEcCZLHdn8T93sZMbH72lwy6
         YvQhtKXJ/0xMxDWea2xj6awevYMFHpL+zedEznzySzkT6XoadatRWZtL716J2WmpmH45
         OFfOApWj0FvDPZH7YCq05JqhlEyjJg7HM6o+DaI7ST7E5i/ce2nZYSwPLCtvUQZ0z7Tt
         frtg==
X-Gm-Message-State: AO0yUKWKbF0A95/seM448nvMzxPI+V0ixWWphCABLtMuJifu4neBusVQ
        F2QUY6Pp4f9Y9JylLbrB3zx8LGYSOgndDNpRyIw=
X-Google-Smtp-Source: AK7set8Qd4OHKSzPmiTWMliy10a/G8dDy8JOTmOGGJCFt+t8GRv8SHa9aGKKXq1WB+UO6VNza4fdEfQXn7owmJDnpb8=
X-Received: by 2002:a17:906:4bcb:b0:8b1:28f6:8ab3 with SMTP id
 x11-20020a1709064bcb00b008b128f68ab3mr8269471ejv.15.1678238352239; Tue, 07
 Mar 2023 17:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20230228093206.821563-1-jolsa@kernel.org> <20230228093206.821563-5-jolsa@kernel.org>
In-Reply-To: <20230228093206.821563-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:19:00 -0800
Message-ID: <CAEf4Bzar7H1OsjgqJ8H6R-f3DZPhhR0+KOamyt0MDNboept--A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 4/9] libbpf: Allow to resolve binary path
 in current directory
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:33=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Try to resolve uprobe/usdt binary path also in current directory,
> it's used in the test code in following changes.

nope, that's not what shell is doing, so let's not invent new rules
here. If some tests need something like that, utilize LD_LIBRARY_PATH
or even better just specify './library.so'

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 05c4db355f28..f72115e8b7f9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10727,17 +10727,19 @@ static const char *arch_specific_lib_paths(void=
)
>  /* Get full path to program/shared library. */
>  static int resolve_full_path(const char *file, char *result, size_t resu=
lt_sz)
>  {
> -       const char *search_paths[3] =3D {};
> +       const char *search_paths[4] =3D {};
>         int i, perm;
>
>         if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
>                 search_paths[0] =3D getenv("LD_LIBRARY_PATH");
>                 search_paths[1] =3D "/usr/lib64:/usr/lib";
>                 search_paths[2] =3D arch_specific_lib_paths();
> +               search_paths[3] =3D ".";
>                 perm =3D R_OK;
>         } else {
>                 search_paths[0] =3D getenv("PATH");
>                 search_paths[1] =3D "/usr/bin:/usr/sbin";
> +               search_paths[2] =3D ".";
>                 perm =3D R_OK | X_OK;
>         }
>
> --
> 2.39.2
>
