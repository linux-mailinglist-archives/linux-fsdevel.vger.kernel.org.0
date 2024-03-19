Return-Path: <linux-fsdevel+bounces-14799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC787F574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 03:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52A0B21924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C2651BE;
	Tue, 19 Mar 2024 02:27:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2764CF3;
	Tue, 19 Mar 2024 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815268; cv=none; b=FMunqHrHT8/FoamhLBWzV4kmHQebVwpIc6Zat/JOaTBELNFRlmnz/0mlA//No4mgVVP+iPloOyOU99ss78mddU4oDfzqQhaBqH66ZIj+gE7EGjw/mEShtk/HnM3HhEmdTcSSMVUL6phtHWqSGbBZCQ9UpsO/zZveVTs1VFV5v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815268; c=relaxed/simple;
	bh=KlK6RRY+rznZ+X+XX2ZR9KnlLvHxiYkumw+UmKTdxzM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i2Obn7Ah07erqBOeRGJjEkY/bePCuBHYJrGJJy9AAtZ3T6x7rml1SdQcG4wSMqKmTWrzTaZZZQ6Nd7x1tGLV70sr4TnQx7uuWcfUyBG7Y4Ts0wTo0M2k/u7fThDwxHINjgKHWGJA9PcF+ygBla70oIbMDeaOr6os3sC8afTw3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzFxQ3kYjz4f3jZm;
	Tue, 19 Mar 2024 10:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5DC121A09D0;
	Tue, 19 Mar 2024 10:27:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REc+PhlGo6SHQ--.49153S3;
	Tue, 19 Mar 2024 10:27:42 +0800 (CST)
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
To: Matthew Sakai <msakai@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 dm-devel@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
 <20240315-assoziieren-hacken-b43f24f78970@brauner>
 <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>
 <20240318-mythisch-pittoresk-1c57af743061@brauner>
 <c9bfba49-9611-c965-713c-1ef0b1e305ce@huaweicloud.com>
 <dd4e443a-696d-b02f-44ff-4649b585ef17@huaweicloud.com>
 <0665f6a6-39d9-e730-9403-0348c181dd55@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7210daac-4c0b-ce98-fe61-1c5e7c33b289@huaweicloud.com>
Date: Tue, 19 Mar 2024 10:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0665f6a6-39d9-e730-9403-0348c181dd55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REc+PhlGo6SHQ--.49153S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUZryfur4xuF43uFW3KFg_yoW8Aw18p3
	4qyFsxKr4Dtr1DA34Syw18Xw1Fyw45Xr1rXw15Xr12vryktry3tr4xKrn0kryDXrsrZr17
	uF48t3yfXas5ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/19 10:13, Matthew Sakai 写道:
> 
> On 3/18/24 21:43, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/03/19 9:18, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2024/03/18 17:39, Christian Brauner 写道:
>>>> On Sat, Mar 16, 2024 at 10:49:33AM +0800, Yu Kuai wrote:
>>>>> Hi, Christian
>>>>>
>>>>> 在 2024/03/15 21:54, Christian Brauner 写道:
>>>>>> On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
>>>>>>> Hi, Christian
>>>>>>> Hi, Christoph
>>>>>>> Hi, Jan
>>>>>>>
>>>>>>> Perhaps now is a good time to send a formal version of this set.
>>>>>>> However, I'm not sure yet what branch should I rebase and send 
>>>>>>> this set.
>>>>>>> Should I send to the vfs tree?
>>>>>>
>>>>>> Nearly all of it is in fs/ so I'd say yes.
>>>>>> .
>>>>>
>>>>> I see that you just create a new branch vfs.fixes, perhaps can I 
>>>>> rebase
>>>>> this set against this branch?
>>>>
>>>> Please base it on vfs.super. I'll rebase it to v6.9-rc1 on Sunday.
>>>
>>> Okay, I just see that vfs.super doesn't contain commit
>>> 1cdeac6da33f("btrfs: pass btrfs_device to btrfs_scratch_superblocks()"),
>>> and you might need to fix the conflict at some point.
>>
>> And there is another problem, dm-vdo doesn't exist in vfs.super yet. Do
>> you still want me to rebase here?
>>
> 
> The dm-vdo changes don't appear to rely on earlier patches in the 
> series, so I think dm-vdo could incorporate the dm-vdo patch 
> independently from the rest of the series, if that would be helpful. (I 
> don't want to confuse things too much.) In that case it would go through 
> the dm tree with the rest of dm-vdo.

We want to remove the 'bd_inode' field in this set. And if we want to go
through dm tree for dm-vdo changes, we must keep the field for now.

I don't have preference, Christian will make the decision. 😉

Thanks,
Kuai

> 
> Matt
> 
> .
> 


