Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2589B0225
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfIKQxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:53:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48026 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQxp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:53:45 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i85s8-00013U-0b; Wed, 11 Sep 2019 10:53:37 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-14-logang@deltatee.com>
 <92d61426-65a2-827c-936b-55f12f3d6afb@grimberg.me>
 <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
 <7954e8a4-6026-2210-7192-94a4e483facf@grimberg.me>
 <b23c72b2-c9db-cb8e-5519-63eb195b7fd4@deltatee.com>
 <ca811aea-c4ae-10ee-15a5-2332d5a9e29a@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <19da6ca1-3cde-3f29-59ee-923c562e6487@deltatee.com>
Date:   Wed, 11 Sep 2019 10:53:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca811aea-c4ae-10ee-15a5-2332d5a9e29a@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, kbusch@kernel.org, axboe@fb.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v8 13/13] nvmet-passthru: support block accounting
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-09-09 5:15 p.m., Sagi Grimberg wrote:
> 
>>>>>> Support block disk accounting by setting the RQF_IO_STAT flag
>>>>>> and gendisk in the request.
>>>>>>
>>>>>> After this change, IO counts will be reflected correctly in
>>>>>> /proc/diskstats for drives being used by passthru.
>>>>>>
>>>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>>> ---
>>>>>>     drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/nvme/target/io-cmd-passthru.c
>>>>>> b/drivers/nvme/target/io-cmd-passthru.c
>>>>>> index 7557927a3451..63f12750a80d 100644
>>>>>> --- a/drivers/nvme/target/io-cmd-passthru.c
>>>>>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>>>>>> @@ -410,6 +410,9 @@ static struct request
>>>>>> *nvmet_passthru_blk_make_request(struct nvmet_req *req,
>>>>>>         if (unlikely(IS_ERR(rq)))
>>>>>>             return rq;
>>>>>>     +    if (blk_queue_io_stat(q) && cmd->common.opcode !=
>>>>>> nvme_cmd_flush)
>>>>>> +        rq->rq_flags |= RQF_IO_STAT;
>>>>
>>>> Thanks for the review!
>>>>
>>>>> Does flush has data bytes in the request? Why the special casing?
>>>>
>>>> Well it was special cased in the vanilla blk account flow... But I
>>>> think
>>>> it's required to be special cased so the IO and in_flight counts don't
>>>> count flushes (as they do not for regular block device traffic).
>>>
>>> I think that the accounting exclude I/O that is yielded from the flush
>>> sequence. Don't think its relevant here...
>>
>> What? Per blk_account_io_done(), RQF_FLUSH_SEQ will not be set by us for
>> passthru commands and I don't think it's appropriate to do so. Thus, if
>> we set RQF_IO_STAT for passthru flush commands, they will be counted
>> which we do not want.
> 
> Have you considered to have nvmet_passthru_blk_make_request set RQF_FUA
> for nvme_cmd_flush? this way blk_insert_flush will be called and
> RQF_FLUSH_SEQ will be set and you don't need to worry about this
> special casing...

Well, I haven't done that mostly because I'm not sure of all the side
effects of doing so. However, I've tried it and everything seems to
still work, so I'll make that change for v9 which I'll probably send out
after the merge window.

Logan
