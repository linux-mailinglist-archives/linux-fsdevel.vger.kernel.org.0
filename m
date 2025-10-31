Return-Path: <linux-fsdevel+bounces-66542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B518C22ECE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E53424AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB826ED25;
	Fri, 31 Oct 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1PJllnbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD611898F8;
	Fri, 31 Oct 2025 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875715; cv=none; b=UjXMTauk1Cw7gbisl1LE+ECToN4g+yAR1nVndRfFkyH4PZq73IRz4hAsQoex+vdybcNMpSR2WKc940Z+yhvIgQ3Jv7RX1nPYXjjG+9Whin5uVzxKnBUEAbQ+q5I5kBnNe0Wd+G1ciaCwzTxF2SiCiYly955bO+qL4EpmTg9PCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875715; c=relaxed/simple;
	bh=M+BOJ/OBQpKo/ETGkXYxnnjjC62dEeaIxIajvQYcOfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IHxcbPGjDD8f29pYsR+ueNtbzm8POYvEtkUGC+JQExg/f1oB/STMVj5VjgIk0LECpYK9sZJVK9MHweM68NeHV2rylvqfHf6a7OffNjvcQe/hNwi+7Hz1c3riXpEpKh8K30x3+z1bnjwsJhEXJX2u9akD8tSmCynptRc8viM4j5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1PJllnbf; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FuRkASDZGC+sxqL3DYTg3OeS7+jWMa3JBcSB0zkywCw=;
	b=1PJllnbfIbkvN0pKBGCG9TvvyYM4KGWr7n3wEXphZXHtJ4dimURefifOMidnDOs+bfUqeOF/4
	OAEbwCDFZydkX1/3puSsGcf2swvVu2LEN3zhuUZkJIiN22z9kddenEuUrN/H1xkv2rk5oQu2eSC
	o5hUppPjT4EJIbxE0/pOPNQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cyPCs5FPtz1T4Fg;
	Fri, 31 Oct 2025 09:54:01 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EB2F0140156;
	Fri, 31 Oct 2025 09:55:07 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 09:55:06 +0800
Message-ID: <6899c98c-b31b-4827-979c-935f833ed332@huawei.com>
Date: Fri, 31 Oct 2025 09:55:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
 <aQPX1-XWQjKaMTZB@casper.infradead.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aQPX1-XWQjKaMTZB@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-10-31 05:25, Matthew Wilcox wrote:
> On Sat, Oct 25, 2025 at 02:32:45PM +0800, Baokun Li wrote:
>> On 2025-10-25 12:45, Matthew Wilcox wrote:
>>> No, absolutely not.  We're not having open-coded GFP_NOFAIL semantics.
>>> The right way forward is for ext4 to use iomap, not for buffer heads
>>> to support large block sizes.
>> ext4 only calls getblk_unmovable or __getblk when reading critical
>> metadata. Both of these functions set __GFP_NOFAIL to ensure that
>> metadata reads do not fail due to memory pressure.
>>
>> Both functions eventually call grow_dev_folio(), which is why we
>> handle the __GFP_NOFAIL logic there. xfs_buf_alloc_backing_mem()
>> has similar logic, but XFS manages its own metadata, allowing it
>> to use vmalloc for memory allocation.
> In today's ext4 call, we discussed various options:
>
> 1. Change folios to be potentially fragmented.  This change would be
> ridiculously large and nobody thinks this is a good idea.  Included here
> for completeness.
>
> 2. Separate the buffer cache from the page cache again.  They were
> unified about 25 years ago, and this also feels like a very big job.
>
> 3. Duplicate the buffer cache into ext4/jbd2, remove the functionality
> not needed and make _this_ version of the buffer cache allocate
> its own memory instead of aliasing into the page cache.  More feasible
> than 1 or 2; still quite a big job.
>
> 4. Pick up Catherine's work and make ext4/jbd2 use it.  Seems to be
> about an equivalent amount of work to option 3.
>
> 5. Make __GFP_NOFAIL work for allocations up to 64KiB (we decided this was
> probably the practical limit of sector sizes that people actually want).
> In terms of programming, it's a one-line change.  But we need to sell
> this change to the MM people.  I think it's doable because if we have
> a filesystem with 64KiB sectors, there will be many clean folios in the
> pagecache which are 64KiB or larger.
>
> So, we liked option 5 best.
>
Thank you for your suggestions! 

Yes, options 1 and 2 don’t seem very feasible, and options 3 and 4 would
involve a significant amount of work. Option 5 is indeed the simplest and
most general solution at this point, and it makes a lot of sense.

I will send a separate RFC patch to the MM list to gather feedback from the
MM people. If this approach is accepted, we can drop patches 22 and 23 from
the current series.


Cheers,
Baokun



