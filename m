Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0E4FBC66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiDKMvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiDKMvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:51:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E129C87;
        Mon, 11 Apr 2022 05:48:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9qAczp_1649681329;
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9qAczp_1649681329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 20:48:50 +0800
Message-ID: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 20:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 04/20] cachefiles: notify user daemon when withdrawing
 cookie
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
References: <20220406075612.60298-5-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091405.1649680508@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1091405.1649680508@warthog.procyon.org.uk>
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



On 4/11/22 8:35 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +static int init_close_req(struct cachefiles_req *req, void *private)
> 
> "cachefiles_" prefix please.

Okay.

> 
>> +	/*
>> +	 * It's possible if the cookie looking up phase failed before READ
>> +	 * request has ever been sent.
>> +	 */
> 
> What "it" is possible?  You might want to say "It's possible that the
> cookie..."

"It's possible that the following if (fd == 0) condition is triggered
when cookie looking up phase failed before READ request has ever been sent."

Anyway I will fix this comment then.

> 
>> +	if (fd == 0)
>> +		return -ENOENT;
> 
> 0 is a valid fd.

Yeah, but IMHO fd 0 is always for stdin? I think the allocated anon_fd
won't install at fd 0. Please correct me if I'm wrong.

In fact I wanna use "fd == 0" as the initial state as struct
cachefiles_object is allocated with kmem_cache_zalloc().


-- 
Thanks,
Jeffle
