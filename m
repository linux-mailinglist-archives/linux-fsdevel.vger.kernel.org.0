Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201ED4F947B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiDHLxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiDHLxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:53:02 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA22F86D5
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 04:50:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9VwsCe_1649418655;
Received: from 30.225.24.70(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9VwsCe_1649418655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Apr 2022 19:50:56 +0800
Message-ID: <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
Date:   Fri, 8 Apr 2022 19:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlAbqF4Yts8Aju+W@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/8/22 7:25 PM, Vivek Goyal wrote:
> On Fri, Apr 08, 2022 at 10:36:40AM +0800, JeffleXu wrote:
>>
>>
>> On 4/7/22 10:10 PM, Vivek Goyal wrote:
>>> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>>>> Move dmap free worker kicker inside the critical region, so that extra
>>>> spinlock lock/unlock could be avoided.
>>>>
>>>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>
>>> Looks good to me. Have you done any testing to make sure nothing is
>>> broken.
>>
>> xfstests -g quick shows no regression. The tested virtiofs is mounted
>> with "dax=always".
> 
> I think xfstests might not trigger reclaim. You probably will have to
> run something like blogbench with a small dax window like 1G so that
> heavy reclaim happens.


Actually, I configured the DAX window to 8MB, i.e. 4 slots when running
xfstests. Thus I think the reclaim path is most likely triggered.


> 
> For fun, I sometimes used to run it with a window of just say 16 dax
> ranges so that reclaim was so heavy that if there was a bug, it will
> show up.
> 

Yeah, my colleague had ever reported that a DAX window of 4KB will cause
hang in our internal OS (which is 4.19, we back ported virtiofs to
4.19). But then I found that this issue doesn't exist in the latest
upstream. The reason seems that in the upstream kernel,
devm_memremap_pages() called in virtio_fs_setup_dax() will fail directly
since the dax window (4KB) is not aligned with the sparse memory section.

-- 
Thanks,
Jeffle
