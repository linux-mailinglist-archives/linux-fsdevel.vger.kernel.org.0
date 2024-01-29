Return-Path: <linux-fsdevel+bounces-9359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D2840425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B13285EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA95FEEF;
	Mon, 29 Jan 2024 11:51:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A65FDA9;
	Mon, 29 Jan 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529101; cv=none; b=GtpEzJXHJfyeR+cKk5tSpbwbiWUWMZi/r/yZ6oMILy9agnCYMtCcgdNY/eqB80X/Ekx1tPTK/UdxP8nbZX1y1XuVrFUe9T16lLKAdQeBq/cC/qcpa/hDbloyBWbIczmQoFAWhm9sYWFhJhL2ua3QkmA7ThKATOvo2fAKIt0j0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529101; c=relaxed/simple;
	bh=Qv95v28qnP0te1WV1+cNFf3+tgBoXulZBw8bCh66O60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFfye7Ml6lf9nYzvp10yj+4oqpHLxQfqeNF8ceN986BfX6PvyrILMzVl0NTrhlJJBrMxL1ZPz5dzNPfjzUL2GJPo1tON+kii0/i/T4AKR/svfJ3fRFYkzCh05lkKIfaHJu+I75Sh2udUpL8rEyYWX89AUEz++JJINBUx1CcXjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D31E1FB;
	Mon, 29 Jan 2024 03:52:22 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407943F5A1;
	Mon, 29 Jan 2024 03:51:33 -0800 (PST)
Date: Mon, 29 Jan 2024 11:51:30 +0000
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
Subject: Re: [PATCH RFC v3 06/35] mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count
 the number of pages
Message-ID: <ZbeRQpGNnfXnjayQ@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-7-alexandru.elisei@arm.com>
 <0a71c87a-ae2c-4a61-8adb-3a51d6369b99@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a71c87a-ae2c-4a61-8adb-3a51d6369b99@arm.com>

Hi,

On Mon, Jan 29, 2024 at 02:54:20PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > The CMA_ALLOC_SUCCESS, respectively CMA_ALLOC_FAIL, are increased by one
> > after each cma_alloc() function call. This is done even though cma_alloc()
> > can allocate an arbitrary number of CMA pages. When looking at
> > /proc/vmstat, the number of successful (or failed) cma_alloc() calls
> > doesn't tell much with regards to how many CMA pages were allocated via
> > cma_alloc() versus via the page allocator (regular allocation request or
> > PCP lists refill).
> > 
> > This can also be rather confusing to a user who isn't familiar with the
> > code, since the unit of measurement for nr_free_cma is the number of pages,
> > but cma_alloc_success and cma_alloc_fail count the number of cma_alloc()
> > function calls.
> > 
> > Let's make this consistent, and arguably more useful, by having
> > CMA_ALLOC_SUCCESS count the number of successfully allocated CMA pages, and
> > CMA_ALLOC_FAIL count the number of pages the cma_alloc() failed to
> > allocate.
> > 
> > For users that wish to track the number of cma_alloc() calls, there are
> > tracepoints for that already implemented.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  mm/cma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/cma.c b/mm/cma.c
> > index f49c95f8ee37..dbf7fe8cb1bd 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -517,10 +517,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
> >  	pr_debug("%s(): returned %p\n", __func__, page);
> >  out:
> >  	if (page) {
> > -		count_vm_event(CMA_ALLOC_SUCCESS);
> > +		count_vm_events(CMA_ALLOC_SUCCESS, count);
> >  		cma_sysfs_account_success_pages(cma, count);
> >  	} else {
> > -		count_vm_event(CMA_ALLOC_FAIL);
> > +		count_vm_events(CMA_ALLOC_FAIL, count);
> >  		if (cma)
> >  			cma_sysfs_account_fail_pages(cma, count);
> >  	}
> 
> Without getting into the merits of this patch - which is actually trying to do
> semantics change to /proc/vmstat, wondering how is this even related to this
> particular series ? If required this could be debated on it's on separately.

Having the number of CMA pages allocated and the number of CMA pages freed
allows someone to infer how many tagged pages are in use at a given time:
(allocated CMA pages - CMA pages allocated by drivers* - CMA pages
released) * 32. That is valuable information for software and hardware
designers.

Besides that, for every iteration of the series, this has proven invaluable
for discovering bugs with freeing and/or reserving tag storage pages.

*that would require userspace reading cma_alloc_success and
cma_release_success before any tagged allocations are performed.

Thanks,
Alex

