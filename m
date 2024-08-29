Return-Path: <linux-fsdevel+bounces-27741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEF9637B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCEE284302
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B91B813;
	Thu, 29 Aug 2024 01:28:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939A2745C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894889; cv=none; b=ulDomy2Yu0Zbs3R1CVdYLrc9jWtNr8BgVLBG/44y6/iHKYLtg/7iBBXswM1FhBYu7d3+c6V/HAoigeCw08Y4L/0NJDfO6/ceiuDSnPTWvBl2VXdb0ckF61OjioBYxsd2DMaxUchoMlTEoB+DXcqV0/wnMMDGixlJqeI9OUDnz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894889; c=relaxed/simple;
	bh=Oo1Eb1yYJpglCkfbAGh2stueJP48yA3SDpbznnJjRsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T4gDNS0ktm4a3e1TmM93JPXh4Sq1Z72r1vzHBZNLzLaxXI6XKMjOjyxJbKeFf06eKKx4haJp6ls3CT9/stCrteRfx/GCHsAvynsMEVouWslgOAApRrgtaWDtl0s2W7Wsgonp2p07khinrvg1qaOVwpv9z325Kaurd9thelGutH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvNtt2rCszyR8q;
	Thu, 29 Aug 2024 09:27:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AE751402C6;
	Thu, 29 Aug 2024 09:28:05 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:28:05 +0800
Message-ID: <143e1d04-2f9f-4a93-81bb-7d3803b3e4c3@huawei.com>
Date: Thu, 29 Aug 2024 09:28:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] zonefs: obtain fs magic from superblock
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, <naohiro.aota@wdc.com>,
	<jth@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>
References: <20240828120152.3695626-1-lihongbo22@huawei.com>
 <abcb7207-8b8d-4a29-9d0d-665da2c91443@kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <abcb7207-8b8d-4a29-9d0d-665da2c91443@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/29 8:56, Damien Le Moal wrote:
> On 8/28/24 21:01, Hongbo Li wrote:
>> The sb->s_magic holds the file system magic, we can use
>> this to avoid use file system magic macro directly.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/zonefs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index faf1eb87895d..1ecbf19ccc58 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -444,7 +444,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>   	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>>   	enum zonefs_ztype t;
>>   
>> -	buf->f_type = ZONEFS_MAGIC;
>> +	buf->f_type = sb->s_magic;
> 
> I fail to see the benefits of this change. "we can do it differently" is not
> really an argument in itself without clear benefits. And in this case, that
> function will have an additional sb pointer dereference, so be slower (not that
> it matters though since this is not the hot path).
> 
Just avoid using the macro directly. No other benefits.

This kind of macro definition is like a magic number; once it changes, 
it will affect a large amount of code.

It's just my personal opinion. 😉

Thanks,
Hongbo


> See other file systems (e.g. xfs_fs_statfs), many do the same thing and use
> their MAGIC macro for this field.
> 
>>   	buf->f_bsize = sb->s_blocksize;
>>   	buf->f_namelen = ZONEFS_NAME_MAX;
>>   
> 

