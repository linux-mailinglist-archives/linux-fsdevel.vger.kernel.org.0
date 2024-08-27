Return-Path: <linux-fsdevel+bounces-27270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F095FF27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547B1B21E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993C17548;
	Tue, 27 Aug 2024 02:32:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96ED51C;
	Tue, 27 Aug 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725964; cv=none; b=Wg7LoA14+IlLv4ApyVkQvV05h1e9XXhK6O393satgEPOF4fkIDOcuNuUXivpaQiu6j45hikhd9pF6iB+H0fAaUvbZvWu6mT3fUu+Nfg9xAhjamq+yLo5MyoIR8rDF8i54AddLYDRjLp4vkkGLA+pwAuVHv76dClxqy6oTFM1MeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725964; c=relaxed/simple;
	bh=/inDil37vtqVPQY287mjyVoWuCEHeCFHy9dKqG4VoQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NKg5GYsWuwJNUn8mvrQRUtF0cxUJDQzJOGxZI+GTfXIT4nTsrNvI5cEKPjB9oLhFG0qi5DZX9hQs7U9CsZgSnP3bbCgBxZhIkC+SdrOk6pPjxomyL0vyU7h/9Gbhe+toO+aJ575rMP+l0k1Yv+sNyV5wZt4IaQvDWWVoDE/FZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtBKM4xSPz20mlq;
	Tue, 27 Aug 2024 10:27:51 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DC0C140120;
	Tue, 27 Aug 2024 10:32:39 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 10:32:39 +0800
Message-ID: <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
Date: Tue, 27 Aug 2024 10:32:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <brauner@kernel.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
	<gnoack@google.com>, <mic@digikod.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827021300.GK6043@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 10:13, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
>> Many mainstream file systems already support the GETVERSION ioctl,
>> and their implementations are completely the same, essentially
>> just obtain the value of i_generation. We think this ioctl can be
>> implemented at the VFS layer, so the file systems do not need to
>> implement it individually.
> 
> What if a filesystem never touches i_generation?  Is it ok to advertise
> a generation number of zero when that's really meaningless?  Or should
> we gate the generic ioctl on (say) whether or not the fs implements file
> handles and/or supports nfs?

This ioctl mainly returns the i_generation, and whether it has meaning 
is up to the specific file system. Some tools will invoke 
IOC_GETVERSION, such as `lsattr -v`(but if it's lattr, it won't), but 
users may not necessarily actually use this value.

Thanks,
Hongbo

> 
> --D
> 
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/ioctl.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index 64776891120c..dff887ec52c4 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -878,6 +878,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>>   	case FS_IOC_GETFSUUID:
>>   		return ioctl_getfsuuid(filp, argp);
>>   
>> +	case FS_IOC_GETVERSION:
>> +		return put_user(inode->i_generation, (int __user *)argp);
>> +
>>   	case FS_IOC_GETFSSYSFSPATH:
>>   		return ioctl_get_fs_sysfs_path(filp, argp);
>>   
>> @@ -992,6 +995,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>>   		cmd = (cmd == FS_IOC32_GETFLAGS) ?
>>   			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
>>   		fallthrough;
>> +	case FS_IOC32_GETVERSION:
>> +		cmd = FS_IOC_GETVERSION;
>> +		fallthrough;
>>   	/*
>>   	 * everything else in do_vfs_ioctl() takes either a compatible
>>   	 * pointer argument or no argument -- call it with a modified
>> -- 
>> 2.34.1
>>
>>
> 

