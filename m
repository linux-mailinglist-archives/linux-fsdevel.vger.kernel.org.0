Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3784690133
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBIHYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 02:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBIHXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901B14DBEA
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 23:23:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y4so751794pfe.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 23:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=QTvuFq/7v+CdkDisGU23a4Mg4sCbIx93MNu51rqdsSFelRH+bzFtnIoxiDz5XLtECD
         mVOdxoI+TDOdkZ+OftJL3dm7+U+HdYpulqUrb2jLjjKCqVg0ACdWdD2HO+m/yRYZ3tuw
         wkdhJGyPozWn+PtKhMrcQXV0lfoFGh+g0xgtz67cOirBzeCAtoScHKwH/q5zla5Efj+F
         bOGjzkshWM0wd9jjds9Jgo9wbbEimVjRaN2G/fPBSRVYTKbJ7QTToZAfK2O0wuDdv6lJ
         yO49Rn6wsAx0XAY45aXkgHk7bVpHRoWTWItBRJR4rEGqsJGkEgeumTF3u+UwIkz1j6EL
         2c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=ZLXr9EkFIjfYc6V4OvrcXGcsdnAr3yeBf2GYUxqw9x5pS2fAUkwoum3YQpKYjtQoTz
         PIjpovWNkVDn5pnT4L86kurdz4ahhDyIjPPLqXw4GHgKbhrc6+d9pKlZPFYclw3i0Riu
         Bdk2DTkTcqPLMrDn99GUt3amV3Nt+DBtWvWx5xsw+BaBXEQ83Lf8XVOkKejiGYHqev59
         frzawW6WY2HDnIKY4qgfR6MeJYZU3cbjk6vBE52wQgAy7EvJ1Jp6KpogOCRGzkXHF9Mv
         tf69jnmdYP2Zf4m4Q2XxhmLPcRlF8eKGld/ih2jZXQ4GbVjDpQiX453sRJXBGdKdp7in
         KIUQ==
X-Gm-Message-State: AO0yUKURFmXUZ5SEO+PD/1RU6Kh7DAi+p+bdItZY7khRUIZiL8FfdWlO
        xRfkR6s9uw7xOZWATsMbmjLDN3ILZ81SBdHJJ59tKg==
X-Google-Smtp-Source: AK7set8147oifuJImE5p0zRAylkYykGYufjK3B5xwMaz7PIg/QVSQ6RfLCFlhgyJPReztt3sdy3IK2VJ1VcQgxbPxyU=
X-Received: by 2002:a63:8f0c:0:b0:4fb:3232:8f70 with SMTP id
 n12-20020a638f0c000000b004fb32328f70mr1164056pgd.9.1675927404760; Wed, 08 Feb
 2023 23:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-3-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-3-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Feb 2023 23:23:13 -0800
Message-ID: <CA+khW7iGj=Y3NVxc9Y-MnwmPxCz5jHDmSfW-S6KS9Hko=jgJOg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] bpf: Use file object build id in stackmap
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Use build id from file object in stackmap if it's available.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Can we insert the lookup from vma->vm_file in build_id_parse() rather
than its callers?

>  kernel/bpf/stackmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index aecea7451b61..944cb260a42c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -156,7 +156,15 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>                         goto build_id_valid;
>                 }
>                 vma = find_vma(current->mm, ips[i]);
> +#ifdef CONFIG_FILE_BUILD_ID
> +               if (vma && vma->vm_file && vma->vm_file->f_bid) {
> +                       memcpy(id_offs[i].build_id,
> +                              vma->vm_file->f_bid->data,
> +                              vma->vm_file->f_bid->sz);
> +               } else {
> +#else
>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> +#endif
>                         /* per entry fall back to ips */
>                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>                         id_offs[i].ip = ips[i];
> --
> 2.39.1
>
