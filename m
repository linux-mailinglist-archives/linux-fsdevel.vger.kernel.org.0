Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A56DFF4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLT7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDLT7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:59:42 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0402D55;
        Wed, 12 Apr 2023 12:59:40 -0700 (PDT)
Received: from [192.168.1.190] (ip5b426bea.dynamic.kabel-deutschland.de [91.66.107.234])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CD70C60027FEB;
        Wed, 12 Apr 2023 21:59:38 +0200 (CEST)
Message-ID: <9d598566-5729-630e-5025-b4173cf307e4@molgen.mpg.de>
Date:   Wed, 12 Apr 2023 21:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
 <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
 <ZDT9PjLeQgjVA16P@infradead.org>
 <50d131e3-7528-2064-fbe6-65482db46ae4@veeam.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <50d131e3-7528-2064-fbe6-65482db46ae4@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/23 12:43, Sergei Shtepa wrote:
> 
> 
> On 4/11/23 08:25, Christoph Hellwig wrote:
>> Subject:
>> Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
>> From:
>> Christoph Hellwig <hch@infradead.org>
>> Date:
>> 4/11/23, 08:25
>>
>> To:
>> Donald Buczek <buczek@molgen.mpg.de>
>> CC:
>> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>
>>
>> On Sat, Apr 08, 2023 at 05:30:19PM +0200, Donald Buczek wrote:
>>> Maybe detach the old filter and attach the new one instead? An atomic replace might be usefull and it wouldn't complicate the code to do that instead. If its the same filter, maybe just return success and don't go through ops->detach and ops->attach?
>> I don't think a replace makes any sense.  We might want multiple
>> filters eventually, but unless we have a good use case for even just
>> more than a single driver we can deal with that once needed.  The
>> interface is prepared to support multiple attached filters already.
>>
> 
> 
> Thank you Donald for your comment. It got me thinking.
> 
> Despite the fact that only one filter is currently offered for the kernel,
> I think that out-of-tree filters of block devices may appear very soon.
> It would be good to think about it in advance.
> And, I agree with Christophe, we would not like to redo the blk-filter interface
> when new filters appear in the tree.
> 
> We can consider a block device as a resource that two actor want to take over.
> There are two possible behavioral strategies:
> 1. If one owner occupies a resource, then for other actors, the ownership
> request will end with a refusal. The owner will not lose his resource.
> 2. Any actor can take away a resource from the owner and inform him about its
> loss using a callback.
> 
> I think the first strategy is safer. When calling ioctl BLKFILTER_ATTACH, the
> kernel informs the actor that the resource is busy.
> Of course, there is still an option to grab someone else's occupied resource.
> To do this, he will have to call ioctl BLKFILTER_DETACH, specifying the name
> of the filter that needs to be detached. It is assumed that such detached
> should be performed by the same actor that attached it there.
> 
> If we replace the owner at each ioctl BLKFILTER_ATTACH, then we can get a
> situation of competition between two actors. At the same time, they won't
> even get a message that something is going wrong.
> 
> An example from life. The user compares different backup tools. Install one,
> then another. Each uses its own filter (And why not? this is technically
> possible).
> With the first strategy, the second tool will make it clear to the user that
> it cannot work, since the resource is already occupied by another.
> The user will have to experiment first with one tool, uninstall it, and then
> experiment with another.
> With the second strategy, both tools will unload each other's filters. In the
> best case, this will lead to disruption of their work. At a minimum, blksnap,
> when detached, will reset the change tracker and each backup will perform a
> full read of the block device. As a result, the user will receive distorted
> data, the system will not work as planned, although there will be no error
> message.

I had a more complicated scenario in mind. For example, some kind of live migration
from one block device to another, when you switch from the filter which clones from the
source device to the target device to the filter which just redirects from the source
device to the target device as the last step.

OTOH, that may be a very distant vision. Plus, one single and simple filter, which
redirects I/O into a DM stack, would be enough or better anyway to do the more
complicated things using the DM features, which include atomic replacement and
stacking and everything.

I don't have a strong opinion.

Best

   Donald
-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
