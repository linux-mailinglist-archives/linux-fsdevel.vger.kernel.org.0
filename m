Return-Path: <linux-fsdevel+bounces-31558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875A998660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983D01C226A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDD1C460D;
	Thu, 10 Oct 2024 12:45:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAE1C6882;
	Thu, 10 Oct 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564305; cv=none; b=AGVtCdhsFSsPyHo8dscikXIKhNmJKHZT4pHZ6mODigIlkIuSmFJF8SqRw+yqXPPux2AUcSkqcx8iftUwFtUFXob0OOBny7K4YOPpkYhvWuxXLTw4nWqvdHsFNMQJrGuipleJnFLWdhPJ1r34q2Q0tMm6kqFqsl6HVNgIUoOZgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564305; c=relaxed/simple;
	bh=xCFgAuZiiogFYGmAMETQx/sjqDPkGLWs2cFFKREAYNU=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c3XLcZKly+5X1gykQJAT5aV/OK3fw4xDhB0RaME46yU0poqD2OqLaHmZTV8WTnYMmDg+++wFHG+v9NKjb+kE18AmuLsVcio6YyOcrwrdb2LtsyxgwNEVbSQNWQJZmJSFx819SY9VPVWgPxW0WVZYed40zuufpo2SVjdWgOFf5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XPTvs2gKnz1SCQ8;
	Thu, 10 Oct 2024 20:43:53 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id 948651A0190;
	Thu, 10 Oct 2024 20:45:00 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemd200022.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 20:44:59 +0800
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
To: Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
 <20241010121607.54ttcmdfmh7ywho7@quack3>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangxiaoxu5@huawei.com>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <6707CC10.2020007@huawei.com>
Date: Thu, 10 Oct 2024 20:44:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241010121607.54ttcmdfmh7ywho7@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200022.china.huawei.com (7.221.188.232)



On 2024/10/10 20:16, Jan Kara wrote:
> On Thu 10-10-24 19:25:42, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In order to better analyze the issue of file system uninstallation caused
>> by kernel module opening files, it is necessary to perform dentry recycling
> I don't quite understand the use case you mention here. Can you explain it
> a bit more (that being said I've needed dropping caches for a particular sb
> myself a few times for debugging purposes so I generally agree it is a
> useful feature).
Well, I'm analyzing what files are still open and the file system can't 
be unmounted.
The process occupied by the opened file cannot be found through the 
fuser. That is,
the file may be occupied by the kernel mode. You can insert a module or 
use kprobe
to obtain all cached files of the corresponding file system. But there 
can be a lot of
files, so I want to clean up irrelevant files first.
>> on a single file system. But now, apart from global dentry recycling, it is
>> not supported to do dentry recycling on a single file system separately.
>> This feature has usage scenarios in problem localization scenarios.At the
>> same time, it also provides users with a slightly fine-grained
>> pagecache/entry recycling mechanism.
>> This patch supports the recycling of pagecache/entry for individual file
>> systems.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mm.h |  2 ++
>>   kernel/sysctl.c    |  9 +++++++++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
>> index d45ef541d848..99d412cf3e52 100644
>> --- a/fs/drop_caches.c
>> +++ b/fs/drop_caches.c
>> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>>   	}
>>   	return 0;
>>   }
>> +
>> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
>> +				  void *buffer, size_t *length, loff_t *ppos)
>> +{
>> +	unsigned int major, minor;
>> +	unsigned int ctl;
>> +	struct super_block *sb;
>> +	static int stfu;
>> +
>> +	if (!write)
>> +		return 0;
>> +
>> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
>> +		return -EINVAL;
> I think specifying bdev major & minor number is not a great interface these
> days. In particular for filesystems which are not bdev based such as NFS. I
> think specifying path to some file/dir in the filesystem is nicer and you
> can easily resolve that to sb here as well.
>
> 								Honza
That's a really good idea. I think by specifying bdev "major & minor", 
you can reclaim
the file system pagecache that is not unmounted due to "umount -l" mode. 
In this
case, the sb of the corresponding file system cannot be found in the 
specified path.
So I think we can support both ways. I look forward to your opinion.


