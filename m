Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DB757BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGRMcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGRMcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:32:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F6AC;
        Tue, 18 Jul 2023 05:32:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R4yxv30Z4z4f3lWy;
        Tue, 18 Jul 2023 20:32:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7JBhrZkmOQFOQ--.32583S3;
        Tue, 18 Jul 2023 20:32:03 +0800 (CST)
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Donald Buczek <buczek@molgen.mpg.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-3-sergei.shtepa@veeam.com>
 <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
 <90f79cf3-86a2-02c0-1887-d3490f9848bb@veeam.com>
 <d929eaa7-61d6-c4c4-aabc-0124c3693e10@huaweicloud.com>
 <686b9999-c903-cff1-48ba-21324031da17@veeam.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fc740cf1-93a7-e438-e784-5209808981dc@huaweicloud.com>
Date:   Tue, 18 Jul 2023 20:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <686b9999-c903-cff1-48ba-21324031da17@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7JBhrZkmOQFOQ--.32583S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3JrWrXFWUKFyftr4UCFg_yoW5tw47pF
        W5Kan8Kr4kGFnak3sFy3WxCa45tws3Jr1F9r15J34rCr98JrnI9343K3yfua4Duryqk3yY
        vr4Fg3s7Jas7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/07/18 19:25, Sergei Shtepa 写道:
> Hi.
> 
> On 7/18/23 03:37, Yu Kuai wrote:
>> Subject:
>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>> From:
>> Yu Kuai <yukuai1@huaweicloud.com>
>> Date:
>> 7/18/23, 03:37
>>
>> To:
>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>
>>
>> Hi,
>>
>> 在 2023/07/17 22:39, Sergei Shtepa 写道:
>>>
>>>
>>> On 7/11/23 04:02, Yu Kuai wrote:
>>>> bdev_disk_changed() is not handled, where delete_partition() and
>>>> add_partition() will be called, this means blkfilter for partiton will
>>>> be removed after partition rescan. Am I missing something?
>>>
>>> Yes, when the bdev_disk_changed() is called, all disk block devices
>>> are deleted and new ones are re-created. Therefore, the information
>>> about the attached filters will be lost. This is equivalent to
>>> removing the disk and adding it back.
>>>
>>> For the blksnap module, partition rescan will mean the loss of the
>>> change trackers data. If a snapshot was created, then such
>>> a partition rescan will cause the snapshot to be corrupted.
>>>
>>
>> I haven't review blksnap code yet, but this sounds like a problem.
> 
> I can't imagine a case where this could be a problem.
> Partition rescan is possible only if the file system has not been
> mounted on any of the disk partitions. Ioctl BLKRRPART will return
> -EBUSY. Therefore, during normal operation of the system, rescan is
> not performed.
> And if the file systems have not been mounted, it is possible that
> the disk partition structure has changed or the disk in the media
> device has changed. In this case, it is better to detach the
> filter, otherwise it may lead to incorrect operation of the module.
> 
> We can add prechange/postchange callback functions so that the
> filter can track rescan process. But at the moment, this is not
> necessary for the blksnap module.

So you mean that blkfilter is only used for the case that partition
is mounted? (Or you mean that partition is opened)

Then, I think you mean that filter should only be used for the partition
that is opended? Otherwise, filter can be gone at any time since
partition rescan can be gone.

//user
1. attach filter
		// other context rescan partition
2. mount fs
// user will found filter is gone.

Thanks,
Kuai

> 
> Therefore, I will refrain from making changes for now.
> 
>>
>> possible solutions I have in mind:
>>
>> 1. Store blkfilter for each partition from bdev_disk_changed() before
>> delete_partition(), and add blkfilter back after add_partition().
>>
>> 2. Store blkfilter from gendisk as a xarray, and protect it by
>> 'open_mutex' like 'part_tbl', block_device can keep the pointer to
>> reference blkfilter so that performance from fast path is ok, and the
>> lifetime of blkfiter can be managed separately.
>>
>>> There was an idea to do filtering at the disk level,
>>> but I abandoned it.
>>> .
>>>
>> I think it's better to do filtering at the partition level as well.
>>
>> Thanks,
>> Kuai
>>
> .
> 

