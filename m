Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A8757157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 03:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGRBVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 21:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:21:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F2A6;
        Mon, 17 Jul 2023 18:21:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R4h476Xklz4f3tpr;
        Tue, 18 Jul 2023 09:21:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAW6bVkzqLiOA--.59429S3;
        Tue, 18 Jul 2023 09:21:28 +0800 (CST)
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
 <eca5a778-6795-fc03-7ae0-fe06f514af85@huaweicloud.com>
 <2ab36e73-a612-76a8-9c20-f5e11c67bcc3@huaweicloud.com>
 <b19b4c51-c769-84f9-7eae-b555ae51d692@veeam.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4ab4ba31-6eb3-9d8c-9bd5-376e192f3ba2@huaweicloud.com>
Date:   Tue, 18 Jul 2023 09:21:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b19b4c51-c769-84f9-7eae-b555ae51d692@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAW6bVkzqLiOA--.59429S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18XryUJF4fZry3ZF45GFg_yoW5tFW7pF
        Z5XayjyrWDXF1kXw4qgw1UAF92qw1DGw1UZryftay5Jr4DtrnFgw47Wr909wn5Ar48WFyj
        vr1jqrWIv3s8JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2023/07/18 1:39, Sergei Shtepa 写道:
> Hi.
> 
> On 7/12/23 14:34, Yu Kuai wrote:
>> Subject:
>> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
>> From:
>> Yu Kuai <yukuai1@huaweicloud.com>
>> Date:
>> 7/12/23, 14:34
>>
>> To:
>> Yu Kuai <yukuai1@huaweicloud.com>, Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
>>
>>
>> Hi,
>>
>> 在 2023/07/12 18:04, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2023/07/11 10:02, Yu Kuai 写道:
>>>
>>>>> +static bool submit_bio_filter(struct bio *bio)
>>>>> +{
>>>>> +    if (bio_flagged(bio, BIO_FILTERED))
>>>>> +        return false;
>>>>> +
>>>>> +    bio_set_flag(bio, BIO_FILTERED);
>>>>> +    return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
>>>>> +}
>>>>> +
>>>>>    static void __submit_bio(struct bio *bio)
>>>>>    {
>>>>> +    /*
>>>>> +     * If there is a filter driver attached, check if the BIO needs to go to
>>>>> +     * the filter driver first, which can then pass on the bio or consume it.
>>>>> +     */
>>>>> +    if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
>>>>> +        return;
>>>>> +
>>>>>        if (unlikely(!blk_crypto_bio_prep(&bio)))
>>>>>            return;
>>>
>>> ...
>>>
>>>>> +static void __blkfilter_detach(struct block_device *bdev)
>>>>> +{
>>>>> +    struct blkfilter *flt = bdev->bd_filter;
>>>>> +    const struct blkfilter_operations *ops = flt->ops;
>>>>> +
>>>>> +    bdev->bd_filter = NULL;
>>>>> +    ops->detach(flt);
>>>>> +    module_put(ops->owner);
>>>>> +}
>>>>> +
>>>>> +void blkfilter_detach(struct block_device *bdev)
>>>>> +{
>>>>> +    if (bdev->bd_filter) {
>>>>> +        blk_mq_freeze_queue(bdev->bd_queue);
>>>
>>> And this is not sate as well, for bio-based device, q_usage_counter is
>>> not grabbed while submit_bio_filter() is called, hence there is a risk
>>> of uaf from submit_bio_filter().
>>
>> And there is another question, can blkfilter_detach() from
>> del_gendisk/delete_partiton and ioctl concurrent? I think it's a
>> problem.
>>
> 
> Yes, it looks like if two threads execute the blkfilter_detach() function,
> then a problem is possible. The blk_mq_freeze_queue() function does not
> block threads.
> But for this, it is necessary that the IOCTL for the block device and
> its removal are performed simultaneously. Is this possible?

I think it's possible, ioctl only requires to open the disk/partition,
and it won't block disk removal:

t1:			t2:

open dev
ioctl
			remove dev
			 del_gendisk
  blkfilter_detach	  blkfilter_detach

> 
> I suppose that using mutex bdev->bd_disk->open_mutex in
> blkfilter_ioctl_attach(), blkfilter_ioctl_detach() and
> blkfilter_ioctl_ctl() can fix the problem. What do you think?

I think it's ok, and blkfilter ioctl must check disk_live() while
holding the lock.

Thanks,
Kuai

> 
> 
>> Thanks,
>> Kuai
>>>
>>> Thanks,
>>> Kuai
>>>
>>> .
>>>
>>
> .
> 

