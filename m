Return-Path: <linux-fsdevel+bounces-33852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCE9BFB06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BDB1F24183
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB679F5;
	Thu,  7 Nov 2024 00:57:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019D79D0;
	Thu,  7 Nov 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941056; cv=none; b=PuFrtVEylRHtYQahoGi9ZzNAFxRx9lKQGYm0nt6/VqQjGISPeTSi4TDpO8ZObWZG3kzK9fKM8pCBixPeToaJtiZSnkhEeogEyoMix68oCRuS+R3KGkxy4sYlecrNb9xLjFOjHUmix9HDDBbmFNQfrlkukCYfjD45gfk892d0WTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941056; c=relaxed/simple;
	bh=ArEGzs21LgB4PFU5jHdCGFhDjiQ12PvoV2JHv3V3voM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rJTKcgBH/pT0gnE5ySumZ3t+WIY5R4bia8ZR4UNIWU833IqOgIv3fKp9hVIJNbdbBlgGZAvhb8U89ZPJ6T4zKBHjMLfqY7AGRgy1ONJjSPuD8GGNhTfNDmxUkqViWMaJpR+aj3wXUXskcXeVJQfqGVVeQdJ02G8vUs5qsH4sAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XkNvb1TwZz4f3kJt;
	Thu,  7 Nov 2024 08:57:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1916F1A0568;
	Thu,  7 Nov 2024 08:57:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoZzECxnGnRCBA--.54616S3;
	Thu, 07 Nov 2024 08:57:25 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
Date: Thu, 7 Nov 2024 08:57:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoZzECxnGnRCBA--.54616S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8CryxXw1UtrWkXFWxCrg_yoW8tF4Upa
	yfJ3Z8Kr47ur18Gws7tayjvay0kan5X345urn5K345ZF1Y9FySgrWI9F15uF97GrsxCr17
	KF1aqwn7J3WUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

在 2024/11/06 23:19, Chuck Lever III 写道:
> 
> 
>> On Nov 6, 2024, at 1:16 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Fix patch is patch 27, relied patches are from:
> 
> I assume patch 27 is:
> 
> libfs: fix infinite directory reads for offset dir
> 
> https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@huaweicloud.com/
> 
> I don't think the Maple tree patches are a hard
> requirement for this fix. And note that libfs did
> not use Maple tree originally because I was told
> at that time that Maple tree was not yet mature.
> 
> So, a better approach might be to fit the fix
> onto linux-6.6.y while sticking with xarray.

The painful part is that using xarray is not acceptable, the offet
is just 32 bit and if it overflows, readdir will read nothing. That's
why maple_tree has to be used.

Thanks,
Kuai

> 
> This is the first I've heard of this CVE. It
> would help if the patch authors got some
> notification when these are filed.
> 
> 
>>> - patches from set [1] to add helpers to maple_tree, the last patch to
>>> improve fork() performance is not backported;
>>
>> So things slowed down?
>>
>>> - patches from set [2] to change maple_tree, and follow up fixes;
>>> - patches from set [3] to convert offset_ctx from xarray to maple_tree;
>>>
>>> Please notice that I'm not an expert in this area, and I'm afraid to
>>> make manual changes. That's why patch 16 revert the commit that is
>>> different from mainline and will cause conflict backporting new patches.
>>> patch 28 pick the original mainline patch again.
>>>
>>> (And this is what we did to fix the CVE in downstream kernels).
>>>
>>> [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00@bytedance.com/
>>> [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howlett@oracle.com/T/
>>> [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net/
>>
>> This series looks rough.  I want to have the maintainers of these
>> files/subsystems to ack this before being able to take them.
>>
>> thanks,
>>
>> greg k-h
> 
> --
> Chuck Lever
> 
> 


