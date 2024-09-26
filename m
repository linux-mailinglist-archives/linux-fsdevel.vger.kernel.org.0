Return-Path: <linux-fsdevel+bounces-30151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A311A98701E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258A8B20D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863631ABEDD;
	Thu, 26 Sep 2024 09:28:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F261AB6F2;
	Thu, 26 Sep 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342898; cv=none; b=PB43eQTwYyn0QFSca1k7Btj8iTlwLg8GqQEFrY//ui0J0ScVgbCSar9sU3RYpsjXPHfd0ENWF1lvlFHLlSRxws8TXu3A3c0sVp64hidu0H38dTKAAJmWRqHxnpYjc4Fcl77xIK1WebNgypM6rq+gjmyrg6OdI6bXU3RvdJxWaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342898; c=relaxed/simple;
	bh=EDht8aYisYAcI7n+B9DfXTXswUoogYDJgicgfThstww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hx0kWE8jXjAEjqdfOId3XGEYK7VRN8a4jwa9OJh/zFruf3OVIj1VMGpBaLppPM6LJNonFbcTYGi42V9mCBN5ZBYJ2QdQlEUwQhKae2vePkxoRZlmBn7haykAVrYZ7jw6uRjA1BKuNQFfT9mGk5yVNSQcbVWundiF1/KzyQtKegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDpBs5d7Hz10McL;
	Thu, 26 Sep 2024 17:26:45 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 495EF1401F0;
	Thu, 26 Sep 2024 17:28:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 17:28:11 +0800
Message-ID: <52f055eb-a828-45cd-a06d-ca2006321926@huawei.com>
Date: Thu, 26 Sep 2024 17:28:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC: Jan Kara <jack@suse.cz>, <tytso@mit.edu>, <stable@vger.kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?=
	<stgraber@stgraber.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, Wesley Hershberger
	<wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
 <CAEivzxc-b-QDx8AEdHEwa06Q2TYgZZkw2PWQ+K_Lyf+oyTM1Zg@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAEivzxc-b-QDx8AEdHEwa06Q2TYgZZkw2PWQ+K_Lyf+oyTM1Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/26 17:16, Aleksandr Mikhalitsyn wrote:
> On Thu, Sep 26, 2024 at 10:29 AM Baokun Li <libaokun1@huawei.com> wrote:
>> On 2024/9/25 23:57, Jan Kara wrote:
>>> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
>>>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
>>>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
>>>> [   33.888740] ------------[ cut here ]------------
>>>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
>>> Ah, I was staring at this for a while before I understood what's going on
>>> (it would be great to explain this in the changelog BTW).  As far as I
>>> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation
>>> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
>>> flexbg_size (for example when ogroup = flexbg_size, ngroup = 2*flexbg_size
>>> - 1) which then confuses things. I think that was not really intended and
>>> instead of fixing up ext4_alloc_group_tables() we should really change
>>> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceeds
>>> flexbg size. Baokun?
>>>
>>>                                                                Honza
>> Hi Honza,
>>
>> Your analysis is absolutely correct. It's a bug!
>> Thank you for locating this issue！
>> An extra 1 should not be added when calculating resize_bg in
>> alloc_flex_gd().
>>
>>
>> Hi Aleksandr,
> Hi Baokun,
>
>> Could you help test if the following changes work?
> I can confirm that this patch helps.
>
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>
> Kind regards,
> Alex

Thank you for the test!


Cheers,
Baokun
>>
>> Thanks,
>> Baokun
>>
>> ---
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index e04eb08b9060..1f01a7632149 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -253,10 +253,12 @@ static struct ext4_new_flex_group_data
>> *alloc_flex_gd(unsigned int flexbg_size,
>>           /* Avoid allocating large 'groups' array if not needed */
>>           last_group = o_group | (flex_gd->resize_bg - 1);
>>           if (n_group <= last_group)
>> -               flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
>> +               flex_gd->resize_bg = 1 << fls(n_group - o_group);
>>           else if (n_group - last_group < flex_gd->resize_bg)
>> -               flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
>> +               flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
>>                                                 fls(n_group - last_group));
>>
>>           flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>>                                           sizeof(struct ext4_new_group_data),
>>

