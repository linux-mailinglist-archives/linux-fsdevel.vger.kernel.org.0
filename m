Return-Path: <linux-fsdevel+bounces-73471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1AD1A436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74FAD3082D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03EF2ED84A;
	Tue, 13 Jan 2026 16:25:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D823C51D;
	Tue, 13 Jan 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321503; cv=none; b=oFIhAK49izXSJRMSYgoryL+abXI8/1BuQO4345moJt8SZAVRAQiWg7pi2WefOLi15FybOp5biokxoGbB5vZcL/vBdktWIqtxVIytLH9v/P+8gQ116JLkI5RXkXevmalsJ83na12LdQN06PbIT7n7XKSC8QKk7yIRgFfC6IbTtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321503; c=relaxed/simple;
	bh=U3y4Aj9jg/XmG6S7/BTbczsDrq1C4zgzKyQ2kpKoI2A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7D3iVC83bIOolHPFxR9UbYLGUzLoAfvH2BD/fuJOosAH+ZgAInb/4mgaI2ZBUrz/XuGA08ZhYv1GnGyoqRXMPn9Ndy5FsZtlpyqkjJsqcKZkoOiRfhwCrkceWeK20ezD0ftElR8gALu0knSVrKludO6iJPjzis+V+BafHyrm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drF2L5f5TzJ468V;
	Wed, 14 Jan 2026 00:24:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A5C640569;
	Wed, 14 Jan 2026 00:24:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 16:24:53 +0000
Date: Tue, 13 Jan 2026 16:24:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yosry Ahmed <yosry.ahmed@linux.dev>, <linux-mm@kvack.org>,
	<cgroups@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <kernel-team@meta.com>,
	<longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<ziy@nvidia.com>, <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <rppt@kernel.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<chrisl@kernel.org>, <kasong@tencent.com>, <shikemeng@huaweicloud.com>,
	<nphamcs@gmail.com>, <bhe@redhat.com>, <baohua@kernel.org>,
	<chengming.zhou@linux.dev>, <roman.gushchin@linux.dev>,
	<muchun.song@linux.dev>, <osalvador@suse.de>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>, <cl@gentwo.org>,
	<harry.yoo@oracle.com>, <zhengqi.arch@bytedance.com>
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <20260113162452.00000da9@huawei.com>
In-Reply-To: <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
	<20260108203755.1163107-8-gourry@gourry.net>
	<i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
	<aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
	<4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
	<aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)


...

> > Are we checking if the device has enough memory for the worst case
> > scenario (i.e. PAGE_SIZE)?
> > 
> > Or are we checking if the device can compress this specific page and
> > checking if it can compress it and store it? This seems like it could be
> > racy and there might be some throwaway work.
> >   
> 
> We essentially need to capture the current compression ratio and
> real-usage to determine whether there's another page available.
> 
> It is definitely racey, and the best we can do is set reasonable
> real-memory-usage limits to prevent ever finding ourselves in that
> scenario.  That most likely means requiring the hardware send an
> interrupt when usage and/or ratio hit some threshhold and setting a
> "NO ALLOCATION ALLOWED" bit.

I believe we could do some dance to close the race.

What we need is some upper bounds on usage at any point in time,
if that estimate is too high stop allocating until we get a better bound.

Can do that by starting an allocation counter before reading capacity.
As long as it only counts allocations (and not frees) then it will
always be an upper bound. 

Any frees will be dealt with when we reread current allocation (having
started a new counter of allocations just before that). Once we have
that new upper bound, can ignore the previous one as being less accurate.

If we see the interrupt, all bets are off. That's a fatal error in capacity
tracking.

> 
> But in software we can also try to query/track this as well, but we may
> not be able to query the device at allocation time (or at least that
> would be horribly non-performant).
> 
> So yeah, it's racy.

 
> > > 
> > > Thank you again for taking a look, this has been enlightening.  Good
> > > takeaways for the rest of the N_PRIVATE design.  
> > 
> > Thanks for kicking off the discussion here, an interesting problem to
> > solve for sure :)
> >   
> 
> One of the more interesting ones i've had in a few years :]

Agreed. Compressed memory is fun ;)
> 
> Cheers,
> ~Gregory


