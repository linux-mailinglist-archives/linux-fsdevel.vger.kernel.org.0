Return-Path: <linux-fsdevel+bounces-79100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK9rNn1IpmlyNQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 03:33:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AEF1E81C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD99A309B08A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B532F12AF;
	Tue,  3 Mar 2026 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g+Ccphz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BD31F990
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505145; cv=none; b=og9npkyh7s4Ko0wP19tVsBGPqTJV8htdKz56jaikej2esHjI0hqgTHrQ0lJvn2yrgD6eD4PETW4v5ETmaYTTrv1HLai1/F7JiTjcb4H3kr08XUhN53i3PdulC0vuzG4T6QtAJI4uvQL2Ah9NsWSRcKRdHgjlQmWQYo6k6N3qdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505145; c=relaxed/simple;
	bh=eX5QirGpKHaGOmyaKuk0rJSqIL0s05dDoC+enSydy4U=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aZl+BHzlSwQ5zCzI9NRGDJlO5W1/lneU1FOIDY9jkv3p9eU3ZC0af3pzGJHTcGuWamOnItfSNjL6/lIyXKdxy+fToerbQ7mYikdct26IP2xnXqYtotx7TvhuRuRjNkLtyiLJXDLiHb663bZ9xd2fJlGpbyhUbOoEMMd65rbUIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g+Ccphz3; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g9ZERwdBTzNcJlyl7JMEnk+Gz1/74PAnF0zrPGxMSQQ=;
	b=g+Ccphz3cJNi5TcygW53gBxDab7EwyQTaCNpRcJjETumLELzvNTl4B5FiUfyF/86C7c4+Y//l
	CFCACOmEJ6W+2CN38ejvHuYCbFe1+C7XV3R4GTglJDnl1cymj8P9ZYZudqGgZS4UkwUr8niVtMW
	GlHKRalvnsVd6SKU82/e2bE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fQ07b51GCzmV7V;
	Tue,  3 Mar 2026 10:27:23 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F18C340565;
	Tue,  3 Mar 2026 10:32:14 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 10:32:14 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 10:32:13 +0800
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
To: Muchun Song <muchun.song@linux.dev>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
 <959B7A5C-8C1A-417C-A1D3-6500E506DEE6@linux.dev>
 <69A14882.4030609@huawei.com>
 <C63DBC11-B4CD-4D8D-9C09-E6A9F690FB21@linux.dev>
 <69A15314.3080602@huawei.com>
 <57055A1C-0684-4B77-80ED-4A641F262792@linux.dev>
CC: Ye Bin <yebin@huaweicloud.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <david@fromorbit.com>,
	<zhengqi.arch@bytedance.com>, <roman.gushchin@linux.dev>,
	<linux-mm@kvack.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A6482C.6060807@huawei.com>
