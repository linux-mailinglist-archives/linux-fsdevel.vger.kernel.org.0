Return-Path: <linux-fsdevel+bounces-9360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1CF840455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7BD1C227A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0260253;
	Mon, 29 Jan 2024 11:53:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4886027C;
	Mon, 29 Jan 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529214; cv=none; b=mnT/8jm0/58HfAX/GEkqGr0oWF/wSJKiYvD/CjqioWP4DHUXUp2HuAyKef123q8DhGBGlUvS61pIWoEe7KCYszihrAu0a0li7/K8se6p5pIpajQa1ZtZOFxq2sRUSxv9XrL+4fxuH1oKyJqLpARoxXMxdGNP3OgteDVx0PExZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529214; c=relaxed/simple;
	bh=9L2UF9+dZdtAdzD8GbLISbEH+QTdRBWmwSLckqatatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVj1tJYvOqNOU2TwIkrzYOgKds7xRWmN5V54qQc5JIfz7tVAbuWFz3K7ph0BYNH4PrSqovUgt+DbwCjda3ReVZrRXf+23btrGtv8DMilqe2ZG6G0NA6M9n96EZEHl0K1dv9dn1B2e2GkOQJnf/qRxOZj5mwM1UmTAp23VXdPZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC471FB;
	Mon, 29 Jan 2024 03:54:15 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830E13F5A1;
	Mon, 29 Jan 2024 03:53:26 -0800 (PST)
Date: Mon, 29 Jan 2024 11:53:23 +0000
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
Subject: Re: [PATCH RFC v3 07/35] mm: cma: Add CMA_RELEASE_{SUCCESS,FAIL}
 events
Message-ID: <ZbeRs-vIDWGlpcGV@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-8-alexandru.elisei@arm.com>
 <545bb7bd-31c7-4166-9f81-778b82ece6d4@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545bb7bd-31c7-4166-9f81-778b82ece6d4@arm.com>

Hi,

On Mon, Jan 29, 2024 at 03:01:24PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > Similar to the two events that relate to CMA allocations, add the
> > CMA_RELEASE_SUCCESS and CMA_RELEASE_FAIL events that count when CMA pages
> > are freed.
> 
> How is this is going to be beneficial towards analyzing CMA alloc/release
> behaviour - particularly with respect to this series. OR just adding this
> from parity perspective with CMA alloc side counters ? Regardless this
> CMA change too could be discussed separately.

Added for parity and because it's useful for this series (see my reply to
the previous patch where I discuss how I've used the counters).

Thanks,
Alex

> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * New patch.
> > 
> >  include/linux/vm_event_item.h | 2 ++
> >  mm/cma.c                      | 6 +++++-
> >  mm/vmstat.c                   | 2 ++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index 747943bc8cc2..aba5c5bf8127 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -83,6 +83,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  #ifdef CONFIG_CMA
> >  		CMA_ALLOC_SUCCESS,
> >  		CMA_ALLOC_FAIL,
> > +		CMA_RELEASE_SUCCESS,
> > +		CMA_RELEASE_FAIL,
> >  #endif
> >  		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
> >  		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
> > diff --git a/mm/cma.c b/mm/cma.c
> > index dbf7fe8cb1bd..543bb6b3be8e 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -562,8 +562,10 @@ bool cma_release(struct cma *cma, const struct page *pages,
> >  {
> >  	unsigned long pfn;
> >  
> > -	if (!cma_pages_valid(cma, pages, count))
> > +	if (!cma_pages_valid(cma, pages, count)) {
> > +		count_vm_events(CMA_RELEASE_FAIL, count);
> >  		return false;
> > +	}
> >  
> >  	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
> >  
> > @@ -575,6 +577,8 @@ bool cma_release(struct cma *cma, const struct page *pages,
> >  	cma_clear_bitmap(cma, pfn, count);
> >  	trace_cma_release(cma->name, pfn, pages, count);
> >  
> > +	count_vm_events(CMA_RELEASE_SUCCESS, count);
> > +
> >  	return true;
> >  }
> >  
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index db79935e4a54..eebfd5c6c723 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1340,6 +1340,8 @@ const char * const vmstat_text[] = {
> >  #ifdef CONFIG_CMA
> >  	"cma_alloc_success",
> >  	"cma_alloc_fail",
> > +	"cma_release_success",
> > +	"cma_release_fail",
> >  #endif
> >  	"unevictable_pgs_culled",
> >  	"unevictable_pgs_scanned",

