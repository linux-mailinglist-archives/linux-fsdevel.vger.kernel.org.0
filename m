Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC01150ADF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 04:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443480AbiDVCrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbiDVCrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:47:18 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DC4B42E;
        Thu, 21 Apr 2022 19:44:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAjn9jI_1650595459;
Received: from 30.225.24.197(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAjn9jI_1650595459)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 10:44:22 +0800
Message-ID: <cb91ef9f-62ab-6bca-2bde-ac1977ec6f37@linux.alibaba.com>
Date:   Fri, 22 Apr 2022 10:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 03/21] cachefiles: unbind cachefiles gracefully in
 on-demand mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com,
        zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-4-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1444916.1650549738@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1444916.1650549738@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/21/22 10:02 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	struct kref			unbind_pincount;/* refcount to do daemon unbind */
> 
> Please use refcount_t or atomic_t, especially as this isn't the refcount for
> the structure.

Okay, will be done in the next version.

> 
>> -	cachefiles_daemon_unbind(cache);
>> -
>>  	/* clean up the control file interface */
>>  	cache->cachefilesd = NULL;
>>  	file->private_data = NULL;
>>  	cachefiles_open = 0;
> 
> Please call cachefiles_daemon_unbind() before the cleanup.

Since the cachefiles_struct struct will be freed once the pincount is
decreased to 0, "cache->cachefilesd = NULL;" needs to be done before
decreasing the pincount. BTW, "cachefiles_open = 0;" indeed should be
done only when pincount has been decreased to 0.


-- 
Thanks,
Jeffle
