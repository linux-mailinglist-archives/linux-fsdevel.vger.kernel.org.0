Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C384E8C45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 04:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiC1CsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 22:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiC1CsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:48:02 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553F3D488;
        Sun, 27 Mar 2022 19:46:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8KPT83_1648435575;
Received: from 30.225.24.93(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8KPT83_1648435575)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 10:46:16 +0800
Message-ID: <9800e033-0456-b3cc-27e6-cf3d776f6feb@linux.alibaba.com>
Date:   Mon, 28 Mar 2022 10:46:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v6 10/22] erofs: add mode checking helper
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-11-jefflexu@linux.alibaba.com>
 <YkEgoqAKNTf45lJa@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YkEgoqAKNTf45lJa@B-P7TQMD6M-0146.local>
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



On 3/28/22 10:42 AM, Gao Xiang wrote:
> On Fri, Mar 25, 2022 at 08:22:11PM +0800, Jeffle Xu wrote:
>> Until then erofs is exactly blockdev based filesystem. In other using
>> scenarios (e.g. container image), erofs needs to run upon files.
>>
>> This patch set is going to introduces a new nodev mode, in which erofs
>> could be mounted from a bootstrap blob file containing complete erofs
>> image.
>>
>> Add a helper checking which mode erofs works in.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/internal.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index e424293f47a2..1486e2573667 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -161,6 +161,11 @@ struct erofs_sb_info {
>>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
>>  #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
>>  
>> +static inline bool erofs_is_nodev_mode(struct super_block *sb)
> 
> I've seen a lot of such
> 
> +		if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> +		    erofs_is_nodev_mode(sb)) {
> 
> usages in the followup patches, which makes me wonder if the configuration
> can be checked in the helper as well. Also maybe rename it as
> erofs_is_fscache_mode()?
> 

Sure. Will be done in the next version.

-- 
Thanks,
Jeffle
