Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD2758235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGRQeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 12:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGRQeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:34:16 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3153124;
        Tue, 18 Jul 2023 09:34:14 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 4A31041087;
        Tue, 18 Jul 2023 12:34:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1689698052;
        bh=HupSvzm2vncOrOzzRtgKkwQ3ecploXR1dUcOc8VjTcY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Xfr8MtO0+Zi2DaBlCSpzeAykKnjx/XsIpmvblMY3k28janKsB5HiuMje4LAIaIbw5
         06gEUAijroubdt4JN02gRmhyIx7LbR32zkCEs0XSi/LXTxhl003VbRKan84J2ddFsk
         xt/F6ECKvcuYnhGrsvGSed2GcI3RPEd8wsztZHMcbytBGfkjsBCd9EOeZrWhiZNwtP
         lQ28p2prZeN+aytMKbHjh1KTyhp3tlkd2CEPc6Q2AyLOfzpw/qSw+waj/zgMc42nc5
         AFzm2arV/NPfColw9+5vzXg7ckh6NMkvQTVkOOBwJDf1Dw2X3RdGlQ59D9Jjfclatj
         ++27WJliivqfQ==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Tue, 18 Jul
 2023 18:34:05 +0200
Message-ID: <fdebc267-249a-2345-ba60-476240c8cf63@veeam.com>
Date:   Tue, 18 Jul 2023 18:33:58 +0200
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
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <fc740cf1-93a7-e438-e784-5209808981dc@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677765
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/18/23 14:32, Yu Kuai wrote:
> Subject:
> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
> From:
> Yu Kuai <yukuai1@huaweicloud.com>
> Date:
> 7/18/23, 14:32
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
> 
> 
> Hi,
> 
> 在 2023/07/18 19:25, Sergei Shtepa 写道:
>> Hi.
>>
>> On 7/18/23 03:37, Yu Kuai wrote:
>>> Subject:
>>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>>> From:
>>> Yu Kuai <yukuai1@huaweicloud.com>
>>> Date:
>>> 7/18/23, 03:37
>>>
>>> To:
>>> Sergei Shtepa <sergei.shtepa@veeam.com>, Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>> CC:
>>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>>
>>>
>>> Hi,
>>>
>>> 在 2023/07/17 22:39, Sergei Shtepa 写道:
>>>>
>>>>
>>>> On 7/11/23 04:02, Yu Kuai wrote:
>>>>> bdev_disk_changed() is not handled, where delete_partition() and
>>>>> add_partition() will be called, this means blkfilter for partiton will
>>>>> be removed after partition rescan. Am I missing something?
>>>>
>>>> Yes, when the bdev_disk_changed() is called, all disk block devices
>>>> are deleted and new ones are re-created. Therefore, the information
>>>> about the attached filters will be lost. This is equivalent to
>>>> removing the disk and adding it back.
>>>>
>>>> For the blksnap module, partition rescan will mean the loss of the
>>>> change trackers data. If a snapshot was created, then such
>>>> a partition rescan will cause the snapshot to be corrupted.
>>>>
>>>
>>> I haven't review blksnap code yet, but this sounds like a problem.
>>
>> I can't imagine a case where this could be a problem.
>> Partition rescan is possible only if the file system has not been
>> mounted on any of the disk partitions. Ioctl BLKRRPART will return
>> -EBUSY. Therefore, during normal operation of the system, rescan is
>> not performed.
>> And if the file systems have not been mounted, it is possible that
>> the disk partition structure has changed or the disk in the media
>> device has changed. In this case, it is better to detach the
>> filter, otherwise it may lead to incorrect operation of the module.
>>
>> We can add prechange/postchange callback functions so that the
>> filter can track rescan process. But at the moment, this is not
>> necessary for the blksnap module.
> 
> So you mean that blkfilter is only used for the case that partition
> is mounted? (Or you mean that partition is opened)
> 
> Then, I think you mean that filter should only be used for the partition
> that is opended? Otherwise, filter can be gone at any time since
> partition rescan can be gone.
> 
> //user
> 1. attach filter
>         // other context rescan partition
> 2. mount fs
> // user will found filter is gone.

Mmm...  The fact is that at the moment the user of the filter is the
blksnap module. There are no other filter users yet. The blksnap module
solves the problem of creating snapshots, primarily for backup purposes.
Therefore, the main use case is to attach a filter for an already running
system, where all partitions are marked up, file systems are mounted.

If the server is being serviced, during which the disk is being
re-partitioned, then disabling the filter is normal. In this case, the
change tracker will be reset, and at the next backup, the filter will be
attached again.

But if I were still solving the problem of saving the filter when rescanning,
then it is necessary to take into account the UUID and name of the partition
(struct partition_meta_info). It is unacceptable that due to a change in the
structure of partitions, the filter is attached to another partition by mistake.
The changed() callback would also be good to add so that the filter receives
a notification that the block device has been updated.

But I'm not sure that this should be done, since if some code is not used in
the kernel, then it should not be in the kernel.

> 
> Thanks,
> Kuai
> 
>>
>> Therefore, I will refrain from making changes for now.
>>
>>>
>>> possible solutions I have in mind:
>>>
>>> 1. Store blkfilter for each partition from bdev_disk_changed() before
>>> delete_partition(), and add blkfilter back after add_partition().
>>>
>>> 2. Store blkfilter from gendisk as a xarray, and protect it by
>>> 'open_mutex' like 'part_tbl', block_device can keep the pointer to
>>> reference blkfilter so that performance from fast path is ok, and the
>>> lifetime of blkfiter can be managed separately.
>>>
>>>> There was an idea to do filtering at the disk level,
>>>> but I abandoned it.
>>>> .
>>>>
>>> I think it's better to do filtering at the partition level as well.
>>>
>>> Thanks,
>>> Kuai
>>>
>> .
>>
> 
