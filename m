Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8866719025
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFABqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 21:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFABqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 21:46:02 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6BA3;
        Wed, 31 May 2023 18:46:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjzVehH_1685583955;
Received: from 30.221.145.175(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjzVehH_1685583955)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 09:45:57 +0800
Message-ID: <33fd8e03-7c99-c12d-255d-b7190612379b@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 09:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap
 in error path
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        gerry@linux.alibaba.com, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>
References: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
 <ZHeoIFrp303f0E8d@redhat.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZHeoIFrp303f0E8d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/1/23 4:03 AM, Vivek Goyal wrote:
> On Mon, Apr 24, 2023 at 08:32:50PM +0800, Jingbo Xu wrote:
>> When range already got reclaimed by somebody else, return NULL so that
>> the caller could retry to allocate or reclaim another range, instead of
>> mistakenly returning the range already got reclaimed and reused by
>> others.
>>
>> Reported-by: Liu Jiang <gerry@linux.alibaba.com>
>> Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Hi Jingbo,
> 
> This patch looks correct to me.
> 
> Are you able to reproduce the problem? Or you are fixing it based on
> code inspection?

It's spotted by Liu Jiang during code review.  Not tested yet.

> 
> How are you testing this? We don't have virtiofsd DAX implementation yet
> in rust virtiofsd yet. 
> 
> I am not sure how to test this chagne now. We had out of tree patches
> in qemu and now qemu has gotten rid of C version of virtiofsd so these
> patches might not even work now.

Yeah this exception path may not be so easy to be tested as it is only
triggered in the race condition.  I have the old branch (of qemu) with
support for DAX, and maybe I could try to reproduce the exception path
by configuring limited DAX window and heavy IO workload.


-- 
Thanks,
Jingbo
