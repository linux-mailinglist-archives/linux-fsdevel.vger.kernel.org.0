Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2D756AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGQRkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 13:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQRkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:40:15 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE50E3;
        Mon, 17 Jul 2023 10:40:14 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 6DBDE5EC32;
        Mon, 17 Jul 2023 20:40:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1689615611;
        bh=EcUONx2QoC1Q38uHYLn+ll6oxMznhmLp6cVLoRPn580=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=ScP3tPuhjukSfnf4MGNVkVElBvt3QBFrjW7LMWC2K89vGmF83REc1fKPDggZtA4IG
         XfxZ6hKYPZiA6rs1FUfdp0F/tBniPNT3qWGJKjJNRwVYXuSP2LirBmMzT54bZG1rFl
         cXBVdYlDtvALZWH+HJ8oHFLj3t3YWjxeYj/eSMPOT0e1DZoUYc2Wi2SRQ64izSjVFt
         ejpDgSFr/fD9Pzk6IJpJOisOh7UgXAwznD+f99OO0or/v7IAvaP1RWGZO+Yyb8gn7s
         e/OuYqdNkHStKIrizOFyU87YoU6yC2xQ4QlFS2j5cpJDB79U4V4sNOqNhuPng8f/qM
         S6cqA94JoKibg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 17 Jul
 2023 19:40:05 +0200
Message-ID: <b19b4c51-c769-84f9-7eae-b555ae51d692@veeam.com>
Date:   Mon, 17 Jul 2023 19:39:55 +0200
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
 <eca5a778-6795-fc03-7ae0-fe06f514af85@huaweicloud.com>
 <2ab36e73-a612-76a8-9c20-f5e11c67bcc3@huaweicloud.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <2ab36e73-a612-76a8-9c20-f5e11c67bcc3@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677467
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

On 7/12/23 14:34, Yu Kuai wrote:
> Subject:
> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
> From:
> Yu Kuai <yukuai1@huaweicloud.com>
> Date:
> 7/12/23, 14:34
> 
> To:
> Yu Kuai <yukuai1@huaweicloud.com>, Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
> 
> 
> Hi,
> 
> 在 2023/07/12 18:04, Yu Kuai 写道:
>> Hi,
>>
>> 在 2023/07/11 10:02, Yu Kuai 写道:
>>
>>>> +static bool submit_bio_filter(struct bio *bio)
>>>> +{
>>>> +    if (bio_flagged(bio, BIO_FILTERED))
>>>> +        return false;
>>>> +
>>>> +    bio_set_flag(bio, BIO_FILTERED);
>>>> +    return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
>>>> +}
>>>> +
>>>>   static void __submit_bio(struct bio *bio)
>>>>   {
>>>> +    /*
>>>> +     * If there is a filter driver attached, check if the BIO needs to go to
>>>> +     * the filter driver first, which can then pass on the bio or consume it.
>>>> +     */
>>>> +    if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
>>>> +        return;
>>>> +
>>>>       if (unlikely(!blk_crypto_bio_prep(&bio)))
>>>>           return;
>>
>> ...
>>
>>>> +static void __blkfilter_detach(struct block_device *bdev)
>>>> +{
>>>> +    struct blkfilter *flt = bdev->bd_filter;
>>>> +    const struct blkfilter_operations *ops = flt->ops;
>>>> +
>>>> +    bdev->bd_filter = NULL;
>>>> +    ops->detach(flt);
>>>> +    module_put(ops->owner);
>>>> +}
>>>> +
>>>> +void blkfilter_detach(struct block_device *bdev)
>>>> +{
>>>> +    if (bdev->bd_filter) {
>>>> +        blk_mq_freeze_queue(bdev->bd_queue);
>>
>> And this is not sate as well, for bio-based device, q_usage_counter is
>> not grabbed while submit_bio_filter() is called, hence there is a risk
>> of uaf from submit_bio_filter().
> 
> And there is another question, can blkfilter_detach() from
> del_gendisk/delete_partiton and ioctl concurrent? I think it's a
> problem.
> 

Yes, it looks like if two threads execute the blkfilter_detach() function,
then a problem is possible. The blk_mq_freeze_queue() function does not
block threads.
But for this, it is necessary that the IOCTL for the block device and
its removal are performed simultaneously. Is this possible?

I suppose that using mutex bdev->bd_disk->open_mutex in
blkfilter_ioctl_attach(), blkfilter_ioctl_detach() and
blkfilter_ioctl_ctl() can fix the problem. What do you think?


> Thanks,
> Kuai
>>
>> Thanks,
>> Kuai
>>
>> .
>>
> 
