Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC748C097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbiALJCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 04:02:18 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40505 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238082AbiALJCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:02:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V1e06w2_1641978133;
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V1e06w2_1641978133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 17:02:14 +0800
Message-ID: <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
Date:   Wed, 12 Jan 2022 17:02:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
 <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
In-Reply-To: <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/28/21 8:33 PM, JeffleXu wrote:
> 
> 
> On 12/27/21 11:36 PM, Matthew Wilcox wrote:
>> On Mon, Dec 27, 2021 at 08:54:40PM +0800, Jeffle Xu wrote:
>>> +	spin_lock(&cache->reqs_lock);
>>> +	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);
>>
>> GFP_KERNEL while holding a spinlock?
> 
> Right. Thanks for pointing it out.
> 
>>
>> You should be using an XArray instead of an IDR in new code anyway.
>>
> 
> Regards.
> 

Hi Matthew,

I'm afraid IDR can't be replaced by xarray here. Because we need an 'ID'
for each pending read request, so that after fetching data from remote,
user daemon could notify kernel which read request has finished by this
'ID'.

Currently this 'ID' is get from idr_alloc(), and actually identifies the
position of corresponding read request inside the IDR tree. I can't find
similar API of xarray implementing similar function, i.e., returning an
'ID'.

As for the issue of GFP_KERNEL while holding a spinlock, I'm going to
fix this with idr_preload(), somehing like

+       idr_preload(GFP_KERNEL);
+       idr_lock(&cache->reqs);
+
+       ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_ATOMIC);
+       if (ret >= 0)
+               req->req_in.id = ret;
+
+       idr_unlock(&cache->reqs);
+       idr_preload_end();

Please correct me if I'm wrong.

-- 
Thanks,
Jeffle
