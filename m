Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0168FB9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 00:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHXw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 18:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBHXwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:52:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588116ADA;
        Wed,  8 Feb 2023 15:52:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so1584859ejc.12;
        Wed, 08 Feb 2023 15:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7flmy3/jyFAU4sjWzJzGvCMw9yaMqfZS+04g1NY/TE=;
        b=Ac19gV4JVm98yvL3KzN2TixhwIUbkj9aMrZn/qmddD9VfS2zkLoJN2p5iZELDdEmCm
         1nhWn5VXYdY05fShRkrKDumjYjNjvW/EWJwmXqFKVTZZUz/xuhATAw5M8viT0xiLb8iE
         K0hT9wtXh85YS7T3g9ZbQ34lyS+LmnxNIFRxjrDpYyPTLmYDOKSjUa3hZS3/NLPW7y+Q
         3YF6sQFlIr0iZZcwlaSyx7ZdbKoUyRGYQSyxwiNTvvHEHoHPil5TSuC2vNBfxKrC2BH/
         JlQsc+/JynNioS/wKM/98dRwF6lVDEbC9/i9OSG9a58F/vWkKtTgLg5L2dofoIo0Kisu
         z4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7flmy3/jyFAU4sjWzJzGvCMw9yaMqfZS+04g1NY/TE=;
        b=WJmDPBdj3GHYoFjNdKmBZHb4Ab8o1TdMF/V6Zr8YmLqjV68fftdB+DY+cvgRViQC0x
         PxygV2MTieabEfvV+2I6pAjSX8uGsvzoeozF5ap6Fs0O+m6kQFGXJ62JjgHxtTP+Ci0l
         K/s9JKNjW6d8oFcVXDx2sCeWEdq9l7DfZ2rsJgHVm87oPlkq/ffEXyTDab1Z0O63zfEw
         9xFJXXVRJ9DlgRzXRo0A9v3IMjRbUXt7/LiR7XF6yjlAejlsZcyLJDi9wC+mlPYHa6gX
         wOhI9FFKIhlGb34OLynJG/EdNdaLIZ1/QDP61900kORH5OWpa9VA+uGWhUp8c2tu1jv5
         mTGQ==
X-Gm-Message-State: AO0yUKUZoyIfXE5xYJtCIoSnNG5fDRo4mbr8ITbIYU6t9W7vrXi2QLij
        hvKxEOsc9udXqFzcFmnH+c0J2RefYp9q2/N/HEA=
X-Google-Smtp-Source: AK7set83cYNIyE0vnJy611lFInZnOWMfKBNkj2YIsRgSBoiLIL9IVj9F3ehVTlCCPCJGIuFu+WIQNl29TZr3aodpGB0=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1309150ejc.12.1675900372409; Wed, 08
 Feb 2023 15:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-2-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 15:52:40 -0800
Message-ID: <CAEf4BzZHwXiLPuaAwz3vexzaJbBC90p5pCawbrsu4-Rk3XZOYw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] mm: Store build id in file object
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Storing build id in file object for elf executable with build
> id defined. The build id is stored when file is mmaped.
>
> The build id object assignment to the file is locked with existing
> file->f_mapping semaphore.
>
> It's hidden behind new config option CONFIG_FILE_BUILD_ID.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  fs/file_table.c         |  3 +++
>  include/linux/buildid.h | 17 ++++++++++++++++
>  include/linux/fs.h      |  3 +++
>  lib/buildid.c           | 44 +++++++++++++++++++++++++++++++++++++++++
>  mm/Kconfig              |  7 +++++++
>  mm/mmap.c               | 15 ++++++++++++++
>  6 files changed, 89 insertions(+)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index dd88701e54a9..d1c814cdb623 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -28,6 +28,7 @@
>  #include <linux/ima.h>
>  #include <linux/swap.h>
>  #include <linux/kmemleak.h>
> +#include <linux/buildid.h>
>
>  #include <linux/atomic.h>
>
> @@ -47,6 +48,7 @@ static void file_free_rcu(struct rcu_head *head)
>  {
>         struct file *f = container_of(head, struct file, f_rcuhead);
>
> +       file_build_id_free(f);
>         put_cred(f->f_cred);
>         kmem_cache_free(filp_cachep, f);
>  }
> @@ -412,6 +414,7 @@ void __init files_init(void)
>         filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
>                         SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
>         percpu_counter_init(&nr_files, 0, GFP_KERNEL);
> +       build_id_init();
>  }
>
>  /*
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3b7a0ff4642f..7c818085ad2c 100644
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

don't know if 21 vs 24 matters for kmem_cache_create(), but we don't
need 4 bytes to store build_id size, given max size is 20, so maybe
use u8 for sz?

> +};
> +
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>                    __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
> @@ -17,4 +23,15 @@ void init_vmlinux_build_id(void);
>  static inline void init_vmlinux_build_id(void) { }
>  #endif
>
> +#ifdef CONFIG_FILE_BUILD_ID
> +void __init build_id_init(void);
> +void build_id_free(struct build_id *bid);
> +int vma_get_build_id(struct vm_area_struct *vma, struct build_id **bidp);
> +void file_build_id_free(struct file *f);
> +#else
> +static inline void __init build_id_init(void) { }
> +static inline void build_id_free(struct build_id *bid) { }
> +static inline void file_build_id_free(struct file *f) { }
> +#endif /* CONFIG_FILE_BUILD_ID */
> +
>  #endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c1769a2c5d70..9ad5e5fbf680 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -975,6 +975,9 @@ struct file {
>         struct address_space    *f_mapping;
>         errseq_t                f_wb_err;
>         errseq_t                f_sb_err; /* for syncfs */
> +#ifdef CONFIG_FILE_BUILD_ID
> +       struct build_id         *f_bid;

