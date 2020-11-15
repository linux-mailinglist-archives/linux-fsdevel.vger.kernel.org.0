Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41D92B332C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 10:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKOJRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 04:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgKOJRR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 04:17:17 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B8422450;
        Sun, 15 Nov 2020 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605431835;
        bh=XrsLu3AgfKf/yhCqreqSLPfO0QbxjM5u1nh2OTK+i7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0I4G8XBAWR7g47zvvLF17b4q7dpa65b9wkXecvSGjBwSxVcsrFJ8ESXu8JFAv6n6
         sdRm52xntWf8ZCcumTh9FSor5j2JPuQESup2yC2R21JKmZx1500hzTDazlR+vjkiGB
         IVdV6hSWm3dBik27GJTFfn5JfaFip6aaLkmt9qWY=
Date:   Sun, 15 Nov 2020 11:17:00 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
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
Subject: Re: [PATCH v8 6/9] secretmem: add memcg accounting
Message-ID: <20201115091700.GY4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-7-rppt@kernel.org>
 <CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 03:42:25PM -0800, Roman Gushchin wrote:
> вт, 10 нояб. 2020 г. в 07:16, Mike Rapoport <rppt@kernel.org>:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/filemap.c   |  2 +-
> >  mm/secretmem.c | 42 +++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 249cf489f5df..11387a077373 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -844,7 +844,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
> >         page->mapping = mapping;
> >         page->index = offset;
> >
> > -       if (!huge) {
> > +       if (!huge && !page->memcg_data) {
> >                 error = mem_cgroup_charge(page, current->mm, gfp);
> >                 if (error)
> >                         goto error;
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 1aa2b7cffe0d..1eb7667016fa 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/memblock.h>
> >  #include <linux/pseudo_fs.h>
> > +#include <linux/memcontrol.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/sched/signal.h>
> >
> > @@ -49,6 +50,38 @@ struct secretmem_ctx {
> >
> >  static struct cma *secretmem_cma;
> >
> 
> Hi Mike!
> 
> > +static int secretmem_memcg_charge(struct page *page, gfp_t gfp, int order)
> > +{
> > +       unsigned long nr_pages = (1 << order);
> > +       int i, err;
> > +
> > +       err = memcg_kmem_charge_page(page, gfp, order);
> > +       if (err)
> > +               return err;
> > +
> > +       for (i = 1; i < nr_pages; i++) {
> > +               struct page *p = page + i;
> > +
> > +               p->memcg_data = page->memcg_data;
> > +       }
> 
> Hm, it looks very strange to me. Why do we need to copy memcg_data?
> What about css reference counting?

I need to copy memcg_data to mark a page as being accounted so it won't
be charged again when it is added to page cache.

What happens here is that I allocate a large page and then use it as a
local cache for allocations in secretmem_fault(). I charge the large
page as kmem. 

During secretmem_fault() a small sub-page from that large page goes into
page cache and there I skip its memcg accounting.

In the end, when the large page is freed, the memcg_data for all its
sub-pages is cleared and I uncharge memcg with the order of large page.

An alternative would be to uncharge a small page from kmem in
secretmem_fault() and make this page charged in add_to_page_cache(), but
that would complicate the release path as I would need to re-charge the
small page back to kmem at secretmem_freepage() and track all the
participating memcgs till the large page is freed.

> And what about statistics?

Hmm, that's probably won't be accurate :-/

> I'm sorry for being late.
> 
> Thank you!
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static void secretmem_memcg_uncharge(struct page *page, int order)
> > +{
> > +       unsigned long nr_pages = (1 << order);
> > +       int i;
> > +
> > +       for (i = 1; i < nr_pages; i++) {
> > +               struct page *p = page + i;
> > +
> > +               p->memcg_data = 0;
> > +       }
> > +
> > +       memcg_kmem_uncharge_page(page, PMD_PAGE_ORDER);
> > +}
> > +
> >  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >  {
> >         unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> > @@ -61,10 +94,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >         if (!page)
> >                 return -ENOMEM;
> >
> > -       err = set_direct_map_invalid_noflush(page, nr_pages);
> > +       err = secretmem_memcg_charge(page, gfp, PMD_PAGE_ORDER);
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
> > @@ -81,6 +118,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >          * won't fail
> >          */
> >         set_direct_map_default_noflush(page, nr_pages);
> > +err_memcg_uncharge:
> > +       secretmem_memcg_uncharge(page, PMD_PAGE_ORDER);
> >  err_cma_release:
> >         cma_release(secretmem_cma, page, nr_pages);
> >         return err;
> > @@ -310,6 +349,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
> >         int i;
> >
> >         set_direct_map_default_noflush(page, nr_pages);
> > +       secretmem_memcg_uncharge(page, PMD_PAGE_ORDER);
> >
> >         for (i = 0; i < nr_pages; i++)
> >                 clear_highpage(page + i);
> > --
> > 2.28.0
> >
> >

-- 
Sincerely yours,
Mike.
