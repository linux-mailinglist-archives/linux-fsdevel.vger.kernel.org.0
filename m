Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30616BDB53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCPWIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCPWIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:08:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30FD5A74;
        Thu, 16 Mar 2023 15:07:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so13459187edc.3;
        Thu, 16 Mar 2023 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679004463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmkBwYxMQeUctzjrFldtVoaezANsLHjS7h90Bw7aOb8=;
        b=OX06J91y0AB0jF4YfP4k34mwZrJxn3FEjT8Bs/YRmhC74kY3uZLq9nXirZCLa0sgnk
         OMKjp9M0BjTPz5I07oYFKPjCj6i7DgmazoDeKkkPn6a3P4tr6NiyFEq2RHhWhOqnSZUf
         XE8hW5tZUtgGplONZ/EMug8Sd0Os6zkq4hqZYKDpnYZTXcHRrxgR7ede8UjXmk6fNf9w
         zE0bPmjHeVkfm5AUJlOJ6CIxmb6MKIZtXh4goJ3rWoBIwdPOKYz3Mc96+LF/KHQ9GMoS
         XuEzlkBtzI/kTsy4EVMFUFT/7ehTvh/ZmVLE5iXZCNKQ7PeWHQhJt3kFoBs3tMntB/R6
         r2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmkBwYxMQeUctzjrFldtVoaezANsLHjS7h90Bw7aOb8=;
        b=bMDY5rjcUg6OJ8kwIhafj6zFnhsKni8OKR5l5f2FdHLriIHU3U6wuE9Pjr3sU+nMHp
         5pOHxt4pnrVIznUR+upJ7mF2/cFKJMb0T+xktMTU/gsP2F+/8LunRLgYOccmQQn/h0i0
         GA7OlrRiGqI8Wf3Y4+LbMpMMucsiuVnv2TtdnxdpwHwjOOs14lDaAsGbZgOQqYhNFuW4
         6KZlGmFGE86Wf/oJ078org7XO7ea5rYF2/vE8Cs5DRi10ZjHMh/AByAltXWk8Iv2ScLq
         rwwCLFM+wtsB9w/BUSyIS379GPi8XYbmXPq1c+HCcx8+12uLtTIo01UpB+nSX//A3JPS
         psxw==
X-Gm-Message-State: AO0yUKUY/SYwXPuNjujpQxfW6CHMNensJEvgYvaQ+t42zGLtlNyaHt+D
        sl2FeLV9Bb5/gHcfuSl1Z77R4rzAC7vr4l/7nUs=
X-Google-Smtp-Source: AK7set9ozrlkiM47WoqWKw6CvAMXBMPI57v2AuYyZMo5AdmbLC12BcKAsk6mAq2CFYYmRW2g2Eyy3+GlPBwvyWk5klY=
X-Received: by 2002:a17:906:8552:b0:8ab:b606:9728 with SMTP id
 h18-20020a170906855200b008abb6069728mr6158995ejy.5.1679004463514; Thu, 16 Mar
 2023 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-4-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:07:31 -0700
Message-ID: <CAEf4Bzbj03xyVtTH32HS-eN+Ue6sXA7SzU6rHMO+pbZMBAXTdg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/9] bpf: Use file object build id in stackmap
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
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

On Thu, Mar 16, 2023 at 10:02=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Use build id from file object in stackmap if it's available.
>
> The file's f_build_id is available (for CONFIG_FILE_BUILD_ID option)
> when the file is mmap-ed, so it will be available (if present) when
> used by stackmap.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/stackmap.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 0f1d8dced933..14d27bd83081 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -124,6 +124,28 @@ static struct bpf_map *stack_map_alloc(union bpf_att=
r *attr)
>         return ERR_PTR(err);
>  }
>
> +#ifdef CONFIG_FILE_BUILD_ID
> +static int vma_get_build_id(struct vm_area_struct *vma, unsigned char *b=
uild_id)
> +{
> +       struct build_id *bid;
> +
> +       if (!vma->vm_file)
> +               return -EINVAL;
> +       bid =3D vma->vm_file->f_build_id;
> +       if (IS_ERR_OR_NULL(bid))
> +               return bid ? PTR_ERR(bid) : -ENOENT;
> +       if (bid->sz > BUILD_ID_SIZE_MAX)
> +               return -EINVAL;
> +       memcpy(build_id, bid->data, bid->sz);
> +       return 0;
> +}
> +#else
> +static int vma_get_build_id(struct vm_area_struct *vma, unsigned char *b=
uild_id)
> +{
> +       return build_id_parse(vma, build_id, NULL);
> +}
> +#endif
> +
>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_=
offs,
>                                           u64 *ips, u32 trace_nr, bool us=
er)
>  {
> @@ -156,7 +178,7 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>                         goto build_id_valid;
>                 }
>                 vma =3D find_vma(current->mm, ips[i]);
> -               if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL=
)) {
> +               if (!vma || vma_get_build_id(vma, id_offs[i].build_id)) {
>                         /* per entry fall back to ips */
>                         id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
>                         id_offs[i].ip =3D ips[i];
> --
> 2.39.2
>
