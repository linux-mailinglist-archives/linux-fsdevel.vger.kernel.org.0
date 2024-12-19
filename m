Return-Path: <linux-fsdevel+bounces-37827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB49F8018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3D3188A403
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D622687C;
	Thu, 19 Dec 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OztNAEf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002EF2AE96
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626453; cv=none; b=DXyRortFb5Hupw0zogzPqUnty7cmMqmAqXQGjchrbKU5Jk+jKn5/L1ch3BZzmqFBME8rTpSsILHir6LNYXNoFdcCMr8e0ohW6MdXOHrxb5NBSmOeWWqodk/VujZkvtS+ddooFDT9/hu8OwtNrUx823oszxTYMHN9BCfmSNZ4zck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626453; c=relaxed/simple;
	bh=QazBR5jTUYmbMkyUp8ziiK45jUfncM0lKIk+VYJp5gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1vDI0vZz6aW6lO4JCEMYGvJ7Ml2vgGAWJ8jSTYeiflzHhbALHC5hN9A/IE5KSYfftUv2yrERyEkRvpnX2XTCLABlRk30u8+e2F363QWmS10b6RZ+U2l0996A/7YXLWJSRtk29IzZj7G/tziL9QUbW9BoGgCAkcSWZlXrSBuwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OztNAEf4; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 08:40:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734626449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWPJuiiJybDd1Rz94btJfDZ/lmxqC2aRO87v8CIWY9o=;
	b=OztNAEf4VQcRYqQ8PjONb0fiIA+KLKq1ajAKT58JAgzQlRbVHeNd5LBYRabfA1K7ZHHsk5
	HG7Zug/9UNJ6vlR+8JiRtBembrH6i6Rq2F3Rm+R7ZRZ8ZC+AhKSwBkMAWYE25AM6/JEetb
	RyKjyH73LrAq5RSUFXIBvm+jFnlaun8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
[...]
> > 
> > If you check the code just above this patch, this
> > mapping_writeback_indeterminate() check only happen for pages under
> > writeback which is a temp state. Anyways, fuse folios should not be
> > unmovable for their lifetime but only while under writeback which is
> > same for all fs.
> 
> But there, writeback is expected to be a temporary thing, not possibly:
> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> 
> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> guarantees, and unfortunately, it sounds like this is the case here, unless
> I am missing something important.
> 

It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
the confusion. The writeback state is not indefinite. A proper fuse fs,
like anyother fs, should handle writeback pages appropriately. These
additional checks and skips are for (I think) untrusted fuse servers.
Personally I think waiting indefinitely on writeback, particularly for
sync compaction, should be fine but fuse maintainers want to avoid
scenarios where an untrusted fuse server can force such stalls in other
jobs. Yes, this will not solve the untrusted fuse server causing
fragmentation issue but that is the risk of running untrusted fuse
server, IMHO.


