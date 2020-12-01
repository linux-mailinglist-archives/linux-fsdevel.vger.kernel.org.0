Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8830D2CA83B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLAQ1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 11:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgLAQ1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:27:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BE1C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 08:26:42 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so5423315lfg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UJVLM5Dqv2cefS+n6lGrGwBWlmWKE0R3TDne+pe3Bs=;
        b=FOt9Uwe8mMuQpkLtE3HwADznhiQAPHIv5qbx/nee+V6fPYII6uwM8YcQa45LjSkNit
         xN2Ni8+aSuqbC8DEl3H2dRFy4L64QfRY26qmEwmobmvloqKDLa4Y1T1/tglSCSYyVjFz
         TGzZv08fH5E8I0xMZXZ35LySIHJ4y5qOxJCt/eRpg+i9AmdV1KYwf3RRe+21Bau3FyAk
         TgjcdVwXs+hgZ3oOPDOHLZRRpn3QIXgLlfeoSqj+PYEgRXxsUTvPB9z2raugESsDCDi7
         PoPjiizivTLMGsoEb5gLH/0USm8goY99nieSXEeif8xF9VTmKdzk9lvolETkT+NJW5OI
         E5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UJVLM5Dqv2cefS+n6lGrGwBWlmWKE0R3TDne+pe3Bs=;
        b=WFts0pprXUtCMaWcbCFTA/hgt57CM2B5puzXaLDHS8pvBZsG81kfkSb3a9VaYmse7d
         AdP+8hKnKiBl9IxEVD5rRxRfN2k0tKgGJPmq9ZcU/n2IyB0j9K0P0tiVhJwkHTo1Omt0
         GiQ9qEM9AI1hbToD022Yz9jMiSDbJyq6oLEGDy3EBaAVGmyrehqtJ0Xogjm0hma9eW9r
         Dg9bZ2jmaT49hikZfzujYc5Il+l4oNUtbjQVE7aB2j5zGS3OsPoVSZT62CznpcB8f9kX
         EP2Xp1QNDYNkiUoicit+GOdo1EQzSSqgyu6vyfz5q/K/WHTKajTShTtsxUxQGZvC2PjE
         ezUA==
X-Gm-Message-State: AOAM532/v3+tgm3whPoTIB0HZ9+REef38yg2afStD0LFp4XVPAi6kHV3
        BvIBAcwEDPSQ4aDlCAfbSkp18KFg7/hfHw4u4iIFHQ==
X-Google-Smtp-Source: ABdhPJytohNJ8iNZKzbCo9+sP2alA9aq9BKvpr0U+vIWUQXazYra1OUcGEIazvY7fNo2GDXrYBRdoJ+yVVYi2C5hE9o=
X-Received: by 2002:a19:cc42:: with SMTP id c63mr1600882lfg.521.1606840000078;
 Tue, 01 Dec 2020 08:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20201201074559.27742-1-rppt@kernel.org> <20201201074559.27742-8-rppt@kernel.org>
In-Reply-To: <20201201074559.27742-8-rppt@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Dec 2020 08:26:28 -0800
Message-ID: <CALvZod4bTBGf7DS=5EUCeU810p5C1aqf5sB0n1N8sc4jt5W3Tg@mail.gmail.com>
Subject: Re: [PATCH v13 07/10] secretmem: add memcg accounting
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
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:47 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/filemap.c   |  3 ++-
>  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 249cf489f5df..cf7f1dc9f4b8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -42,6 +42,7 @@
>  #include <linux/psi.h>
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
> +#include <linux/secretmem.h>
>  #include "internal.h"
>
>  #define CREATE_TRACE_POINTS
> @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
>         page->mapping = mapping;
>         page->index = offset;
>
> -       if (!huge) {
> +       if (!huge && !page_is_secretmem(page)) {
>                 error = mem_cgroup_charge(page, current->mm, gfp);
>                 if (error)
>                         goto error;
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 52a900a135a5..5e3e5102ad4c 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -18,6 +18,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/secretmem.h>
> +#include <linux/memcontrol.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
>
> @@ -44,6 +45,32 @@ struct secretmem_ctx {
>
>  static struct cma *secretmem_cma;
>
> +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> +{
> +       int err;
> +
> +       err = memcg_kmem_charge_page(page, gfp, order);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * seceremem caches are unreclaimable kernel allocations, so treat
> +        * them as unreclaimable slab memory for VM statistics purposes
> +        */
> +       mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> +                             PAGE_SIZE << order);
> +
> +       return 0;
> +}
> +
> +static void secretmem_unaccount_pages(struct page *page, int order)
> +{
> +
> +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> +                           -PAGE_SIZE << order);

mod_lruvec_page_state()

> +       memcg_kmem_uncharge_page(page, order);
> +}
> +
>  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
>         unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> @@ -56,10 +83,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>         if (!page)
>                 return -ENOMEM;
>
> -       err = set_direct_map_invalid_noflush(page, nr_pages);
> +       err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
>         if (err)
>                 goto err_cma_release;
>
> +       err = set_direct_map_invalid_noflush(page, nr_pages);
> +       if (err)
> +               goto err_memcg_uncharge;
> +
>         addr = (unsigned long)page_address(page);
>         err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
>         if (err)
> @@ -76,6 +107,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>          * won't fail
>          */
>         set_direct_map_default_noflush(page, nr_pages);
> +err_memcg_uncharge:
> +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>  err_cma_release:
>         cma_release(secretmem_cma, page, nr_pages);
>         return err;
> @@ -302,6 +335,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
>         int i;
>
>         set_direct_map_default_noflush(page, nr_pages);
> +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>
>         for (i = 0; i < nr_pages; i++)
>                 clear_highpage(page + i);
> --
> 2.28.0
>
