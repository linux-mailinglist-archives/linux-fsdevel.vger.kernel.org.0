Return-Path: <linux-fsdevel+bounces-30039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43049854E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C747B218A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78431B85D1;
	Wed, 25 Sep 2024 08:01:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F013C8EA;
	Wed, 25 Sep 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251307; cv=none; b=Z37enVnbMqVHJwj4pw9iFOUfuwLUkaEQjmwJR7pSpY7PMar125lvx4zenonxBdeYYdYzwaTD0Y/RKJGefDlvAqbbhY/5vT2hm7WfAlE/Q/MKChWCbxzCHso1gdtm9sXPGDPXycFdKoNybvqNusId8KnQf5ffOXmUt8XZNJGwP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251307; c=relaxed/simple;
	bh=qyw2Z+2uu4xdzs4MJ0BrYY3HrcD/fEmZY0/Wo/hYRUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hAEtFtd04sZd6p6lrddN8P/CbdTwGGkuagc/09jBGGnHeXJNSF2rS5qbHAmdZikL4D6UoEw/ux8uMuOkiQEfE1S3YKn2nrnUzj166eu4e0beI4eOaWsdCqCV2ChUAgcF2WB9d9uwRlKxypFF6SpjN62wxrKbAMVfhAbLD0URSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XD8JQ3173zfcgW;
	Wed, 25 Sep 2024 15:59:18 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 875D5180064;
	Wed, 25 Sep 2024 16:01:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 16:01:35 +0800
Message-ID: <728dd40e-a725-41c0-be90-a85e02d3cd76@huawei.com>
Date: Wed, 25 Sep 2024 16:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in
 mount option.
To: Jan Kara <jack@suse.cz>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <chris.zjh@huawei.com>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
 <20240925075105.lnssx7gcgfh5s743@quack3>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240925075105.lnssx7gcgfh5s743@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/25 15:51, Jan Kara wrote:
> On Wed 25-09-24 09:56:24, Hongbo Li wrote:
>> The `fs_lookup_param` did not consider the relative path for
>> block device. When we mount ext4 with `journal_path` option using
>> relative path, `param->dirfd` was not set which will cause mounting
>> error.
>>
>> This can be reproduced easily like this:
>>
>> mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
>> mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
>> cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT
>>
>> Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>> v2:
>>    - Change the journal_path parameter as string not bdev, and
>>      determine the relative path situation inside fs_lookup_param.
>>    - Add Suggested-by.
>>
>> v1: https://lore.kernel.org/all/20240527-mahlen-packung-3fe035ab390d@brauner/
>> ---
>>   fs/ext4/super.c | 4 ++--
>>   fs/fs_parser.c  | 3 +++
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 16a4ce704460..cd23536ce46e 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1744,7 +1744,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>>   	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
>>   	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
>>   	fsparam_u32	("journal_dev",		Opt_journal_dev),
>> -	fsparam_bdev	("journal_path",	Opt_journal_path),
>> +	fsparam_string	("journal_path",	Opt_journal_path),
> 
> Why did you change this? As far as I can see the only effect would be that
> empty path will not be allowed (which makes sense) but that seems like an
> independent change which would deserve a comment in the changelog? Or am I
> missing something?

The fsparam_bdev serves no purpose here, you're right, empty path will 
not be allowed for `journal_path` option. And all changes are made to 
fix the issues (journal_path options changed) introduced by the previous 
new mount api conversion.

> 
>>   	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
>>   	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
>>   	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
>> @@ -2301,7 +2301,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   			return -EINVAL;
>>   		}
>>   
>> -		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
>> +		error = fs_lookup_param(fc, param, true, LOOKUP_FOLLOW, &path);
>>   		if (error) {
>>   			ext4_msg(NULL, KERN_ERR, "error: could not find "
>>   				 "journal device path");
>> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> index 24727ec34e5a..2ae296764b69 100644
>> --- a/fs/fs_parser.c
>> +++ b/fs/fs_parser.c
>> @@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
>>   		f = getname_kernel(param->string);
>>   		if (IS_ERR(f))
>>   			return PTR_ERR(f);
>> +		/* for relative path */
>> +		if (f->name[0] != '/')
>> +			param->dirfd = AT_FDCWD;
> 
> What Al meant is that you can do simply:
> 		param->dirfd = AT_FDCWD;
> 
> and everything will work the same because 'dfd' is ignored for absolute
> pathnames in path_init().
> 
ok, seems reasonable.

Thanks,
Hongbo
> 								Honza

