Return-Path: <linux-fsdevel+bounces-78682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIpCNBpGoWkirwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:22:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 327271B3C73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D428307B223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71935A397;
	Fri, 27 Feb 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s0Qqfgv6";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s0Qqfgv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DB332622
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176723; cv=none; b=nHT4O3OSh/1PcFsoKQ/8LAVVPJRqkIvHjxKNHseduKFy1Tn/UdvYCLH7JOSecEkWCPOB1I+VYK5kZNPEZ6/1An53oi0SRM4XTYrDs7tYwd80ycgP720fcnyhBREgM+5NrsZW2DAGhS0wpILwsZAjomL3jsOwcCTSKHr95cQMvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176723; c=relaxed/simple;
	bh=s+D0p2ZznwV0LVZnNniOUXug4rBkPo8/vWcFLBmGWNk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ox0T+6yfw7+O370waCnlTi0hQkffXFCUYldRROSxFeN8V+7tImoXDPXA2VWLPzyk4jLKCO10oDUpS0FFo4l1Fn88tB+HF099eKIRGIykUCfys2UqL8942E0LI0zPMmNIxWeTVdC0YRFR3ZtdVpNNNvWL5JTY9EKEg9S0fUN3Xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s0Qqfgv6; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s0Qqfgv6; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=avyklT8ko17OO+T4b2BCtg7wDKlzbbLPrf2QbaV4vBE=;
	b=s0Qqfgv6XXOMw0WL6SBdGWFuu/zOcDq311HqQfv3rZGLhyYWsQP+QOoGtNSsASop83hvOW6pL
	6sNgjken/XLv0tubjuEugoPxYMyuL5Lgq1xX6PhrM4TzAOUL8zSJyNahh2xLrNC2s1FNBXb03eL
	HMJqi0zYDffehJthhyGgZpc=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fMfn43Jd1z1BFrB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:18:16 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=avyklT8ko17OO+T4b2BCtg7wDKlzbbLPrf2QbaV4vBE=;
	b=s0Qqfgv6XXOMw0WL6SBdGWFuu/zOcDq311HqQfv3rZGLhyYWsQP+QOoGtNSsASop83hvOW6pL
	6sNgjken/XLv0tubjuEugoPxYMyuL5Lgq1xX6PhrM4TzAOUL8zSJyNahh2xLrNC2s1FNBXb03eL
	HMJqi0zYDffehJthhyGgZpc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fMfgl0QbBz1T4Fq;
	Fri, 27 Feb 2026 15:13:39 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CA002021A;
	Fri, 27 Feb 2026 15:18:33 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 15:18:33 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 15:18:32 +0800
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
To: Qi Zheng <qi.zheng@linux.dev>, Muchun Song <muchun.song@linux.dev>, Ye Bin
	<yebin@huaweicloud.com>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
 <e4834869-4144-41aa-b370-9c4e6091322e@linux.dev>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<david@fromorbit.com>, <roman.gushchin@linux.dev>, <linux-mm@kvack.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A14547.3050803@huawei.com>
Date: Fri, 27 Feb 2026 15:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e4834869-4144-41aa-b370-9c4e6091322e@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78682-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scenarios.at:url,huaweicloud.com:email];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 327271B3C73
X-Rspamd-Action: no action



On 2026/2/27 14:50, Qi Zheng wrote:
>
>
> On 2/27/26 2:39 PM, yebin (H) wrote:
>>
>>
>> On 2026/2/27 11:31, Muchun Song wrote:
>>>
>>>
>>>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>>>
>>>> From: Ye Bin <yebin10@huawei.com>
>>>>
>>>> In order to better analyze the issue of file system uninstallation
>>>> caused
>>>> by kernel module opening files, it is necessary to perform dentry
>>>> recycling
>>>> on a single file system. But now, apart from global dentry
>>>> recycling, it is
>>>> not supported to do dentry recycling on a single file system
>>>> separately.
>>>
>>> Would shrinker-debugfs satisfy your needs (See Documentation/admin-
>>> guide/mm/shrinker_debugfs.rst)?
>>>
>>> Thanks,
>>> Muchun
>>>
>> Thank you for the reminder. The reclamation of dentries and nodes can
>> meet my needs. However, the reclamation of the page cache alone does
>> not satisfy my requirements. I have reviewed the code of
>> shrinker_debugfs_scan_write() and found that it does not support batch
>> deletion of all dentries/inode for all nodes/memcgs,instead, users
>> need to traverse through them one by one, which is not very
>> convenient. Based on my previous experience, I have always performed
>> dentry/inode reclamation at the file system level.
>
> Using shrinker-debugfs allows users to specify the size of a single
> reclaim cycle (nr_to_scan), which controls the strength of each reclaim
> cycle to adapt to different workloads. Can the new drop_fs_caches
> support a similar approach?
>
> Thanks,
> Qi
>
"drop_fs_caches" is similar to "drop_caches," but it only operates on 
the specified file system. It does not support specifying the number of 
pages to scan (nr_to_scan).
>>
>> Thanks,
>> Ye Bin
>>>> This feature has usage scenarios in problem localization
>>>> scenarios.At the
>>>> same time, it also provides users with a slightly fine-grained
>>>> pagecache/entry recycling mechanism.
>>>> This patchset supports the recycling of pagecache/entry for
>>>> individual file
>>>> systems.
>>>>
>>>> Diff v3 vs v2
>>>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>>>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim
>>>> dentry/inode.
>>>> 2. Fixing compilation issues in specific architectures and
>>>> configurations.
>>>>
>>>> Diff v2 vs v1:
>>>> 1. Fix possible live lock for shrink_icache_sb().
>>>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>>>> 3. Fix potential deadlocks as follows:
>>>> https://lore.kernel.org/linux-
>>>> fsdevel/00000000000098f75506153551a1@google.com/
>>>> After some consideration, it was decided that this feature would
>>>> primarily
>>>> be used for debugging purposes. Instead of adding a new IOCTL
>>>> command, the
>>>> task_work mechanism was employed to address potential deadlock issues.
>>>>
>>>> Ye Bin (3):
>>>>   mm/vmscan: introduce drop_sb_dentry_inode() helper
>>>>   sysctl: add support for drop_caches for individual filesystem
>>>>   Documentation: add instructions for using 'drop_fs_caches sysctl'
>>>>     sysctl
>>>>
>>>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>>>> fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
>>>> include/linux/mm.h                      |   1 +
>>>> mm/internal.h                           |   3 +
>>>> mm/shrinker.c                           |   4 +-
>>>> mm/vmscan.c                             |  50 ++++++++++
>>>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> .
>>>
>
> .
>

