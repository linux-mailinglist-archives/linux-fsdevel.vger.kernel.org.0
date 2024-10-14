Return-Path: <linux-fsdevel+bounces-31925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103599DA68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 01:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E91281DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515601D9A6F;
	Mon, 14 Oct 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWvK83WT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9011D968F
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950239; cv=none; b=W1EI0onLl73HPohoERQXTa4qxxbNBBe0mjdwgqXf7qAF8ZE2BwsKQwk/eVTojb7Ud6vyX8BdGWEfkdJO+Zw3Xcj0Gxy0BB6ffv/M8t00oNzYV77AX8cbY5BAmFercnJnyxSwNqIEW2pni/qb7sjIc0VrM1kpYybX9aGUumwUuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950239; c=relaxed/simple;
	bh=RgeZD9Cxz3vszFWlIcoosWpbndEOPPsV0clDKfGFBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHPJ9av28ux9lXPvHKzGuwkGB9oqnYUes596L9rWrYzrEmokTv87TIM6d0nTD6BP05pckAZgfCf091Mv0yIGcpMCp8ELUBuVmjuFesh4GsOBZJf/8JalKjLvtlKykcxQKM9CxdbVNEIJ4un7z6j3PFV2bfhelj2kaoJhs7e5M+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mWvK83WT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 16:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728950234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPtL0QwGQ36eTFdq7R1HCyTduE83oafH5uKDVbXYQgM=;
	b=mWvK83WTq0UvMjPH1IwJ3BXZ0BXkWlzjsroDLTrXMX0xMwmxY1DPcCNtqVEnMeundOKrUU
	GTDXR6FBypfqdkjNnWJfyFWtwoPzrGZrXazqGd9LJf0DP/GwWJVloBzkZ688pT9ikEM/P7
	uIi/GMcGh9KN0rbEQMCG33+wjLHhHmM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm: skip reclaiming folios in writeback contexts
 that may trigger deadlock
Message-ID: <5yasw5ke7aqfp2g7kzj2uzrrmvblesywavs6qs3bdcpe4vkmv2@iwpivyu7kzgy>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-2-joannelkoong@gmail.com>
 <265keu5uzo3gzqrvhcn2cagii4sak3e2a372ra7jlav35fnkrx@aicyzyftun3l>
 <CAJnrk1Yrn3_eXPCrXDqA-5F2un33BAxrP=GdmrLw7bhtbGypjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yrn3_eXPCrXDqA-5F2un33BAxrP=GdmrLw7bhtbGypjA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 02:04:07PM GMT, Joanne Koong wrote:
