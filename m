Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FA8F007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfHOQDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:03:04 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59254 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOQDC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:03:02 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hyIDB-00010b-ON; Thu, 15 Aug 2019 10:02:50 -0600
To:     Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-8-logang@deltatee.com>
 <e0323600-c4e8-00e7-d8cc-ff8d31b4ed10@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <90e7402f-bd2b-1e3b-1f15-53eff50a1abd@deltatee.com>
Date:   Thu, 15 Aug 2019 10:02:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e0323600-c4e8-00e7-d8cc-ff8d31b4ed10@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v7 07/14] nvmet-passthru: add enable/disable helpers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-08-15 6:20 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> This patch adds helper functions which are used in the NVMeOF configfs
>> when the user is configuring the passthru subsystem. Here we ensure
>> that only one subsys is assigned to each nvme_ctrl by using an xarray
>> on the cntlid.
>>
>> [chaitanya.kulkarni@wdc.com: this patch is very roughly based
>>   on a similar one by Chaitanya]
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/target/core.c            |  8 +++
>>   drivers/nvme/target/io-cmd-passthru.c | 77 +++++++++++++++++++++++++++
>>   drivers/nvme/target/nvmet.h           | 10 ++++
>>   3 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 50c01b2da568..2e75968af7f4 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -519,6 +519,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>         mutex_lock(&subsys->lock);
>>       ret = 0;
>> +
>> +    if (nvmet_passthru_ctrl(subsys)) {
>> +        pr_info("cannot enable both passthru and regular namespaces
>> for a single subsystem");
>> +        goto out_unlock;
>> +    }
>> +
>>       if (ns->enabled)
>>           goto out_unlock;
>>   @@ -1439,6 +1445,8 @@ static void nvmet_subsys_free(struct kref *ref)
>>         WARN_ON_ONCE(!list_empty(&subsys->namespaces));
>>   +    nvmet_passthru_subsys_free(subsys);
>> +
>>       kfree(subsys->subsysnqn);
>>       kfree(subsys);
>>   }
>> diff --git a/drivers/nvme/target/io-cmd-passthru.c
>> b/drivers/nvme/target/io-cmd-passthru.c
>> index 46c58fec5608..b199785500ad 100644
>> --- a/drivers/nvme/target/io-cmd-passthru.c
>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>> @@ -11,6 +11,11 @@
>>   #include "../host/nvme.h"
>>   #include "nvmet.h"
>>   +/*
>> + * xarray to maintain one passthru subsystem per nvme controller.
>> + */
>> +static DEFINE_XARRAY(passthru_subsystems);
>> +
>>   static struct workqueue_struct *passthru_wq;
>>     int nvmet_passthru_init(void)
>> @@ -27,6 +32,78 @@ void nvmet_passthru_destroy(void)
>>       destroy_workqueue(passthru_wq);
>>   }
>>   +int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>> +{
>> +    struct nvme_ctrl *ctrl;
>> +    int ret = -EINVAL;
>> +    void *old;
>> +
>> +    mutex_lock(&subsys->lock);
>> +    if (!subsys->passthru_ctrl_path)
>> +        goto out_unlock;
>> +    if (subsys->passthru_ctrl)
>> +        goto out_unlock;
>> +
>> +    if (subsys->nr_namespaces) {
>> +        pr_info("cannot enable both passthru and regular namespaces
>> for a single subsystem");
>> +        goto out_unlock;
>> +    }
>> +
>> +    ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
>> +    if (IS_ERR(ctrl)) {
>> +        ret = PTR_ERR(ctrl);
>> +        pr_err("failed to open nvme controller %s\n",
>> +               subsys->passthru_ctrl_path);
>> +
>> +        goto out_unlock;
>> +    }
>> +
>> +    old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
>> +             subsys, GFP_KERNEL);
>> +    if (xa_is_err(old)) {
>> +        ret = xa_err(old);
>> +        goto out_put_ctrl;
>> +    }
>> +
>> +    if (old)
>> +        goto out_put_ctrl;
>> +
>> +    subsys->passthru_ctrl = ctrl;
>> +    ret = 0;
>> +
>> +    goto out_unlock;
> 
> can we re-arrange the code here ?
> 
> it's not so common to see goto in a good flow.
> 
> maybe have 1 good flow the goto's will go bellow it as we usually do in
> this subsystem.

OK, queued up for v8.

Thanks,

Logan
