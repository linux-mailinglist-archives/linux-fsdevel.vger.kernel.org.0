Return-Path: <linux-fsdevel+bounces-30209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD5987CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 03:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F01284A20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8715099E;
	Fri, 27 Sep 2024 01:43:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4412746D;
	Fri, 27 Sep 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401405; cv=none; b=aMsGFiHnuaHqAFfQs2CRBOb/Pv0+kuhl8wvONFLrLAhfZVDRok6m4gxz+B08zAd5CfN/E6+JSj/HUNJgCldiCY7g3gTgELDz7kg8MGp3Y5g1syJoNL1P9kolDnRWD+TEtw2u/Kqbyv4MMYuJMCy1Zt6NM3/FMNNtr+tVdn/8848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401405; c=relaxed/simple;
	bh=eThHgiFZLCQUTtc9xrFLaZUNnQjcwKmNmd28LqBUrx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bbCX2/CcUj6BUKFZn95nV1g0SYbxhJ1wWLzX28f3JWAFeh+Ar75oudE7Oc0eiku2cXcCVhebxj+Ga5pj6M2CJgsBli5Jh82kJ/ut1RKV6UQMcwDqm7HSoEzeZ/q0n4b0WciCQxLzmYhpbxxsgw6WWZr91KdwqlPG4h9Ps2DMC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XFCrd12pxz2DcZj;
	Fri, 27 Sep 2024 09:42:25 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 9118C1A0188;
	Fri, 27 Sep 2024 09:43:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Sep
 2024 09:43:13 +0800
Message-ID: <e6758b35-fb97-4f69-8cdb-2650edea80b5@huawei.com>
Date: Fri, 27 Sep 2024 09:43:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Eric Sandeen <sandeen@sandeen.net>
CC: Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn
	<aleksandr.mikhalitsyn@canonical.com>, <tytso@mit.edu>,
	<stable@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>, Wesley
 Hershberger <wesley.hershberger@canonical.com>, Yang Erkun
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
 <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/27 0:04, Eric Sandeen wrote:
> On 9/26/24 3:28 AM, Baokun Li wrote:
>> On 2024/9/25 23:57, Jan Kara wrote:
>>> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
>>>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
>>>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
>>>> [   33.888740] ------------[ cut here ]------------
>>>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
>>> Ah, I was staring at this for a while before I understood what's going on
>>> (it would be great to explain this in the changelog BTW).  As far as I
>>> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation
>>> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
>>> flexbg_size (for example when ogroup = flexbg_size, ngroup = 2*flexbg_size
>>> - 1) which then confuses things. I think that was not really intended and
>>> instead of fixing up ext4_alloc_group_tables() we should really change
>>> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceeds
>>> flexbg size. Baokun?
>>>
>>>                                  Honza
>> Hi Honza,
>>
>> Your analysis is absolutely correct. It's a bug!
>> Thank you for locating this issue！
>> An extra 1 should not be added when calculating resize_bg in alloc_flex_gd().
>>
>>
>> Hi Aleksandr,
>>
>> Could you help test if the following changes work?
>>
> I just got an internal bug report for this as well, and I can also confirm that
> the patch fixes my testcase, thanks! Feel free to add:
>
> Tested-by: Eric Sandeen <sandeen@redhat.com>
>
> I had been trying to debug this and it felt like an off by one but I didn't get
> to a solution in time. ;)
>
> Can you explain what the 2 cases under
>
> /* Avoid allocating large 'groups' array if not needed */
>
> are doing? I *think* the first 'if' is trying not to over-allocate for the last
> batch of block groups that get added during a resize. What is the "else if" case
> doing?
>
> Thanks,
> -Eric
>
The ext4 online resize started out by allocating the memory needed
for an entire flexible block group regardless of the number of block
groups to be added.

This led to a warning being triggered in the mm module when the
userland set a very large flexbg_size (perhaps they wanted to put
all the group metadata in the head of the disk), allocating more
memory than the MAX_ORDER size. Commit 5d1935ac02ca5a
("ext4: avoid online resizing failures due to oversized flex bg") fixes
this problem with resize_bg.

Normally, when online resizing, we may not need to allocate the
memory required for an entire flexible block group. So if o_group
and n_group are in the same flexible block group or if o_group
and n_group are in neighbouring flexible block groups, we
check if less memory can be allocated. This is what was done in
commit 665d3e0af4d3 ("ext4: reduce unnecessary memory
allocation in alloc_flex_gd()").

Regards,
Baokun


