Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDF759068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGSIhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGSIg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:36:59 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268519B1;
        Wed, 19 Jul 2023 01:36:49 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 5211E4247A;
        Wed, 19 Jul 2023 04:36:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1689755806;
        bh=wGCVKhkqJH+Yo7LufeZklucelDz+msotbtzEN6Hr8P0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=b0tym7087WS5sdxCyrv3EV2zpaoRiGi3ekxt669mmHNcKFikaqhwLNEQX+e0l9gmH
         U3bGI9EdrhhlVagIdk5CzOIo6lCiLeU6jbAPnUX8gZQYRfUdQQv/xkNyPz/xxw2eA1
         FLz9qgNpPSZLpEfJZI5IR4ug8hL8iVnooW4AqFoyt49KPdoXvHc3fiPvrbdFSBrx5/
         cWGuswVMpPWnRUdA7fQfthFBQsJLLA031X0YfmcUNsWhw68+C/6Pd0FdjkkWw6LcIV
         RobDFJ5mpZoD9qruEAWpiveN2dNnj7iecoPk6XynlSWg3O8IlqHtWUVVUxq4XzrohS
         +eHXbcHzHnfrA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 19 Jul
 2023 10:36:39 +0200
Message-ID: <c33df221-968c-9f31-e545-27dd4e90729f@veeam.com>
Date:   Wed, 19 Jul 2023 10:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dchinner@redhat.com>, <willy@infradead.org>, <dlemoal@kernel.org>,
        <linux@weissschuh.net>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
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
 <8257903a-1905-49c5-bed4-d15ca06c6d3b@huaweicloud.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <8257903a-1905-49c5-bed4-d15ca06c6d3b@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677661
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/19/23 09:28, Yu Kuai wrote:
> Subject:
> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
> From:
> Yu Kuai <yukuai1@huaweicloud.com>
> Date:
> 7/19/23, 09:28
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
> 
> 
> Hi,
> 
> 在 2023/07/19 0:33, Sergei Shtepa 写道:
>>
>>
>> On 7/18/23 14:32, Yu Kuai wrote:
>>> Subject:
>>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>>> From:
>>> Yu Kuai <yukuai1@huaweicloud.com>
>>> Date:
>>> 7/18/23, 14:32
>>>
>>> To:
>>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>> CC:
>>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>>
>>>
>>> Hi,
>>>
>>> 在 2023/07/18 19:25, Sergei Shtepa 写道:
>>>> Hi.
>>>>
>>>> On 7/18/23 03:37, Yu Kuai wrote:
>>>>> Subject:
>>>>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>>>>> From:
>>>>> Yu Kuai <yukuai1@huaweicloud.com>
>>>>> Date:
>>>>> 7/18/23, 03:37
>>>>>
>>>>> To:
>>>>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>>>> CC:
>>>>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> 在 2023/07/17 22:39, Sergei Shtepa 写道:
>>>>>>
>>>>>>
>>>>>> On 7/11/23 04:02, Yu Kuai wrote:
>>>>>>> bdev_disk_changed() is not handled, where delete_partition() and
>>>>>>> add_partition() will be called, this means blkfilter for partiton will
>>>>>>> be removed after partition rescan. Am I missing something?
>>>>>>
>>>>>> Yes, when the bdev_disk_changed() is called, all disk block devices
>>>>>> are deleted and new ones are re-created. Therefore, the information
>>>>>> about the attached filters will be lost. This is equivalent to
>>>>>> removing the disk and adding it back.
>>>>>>
>>>>>> For the blksnap module, partition rescan will mean the loss of the
>>>>>> change trackers data. If a snapshot was created, then such
>>>>>> a partition rescan will cause the snapshot to be corrupted.
>>>>>>
>>>>>
>>>>> I haven't review blksnap code yet, but this sounds like a problem.
>>>>
>>>> I can't imagine a case where this could be a problem.
>>>> Partition rescan is possible only if the file system has not been
>>>> mounted on any of the disk partitions. Ioctl BLKRRPART will return
>>>> -EBUSY. Therefore, during normal operation of the system, rescan is
>>>> not performed.
>>>> And if the file systems have not been mounted, it is possible that
>>>> the disk partition structure has changed or the disk in the media
>>>> device has changed. In this case, it is better to detach the
>>>> filter, otherwise it may lead to incorrect operation of the module.
>>>>
>>>> We can add prechange/postchange callback functions so that the
>>>> filter can track rescan process. But at the moment, this is not
>>>> necessary for the blksnap module.
>>>
>>> So you mean that blkfilter is only used for the case that partition
>>> is mounted? (Or you mean that partition is opened)
>>>
>>> Then, I think you mean that filter should only be used for the partition
>>> that is opended? Otherwise, filter can be gone at any time since
>>> partition rescan can be gone.
>>>
>>> //user
>>> 1. attach filter
>>>          // other context rescan partition
>>> 2. mount fs
>>> // user will found filter is gone.
>>
>> Mmm...  The fact is that at the moment the user of the filter is the
>> blksnap module. There are no other filter users yet. The blksnap module
>> solves the problem of creating snapshots, primarily for backup purposes.
>> Therefore, the main use case is to attach a filter for an already running
>> system, where all partitions are marked up, file systems are mounted.
>>
>> If the server is being serviced, during which the disk is being
>> re-partitioned, then disabling the filter is normal. In this case, the
>> change tracker will be reset, and at the next backup, the filter will be
>> attached again.
> 
> Thanks for the explanation, I was thinking that blkshap can replace
> dm-snapshot.

Thanks!
At the moment I am creating blksnap with the Veeam product needs in mind.
I would be glad if blksnap would be useful in other products as well.
If you have any thoughts/questions/suggestions/comments, then write to me
directly. I'll be happy to discuss everything.
To work on the patch, I use the branch here
Link: https://github.com/SergeiShtepa/linux/tree/blksnap-master
The user-space libs, tools and tests, compatible with the upstream is here
Link: https://github.com/veeam/blksnap/tree/stable-v2.0
Perhaps it will be useful to you.

> 
> Thanks,
> Kuai
> 
>>
>> But if I were still solving the problem of saving the filter when rescanning,
>> then it is necessary to take into account the UUID and name of the partition
>> (struct partition_meta_info). It is unacceptable that due to a change in the
>> structure of partitions, the filter is attached to another partition by mistake.
>> The changed() callback would also be good to add so that the filter receives
>> a notification that the block device has been updated.
>>
>> But I'm not sure that this should be done, since if some code is not used in
>> the kernel, then it should not be in the kernel.
>>
>>>
>>> Thanks,
>>> Kuai
>>>
>>>>
>>>> Therefore, I will refrain from making changes for now.
>>>>
>>>>>
>>>>> possible solutions I have in mind:
>>>>>
>>>>> 1. Store blkfilter for each partition from bdev_disk_changed() before
>>>>> delete_partition(), and add blkfilter back after add_partition().
>>>>>
>>>>> 2. Store blkfilter from gendisk as a xarray, and protect it by
>>>>> 'open_mutex' like 'part_tbl', block_device can keep the pointer to
>>>>> reference blkfilter so that performance from fast path is ok, and the
>>>>> lifetime of blkfiter can be managed separately.
>>>>>
>>>>>> There was an idea to do filtering at the disk level,
>>>>>> but I abandoned it.
>>>>>> .
>>>>>>
>>>>> I think it's better to do filtering at the partition level as well.
>>>>>
>>>>> Thanks,
>>>>> Kuai
>>>>>
>>>> .
>>>>
>>>
>> .
>>
> 
