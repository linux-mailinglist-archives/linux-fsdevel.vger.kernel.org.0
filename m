Return-Path: <linux-fsdevel+bounces-78679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPxqAyY8oWnsrQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:39:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D14211B3550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41C09303CEDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 06:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431EE36493C;
	Fri, 27 Feb 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fal7Ym+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B13603F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174370; cv=none; b=S/4Ck1KuFLqai45/SlxVils1tjo0kpeBix+QxN7iG3rhlqRZh8/12xJIiSNwzePFq+sI/kyEmqArYqXyBgdCMxKhHD136xWIRM4tHSZtF0kkC7eSXWD/91oUvBrRLpbJG5t9g/V7Bef4vr/UY9UQdNz+0uhRxHg3NJEiBCFJB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174370; c=relaxed/simple;
	bh=75S9eXZrxcjUHU3Xgc3j9/yPmVeunizdRsf3/XiPHJ0=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R8jF5T4Z97slT5kRhVGkJ2EjQP0DC6zLuwsKY39McEkeqcbvLIqdsUD44010CXqWvn/dYeVXmYQVlmlN9gGrkkCXXs9bPYQT6hcCs/d2YU3Wqs0y0Ay5WQVuE5ebNJI/iPYPXxZDV85xoBxWqJ4xzUdDxb8JwlJe+ySFRBT5Ojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fal7Ym+U; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l/o+Q4AGikwIdB1bx+x/BsS3mTAPffNhVvHygGJp3gQ=;
	b=fal7Ym+UZ9TdpFDu8oxIToBd875duzVo5udOAcl/QqlARsvXZynsA51nqjSmpqCULkGIyBtHu
	gR9UapoubELSqeSBYWoHctScqwjMyBFqGFb6LRKPcUTe+t96pXiVYrng1LLgmmEnDHB0x4DVEBS
	3ZEy+yqNJmC5goD3zgqvME8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fMdpr6Jjhz12LD1;
	Fri, 27 Feb 2026 14:34:44 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 562A74056A;
	Fri, 27 Feb 2026 14:39:24 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 14:39:24 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 14:39:23 +0800
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
To: Muchun Song <muchun.song@linux.dev>, Ye Bin <yebin@huaweicloud.com>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<david@fromorbit.com>, <zhengqi.arch@bytedance.com>,
	<roman.gushchin@linux.dev>, <linux-mm@kvack.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A13C1A.9020002@huawei.com>
Date: Fri, 27 Feb 2026 14:39:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78679-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:email,huawei.com:mid,huawei.com:dkim,huawei.com:email];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D14211B3550
X-Rspamd-Action: no action



On 2026/2/27 11:31, Muchun Song wrote:
>
>
>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In order to better analyze the issue of file system uninstallation caused
>> by kernel module opening files, it is necessary to perform dentry recycling
>> on a single file system. But now, apart from global dentry recycling, it is
>> not supported to do dentry recycling on a single file system separately.
>
> Would shrinker-debugfs satisfy your needs (See Documentation/admin-guide/mm/shrinker_debugfs.rst)?
>
> Thanks,
> Muchun
>
Thank you for the reminder. The reclamation of dentries and nodes can 
meet my needs. However, the reclamation of the page cache alone does not 
satisfy my requirements. I have reviewed the code of 
shrinker_debugfs_scan_write() and found that it does not support batch 
deletion of all dentries/inode for all nodes/memcgs,instead, users need 
to traverse through them one by one, which is not very convenient. Based 
on my previous experience, I have always performed dentry/inode 
reclamation at the file system level.

Thanks,
Ye Bin
>> This feature has usage scenarios in problem localization scenarios.At the
>> same time, it also provides users with a slightly fine-grained
>> pagecache/entry recycling mechanism.
>> This patchset supports the recycling of pagecache/entry for individual file
>> systems.
>>
>> Diff v3 vs v2
>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim dentry/inode.
>> 2. Fixing compilation issues in specific architectures and configurations.
>>
>> Diff v2 vs v1:
>> 1. Fix possible live lock for shrink_icache_sb().
>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>> 3. Fix potential deadlocks as follows:
>> https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.com/
>> After some consideration, it was decided that this feature would primarily
>> be used for debugging purposes. Instead of adding a new IOCTL command, the
>> task_work mechanism was employed to address potential deadlock issues.
>>
>> Ye Bin (3):
>>   mm/vmscan: introduce drop_sb_dentry_inode() helper
>>   sysctl: add support for drop_caches for individual filesystem
>>   Documentation: add instructions for using 'drop_fs_caches sysctl'
>>     sysctl
>>
>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>> fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
>> include/linux/mm.h                      |   1 +
>> mm/internal.h                           |   3 +
>> mm/shrinker.c                           |   4 +-
>> mm/vmscan.c                             |  50 ++++++++++
>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>
>> --
>> 2.34.1
>>
>
> .
>

