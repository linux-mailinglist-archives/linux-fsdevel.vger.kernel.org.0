Return-Path: <linux-fsdevel+bounces-9357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571C84040D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ABB281AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0B5D8FE;
	Mon, 29 Jan 2024 11:46:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCA5FEEF;
	Mon, 29 Jan 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528783; cv=none; b=BzqkPbkPox+DdSbTuGUWx+1VLr0boNLRhlzfPDaAJOvKO4cQoA4PLrFnejY1SHUtFvyk/4rqx3CbA72tb6cdDqHdh5uLsAPoYtk0EFplsxCeV4a7TqatlkfNRs3kFaax5KtyBCiukLY9DRy91Jq88xDSXq/rQVrz8RNgwxduBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528783; c=relaxed/simple;
	bh=W20dwqMVEP/WMEY+AMYL2jqlplQiLjK5HZQ63ENtQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhwWCT5gGKc9fkd/Tf8/w/APgg4ZGY6L4to4kXvvkpZlvh+3LkwVDyggkmnqiGS1qLds7KQUknz1AQxhA9MbI22FZmxDMZMhM8BBZl7JzPvZNrJS2EamKUmy71cx/0a8LVtTUwuk91oBdLVeEEo+jnOTYYOoXPDJntoDf/gpht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E09CDA7;
	Mon, 29 Jan 2024 03:47:04 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0040D3F5A1;
	Mon, 29 Jan 2024 03:46:14 -0800 (PST)
Date: Mon, 29 Jan 2024 11:46:12 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 04/35] mm: page_alloc: Partially revert "mm:
 page_alloc: remove stale CMA guard code"
Message-ID: <ZbeQBDwe8zc_pLDZ@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-5-alexandru.elisei@arm.com>
 <966a1a84-76dc-40da-bde2-251d2a81ee31@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966a1a84-76dc-40da-bde2-251d2a81ee31@arm.com>

Hi,

On Mon, Jan 29, 2024 at 02:31:23PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > The patch f945116e4e19 ("mm: page_alloc: remove stale CMA guard code")
> > removed the CMA filter when allocating from the MIGRATE_MOVABLE pcp list
> > because CMA is always allowed when __GFP_MOVABLE is set.
> > 
> > With the introduction of the arch_alloc_cma() function, the above is not
> > true anymore, so bring back the filter.
> 
> This makes sense as arch_alloc_cma() now might prevent ALLOC_CMA being
> assigned to alloc_flags in gfp_to_alloc_flags_cma().

Can I add your Reviewed-by tag then?

Thanks,
Alex

> 
> > 
> > This is a partially revert because the stale comment remains removed.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  mm/page_alloc.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a96d47a6393e..0fa34bcfb1af 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2897,10 +2897,17 @@ struct page *rmqueue(struct zone *preferred_zone,
> >  	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> >  
> >  	if (likely(pcp_allowed_order(order))) {
> > -		page = rmqueue_pcplist(preferred_zone, zone, order,
> > -				       migratetype, alloc_flags);
> > -		if (likely(page))
> > -			goto out;
> > +		/*
> > +		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> > +		 * we need to skip it when CMA area isn't allowed.
> > +		 */
> > +		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> > +				migratetype != MIGRATE_MOVABLE) {
> > +			page = rmqueue_pcplist(preferred_zone, zone, order,
> > +					migratetype, alloc_flags);
> > +			if (likely(page))
> > +				goto out;
> > +		}
> >  	}
> >  
> >  	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,

