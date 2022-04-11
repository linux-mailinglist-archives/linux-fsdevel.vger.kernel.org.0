Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBE4FBC35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbiDKMib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbiDKMia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:38:30 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38511ADBD;
        Mon, 11 Apr 2022 05:36:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9pPvL2_1649680565;
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9pPvL2_1649680565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 20:36:07 +0800
Message-ID: <46dc4929-b52b-474c-1bdb-b3e439f09585@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 20:36:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 03/20] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220406075612.60298-4-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091118.1649680137@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1091118.1649680137@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/22 8:28 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	  This permits on-demand read mode of cachefiles. In this mode, when
>> +	  cache miss, the cachefiles backend instead of netfs, is responsible
>> +          for fetching data, e.g. through user daemon.
> 
> That third line should probably begin with a tab as the other two line do.

Oh yeah...

> 
>> +static inline void cachefiles_flush_reqs(struct cachefiles_cache *cache)
> 
> If it's in a .c file, there's no need to mark it "inline".  The compiler will
> inline it anyway if it decides it should.

Okay.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +	cachefiles_flush_reqs(cache);
>> +	xa_destroy(&cache->reqs);
>> +#endif
> 
> If cachefiles_flush_reqs() is only used in this one place, the xa_destroy()
> should possibly be moved into it.
> 

Alright.


-- 
Thanks,
Jeffle
