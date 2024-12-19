Return-Path: <linux-fsdevel+bounces-37823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B49F7FB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF281657FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393D422759D;
	Thu, 19 Dec 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EqMg9tMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D36226529
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625576; cv=none; b=STEBc1zfla1MjY558nm1cmIQNMl4ydxLDBcQ9R5hJ74O7JN3zDhzxtG55XYWKxg1J2Lv1a9ATDfS3s7yPDEcO9HvjqGNw6eReiJ+hlSqcAYLOohmKg24dipzpRmHtUasym+WFVADdnN8tIfL81Xuy7nuxXv92zUUe+pr1LMpRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625576; c=relaxed/simple;
	bh=yTl49/5SyDtDf5d/CeGeEt8iy+L+9LcauV4ER98k70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElHDQKerROBgMs/RNj5K1BLdYL78JeDIstmi3Pz904Hci8rLEkQMN79bxCQCRDfHC+NTH8nYLax5lhpPT0BNFDpgfc+8n5Mccc4yz6VeXs6UVgIKqk6oTtQN5luHUU0iIGTh7qDFFiwiS2A/cSsOyrf/95UXDb+jD7nVWO1gyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EqMg9tMd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 08:26:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734625571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g2334SKBzcMIdlQx2V++5W2JrGnzx2vdgTttgjhEBtc=;
	b=EqMg9tMdhea/sTRb4Dl/bpMCc1JKcTvtrlJg8eZ2T82hwswf4mEoQjEchdk6Yr4IAGNhw4
	PW6Umw7Uohb53z1Mw3HtSbympx9IfJKVXg43K20LN8d/KTzTaxgJfWIHLFXsS926fvhSby
	7Zk/cg5RC43AtE/+jACCRaeuzPK4nUE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <7qyun2waznrduxpf2i5eebqdvpigrd5ycu4rlpawu336kqkyvh@xmfmlsmr43gw>
References: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
 <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
 <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
 <6FBDD501-25A0-4A21-8051-F8EE74AD177B@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FBDD501-25A0-4A21-8051-F8EE74AD177B@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 11:14:49AM -0500, Zi Yan wrote:
> On 19 Dec 2024, at 11:09, Bernd Schubert wrote:
> 
> > On 12/19/24 17:02, Zi Yan wrote:
> >> On 19 Dec 2024, at 11:00, Zi Yan wrote:
> >>> On 19 Dec 2024, at 10:56, Bernd Schubert wrote:
> >>>
> >>>> On 12/19/24 16:55, Zi Yan wrote:
> >>>>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
> >>>>>
> >>>>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
> >>>>>>> On 19.12.24 16:43, Shakeel Butt wrote:
> >>>>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
> >>>>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
> >>>>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> >>>>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
> >>>>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
> >>>>>>>>>> writeback may take an indeterminate amount of time to complete, and
> >>>>>>>>>> waits may get stuck.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>>>>>>> ---
> >>>>>>>>>>    mm/migrate.c | 5 ++++-
> >>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>>>>>>>> index df91248755e4..fe73284e5246 100644
> >>>>>>>>>> --- a/mm/migrate.c
> >>>>>>>>>> +++ b/mm/migrate.c
> >>>>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >>>>>>>>>>    		 */
> >>>>>>>>>>    		switch (mode) {
> >>>>>>>>>>    		case MIGRATE_SYNC:
> >>>>>>>>>> -			break;
> >>>>>>>>>> +			if (!src->mapping ||
> >>>>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
> >>>>>>>>>> +				break;
> >>>>>>>>>> +			fallthrough;
> >>>>>>>>>>    		default:
> >>>>>>>>>>    			rc = -EBUSY;
> >>>>>>>>>>    			goto out;
> >>>>>>>>>
> >>>>>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
> >>>>>>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
> >>>>>>>>>
> >>>>>>>>> That sounds very bad.
> >>>>>>>>
> >>>>>>>> The page under writeback are already unmovable while they are under
> >>>>>>>> writeback. This patch is only making potentially unrelated tasks to
> >>>>>>>> synchronously wait on writeback completion for such pages which in worst
> >>>>>>>> case can be indefinite. This actually is solving an isolation issue on a
> >>>>>>>> multi-tenant machine.
> >>>>>>>>
> >>>>>>> Are you sure, because I read in the cover letter:
> >>>>>>>
> >>>>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
> >>>>>>> support writable mmap"))), a temp page is allocated for every dirty
> >>>>>>> page to be written back, the contents of the dirty page are copied over to
> >>>>>>> the temp page, and the temp page gets handed to the server to write back.
> >>>>>>> This is done so that writeback may be immediately cleared on the dirty
> >>>>>>> page,"
> >>>>>>>
> >>>>>>> Which to me means that they are immediately movable again?
> >>>>>>
> >>>>>> Oh sorry, my mistake, yes this will become an isolation issue with the
> >>>>>> removal of the temp page in-between which this series is doing. I think
> >>>>>> the tradeoff is between extra memory plus slow write performance versus
> >>>>>> temporary unmovable memory.
> >>>>>
> >>>>> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
> >>>>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
> >>>>> temporary.
> >>>>
> >>>> Is there is a difference between FUSE TMP page being unmovable and
> >>>> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?
> >>
> >> (Fix my response location)
> >>
> >> Both are unmovable, but you can control where FUSE TMP page
> >> can come from to avoid spread across the entire memory space. For example,
> >> allocate a contiguous region as a TMP page pool.
> >
> > Wouldn't it make sense to have that for fuse writeback pages as well?
> > Fuse tries to limit dirty pages anyway.
> 
> Can fuse constraint the location of writeback pages? Something like what
> I proposed[1], migrating pages to a location before their writeback? Will
> that be a performance concern?
> 
> In terms of the number of dirty pages, you only need one page out of 512
> pages to prevent 2MB THP from allocation. For CMA allocation, one unmovable
> page can kill one contiguous range. What is the limit of fuse dirty pages?
> 
> [1] https://lore.kernel.org/linux-mm/90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com/

I think this whole concern of fuse making system memory unmovable
forever is overblown. Fuse is already using a temp (unmovable) page for
the writeback and is slow and is being removed in this series.

