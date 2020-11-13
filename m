Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A02B294D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 00:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMXmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 18:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgKMXmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:42:39 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91370C0613D1;
        Fri, 13 Nov 2020 15:42:38 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v144so16523958lfa.13;
        Fri, 13 Nov 2020 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JqzzLgIvxHqw73GCku4Mas63TAVlMZ5DWuV5xVfKdKs=;
        b=B0r19MMZBS4qnPOpH3Oh7mviI2ESDdHEhgo+UT9aZXskXoEd9SnPfMI/JIQYxPxtOR
         EGdJ2X/BFGo2JIgPc7YKwL5OHO+C0iGUlcLt7SsFk5strPrUoRxXyWJ0RUiRQlWr4+Q9
         UGWo8SVcac0O9tQYHuBdOkO7NOuKdAMPi3UiVqcUEf+/yt3BCTCvkiiO9shXsZcgvKCI
         mqX10Qdfqu4P8JgnD2ndzSSlvwFINTNV0y8KdpRHFKCK3X2fikhgsl9ap1i9u5iJJjMW
         PWLkp0ZY+5TBxslo+fG0/WW3kZ1717ioHRkZ7oRtRA7lwDMuCMImPvZsEfTtSS5PpFGO
         gyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqzzLgIvxHqw73GCku4Mas63TAVlMZ5DWuV5xVfKdKs=;
        b=o8ZaDQwtEm6/C/WINt1pKyEGYhabIlkusnY7EFCJSrwWlF6qSZsgwLlptXoLU9Yrdb
         oo/YwSazqMijlA5wrZtQTDLzFVeJd1842NVyqbxvTrn8TJ26EJycNTBmctvXuADyikxx
         UwiNYvQFYEVgt6YZWh0in3XV/M8jq/f3IrCFQ1d4uwJkFPTSPeuPR/cBcvqYT3+PlANq
         YVc5ydKxfkFp2bcj6VMQteCih9bpzkRWVnd+vEmri0iNk8dujLspWtqWshgrFJBmbuek
         h+9u4zIqS34atpwXwuDSKgpMU0BYfDzBcwaTkBWM813clLMkCgEaDieiosISk5CrUOdD
         Awxw==
X-Gm-Message-State: AOAM531utgywuerEzI208zk1821zbvZgCmwNPedgP9/+vafzKrFsUuEL
        OTO+amHQVhNTTU/sUHYgrgYD0HzeFX+hXbHToEg=
X-Google-Smtp-Source: ABdhPJzhCiM/9It/85NbIdVKdebxXQcus40OOuN1h7PzHPVAvA/sjezmqkryt630ZVNrgKRfchCjAC+cyB3SFkLkebc=
X-Received: by 2002:a19:e84:: with SMTP id 126mr1806647lfo.432.1605310957017;
 Fri, 13 Nov 2020 15:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20201110151444.20662-1-rppt@kernel.org> <20201110151444.20662-7-rppt@kernel.org>
In-Reply-To: <20201110151444.20662-7-rppt@kernel.org>
From:   Roman Gushchin <guroan@gmail.com>
Date:   Fri, 13 Nov 2020 15:42:25 -0800
Message-ID: <CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] secretmem: add memcg accounting
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=D0=B2=D1=82, 10 =D0=BD=D0=BE=D1=8F=D0=B1. 2020 =D0=B3. =D0=B2 07:16, Mike =
Rapoport <rppt@kernel.org>:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/filemap.c   |  2 +-
>  mm/secretmem.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 249cf489f5df..11387a077373 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -844,7 +844,7 @@ static noinline int __add_to_page_cache_locked(struct=
 page *page,
>         page->mapping =3D mapping;
>         page->index =3D offset;
>
> -       if (!huge) {
> +       if (!huge && !page->memcg_data) {
>                 error =3D mem_cgroup_charge(page, current->mm, gfp);
>                 if (error)
>                         goto error;
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1aa2b7cffe0d..1eb7667016fa 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -17,6 +17,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
> +#include <linux/memcontrol.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
>
> @@ -49,6 +50,38 @@ struct secretmem_ctx {
>
>  static struct cma *secretmem_cma;
>

Hi Mike!

> +static int secretmem_memcg_charge(struct page *page, gfp_t gfp, int orde=
r)
> +{
> +       unsigned long nr_pages =3D (1 << order);
> +       int i, err;
> +
> +       err =3D memcg_kmem_charge_page(page, gfp, order);
> +       if (err)
> +               return err;
> +
> +       for (i =3D 1; i < nr_pages; i++) {
> +               struct page *p =3D page + i;
> +
> +               p->memcg_data =3D page->memcg_data;
> +       }

Hm, it looks very strange to me. Why do we need to copy memcg_data?
What about css reference counting?

And what about statistics?

I'm sorry for being late.

Thank you!

> +
> +       return 0;
> +}
> +
> +static void secretmem_memcg_uncharge(struct page *page, int order)
> +{
> +       unsigned long nr_pages =3D (1 << order);
> +       int i;
> +
> +       for (i =3D 1; i < nr_pages; i++) {
> +               struct page *p =3D page + i;
> +
> +               p->memcg_data =3D 0;
> +       }
> +
> +       memcg_kmem_uncharge_page(page, PMD_PAGE_ORDER);
> +}
> +
>  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
>         unsigned long nr_pages =3D (1 << PMD_PAGE_ORDER);
> @@ -61,10 +94,14 @@ static int secretmem_pool_increase(struct secretmem_c=
tx *ctx, gfp_t gfp)
>         if (!page)
>                 return -ENOMEM;
>
> -       err =3D set_direct_map_invalid_noflush(page, nr_pages);
> +       err =3D secretmem_memcg_charge(page, gfp, PMD_PAGE_ORDER);
>         if (err)
>                 goto err_cma_release;
>
> +       err =3D set_direct_map_invalid_noflush(page, nr_pages);
> +       if (err)
> +               goto err_memcg_uncharge;
> +
>         addr =3D (unsigned long)page_address(page);
>         err =3D gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
>         if (err)
> @@ -81,6 +118,8 @@ static int secretmem_pool_increase(struct secretmem_ct=
x *ctx, gfp_t gfp)
>          * won't fail
>          */
>         set_direct_map_default_noflush(page, nr_pages);
> +err_memcg_uncharge:
> +       secretmem_memcg_uncharge(page, PMD_PAGE_ORDER);
>  err_cma_release:
>         cma_release(secretmem_cma, page, nr_pages);
>         return err;
> @@ -310,6 +349,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *=
pool,
>         int i;
>
>         set_direct_map_default_noflush(page, nr_pages);
> +       secretmem_memcg_uncharge(page, PMD_PAGE_ORDER);
>
>         for (i =3D 0; i < nr_pages; i++)
>                 clear_highpage(page + i);
> --
> 2.28.0
>
>
