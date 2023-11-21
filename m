Return-Path: <linux-fsdevel+bounces-3307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F87F2C24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FB7B218AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C748CCF;
	Tue, 21 Nov 2023 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78170122;
	Tue, 21 Nov 2023 03:54:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBD48FEC;
	Tue, 21 Nov 2023 03:55:29 -0800 (PST)
Received: from arm.com (e121798.cambridge.arm.com [10.1.197.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1103F7A6;
	Tue, 21 Nov 2023 03:54:38 -0800 (PST)
Date: Tue, 21 Nov 2023 11:54:36 +0000
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
Subject: Re: [PATCH RFC 20/37] mm: compaction: Reserve metadata storage in
 compaction_alloc()
Message-ID: <ZVyafCOxqfa7T130@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-21-alexandru.elisei@arm.com>
 <CAMn1gO67Lz_Xw5SCrq3fF4rOCSw3sXYK8qC77TTGnJeWd0b0Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO67Lz_Xw5SCrq3fF4rOCSw3sXYK8qC77TTGnJeWd0b0Sg@mail.gmail.com>

Hi Peter,

On Mon, Nov 20, 2023 at 08:49:32PM -0800, Peter Collingbourne wrote:
> Hi Alexandru,
> 
> On Wed, Aug 23, 2023 at 6:16 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > If the source page being migrated has metadata associated with it, make
> > sure to reserve the metadata storage when choosing a suitable destination
> > page from the free list.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  mm/compaction.c | 9 +++++++++
> >  mm/internal.h   | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index cc0139fa0cb0..af2ee3085623 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -570,6 +570,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >         bool locked = false;
> >         unsigned long blockpfn = *start_pfn;
> >         unsigned int order;
> > +       int ret;
> >
> >         /* Strict mode is for isolation, speed is secondary */
> >         if (strict)
> > @@ -626,6 +627,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >
> >                 /* Found a free page, will break it into order-0 pages */
> >                 order = buddy_order(page);
> > +               if (metadata_storage_enabled() && cc->reserve_metadata) {
> > +                       ret = reserve_metadata_storage(page, order, cc->gfp_mask);
> 
> At this point the zone lock is held and preemption is disabled, which
> makes it invalid to call reserve_metadata_storage.

You are correct, I missed that. I dropped reserving tag storage during
compaction in the next iteration, so fortunately I unintentionally fixed
it.

Thanks,
Alex

> 
> Peter
> 
> > +                       if (ret)
> > +                               goto isolate_fail;
> > +               }
> >                 isolated = __isolate_free_page(page, order);
> >                 if (!isolated)
> >                         break;
> > @@ -1757,6 +1763,9 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
> >         struct compact_control *cc = (struct compact_control *)data;
> >         struct folio *dst;
> >
> > +       if (metadata_storage_enabled())
> > +               cc->reserve_metadata = folio_has_metadata(src);
> > +
> >         if (list_empty(&cc->freepages)) {
> >                 isolate_freepages(cc);
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index d28ac0085f61..046cc264bfbe 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -492,6 +492,7 @@ struct compact_control {
> >                                          */
> >         bool alloc_contig;              /* alloc_contig_range allocation */
> >         bool source_has_metadata;       /* source pages have associated metadata */
> > +       bool reserve_metadata;
> >  };
> >
> >  /*
> > --
> > 2.41.0
> >

