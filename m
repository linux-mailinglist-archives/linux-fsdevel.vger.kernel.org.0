Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC244DD463
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 06:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiCRFat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 01:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiCRFas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:30:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064FD3AF0;
        Thu, 17 Mar 2022 22:29:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7UWZ7Y_1647581363;
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7UWZ7Y_1647581363)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 13:29:25 +0800
Message-ID: <a8be4038-720f-d604-03fc-f958e9083680@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 13:29:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH v5 17/22] erofs: implement fscache-based
 data read for non-inline layout
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-18-jefflexu@linux.alibaba.com>
 <YjLSyLGDtSrwJLHN@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjLSyLGDtSrwJLHN@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/17/22 2:18 PM, Gao Xiang wrote:
> On Wed, Mar 16, 2022 at 09:17:18PM +0800, Jeffle Xu wrote:
>> This patch implements the data plane of reading data from bootstrap blob
>> file over fscache for non-inline layout.
>>
>> Be noted that compressed layout is not supported yet.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c  | 94 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/inode.c    |  6 ++-
>>  fs/erofs/internal.h |  1 +
>>  3 files changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 654414aa87ad..df56562f33c4 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -4,6 +4,12 @@
>>   */
>>  #include "internal.h"
>>  
>> +struct erofs_fscache_map {
>> +	struct erofs_fscache_context *m_ctx;
>> +	erofs_off_t m_pa, m_la, o_la;
>> +	u64 m_llen;
> 
> Can we directly use "struct erofs_map_blocks map"?
> So "erofs_fscache_get_map" can be avoided then.

OK, the extra fields will be folded into "struct erofs_map_blocks map".

-- 
Thanks,
Jeffle
