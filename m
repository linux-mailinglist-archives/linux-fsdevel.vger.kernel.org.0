Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A704B7C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 02:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiBPBcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 20:32:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiBPBcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:32:50 -0500
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD541A3B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 17:32:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4akZcN_1644975153;
Received: from 30.225.24.51(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4akZcN_1644975153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 09:32:34 +0800
Message-ID: <8343b195-b9d4-0501-d312-6ffdf382ff83@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 09:32:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] init: remove unused names parameter of split_fs_names()
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, hch@lst.de
References: <20220215070610.108967-1-jefflexu@linux.alibaba.com>
 <Ygv9qt4CEQ7P8/lD@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Ygv9qt4CEQ7P8/lD@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/16/22 3:23 AM, Vivek Goyal wrote:
> On Tue, Feb 15, 2022 at 03:06:10PM +0800, Jeffle Xu wrote:
>> It is a trivial cleanup.
>>
> 
> Would it be better to modify split_fs_names() instead and use
> parameter "names" insted of directly using "root_fs_names".

Yes it can do. But currently split_fs_names() is only called by
mount_block_root() and mount_nodev_root(), in which names argument is
always root_fs_names. And split_fs_names() is declared as a static
function in init/do_mounts.c.

> 
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  init/do_mounts.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/init/do_mounts.c b/init/do_mounts.c
>> index 762b534978d9..15502d4ef249 100644
>> --- a/init/do_mounts.c
>> +++ b/init/do_mounts.c
>> @@ -339,7 +339,7 @@ __setup("rootfstype=", fs_names_setup);
>>  __setup("rootdelay=", root_delay_setup);
>>  
>>  /* This can return zero length strings. Caller should check */
>> -static int __init split_fs_names(char *page, size_t size, char *names)
>> +static int __init split_fs_names(char *page, size_t size)
>>  {
>>  	int count = 1;
>>  	char *p = page;
>> @@ -403,7 +403,7 @@ void __init mount_block_root(char *name, int flags)
>>  	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
>>  		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
>>  	if (root_fs_names)
>> -		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
>> +		num_fs = split_fs_names(fs_names, PAGE_SIZE);
>>  	else
>>  		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
>>  retry:
>> @@ -546,7 +546,7 @@ static int __init mount_nodev_root(void)
>>  	fs_names = (void *)__get_free_page(GFP_KERNEL);
>>  	if (!fs_names)
>>  		return -EINVAL;
>> -	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
>> +	num_fs = split_fs_names(fs_names, PAGE_SIZE);
>>  
>>  	for (i = 0, fstype = fs_names; i < num_fs;
>>  	     i++, fstype += strlen(fstype) + 1) {
>> -- 
>> 2.27.0
>>

-- 
Thanks,
Jeffle
