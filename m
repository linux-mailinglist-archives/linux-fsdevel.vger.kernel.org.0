Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57CF756907
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGQQXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjGQQXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:23:07 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADBE130;
        Mon, 17 Jul 2023 09:23:04 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 5AB254248A;
        Mon, 17 Jul 2023 12:23:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1689610980;
        bh=Yvy6JirBoMjCFBuNJLeE1/fak8zms1mE164qX049iOs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=TxOAaz9utzv3vgLwP/d5AdxUc+oj3HgXCI1WvZ4f6kDSrmSSsRYOAJTkP+7pwJ1sC
         6F77S0wSUR2lJL7Jxgp/kZtOAlEMmxKnxck584Z1rU0/IijB9yUKAyr8ho+lQj9z9h
         0iKPkvu6rABYMy1wNhO/J7xcLTpjMntbRfq/rIt3IlbUWzJ7Ri6z7VstWRrr9E41Mf
         dCjgtAdvUHMGhS7mi9LXhajB/lS6vrbnCrPArFt+Zgxw1ZbmOWkeffDsIy5WWZBgso
         G9MT7cO9SQCJ6OYaxStB5PLB+fLcnqgKRIKvaO4FagdjfPFBWU1TwTfeRh6+g7JxyY
         rqcteokc0hxmA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 17 Jul
 2023 18:22:53 +0200
Message-ID: <3a86aa81-83ff-6245-bc10-304bde8c200d@veeam.com>
Date:   Mon, 17 Jul 2023 18:22:46 +0200
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
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <eca5a778-6795-fc03-7ae0-fe06f514af85@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677461
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/12/23 12:04, Yu Kuai wrote:
> Subject:
> Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
> From:
> Yu Kuai <yukuai1@huaweicloud.com>
> Date:
> 7/12/23, 12:04
> 
> To:
> Yu Kuai <yukuai1@huaweicloud.com>, Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>, "yukuai (C)" <yukuai3@huawei.com>
> 
> 
> Hi,
> 
> 在 2023/07/11 10:02, Yu Kuai 写道:
> 
>>> +static bool submit_bio_filter(struct bio *bio)
>>> +{
>>> +    if (bio_flagged(bio, BIO_FILTERED))
>>> +        return false;
>>> +
>>> +    bio_set_flag(bio, BIO_FILTERED);
>>> +    return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
>>> +}
>>> +
>>>   static void __submit_bio(struct bio *bio)
>>>   {
>>> +    /*
>>> +     * If there is a filter driver attached, check if the BIO needs to go to
>>> +     * the filter driver first, which can then pass on the bio or consume it.
>>> +     */
>>> +    if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
>>> +        return;
>>> +
>>>       if (unlikely(!blk_crypto_bio_prep(&bio)))
>>>           return;
> 
> ...
> 
>>> +static void __blkfilter_detach(struct block_device *bdev)
>>> +{
>>> +    struct blkfilter *flt = bdev->bd_filter;
>>> +    const struct blkfilter_operations *ops = flt->ops;
>>> +
>>> +    bdev->bd_filter = NULL;
>>> +    ops->detach(flt);
>>> +    module_put(ops->owner);
>>> +}
>>> +
>>> +void blkfilter_detach(struct block_device *bdev)
>>> +{
>>> +    if (bdev->bd_filter) {
>>> +        blk_mq_freeze_queue(bdev->bd_queue);
> 
> And this is not sate as well, for bio-based device, q_usage_counter is
> not grabbed while submit_bio_filter() is called, hence there is a risk
> of uaf from submit_bio_filter().
> 
> Thanks,
> Kuai
> 

Hi Kuai.

Indeed, the filter call is performed before calling bio_queue_enter().
I must admit, you are very attentive. 

I didn't keep track of the change in the position of the
bio_queue_enter() function deeper on the stack.

I think I need to add a check for q_usage_counter, for the debug build.
So that I don't miss it in the future. 

