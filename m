Return-Path: <linux-fsdevel+bounces-37822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953919F7F94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA31162774
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76922756F;
	Thu, 19 Dec 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJS1fZcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932415252D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625360; cv=none; b=gr+MlDcfUX5VXnvvRhOH5r5evZYLZ28Gg1dMTIPAOE7ax6eYsH6Mmy13HKsCOkomkj+dsyRiPwhbEe+fIwfxhAmMFWDL83ZPVrVUhJ8Rdg8xykl8YDzq4S0ryMKbEt7re9JkKPiHy7HiKfzMtuQVo4A0A8CfkYDa8S2zgYYHr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625360; c=relaxed/simple;
	bh=1wpUNpTYtHwWdwj0HDQ7B0JhVbrfic6k4xJTucLxAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+loTFSRZXEDHZRoDXS4XD9ZjbWQHfpZbbG062vHLkb3yXyn9NEFttp4woQM/UE57+iRWL+dGAhIQMFj+gmJ+SVXDe5+ksUMkX97ExDjeWN0EUsM0FkDua68jqszwAp1vQMYByVa98rUqZfzzBuD5eFEP/KnhXU39bQU/nH7M8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJS1fZcG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 08:22:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734625356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=492fyIcDZR0RXpAoh3ANPc363L8kEgmZve/YJhkN9Hc=;
	b=fJS1fZcGhQTNqd6lOMcOggQJX3WqRMss1RqIkRiHLqkJEPaZY0lOemOyFwVLx2OCTKcaRP
	0FbCrJJeggXD/2Z9NQ6R7KuBbb+Ea1Quyghnk6Jy3t34o+17Z3UnmC2gXdaXgPKfnqt18G
	AJocp3U59oUsNr/DpASos5BSTMUqFC8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 10:55:10AM -0500, Zi Yan wrote:
> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
> 
> > On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
> >> On 19.12.24 16:43, Shakeel Butt wrote:
> >>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
> >>>> On 23.11.24 00:23, Joanne Koong wrote:
> >>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> >>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
> >>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
> >>>>> writeback may take an indeterminate amount of time to complete, and
> >>>>> waits may get stuck.
> >>>>>
> >>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>> ---
> >>>>>    mm/migrate.c | 5 ++++-
> >>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>>> index df91248755e4..fe73284e5246 100644
> >>>>> --- a/mm/migrate.c
> >>>>> +++ b/mm/migrate.c
> >>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >>>>>    		 */
> >>>>>    		switch (mode) {
> >>>>>    		case MIGRATE_SYNC:
> >>>>> -			break;
> >>>>> +			if (!src->mapping ||
> >>>>> +			    !mapping_writeback_indeterminate(src->mapping))
> >>>>> +				break;
> >>>>> +			fallthrough;
> >>>>>    		default:
> >>>>>    			rc = -EBUSY;
> >>>>>    			goto out;
> >>>>
> >>>> Ehm, doesn't this mean that any fuse user can essentially completely block
> >>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
> >>>>
> >>>> That sounds very bad.
> >>>
> >>> The page under writeback are already unmovable while they are under
> >>> writeback. This patch is only making potentially unrelated tasks to
> >>> synchronously wait on writeback completion for such pages which in worst
> >>> case can be indefinite. This actually is solving an isolation issue on a
> >>> multi-tenant machine.
> >>>
> >> Are you sure, because I read in the cover letter:
> >>
> >> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
> >> support writable mmap"))), a temp page is allocated for every dirty
> >> page to be written back, the contents of the dirty page are copied over to
> >> the temp page, and the temp page gets handed to the server to write back.
> >> This is done so that writeback may be immediately cleared on the dirty
> >> page,"
> >>
> >> Which to me means that they are immediately movable again?
> >
> > Oh sorry, my mistake, yes this will become an isolation issue with the
> > removal of the temp page in-between which this series is doing. I think
> > the tradeoff is between extra memory plus slow write performance versus
> > temporary unmovable memory.
> 
> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
> temporary.

If you check the code just above this patch, this
mapping_writeback_indeterminate() check only happen for pages under
writeback which is a temp state. Anyways, fuse folios should not be
unmovable for their lifetime but only while under writeback which is
same for all fs.


