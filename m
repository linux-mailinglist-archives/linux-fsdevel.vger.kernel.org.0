Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B76BDB58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCPWIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPWIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:08:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01580E2C;
        Thu, 16 Mar 2023 15:07:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so13460272edc.3;
        Thu, 16 Mar 2023 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679004471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOALZKYk87ymZboEEVOkzREhSwRWC8GQ8w6I4E1YkJo=;
        b=in34xBPeQYTEL3b+BKWYiDFJx3fjRjzM45nuAeTfdrrDD+SWWbSuLVByYQSPYEtyh/
         LJkQvDM6AfBuXzaSQvLDL6bcHgVM/FajGW2t9QI7EO2B5nJmECSYxhcJUfEmnfjyfo6L
         3qEh4U2HU4IryoVbYf3ZfYRktGLQXtPrCFHjvzPXNoXBsG10nnJQkG8aq3PiT9E2PNZS
         Uox6zB00WGxZ2BPU1pXkkyPJ2utVt8tc8SLQCDX5k0/F7Gefv6BTc7YsFqcZB9tQOWQh
         jlPZyIpvOlWniEoEnLA+2EAJ3OY3tCqS65xiSA2BTnfXirOh5YvXVccb+i3BAUfqbe/b
         zb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOALZKYk87ymZboEEVOkzREhSwRWC8GQ8w6I4E1YkJo=;
        b=Cqx+6BNH43/FlhMY7O5z2uLsSN5RmgkazLtVZyy5RiGvDRknAp8fpBHTqUz5lpa5H4
         QCt48YkQuSfx3DDEZ5HIIliW9cWFTdLMRKKUX/PopPWmWZb71HyQF3BMpbIaJAhOi1WJ
         +o860pz+u8guMKwBTe7Bh5b5jTnooYRAZ0pqaXoYWM+RDw3s0rpHe3OF/WYeTb2okl7B
         xIFu7IUqyhMRM+1MFUtW5OzmX520/P6omZJV9sfA2VuKwAhzQZW7tqJEZAOfeS/BmELP
         4u77JAFv5PGPjtdTFnNxz6KA1RiLPv2YbkGqc0K0rZCqRNgwacJ3bTyF83gBRJZddSII
         KxJQ==
X-Gm-Message-State: AO0yUKUaXDaWaYPxhGeHa92gPIf6ouxK7K68KBkc3cajkxFQSkGjakOi
        qhsyCYG6yJNB/H0Dc6tb+9/DG1boY4/amGdq7/c=
X-Google-Smtp-Source: AK7set9oRcqczZSug6uQ8e1BvxXTQIFidg+bqwd+pyGq8dOPEHDoU7I4CesioNRco9SN/0FMKqK741L01oMq1AIZHP8=
X-Received: by 2002:a17:906:2b09:b0:931:ce20:db96 with SMTP id
 a9-20020a1709062b0900b00931ce20db96mr16322ejg.5.1679004470876; Thu, 16 Mar
 2023 15:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-2-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:07:38 -0700
Message-ID: <CAEf4BzbHk10Tt0h38dt=HLi5U9_4BoWN5NNiwjXy_KoBe2j=SQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/9] mm: Store build id in file object
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
> Storing build id in file object for elf executable with build
> id defined. The build id is stored when file is mmaped.
>
> The build id object assignment to the file is locked with existing
> file->f_mapping semaphore.
>
> The f_build_id pointer points either build id object or carries
> the error the build id retrieval failed on.
>
> It's hidden behind new config option CONFIG_FILE_BUILD_ID.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  fs/file_table.c         |  3 +++
>  include/linux/buildid.h | 17 +++++++++++++++++
>  include/linux/fs.h      |  7 +++++++
>  lib/buildid.c           | 42 +++++++++++++++++++++++++++++++++++++++++
>  mm/Kconfig              |  9 +++++++++
>  mm/mmap.c               | 18 ++++++++++++++++++
>  6 files changed, 96 insertions(+)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 372653b92617..d72f72503268 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -29,6 +29,7 @@
>  #include <linux/ima.h>
>  #include <linux/swap.h>
>  #include <linux/kmemleak.h>
> +#include <linux/buildid.h>
>
>  #include <linux/atomic.h>
>
> @@ -48,6 +49,7 @@ static void file_free_rcu(struct rcu_head *head)
>  {
>         struct file *f =3D container_of(head, struct file, f_rcuhead);
>
> +       file_build_id_free(f);
>         put_cred(f->f_cred);
>         kmem_cache_free(filp_cachep, f);
>  }
> @@ -413,6 +415,7 @@ void __init files_init(void)
>         filp_cachep =3D kmem_cache_create("filp", sizeof(struct file), 0,
>                         SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, N=
ULL);
>         percpu_counter_init(&nr_files, 0, GFP_KERNEL);
> +       build_id_init();
>  }
>
>  /*
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3b7a0ff4642f..b8b2e00420d6 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -3,9 +3,15 @@
>  #define _LINUX_BUILDID_H
>
>  #include <linux/mm_types.h>
> +#include <linux/slab.h>
>
>  #define BUILD_ID_SIZE_MAX 20
>
> +struct build_id {
> +       u32 sz;
> +       char data[BUILD_ID_SIZE_MAX];
> +};
> +
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>                    __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf=
_size);
> @@ -17,4 +23,15 @@ void init_vmlinux_build_id(void);
>  static inline void init_vmlinux_build_id(void) { }
>  #endif
>
> +#ifdef CONFIG_FILE_BUILD_ID
> +void __init build_id_init(void);
> +void build_id_free(struct build_id *bid);
> +void file_build_id_free(struct file *f);
> +void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bid=
p);
> +#else
> +static inline void __init build_id_init(void) { }
> +static inline void build_id_free(struct build_id *bid) { }
> +static inline void file_build_id_free(struct file *f) { }
> +#endif /* CONFIG_FILE_BUILD_ID */
> +
>  #endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..ce03fd965cdb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -977,6 +977,13 @@ struct file {
>         struct address_space    *f_mapping;
>         errseq_t                f_wb_err;
>         errseq_t                f_sb_err; /* for syncfs */
> +#ifdef CONFIG_FILE_BUILD_ID
> +       /*
> +        * Initialized when the file is mmaped (mmap_region),
> +        * guarded by f_mapping lock.
> +        */
> +       struct build_id         *f_build_id;
> +#endif
>  } __randomize_layout
>    __attribute__((aligned(4))); /* lest something weird decides that 2 is=
 OK */
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index dfc62625cae4..04181c0b7c21 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/slab.h>
>
>  #define BUILD_ID 3
>
> @@ -189,3 +190,44 @@ void __init init_vmlinux_build_id(void)
>         build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
>  }
>  #endif
> +
> +#ifdef CONFIG_FILE_BUILD_ID
> +
> +/* SLAB cache for build_id structures */
> +static struct kmem_cache *build_id_cachep;
> +
> +void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bid=
p)

this function clearly has a result to return, so why use void function
and out parameters instead of just returning `struct build_id *`?

> +{
> +       struct build_id *bid =3D ERR_PTR(-ENOMEM);
> +       int err;
> +
> +       bid =3D kmem_cache_alloc(build_id_cachep, GFP_KERNEL);
> +       if (!bid)
> +               goto out;
> +       err =3D build_id_parse(vma, bid->data, &bid->sz);
> +       if (err) {
> +               build_id_free(bid);
> +               bid =3D ERR_PTR(err);
> +       }

[...]
