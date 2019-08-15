Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 146E78EFE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHOP77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 11:59:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59178 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbfHOP77 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:59:59 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hyIAB-0000kk-MY; Thu, 15 Aug 2019 09:59:44 -0600
To:     Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-2-logang@deltatee.com>
 <563baec2-61f6-5705-d751-1eee75370e66@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3dc99450-bd6d-b994-4b4c-1af225565c2f@deltatee.com>
Date:   Thu, 15 Aug 2019 09:59:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <563baec2-61f6-5705-d751-1eee75370e66@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v7 01/14] nvme-core: introduce nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-08-15 5:46 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>> It makes use of filp_open() to open the file and uses the private
>> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
>> file do not match, -EINVAL is returned.
>>
>> The purpose of this function is to support NVMe-OF target passthru.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h |  2 ++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e6ee6f2a3da6..f72334f34a30 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2817,6 +2817,30 @@ static const struct file_operations
>> nvme_dev_fops = {
>>       .compat_ioctl    = nvme_dev_ioctl,
>>   };
>>   +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
>> +{
>> +    struct nvme_ctrl *ctrl;
>> +    struct file *f;
>> +
>> +    f = filp_open(path, O_RDWR, 0);
>> +    if (IS_ERR(f))
>> +        return ERR_CAST(f);
>> +
>> +    if (f->f_op != &nvme_dev_fops) {
>> +        ctrl = ERR_PTR(-EINVAL);
>> +        goto out_close;
>> +    }
> 
> Logan,
> 
> this means that the PT is for nvme-pci and also nvme-fabrics as well.
> 
> Is this the intention ? or we want to restrict it to pci only.

Yes, in theory, someone could passthru an nvme-fabrics controller or
they could passthru a passthru'd passthru'd nvme-fabrics controller.
This probably isn't a good idea but I don't know that we need to
specifically reject it. If you think we should I could figure out a way
to filter by pci controllers only.

Logan
