Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258515B9311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 05:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIOD37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 23:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOD35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:29:57 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685B24BFA;
        Wed, 14 Sep 2022 20:29:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPqzoJh_1663212590;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPqzoJh_1663212590)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 11:29:52 +0800
Message-ID: <a986a33a-b03f-0a36-fad7-9c2afe3f2a48@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 11:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 4/6] erofs: introduce fscache-based domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com,
        huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-5-zhujia.zj@bytedance.com>
 <YyHVQGftl/0Bf4kW@B-P7TQMD6M-0146.lan>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YyHVQGftl/0Bf4kW@B-P7TQMD6M-0146.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/14/22 9:21 PM, Gao Xiang wrote:
>> @@ -518,7 +614,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>  
>>  	erofs_fscache_unregister_cookie(sbi->s_fscache);
>> -	fscache_relinquish_volume(sbi->volume, NULL, false);
>>  	sbi->s_fscache = NULL;
>> +
>> +	if (sbi->domain)
>> +		erofs_fscache_domain_put(sbi->domain);
>> +	else
>> +		fscache_relinquish_volume(sbi->volume, NULL, false);
>> +
> 
> How about using one helper and pass in sb directly instead?
> 

Then this helper has only one caller...


-- 
Thanks,
Jingbo
