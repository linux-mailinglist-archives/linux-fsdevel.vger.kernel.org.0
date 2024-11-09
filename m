Return-Path: <linux-fsdevel+bounces-34132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F589C293E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C72B24061
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE722E859;
	Sat,  9 Nov 2024 01:31:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFA20309;
	Sat,  9 Nov 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115861; cv=none; b=qnaVGC/LBiUn0WrL/ZnGuAvf6XoK6JyesqlyOagjDy1TiE6+R51BIbAaaVt8+aPPXQ0z8J07R6djhd9Y5tYXPDbhV9od5FvzL1MefV88rNnXnPuXnBftPlul26w5Ob4r1vaTIjDYukrDo7jcGIkdRv6lw53xC3+VOInEF18ttOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115861; c=relaxed/simple;
	bh=QO+eWDf9tHrhcwwUNMYL/hq8FgQEK68bufE8P+GQG3E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IfhwEZe2CwrTdeD0iLGOfC/f1YLLFI4lKQEP4i+ggMod3GvyVh7atp5p5Xi/gQTnz6IHmJEDG2T7ZXWcldqUX5NIFHQv2WPiXAgCdAUZfCtbR/Nnt9RdSNuobcvzbfY0V2jFBHv1B/1TH3ZbMnu08/jQ2Eqp1KXMAa5zl31GkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XldY90nJMz4f3kFQ;
	Sat,  9 Nov 2024 09:30:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 30EE71A0196;
	Sat,  9 Nov 2024 09:30:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoJLuy5nMaQEBQ--.46715S3;
	Sat, 09 Nov 2024 09:30:53 +0800 (CST)
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
To: Chuck Lever III <chuck.lever@oracle.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 linux-stable <stable@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a223b1dd-9699-5f6c-2b71-98e9cd377007@huaweicloud.com>
Date: Sat, 9 Nov 2024 09:30:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoJLuy5nMaQEBQ--.46715S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4rAF4rWr43Ww4rurWxZwb_yoWrCry5pF
	Z7t3WjkFsrJr17Kwn2vw4j9FW0yw4fGry5XFn8Wry7AF909r1SgF4xGr1YkFyxGws3u3Wj
	qF4Yva47JF1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRJMa0UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/08 21:23, Chuck Lever III 写道:
> 
> 
>> On Nov 7, 2024, at 8:19 PM, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/11/07 22:41, Chuck Lever 写道:
>>> On Thu, Nov 07, 2024 at 08:57:23AM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2024/11/06 23:19, Chuck Lever III 写道:
>>>>>
>>>>>
>>>>>> On Nov 6, 2024, at 1:16 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
>>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>>
>>>>>>> Fix patch is patch 27, relied patches are from:
>>>>>
>>>>> I assume patch 27 is:
>>>>>
>>>>> libfs: fix infinite directory reads for offset dir
>>>>>
>>>>> https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@huaweicloud.com/
>>>>>
>>>>> I don't think the Maple tree patches are a hard
>>>>> requirement for this fix. And note that libfs did
>>>>> not use Maple tree originally because I was told
>>>>> at that time that Maple tree was not yet mature.
>>>>>
>>>>> So, a better approach might be to fit the fix
>>>>> onto linux-6.6.y while sticking with xarray.
>>>>
>>>> The painful part is that using xarray is not acceptable, the offet
>>>> is just 32 bit and if it overflows, readdir will read nothing. That's
>>>> why maple_tree has to be used.
>>> A 32-bit range should be entirely adequate for this usage.
>>>   - The offset allocator wraps when it reaches the maximum, it
>>>     doesn't overflow unless there are actually billions of extant
>>>     entries in the directory, which IMO is not likely.
>>
>> Yes, it's not likely, but it's possible, and not hard to trigger for
>> test.
> 
> I question whether such a test reflects any real-world
> workload.
> 
> Besides, there are a number of other limits that will impact
> the ability to create that many entries in one directory.
> The number of inodes in one tmpfs instance is limited, for
> instance.
> 
> 
>> And please notice that the offset will increase for each new file,
>> and file can be removed, while offset stays the same.

Did you see the above explanation? files can be removed, you don't have
to store that much files to triggger the offset to overflow.

>>>   - The offset values are dense, so the directory can use all 2- or
>>>     4- billion in the 32-bit integer range before wrapping.
>>
>> A simple math, if user create and remove 1 file in each seconds, it will
>> cost about 130 years to overflow. And if user create and remove 1000
>> files in each second, it will cost about 1 month to overflow.
> 
> The question is what happens when there are no more offset
> values available. xa_alloc_cyclic should fail, and file
> creation is supposed to fail at that point. If it doesn't,
> that's a bug that is outside of the use of xarray or Maple.

Can you show me the code that xa_alloc_cyclic should fail? At least
according to the commets, it will return 1 if the allocation succeeded
after wrapping.

  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
  * allocation succeeded after wrapping, -ENOMEM if memory could not be
  * allocated or -EBUSY if there are no free entries in @limit.
  */
static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
		struct xa_limit limit, u32 *next, gfp_t gfp)
> 
> 
>> maple tree use 64 bit value for the offset, which is impossible to
>> overflow for the rest of our lifes.
>>>   - No-one complained about this limitation when offset_readdir() was
>>>     first merged. The xarray was replaced for performance reasons,
>>>     not because of the 32-bit range limit.
>>> It is always possible that I have misunderstood your concern!
>>
>> The problem is that if the next_offset overflows to 0, then after patch
>> 27, offset_dir_open() will record the 0, and later offset_readdir will
>> return directly, while there can be many files.
> 
> That's a separate bug that has nothing to do with the maximum
> number of entries one directory can have. Again, you don't
> need Maple tree to address that.
> 
> My understanding from Liam is that backporting Maple into
> v6.6 is just not practical to do. We must explore alternate
> ways to address these concerns.

Like I said, I'll just give up for this cve for v6.6.
> 
> 
> --
> Chuck Lever
> 
> 


