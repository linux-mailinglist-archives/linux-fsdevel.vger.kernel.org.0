Return-Path: <linux-fsdevel+bounces-4470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C67FF9D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0ED1F20F73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F55A0F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EE4131;
	Thu, 30 Nov 2023 09:43:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0867A1756;
	Thu, 30 Nov 2023 09:43:56 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526A93F6C4;
	Thu, 30 Nov 2023 09:43:04 -0800 (PST)
Date: Thu, 30 Nov 2023 17:43:01 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 21/27] mm: arm64: Handle tag storage pages mapped
 before mprotect(PROT_MTE)
Message-ID: <ZWjJpaSahUUM3GKs@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-22-alexandru.elisei@arm.com>
 <CAMn1gO5WYC5Xx7LfBxN_j-xqkVT+tjXP5PqDfrvhgqPOa0ZCsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO5WYC5Xx7LfBxN_j-xqkVT+tjXP5PqDfrvhgqPOa0ZCsA@mail.gmail.com>

Hi Peter,

On Mon, Nov 27, 2023 at 09:39:17PM -0800, Peter Collingbourne wrote:
> Hi Alexandru,
> 
> On Sun, Nov 19, 2023 at 8:59 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  arch/arm64/include/asm/mte_tag_storage.h |  1 +
> >  arch/arm64/kernel/mte_tag_storage.c      | 15 +++++++
> >  arch/arm64/mm/fault.c                    | 55 ++++++++++++++++++++++++
> >  include/linux/migrate.h                  |  8 +++-
> >  include/linux/migrate_mode.h             |  1 +
> >  mm/internal.h                            |  6 ---
> >  6 files changed, 78 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> > index b97406d369ce..6a8b19a6a758 100644
> > --- a/arch/arm64/include/asm/mte_tag_storage.h
> > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > @@ -33,6 +33,7 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
> >  void free_tag_storage(struct page *page, int order);
> >
> >  bool page_tag_storage_reserved(struct page *page);
> > +bool page_is_tag_storage(struct page *page);
> >
> >  vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
> >  vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index a1cc239f7211..5096ce859136 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -500,6 +500,21 @@ bool page_tag_storage_reserved(struct page *page)
> >         return test_bit(PG_tag_storage_reserved, &page->flags);
> >  }
> >
> > +bool page_is_tag_storage(struct page *page)
> > +{
> > +       unsigned long pfn = page_to_pfn(page);
> > +       struct range *tag_range;
> > +       int i;
> > +
> > +       for (i = 0; i < num_tag_regions; i++) {
> > +               tag_range = &tag_regions[i].tag_range;
> > +               if (tag_range->start <= pfn && pfn <= tag_range->end)
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> >  {
> >         unsigned long start_block, end_block;
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 6730a0812a24..964c5ae161a3 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/extable.h>
> >  #include <linux/kfence.h>
> >  #include <linux/signal.h>
> > +#include <linux/migrate.h>
> >  #include <linux/mm.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/init.h>
> > @@ -956,6 +957,50 @@ void tag_clear_highpage(struct page *page)
> >  }
> >
> >  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > +
> > +#define MR_TAGGED_TAG_STORAGE  MR_ARCH_1
> > +
> > +extern bool isolate_lru_page(struct page *page);
> > +extern void putback_movable_pages(struct list_head *l);
> 
> Could we move these declarations to a non-mm-internal header and
> #include it instead of manually declaring them here?

Yes, that's better than this hackish way of doing it.

> 
> > +
> > +/* Returns with the page reference dropped. */
> > +static void migrate_tag_storage_page(struct page *page)
> > +{
> > +       struct migration_target_control mtc = {
> > +               .nid = NUMA_NO_NODE,
> > +               .gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_TAGGED,
> > +       };
> > +       unsigned long i, nr_pages = compound_nr(page);
> > +       LIST_HEAD(pagelist);
> > +       int ret, tries;
> > +
> > +       lru_cache_disable();
> > +
> > +       for (i = 0; i < nr_pages; i++) {
> > +               if (!isolate_lru_page(page + i)) {
> > +                       ret = -EAGAIN;
> > +                       goto out;
> > +               }
> > +               /* Isolate just grabbed another reference, drop ours. */
> > +               put_page(page + i);
> > +               list_add_tail(&(page + i)->lru, &pagelist);
> > +       }
> > +
> > +       tries = 5;
> > +       while (tries--) {
> > +               ret = migrate_pages(&pagelist, alloc_migration_target, NULL, (unsigned long)&mtc,
> > +                                   MIGRATE_SYNC, MR_TAGGED_TAG_STORAGE, NULL);
> > +               if (ret == 0 || ret != -EBUSY)
> 
> This could be simplified to:
> 
> if (ret != -EBUSY)

Indeed! I can do the same thing in reserve_tag_storage(), in the loop where I
call alloc_contig_range().

Thanks,
Alex

