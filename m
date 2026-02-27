Return-Path: <linux-fsdevel+bounces-78680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNSoGss+oWnsrQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:50:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B41B3804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3E7309B429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF2361DDD;
	Fri, 27 Feb 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k3c5+5Dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC25355F23
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175030; cv=none; b=gJKZJ4Bvf3kQkzN5AwJFqFzUfyM4x8PBKsPEoDG+J36diY5hl1Pqubq7pM8x1LC42orZ5bTbBkla+9i3ZiqfM7qlg1E38J5yxt0GNTngig/feYe7FdUtRSGPZaYDLpiJZvESUUJwp1MqPZThlhxx4doDyseh1J3KC+yBIbzzP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175030; c=relaxed/simple;
	bh=IGPYPKoVqPGuXJNZRHy7e5HLM7W41sKU2S8fhf3TupU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7AhIOuhnfKOUAU8Qx8O4akOIVeduz1Tq+2GarN1pcv/0fk4Kypj83ereDmtLDaFIiVsmmSMt0k3vB06Z0ihhNER6fj6mai6yd37AofK06YnfNwFa/zALf2UOvkBShcOwD6fSTcR78CCjN51rlCUovh83zCJ9/e9esqHvQhglBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k3c5+5Dj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4834869-4144-41aa-b370-9c4e6091322e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772175025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ7ts30l4mrTad+d0Hkes/PMYHLzhj3PuIrWDmD+Q50=;
	b=k3c5+5DjwB1axQckFpil6TTouQJgOeo5wNB67twv7enMbpueIbelLu3veNh6ERzkdVZX69
	BGyoxm+KfQbKH+kqSDSNnnNOCpurF8zGmiSg/v9MpBCSN71hQzB4TaVY758moJX7U0QPP9
	PoX+1OQi2OiadBTu4NzY0yPrAdc6OOM=
Date: Fri, 27 Feb 2026 14:50:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
To: "yebin (H)" <yebin10@huawei.com>, Muchun Song <muchun.song@linux.dev>,
 Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 david@fromorbit.com, roman.gushchin@linux.dev, linux-mm@kvack.org
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <69A13C1A.9020002@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78680-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.dev:mid,linux.dev:dkim,huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scenarios.at:url]
X-Rspamd-Queue-Id: B92B41B3804
X-Rspamd-Action: no action



On 2/27/26 2:39 PM, yebin (H) wrote:
> 
> 
> On 2026/2/27 11:31, Muchun Song wrote:
>>
>>
>>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>>
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> In order to better analyze the issue of file system uninstallation 
>>> caused
>>> by kernel module opening files, it is necessary to perform dentry 
>>> recycling
>>> on a single file system. But now, apart from global dentry recycling, 
>>> it is
>>> not supported to do dentry recycling on a single file system separately.
>>
>> Would shrinker-debugfs satisfy your needs (See Documentation/admin- 
>> guide/mm/shrinker_debugfs.rst)?
>>
>> Thanks,
>> Muchun
>>
> Thank you for the reminder. The reclamation of dentries and nodes can 
> meet my needs. However, the reclamation of the page cache alone does not 
> satisfy my requirements. I have reviewed the code of 
> shrinker_debugfs_scan_write() and found that it does not support batch 
> deletion of all dentries/inode for all nodes/memcgs,instead, users need 
> to traverse through them one by one, which is not very convenient. Based 
> on my previous experience, I have always performed dentry/inode 
> reclamation at the file system level.

Using shrinker-debugfs allows users to specify the size of a single
reclaim cycle (nr_to_scan), which controls the strength of each reclaim
cycle to adapt to different workloads. Can the new drop_fs_caches
support a similar approach?

Thanks,
Qi

> 
> Thanks,
> Ye Bin
>>> This feature has usage scenarios in problem localization scenarios.At 
>>> the
>>> same time, it also provides users with a slightly fine-grained
>>> pagecache/entry recycling mechanism.
>>> This patchset supports the recycling of pagecache/entry for 
>>> individual file
>>> systems.
>>>
>>> Diff v3 vs v2
>>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim dentry/inode.
>>> 2. Fixing compilation issues in specific architectures and 
>>> configurations.
>>>
>>> Diff v2 vs v1:
>>> 1. Fix possible live lock for shrink_icache_sb().
>>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>>> 3. Fix potential deadlocks as follows:
>>> https://lore.kernel.org/linux- 
>>> fsdevel/00000000000098f75506153551a1@google.com/
>>> After some consideration, it was decided that this feature would 
>>> primarily
>>> be used for debugging purposes. Instead of adding a new IOCTL 
>>> command, the
>>> task_work mechanism was employed to address potential deadlock issues.
>>>
>>> Ye Bin (3):
>>>   mm/vmscan: introduce drop_sb_dentry_inode() helper
>>>   sysctl: add support for drop_caches for individual filesystem
>>>   Documentation: add instructions for using 'drop_fs_caches sysctl'
>>>     sysctl
>>>
>>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>>> fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
>>> include/linux/mm.h                      |   1 +
>>> mm/internal.h                           |   3 +
>>> mm/shrinker.c                           |   4 +-
>>> mm/vmscan.c                             |  50 ++++++++++
>>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>>
>>> -- 
>>> 2.34.1
>>>
>>
>> .
>>


