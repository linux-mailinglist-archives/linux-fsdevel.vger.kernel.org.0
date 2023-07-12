Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066F750414
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGLKFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGLKFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:05:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201B10F2;
        Wed, 12 Jul 2023 03:05:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R1Cyy4Q57z4f4TVj;
        Wed, 12 Jul 2023 18:04:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA30JPJeq5ksQ4uNw--.62128S3;
        Wed, 12 Jul 2023 18:04:59 +0800 (CST)
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eca5a778-6795-fc03-7ae0-fe06f514af85@huaweicloud.com>
Date:   Wed, 12 Jul 2023 18:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JPJeq5ksQ4uNw--.62128S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyUZF1rZw4rJFWUtr18Krg_yoW8Gw4xpr
        n5Xay5JrWUXFn5Ww4DtryUJFyFvF1Dtw1DZryrXa43ArsrAr1jgw47Wr9Y93s3Ar48Gr4U
        Ar10qrsrZwsrGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/07/11 10:02, Yu Kuai 写道:

>> +static bool submit_bio_filter(struct bio *bio)
>> +{
>> +    if (bio_flagged(bio, BIO_FILTERED))
>> +        return false;
>> +
>> +    bio_set_flag(bio, BIO_FILTERED);
>> +    return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
>> +}
>> +
>>   static void __submit_bio(struct bio *bio)
>>   {
>> +    /*
>> +     * If there is a filter driver attached, check if the BIO needs 
>> to go to
>> +     * the filter driver first, which can then pass on the bio or 
>> consume it.
>> +     */
>> +    if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
>> +        return;
>> +
>>       if (unlikely(!blk_crypto_bio_prep(&bio)))
>>           return;

...

>> +static void __blkfilter_detach(struct block_device *bdev)
>> +{
>> +    struct blkfilter *flt = bdev->bd_filter;
>> +    const struct blkfilter_operations *ops = flt->ops;
>> +
>> +    bdev->bd_filter = NULL;
>> +    ops->detach(flt);
>> +    module_put(ops->owner);
>> +}
>> +
>> +void blkfilter_detach(struct block_device *bdev)
>> +{
>> +    if (bdev->bd_filter) {
>> +        blk_mq_freeze_queue(bdev->bd_queue);

And this is not sate as well, for bio-based device, q_usage_counter is
not grabbed while submit_bio_filter() is called, hence there is a risk
of uaf from submit_bio_filter().

Thanks,
Kuai

