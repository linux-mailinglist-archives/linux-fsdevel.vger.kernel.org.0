Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E260CD47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiJYNUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiJYNUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:20:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F65E09EF;
        Tue, 25 Oct 2022 06:20:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxXc10mGSzHty9;
        Tue, 25 Oct 2022 21:20:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:20:13 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:20:12 +0800
Subject: Re: [PATCH v2] chardev: fix error handling in cdev_device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <logang@deltatee.com>, <dan.j.williams@intel.com>,
        <hans.verkuil@cisco.com>, <alexandre.belloni@free-electrons.com>,
        <viro@zeniv.linux.org.uk>
References: <20221025113957.693723-1-yangyingliang@huawei.com>
 <Y1fNnwLlY079xGVY@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ae7cbce0-3506-e21b-fa9b-37a13fe00b77@huawei.com>
Date:   Tue, 25 Oct 2022 21:20:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1fNnwLlY079xGVY@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Greg

On 2022/10/25 19:50, Greg KH wrote:
> On Tue, Oct 25, 2022 at 07:39:57PM +0800, Yang Yingliang wrote:
>> While doing fault injection test, I got the following report:
>>
>> ------------[ cut here ]------------
>> kobject: '(null)' (0000000039956980): is not initialized, yet kobject_put() is being called.
>> WARNING: CPU: 3 PID: 6306 at kobject_put+0x23d/0x4e0
>> CPU: 3 PID: 6306 Comm: 283 Tainted: G        W          6.1.0-rc2-00005-g307c1086d7c9 #1253
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:kobject_put+0x23d/0x4e0
>> Call Trace:
>>   <TASK>
>>   cdev_device_add+0x15e/0x1b0
>>   __iio_device_register+0x13b4/0x1af0 [industrialio]
>>   __devm_iio_device_register+0x22/0x90 [industrialio]
>>   max517_probe+0x3d8/0x6b4 [max517]
>>   i2c_device_probe+0xa81/0xc00
>>
>> When device_add() is injected fault and returns error, if dev->devt is not set,
>> cdev_add() is not called, cdev_del() is not needed. Fix this by checking dev->devt
>> in error path.
> Nit, please wrap your changelog text at 72 columns.
>
>> Fixes: 233ed09d7fda ("chardev: add helper function to register char devs with a struct device")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v1 -> v2:
>>    Add information to update commit message.
>>    v1 link: https://lore.kernel.org/lkml/1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com/T/
>> ---
>>   fs/char_dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>> index ba0ded7842a7..3f667292608c 100644
>> --- a/fs/char_dev.c
>> +++ b/fs/char_dev.c
>> @@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>>   	}
>>   
>>   	rc = device_add(dev);
>> -	if (rc)
>> +	if (rc && dev->devt)
> No, this is a layering violation and one that you do not know is really
> going to be true or not.  the devt being present, or not, should not be
> an issue of if the device_add failed or not.  This isn't correct, sorry.
Do you mean it's not a bug or the warn can be ignored or it's bug in 
driver ?
I see devt is checked before calling cdev_del() in cdev_device_del().

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