Date: Tue, 3 Mar 2026 10:32:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57055A1C-0684-4B77-80ED-4A641F262792@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: 41AEF1E81C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79100-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,scenarios.at:url,huaweicloud.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2026/2/27 16:27, Muchun Song wrote:
>
>
>> On Feb 27, 2026, at 16:17, yebin (H) <yebin10@huawei.com> wrote:
>>
>>
>>
>> On 2026/2/27 15:45, Muchun Song wrote:
>>>
>>>
>>>> On Feb 27, 2026, at 15:32, yebin (H) <yebin10@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/2/27 14:55, Muchun Song wrote:
>>>>>
>>>>>
>>>>>> On Feb 27, 2026, at 14:39, yebin (H) <yebin10@huawei.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2026/2/27 11:31, Muchun Song wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>>>>>>>
>>>>>>>> From: Ye Bin <yebin10@huawei.com>
>>>>>>>>
>>>>>>>> In order to better analyze the issue of file system uninstallation caused
>>>>>>>> by kernel module opening files, it is necessary to perform dentry recycling
>>>>>>>> on a single file system. But now, apart from global dentry recycling, it is
>>>>>>>> not supported to do dentry recycling on a single file system separately.
>>>>>>>
>>>>>>> Would shrinker-debugfs satisfy your needs (See Documentation/admin-guide/mm/shrinker_debugfs.rst)?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Muchun
>>>>>>>
>>>>>> Thank you for the reminder. The reclamation of dentries and nodes can meet my needs. However, the reclamation of the page cache alone does not satisfy my requirements. I have reviewed the code of shrinker_debugfs_scan_write() and found that it does not support batch deletion of all dentries/inode for all nodes/memcgs,instead, users need to traverse through them one by one, which is not very convenient. Based on my previous experience, I have always performed dentry/inode reclamation at the file system level.
>>>>>
>>>>> I don't really like that you're implementing another mechanism with duplicate
>>>>> functionality. If you'd like, you could write a script to iterate through them
>>>>> and execute it that way—I don't think that would be particularly inconvenient,
>>>>> would it? If the iteration operation of memcg is indeed quite cumbersome, I
>>>>> think extending the shrinker debugfs functionality would be more appropriate.
>>>>>
>>>> The shrinker_debugfs can be extended to support node/memcg/fs granularity reclamation, similar to the extended function of echo " 0 - X" > count /echo " - 0 X" > count /echo " - - X" > count. This only solves the problem of reclaiming dentries/inode based on a single file system. However, the page cache reclamation based on a single file system cannot be implemented by using shrinker_debugfs. If the extended function is implemented by shrinker_debugfs, drop_fs_caches can reuse the same interface and maintain the same semantics as drop_caches.
>>>
>>> If the inode is evicted, the page cache is evicted as well. It cannot evict page
>>> cache alone. Why you want to evict cache alone?
>>>
>> The condition for dentry/inode to be reclaimed is that there are no
>> references to them. Therefore, relying on inode reclamation for page
>> cache reclamation has limitations. Additionally, there is currently no
>
> What limit?
>
Perhaps I didn't explain it clearly earlier. What I want to achieve is
the ability to perform memory reclamation (pagecache/dentry/inode)
based on a single file system. In the current network environment, when
troubleshooting issues, I want to control the impact of operations and
only perform memory reclamation on specific file systems. Therefore,
some files might be in an occupied state, and relying on dentry/inode
to reclaim pagecache will not achieve the desired effect. Additionally,
I have encountered some users who periodically run `drop_caches`,
mainly to clear the pagecache. If we rely on dentry/inode to release
resources, there will be issues where the pagecache cannot be fully
cleared. This level of granularity is actually unnecessary because in
some scenarios, users know which partitions they use more frequently,
so they only need to clear the pagecache for specific partitions.

>> usage statistics for the page cache based on a single file system. By
>> comparing the page cache usage before and after reclamation, we can
>> roughly estimate the amount of page cache used by a file system.
>
> I'm curious why dropping inodes doesn't show a noticeable difference
> in page cache usage before and after?
>
>>
>>>>>>
>>>>>> Thanks,
>>>>>> Ye Bin
>>>>>>>> This feature has usage scenarios in problem localization scenarios.At the
>>>>>>>> same time, it also provides users with a slightly fine-grained
>>>>>>>> pagecache/entry recycling mechanism.
>>>>>>>> This patchset supports the recycling of pagecache/entry for individual file
>>>>>>>> systems.
>>>>>>>>
>>>>>>>> Diff v3 vs v2
>>>>>>>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>>>>>>>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim dentry/inode.
>>>>>>>> 2. Fixing compilation issues in specific architectures and configurations.
>>>>>>>>
>>>>>>>> Diff v2 vs v1:
>>>>>>>> 1. Fix possible live lock for shrink_icache_sb().
>>>>>>>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>>>>>>>> 3. Fix potential deadlocks as follows:
>>>>>>>> https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.com/
>>>>>>>> After some consideration, it was decided that this feature would primarily
>>>>>>>> be used for debugging purposes. Instead of adding a new IOCTL command, the
>>>>>>>> task_work mechanism was employed to address potential deadlock issues.
>>>>>>>>
>>>>>>>> Ye Bin (3):
>>>>>>>>   mm/vmscan: introduce drop_sb_dentry_inode() helper
>>>>>>>>   sysctl: add support for drop_caches for individual filesystem
>>>>>>>>   Documentation: add instructions for using 'drop_fs_caches sysctl'
>>>>>>>>     sysctl
>>>>>>>>
>>>>>>>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>>>>>>>> fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
>>>>>>>> include/linux/mm.h                      |   1 +
>>>>>>>> mm/internal.h                           |   3 +
>>>>>>>> mm/shrinker.c                           |   4 +-
>>>>>>>> mm/vmscan.c                             |  50 ++++++++++
>>>>>>>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>
>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>
>>>>> .
>>>
>>>
>>>
>>>
>>> .
>
>
> .
>

