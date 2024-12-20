Return-Path: <linux-fsdevel+bounces-37916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA59F8D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC037A2E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977561A7AD0;
	Fri, 20 Dec 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a0DDExwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84315689A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681329; cv=none; b=QpqM0JqFb39n8I2MYS1sxGt/K4xDONOR4TBstaRjPRS1pHFDjZeW92kxWD9EkeyjDf9c+QZJ36aeKonoNbAgXYngGG3PyplT1wfPe4p7X5lNDhDqB8XELvF9Bbr58A+NtS4PWmeTA/fTxAEPgF7kWPdD9UPNkqB19Tjl27mOod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681329; c=relaxed/simple;
	bh=ttCIJYSrJc0QeV9gYw95Nt2U4MmzgjX6CVNoDNaYrD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/SRAUKZwg9djFR8l+6UPtq/1ufwV3lZdhk8yZeqE8UAuWoMHz3QPauh0Cok26rkHUwjZuvnrnnHFdVexqU4+mrQMNphGNPuHiMru3hrlijxTaIxzNd0UHzlxdGLmlBBxDn98KLOrUe2E+nCCuceiEIKxwgZTBATMnjgVzqjTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a0DDExwV; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734681318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tVyznk1MiTHebBKMKhfRPBkSTeZN6lQ08O5azolZKAM=;
	b=a0DDExwVLz4BVCsuQ+Bd104HUQxIwYdFviBZKyx9RgwThfSW83ni6NWRnp9iQ+tkw+Bzx2KoWrfZa50WsLrZHFyuhZW8mkpuO0sBeloq4B85f+5jtcembH640LWsMEzulJ0wHWrFfCcEYK6r5vBGJTh0BPSwpITCdeOJlClpRKY=
Received: from 30.221.145.251(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLt4y4q_1734681315 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 15:55:16 +0800
Message-ID: <d48ae58e-500f-4ef1-bc6f-a41a8f5b94bf@linux.alibaba.com>
Date: Fri, 20 Dec 2024 15:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/20/24 12:41 AM, David Hildenbrand wrote:
> On 19.12.24 17:40, Shakeel Butt wrote:
>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
>> [...]
>>>>
>>>> If you check the code just above this patch, this
>>>> mapping_writeback_indeterminate() check only happen for pages under
>>>> writeback which is a temp state. Anyways, fuse folios should not be
>>>> unmovable for their lifetime but only while under writeback which is
>>>> same for all fs.
>>>
>>> But there, writeback is expected to be a temporary thing, not possibly:
>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>>
>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>>> guarantees, and unfortunately, it sounds like this is the case here,
>>> unless
>>> I am missing something important.
>>>
>>
>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
>> the confusion. The writeback state is not indefinite. A proper fuse fs,
>> like anyother fs, should handle writeback pages appropriately. These
>> additional checks and skips are for (I think) untrusted fuse servers.
> 
> Can unprivileged user space provoke this case?
> 

There are some details on the initial problem that FUSE community wants
to fix [1].

In summary, a non-malicious fuse daemon may need to allocate some memory
when processing a FUSE_WRITE request (initiated from the writeback
routine), in which case memory reclaim and compaction is triggered when
allocating memory, which in turn leads to waiting on the writeback of
**FUSE** dirty pages (which itself waits for the fuse daemon to handle
it) - a deadlock here.

The current FUSE implementation fixes this by introducing "temp page" in
the writeback routine for FUSE.  In short, a temporary page (allocated
from ZONE_UNMOVABLE) is allocated for each dirty page cache needs to be
written back.  The content is copied from the original page cache to the
temporary page.  And then the original page cache (to writeback,
allocated from ZONE_MOVABLE) clears PG_writeback bit immediately, so
that the fuse daemon won't possibly stuck in deadlock waiting for the
writeback of FUSE page cache.  Instead, the actual writeback work is
done upon the cloned temporary page then.

Thus there are actually two pages for each FUSE page cache, one is the
original FUSE page cache (in ZONE_MOVABLE) and the other is the
temporary page (in ZONE_UNMOVABLE).

- For the original page cache, it will clear PG_writeback bit very
quickly in the writeback routine and won't block the memory direct
reclaim and compaction at all
- As for the temporary page, in the normal case, the fuse server will
complete FUSE_WRITE request as expected, and thus the temporary page
will get freed soon.

However FUSE supports unprivileged mount, in which case the fuse daemon
is run and mounted by an unprivileged user.  Thus the backend fuse
daemon may be malicious (started by an unprivileged user) and refuses to
process any FUSE requests.  Thus in the worst case, these temporary
pages will never complete writeback and get pinned in ZONE_UNMOVABLE
forever. (One thing worth noting is that, once the fuse daemon gets
killed, the whole FUSE filesystem will be aborted, all inflight FUSE
requests are flushed, and all the temporary pages will be freed then)


What this patchset does is to drop the temporary page design in the FUSE
writeback routine, while this patch is introduced to avoid the above
mentioned deadlock for a *sane* FUSE daemon in memory compaction after
dropping the temp page design.

Currently the FUSE writeback pages (i.e. FUSE page cache) is allocated
from GFP_HIGHUSER_MOVABLE, which is consistent with other filesystems.

In the normal case (the FUSE is backed by a well-behaved FUSE daemon),
the page cache will be completed in a reasonable manner and it won't
affect the usability of ZONE_MOVABLE.

While in the worst case (a malicious FUSE daemon run by an unprivileged
user), these page cache in ZONE_MOVABLE can be pinned there indefinitely.

We can argue that in the current implementation (without this patch
series), ZONE_UNMOVABLE can also grow larger and larger, and pin quite
many memory usage (correct me if I'm wrong) in the worst case.  In this
degree this patch doesn't make things even worse.  Besides FUSE enables
strictlimit feature by default, in which each FUSE filesystem can
consume at most 1% of global vm.dirty_background_thresh before write
throttle is triggered.


[1]
https://lore.kernel.org/all/8eec0912-7a6c-4387-b9be-6718f438a111@linux.alibaba.com/


-- 
Thanks,
Jingbo

