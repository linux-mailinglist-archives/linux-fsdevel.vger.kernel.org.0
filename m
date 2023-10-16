Return-Path: <linux-fsdevel+bounces-406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4A7CA835
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D5B1C20AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A31D551;
	Mon, 16 Oct 2023 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B110273D2;
	Mon, 16 Oct 2023 12:40:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDCF7D76;
	Mon, 16 Oct 2023 05:40:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2672F4;
	Mon, 16 Oct 2023 05:41:28 -0700 (PDT)
Received: from monolith (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A323F5A1;
	Mon, 16 Oct 2023 05:40:41 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:41:15 +0100
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
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZS0va9nICZo8bF03@monolith>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010074823.GA2536665@tiffany>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Thu, Oct 12, 2023 at 10:25:11AM +0900, Hyesoo Yu wrote:
> On Wed, Aug 23, 2023 at 02:13:19PM +0100, Alexandru Elisei wrote:
> > pcp lists keep MIGRATE_METADATA pages on the MIGRATE_MOVABLE list. Make
> > sure pages from the movable list are allocated only when the
> > ALLOC_FROM_METADATA alloc flag is set, as otherwise the page allocator
> > could end up allocating a metadata page when that page cannot be used.
> > 
> > __alloc_pages_bulk() sidesteps rmqueue() and calls __rmqueue_pcplist()
> > directly. Add a check for the flag before calling __rmqueue_pcplist(), and
> > fallback to __alloc_pages() if the check is false.
> > 
> > Note that CMA isn't a problem for __alloc_pages_bulk(): an allocation can
> > always use CMA pages if the requested migratetype is MIGRATE_MOVABLE, which
> > is not the case with MIGRATE_METADATA pages.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  mm/page_alloc.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 829134a4dfa8..a693e23c4733 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2845,11 +2845,16 @@ struct page *rmqueue(struct zone *preferred_zone,
> >  
> >  	if (likely(pcp_allowed_order(order))) {
> >  		/*
> > -		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> > -		 * we need to skip it when CMA area isn't allowed.
> > +		 * PCP lists keep MIGRATE_CMA/MIGRATE_METADATA pages on the same
> > +		 * movable list. Make sure it's allowed to allocate both type of
> > +		 * pages before allocating from the movable list.
> >  		 */
> > -		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> > -				migratetype != MIGRATE_MOVABLE) {
> > +		bool movable_allowed = (!IS_ENABLED(CONFIG_CMA) ||
> > +					(alloc_flags & ALLOC_CMA)) &&
> > +				       (!IS_ENABLED(CONFIG_MEMORY_METADATA) ||
> > +					(alloc_flags & ALLOC_FROM_METADATA));
> > +
> > +		if (migratetype != MIGRATE_MOVABLE || movable_allowed) {
> 
> Hi!
> 
> I don't think it would be effcient when the majority of movable pages
> do not use GFP_TAGGED.
> 
> Metadata pages have a low probability of being in the pcp list
> because metadata pages is bypassed when freeing pages.
> 
> The allocation performance of most movable pages is likely to decrease
> if only the request with ALLOC_FROM_METADATA could be allocated.

You're right, I hadn't considered that.

> 
> How about not including metadata pages in the pcp list at all ?

Sounds reasonable, I will keep it in mind for the next iteration of the
series.

Thanks,
Alex

> 
> Thanks,
> Hyesoo Yu.
> 
> >  			page = rmqueue_pcplist(preferred_zone, zone, order,
> >  					migratetype, alloc_flags);
> >  			if (likely(page))
> > @@ -4388,6 +4393,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >  		goto out;
> >  	gfp = alloc_gfp;
> >  
> > +	/*
> > +	 * pcp lists puts MIGRATE_METADATA on the MIGRATE_MOVABLE list, don't
> > +	 * use pcp if allocating metadata pages is not allowed.
> > +	 */
> > +	if (metadata_storage_enabled() && ac.migratetype == MIGRATE_MOVABLE &&
> > +	    !(alloc_flags & ALLOC_FROM_METADATA))
> > +		goto failed;
> > +
> >  	/* Find an allowed local zone that meets the low watermark. */
> >  	for_each_zone_zonelist_nodemask(zone, z, ac.zonelist, ac.highest_zoneidx, ac.nodemask) {
> >  		unsigned long mark;
> > -- 
> > 2.41.0
> > 
> > 



