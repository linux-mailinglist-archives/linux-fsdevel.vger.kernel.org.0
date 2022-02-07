Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE444AB557
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 07:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiBGG5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353653AbiBGGhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:37:52 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44AAC043181;
        Sun,  6 Feb 2022 22:37:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V3mOTeH_1644215867;
Received: from 30.225.28.93(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0V3mOTeH_1644215867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 14:37:47 +0800
Message-ID: <e4eb9000-e246-c01b-abde-de1535ff0374@linux.alibaba.com>
Date:   Mon, 7 Feb 2022 14:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] chardev: call tty_init() in real chrdev_init()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dhowells@redhat.com
References: <4e753e51d0516413fbf557cf861d654ca73486cc.1644164597.git.xuyu@linux.alibaba.com>
 <Yf//U1s3DbTuSqo2@kroah.com>
From:   Yu Xu <xuyu@linux.alibaba.com>
In-Reply-To: <Yf//U1s3DbTuSqo2@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/22 1:03 AM, Greg KH wrote:
> On Mon, Feb 07, 2022 at 12:27:31AM +0800, Xu Yu wrote:
>> It is confusing that tty_init() in called in the initialization of
>> memdev, i.e., static chr_dev_init().
>>
>> Through blame, it is introduced by commit 31d1d48e199e ("Fix init
>> ordering of /dev/console vs callers of modprobe"), which fixes the
>> initialization order of /dev/console driver. However, there seems
>> to be a typo in the patch, i.e., chrdev_init, instead of chr_dev_init.
>>
>> This fixes the typo, IIUC.
>>
>> Note that the return value of tty_init() is always 0, and thus no error
>> handling is provided in chrdev_init().
>>
>> Fixes: 31d1d48e199e ("Fix init ordering of /dev/console vs callers of modprobe")
>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
>> ---
>>   drivers/char/mem.c | 2 +-
>>   fs/char_dev.c      | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
>> index cc296f0823bd..8c90881f8115 100644
>> --- a/drivers/char/mem.c
>> +++ b/drivers/char/mem.c
>> @@ -775,7 +775,7 @@ static int __init chr_dev_init(void)
>>   			      NULL, devlist[minor].name);
>>   	}
>>   
>> -	return tty_init();
>> +	return 0;
>>   }
>>   
>>   fs_initcall(chr_dev_init);
>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>> index ba0ded7842a7..fc042a0a098f 100644
>> --- a/fs/char_dev.c
>> +++ b/fs/char_dev.c
>> @@ -667,6 +667,7 @@ static struct kobject *base_probe(dev_t dev, int *part, void *data)
>>   void __init chrdev_init(void)
>>   {
>>   	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
>> +	tty_init();
>>   }
>>   
> 
> You just changed the ordering sequence here, are you SURE this is
> correct?

To be honest, not 100% sure.

> 
> How was this tested?  Did you verify that the problem that the original
> commit here was fixing is now not happening again?

I tried to reproduce the issue described in the original commit, and
failed. The issue does not appear, or my reproduction is wrong.
   1. revert 31d1d48e199e manually;
   2. request_module("xxx") anywhere before do_initcalls(), since
      tty_init() now is initialized by module_init();
   3. no warning on request_module is shown.

> 
> And what real problem is this solving?  How did you hit the issue that
> this solves?

No real problem actually. As described in the log, it is confusing that
tty_init() in called in the initialization of memdev. They don't have
strong dependencies. I found the issue when I read through codes of
drivers/char/mem.c.

> 
> And finally, yes, it is not good to throw away the return value of
> tty_init().  If it really can not return anything but 0, then let us
> make it a void function first.

Got it. But I will first try to figure out whether this patch is a real
issue.

> 
> thanks,
> 
> greg k-h

-- 
Thanks,
Yu
