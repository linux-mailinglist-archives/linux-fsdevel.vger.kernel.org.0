Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF501758F03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGSH3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGSH3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:29:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883B1E47;
        Wed, 19 Jul 2023 00:28:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R5S9f6Wthz4f3prY;
        Wed, 19 Jul 2023 15:28:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbG1kLdkjRJCOQ--.49626S3;
        Wed, 19 Jul 2023 15:28:55 +0800 (CST)
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
 <fc740cf1-93a7-e438-e784-5209808981dc@huaweicloud.com>
 <fdebc267-249a-2345-ba60-476240c8cf63@veeam.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8257903a-1905-49c5-bed4-d15ca06c6d3b@huaweicloud.com>
Date:   Wed, 19 Jul 2023 15:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fdebc267-249a-2345-ba60-476240c8cf63@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbG1kLdkjRJCOQ--.49626S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWxWr43XF17tw4kZr18Krg_yoW7tF1rpF
        yYga1qkr4kGr1Skwnrt3W7ua4rt395Jr1F9r15J34rCr98KrnIgw43t3yY93WDZr4vka4Y
        vr4ag34xt34DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/07/19 0:33, Sergei Shtepa 写道:
> 
> 
> On 7/18/23 14:32, Yu Kuai wrote:
>> Subject:
>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>> From:
>> Yu Kuai <yukuai1@huaweicloud.com>
>> Date:
>> 7/18/23, 14:32
>>
>> To:
>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>
>>
>> Hi,
>>
>> 在 2023/07/18 19:25, Sergei Shtepa 写道:
>>> Hi.
>>>
>>> On 7/18/23 03:37, Yu Kuai wrote:
>>>> Subject:
>>>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>>>> From:
>>>> Yu Kuai <yukuai1@huaweicloud.com>
>>>> Date:
>>>> 7/18/23, 03:37
>>>>
>>>> To:
>>>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>>> CC:
>>>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>>>
>>>>
>>>> Hi,
>>>>
>>>> 在 2023/07/17 22:39, Sergei Shtepa 写道:
>>>>>
>>>>>
>>>>> On 7/11/23 04:02, Yu Kuai wrote:
>>>>>> bdev_disk_changed() is not handled, where delete_partition() and
>>>>>> add_partition() will be called, this means blkfilter for partiton will
>>>>>> be removed after partition rescan. Am I missing something?
>>>>>
>>>>> Yes, when the bdev_disk_changed() is called, all disk block devices
>>>>> are deleted and new ones are re-created. Therefore, the information
>>>>> about the attached filters will be lost. This is equivalent to
>>>>> removing the disk and adding it back.
>>>>>
>>>>> For the blksnap module, partition rescan will mean the loss of the
>>>>> change trackers data. If a snapshot was created, then such
>>>>> a partition rescan will cause the snapshot to be corrupted.
>>>>>
>>>>
>>>> I haven't review blksnap code yet, but this sounds like a problem.
>>>
>>> I can't imagine a case where this could be a problem.
>>> Partition rescan is possible only if the file system has not been
>>> mounted on any of the disk partitions. Ioctl BLKRRPART will return
>>> -EBUSY. Therefore, during normal operation of the system, rescan is
>>> not performed.
>>> And if the file systems have not been mounted, it is possible that
>>> the disk partition structure has changed or the disk in the media
>>> device has changed. In this case, it is better to detach the
>>> filter, otherwise it may lead to incorrect operation of the module.
>>>
>>> We can add prechange/postchange callback functions so that the
>>> filter can track rescan process. But at the moment, this is not
>>> necessary for the blksnap module.
>>
>> So you mean that blkfilter is only used for the case that partition
>> is mounted? (Or you mean that partition is opened)
>>
>> Then, I think you mean that filter should only be used for the partition
>> that is opended? Otherwise, filter can be gone at any time since
>> partition rescan can be gone.
>>
>> //user
>> 1. attach filter
>>          // other context rescan partition
>> 2. mount fs
>> // user will found filter is gone.
> 
> Mmm...  The fact is that at the moment the user of the filter is the
> blksnap module. There are no other filter users yet. The blksnap module
> solves the problem of creating snapshots, primarily for backup purposes.
> Therefore, the main use case is to attach a filter for an already running
> system, where all partitions are marked up, file systems are mounted.
> 
> If the server is being serviced, during which the disk is being
> re-partitioned, then disabling the filter is normal. In this case, the
> change tracker will be reset, and at the next backup, the filter will be
> attached again.

Thanks for the explanation, I was thinking that blkshap can replace
dm-snapshot.

Thanks,
Kuai

> 
> But if I were still solving the problem of saving the filter when rescanning,
> then it is necessary to take into account the UUID and name of the partition
> (struct partition_meta_info). It is unacceptable that due to a change in the
> structure of partitions, the filter is attached to another partition by mistake.
> The changed() callback would also be good to add so that the filter receives
> a notification that the block device has been updated.
> 
> But I'm not sure that this should be done, since if some code is not used in
> the kernel, then it should not be in the kernel.
> 
>>
>> Thanks,
>> Kuai
>>
>>>
>>> Therefore, I will refrain from making changes for now.
>>>
>>>>
>>>> possible solutions I have in mind:
>>>>
>>>> 1. Store blkfilter for each partition from bdev_disk_changed() before
>>>> delete_partition(), and add blkfilter back after add_partition().
>>>>
>>>> 2. Store blkfilter from gendisk as a xarray, and protect it by
>>>> 'open_mutex' like 'part_tbl', block_device can keep the pointer to
>>>> reference blkfilter so that performance from fast path is ok, and the
>>>> lifetime of blkfiter can be managed separately.
>>>>
>>>>> There was an idea to do filtering at the disk level,
>>>>> but I abandoned it.
>>>>> .
>>>>>
>>>> I think it's better to do filtering at the partition level as well.
>>>>
>>>> Thanks,
>>>> Kuai
>>>>
>>> .
>>>
>>
> .
> 

