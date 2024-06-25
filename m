Return-Path: <linux-fsdevel+bounces-22342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4691683E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9973F1C20ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E71156678;
	Tue, 25 Jun 2024 12:43:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B81482F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319396; cv=none; b=uuHYmYuQSG/vQHqLeLXrctOF+S5IgdoAFNoVZn7NooP0NvAqmGi3KQxxdV7DvAYICgkTaoC9yWekdRXkE9dwn/SKPN7yhc7GzO98vSWAkwPwXALdBbcZFHbIDvZLOvI2MAwktn4TxSWWJuRmhteSrtrbU+nZi/JNjYC+uqjA4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319396; c=relaxed/simple;
	bh=Y2V6r+NFQLPiFt4h9hmDjNJOp7UJunpLKpBsuZNJ3U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S8ozUaulrn/Hh2AqlBmn27hdZEX+1dkaZ97K0XkAfNm/cJGQrxWV+RwQzDHpnsEU1teemH9PqzvtcJJM6j1ZzvIY55g5nQh6CSTgyFLY1AtPbTt552EcaWn+JYL3tR37S2fzvZXGxP+0DBJbplNy/shpQgChXLBY+Oza4sJfWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W7ktB5Nc8zQjYt;
	Tue, 25 Jun 2024 20:39:30 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3193818007C;
	Tue, 25 Jun 2024 20:43:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 20:43:09 +0800
Message-ID: <85412246-8b27-4a25-bdc7-98b816753c2d@huawei.com>
Date: Tue, 25 Jun 2024 20:43:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: fsconfig: intercept non-new mount API in advance
 for FSCONFIG_CMD_CREATE_EXCL command
To: Jan Kara <jack@suse.cz>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240625121831.1833081-1-lihongbo22@huawei.com>
 <20240625122851.hpswxrq4kwt64der@quack3>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240625122851.hpswxrq4kwt64der@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/25 20:28, Jan Kara wrote:
> On Tue 25-06-24 20:18:31, Hongbo Li wrote:
>> fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
>> here we should return -EOPNOTSUPP in advance to avoid extra procedure.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> The patch is already in VFS tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=ef44c8ab06b300a5b9b30e5b630f491ac7bc4d3e
> 
> It just didn't reach Linus' tree yet because it is not urgent fix.
> 
> 								Honza
> 
oh,thanks, I didn't realize this. Just ignore it! ^_^

Thanks,
Hongbo
>> ---
>> v3:
>>    - Add reviewed-by.
>>
>> v2: https://lore.kernel.org/all/20240522030422.315892-1-lihongbo22@huawei.com/
>>    - Fix misspelling and change the target branch.
>>
>> v1: https://lore.kernel.org/all/20240511062147.3312801-1-lihongbo22@huawei.com/T/
>> ---
>>   fs/fsopen.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/fsopen.c b/fs/fsopen.c
>> index 6593ae518115..18fe979da7e2 100644
>> --- a/fs/fsopen.c
>> +++ b/fs/fsopen.c
>> @@ -220,10 +220,6 @@ static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
>>   	if (!mount_capable(fc))
>>   		return -EPERM;
>>   
>> -	/* require the new mount api */
>> -	if (exclusive && fc->ops == &legacy_fs_context_ops)
>> -		return -EOPNOTSUPP;
>> -
>>   	fc->phase = FS_CONTEXT_CREATING;
>>   	fc->exclusive = exclusive;
>>   
>> @@ -411,6 +407,7 @@ SYSCALL_DEFINE5(fsconfig,
>>   		case FSCONFIG_SET_PATH:
>>   		case FSCONFIG_SET_PATH_EMPTY:
>>   		case FSCONFIG_SET_FD:
>> +		case FSCONFIG_CMD_CREATE_EXCL:
>>   			ret = -EOPNOTSUPP;
>>   			goto out_f;
>>   		}
>> -- 
>> 2.34.1
>>