naming nit: anything wrong with f_buildid or f_build_id? all the
related APIs use fully spelled out "build_id"

> +#endif
>  } __randomize_layout
>    __attribute__((aligned(4))); /* lest something weird decides that 2 is OK */
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index dfc62625cae4..7f6c3ca7b257 100644
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
> @@ -189,3 +190,46 @@ void __init init_vmlinux_build_id(void)
>         build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
>  }
>  #endif
> +
> +#ifdef CONFIG_FILE_BUILD_ID
> +
> +/* SLAB cache for build_id structures */
> +static struct kmem_cache *build_id_cachep;
> +
> +int vma_get_build_id(struct vm_area_struct *vma, struct build_id **bidp)
> +{
> +       struct build_id *bid;
> +       int err;
> +
> +       bid = kmem_cache_alloc(build_id_cachep, GFP_KERNEL);
> +       if (!bid)
> +               return -ENOMEM;
> +       err = build_id_parse(vma, bid->data, &bid->sz);
> +       if (err) {
> +               build_id_free(bid);
> +               /* ignore parsing error */
> +               return 0;
> +       }
> +       *bidp = bid;
> +       return 0;
> +}
> +
> +void file_build_id_free(struct file *f)
> +{
> +       build_id_free(f->f_bid);
> +}
> +
> +void build_id_free(struct build_id *bid)
> +{
> +       if (!bid)
> +               return;
> +       kmem_cache_free(build_id_cachep, bid);
> +}
> +
> +void __init build_id_init(void)
> +{
> +       build_id_cachep = kmem_cache_create("build_id", sizeof(struct build_id), 0,
> +                               SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
> +}
> +
> +#endif /* CONFIG_FILE_BUILD_ID */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ff7b209dec05..68911c3780c4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1183,6 +1183,13 @@ config LRU_GEN_STATS
>           This option has a per-memcg and per-node memory overhead.
>  # }
>
> +config FILE_BUILD_ID
> +       bool "Store build id in file object"
> +       default n
> +       help
> +         Store build id in file object for elf executable with build id
> +         defined. The build id is stored when file is mmaped.
> +
>  source "mm/damon/Kconfig"
>
>  endmenu
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 425a9349e610..a06f744206e3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2530,6 +2530,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>         pgoff_t vm_pgoff;
>         int error;
>         MA_STATE(mas, &mm->mm_mt, addr, end - 1);
> +       struct build_id *bid = NULL;
>
>         /* Check against address space limit. */
>         if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> @@ -2626,6 +2627,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                 if (error)
>                         goto unmap_and_free_vma;
>
> +#ifdef CONFIG_FILE_BUILD_ID
> +               if (vma->vm_flags & VM_EXEC && !file->f_bid) {
> +                       error = vma_get_build_id(vma, &bid);
> +                       if (error)
> +                               goto close_and_free_vma;

do we want to fail mmap_region() if we get -ENOMEM from
vma_get_build_id()? can't we just store ERR_PTR(error) in f_bid field?
So we'll have f_bid == NULL for non-exec files, ERR_PTR() for when we
tried and failed to get build ID, and a valid pointer if we succeeded?

> +               }
> +#endif
>                 /*
>                  * Expansion is handled above, merging is handled below.
>                  * Drivers should not alter the address of the VMA.
> @@ -2699,6 +2707,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                 if (vma->vm_flags & VM_SHARED)
>                         mapping_allow_writable(vma->vm_file->f_mapping);
>
> +#ifdef CONFIG_FILE_BUILD_ID
> +               if (bid && !file->f_bid)
> +                       file->f_bid = bid;
> +               else
> +                       build_id_free(bid);
> +#endif
>                 flush_dcache_mmap_lock(vma->vm_file->f_mapping);
>                 vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
>                 flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
> @@ -2759,6 +2773,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                 mapping_unmap_writable(file->f_mapping);
>  free_vma:
>         vm_area_free(vma);
> +       build_id_free(bid);
>  unacct_error:
>         if (charged)
>                 vm_unacct_memory(charged);
> --
> 2.39.1
>
