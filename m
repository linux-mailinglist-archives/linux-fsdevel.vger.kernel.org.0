Return-Path: <linux-fsdevel+bounces-34133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82FD9C2947
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BEF1F22FAC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD222064;
	Sat,  9 Nov 2024 01:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F311E505;
	Sat,  9 Nov 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116345; cv=none; b=YlL3w2kTe+s3uUMQBvVZkDu/nwN2d3HYusBKlFW8hMiC6jyCZkS3lkJ0CRlwhKSKNESY1rVkWOyJe8VpAKcie7+eG+A71xL82RcaHokpsO+BzrETihM5HsK66ChCxSN9sj1+FdoqLMmJn84fEWYIRCI47HbWWO4uCxMiE5GpaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116345; c=relaxed/simple;
	bh=zyS+uCv/hcbGowmIOFH5+zGLFPEbRpiNQkzPMuXtWDY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zmp/hp4o7/L8DDJW7rFgf4H8o3z7zc22i1FPogXgo25xw8Lv7cQsWr5e99v2lZiqoRilu2SHCnrp2A59Azx+lBfrP2dnQnMMOTnit+V3prbwzBJ30atH/L9WjN5/VYvIKcKBBneCgfIfWVIObih68iwjrBL6MolkFJIABMIz9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XldkR4BZ8z4f3lDc;
	Sat,  9 Nov 2024 09:38:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 823A61A0359;
	Sat,  9 Nov 2024 09:38:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4cwvS5n0C0FBQ--.61013S3;
	Sat, 09 Nov 2024 09:38:57 +0800 (CST)
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Chuck Lever III <chuck.lever@oracle.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Sasha Levin <sashal@kernel.org>,
 "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
 "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
 <ZyzRsR9rMQeIaIkM@tissot.1015granger.net>
 <4db0a28b-8587-e999-b7a1-1d54fac4e19c@huaweicloud.com>
 <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
 <tlzw3ktm7xlspfnvkexhmzvzsuhz5zsd2rw2pjjakmvefup5w2@32ufrnferdw6>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a2cc72e9-a39d-d1a1-8fd3-502035460e21@huaweicloud.com>
Date: Sat, 9 Nov 2024 09:38:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tlzw3ktm7xlspfnvkexhmzvzsuhz5zsd2rw2pjjakmvefup5w2@32ufrnferdw6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4cwvS5n0C0FBQ--.61013S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1xCFyfWrW8Kw18Xr4ktFb_yoWrAF48pF
	W0qa4jkr4DXr17twn2vw1UZFW0y3yfJry5Xrn8Gr17Cr909r1ftF4xGr1YkF9rWws3Cr1j
	qF4Yqa47XF1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREfHUDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/09 1:03, Liam R. Howlett 写道:
> * Chuck Lever III <chuck.lever@oracle.com> [241108 08:23]:
>>
>>
>>> On Nov 7, 2024, at 8:19 PM, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2024/11/07 22:41, Chuck Lever 写道:
>>>> On Thu, Nov 07, 2024 at 08:57:23AM +0800, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2024/11/06 23:19, Chuck Lever III 写道:
>>>>>>
>>>>>>
>>>>>>> On Nov 6, 2024, at 1:16 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>> On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
>>>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>>>
>>>>>>>> Fix patch is patch 27, relied patches are from:
>>>>>>
>>>>>> I assume patch 27 is:
>>>>>>
>>>>>> libfs: fix infinite directory reads for offset dir
>>>>>>
>>>>>> https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@huaweicloud.com/
>>>>>>
>>>>>> I don't think the Maple tree patches are a hard
>>>>>> requirement for this fix. And note that libfs did
>>>>>> not use Maple tree originally because I was told
>>>>>> at that time that Maple tree was not yet mature.
>>>>>>
>>>>>> So, a better approach might be to fit the fix
>>>>>> onto linux-6.6.y while sticking with xarray.
>>>>>
>>>>> The painful part is that using xarray is not acceptable, the offet
>>>>> is just 32 bit and if it overflows, readdir will read nothing. That's
>>>>> why maple_tree has to be used.
>>>> A 32-bit range should be entirely adequate for this usage.
>>>>   - The offset allocator wraps when it reaches the maximum, it
>>>>     doesn't overflow unless there are actually billions of extant
>>>>     entries in the directory, which IMO is not likely.
>>>
>>> Yes, it's not likely, but it's possible, and not hard to trigger for
>>> test.
>>
>> I question whether such a test reflects any real-world
>> workload.
>>
>> Besides, there are a number of other limits that will impact
>> the ability to create that many entries in one directory.
>> The number of inodes in one tmpfs instance is limited, for
>> instance.
>>
>>
>>> And please notice that the offset will increase for each new file,
>>> and file can be removed, while offset stays the same.
>>>>   - The offset values are dense, so the directory can use all 2- or
>>>>     4- billion in the 32-bit integer range before wrapping.
>>>
>>> A simple math, if user create and remove 1 file in each seconds, it will
>>> cost about 130 years to overflow. And if user create and remove 1000
>>> files in each second, it will cost about 1 month to overflow.
>>
>> The question is what happens when there are no more offset
>> values available. xa_alloc_cyclic should fail, and file
>> creation is supposed to fail at that point. If it doesn't,
>> that's a bug that is outside of the use of xarray or Maple.
>>
>>
>>> maple tree use 64 bit value for the offset, which is impossible to
>>> overflow for the rest of our lifes.
>>>>   - No-one complained about this limitation when offset_readdir() was
>>>>     first merged. The xarray was replaced for performance reasons,
>>>>     not because of the 32-bit range limit.
>>>> It is always possible that I have misunderstood your concern!
>>>
>>> The problem is that if the next_offset overflows to 0, then after patch
>>> 27, offset_dir_open() will record the 0, and later offset_readdir will
>>> return directly, while there can be many files.
>>
>> That's a separate bug that has nothing to do with the maximum
>> number of entries one directory can have. Again, you don't
>> need Maple tree to address that.
>>
>> My understanding from Liam is that backporting Maple into
>> v6.6 is just not practical to do. We must explore alternate
>> ways to address these concerns.
>>
> 
> The tree itself is in v6.6, but the evolution of the tree to fit the
> needs of this and other subsystems isn't something that would be well
> tested.  This is really backporting features and that's not the point of
> stable.

Of course.
> 
> I think this is what Lorenzo was saying about changing your approach, we
> can't backport 28 patches to fix this when it isn't needed.

I don't have other approach now, so I'll not follow on fixing this cve.
I'll be great if someone has a beeter apporch. :)

Thanks,
Kuai

> 
> Thanks,
> Liam
> 
> .
> 


