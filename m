Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30E6D93BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjDFKNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjDFKNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:13:12 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B51BD0;
        Thu,  6 Apr 2023 03:13:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VfSm3Uv_1680775985;
Received: from 30.97.49.15(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfSm3Uv_1680775985)
          by smtp.aliyun-inc.com;
          Thu, 06 Apr 2023 18:13:07 +0800
Message-ID: <cc219a52-e89c-b7e7-5bfd-0124f881a29f@linux.alibaba.com>
Date:   Thu, 6 Apr 2023 18:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rafael@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
 <2023040635-duty-overblown-7b4d@gregkh>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2023040635-duty-overblown-7b4d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On 2023/4/6 18:03, Greg KH wrote:
> On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
>> Use kobject_is_added() instead of directly accessing the internal
>> variables of kobject. BTW kill kobject_del() directly, because
>> kobject_put() actually covers kobject removal automatically.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/erofs/sysfs.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index 435e515c0792..daac23e32026 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (sbi->s_kobj.state_in_sysfs) {
>> -		kobject_del(&sbi->s_kobj);
>> +	if (kobject_is_added(&sbi->s_kobj)) {
> 
> I do not understand why this check is even needed, I do not think it
> should be there at all as obviously the kobject was registered if it now
> needs to not be registered.

I think Yangtao sent a new patchset which missed the whole previous
background discussions as below:
https://lore.kernel.org/r/028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com

It's needed because once a syzbot complaint as below:
https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com

I'd suggest including the previous backgrounds at least in the newer patchset,
otherwise it makes me explain again and again...

Thanks,
Gao Xiang

> 
> Meta-comment, we need to come up with a "filesystem kobject type" to get
> rid of lots of the boilerplate filesystem kobject logic as it's
> duplicated in every filesystem in tiny different ways and lots of times
> (like here), it's wrong.
> 
> kobjects were not designed to be "used raw" like this, ideally they
> would be wrapped in a subsystem that makes them easier to be used (like
> the driver model), but filesystems decided to use them and that usage
> just grew over the years.  That's evolution for you...> 
> thanks,
> 
> greg k-h
