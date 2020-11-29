Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CFE2C7A3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgK2R1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 12:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2R1W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:27:22 -0500
Received: from kernel.org (unknown [87.71.85.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422E9206F4;
        Sun, 29 Nov 2020 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606670801;
        bh=193fTdj4a0UGUIyrwcsvt+1ylSiVDeNw4WwJgyyeI0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcPgX8dFSy9Ib9kWnBH2tRtaSziWbjbmm/b3KwtE1n5ZeUaApS9TIAbB17gPzKn16
         16Tdha8Hm4Jgj6OkL5MJvDw7grmc3v+aPRxni9lGCOKPmW+seMn30mlZzbCH+CCfcq
         1IVHreDWn8hVqwZBOZMP3h7CF/w11Dl4ALLVGb3o=
Date:   Sun, 29 Nov 2020 19:26:25 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
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
Subject: Re: [PATCH v12 07/10] secretmem: add memcg accounting
Message-ID: <20201129172625.GD557259@kernel.org>
References: <20201125092208.12544-1-rppt@kernel.org>
 <20201125092208.12544-8-rppt@kernel.org>
 <CALvZod4MoXod_YkbO+4k2=PS=xdMVbZa2HWWuUnMZ1G9hSr+Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4MoXod_YkbO+4k2=PS=xdMVbZa2HWWuUnMZ1G9hSr+Jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 29, 2020 at 07:53:45AM -0800, Shakeel Butt wrote:
> On Wed, Nov 25, 2020 at 1:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/filemap.c   |  3 ++-
> >  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 249cf489f5df..cf7f1dc9f4b8 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -42,6 +42,7 @@
> >  #include <linux/psi.h>
> >  #include <linux/ramfs.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/secretmem.h>
> >  #include "internal.h"
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
> >         page->mapping = mapping;
> >         page->index = offset;
> >
> > -       if (!huge) {
> > +       if (!huge && !page_is_secretmem(page)) {
> >                 error = mem_cgroup_charge(page, current->mm, gfp);
> >                 if (error)
> >                         goto error;
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 52a900a135a5..eb6628390444 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/secretmem.h>
> > +#include <linux/memcontrol.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/sched/signal.h>
> >
> > @@ -44,6 +45,32 @@ struct secretmem_ctx {
> >
> >  static struct cma *secretmem_cma;
> >
> > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > +{
> > +       int err;
> > +
> > +       err = memcg_kmem_charge_page(page, gfp, order);
> > +       if (err)
> > +               return err;
> > +
> > +       /*
> > +        * seceremem caches are unreclaimable kernel allocations, so treat
> > +        * them as unreclaimable slab memory for VM statistics purposes
> > +        */
> > +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> > +                           PAGE_SIZE << order);
> 
> Please use mod_lruvec_page_state() instead, so we get the memcg stats too.

Ok

> BTW I think secretmem deserves a vmstat entry instead of overloading
> NR_SLAB_UNRECLAIMABLE_B.

I'd prefer to wait with a dedicated vmstat for now. We can always add it
later, once we have better picture of secremem usage.

> > +
> > +       return 0;
> > +}
> > +
> > +static void secretmem_unaccount_pages(struct page *page, int order)
> > +{
> > +
> > +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> > +                           -PAGE_SIZE << order);
> > +       memcg_kmem_uncharge_page(page, order);
> > +}
> > +
> >  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >  {
> >         unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> > @@ -56,10 +83,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >         if (!page)
> >                 return -ENOMEM;
> >
> > -       err = set_direct_map_invalid_noflush(page, nr_pages);
> > +       err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
> >         if (err)
> >                 goto err_cma_release;
> >
> > +       err = set_direct_map_invalid_noflush(page, nr_pages);
> > +       if (err)
> > +               goto err_memcg_uncharge;
> > +
> >         addr = (unsigned long)page_address(page);
> >         err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
> >         if (err)
> > @@ -76,6 +107,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >          * won't fail
> >          */
> >         set_direct_map_default_noflush(page, nr_pages);
> > +err_memcg_uncharge:
> > +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
> >  err_cma_release:
> >         cma_release(secretmem_cma, page, nr_pages);
> >         return err;
> > @@ -302,6 +335,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
> >         int i;
> >
> >         set_direct_map_default_noflush(page, nr_pages);
> > +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
> >
> >         for (i = 0; i < nr_pages; i++)
> >                 clear_highpage(page + i);
> > --
> > 2.28.0
> >

-- 
Sincerely yours,
Mike.