> On Mon, Oct 14, 2024 at 11:38 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Oct 14, 2024 at 11:22:27AM GMT, Joanne Koong wrote:
> > > Currently in shrink_folio_list(), reclaim for folios under writeback
> > > falls into 3 different cases:
> > > 1) Reclaim is encountering an excessive number of folios under
> > >    writeback and this folio has both the writeback and reclaim flags
> > >    set
> > > 2) Dirty throttling is enabled (this happens if reclaim through cgroup
> > >    is not enabled, if reclaim through cgroupv2 memcg is enabled, or
> > >    if reclaim is on the root cgroup), or if the folio is not marked for
> > >    immediate reclaim, or if the caller does not have __GFP_FS (or
> > >    __GFP_IO if it's going to swap) set
> > > 3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
> > >    set and the caller did not have __GFP_FS (or __GFP_IO if swap) set
> > >
> > > In cases 1) and 2), we activate the folio and skip reclaiming it while
> > > in case 3), we wait for writeback to finish on the folio and then try
> > > to reclaim the folio again. In case 3, we wait on writeback because
> > > cgroupv1 does not have dirty folio throttling, as such this is a
> > > mitigation against the case where there are too many folios in writeback
> > > with nothing else to reclaim.
> > >
> > > The issue is that for filesystems where writeback may block, sub-optimal
> > > workarounds need to be put in place to avoid potential deadlocks that may
> > > arise from the case where reclaim waits on writeback. (Even though case
> > > 3 above is rare given that legacy cgroupv1 is on its way to being
> > > deprecated, this case still needs to be accounted for)
> > >
> > > For example, for FUSE filesystems, when a writeback is triggered on a
> > > folio, a temporary folio is allocated and the pages are copied over to
> > > this temporary folio so that writeback can be immediately cleared on the
> > > original folio. This additionally requires an internal rb tree to keep
> > > track of writeback state on the temporary folios. Benchmarks show
> > > roughly a ~20% decrease in throughput from the overhead incurred with 4k
> > > block size writes. The temporary folio is needed here in order to avoid
> > > the following deadlock if reclaim waits on writeback:
> > > * single-threaded FUSE server is in the middle of handling a request that
> > >   needs a memory allocation
> > > * memory allocation triggers direct reclaim
> > > * direct reclaim waits on a folio under writeback (eg falls into case 3
> > >   above) that needs to be written back to the fuse server
> > > * the FUSE server can't write back the folio since it's stuck in direct
> > >   reclaim
> > >
> > > This commit adds a new flag, AS_NO_WRITEBACK_RECLAIM, to "enum
> > > mapping_flags" which filesystems can set to signify that reclaim
> > > should not happen when the folio is already in writeback. This only has
> > > effects on the case where cgroupv1 memcg encounters a folio under
> > > writeback that already has the reclaim flag set (eg case 3 above), and
> > > allows for the suboptimal workarounds added to address the "reclaim wait
> > > on writeback" deadlock scenario to be removed.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/pagemap.h | 11 +++++++++++
> > >  mm/vmscan.c             |  6 ++++--
> > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 68a5f1ff3301..513a72b8451b 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > >       AS_STABLE_WRITES = 7,   /* must wait for writeback before modifying
> > >                                  folio contents */
> > >       AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */
> > > +     AS_NO_WRITEBACK_RECLAIM = 9, /* Do not reclaim folios under writeback */
> >
> > Isn't it "Do not wait for writeback completion for folios of this
> > mapping during reclaim"?
> 
> I think if we make this "don't wait for writeback completion for
> folios of this mapping during reclaim", then the
> mapping_no_writeback_reclaim check in shrink_folio_list() below would
> need to be something like this instead:
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 885d496ae652..37108d633d21 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1190,7 +1190,8 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                         /* Case 3 above */
>                         } else {
>                                 folio_unlock(folio);
> -                               folio_wait_writeback(folio);
> +                               if (mapping &&
> !mapping_no_writeback_reclaim(mapping))
> +                                       folio_wait_writeback(folio);
>                                 /* then go back and try same folio again */
>                                 list_add_tail(&folio->lru, folio_list);
>                                 continue;

The difference between the outcome for Case 2 and Case 3 is that in Case
2 the kernel is putting the folio in an active list and thus the kernel
will not try to reclaim it in near future but in Case 3, the kernel is
putting back in the list from which it is currently reclaiming meaning
the next iteration will try to reclaim the same folio.

We definitely don't want it in Case 3.

> 
> which I'm not sure if that would be the correct logic here or not.
> I'm not too familiar with vmscan, but it seems like if we are going to
> reclaim the folio then we should wait on it or else we would just keep
> trying the same folio again and again and wasting cpu cycles. In this
> current patch (if I'm understanding this mm code correctly), we skip
> reclaiming the folio altogether if it's under writeback.
> 
> Either one (don't wait for writeback during reclaim or don't reclaim
> under writeback) works for mitigating the potential fuse deadlock,
> but I was thinking "don't reclaim under writeback" might also be more
> generalizable to other filesystems.
> 
> I'm happy to go with whichever you think would be best.

Just to be clear that we are on the same page that this scenario should
be handled in Case 2. Our difference is on how to describe the scenario.
To me the reason we are taking the path of Case 2 is because we don't
want what Case 3 is doing and thus wrote that. Anyways I don't think it
is that importatnt, use whatever working seems reasonable to you.

BTW you will need to update the comment for Case 2 which is above code
block.

thanks,
Shakeel

