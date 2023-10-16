Return-Path: <linux-fsdevel+bounces-405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D97CA832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E85B20F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1F1F613;
	Mon, 16 Oct 2023 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D8273E2;
	Mon, 16 Oct 2023 12:40:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DCED1A6;
	Mon, 16 Oct 2023 05:40:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7541FB;
	Mon, 16 Oct 2023 05:40:51 -0700 (PDT)
Received: from monolith (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E092D3F5A1;
	Mon, 16 Oct 2023 05:40:05 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:40:39 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/37] mm: Add MIGRATE_METADATA allocation policy
Message-ID: <ZS0vRz6PlUJM8MN9@monolith>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-5-alexandru.elisei@arm.com>
 <CGME20231012013834epcas2p28ff3162673294077caef3b0794b69e72@epcas2p2.samsung.com>
 <20231012012824.GA2426387@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012012824.GA2426387@tiffany>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Oct 12, 2023 at 10:28:24AM +0900, Hyesoo Yu wrote:
> On Wed, Aug 23, 2023 at 02:13:17PM +0100, Alexandru Elisei wrote:
> > Some architectures implement hardware memory coloring to catch incorrect
> > usage of memory allocation. One such architecture is arm64, which calls its
> > hardware implementation Memory Tagging Extension.
> > 
> > So far, the memory which stores the metadata has been configured by
> > firmware and hidden from Linux. For arm64, it is impossible to to have the
> > entire system RAM allocated with metadata because executable memory cannot
> > be tagged. Furthermore, in practice, only a chunk of all the memory that
> > can have tags is actually used as tagged. which leaves a portion of
> > metadata memory unused. As such, it would be beneficial to use this memory,
> > which so far has been unaccessible to Linux, to service allocation
> > requests. To prepare for exposing this metadata memory a new migratetype is
> > being added to the page allocator, called MIGRATE_METADATA.
> > 
> > One important aspect is that for arm64 the memory that stores metadata
> > cannot have metadata associated with it, it can only be used to store
> > metadata for other pages. This means that the page allocator will *not*
> > allocate from this migratetype if at least one of the following is true:
> > 
> > - The allocation also needs metadata to be allocated.
> > - The allocation isn't movable. A metadata page storing data must be
> >   able to be migrated at any given time so it can be repurposed to store
> >   metadata.
> > 
> > Both cases are specific to arm64's implementation of memory metadata.
> > 
> > For now, metadata storage pages management is disabled, and it will be
> > enabled once the architecture-specific handling is added.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > [..]
> > @@ -2144,6 +2156,15 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> >  		if (alloc_flags & ALLOC_CMA)
> >  			page = __rmqueue_cma_fallback(zone, order);
> >  
> > +		/*
> > +		 * Allocate data pages from MIGRATE_METADATA only if the regular
> > +		 * allocation path fails to increase the chance that the
> > +		 * metadata page is available when the associated data page
> > +		 * needs it.
> > +		 */
> > +		if (!page && (alloc_flags & ALLOC_FROM_METADATA))
> > +			page = __rmqueue_metadata_fallback(zone, order);
> > +
> 
> Hi!
> 
> I guess it would cause non-movable page starving issue as CMA.

I don't understand what you mean by "non-movable page starving issue as
CMA". Would you care to elaborate?

> The metadata pages cannot be used for non-movable allocations.
> Metadata pages are utilized poorly, non-movable allocations may end up
> getting starved if all regular movable pages are allocated and the only
> pages left are metadata. If the system has a lot of CMA pages, then
> this problem would become more bad. I think it would be better to make
> use of it in places where performance is not critical, including some
> GFP_METADATA ?

GFP_METADATA pages must be used only for movable allocations. The kernel
must be able to migrate GFP_METADATA pages (if they have been allocated)
when they are reserved to serve as tag storage for a newly allocated tagged
page.

If you are referring to the fact that GFP_METADATA pages are allocated only
when there are no more free pages in the zone, then yes, I can understand
that that might be an issue. However, it's worth keeping in mind that if a
GFP_METADATA page is in use when it needs to be repurposed to serve as tag
storage, its contents must be migrated first, and this is obviously slow.

To put it another way, the more eager the page allocator is to allocate
from GFP_METADATA, the slower it will be to allocate tagged pages because
reserving the corresponding tag storage will be slow due to migration.

Before making a decision, I think it would be very helpful to run
performance tests with different allocation policies for GFP_METADATA. But I
would say that it's a bit premature for that, and I think it would be best
to wait until the series stabilizes.

And thank you for the feedback!

Alex

> 
> Thanks,
> Hyesoo Yu.

